--==================================================================--
--  YOMOGI — Steal an Egg  |  PET SPAWNER  v5.0
--------------------------------------------------------------------
--  Spawns any pet in the game straight into your inventory, with
--  the mutation and size you pick. Visual only — nothing is sent
--  to the server.
--
--  How it works:
--    • The hotbar/inventory is NOT built from Backpack tools — the
--      BackpackController rebuilds it from the replicated save:
--          profile.Inventory[uid] = AssetItems.Encode(itemData)
--      So we write there, then call the controller's own
--      syncAssetsFromSave closure (pulled out of the GC) to redraw.
--    • The held model comes from the game's own rig factory via
--      ItemDisplay.CreateTool.
--    • AssetRoster.WearAsset/DoffAsset are hooked so equipping our
--      pets never hits the server ("Failed to equip asset").
--
--  NOTE: the GUI must live in PlayerGui, not gethui()/CoreGui —
--  after a thread's first yield this executor demotes its identity
--  and writes to CoreGui descendants start throwing.
--
--  Yt: YOMOGI SCRIPT
--==================================================================--

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RS           = game:GetService("ReplicatedStorage")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local LocalPlayer  = Players.LocalPlayer

--------------------------------------------------------------------
-- Cleanup previous run
--------------------------------------------------------------------
for _, container in ipairs({(gethui and gethui()) or nil, game:GetService("CoreGui"), LocalPlayer:FindFirstChild("PlayerGui")}) do
	local old = container and container:FindFirstChild("YomogiPetSpawner")
	if old then pcall(function() old:Destroy() end) end
end
if _G.YomogiPetCleanup then pcall(_G.YomogiPetCleanup) end

local running = true

-- Click handlers fire on a restricted thread; run the real work on
-- a fresh one so Instance creation keeps our capabilities.
local function enqueue(fn)
	task.spawn(function()
		local ok, err = pcall(fn)
		if not ok then warn("[Yomogi] " .. tostring(err)) end
	end)
end

--------------------------------------------------------------------
-- Game modules
--------------------------------------------------------------------
local Assets, Save, AssetItems, ItemDisplay, AssetRoster
local EggRecords, AssetGender, AssetEarnings, PlotState, AssetComponent, AssetRigFactory
do
	local ok = true
	local function grab(path)
		local good, mod = pcall(require, path)
		if not good then ok = false end
		return mod
	end
	Assets      = grab(RS.Data.Assets)
	Save        = grab(RS.Shared.Save)
	AssetItems  = grab(RS.Shared.Util.AssetItems)
	ItemDisplay = grab(RS.Shared.Modules.ItemDisplay)
	AssetRoster = grab(RS.Client.AssetRoster)
	if not ok then
		warn("[Yomogi] Could not load game modules — are you in Steal an Egg?")
		return
	end

	-- Placing a real, wandering pet needs the plot's ActiveAssetsController
	-- pieces. These are optional: without them the Place button is hidden
	-- and Spawn still works.
	pcall(function()
		local ctrl     = LocalPlayer.PlayerScripts.Game.Plots.ActiveAssetsController
		AssetComponent  = require(ctrl.AssetComponent)
		EggRecords      = require(RS.Shared.Util.EggRecords)
		AssetGender     = require(RS.Shared.Util.AssetGender)
		AssetEarnings   = require(RS.Shared.Util.AssetEarnings)
		PlotState       = require(RS.Client.PlotState)
		AssetRigFactory = require(RS.Shared.Modules.AssetRigFactory)
	end)
end

--------------------------------------------------------------------
-- The live movement batch + billboard controller.
--   Creating our own would work, but nothing would ever step them —
--   the ActiveAssetsController owns the render loop. So we reach into
--   its upvalues and reuse the exact instances it is already driving,
--   which is what makes placed pets actually walk and animate.
--------------------------------------------------------------------
local LiveBatch, LiveBillboards
if AssetComponent then
	pcall(function()
		local ctrl = LocalPlayer.PlayerScripts.Game.Plots.ActiveAssetsController
		local MB = require(ctrl.AssetMovementBatch)
		local BB = require(ctrl.AssetBillboardController)
		if not getgc then return end

		for _, f in ipairs(getgc(false)) do
			if type(f) == "function" and not (iscclosure and iscclosure(f)) then
				local good, info = pcall(debug.getinfo, f)
				local src = good and info and tostring(info.source) or ""
				if src:find("ActiveAssetsController", 1, true)
				   and not src:find("%.Asset") and not src:find("PerformanceTest") then
					for i = 1, (info.nups or 0) do
						local okv, val = pcall(debug.getupvalue, f, i)
						if okv and type(val) == "table" then
							local okm, mt = pcall(getmetatable, val)
							if okm then
								if mt == MB and not LiveBatch      then LiveBatch = val      end
								if mt == BB and not LiveBillboards then LiveBillboards = val end
							end
						end
					end
				end
			end
			if LiveBatch and LiveBillboards then break end
		end
	end)
end

local CAN_PLACE = (AssetComponent ~= nil) and (LiveBatch ~= nil) and (LiveBillboards ~= nil)
if not CAN_PLACE then
	warn("[Yomogi] pet placement unavailable — Spawn still works")
end

--------------------------------------------------------------------
-- Equip hooks (once per version; originals cached so a re-run
-- can install new hooks without wrapping its own wrapper)
--------------------------------------------------------------------
local HOOK_VERSION = 6

local FAKE_PETS = _G.__YomogiFakePets or {}
_G.__YomogiFakePets = FAKE_PETS

if _G.__YomogiPetHookVersion ~= HOOK_VERSION then
	_G.__YomogiPetHookVersion = HOOK_VERSION

	_G.__YomogiPetOriginals = _G.__YomogiPetOriginals or {
		WearAsset = AssetRoster.WearAsset,
		DoffAsset = AssetRoster.DoffAsset,
	}
	local ORIG = _G.__YomogiPetOriginals

	AssetRoster.WearAsset = function(uid, ...)
		if FAKE_PETS[uid] then return true, nil, nil end
		return ORIG.WearAsset(uid, ...)
	end

	AssetRoster.DoffAsset = function(uid, ...)
		if uid == nil or FAKE_PETS[uid] then return true, nil end
		return ORIG.DoffAsset(uid, ...)
	end
end

--------------------------------------------------------------------
-- Inventory bridge
--------------------------------------------------------------------
local SyncAssets
do
	if getgc then
		for _, v in ipairs(getgc(false)) do
			if type(v) == "function" and not (iscclosure and iscclosure(v)) then
				local good, info = pcall(debug.getinfo, v)
				if good and info and info.name == "syncAssetsFromSave" then
					SyncAssets = v
					break
				end
			end
		end
	end
	if not SyncAssets then
		warn("[Yomogi] inventory sync hook not found — pets may not show in the hotbar")
	end
end

local function refreshInventory()
	if SyncAssets then pcall(SyncAssets) end
end

--------------------------------------------------------------------
-- Catalogue — every pet that has a model, best earners first
--------------------------------------------------------------------
local PET_MODELS = RS:FindFirstChild("AssetModels")

local CATALOG = (function()
	local list = {}
	for id, cfg in pairs(Assets.Directory) do
		if not PET_MODELS or PET_MODELS:FindFirstChild(id) then
			table.insert(list, {
				id        = id,
				display   = cfg.DisplayName or id,
				rate      = tonumber(cfg.EarningRate) or 0,
				rarity    = (type(cfg.Rarity) == "table" and cfg.Rarity.Name) or "?",
				icon      = cfg.Icon or "",
				baseScale = tonumber(cfg.BaseModelScale) or 1,
			})
		end
	end
	table.sort(list, function(a, b)
		if a.rate == b.rate then return a.display < b.display end
		return a.rate > b.rate
	end)
	return list
end)()

local MUTATIONS = { "None", "Golden", "Rainbow", "Silver", "Sakura", "GreatBloom" }
local SIZES = {
	{ label = "1x",  mult = 1  },
	{ label = "2x",  mult = 2  },
	{ label = "5x",  mult = 5  },
	{ label = "10x", mult = 10 },
	{ label = "25x", mult = 25 },
}

--------------------------------------------------------------------
-- State
--------------------------------------------------------------------
local spawnedTools    = {}
local injectedUids    = {}
local spawnCounter    = 0
local currentMutation = "None"
local currentSize     = 1
local autoEquip       = true
local heldTool        = nil
local placedComponents = {}   -- wandering pets placed in the base
local fakeIncome       = 0    -- $/s from everything placed

--------------------------------------------------------------------
-- Theme
--------------------------------------------------------------------
local C = {
	bg      = Color3.fromRGB(14, 14, 14),
	panel   = Color3.fromRGB(22, 22, 22),
	border  = Color3.fromRGB(180, 180, 180),
	text    = Color3.fromRGB(240, 240, 240),
	sub     = Color3.fromRGB(130, 130, 130),
	btn     = Color3.fromRGB(28, 28, 28),
	hover   = Color3.fromRGB(48, 48, 48),
	accent  = Color3.fromRGB(35, 70, 120),
	accentH = Color3.fromRGB(55, 100, 170),
	place   = Color3.fromRGB(30, 95, 45),
	placeH  = Color3.fromRGB(45, 140, 65),
	money   = Color3.fromRGB(90, 220, 90),
	warn    = Color3.fromRGB(220, 170, 60),
	bar     = Color3.fromRGB(70, 70, 70),
	pulseLo = Color3.fromRGB(55, 55, 55),
	pulseHi = Color3.fromRGB(220, 220, 220),
}

local RARITY_COLOR = {
	Common    = Color3.fromRGB(180, 180, 180),
	Uncommon  = Color3.fromRGB(90,  200, 90),
	Rare      = Color3.fromRGB(70,  130, 230),
	Epic      = Color3.fromRGB(170, 70,  220),
	Legendary = Color3.fromRGB(230, 170, 40),
	Mythic    = Color3.fromRGB(230, 70,  70),
	Cosmic    = Color3.fromRGB(100, 200, 255),
	Divine    = Color3.fromRGB(255, 255, 180),
	Eternal   = Color3.fromRGB(255, 220, 120),
	Secret    = Color3.fromRGB(255, 80,  150),
}

--------------------------------------------------------------------
-- UI helpers
--------------------------------------------------------------------
local function make(class, props, parent)
	local obj = Instance.new(class)
	for k, v in pairs(props) do pcall(function() obj[k] = v end) end
	if parent then obj.Parent = parent end
	return obj
end

local function corner(parent, r)
	return make("UICorner", { CornerRadius = UDim.new(0, r or 6) }, parent)
end

local function abbrev(n)
	if n >= 1e12 then return ("%.2fT"):format(n / 1e12) end
	if n >= 1e9  then return ("%.2fB"):format(n / 1e9)  end
	if n >= 1e6  then return ("%.2fM"):format(n / 1e6)  end
	if n >= 1e3  then return ("%.1fK"):format(n / 1e3)  end
	return tostring(math.floor(n))
end

--------------------------------------------------------------------
-- Window
--------------------------------------------------------------------
-- Mobile-friendly dimensions. The GUI stays readable while fitting small phones.
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
local W = math.min(330, math.max(270, math.floor(viewport.X * 0.88)))
local H = math.min(500, math.max(400, math.floor(viewport.Y * 0.72)))

local root = make("ScreenGui", {
	Name           = "YomogiPetSpawner",
	ResetOnSpawn   = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, LocalPlayer:WaitForChild("PlayerGui"))

-- Floating reopen button. It uses the uploaded character image only if
-- a valid Roblox image asset ID is supplied; otherwise the frog face is
-- used, so the GUI can never fail to load because of an invalid image ID.
local OPEN_IMAGE_ID = "" -- put your Roblox uploaded image ID here, e.g. "rbxassetid://123456789"
local openBtn = make("ImageButton", {
    Name = "OpenYomogi",
    Size = UDim2.new(0, 58, 0, 58),
    Position = UDim2.new(0.5, -29, 0, 105),
    BackgroundColor3 = Color3.fromRGB(35, 70, 120),
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Image = OPEN_IMAGE_ID,
    Visible = false,
    ZIndex = 50,
}, root)
corner(openBtn, 14)
make("UIStroke", {Color = Color3.fromRGB(220,220,220), Thickness = 1.5}, openBtn)

local openText = make("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "🐸",
    TextSize = 30,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1,1,1),
    Visible = (OPEN_IMAGE_ID == ""),
    ZIndex = 51,
}, openBtn)

local main = make("Frame", {
	Name             = "Main",
	Size             = UDim2.new(0, W, 0, H),
	Position         = UDim2.new(0.5, -W / 2, 0.5, -H / 2),
	BackgroundColor3 = C.bg,
	BorderSizePixel  = 0,
	ClipsDescendants = true,
}, root)
corner(main, 8)

local mainStroke = make("UIStroke", {
	Color           = C.border,
	Thickness       = 1.5,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, main)

local function updateMobileSize()
    local v = camera and camera.ViewportSize or Vector2.new(800, 600)
    local nw = math.min(330, math.max(270, math.floor(v.X * 0.88)))
    local nh = math.min(500, math.max(400, math.floor(v.Y * 0.72)))
    main.Size = UDim2.new(0, nw, 0, nh)
    main.Position = UDim2.new(0.5, -nw/2, 0.5, -nh/2)
end
if camera then
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateMobileSize)
end

-- ── Title bar ─────────────────────────────────────────────────────
local titleBar = make("Frame", {
	Size             = UDim2.new(1, 0, 0, 36),
	BackgroundColor3 = C.panel,
	BorderSizePixel  = 0,
}, main)
corner(titleBar, 8)

make("TextLabel", {
	Size                   = UDim2.new(1, -80, 1, 0),
	Position               = UDim2.new(0, 12, 0, 0),
	BackgroundTransparency = 1,
	Text                   = "🐾  Gena Pet Spawner",
	TextColor3             = C.text,
	Font                   = Enum.Font.GothamBold,
	TextSize               = 14,
	TextXAlignment         = Enum.TextXAlignment.Left,
}, titleBar)

local closeBtn = make("TextButton", {
	Size             = UDim2.new(0, 28, 0, 28),
	Position         = UDim2.new(1, -32, 0.5, -14),
	BackgroundColor3 = C.btn,
	Text             = "✕",
	TextColor3       = C.text,
	Font             = Enum.Font.GothamBold,
	TextSize         = 13,
	BorderSizePixel  = 0,
	AutoButtonColor  = false,
}, titleBar)
corner(closeBtn)

-- drag
do
	local dragging, dragStart, startPos
	titleBar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging, dragStart, startPos = true, i.Position, main.Position
		end
	end)
	titleBar.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
		             or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

-- ── Status ────────────────────────────────────────────────────────
local statusFrame = make("Frame", {
	Size             = UDim2.new(1, -16, 0, 24),
	Position         = UDim2.new(0, 8, 0, 42),
	BackgroundColor3 = C.panel,
	BorderSizePixel  = 0,
}, main)
corner(statusFrame)

local IDLE_TEXT = ("%d pets loaded — pick one"):format(#CATALOG)

local statusLbl = make("TextLabel", {
	Size                   = UDim2.new(1, -12, 1, 0),
	Position               = UDim2.new(0, 8, 0, 0),
	BackgroundTransparency = 1,
	Text                   = IDLE_TEXT,
	TextColor3             = C.sub,
	Font                   = Enum.Font.Gotham,
	TextSize               = 12,
	TextXAlignment         = Enum.TextXAlignment.Left,
	TextTruncate           = Enum.TextTruncate.AtEnd,
}, statusFrame)

local statusToken = 0
local function notify(msg, col)
	statusToken += 1
	local mine = statusToken
	statusLbl.Text       = msg
	statusLbl.TextColor3 = col or C.sub
	task.delay(3, function()
		if statusToken == mine then
			statusLbl.Text       = IDLE_TEXT
			statusLbl.TextColor3 = C.sub
		end
	end)
end

--------------------------------------------------------------------
-- Spawn / clear
--------------------------------------------------------------------
local function equipTool(tool)
	local char = LocalPlayer.Character
	local hum  = char and char:FindFirstChildOfClass("Humanoid")
	if not (hum and tool and tool.Parent) then return false end
	local ok = pcall(function() hum:EquipTool(tool) end)
	if ok then heldTool = tool end
	return ok
end

local function clearAll()
	heldTool = nil
	local char = LocalPlayer.Character
	local hum  = char and char:FindFirstChildOfClass("Humanoid")
	if hum then pcall(function() hum:UnequipTools() end) end

	local n = #spawnedTools
	for _, tool in ipairs(spawnedTools) do
		pcall(function() tool:Destroy() end)
	end
	spawnedTools = {}

	for uid in pairs(injectedUids) do
		FAKE_PETS[uid] = nil
		pcall(Save.ApplyLocalFieldEntry, "Inventory", uid, nil)
	end
	injectedUids = {}
	refreshInventory()

	-- placed pets: pull them out of the live batch before destroying
	for _, comp in ipairs(placedComponents) do
		pcall(function()
			local model = comp:GetModel()
			if LiveBillboards then LiveBillboards:Remove(model) end
			if LiveBatch      then LiveBatch:Remove(model)      end
		end)
		pcall(function() comp:Destroy() end)
		n += 1
	end
	placedComponents = {}
	fakeIncome = 0

	local holder = workspace:FindFirstChild("YomogiPets")
	if holder then pcall(function() holder:Destroy() end) end

	return n
end

--------------------------------------------------------------------
-- Place a real, wandering pet in your base
--------------------------------------------------------------------
local function petContainer()
	local f = workspace:FindFirstChild("YomogiPets")
	if not f then
		f = Instance.new("Folder")
		f.Name   = "YomogiPets"
		f.Parent = workspace
	end
	return f
end

local function findPetArea()
	local good, slot = pcall(PlotState.ResolveLocalSlot)
	if not good or slot == nil then return nil end
	local folder = PlotState.ResolveFolder()
	local plot   = folder and folder:FindFirstChild(tostring(slot))
	local upd    = plot and plot:FindFirstChild("ToUpdate")
	local area   = upd and upd:FindFirstChild("PetArea")
	return (area and area:IsA("BasePart")) and area or nil
end

-- Build the item the way the game does, then stamp on the
-- mutation and size the user picked.
local function buildItemData(entry)
	local rng = Random.new()
	local egg = EggRecords.NewEgg(entry.id, rng)
	egg.AssetGender = AssetGender.Settle(entry.id, nil, rng)

	local itemData = EggRecords.ToAssetItemData(egg)
	itemData.HasBeenFirstPlaced = true
	itemData.Scale = (itemData.Scale or entry.baseScale) * currentSize
	if currentMutation ~= "None" then
		itemData.Mutations    = { currentMutation }
		itemData.BaseMutation = currentMutation
	else
		itemData.Mutations    = {}
		itemData.BaseMutation = nil
	end
	return itemData, rng
end

-- Keep a placement inside the base so the pet never wanders off.
local function clampToArea(pos, area)
	local half   = area.Size * 0.5
	local local_ = area.CFrame:PointToObjectSpace(pos)
	local x = math.clamp(local_.X, -half.X + 2, half.X - 2)
	local z = math.clamp(local_.Z, -half.Z + 2, half.Z - 2)
	return (area.CFrame * CFrame.new(x, 0, z)).Position
end

-- Drop a live, wandering pet at an exact spot.
-- Pass existingItemData to place the exact pet you were holding.
local function placeAt(entry, cframe, existingItemData)
	local petArea = findPetArea()
	if not petArea then
		notify("Could not find your base's pet area", C.warn)
		return false
	end

	spawnCounter += 1
	local uid = ("yomogipet_%s_%d_%d"):format(
		entry.id:lower():gsub("[^%a%d]", "_"), spawnCounter, math.random(1000, 9999))

	local itemData, rng = buildItemData(entry)
	if existingItemData then itemData = existingItemData end
	local record = {
		OwnerUserId    = LocalPlayer.UserId,
		UID            = uid,
		ItemData       = itemData,
		MoneyPerSecond = AssetEarnings.LiveRatePerSecond(itemData),
		Seed           = rng:NextInteger(1, 2147483647),
	}

	-- 7th arg is the initial CFrame; without it the game picks a random
	-- spot in the area instead of where you clicked.
	local ok, comp = pcall(AssetComponent.new,
		record, LocalPlayer, petArea, petContainer(),
		LiveBillboards, LiveBatch, cframe)

	if not ok or not comp then
		notify("Could not place " .. entry.display, C.warn)
		return false
	end

	local model = comp:GetModel()
	pcall(function()
		LiveBillboards:Add(model, record.ItemData, record.MoneyPerSecond)
	end)

	-- The name/$ billboard is adorned to the model's CENTER part, which
	-- sits mid-body — so it renders buried inside the mesh. Lift it above
	-- the pet and draw it on top, the way a real placed pet reads.
	task.spawn(function()
		task.wait(0.1)
		pcall(function()
			local _, size = model:GetBoundingBox()
			local center  = model:FindFirstChild("CENTER", true)
			local lift    = (size.Y * 0.5) + 2.5
			if center then
				lift = (model:GetBoundingBox().Position.Y + size.Y * 0.5) - center.Position.Y + 2.5
			end
			for _, d in ipairs(model:GetDescendants()) do
				if d:IsA("BillboardGui") then
					d.StudsOffsetWorldSpace = Vector3.new(0, lift, 0)
					d.AlwaysOnTop = true
					d.Enabled = true
				end
			end
		end)
	end)

	table.insert(placedComponents, comp)

	-- this pet now pays out every second
	fakeIncome += (tonumber(record.MoneyPerSecond) or 0)

	local name = (itemData.BaseMutation and (itemData.BaseMutation .. " ") or "") .. entry.display
	notify(("Placed %s  (+$%s/s)"):format(name, abbrev(record.MoneyPerSecond)), C.money)
	return true
end

--------------------------------------------------------------------
-- Payout ticker
--   The server keeps replicating the real profile down on top of us,
--   which is why a one-shot write snaps back a second later. So we
--   track the server's own value separately (ignoring the echo of our
--   own writes) and keep re-applying serverValue + ourBonus.
--------------------------------------------------------------------
local earned      = 0     -- total fake cash accrued
local serverMoney = 0     -- last genuine value the server sent
local lastMoney   = nil   -- last value we wrote, to spot our own echo
local serverMps   = 0
local lastMps     = nil

pcall(function()
	local profile = Save.Get()
	if profile and typeof(profile.Money) == "number" then
		serverMoney = profile.Money
	end
end)

pcall(function()
	Save.WatchFields("Money", function()
		local profile = Save.Get()
		local v = profile and profile.Money
		if typeof(v) ~= "number" then return end
		-- our own write coming back? ignore it
		if lastMoney and math.abs(v - lastMoney) < 0.01 then return end
		serverMoney = v
	end)
end)

pcall(function()
	local ls  = LocalPlayer:WaitForChild("leaderstats", 5)
	local mps = ls and ls:FindFirstChild("Money/s")
	if not mps then return end
	serverMps = mps.Value
	mps.Changed:Connect(function(v)
		if lastMps and math.abs(v - lastMps) < 0.01 then return end
		serverMps = v
	end)
end)

task.spawn(function()
	local acc = 0
	while running do
		local dt = task.wait(0.25)
		if fakeIncome > 0 then
			acc += fakeIncome * (dt or 0.25)
			if acc >= 1 then
				earned += acc
				acc = 0
			end

			pcall(function()
				local ls  = LocalPlayer:FindFirstChild("leaderstats")
				local mps = ls and ls:FindFirstChild("Money/s")
				if mps then
					lastMps = serverMps + fakeIncome
					mps.Value = lastMps
				end

				lastMoney = serverMoney + earned
				Save.ApplyLocalField("Money", lastMoney)
			end)
		end
	end
end)

--------------------------------------------------------------------
-- Placing what you're holding
--   Spawn puts the pet in your hands. Click while holding it and it
--   drops right where you're aiming, then starts wandering.
--------------------------------------------------------------------
-- Where the cursor is pointing, kept inside the base.
local function mouseGroundCFrame(area)
	local cam = workspace.CurrentCamera
	if not cam then return nil end
	local mp  = UIS:GetMouseLocation()
	local ray = cam:ViewportPointToRay(mp.X, mp.Y)

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character, petContainer() }

	local hit = workspace:Raycast(ray.Origin, ray.Direction * 3000, params)
	if not hit then return nil end

	local pos = clampToArea(hit.Position, area)
	return CFrame.new(Vector3.new(pos.X, hit.Position.Y, pos.Z))
end

-- Consume the held tool and turn it into a living pet.
local function placeHeldPet(entry, tool, uid, itemData)
	if not CAN_PLACE then
		notify("Placement unavailable in this server", C.warn)
		return
	end
	local area = findPetArea()
	if not area then
		notify("Could not find your base's pet area", C.warn)
		return
	end

	local cf = mouseGroundCFrame(area)
	if not cf then
		notify("Aim at the ground to place it", C.warn)
		return
	end

	if placeAt(entry, cf, itemData) then
		-- the pet is out in the world now, so take the tool away
		heldTool = nil
		FAKE_PETS[uid]    = nil
		injectedUids[uid] = nil
		pcall(Save.ApplyLocalFieldEntry, "Inventory", uid, nil)
		for i, t in ipairs(spawnedTools) do
			if t == tool then table.remove(spawnedTools, i) break end
		end
		pcall(function() tool:Destroy() end)
		refreshInventory()
	end
end

local function doSpawn(entry)
	spawnCounter += 1
	local uid = ("yomogipet_%s_%d_%d"):format(
		entry.id:lower():gsub("[^%a%d]", "_"), spawnCounter, math.random(1000, 9999))

	local mutations, baseMutation = {}, nil
	if currentMutation ~= "None" then
		mutations, baseMutation = { currentMutation }, currentMutation
	end

	local itemData = {
		HasBeenFirstPlaced = false,
		Category     = entry.id,
		Scale        = entry.baseScale * currentSize,
		EyeColor     = "ffffff",
		ColorSeed    = math.random(0, 2147483647),
		ColorIndex   = 1,
		Mutations    = mutations,
		BaseMutation = baseMutation,
	}

	-- 1. the inventory row the hotbar actually reads
	local good, encoded = pcall(AssetItems.Encode, itemData)
	if not good then
		notify("Could not encode " .. entry.display, C.warn)
		return
	end
	pcall(Save.ApplyLocalFieldEntry, "Inventory", uid, encoded)
	injectedUids[uid] = true
	FAKE_PETS[uid]    = true

	-- 2. the holdable tool, built by the game's own rig factory
	local ok, tool = pcall(ItemDisplay.CreateTool, itemData, uid, LocalPlayer)
	refreshInventory()

	if ok and typeof(tool) == "Instance" then
		table.insert(spawnedTools, tool)
		local name = (baseMutation and (baseMutation .. " ") or "") .. entry.display

		-- Click while holding it to drop it in your base.
		if CAN_PLACE then
			tool.Activated:Connect(function()
				enqueue(function() placeHeldPet(entry, tool, uid, itemData) end)
			end)
		end

		if autoEquip then
			task.wait(0.15)
			if equipTool(tool) then
				notify(("Holding %s  (%dx) — click to place it"):format(name, currentSize), C.money)
				return
			end
		end
		notify(("Added %s  (%dx) to inventory"):format(name, currentSize), C.money)
	else
		notify("Spawn failed for " .. entry.display, C.warn)
	end
end

closeBtn.MouseEnter:Connect(function()
	enqueue(function() closeBtn.BackgroundColor3 = Color3.fromRGB(120, 35, 35) end)
end)
closeBtn.MouseLeave:Connect(function()
	enqueue(function() closeBtn.BackgroundColor3 = C.btn end)
end)
closeBtn.MouseButton1Click:Connect(function()
	enqueue(function()
		main.Visible = false
		openBtn.Visible = true
	end)
end)

openBtn.MouseButton1Click:Connect(function()
    enqueue(function()
        main.Visible = true
        openBtn.Visible = false
    end)
end)

-- Drag the reopen button on touch/mouse so it can be moved away from game buttons.
do
    local dragging, dragStart, startPos
    openBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos = true, i.Position, openBtn.Position
        end
    end)
    openBtn.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - dragStart
            openBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end

-- ── Search + Clear ────────────────────────────────────────────────
local searchRow = make("Frame", {
	Size                   = UDim2.new(1, -16, 0, 28),
	Position               = UDim2.new(0, 8, 0, 72),
	BackgroundTransparency = 1,
}, main)

local searchBox = make("TextBox", {
	Size              = UDim2.new(1, -72, 1, 0),
	BackgroundColor3  = C.panel,
	TextColor3        = C.text,
	PlaceholderText   = "Search pets…",
	PlaceholderColor3 = C.sub,
	Text              = "",
	Font              = Enum.Font.Gotham,
	TextSize          = 12,
	ClearTextOnFocus  = false,
	BorderSizePixel   = 0,
}, searchRow)
corner(searchBox)
make("UIPadding", { PaddingLeft = UDim.new(0, 8) }, searchBox)

local clearBtn = make("TextButton", {
	Size             = UDim2.new(0, 66, 1, 0),
	Position         = UDim2.new(1, -66, 0, 0),
	BackgroundColor3 = Color3.fromRGB(90, 30, 30),
	Text             = "Clear All",
	TextColor3       = C.text,
	Font             = Enum.Font.GothamBold,
	TextSize         = 11,
	BorderSizePixel  = 0,
	AutoButtonColor  = false,
}, searchRow)
corner(clearBtn)
clearBtn.MouseEnter:Connect(function()
	enqueue(function() clearBtn.BackgroundColor3 = Color3.fromRGB(130, 45, 45) end)
end)
clearBtn.MouseLeave:Connect(function()
	enqueue(function() clearBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 30) end)
end)
clearBtn.MouseButton1Click:Connect(function()
	enqueue(function()
		local n = clearAll()
		notify(n > 0 and ("Removed " .. n .. " pet(s)") or "Nothing to clear", C.sub)
	end)
end)

-- ── Mutation grid ──────────────────────────────────────────────────
local mutRow = make("Frame", {
    Size = UDim2.new(1, -16, 0, 76),
    Position = UDim2.new(0, 8, 0, 106),
    BackgroundTransparency = 1,
}, main)

make("TextLabel", {
    Size = UDim2.new(0, 54, 0, 24),
    BackgroundTransparency = 1,
    Text = "Mutation",
    TextColor3 = C.sub,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, mutRow)

local mutBtns = {}
for i, name in ipairs(MUTATIONS) do
    local col = (i - 1) % 3
    local row = math.floor((i - 1) / 3)
    local label = (name == "GreatBloom") and "Bloom" or name
    local b = make("TextButton", {
        Size = UDim2.new(0, 78, 0, 24),
        Position = UDim2.new(0, 58 + col * 82, 0, 26 + row * 26),
        BackgroundColor3 = (name == "None") and C.accent or C.btn,
        Text = label,
        TextColor3 = C.text,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        BorderSizePixel = 0,
        AutoButtonColor = false,
    }, mutRow)
    corner(b, 5)
    mutBtns[name] = b

    b.MouseButton1Click:Connect(function()
        enqueue(function()
            currentMutation = name
            for n, other in pairs(mutBtns) do
                other.BackgroundColor3 = (n == name) and C.accent or C.btn
            end
            notify("Mutation: " .. label, C.sub)
        end)
    end)
end

-- ── Size row ──────────────────────────────────────────────────────
local sizeRow = make("Frame", {
	Size                   = UDim2.new(1, -16, 0, 26),
	Position               = UDim2.new(0, 8, 0, 186),
	BackgroundTransparency = 1,
}, main)

make("TextLabel", {
	Size                   = UDim2.new(0, 54, 1, 0),
	BackgroundTransparency = 1,
	Text                   = "Size",
	TextColor3             = C.sub,
	Font                   = Enum.Font.Gotham,
	TextSize               = 11,
	TextXAlignment         = Enum.TextXAlignment.Left,
}, sizeRow)

local sizeBtns = {}
for i, opt in ipairs(SIZES) do
	local b = make("TextButton", {
		Size             = UDim2.new(0, 52, 1, 0),
		Position         = UDim2.new(0, 56 + (i - 1) * 54, 0, 0),
		BackgroundColor3 = (opt.mult == 1) and C.accent or C.btn,
		Text             = opt.label,
		TextColor3       = C.text,
		Font             = Enum.Font.Gotham,
		TextSize         = 10,
		BorderSizePixel  = 0,
		AutoButtonColor  = false,
	}, sizeRow)
	corner(b, 5)
	sizeBtns[opt.mult] = b

	b.MouseButton1Click:Connect(function()
		enqueue(function()
			currentSize = opt.mult
			for m, other in pairs(sizeBtns) do
				other.BackgroundColor3 = (m == opt.mult) and C.accent or C.btn
			end
			notify("Size: " .. opt.label, C.sub)
		end)
	end)
end

-- ── Auto-equip toggle ─────────────────────────────────────────────
local equipRow = make("Frame", {
	Size                   = UDim2.new(1, -16, 0, 24),
	Position               = UDim2.new(0, 8, 0, 218),
	BackgroundTransparency = 1,
}, main)

local equipToggle = make("TextButton", {
	Size             = UDim2.new(0, 116, 1, 0),
	BackgroundColor3 = C.accent,
	Text             = "Auto-equip: ON",
	TextColor3       = C.text,
	Font             = Enum.Font.GothamBold,
	TextSize         = 10,
	BorderSizePixel  = 0,
	AutoButtonColor  = false,
}, equipRow)
corner(equipToggle, 5)

make("TextLabel", {
	Size                   = UDim2.new(1, -124, 1, 0),
	Position               = UDim2.new(0, 122, 0, 0),
	BackgroundTransparency = 1,
	Text                   = "hold it, then click to place",
	TextColor3             = C.sub,
	Font                   = Enum.Font.Gotham,
	TextSize               = 10,
	TextXAlignment         = Enum.TextXAlignment.Left,
}, equipRow)

equipToggle.MouseButton1Click:Connect(function()
	enqueue(function()
		autoEquip = not autoEquip
		equipToggle.Text             = "Auto-equip: " .. (autoEquip and "ON" or "OFF")
		equipToggle.BackgroundColor3 = autoEquip and C.accent or C.btn
		if not autoEquip then heldTool = nil end
	end)
end)

-- ── Pet list ──────────────────────────────────────────────────────
local scroll = make("ScrollingFrame", {
	Size                 = UDim2.new(1, -16, 1, -280),
	Position             = UDim2.new(0, 8, 0, 256),
	BackgroundColor3     = C.panel,
	BorderSizePixel      = 0,
	ScrollBarThickness   = 4,
	ScrollBarImageColor3 = C.bar,
	CanvasSize           = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize  = Enum.AutomaticSize.Y,
}, main)
corner(scroll)
make("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }, scroll)
make("UIPadding", {
	PaddingTop  = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4),
	PaddingLeft = UDim.new(0, 4), PaddingRight  = UDim.new(0, 4),
}, scroll)

for i, entry in ipairs(CATALOG) do
	local rarCol = RARITY_COLOR[entry.rarity] or C.sub

	local row = make("Frame", {
		Name             = "Row_" .. i,
		Size             = UDim2.new(1, -8, 0, 44),
		BackgroundColor3 = C.btn,
		BorderSizePixel  = 0,
		LayoutOrder      = i,
	}, scroll)
	corner(row)
	row:SetAttribute("Search", (entry.display .. " " .. entry.id .. " " .. entry.rarity):lower())

	local stripe = make("Frame", {
		Size             = UDim2.new(0, 4, 1, -12),
		Position         = UDim2.new(0, 0, 0.5, -16),
		BackgroundColor3 = rarCol,
		BorderSizePixel  = 0,
	}, row)
	corner(stripe, 3)

	make("TextLabel", {
		Size                   = UDim2.new(0, 22, 1, 0),
		Position               = UDim2.new(0, 6, 0, 0),
		BackgroundTransparency = 1,
		Text                   = "#" .. i,
		TextColor3             = C.sub,
		Font                   = Enum.Font.Gotham,
		TextSize               = 9,
		TextXAlignment         = Enum.TextXAlignment.Left,
	}, row)

	if entry.icon ~= "" then
		make("ImageLabel", {
			Size                   = UDim2.new(0, 34, 0, 34),
			Position               = UDim2.new(0, 28, 0.5, -17),
			BackgroundTransparency = 1,
			Image                  = entry.icon,
		}, row)
	end

	make("TextLabel", {
		Size                   = UDim2.new(0, 140, 0, 16),
		Position               = UDim2.new(0, 66, 0, 5),
		BackgroundTransparency = 1,
		Text                   = entry.display,
		TextColor3             = C.text,
		Font                   = Enum.Font.GothamBold,
		TextSize               = 12,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextTruncate           = Enum.TextTruncate.AtEnd,
	}, row)

	make("TextLabel", {
		Size                   = UDim2.new(0, 140, 0, 14),
		Position               = UDim2.new(0, 66, 0, 23),
		BackgroundTransparency = 1,
		Text                   = "$" .. abbrev(entry.rate) .. "/s",
		TextColor3             = C.money,
		Font                   = Enum.Font.Gotham,
		TextSize               = 11,
		TextXAlignment         = Enum.TextXAlignment.Left,
	}, row)

	make("TextLabel", {
		Size                   = UDim2.new(0, 70, 1, 0),
		Position               = UDim2.new(1, -142, 0, 0),
		BackgroundTransparency = 1,
		Text                   = entry.rarity,
		TextColor3             = rarCol,
		Font                   = Enum.Font.GothamBold,
		TextSize               = 10,
		TextXAlignment         = Enum.TextXAlignment.Right,
	}, row)

	-- into your hands; click in-world to place it
	local btn = make("TextButton", {
		Size             = UDim2.new(0, 60, 0, 28),
		Position         = UDim2.new(1, -64, 0.5, -14),
		BackgroundColor3 = C.accent,
		Text             = "Spawn",
		TextColor3       = C.text,
		Font             = Enum.Font.GothamBold,
		TextSize         = 11,
		BorderSizePixel  = 0,
		AutoButtonColor  = false,
	}, row)
	corner(btn)

	btn.MouseEnter:Connect(function()
		enqueue(function() btn.BackgroundColor3 = C.accentH end)
	end)
	btn.MouseLeave:Connect(function()
		enqueue(function() btn.BackgroundColor3 = C.accent end)
	end)
	btn.MouseButton1Click:Connect(function()
		enqueue(function() doSpawn(entry) end)
	end)

	row.MouseEnter:Connect(function()
		enqueue(function() row.BackgroundColor3 = C.hover end)
	end)
	row.MouseLeave:Connect(function()
		enqueue(function() row.BackgroundColor3 = C.btn end)
	end)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local q = searchBox.Text:lower()
	enqueue(function()
		for _, row in ipairs(scroll:GetChildren()) do
			if row:IsA("Frame") then
				local hay = row:GetAttribute("Search")
				row.Visible = (q == "") or (hay ~= nil and hay:find(q, 1, true) ~= nil)
			end
		end
	end)
end)

-- ── Footer ────────────────────────────────────────────────────────
make("TextLabel", {
	Size                   = UDim2.new(1, 0, 0, 18),
	Position               = UDim2.new(0, 0, 1, -20),
	BackgroundTransparency = 1,
	Text                   = "Yt: Gena Scripts",
	TextColor3             = C.sub,
	Font                   = Enum.Font.FredokaOne,
	TextSize               = 10,
	TextXAlignment         = Enum.TextXAlignment.Center,
	ZIndex                 = 10,
}, main)

-- ── Silver pulse ──────────────────────────────────────────────────
task.spawn(function()
	local info = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	while running and root.Parent do
		TweenService:Create(mainStroke, info, { Color = C.pulseHi }):Play()
		task.wait(1.8)
		TweenService:Create(mainStroke, info, { Color = C.pulseLo }):Play()
		task.wait(1.8)
	end
end)

--------------------------------------------------------------------
_G.YomogiPetCleanup = function()
    running = false
    clearAll()
    pcall(function() root:Destroy() end)
end

print(("[Yomogi] Pet Spawner ready — %d pets (best: %s at $%s/s)")
	:format(#CATALOG, CATALOG[1].display, abbrev(CATALOG[1].rate)))
