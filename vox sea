-- Bootstrap errors cannot leave a half-loaded singleton or a permanent load lock.
return (function()
    local ok, result = xpcall(function()
-- Archivist Hub / Vox Seas. Shared CosmiUI; independent runtime.
-- SKELETON (pre-launch): interface only. Game logic is added after the live audit
-- in notas.md. Never spends premium currency or Robux.
local VOX_SEAS_PLACE = 104067066727140
local env = getgenv()
-- ARCHIVIST_VS_PREVIEW lets the interface be checked in another place before launch.
assert(game.PlaceId == VOX_SEAS_PLACE or env.ARCHIVIST_VS_PREVIEW == true, "This hub requires Vox Seas")
if env.ARCHIVIST_VS_STARTING and env.ARCHIVIST_VS_STARTING.JobId == game.JobId
    and env.ARCHIVIST_VS_STARTING.Player == game:GetService("Players").LocalPlayer
    and os.clock() - env.ARCHIVIST_VS_STARTING.At < 120 then
    local loading = env.ARCHIVIST_LOADING
    local pending = env.ARCHIVIST_VS_STARTING
    if loading then
        pcall(function() loading:Set(0, "Vox Seas is already loading...") end)
        task.delay(8, function()
            if env.ARCHIVIST_VS_STARTING == pending and env.ARCHIVIST_LOADING == loading then pcall(loading.Destroy, loading) end
        end)
    end
    return env.ARCHIVIST_VS
end
env.ARCHIVIST_VS_STARTING = {JobId = game.JobId, Player = game:GetService("Players").LocalPlayer, At = os.clock()}

-- Loading screen watchdog: if the hub fails anywhere during startup, the loader's
-- screen closes by itself and the error stays in the console.
task.spawn(function()
    local token = env.ARCHIVIST_VS_STARTING
    task.wait(90)
    if env.ARCHIVIST_VS_STARTING ~= token then return end
    local current = env.ARCHIVIST_VS
    if current and current.UIReady then return end
    env.ARCHIVIST_VS_BOOT_ERROR = "Startup timed out at " .. tostring(env.ARCHIVIST_VS_BOOT_STAGE or "game data")
    env.ARCHIVIST_VS_STARTING = nil
    if current then
        current.Alive = false
        if type(current.Unload) == "function" then pcall(current.Unload, current)
        else
            for _, connection in ipairs(current.Connections or {}) do pcall(connection.Disconnect, connection) end
            if current.Library then pcall(function() current.Library:Unload() end) end
        end
    end
    local loading = env.ARCHIVIST_LOADING
    if loading then
        pcall(function() loading:Set(0, "Startup timed out. Run the loader again.") end)
        task.delay(8, function() pcall(loading.Destroy, loading) end)
    end
    warn("[ArchivistHub] " .. env.ARCHIVIST_VS_BOOT_ERROR)
end)

if env.ARCHIVIST_VS then pcall(function() env.ARCHIVIST_VS:Unload() end) end
pcall(function()
    local holder = gethui and gethui() or game:GetService("CoreGui")
    for _, gui in ipairs(holder:GetChildren()) do
        if gui.Name == "ArchivistVoxSeasLauncher" then
            gui:Destroy()
        elseif gui.Name == "Obsidian" and gui:GetAttribute("ArchivistGame") == "VoxSeas" then
            -- Only our own window: another Archivist hub open in the same client stays.
            gui:Destroy()
        end
    end
    local oldAfk = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ArchivistVoxSeasAFK")
    if oldAfk then oldAfk:Destroy() end
end)

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
-- Recover a quiet-screen render lease left by an interrupted prior runtime.
pcall(function() RunService:Set3dRenderingEnabled(true) end)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInput = game:GetService("UserInputService")
local player = Players.LocalPlayer
-- Bounded waits: a slow client aborts cleanly instead of hanging the loading screen.
local TIMEOUT = 30
env.ARCHIVIST_VS_BOOT_STAGE = "game data"
if not game:IsLoaded() then
    local deadline = os.clock() + TIMEOUT
    repeat task.wait(0.1) until game:IsLoaded() or os.clock() >= deadline
    assert(game:IsLoaded(), "[ArchivistHub] Game did not load in 30 seconds")
end
if not player:WaitForChild("PlayerScripts", TIMEOUT) then error("[ArchivistHub] PlayerScripts no aparecio en 30s: reentra al juego") end
-- Auto Execute must wait for usable player data (Elysium DataStore), not just PlayerScripts.
local Elysium, MainModules
if game.PlaceId == VOX_SEAS_PLACE then
    Elysium = require(RS:WaitForChild("Elysium", TIMEOUT):WaitForChild("Modules", TIMEOUT))
    MainModules = require(RS:WaitForChild("Shared", TIMEOUT):WaitForChild("MainModules", TIMEOUT))
    local deadline, ready = os.clock() + 60, false
    repeat
        local ok, data = pcall(Elysium.DataStore.Get, Elysium.DataStore)
        ready = ok and type(data) == "table" and type(data.Statistics) == "table" and type(data.Quests) == "table"
        if not ready then task.wait(0.1) end
    until ready or os.clock() >= deadline
    if not ready then error("[ArchivistHub] Player data did not become ready in 60 seconds") end
    -- The game's DataStore:Get lowers this thread's identity until the next resume
    -- (CoreGui then reads as nil); one yield restores it before the interface loads.
    task.wait()
end
local ASSETS = "https://archivist-hub.archivisthub.workers.dev"

-- The main chunk is close to Luau's 200-local limit in the other hubs: new state and
-- functions go on Hub, not in new top-level locals.
local Hub = {Version = "1.0 Release", Game = "Vox Seas", JobId = game.JobId, Player = player, Alive = true, Paused = false,
    State = "Idle", Started = os.clock(), Connections = {}, HideWatch = {}}
env.ARCHIVIST_VS = Hub
function Hub.BootStage(name)
    assert(Hub.Alive, "[ArchivistHub] Startup was stopped")
    Hub.LoadStage, env.ARCHIVIST_VS_BOOT_STAGE = name, name
    pcall(function() if env.ARCHIVIST_LOADING then env.ARCHIVIST_LOADING:Set(0, "Vox Seas: " .. name .. "...") end end)
end

-- Settings, one file per account.
local SETTINGS_FILE = "archivist_voxseas_" .. player.UserId .. ".json"
local DEFAULTS = {AntiDie = true, Farm = false, AutoClick = false, AutoCodes = false, AutoStory = false, AutoGeppo = false, AutoSoru = false, AutoLearnSense = false, AutoLearnArmor = false, Priority = {"Fruits", "Story", "Farm"}, AutoVoxArmor = false, AutoVoxSense = false, TrainVoxSense = false, TrainVoxArmor = false, AutoAccessories = false, FruitGacha = false, AutoFish = false, AutoMinigames = false, FishWeapon = true, FishSpot = "Nearest Shore", FishNotify = true, FishNotifyRarities = {Rare = true, Epic = true, Legendary = true}, FishPausePlayers = false, AutoStoreFruits = false, AutoEatFruits = false, AutoDropFruits = false, DropFruits = {}, FruitESP = false, FruitFinder = false, FruitHop = false, FruitStore = true, FruitMinRarity = "Common", CodeResults = {}, AutoQuest = true, Height = 7, FarmMethod = "Teleport", Weapon = "Sword", Skills = {}, FarmMob = false, MobIsland = "Solmar Island", Mobs = {}, AutoStats = false, StatPick = "Sword", StatOrder = {}, StatMax = {}, StatList = {}, StatCap = {}, AntiAFK = true, AutoReconnect = true, AutoLoad = true, AFKScreen = true, Theme = "Purple"}
local S = table.clone(DEFAULTS)
pcall(function()
    if isfile(SETTINGS_FILE) then
        for key, value in pairs(HttpService:JSONDecode(readfile(SETTINGS_FILE))) do
            if DEFAULTS[key] ~= nil or key == "FishPoint" then S[key] = value end
        end
    end
end)
-- Combat height is internal; the farming panel exposes actions only.
S.Height = 7
if type(S.CodeResults) ~= "table" then S.CodeResults = {} end
Hub.S, Hub.DEFAULTS = S, DEFAULTS
local function save() pcall(writefile, SETTINGS_FILE, HttpService:JSONEncode(S)) end
Hub.Save = save
function Hub.CancelRecovery()
    if Hub.Recovering or Hub.StoryRecoverySpot then
        Hub.HoldAt = nil
        Hub.State = "Resuming"
    end
    Hub.Recovering, Hub.StoryRecoverySpot = nil, nil
end

-- Same recovery behavior as Anime Breaker: pre-arm execution, two disconnect
-- signals and bounded retry cadence. Local previews remain local across servers.
do
    local teleport = game:GetService("TeleportService")
    local gui = game:GetService("GuiService")
    function Hub.QueueLoad()
        if not Hub.Alive or not S.AutoLoad then return false end
        if Hub.LoadQueued then return true end
        local queue = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport)
            or (fluxus and fluxus.queue_on_teleport)
        if type(queue) ~= "function" then Hub.LoadError = "Executor has no teleport queue" return false end
        local preview = env.ARCHIVIST_VS_LOCAL and "vox-seas.luau" or ""
        local source = "local preview = " .. string.format("%q", preview) .. "\n" .. [[
repeat task.wait() until game:IsLoaded()
local player = game:GetService("Players").LocalPlayer
while not player do task.wait() player = game:GetService("Players").LocalPlayer end
local e = getgenv()
local h = e.ARCHIVIST_VS
if h and h.Alive and h.UIReady and h.JobId == game.JobId and h.Player == player then return end
local file = "archivist_voxseas_" .. player.UserId .. ".json"
local ok, settings = pcall(function()
    return game:GetService("HttpService"):JSONDecode(readfile(file))
end)
if ok and settings.AutoLoad == false then return end
local scripts = player:WaitForChild("PlayerScripts", 45)
if not scripts or not scripts:WaitForChild("ClientScripts", 45) then
    e.ARCHIVIST_VS_AUTOEXEC_ERROR = "Game client did not become ready"
    return
end
e.ARCHIVIST_VS_AUTOEXEC_RUN = {JobId = game.JobId, At = os.time()}
local success, err = pcall(function()
    if preview ~= "" then
        assert(isfile and isfile(preview), "Local Vox Seas preview is missing")
        e.ARCHIVIST_VS_LOCAL = true
        assert(loadstring(readfile(preview)))()
    else
        assert(loadstring(game:HttpGet("https://archivist-hub.archivisthub.workers.dev/loader.lua")))()
    end
end)
e.ARCHIVIST_VS_AUTOEXEC_ERROR = not success and tostring(err) or nil
if not success then
    local broken = e.ARCHIVIST_VS
    if broken and broken.JobId == game.JobId then
        if type(broken.Unload) == "function" then pcall(broken.Unload, broken)
        else
            broken.Alive = false
            for _, connection in ipairs(broken.Connections or {}) do pcall(function() connection:Disconnect() end) end
            if e.ARCHIVIST_VS == broken then e.ARCHIVIST_VS = nil end
        end
    end
    warn("[ArchivistHub] Auto Execute: " .. tostring(err))
end
]]
        local ok, result = pcall(queue, source)
        Hub.LoadQueued = ok and result ~= false
        Hub.LoadError = not Hub.LoadQueued and tostring(result) or nil
        if Hub.LoadQueued then Hub.LoadQueueAt, Hub.LoadQueueJob = os.clock(), game.JobId end
        return Hub.LoadQueued
    end
    function Hub.CanReconnect(code)
        code = tostring(code or "")
        return not (code:find("Duplicate") or code:find("Kick") or code:find("Banned") or code:find("^Teleport"))
    end
    function Hub.Reconnect(message, requireExecute)
        if env.ARCHIVIST_VS ~= Hub or not Hub.Alive or not S.AutoReconnect or Hub.Reconnecting then return false end
        if requireExecute and not Hub.QueueLoad() then return false end
        Hub.Reconnecting, Hub.LastDisconnect = true, tostring(message)
        save()
        Hub.QueueLoad()
        task.spawn(function()
            local failed
            local ok, err = xpcall(function()
                local privateId = RS:GetAttribute("PrivateServerId")
                if privateId == nil then pcall(function() privateId = game.PrivateServerId end) end
                local sameFailed = game.JobId == "" or (type(privateId) == "string" and privateId ~= "")
                failed = teleport.TeleportInitFailed:Connect(function(who, _, reason)
                    if who ~= player then return end
                    sameFailed, Hub.LoadQueued, Hub.ReconnectError = true, false, tostring(reason)
                end)
                table.insert(Hub.Connections, failed)
                local attempt = 0
                while Hub.Alive and env.ARCHIVIST_VS == Hub and S.AutoReconnect do
                    attempt += 1
                    Hub.ReconnectAttempts = attempt
                    Hub.QueueLoad()
                    local sent, reason
                    if attempt <= 2 and not sameFailed then
                        Hub.RejoinMode = "Same server"
                        sent, reason = pcall(teleport.TeleportToPlaceInstance, teleport, game.PlaceId, game.JobId, player)
                    else
                        Hub.RejoinMode = "New server"
                        sent, reason = pcall(teleport.Teleport, teleport, game.PlaceId, player)
                    end
                    if not sent then sameFailed = true Hub.ReconnectError = tostring(reason) end
                    local untilAt = os.clock() + math.min(20 * attempt, 60)
                    repeat task.wait(0.5) until not Hub.Alive or not S.AutoReconnect
                        or os.clock() >= untilAt or (sameFailed and Hub.RejoinMode == "Same server")
                end
            end, function(message) return debug.traceback(tostring(message), 2) end)
            if failed then failed:Disconnect() end
            if not ok then Hub.ReconnectError = err end
            Hub.Reconnecting = false
        end)
        return true
    end
    function Hub.OnDisconnect(message)
        if not Hub.Alive or env.ARCHIVIST_VS ~= Hub or type(message) ~= "string" or message == "" then return end
        local code = ""
        pcall(function() code = gui:GetErrorCode().Name end)
        Hub.LastDisconnect = code .. ": " .. message
        if S.AutoReconnect and Hub.CanReconnect(code) then return Hub.Reconnect(Hub.LastDisconnect) end
    end
    table.insert(Hub.Connections, player.OnTeleport:Connect(function(state)
        if not Hub.Alive then return end
        if state == Enum.TeleportState.Started then save() Hub.QueueLoad()
        elseif state == Enum.TeleportState.Failed then Hub.LoadQueued = false end
    end))
    pcall(function() table.insert(Hub.Connections, gui.ErrorMessageChanged:Connect(Hub.OnDisconnect)) end)
    pcall(function()
        local overlay = game:GetService("CoreGui").RobloxPromptGui.promptOverlay
        table.insert(Hub.Connections, overlay.ChildAdded:Connect(function(child)
            if child.Name ~= "ErrorPrompt" then return end
            task.wait(0.5)
            local message = "Disconnected"
            pcall(function() message = gui:GetErrorMessage() end)
            Hub.OnDisconnect(message ~= "" and message or "Disconnected")
        end))
    end)
    task.spawn(function()
        Hub.QueueLoad()
        while Hub.Alive and env.ARCHIVIST_VS == Hub do
            local ok, message = pcall(gui.GetErrorMessage, gui)
            if ok and type(message) == "string" and message ~= "" then Hub.OnDisconnect(message) end
            task.wait(5)
        end
    end)
end
-- Anti-AFK uses the same independent mouse and keyboard paths as Anime Breaker.
local function antiAfkPulse(source)
    if not Hub.Alive or env.ARCHIVIST_VS ~= Hub or not S.AntiAFK or Hub.AFKPulsing then return false end
    Hub.AFKPulsing = true
    Hub.AFKIgnoreInputUntil = os.clock() + 0.3
    local mouseOK, mouseError = pcall(function()
        local virtual = game:GetService("VirtualUser")
        virtual:CaptureController()
        virtual:ClickButton2(Vector2.zero)
    end)
    local keyOK, keyError = pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F15, false, game)
    end)
    if keyOK then task.wait(0.04) end
    local releaseOK, releaseError = pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F15, false, game)
    end)
    Hub.AFKPulsing = false
    Hub.AntiAFKMethods = {Mouse = mouseOK, Keyboard = keyOK and releaseOK}
    local errors = {}
    if not mouseOK then table.insert(errors, tostring(mouseError)) end
    if not keyOK then table.insert(errors, tostring(keyError)) end
    if not releaseOK then table.insert(errors, tostring(releaseError)) end
    Hub.AFKLastError = #errors > 0 and table.concat(errors, " | ") or nil
    if mouseOK or (keyOK and releaseOK) then
        Hub.AFKLastPulse = os.clock()
        Hub.AFKPulses = (Hub.AFKPulses or 0) + 1
        Hub.AFKLastSource = source or "Preventive"
        return true
    end
    return false
end
Hub.PulseAntiAFK = antiAfkPulse
table.insert(Hub.Connections, player.Idled:Connect(function() antiAfkPulse("Idle signal") end))

-- Interface
Hub.BootStage("interface")
local function loadInterface()
    if env.ARCHIVIST_VS_LOCAL and isfile("archivist-voxseas-cosmi-local.lua") then return readfile("archivist-voxseas-cosmi-local.lua") end
    local source, finished, failure
    task.spawn(function()
        local ok, result = pcall(game.HttpGet, game, ASSETS .. "/cosmi-ui.lua")
        if ok and type(result) == "string" and #result > 1000 then source = result else failure = tostring(result) end
        finished = true
    end)
    local deadline = os.clock() + 12
    repeat task.wait(0.05) until finished or os.clock() >= deadline or not Hub.Alive
    assert(Hub.Alive, "[ArchivistHub] Startup was stopped")
    local cache = "archivist_voxseas_cosmi_cache_v1.lua"
    if source then
        pcall(writefile, cache, source)
        return source
    end
    local ok, cached = pcall(function() return isfile(cache) and readfile(cache) end)
    if ok and type(cached) == "string" and #cached > 1000 then return cached end
    error("[ArchivistHub] Interface download failed. Run the loader again. " .. tostring(failure or "Timed out after 12 seconds"))
end
local ui = assert(loadstring(loadInterface(), "CosmiUI/Library.lua"))()
Hub.Library = ui
ui.ForceCheckbox = false
ui.ShowToggleFrameInKeybinds = true
ui.ShowCustomCursor = false
ui.Scheme.BackgroundColor = Color3.fromRGB(22, 22, 25)
ui.Scheme.MainColor = Color3.fromRGB(31, 31, 35)
ui.Scheme.AccentColor = Color3.fromRGB(140, 112, 220)
ui.Scheme.OutlineColor = Color3.fromRGB(52, 52, 58)
ui.Scheme.FontColor = Color3.fromRGB(236, 236, 240)
ui.Scheme.Font = Font.fromEnum(Enum.Font.Gotham)

local function customAsset(path, route, cachedOnly)
    local ok, asset = pcall(function()
        if not isfile(path) then
            if cachedOnly then return nil end
            local bytes = game:HttpGet(ASSETS .. route)
            assert(bytes:sub(2, 4) == "PNG", "Invalid image")
            writefile(path, bytes)
        end
        return getcustomasset(path)
    end)
    return ok and asset or nil
end
local logo = customAsset("archivist_cosmic_logo_v5_transparent.png", "/archivist-logo.png", true)
local faces = {
    Open = customAsset("archivist_launcher_king_open_v2.png", "/launcher-king-open.png", true),
    Closed = customAsset("archivist_launcher_king_closed_v2.png", "/launcher-king-closed.png", true),
}

local mobile = ui.IsMobile == true
local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
local windowWidth = math.max(360, math.min(740, viewport.X - 48))
local windowHeight = math.max(360, math.min(500, viewport.Y - 90))
if mobile then
    windowWidth = math.floor(math.max(300, math.min(800, (viewport.X - 16) / 0.92)))
    windowHeight = math.floor(math.max(220, math.min(540, (viewport.Y - 12) / 0.92)))
end
Hub.BootStage("window")
local window = ui:CreateWindow({
    Title = "daykits hub", Version = Hub.Version, Footer = "daykits hub  •  Vox Seas", Icon = logo or "moon-star",
    Font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular),
    UppercaseTitle = true, AnimatedBorder = true, CornerRadius = 8, TopBarHeight = mobile and 44 or 58,
    IconSize = mobile and UDim2.fromOffset(30, 30) or UDim2.fromOffset(36, 36), Center = true, AutoShow = true,
    Resizable = true, CopyableFooter = false, NotifySide = "Right", EnableCompacting = true, SidebarCompacted = true,
    GlobalSearch = true, ShowMobileButtons = false, DisableNotificationBell = true, DisableSearch = true,
    ShowCustomCursor = false, Size = UDim2.fromOffset(windowWidth, windowHeight),
})
if mobile then pcall(function() ui:SetDPIScale(92) end) end
if ui.ScreenGui then ui.ScreenGui.DisplayOrder = 2000000 ui.ScreenGui:SetAttribute("ArchivistGame", "VoxSeas") end
if ui.NotificationBellMini then ui.NotificationBellMini.Visible = false end
Hub.Window = window

-- King launcher: awake with the menu open, asleep and shaking his head with it closed.
local launcherGui = Instance.new("ScreenGui")
launcherGui.Name = "ArchivistVoxSeasLauncher"
launcherGui.ResetOnSpawn = false
launcherGui.IgnoreGuiInset = true
launcherGui.DisplayOrder = 2000001
local parented = pcall(function() launcherGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
if not parented or not launcherGui.Parent then launcherGui.Parent = player:WaitForChild("PlayerGui", TIMEOUT) end
Hub.LauncherGui = launcherGui
local launcher = Instance.new("TextButton")
launcher.Name = "ArchivistToggle"
launcher.Size = mobile and UDim2.fromOffset(72, 66) or UDim2.fromOffset(76, 69)
launcher.Position = UDim2.fromOffset(mobile and 8 or 12, mobile and 40 or 70)
launcher.BackgroundTransparency = 1
launcher.AutoButtonColor = false
launcher.Text = ""
launcher.ZIndex = 20
launcher.Parent = launcherGui
local king = Instance.new("ImageLabel")
king.Name = "Logo"
king.AnchorPoint = Vector2.new(0.5, 0.5)
king.Position = UDim2.fromScale(0.5, 0.5)
king.Size = UDim2.fromScale(1, 1)
king.BackgroundTransparency = 1
king.Image = faces.Open or logo or ""
king.Parent = launcher
-- Vox Seas: King sits between the clock (Day/Night) and the quest tracker, top left.
function Hub.PlaceKing()
    local main = player.PlayerGui:FindFirstChild("ScreenGuis")
    main = main and main:FindFirstChild("MainUI")
    local clock = main and main:FindFirstChild("WeatherStats", true)
    local quests = main and main:FindFirstChild("ActiveQuest", true)
    if not clock then return end
    local inset = game:GetService("GuiService"):GetGuiInset().Y
    local top = clock.AbsolutePosition.Y + clock.AbsoluteSize.Y + inset + 6
    local bottom = quests and quests.AbsolutePosition.Y + inset - 6 or top + launcher.AbsoluteSize.Y + 12
    local y = math.max(top, math.floor((top + bottom - launcher.AbsoluteSize.Y) / 2))
    local x = math.max(4, clock.AbsolutePosition.X - 6)
    if launcher.Position.Y.Offset ~= y or launcher.Position.X.Offset ~= x then launcher.Position = UDim2.fromOffset(x, y) end
end
task.spawn(function()
    while Hub.Alive do
        pcall(Hub.PlaceKing)
        task.wait(2)
    end
end)
local function setKingFace()
    local face = ui.Toggled and faces.Open or faces.Closed
    if face then king.Image = face end
end
launcher.Activated:Connect(function()
    if Hub.Alive then
        window:Toggle()
        setKingFace()
    end
end)
local function shakeHead()
    local start = os.clock()
    while Hub.Alive do
        local t = os.clock() - start
        if t >= 1.05 then break end
        local sx, sy, x, y, rot = 1, 1, 0, 0, 0
        if t < 0.12 then
            local k = math.sin(t / 0.12 * math.pi / 2)
            sx, sy, y = 1 + 0.06 * k, 1 - 0.1 * k, 2 * k
        elseif t < 0.78 then
            local k = (t - 0.12) / 0.66
            local amp = 18 * (1 - k) ^ 1.6
            rot = amp * math.sin(k * math.pi * 2 * 6.5)
            x = rot * 0.12
            sx, sy, y = 1.06 - 0.06 * k, 0.9 + 0.06 * k, 2 - 2 * k
        else
            local k = (t - 0.78) / 0.27
            local bounce = math.sin(k * math.pi) * (1 - k * 0.5)
            sx, sy, y = 1 - 0.05 * bounce, 0.96 + 0.04 * k + 0.1 * bounce, -3 * bounce
        end
        king.Rotation = rot
        king.Size = UDim2.fromScale(sx, sy)
        king.Position = UDim2.new(0.5, x, 0.5, y)
        RunService.Heartbeat:Wait()
    end
    king.Rotation = 0
    king.Size = UDim2.fromScale(1, 1)
    king.Position = UDim2.fromScale(0.5, 0.5)
end
task.spawn(function()
    local nextBlink, nextShake = os.clock() + 10, os.clock() + 10
    while Hub.Alive do
        local now = os.clock()
        if faces.Open and faces.Closed then
            if ui.Toggled then
                nextShake = now + 10
                if now >= nextBlink then
                    king.Image = faces.Closed
                    task.wait(0.14)
                    nextBlink = os.clock() + 10
                end
            elseif now >= nextShake then
                shakeHead()
                nextShake = os.clock() + 10
            end
            nextBlink = ui.Toggled and nextBlink or os.clock() + 10
        end
        setKingFace()
        task.wait(0.1)
    end
end)

local home = window:AddTab({Name = "Home", Icon = "house", Description = "Home"})
-- Same enamel BETA badge as Overdrive in Anime Breaker, placed after a groupbox title.
local function addBetaBadge(box, title, word)
    word = word or "BETA"
    pcall(function()
        for _, label in ipairs(box.BoxHolder:GetDescendants()) do
            if label:IsA("TextLabel") and label.Text == title then
                local badge = Instance.new("Frame")
                badge.Name = "BetaBadge"
                badge.AnchorPoint = Vector2.new(0, 0.5)
                local width = game:GetService("TextService"):GetTextSize(title, label.TextSize, Enum.Font.GothamMedium, Vector2.new(250, 50)).X
                badge.Position = UDim2.new(0, width + 10, 0.5, 0)
                badge.Size = UDim2.fromOffset(22 + game:GetService("TextService"):GetTextSize(word, 10, Enum.Font.GothamBold, Vector2.new(250, 50)).X + 6, 20)
                badge.BackgroundColor3 = Color3.new(1, 1, 1)
                badge.BorderSizePixel = 0
                badge.Active = false
                badge.Parent = label
                Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 5)
                local gradient = Instance.new("UIGradient")
                gradient.Rotation = 25
                gradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 31, 64)),
                    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(30, 24, 38)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(61, 34, 53)),
                })
                gradient.Parent = badge
                local stroke = Instance.new("UIStroke")
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Color = Color3.fromRGB(220, 165, 222)
                stroke.Transparency = 0.25
                stroke.Parent = badge
                local rim = Instance.new("UIGradient")
                rim.Rotation = 35
                rim.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.05),
                    NumberSequenceKeypoint.new(0.5, 0.65),
                    NumberSequenceKeypoint.new(1, 0.2),
                })
                rim.Parent = stroke
                local glow = Instance.new("UIStroke")
                glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                glow.Color = Color3.fromRGB(206, 130, 211)
                glow.Thickness = 3
                glow.Transparency = 0.93
                glow.Parent = badge
                -- Four-point star drawn with frames, no font glyph.
                local mark = Instance.new("Frame")
                mark.AnchorPoint = Vector2.new(0.5, 0.5)
                mark.Position = UDim2.new(0, 10, 0.5, 0)
                mark.Size = UDim2.fromOffset(10, 12)
                mark.BackgroundTransparency = 1
                mark.Parent = badge
                local core = Instance.new("Frame")
                core.AnchorPoint = Vector2.new(0.5, 0.5)
                core.Position = UDim2.fromScale(0.5, 0.5)
                core.Size = UDim2.fromOffset(4, 4)
                core.Rotation = 45
                core.BorderSizePixel = 0
                core.BackgroundColor3 = Color3.fromRGB(255, 226, 248)
                core.Parent = mark
                for index, size in ipairs({Vector2.new(2, 11), Vector2.new(8, 2)}) do
                    local ray = Instance.new("Frame")
                    ray.AnchorPoint = Vector2.new(0.5, 0.5)
                    ray.Position = UDim2.fromScale(0.5, 0.5)
                    ray.Size = UDim2.fromOffset(size.X, size.Y)
                    ray.BorderSizePixel = 0
                    ray.BackgroundColor3 = Color3.fromRGB(255, 213, 244)
                    ray.Parent = mark
                    local soften = Instance.new("UIGradient")
                    soften.Rotation = index == 1 and 90 or 0
                    soften.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.42, 0),
                        NumberSequenceKeypoint.new(0.58, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    soften.Parent = ray
                end
                local text = Instance.new("TextLabel")
                text.Position = UDim2.fromOffset(17, 0)
                text.Size = UDim2.new(1, -20, 1, 0)
                text.BackgroundTransparency = 1
                text.Font = Enum.Font.GothamBold
                text.Text = word
                text.TextSize = 10
                text.TextColor3 = Color3.fromRGB(255, 232, 250)
                text.TextXAlignment = Enum.TextXAlignment.Left
                text.Parent = badge
                break
            end
        end
    end)
end

-- Tabs by function, same order as the other hubs. Content arrives after the launch audit.
local farmTab = window:AddTab({Name = "Farm", Icon = "crosshair", Description = "Farming and stats"})
local farmSub = farmTab:AddSubTab({Name = "Farming", Icon = "crosshair"})
local statsSub = farmTab:AddSubTab({Name = "Stats", Icon = "chart-column"})
local voxSub = farmTab:AddSubTab({Name = "Vox", Icon = "zap"})
local fruitSub = window:AddTab({Name = "Fruits", Icon = "apple", Description = "Fruit finder"})
local fishTab = window:AddTab({Name = "Fishing", Icon = "fish", Description = "Auto fishing"})
local priorityTab = window:AddTab({Name = "Priority", Icon = "list-ordered", Description = "What runs first"})
local settingsTab = window:AddTab({Name = "Settings", Icon = "settings", Description = "Safety and interface"})
Hub.Tabs = {Home = home, Farm = farmTab, Farming = farmSub, Stats = statsSub, Vox = voxSub,
    Settings = settingsTab}
local Options, Toggles = ui.Options, ui.Toggles
Hub.Toggles, Hub.Options = Toggles, Options

-- Home: player card, session tiles, updates, Discord and quick access.
home.SingleColumn = true
home.Sides[2].Visible = false
home:RefreshSides()
local card = home:AddPlayerInfo("ArchivistVSPlayer", {Scrollable = true, Player = player, Title = "Hi, " .. player.DisplayName,
    Description = "@" .. player.Name .. "  •  Vox Seas"})
pcall(function()
    local gameLogo = Instance.new("ImageLabel")
    gameLogo.Name = "ArchivistGameLogo"
    gameLogo.BackgroundTransparency = 1
    gameLogo.Image = "rbxthumb://type=GameIcon&id=" .. game.GameId .. "&w=150&h=150"
    gameLogo.AnchorPoint = Vector2.new(1, 0.5)
    gameLogo.Position = UDim2.new(1, -12, 0.5, 0)
    gameLogo.Size = mobile and UDim2.fromOffset(44, 44) or UDim2.fromOffset(60, 60)
    gameLogo.ZIndex = 50
    Instance.new("UICorner", gameLogo).CornerRadius = UDim.new(0, 10)
    gameLogo.Parent = card.Holder
end)
local sessionRow = Instance.new("Frame")
sessionRow.Name = "ArchivistHomeStats"
sessionRow.BackgroundTransparency = 1
sessionRow.Size = UDim2.new(1, 0, 0, 68)
sessionRow.Parent = home.Sides[1]
local sessionValues = {}
for index, spec in ipairs({{Key = "Session", X = 0, Width = 0.20}, {Key = "Location", X = 0.20, Width = 0.40},
    {Key = "Players", X = 0.60, Width = 0.17}, {Key = "Executor", X = 0.77, Width = 0.23}}) do
    local tile = Instance.new("Frame")
    tile.Name = spec.Key
    tile.BackgroundColor3 = Color3.fromRGB(29, 28, 35)
    tile.BorderSizePixel = 0
    tile.Size = UDim2.new(spec.Width, -6, 1, 0)
    tile.Position = UDim2.new(spec.X, index == 1 and 0 or 3, 0, 0)
    tile.Parent = sessionRow
    Instance.new("UICorner", tile).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", tile)
    stroke.Color = Color3.fromRGB(63, 57, 77)
    stroke.Transparency = 0.35
    local heading = Instance.new("TextLabel")
    heading.BackgroundTransparency = 1
    heading.Position = UDim2.fromOffset(12, 9)
    heading.Size = UDim2.new(1, -24, 0, 15)
    heading.Font = Enum.Font.Gotham
    heading.TextSize = 11
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.TextColor3 = Color3.fromRGB(170, 165, 184)
    heading.Text = spec.Key
    heading.Parent = tile
    local value = heading:Clone()
    value.Position = UDim2.fromOffset(12, 27)
    value.Size = UDim2.new(1, -24, 1, -34)
    value.Font = Enum.Font.GothamMedium
    value.TextSize = 14
    value.TextColor3 = Color3.fromRGB(236, 236, 240)
    value.Parent = tile
    sessionValues[spec.Key] = value
end
local updates = home:AddGroupbox({Side = "Left", Name = "Updates", IconName = "history"})
do
local updateHeader = updates:AddLabel({Text = "1.0  -  Release", DoesWrap = false})
pcall(function()
    local label = updateHeader.TextLabel
    label.FontFace = Font.new(label.FontFace.Family, Enum.FontWeight.Medium)
    local function paint()
        if label.TextColor3 ~= ui.Scheme.AccentColor then label.TextColor3 = ui.Scheme.AccentColor end
    end
    paint()
    table.insert(Hub.Connections, label:GetPropertyChangedSignal("TextColor3"):Connect(paint))
end)
local updateBody = updates:AddLabel({Text = table.concat({
    "• First release of the Vox Seas hub.",
    "• Auto Farm Level, Farm Mob and Auto Complete Story.",
    "• Vox abilities, Fruit Finder, Fruit Gacha and Auto Fish.",
    "• Anti-AFK, AFK Screen, Auto Reconnect and Auto Execute.",
}, "\n"), DoesWrap = true})
pcall(function() updateBody.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) end)
end
local discord = home:AddGroupbox({Side = "Right", Name = "Discord", IconName = "users"})
discord:AddLabel({Text = "Archivist Hub community", DoesWrap = true})
discord:AddButton({Text = "Copy Discord Link", Func = function()
    if pcall(setclipboard, "https://discord.gg/4rM8tg8Nqm") then
        ui:Notify({Title = "Discord", Description = "Link copied", Time = 3})
    end
end})
discord:AddLabel({Text = "Thanks for joining us ♥", DoesWrap = true})
local row = Instance.new("Frame")
row.Name = "ArchivistHomeOverview"
row.BackgroundTransparency = 1
row.AutomaticSize = Enum.AutomaticSize.Y
row.Size = UDim2.new(1, 0, 0, 0)
row.Parent = home.Sides[1]
local rowLayout = Instance.new("UIListLayout", row)
rowLayout.Padding = UDim.new(0, 8)
rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
updates.BoxHolder.Parent, discord.BoxHolder.Parent = row, row
updates.BoxHolder.LayoutOrder, discord.BoxHolder.LayoutOrder = 1, 2
local function fitHome()
    local stacked = row.AbsoluteSize.X < 420
    rowLayout.FillDirection = stacked and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal
    updates.BoxHolder.Size = stacked and UDim2.new(1, 0, 0, 0) or UDim2.new(0.58, -4, 0, 0)
    discord.BoxHolder.Size = stacked and UDim2.new(1, 0, 0, 0) or UDim2.new(0.42, -4, 0, 0)
end
table.insert(Hub.Connections, row:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitHome))
fitHome()
local quick = home:AddGroupbox({Side = "Left", Name = "Quick Access", IconName = "zap"})
local function rejoin()
    local ok = pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player) end)
    if not ok then ui:Notify({Title = "Rejoin Server", Description = "Unable to request rejoin. Try again.", Time = 5}) end
end
quick:AddButton({Text = "Reset Settings", Func = function() if Hub.ResetSettings then Hub.ResetSettings() end end})
    :AddButton({Text = "Rejoin Server", Tooltip = "Rejoin your current server.", Func = rejoin})
local stopButton = quick:AddButton({Text = "Stop Everything", Func = function() Hub.SetPaused(true) end})
local startButton = stopButton:AddButton({Text = "Start Everything", Func = function() Hub.SetPaused(false) end})
local pauseLabel = quick:AddLabel({Text = "Script running", DoesWrap = true})
function Hub.SetPaused(paused)
    Hub.Paused = paused == true
    if Hub.Paused and Hub.CancelStoryMotion then Hub.CancelStoryMotion() end
    for button, selected in pairs({[stopButton] = Hub.Paused, [startButton] = not Hub.Paused}) do
        button.Base.BackgroundColor3 = selected and ui.Scheme.AccentColor or Color3.fromRGB(43, 41, 49)
        button.Base.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(207, 203, 216)
        button.Base.TextTransparency = 0
    end
    pauseLabel:SetText(Hub.Paused and "Everything paused" or "Script running")
end


-- Pre-launch placeholders: no game logic until the live audit (notas.md).
function Hub.AddSoon(tab, side, name, icon, text)
    local box = tab:AddGroupbox({Side = side, Name = name, IconName = icon})
    addBetaBadge(box, name, "SOON")
    box:AddLabel({Text = text, DoesWrap = true})
    return box
end
function Hub.SelectedValues(selection)
    local values = {}
    for key, enabled in pairs(selection or {}) do if enabled then table.insert(values, key) end end
    table.sort(values)
    return values
end
Hub.BootStage("controls")
local farmBox = farmSub:AddGroupbox({Side = "Left", Name = "Farming", IconName = "swords"})
farmBox:AddDropdown("ArchivistVSWeapon", {Text = "Select Weapon", Values = {"Sword", "Melee", "Gun", "Fruit"}, Default = S.Weapon, Multi = false})
farmBox:AddDropdown("ArchivistVSFarmMethod", {Text = "Farm Method", Values = {"Teleport", "Movement"}, Default = S.FarmMethod, Multi = false, Tooltip = "Movement circles behind the enemy and dodges skills"})
farmBox:AddDropdown("ArchivistVSSkills", {Text = "Skills", Values = {"Z", "X", "C", "V"}, AllowNull = true, Default = Hub.SelectedValues(S.Skills), Multi = true, Tooltip = "Used while farming"})
farmBox:AddToggle("ArchivistVSFarm", {Text = "Auto Farm Level", Default = S.Farm, Tooltip = "Farms and takes level quests"})
farmBox:AddToggle("ArchivistVSAntiDie", {Text = "Anti Die", Default = S.AntiDie, Tooltip = "Retreat at 10% health, resume at 50%"})
-- Inline selectors keep the label and selected value on the same row.
function Hub.InlineSelector(option)
    local holder = option.Holder
    if not holder then return end
    holder.Size = UDim2.new(1, 0, 0, 30)
    for _, child in ipairs(holder:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Size = UDim2.new(0.43, -6, 1, 0)
            child.TextSize = 13
            child.Position = UDim2.fromOffset(0, 0)
        elseif child:IsA("TextButton") then
            child.AnchorPoint = Vector2.new(1, 0)
            child.Position = UDim2.fromScale(1, 0)
            child.Size = UDim2.new(0.57, 0, 1, 0)
            for _, part in ipairs(child:GetChildren()) do
                if part:IsA("TextButton") then
                    part.Size = UDim2.new(1, -16, 1, 0)
                    part.TextSize = 13
                    part.TextXAlignment = Enum.TextXAlignment.Center
                end
            end
        end
    end
end
Hub.InlineSelector(Options.ArchivistVSWeapon)
Hub.InlineSelector(Options.ArchivistVSFarmMethod)
Hub.InlineSelector(Options.ArchivistVSSkills)
farmBox:Resize()
-- Enemy level from the game's own enemy data, cached by name (lists go from weakest to strongest).
Hub.MobLevels = {}
function Hub.MobLevel(name)
    local cached = Hub.MobLevels[name]
    if cached then return cached end
    local level = math.huge
    pcall(function()
        local module = RS.Shared.MainModules.EnemysUtils.EnemysInfo:FindFirstChild(name, true)
        local info = module and module:IsA("ModuleScript") and require(module)
        level = tonumber(info and info.EnemyArguments and info.EnemyArguments.Level) or math.huge
    end)
    Hub.MobLevels[name] = level
    return level
end
function Hub.ByLevel(list)
    table.sort(list, function(a, b)
        local la, lb = Hub.MobLevel(a), Hub.MobLevel(b)
        if la ~= lb then return la < lb end
        return a < b
    end)
    return list
end
Hub.IslandList = {}
pcall(function()
    local lowest = {}
    for _, island in ipairs(workspace.IgnoreList.Data.EnemyGroups:GetChildren()) do
        table.insert(Hub.IslandList, island.Name)
        local low = math.huge
        for _, group in ipairs(island:GetChildren()) do
            for name in tostring(group:GetAttribute("Enemies") or ""):gmatch("[^,]+") do
                name = name:gsub("^Enemies=", "")
                if name ~= "" and not name:find("History") then low = math.min(low, Hub.MobLevel(name)) end
            end
        end
        -- Wanted bosses are not an island: always last.
        lowest[island.Name] = island.Name == "Wanted" and math.huge or low
    end
    table.sort(Hub.IslandList, function(a, b)
        if lowest[a] ~= lowest[b] then return lowest[a] < lowest[b] end
        return a < b
    end)
end)
task.wait() -- native modules may lower the calling thread capability
function Hub.MobsOf(island)
    local list, seen = {}, {}
    local folder = workspace.IgnoreList.Data.EnemyGroups:FindFirstChild(island)
    for _, group in ipairs(folder and folder:GetChildren() or {}) do
        for name in tostring(group:GetAttribute("Enemies") or ""):gmatch("[^,]+") do
            name = name:gsub("^Enemies=", "")
            if name ~= "" and not name:find("History") and not seen[name] then seen[name] = true table.insert(list, name) end
        end
    end
    return Hub.ByLevel(list)
end
if not table.find(Hub.IslandList, S.MobIsland) then S.MobIsland = Hub.IslandList[1] or S.MobIsland end
local mobBox = farmSub:AddGroupbox({Side = "Left", Name = "Farm Mob", IconName = "target"})
mobBox:AddDropdown("ArchivistVSMobIsland", {Text = "Island", Values = Hub.IslandList, Default = S.MobIsland, Multi = false})
mobBox:AddDropdown("ArchivistVSMobs", {Text = "Select Mob", Values = Hub.MobsOf(S.MobIsland), Default = Hub.SelectedValues(S.Mobs), Multi = true})
mobBox:AddToggle("ArchivistVSFarmMob", {Text = "Auto Farm Mob", Default = S.FarmMob, Tooltip = "Farms the chosen mobs, no quest"})
local factureBox = farmSub:AddGroupbox({Side = "Right", Name = "Facture", IconName = "sparkles"})
factureBox:AddToggle("ArchivistVSAutoCodes", {Text = "Auto Redeem Codes", Default = S.AutoCodes, Tooltip = "Tries known codes once"})
factureBox:AddToggle("ArchivistVSAutoClick", {Text = "Auto Click", Default = S.AutoClick, Tooltip = "Attacks with your selected weapon"})
factureBox:AddToggle("ArchivistVSAutoStory", {Text = "Auto Complete Story", Default = S.AutoStory, Tooltip = "Completes the story quests"})
factureBox:AddToggle("ArchivistVSAutoAccessories", {Text = "Auto Equip Best Accessories", Default = S.AutoAccessories, Tooltip = "Equips the best accessory per slot"})
local statsBox = statsSub:AddGroupbox({Side = "Left", Name = "Auto Stats", IconName = "chart-column"})
statsBox:AddToggle("ArchivistVSAutoStats", {Text = "Auto Stats", Default = S.AutoStats, Tooltip = "Spends free points in your order"})
Hub.StatNames = {"Strength", "Endurance", "Sword", "Gun", "DevilFruit"}
-- Priority = the order the stats were picked. Older settings (single pick or rows) carry over.
if type(S.StatList) ~= "table" then S.StatList = {} end
if type(S.StatCap) ~= "table" then S.StatCap = {} end
if #S.StatList == 0 then
    for index, name in ipairs(type(S.StatOrder) == "table" and S.StatOrder or {}) do
        if name ~= "None" and table.find(Hub.StatNames, name) and not table.find(S.StatList, name) then
            table.insert(S.StatList, name)
            local old = type(S.StatMax) == "table" and tonumber(S.StatMax[index])
            if old then S.StatCap[name] = old end
        end
    end
    if #S.StatList == 0 and table.find(Hub.StatNames, S.StatPick) then S.StatList = {S.StatPick} end
end
local picked = {}
for _, name in ipairs(S.StatList) do picked[name] = true end
statsBox:AddDropdown("ArchivistVSStatList", {Text = "Stats", Values = Hub.StatNames, Default = Hub.SelectedValues(picked), Multi = true, AllowNull = true, Tooltip = "Pick order is the priority"})
for _, name in ipairs(Hub.StatNames) do
    statsBox:AddSlider("ArchivistVSStatCap" .. name, {Text = name .. " Target", Default = tonumber(S.StatCap[name]) or 500, Min = 1, Max = 500, Rounding = 0, Compact = false})
    Options["ArchivistVSStatCap" .. name]:SetVisible(picked[name] == true)
end
local statsInfoBox = statsSub:AddGroupbox({Side = "Right", Name = "Stats Order", IconName = "list-ordered"})
Hub.StatsLabel = statsInfoBox:AddLabel({Text = "Free points  -", DoesWrap = true})
-- Left: quests that unlock abilities, training below. Right: keep the forms switched on.
local voxCompleteBox = voxSub:AddGroupbox({Side = "Left", Name = "Auto Complete", IconName = "badge-check"})
voxCompleteBox:AddToggle("ArchivistVSAutoGeppo", {Text = "Auto Complete Geppo", Default = S.AutoGeppo, Tooltip = "Double jump, 500 Gold"})
voxCompleteBox:AddToggle("ArchivistVSAutoSoru", {Text = "Auto Complete Soru", Default = S.AutoSoru, Tooltip = "Phantom Tablet quest, free, level 85"})
voxCompleteBox:AddToggle("ArchivistVSAutoLearnSense", {Text = "Auto Complete Vox Sense", Default = S.AutoLearnSense, Tooltip = "Askard lesson, 5000 Gold, level 145"})
voxCompleteBox:AddToggle("ArchivistVSAutoLearnArmor", {Text = "Auto Complete Vox Armor", Default = S.AutoLearnArmor, Tooltip = "Askard lesson, 5000 Gold, after Vox Sense"})
Hub.AbilityLabel = voxCompleteBox:AddLabel({Text = "Loading", DoesWrap = true})
local voxAbilityBox = voxSub:AddGroupbox({Side = "Right", Name = "Auto Active", IconName = "sparkles"})
voxAbilityBox:AddToggle("ArchivistVSAutoVoxArmor", {Text = "Auto Active Vox Armor", Default = S.AutoVoxArmor, Tooltip = "Keeps Vox Armor on"})
voxAbilityBox:AddToggle("ArchivistVSAutoVoxSense", {Text = "Auto Active Vox Sense", Default = S.AutoVoxSense, Tooltip = "Keeps Vox Sense on"})
local voxBox = voxSub:AddGroupbox({Side = "Left", Name = "Vox Training", IconName = "zap"})
voxBox:AddToggle("ArchivistVSTrainVoxSense", {Text = "Train Vox Sense", Default = S.TrainVoxSense, Tooltip = "Askard dodge training, paid in Gold"})
voxBox:AddToggle("ArchivistVSTrainVoxArmor", {Text = "Train Vox Armor", Default = S.TrainVoxArmor, Tooltip = "Askard stone training, paid in Gold"})
Hub.VoxTrainLabel = voxBox:AddLabel({Text = "Loading", DoesWrap = true})
-- Priority: when several modes are on, the one ranked higher runs first.
Hub.PriorityNames = {"Fruits", "Story", "Farm"}
do
    local valid, seen = {}, {}
    for _, name in ipairs(type(S.Priority) == "table" and S.Priority or {}) do
        if table.find(Hub.PriorityNames, name) and not seen[name] then seen[name] = true table.insert(valid, name) end
    end
    for _, name in ipairs(Hub.PriorityNames) do if not seen[name] then table.insert(valid, name) end end
    S.Priority = valid
end
function Hub.Rank(name) return table.find(S.Priority, name) or 99 end
Hub.PrioritySlots = {"First", "Second", "Third"}
local priorityBox = priorityTab:AddGroupbox({Side = "Left", Name = "Priority", IconName = "list-ordered"})
for index, slot in ipairs(Hub.PrioritySlots) do
    priorityBox:AddDropdown("ArchivistVSPriority" .. slot, {Text = slot, Values = Hub.PriorityNames, Default = S.Priority[index], Multi = false})
    Hub.InlineSelector(Options["ArchivistVSPriority" .. slot])
end
local priorityInfo = priorityTab:AddGroupbox({Side = "Right", Name = "How it works", IconName = "info"})
priorityInfo:AddLabel({Text = "Farm: Auto Farm Level or Mob\nStory: Auto Complete Story\nFruits: Auto Fruit Finder\nA higher mode runs first; lower ones wait.", DoesWrap = true})
priorityBox:Resize()
-- Settings
local safetyBox = settingsTab:AddGroupbox({Side = "Left", Name = "Safety", IconName = "shield"})
safetyBox:AddToggle("ArchivistVSAntiAFK", {Text = "Anti-AFK", Default = S.AntiAFK})
safetyBox:AddToggle("ArchivistVSAutoReconnect", {Text = "Auto Reconnect", Default = S.AutoReconnect, Tooltip = "Rejoin after connection loss"})
safetyBox:AddToggle("ArchivistVSAutoLoad", {Text = "Auto Execute", Default = S.AutoLoad, Tooltip = "Load the hub after teleporting"})
safetyBox:AddToggle("ArchivistVSAFKScreen", {Text = "AFK Screen", Default = S.AFKScreen, Tooltip = "After 30 seconds without input. Farming continues."})
-- Server: uses the game's own free server list (no Robux, no private server purchase).
local serverBox = settingsTab:AddGroupbox({Side = "Left", Name = "Server", IconName = "server"})
-- The game's own list only returns the ~200 fullest servers, so the Roblox public server
-- API (ascending) is used to find servers with 5 players or fewer.
Hub.EmptyMax = 5
function Hub.SmallServers()
    local found, cursor = {}, nil
    for _ = 1, 3 do
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"
            .. (cursor and ("&cursor=" .. cursor) or "")
        local ok, body = pcall(function()
            if request then local r = request({Url = url, Method = "GET"}) return r.StatusCode == 200 and r.Body or nil end
            return game:HttpGet(url)
        end)
        local okj, data = pcall(function() return HttpService:JSONDecode(body) end)
        if not ok or not okj or type(data) ~= "table" or type(data.data) ~= "table" then break end
        local over = false
        for _, server in ipairs(data.data) do
            local count = tonumber(server.playing) or 0
            if count > Hub.EmptyMax then over = true
            elseif server.id ~= game.JobId and count < (tonumber(server.maxPlayers) or 20) then table.insert(found, {JobId = server.id, Players = count}) end
        end
        cursor = data.nextPageCursor
        if over or not cursor or #found >= 30 then break end
    end
    return found
end
serverBox:AddButton({Text = "Join Emptiest Server", Tooltip = "5 players or fewer", Func = function()
    task.spawn(function()
        local list = Hub.SmallServers()
        if #list == 0 then ui:Notify({Title = "Server", Description = "No server with 5 players or fewer", Time = 5}) return end
        save()
        Hub.QueueLoad()
        -- Random among the small ones so several users do not pile into the same server; retry on failure.
        for _ = 1, math.min(4, #list) do
            local pick = table.remove(list, math.random(1, #list))
            ui:Notify({Title = "Server", Description = "Joining a server with " .. pick.Players .. " players", Time = 5})
            local ok = pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.JobId, player) end)
            if ok then
                local failed = false
                local connection = TeleportService.TeleportInitFailed:Connect(function(who) if who == player then failed = true end end)
                local deadline = os.clock() + 12
                repeat task.wait(0.5) until failed or os.clock() >= deadline
                connection:Disconnect()
                if not failed then return end
            end
        end
        ui:Notify({Title = "Server", Description = "Join failed, try again", Time = 6})
    end)
end})
local interfaceBox = settingsTab:AddGroupbox({Side = "Right", Name = "Interface", IconName = "palette"})
local THEMES = {
    Purple = Color3.fromRGB(140, 112, 220), Blue = Color3.fromRGB(76, 132, 235), Cyan = Color3.fromRGB(56, 182, 202),
    Green = Color3.fromRGB(82, 178, 104), Red = Color3.fromRGB(214, 72, 82), Pink = Color3.fromRGB(222, 102, 172),
    Orange = Color3.fromRGB(232, 140, 58), Gold = Color3.fromRGB(214, 176, 72),
}
local function setTheme(name)
    local color = THEMES[name] or THEMES.Purple
    S.Theme = THEMES[name] and name or "Purple"
    ui.Scheme.AccentColor = color
    local h, sat = color:ToHSV()
    ui.Scheme.OutlineColor = S.Theme == "Purple" and Color3.fromRGB(52, 52, 58) or Color3.fromHSV(h, math.min(sat, 0.32), 0.31)
    pcall(function() ui:UpdateColorsUsingRegistry() end)
    Hub.SetPaused(Hub.Paused)
    save()
end
interfaceBox:AddDropdown("ArchivistVSAccent", {Text = "Accent Color", Values = {"Purple", "Blue", "Cyan", "Green", "Red", "Pink", "Orange", "Gold"}, Default = S.Theme, Multi = false,
    Callback = function(value) if value then setTheme(value) end end})
setTheme(S.Theme)

-- AFK Screen: same art and behaviour as the Anime Breaker hub.
local afk = {Active = false, LastInput = os.clock(), Held = {}, Stopped = false}
Hub.AFKState = afk
do
    local screen, clockLabel, cardScale
    local stars = {}
    local TweenService = game:GetService("TweenService")
    local fpsCap = setfpscap or (syn and syn.setfpscap)
    local function applyQuiet()
        if fpsCap then pcall(fpsCap, afk.Active and (mobile and 30 or 60) or 0) end
        pcall(function() RunService:Set3dRenderingEnabled(not afk.Active) end)
        Hub.RenderingSuspended = afk.Active
        env.ARCHIVIST_VS_RENDER_OWNER = afk.Active and Hub or nil
    end
    local function cachedArt(name, bytes)
        if type(getcustomasset) ~= "function" then return "" end
        local ok, asset = pcall(function()
            if not (isfile and isfile(name)) then
                local data = type(bytes) == "function" and bytes() or bytes
                if data:sub(2, 4) ~= "PNG" then error("not a png") end
                writefile(name, data)
            end
            return getcustomasset(name)
        end)
        return ok and asset or ""
    end
    local function text(parent, value, size, color, font)
        local label = Instance.new("TextLabel", parent)
        label.BackgroundTransparency = 1
        label.Font = font or Enum.Font.GothamMedium
        label.TextSize = size
        label.TextColor3 = color or Color3.fromRGB(236, 236, 240)
        label.Text = value
        return label
    end
    local function fit()
        local camera = workspace.CurrentCamera
        local view = (camera and camera.ViewportSize) or Vector2.new(800, 600)
        if afk.Viewport == view then return end
        afk.Viewport = view
        cardScale.Scale = math.clamp(math.min((view.X - 32) / 330, (view.Y - 32) / 330), 0.45, 1.25)
    end
    local function build()
        if screen then return end
        local starAsset = cachedArt("archivist_afk_star_v4.png", "\137\080\078\071\013\010\026\010\000\000\000\013\073\072\068\082\000\000\000\064\000\000\000\064\008\006\000\000\000\170\105\113\222\000\000\005\171\073\068\065\084\120\156\236\091\107\136\085\085\020\254\102\122\151\077\081\097\101\138\210\132\086\042\164\082\142\129\061\108\108\042\193\031\197\004\061\044\171\009\162\130\002\169\040\176\048\040\040\050\123\080\127\042\070\139\130\050\193\040\036\139\236\058\245\043\115\140\030\154\082\142\102\152\217\088\102\089\246\160\233\251\186\251\230\153\221\062\247\156\123\246\190\231\004\119\062\248\088\231\238\181\247\090\107\063\206\126\157\153\102\052\056\154\209\224\024\106\000\052\056\134\026\000\013\142\066\027\096\096\096\096\018\121\044\010\068\097\013\192\138\119\083\244\146\253\124\190\007\005\161\009\005\128\021\158\064\241\137\149\060\177\169\169\233\083\228\140\162\070\192\173\142\180\091\080\000\114\031\001\236\253\035\041\118\144\135\091\170\095\200\019\056\010\126\066\142\040\098\004\220\128\255\086\030\038\237\122\228\140\034\070\192\023\020\173\049\234\047\057\002\078\065\142\200\117\004\176\242\029\136\175\188\208\202\060\023\034\071\228\253\010\220\028\040\079\048\228\246\010\176\103\071\081\124\101\037\191\140\114\039\116\070\210\254\034\071\243\085\248\026\057\032\207\017\224\090\250\158\038\159\178\210\154\099\242\214\005\185\140\000\246\254\193\020\219\201\232\182\119\061\123\121\188\209\127\070\113\122\068\183\139\028\065\253\239\168\051\242\026\001\087\098\112\229\133\039\034\207\079\090\058\229\189\002\057\032\175\017\176\150\098\114\036\105\015\202\155\158\095\141\254\048\148\055\071\045\145\060\189\212\079\065\157\081\247\017\192\202\077\197\224\202\011\221\149\202\011\230\121\177\149\103\050\203\158\133\058\035\143\087\192\222\227\015\096\240\240\175\224\241\020\101\131\227\064\100\000\123\230\080\138\163\201\163\140\140\062\075\030\017\201\062\199\042\254\022\123\124\179\109\083\105\180\251\054\031\103\070\146\175\097\090\095\228\247\094\114\055\249\163\075\210\198\062\212\136\170\115\000\157\107\150\190\155\028\139\253\149\027\014\063\204\102\160\175\199\248\155\077\241\026\252\176\019\251\027\230\003\114\033\253\245\197\101\078\106\000\109\092\070\033\028\182\050\152\049\168\238\115\011\197\104\132\195\078\250\060\062\078\217\092\037\144\025\008\091\121\225\222\020\121\022\032\044\134\179\046\227\226\148\177\035\128\133\116\060\221\068\158\132\108\208\082\087\025\138\090\226\022\179\039\094\074\083\144\190\231\082\092\069\170\231\042\175\094\011\178\161\159\028\067\223\123\093\202\164\087\096\058\197\027\049\206\191\033\239\071\121\135\087\153\136\042\147\209\110\212\001\140\039\058\225\086\038\093\117\208\124\242\068\071\017\117\194\044\198\243\126\156\205\196\141\016\157\106\139\186\146\028\233\080\127\068\206\164\131\126\020\000\198\118\028\133\086\142\051\028\106\029\166\058\024\219\250\106\054\082\237\004\233\072\067\241\029\114\188\067\189\149\156\225\090\218\234\009\198\116\050\197\042\184\039\076\157\045\046\096\076\223\038\217\073\181\017\050\134\218\200\213\014\181\002\088\195\128\218\144\019\140\175\053\112\087\094\049\182\165\169\188\144\122\039\072\131\063\083\180\147\047\058\212\199\144\037\179\142\215\021\198\071\201\248\180\161\216\218\077\172\169\080\211\086\152\134\255\036\175\230\227\131\014\245\033\228\114\006\120\019\234\004\099\123\185\241\101\227\001\197\166\024\081\003\050\159\006\025\204\117\020\207\194\221\136\139\200\121\012\102\000\001\064\095\138\243\081\242\118\135\090\055\072\093\244\213\141\012\240\058\014\051\176\075\040\094\193\224\189\127\005\075\025\212\229\008\000\250\145\143\078\135\074\107\251\101\244\179\018\025\225\117\026\164\227\021\020\218\043\124\231\080\119\050\240\187\224\009\243\221\208\085\121\237\249\167\251\084\094\240\062\014\051\128\117\020\058\183\111\116\168\039\193\031\174\075\017\249\154\106\124\123\033\200\125\000\003\217\066\113\145\067\181\029\254\216\230\072\107\055\062\189\017\242\066\228\052\071\218\123\240\135\107\239\049\001\129\016\178\001\206\115\164\149\224\143\018\210\249\202\132\144\013\112\142\245\091\215\222\063\192\019\198\198\134\004\095\153\017\164\001\204\173\174\189\021\094\157\162\220\169\034\146\209\099\253\158\102\174\229\188\017\106\004\156\237\072\139\125\255\025\252\068\115\085\174\158\221\160\103\165\033\030\061\041\125\214\140\080\013\224\026\146\239\218\009\172\228\048\242\049\062\106\249\138\094\149\235\121\029\117\139\204\069\140\141\085\041\125\214\140\122\053\192\102\190\187\059\162\009\172\216\165\020\159\147\183\145\007\056\108\040\077\091\221\141\038\239\191\048\182\250\018\124\102\130\119\003\048\088\005\110\191\255\061\017\253\072\242\077\062\046\067\186\235\053\093\188\044\083\025\149\117\217\052\152\102\124\123\033\196\008\208\046\208\158\144\254\153\000\025\224\157\040\111\100\058\098\202\238\049\116\065\101\182\209\198\029\230\119\201\210\203\231\153\240\068\136\006\056\215\145\182\207\124\241\125\168\074\185\165\228\056\195\087\171\228\123\216\216\250\045\165\239\154\224\253\113\148\193\233\064\116\113\013\069\116\087\215\101\031\098\104\071\091\233\103\224\190\123\140\195\010\218\153\005\015\248\030\135\085\094\067\120\088\138\236\127\144\011\201\005\113\159\176\204\218\126\031\057\143\060\008\201\208\205\079\139\207\189\131\111\003\232\164\246\097\138\172\250\068\053\135\129\110\074\145\087\118\245\041\238\005\148\231\151\036\076\161\221\094\100\132\239\028\144\180\020\125\079\118\161\124\073\153\170\242\130\201\171\149\229\070\099\195\039\134\170\240\109\128\106\055\193\075\200\177\172\204\115\089\134\168\202\144\186\114\211\104\120\190\074\086\175\063\162\240\109\000\087\121\125\031\056\159\193\207\037\119\193\019\178\065\094\043\155\198\182\141\212\055\192\046\248\054\192\035\214\239\249\012\182\149\044\033\048\100\083\182\081\254\012\086\129\086\148\037\240\064\136\101\080\135\024\253\081\211\199\012\048\233\125\013\002\250\028\129\242\171\177\214\247\143\171\011\249\127\129\255\019\134\254\103\008\013\142\161\006\064\131\099\168\001\208\224\104\248\006\248\027\000\000\255\255\009\178\075\002\000\000\000\006\073\068\065\084\003\000\127\160\205\126\149\175\115\252\000\000\000\000\073\069\078\068\174\066\096\130")
        local wordmark = cachedArt("archivist_afk_wordmark_v2.png", function() return game:HttpGet(ASSETS .. "/afk-wordmark.png") end)
        local kingArt = cachedArt("archivist_afk_king_v1.png", function() return game:HttpGet(ASSETS .. "/afk-king.png") end)
        screen = Instance.new("ScreenGui")
        screen.AutoLocalize = false
        screen.Name = "ArchivistVoxSeasAFK"
        screen.IgnoreGuiInset = true
        screen.ResetOnSpawn = false
        screen.DisplayOrder = 2000010
        screen.Enabled = false
        screen.Parent = player:FindFirstChildOfClass("PlayerGui")
        local backdrop = Instance.new("Frame", screen)
        backdrop.Size = UDim2.fromScale(1, 1)
        backdrop.BackgroundColor3 = Color3.fromRGB(28, 27, 31)
        backdrop.BorderSizePixel = 0
        backdrop.Active = true
        afk.Backdrop = backdrop
        local random = Random.new(4721)
        for index = 1, mobile and 20 or 45 do
            local size = random:NextInteger(9, 18)
            local dot = Instance.new(starAsset ~= "" and "ImageLabel" or "Frame", backdrop)
            dot.Name = "Star"
            dot.Size = UDim2.fromOffset(size, size)
            dot.AnchorPoint = Vector2.new(0.5, 0.5)
            dot.BorderSizePixel = 0
            dot.Rotation = random:NextInteger(-30, 30)
            local shade = random:NextInteger(150, 205)
            local tint = Color3.fromRGB(shade, shade, shade + 6)
            if starAsset ~= "" then
                dot.BackgroundTransparency = 1
                dot.Image = starAsset
                dot.ImageColor3 = tint
                dot.ImageTransparency = random:NextNumber(0.25, 0.75)
            else
                dot.Size = UDim2.fromOffset(4, 4)
                dot.BackgroundColor3 = tint
                dot.BackgroundTransparency = random:NextNumber(0.1, 0.5)
                Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            end
            local data = {Gui = dot, X = random:NextNumber(0, 1), Phase = random:NextNumber(0, 1.2), Speed = random:NextNumber(0.012, 0.03)}
            dot.Position = UDim2.fromScale(data.X, data.Phase - 0.1)
            stars[index] = data
        end
        if kingArt ~= "" then
            local nest = Instance.new("Frame", backdrop)
            nest.Name = "King"
            nest.BackgroundTransparency = 1
            nest.AnchorPoint = Vector2.new(1, 1)
            nest.Position = UDim2.new(1, -20, 1, -12)
            nest.Size = mobile and UDim2.fromOffset(130, 117) or UDim2.fromOffset(210, 189)
            local kingImage = Instance.new("ImageLabel", nest)
            kingImage.BackgroundTransparency = 1
            kingImage.AnchorPoint = Vector2.new(0.5, 1)
            kingImage.Position = UDim2.fromScale(0.5, 1)
            kingImage.Size = UDim2.fromScale(1, 1)
            kingImage.Image = kingArt
            local zs = {}
            for index = 1, 3 do
                local z = text(nest, "Z", 28, Color3.fromRGB(168, 110, 255), Enum.Font.GothamBlack)
                z.AnchorPoint = Vector2.new(0.5, 0.5)
                z.Size = UDim2.fromOffset(30, 30)
                local edge = Instance.new("UIStroke", z)
                edge.Color = Color3.fromRGB(70, 30, 120)
                edge.Thickness = 1.5
                local scale = Instance.new("UIScale", z)
                scale.Scale = 18 / 28
                zs[index] = {Gui = z, Edge = edge, Scale = scale}
            end
            afk.King = {Gui = kingImage, Zs = zs}
        end
        local holder = Instance.new("Frame", backdrop)
        holder.AnchorPoint = Vector2.new(0.5, 0.5)
        holder.Position = UDim2.fromScale(0.5, 0.5)
        holder.Size = UDim2.fromOffset(326, 310)
        holder.BackgroundTransparency = 1
        cardScale = Instance.new("UIScale", holder)
        local banner = Instance.new("ImageLabel", holder)
        banner.Name = "Wordmark"
        banner.BackgroundTransparency = 1
        banner.AnchorPoint = Vector2.new(0.5, 0)
        banner.Position = UDim2.fromScale(0.5, 0)
        banner.Size = UDim2.fromOffset(300, 150)
        banner.ScaleType = Enum.ScaleType.Fit
        banner.Image = wordmark
        banner.Visible = wordmark ~= ""
        local idCard = Instance.new("Frame", holder)
        idCard.Name = "IdentityCard"
        idCard.Position = UDim2.fromOffset(0, 145)
        idCard.Size = UDim2.fromOffset(326, 130)
        idCard.BackgroundColor3 = Color3.fromRGB(31, 30, 35)
        idCard.BorderSizePixel = 0
        idCard.ClipsDescendants = true
        Instance.new("UICorner", idCard).CornerRadius = UDim.new(0, 12)
        local stroke = Instance.new("UIStroke", idCard)
        stroke.Color = Color3.fromRGB(58, 57, 64)
        stroke.Thickness = 1
        local avatar = Instance.new("ImageLabel", idCard)
        avatar.BackgroundColor3 = Color3.fromRGB(48, 47, 54)
        avatar.Size = UDim2.fromOffset(40, 40)
        avatar.Position = UDim2.fromOffset(18, 15)
        avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
        Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
        local owner = text(idCard, player.DisplayName, 13, nil, Enum.Font.GothamBold)
        owner.Position = UDim2.fromOffset(70, 17)
        owner.Size = UDim2.new(1, -232, 0, 18)
        owner.TextXAlignment = Enum.TextXAlignment.Left
        owner.TextTruncate = Enum.TextTruncate.AtEnd
        local username = text(idCard, "@" .. player.Name, 10, Color3.fromRGB(140, 139, 148))
        username.Position = UDim2.fromOffset(70, 36)
        username.Size = UDim2.new(1, -232, 0, 14)
        username.TextXAlignment = Enum.TextXAlignment.Left
        username.TextTruncate = Enum.TextTruncate.AtEnd
        clockLabel = text(idCard, "", 13, nil, Enum.Font.RobotoMono)
        clockLabel.RichText = true
        clockLabel.Position = UDim2.new(1, -158, 0, 25)
        clockLabel.Size = UDim2.fromOffset(140, 20)
        clockLabel.TextXAlignment = Enum.TextXAlignment.Right
        local divider = Instance.new("Frame", idCard)
        divider.Position = UDim2.fromOffset(18, 67)
        divider.Size = UDim2.new(1, -36, 0, 1)
        divider.BackgroundColor3 = Color3.fromRGB(52, 51, 58)
        divider.BorderSizePixel = 0
        local brandRow = Instance.new("Frame", idCard)
        brandRow.BackgroundTransparency = 1
        brandRow.Position = UDim2.fromOffset(0, 72)
        brandRow.Size = UDim2.new(1, 0, 0, 52)
        local brandLayout = Instance.new("UIListLayout", brandRow)
        brandLayout.FillDirection = Enum.FillDirection.Horizontal
        brandLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        brandLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        brandLayout.SortOrder = Enum.SortOrder.LayoutOrder
        brandLayout.Padding = UDim.new(0, 9)
        local left = text(brandRow, "Archivist", 14, nil, Enum.Font.GothamBold)
        left.AutomaticSize = Enum.AutomaticSize.X
        left.Size = UDim2.fromOffset(0, 26)
        left.LayoutOrder = 1
        local brandLogo = Instance.new("ImageLabel", brandRow)
        brandLogo.Name = "ArchivistLogo"
        brandLogo.BackgroundTransparency = 1
        brandLogo.Size = UDim2.fromOffset(28, 28)
        brandLogo.Image = logo or ""
        brandLogo.Visible = logo ~= nil
        brandLogo.LayoutOrder = 2
        local right = text(brandRow, "Hub", 14, nil, Enum.Font.GothamBold)
        right.AutomaticSize = Enum.AutomaticSize.X
        right.Size = UDim2.fromOffset(0, 26)
        right.LayoutOrder = 3
        local shine = Instance.new("Frame", idCard)
        shine.AnchorPoint = Vector2.new(0.5, 1)
        shine.Position = UDim2.fromScale(0.3, 1)
        shine.Size = UDim2.new(0.5, 0, 0, 2)
        shine.BackgroundColor3 = Color3.new(1, 1, 1)
        shine.BorderSizePixel = 0
        local fade = Instance.new("UIGradient", shine)
        fade.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 110, 200)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(240, 240, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 110, 200)),
        })
        fade.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(1, 1),
        })
        afk.Shine = shine
        local hint = text(holder, mobile and "Touch to return" or "Press any key to return", 10, Color3.fromRGB(130, 129, 138))
        hint.Position = UDim2.fromOffset(0, 287)
        hint.Size = UDim2.new(1, 0, 0, 16)
        afk.Typed = {owner, username, clockLabel, left, right}
        afk.Viewport = nil
        fit()
    end
    local function coreGui(show)
        local starter = game:GetService("StarterGui")
        local playerGui = player:FindFirstChildOfClass("PlayerGui")
        if not show and playerGui then
            afk.HiddenGuis = afk.HiddenGuis or {}
            for _, gui in ipairs(playerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui ~= screen and gui.Enabled then
                    gui.Enabled = false
                    afk.HiddenGuis[gui] = true
                end
            end
        elseif show and afk.HiddenGuis then
            for gui in pairs(afk.HiddenGuis) do
                if gui.Parent and not gui.Enabled then gui.Enabled = true end
            end
            afk.HiddenGuis = nil
        end
        if not show then
            afk.CoreState = afk.CoreState or {}
            for _, kind in ipairs({Enum.CoreGuiType.PlayerList, Enum.CoreGuiType.Chat}) do
                local ok, on = pcall(starter.GetCoreGuiEnabled, starter, kind)
                if afk.CoreState[kind] == nil then afk.CoreState[kind] = not ok or on end
                pcall(starter.SetCoreGuiEnabled, starter, kind, false)
            end
            pcall(starter.SetCore, starter, "TopbarEnabled", false)
        elseif afk.CoreState then
            for kind, on in pairs(afk.CoreState) do pcall(starter.SetCoreGuiEnabled, starter, kind, on) end
            pcall(starter.SetCore, starter, "TopbarEnabled", true)
            afk.CoreState = nil
        end
    end
    function afk.Wake()
        if afk.RenderConnection then afk.RenderConnection:Disconnect() afk.RenderConnection = nil end
        afk.LastInput = os.clock()
        local wasActive = afk.Active
        afk.Active = false
        applyQuiet()
        if not wasActive then return end
        if screen then screen.Enabled = false end
        coreGui(true)
        pcall(function()
            if afk.PreviousUI ~= nil then ui.ScreenGui.Enabled = afk.PreviousUI end
            if afk.PreviousLauncher ~= nil then launcherGui.Enabled = afk.PreviousLauncher end
        end)
        applyQuiet()
    end
    local function animate(now)
        local elapsed = now - afk.Started
        for _, star in ipairs(stars) do
            star.Gui.Position = UDim2.fromScale(star.X, (star.Phase + elapsed * star.Speed) % 1.2 - 0.1)
        end
        if afk.Shine then afk.Shine.Position = UDim2.fromScale(elapsed * 0.35 % 1.8 - 0.4, 1) end
        local sleeper = afk.King
        if sleeper then
            local breath = math.sin(elapsed * 1.6)
            sleeper.Gui.Size = UDim2.fromScale(1 + breath * 0.012, 1 - breath * 0.018)
            sleeper.Gui.Rotation = math.sin(elapsed * 0.8) * 1.5
            for index, z in ipairs(sleeper.Zs) do
                local t = (elapsed / 3.6 + index / 3) % 1
                z.Gui.Position = UDim2.fromScale(0.68 + t * 0.22 + math.sin(t * 9) * 0.02, 0.36 - t * 0.42)
                z.Scale.Scale = (12 + t * 16) / 28
                z.Gui.Rotation = -12 + t * 20
                local fading = t < 0.15 and 1 - t / 0.15 or (t > 0.7 and (t - 0.7) / 0.3 or 0)
                z.Gui.TextTransparency = fading
                z.Edge.Transparency = fading
            end
        end
    end
    function afk.Begin()
        if afk.Active or afk.Stopped or not Hub.Alive then return end
        build()
        afk.Started = os.clock()
        afk.Active = true
        if afk.RenderConnection then afk.RenderConnection:Disconnect() end
        afk.RenderConnection = RunService.RenderStepped:Connect(function()
            if Hub.Alive and afk.Active then animate(os.clock()) end
        end)
        afk.PreviousUI, afk.PreviousLauncher = nil, nil
        afk.OpenRun = (afk.OpenRun or 0) + 1
        local opening = afk.OpenRun
        for _, star in ipairs(stars) do star.Gui.Position = UDim2.fromScale(star.X, star.Phase - 0.1) end
        afk.TypeRun = (afk.TypeRun or 0) + 1
        local run = afk.TypeRun
        for _, label in ipairs(afk.Typed or {}) do label.MaxVisibleGraphemes = 0 end
        task.spawn(function()
            task.wait(0.25)
            for _, label in ipairs(afk.Typed or {}) do
                local count = utf8.len(label.ContentText) or #label.ContentText
                for index = 1, count do
                    if afk.TypeRun ~= run or not afk.Active then return end
                    label.MaxVisibleGraphemes = index
                    task.wait(0.045)
                end
                label.MaxVisibleGraphemes = -1
                task.wait(0.08)
            end
        end)
        afk.Backdrop.BackgroundTransparency = 1
        screen.Enabled = true
        TweenService:Create(afk.Backdrop, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
        task.delay(0.4, function()
            if not afk.Active or afk.OpenRun ~= opening then return end
            pcall(function()
                afk.PreviousUI = ui.ScreenGui.Enabled
                afk.PreviousLauncher = launcherGui.Enabled
                ui.ScreenGui.Enabled = false
                launcherGui.Enabled = false
            end)
            coreGui(false)
            applyQuiet()
        end)
    end
    function afk.Stop()
        afk.Wake()
        afk.Stopped = true
        table.clear(afk.Held)
        if screen then screen:Destroy() screen = nil end
        table.clear(stars)
    end
    table.insert(Hub.Connections, UserInput.InputBegan:Connect(function(input)
        -- (antes: local humanInput aparte; se movio inline para liberar un registro)
        if input.KeyCode == Enum.KeyCode.F15 or os.clock() < (Hub.AFKIgnoreInputUntil or 0) then return end
        local kind = input.UserInputType
        if kind == Enum.UserInputType.Keyboard or kind == Enum.UserInputType.Touch
            or tostring(kind):find("MouseButton") or tostring(kind):find("Gamepad") then afk.Held[input] = true end
        afk.Wake()
    end))
    table.insert(Hub.Connections, UserInput.InputEnded:Connect(function(input) afk.Held[input] = nil end))
    table.insert(Hub.Connections, UserInput.InputChanged:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F15 or os.clock() < (Hub.AFKIgnoreInputUntil or 0) then return end
        local kind = input.UserInputType
        if (kind == Enum.UserInputType.MouseMovement and input.Delta.Magnitude >= 2)
            or kind == Enum.UserInputType.MouseWheel
            or kind == Enum.UserInputType.Touch
            or (tostring(kind):find("Gamepad") and input.Position.Magnitude > 0.15) then afk.Wake() end
    end))
    task.delay(6, function() if not afk.Stopped and Hub.Alive then pcall(build) end end)
    task.spawn(function()
        while Hub.Alive and not afk.Stopped do
            if afk.Active and (not screen or not screen.Parent or not screen.Enabled) then
                afk.Wake()
            elseif not afk.Active and Hub.RenderingSuspended then
                applyQuiet()
            end
            local now = os.clock()
            if next(afk.Held) then afk.LastInput = now end
            if S.AFKScreen and not afk.Active and now - afk.LastInput >= 30 then pcall(afk.Begin) end
            if afk.Active and clockLabel then
                pcall(fit)
                local elapsed = math.max(0, math.floor(now - afk.Started))
                local unit = '<font size="9" color="#8C8B94">%s</font>'
                clockLabel.Text = string.format("%02d" .. unit .. " %02d" .. unit .. " %02d" .. unit .. " %02d" .. unit,
                    elapsed // 86400, "d", elapsed // 3600 % 24, "h", elapsed // 60 % 60, "m", elapsed % 60, "s")
            end
            task.wait(0.5)
        end
    end)
end


-- Bindings
local function bindToggle(id, key)
    Toggles[id]:OnChanged(function()
        S[key] = Toggles[id].Value == true
        if key == "AntiDie" and not S[key] then Hub.CancelRecovery() end
        if key == "AutoStory" and S[key] then Hub.StorySignature, Hub.StoryProgressAt, Hub.StoryBlocked = nil, nil, nil end
        if key == "AutoStory" and not S[key] and Hub.CancelStoryMotion then Hub.CancelStoryMotion() end
        if S[key] and (key == "Farm" or key == "FarmMob" or key == "AutoStory") then
            for _, other in ipairs({"Farm", "FarmMob", "AutoStory"}) do
                if other ~= key then
                    S[other] = false
                    local otherToggle = Toggles["ArchivistVS" .. other]
                    if otherToggle and otherToggle.Value then otherToggle:SetValue(false) end
                end
            end
        end
        save()
    end)
end
bindToggle("ArchivistVSAntiAFK", "AntiAFK")
bindToggle("ArchivistVSAutoReconnect", "AutoReconnect")
Toggles.ArchivistVSAutoLoad:OnChanged(function()
    S.AutoLoad = Toggles.ArchivistVSAutoLoad.Value == true
    save()
    if S.AutoLoad then task.spawn(Hub.QueueLoad) end
end)
Toggles.ArchivistVSAFKScreen:OnChanged(function()
    S.AFKScreen = Toggles.ArchivistVSAFKScreen.Value == true
    afk.Wake()
    save()
end)

-- Every farming switch added later goes here so Reset Settings and F8 turn it off.
Hub.AutoToggles = {}
for _, key in ipairs({"AutoCodes", "AutoClick", "AutoStory", "AutoGeppo", "AutoSoru", "AutoLearnSense", "AutoLearnArmor", "AutoVoxArmor", "AutoVoxSense", "TrainVoxSense", "TrainVoxArmor", "AutoAccessories"}) do
    bindToggle("ArchivistVS" .. key, key)
    table.insert(Hub.AutoToggles, "ArchivistVS" .. key)
end
function Hub.ResetSettings()
    for _, id in ipairs(Hub.AutoToggles) do if Toggles[id] then Toggles[id]:SetValue(false) end end
    Toggles.ArchivistVSAntiAFK:SetValue(DEFAULTS.AntiAFK)
    Toggles.ArchivistVSAFKScreen:SetValue(DEFAULTS.AFKScreen)
    save()
    ui:Notify({Title = "Settings", Description = "Settings reset", Time = 3})
end

function Hub:Unload()
    if not self.Alive then return end
    self.Alive = false
    if self.CancelStoryMotion then self.CancelStoryMotion() end
    if self.Fruit then pcall(self.Fruit.Stop) end
    if self.ClearFruitESP then pcall(self.ClearFruitESP) end
    if self.StoryHoldContext and self.NativeHold then pcall(self.NativeHold.Cancel) end
    if self.StoryConverse then pcall(self.StoryConverse.End, self.StoryConverse) end
    self.SkillAimTarget, self.SkillAimUntil = nil, nil
    if self.AimFunctions and self.AimFunctions.Mouse == self.MouseAim then
        self.AimFunctions.Mouse = self.OriginalMouseAim
    end
    if env.ARCHIVIST_VS == self then env.ARCHIVIST_VS = nil end
    pcall(afk.Stop)
    for _, connection in ipairs(self.Connections) do pcall(function() connection:Disconnect() end) end
    pcall(function() if self.PoseProbe then self.PoseProbe:Destroy() self.PoseProbe = nil end end)
    pcall(function() self.LauncherGui:Destroy() end)
    pcall(function() ui:Unload() end)
end

table.insert(Hub.Connections, UserInput.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F8 and not UserInput:GetFocusedTextBox() then
        for _, id in ipairs(Hub.AutoToggles) do if Toggles[id] then Toggles[id]:SetValue(false) end end
    end
end))

bindToggle("ArchivistVSFarmMob", "FarmMob")
bindToggle("ArchivistVSAutoStats", "AutoStats")
table.insert(Hub.AutoToggles, "ArchivistVSFarmMob")
table.insert(Hub.AutoToggles, "ArchivistVSAutoStats")
Options.ArchivistVSWeapon:OnChanged(function() S.Weapon = Options.ArchivistVSWeapon.Value save() end)
Options.ArchivistVSFarmMethod:OnChanged(function() S.FarmMethod = Options.ArchivistVSFarmMethod.Value or "Teleport" save() end)
for index, slot in ipairs(Hub.PrioritySlots) do
    Options["ArchivistVSPriority" .. slot]:OnChanged(function()
        local chosen = Options["ArchivistVSPriority" .. slot].Value
        local old = S.Priority[index]
        if not chosen or chosen == old then return end
        -- Swap with the slot that held it, so every mode keeps one place.
        local from = table.find(S.Priority, chosen)
        S.Priority[index] = chosen
        if from then
            S.Priority[from] = old
            local other = Options["ArchivistVSPriority" .. Hub.PrioritySlots[from]]
            if other and other.Value ~= old then other:SetValue(old) end
        end
        save()
    end)
end
Options.ArchivistVSStatList:OnChanged(function()
    local value = Options.ArchivistVSStatList.Value or {}
    local list = {}
    for _, name in ipairs(S.StatList) do
        if value[name] then table.insert(list, name) end
    end
    for _, name in ipairs(Hub.StatNames) do
        if value[name] and not table.find(list, name) then table.insert(list, name) end
    end
    S.StatList = list
    for _, name in ipairs(Hub.StatNames) do
        Options["ArchivistVSStatCap" .. name]:SetVisible(value[name] == true)
    end
    save()
end)
for _, name in ipairs(Hub.StatNames) do
    Options["ArchivistVSStatCap" .. name]:OnChanged(function()
        S.StatCap[name] = math.floor(tonumber(Options["ArchivistVSStatCap" .. name].Value) or 500)
        save()
    end)
end
Options.ArchivistVSSkills:OnChanged(function()
    S.Skills = {}
    for key, on in pairs(Options.ArchivistVSSkills.Value) do if on then S.Skills[key] = true end end
    save()
end)
Options.ArchivistVSMobs:OnChanged(function()
    S.Mobs = {}
    for name, on in pairs(Options.ArchivistVSMobs.Value) do if on then S.Mobs[name] = true end end
    save()
end)
Options.ArchivistVSMobIsland:OnChanged(function()
    if S.MobIsland == Options.ArchivistVSMobIsland.Value then return end
    S.MobIsland, S.Mobs = Options.ArchivistVSMobIsland.Value, {}
    Options.ArchivistVSMobs:SetValues(Hub.MobsOf(S.MobIsland))
    Options.ArchivistVSMobs:SetValue({})
    save()
end)
-- Weapon type of a backpack tool, from the game's own tool data.
function Hub.ToolType(tool)
    if tool.Name == "Combat" then return "Melee" end
    local ok, info = pcall(function() return MainModules.ToolsInfo:Get(tool.Name, true) end)
    local kind = ok and type(info) == "table" and (info.ToolType or info.Type) or tool:GetAttribute("ToolType")
    if kind == "DevilFruit" then return "Fruit" end
    return kind and tostring(kind) or "Melee"
end
-- Free stat points, computed like the game's stats menu.
function Hub.FreePoints()
    local BF = MainModules.BalancingFeatures
    return BF.CalculateStatPoints(Hub.Data().Statistics.Level, BF:GetDistributedPoints(player))
end
function Hub.StatPlan()
    local stats = Hub.Data().Statistics
    local cap = tonumber(MainModules.BalancingFeatures.MaxLevel) or 500
    local free = math.floor(tonumber(Hub.FreePoints()) or 0)
    local plan, spent, lines, currents = {}, 0, {}, {}
    for _, name in ipairs(Hub.StatNames) do currents[name] = tonumber(stats[name]) or 1 end
    for index, name in ipairs(S.StatList) do
        local current = currents[name]
        local limit = math.min(tonumber(S.StatCap[name]) or cap, cap)
        local give = math.max(0, math.min(limit - current, free - spent))
        if give > 0 then plan[name], spent = give, spent + give end
        local tail = current >= cap and "max" or current >= limit and "reached, raise target"
            or give > 0 and ("+" .. give) or "waiting for points"
        table.insert(lines, index .. ". " .. name .. "  " .. current .. " / " .. limit .. "  " .. tail)
    end
    return plan, spent, free, lines, currents
end
task.spawn(function()
    while Hub.Alive do
        if S.AutoStats and not Hub.Paused and Elysium then
            local ok, plan, spent = pcall(Hub.StatPlan)
            if ok and spent > 0 then
                Elysium.Network:FireServer("StatisticsData", "UpgradeStats", plan)
            end
        end
        task.wait(2)
    end
end)
-- Only automatic skill casts use the farm target as their native mouse aim.
-- Manual aim is delegated unchanged, and the original function is restored on unload.
Hub.SkillNext = {}
Hub.SkillInfo = require(RS.Modules.Skills)
Hub.SkillCastingAPI = require(RS.Elysium.Modules.Library.Casting).IsClient
Hub.AimFunctions = require(RS.Modules.Essentials.PlayerSystem).IsClient.Utils.Functions
Hub.OriginalMouseAim = Hub.AimFunctions.Mouse
Hub.MouseAim = function(...)
    local target = Hub.SkillAimTarget
    local part = target and target.Parent and target:FindFirstChild("HumanoidRootPart")
    if Hub.Alive and Hub.FarmOn and Hub.FarmOn() and part and target == Hub.FarmTarget
        and os.clock() < (Hub.SkillAimUntil or 0) and Hub.HP(target) > 0
        and target:GetAttribute("Dead") ~= true then
        return CFrame.new(part.Position), workspace.CurrentCamera.CFrame
    end
    return Hub.OriginalMouseAim(...)
end
Hub.AimFunctions.Mouse = Hub.MouseAim
function Hub.UseSkills()
    for _, key in ipairs({"Z", "X", "C", "V"}) do
        if not Hub.FarmOn() then break end
        local target = Hub.FarmTarget
        local char = player.Character
        local held = char and char:FindFirstChildOfClass("Tool")
        local skill = held and Hub.SkillInfo:GetByKey(held.Name, key)
        local part = target and target.Parent and target:FindFirstChild("HumanoidRootPart")
        if S.Skills[key] and skill and held and part and Hub.HP(target) > 0
            and target:GetAttribute("Render") ~= false
            and os.clock() >= (Hub.SkillNext[key] or 0) then
            local states = Elysium.States.Player()
            if states:IsInactive(skill.Id .. "_Cooldown") and MainModules.SkillUtils.ValidateSkill(player, skill) then
                Hub.SkillAimTarget, Hub.SkillAimUntil = target, os.clock() + 1.5
                -- Use the same native Call/Begin/End/Release sequence without
                -- depending on keyboard focus. End reads our target-scoped aim.
                Hub.SkillNext[key] = os.clock() + (skill.Settings.Cooldown or 2) + 0.25
                local callResult
                if skill.Client.Call then callResult = skill.Client.Call() end
                Elysium.Network:FireServer("Elysium_Casting", "Begin", "Skill", skill.Id, callResult)
                task.wait(math.max(0.1, skill.Settings.MinTime or 0.1) + 0.12)
                if not Hub.FarmOn() or target ~= Hub.FarmTarget or not target.Parent or Hub.HP(target) <= 0 then
                    Elysium.Network:FireServer("Elysium_Casting", "Cancel", "Skill", skill.Id)
                    break
                end
                local cast = Hub.SkillCastingAPI.GetActive(char, "Skill", skill.Id)
                local endResult = skill.Client.End and skill.Client.End(cast) or {}
                Elysium.Network:FireServer("Elysium_Casting", "Release", "Skill", skill.Id, endResult)
                Hub.LastSkill = {Id = skill.Id, Target = target.Name, At = os.clock()}
                task.wait(0.65)
            end
        end
    end
end
-- Farm: TP only, held above the enemy (measured: hits land and enemies do not reach you).
-- Long trips use measured smooth travel; short hops remain as a slower fallback.
bindToggle("ArchivistVSFarm", "Farm")
bindToggle("ArchivistVSAntiDie", "AntiDie")
table.insert(Hub.AutoToggles, "ArchivistVSFarm")
Hub.Skip = {}
function Hub.Root()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart"), char and char:FindFirstChildOfClass("Humanoid")
end
function Hub.HP(model)
    local h = model:FindFirstChildOfClass("Humanoid")
    return h and tonumber(h:GetAttribute("HandlerHealth")) or 0
end
function Hub.Data() return Elysium.DataStore:Get() end
-- Story engine runs for Auto Story and for Vox / Soru quests that borrow it.
Hub.StorySearchSpots = {Talk_RegistrarFound_VAL = {Zone = "Spot_RegistrarBar_VAL", Npc = "Coliseum Registrar"}}
function Hub.StoryOn() return S.AutoStory or Hub.VoxQuest ~= nil end
function Hub.FarmOn() return Hub.Alive and (S.Farm or S.FarmMob or S.AutoStory or S.AutoFish or S.TrainVoxSense or S.TrainVoxArmor or S.AutoSoru or S.AutoLearnSense or S.AutoLearnArmor) and not Hub.Paused and Elysium ~= nil end
function Hub.Equip(hum)
    local char = player.Character
    if not char then return end
    local held = char:FindFirstChildOfClass("Tool")
    local weapon = Hub.WeaponOverride or S.Weapon
    if held and Hub.ToolType(held) == weapon then return end
    local fallback
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            if Hub.ToolType(tool) == weapon then hum:EquipTool(tool) return end
            if tool.Name == "Combat" then fallback = tool end
        end
    end
    if not held and fallback then hum:EquipTool(fallback) end
end
-- Standing pose above the enemy: upright, a little behind, facing it (not upside down).
-- A roof or wall between the spot and the enemy blocks the hits (Rovan's hut):
-- then the spot drops to the enemy's side, checked again every half second.
Hub.PoseRay = RaycastParams.new()
Hub.PoseRay.FilterType = Enum.RaycastFilterType.Exclude
Hub.PoseRay.RespectCanCollide = true
Hub.PoseOverlap = OverlapParams.new()
Hub.PoseOverlap.FilterType = Enum.RaycastFilterType.Exclude
Hub.PoseLow = setmetatable({}, {__mode = "k"})
function Hub.PoseBlocked(spot, enemy, target)
    Hub.PoseRay.FilterDescendantsInstances = {player.Character, workspace.Playability.Enemys}
    local hit = workspace:Raycast(spot, enemy - spot, Hub.PoseRay)
    return hit ~= nil and not hit.Instance:IsDescendantOf(target)
end
function Hub.PoseFits(spot, size)
    size = size or Vector3.new(3, 5, 3)
    Hub.PoseOverlap.FilterDescendantsInstances = {player.Character, workspace.Playability.Enemys, workspace.IgnoreList}
    local broadHit = false
    for _, part in ipairs(workspace:GetPartBoundsInBox(CFrame.new(spot), size, Hub.PoseOverlap)) do
        if part.CanCollide then broadHit = true break end
    end
    if not broadHit then return true end
    -- Rock and cave mesh bounds contain empty space; confirm actual occupied geometry.
    local probe = Hub.PoseProbe
    if not probe or not probe.Parent then
        probe = Instance.new("Part")
        probe.Name = "ArchivistVoxPoseProbe"
        probe.Anchored, probe.CanCollide, probe.CanTouch, probe.CanQuery = true, false, false, false
        probe.Transparency, probe.Archivable = 1, false
        probe.Parent = workspace.CurrentCamera or workspace
        Hub.PoseProbe = probe
    end
    probe.Size, probe.CFrame = size, CFrame.new(spot)
    for _, part in ipairs(workspace:GetPartsInPart(probe, Hub.PoseOverlap)) do
        if part.CanCollide then return false end
    end
    return true
end
function Hub.FarmPose(enemy, from, target)
    local flat = Vector3.new(from.X - enemy.X, 0, from.Z - enemy.Z)
    flat = flat.Magnitude > 0.1 and flat.Unit or Vector3.new(0, 0, 1)
    local boss = target and target:GetAttribute("IsBoss") == true
    local height, back = boss and 8 or (tonumber(S.Height) or 7), boss and 0.5 or (Hub.PoseBack or 4)
    -- YDiff: the most height the enemy accepts; above it the server releases the target and ignores hits.
    local ydiff = target and tonumber(target:GetAttribute("YDiff"))
    local cap = ydiff and math.max(1.5, ydiff - 1.5) or math.huge
    height = math.min(height, cap)
    local offset = flat * back + Vector3.new(0, height, 0)
    if target then
        local memo = Hub.PoseLow[target]
        if not memo or not memo.Offset or os.clock() - memo.At > 0.5 then
            local candidates = {{height, back}, {math.min(7, cap), 4}, {1.5, 6}}
            local chosen, low
            for _, pair in ipairs(candidates) do
                for turn = 0, 7 do
                    local angle = turn * math.pi / 4
                    local direction = Vector3.new(flat.X * math.cos(angle) - flat.Z * math.sin(angle), 0,
                        flat.X * math.sin(angle) + flat.Z * math.cos(angle))
                    local candidate = direction * pair[2] + Vector3.new(0, pair[1], 0)
                    local spot = enemy + candidate
                    if not Hub.PoseBlocked(spot, enemy, target) and Hub.PoseFits(spot) then
                        chosen, low = candidate, pair[1] < 4
                        break
                    end
                end
                if chosen then break end
            end
            -- No free spot: stay right over the enemy instead of keeping a far (sky) offset.
            memo = {At = os.clock(), Offset = chosen or (flat * back + Vector3.new(0, height, 0)), Low = low == true}
            Hub.PoseLow[target] = memo
        end
        offset = memo.Offset
    end
    local spot = enemy + offset
    return CFrame.lookAt(spot, Vector3.new(enemy.X, spot.Y, enemy.Z))
end
-- Movement method: circles behind the enemy at its height. Enemy melee hitboxes only
-- reach in front of it (EnemysInfo Assembler combos), so the spot follows its back as it turns.
-- Skill telegraphs (red parts in Camera.BossTelegraphs) push the spot out of the marked area.
function Hub.TelegraphHit(pos)
    local camera = workspace.CurrentCamera
    local folder = camera and camera:FindFirstChild("BossTelegraphs")
    if not folder then return false end
    local now = os.clock()
    local cache = Hub.TelegraphCache
    if not cache or cache.Folder ~= folder or now - cache.At >= 0.1 then
        cache = {Folder = folder, At = now, Items = folder:GetDescendants()}
        Hub.TelegraphCache = cache
    end
    local margin = 4
    for _, item in ipairs(cache.Items) do
        if item:IsA("BasePart") and item.Transparency < 1 then
            local p, size = item.CFrame:PointToObjectSpace(pos), item.Size
            if item.Shape == Enum.PartType.Cylinder then
                -- Rotated so the cylinder axis (X) is vertical.
                if math.abs(p.X) < size.X / 2 + 15 and math.sqrt(p.Y * p.Y + p.Z * p.Z) < math.max(size.Y, size.Z) / 2 + margin then return true end
            elseif item.Shape == Enum.PartType.Ball then
                if p.Magnitude < size.X / 2 + margin then return true end
            elseif math.abs(p.X) < size.X / 2 + margin and math.abs(p.Z) < size.Z / 2 + margin and math.abs(p.Y) < size.Y / 2 + 15 then
                return true
            end
        elseif item:IsA("CylinderHandleAdornment") and item.Visible ~= false then
            local adornee = item.Adornee
            local base = adornee and adornee:IsA("BasePart") and adornee.CFrame or CFrame.identity
            local center = (base * item.CFrame).Position
            local flat = Vector3.new(pos.X - center.X, 0, pos.Z - center.Z).Magnitude
            if math.abs(pos.Y - center.Y) < 20 and flat < item.Radius + margin and flat > (item.InnerRadius or 0) - margin then return true end
        end
    end
    return false
end
Hub.MoveRadius = 6
function Hub.PoseGrounded(spot)
    Hub.GroundRay = Hub.GroundRay or RaycastParams.new()
    local params = Hub.GroundRay
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {player.Character, workspace.Playability.Enemys, workspace.IgnoreList}
    params.RespectCanCollide = true
    local hit = workspace:Raycast(spot + Vector3.new(0, 2, 0), Vector3.new(0, -10, 0), params)
    return hit and hit.Normal.Y > 0.6
end
Hub.MovePlans = setmetatable({}, {__mode = "k"})
function Hub.RenderMovePlan(enemy, plan, now)
    if not plan.Offset then return nil end
    local offset = plan.From:Lerp(plan.Offset, math.clamp((now - plan.At) / 0.08, 0, 1))
    plan.Shown = offset
    local spot = enemy + offset
    return CFrame.lookAt(spot, Vector3.new(enemy.X, spot.Y, enemy.Z))
end
function Hub.MovePose(enemy, from, target)
    local now = os.clock()
    local plan = Hub.MovePlans[target]
    if plan and now - plan.At < 0.08 then return Hub.RenderMovePlan(enemy, plan, now) end
    local look = target.HumanoidRootPart.CFrame.LookVector
    look = Vector3.new(look.X, 0, look.Z)
    look = look.Magnitude > 0.1 and look.Unit or Vector3.new(0, 0, 1)
    local back = -look
    local sweep = math.sin(os.clock() * math.pi * 2 / 1.6) * math.rad(50)
    local function at(angle, radius)
        local c, s = math.cos(angle), math.sin(angle)
        return enemy + Vector3.new(back.X * c - back.Z * s, 0, back.X * s + back.Z * c) * radius
    end
    local function ok(spot)
        -- Torso-sized check only: at enemy height the legs touch the floor.
        return not Hub.TelegraphHit(spot) and Hub.PoseGrounded(spot) and Hub.PoseFits(spot + Vector3.new(0, 1, 0), Vector3.new(2, 2, 2))
            and not Hub.PoseBlocked(spot, enemy, target)
    end
    local spot = at(sweep, Hub.MoveRadius)
    if not ok(spot) then
        spot = nil
        Hub.MoveDodging = Hub.TelegraphHit(at(sweep, Hub.MoveRadius))
        for _, radius in ipairs({Hub.MoveRadius, 10, 16, 24, 34}) do
            for _, turn in ipairs({0, 1, -1, 2, -2, 3}) do
                local candidate = at(sweep + turn * math.rad(60), radius)
                if ok(candidate) then spot = candidate break end
            end
            if spot then break end
        end
    else
        Hub.MoveDodging = false
    end
    local offset = spot and spot - enemy
    local previous = plan and plan.Shown or offset
    if offset and previous and Hub.ClearFarmLine and not Hub.ClearFarmLine(enemy + previous, enemy + offset) then previous = offset end
    plan = {At = now, Offset = offset, From = previous, Shown = offset}
    Hub.MovePlans[target] = plan
    return Hub.RenderMovePlan(enemy, plan, now)
end
-- Hold the character still: the target position is re-applied every frame.
table.insert(Hub.Connections, RunService.Heartbeat:Connect(function()
    local spot = Hub.HoldAt
    if not spot or not Hub.FarmOn() then return end
    -- Interaction animations (lever pulls) align the character themselves.
    if os.clock() < (Hub.HoldPauseUntil or 0) then return end
    local root, hum = Hub.Root()
    if not root or not hum or hum.Health <= 0 then Hub.HoldAt, Hub.FarmTarget = nil, nil return end
    if S.AutoStory and root.Anchored then
        Hub.HoldAt, Hub.FarmTarget = nil, nil
        return
    end
    local target = Hub.FarmTarget
    if target and target.Parent and target:FindFirstChild("HumanoidRootPart") then
        local enemy = target.HumanoidRootPart.Position
        -- Bosses always use Movement: circling behind dodges their skills instead of tanking them.
        local dodge = S.FarmMethod == "Movement" or target:GetAttribute("IsBoss") == true
        spot = dodge and Hub.MovePose(enemy, root.Position, target)
            or Hub.FarmPose(enemy, root.Position, target)
        Hub.HoldAt = spot
    end
    root.CFrame = spot
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
end))
-- Hold a neutral standing pose locally during combat; restore animator control
-- automatically when farming stops. The attack remote keeps its measured cadence.
Hub.StandingJoints = {}
function Hub.CacheStandingJoints(char)
    table.clear(Hub.StandingJoints)
    for _, joint in ipairs(char:GetDescendants()) do
        if joint:IsA("Motor6D") then
            table.insert(Hub.StandingJoints, joint)
        end
    end
end
if player.Character then Hub.CacheStandingJoints(player.Character) end
table.insert(Hub.Connections, player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if Hub.Alive and player.Character == char then Hub.CacheStandingJoints(char) end
end))
table.insert(Hub.Connections, RunService.PreSimulation:Connect(function()
    if not Hub.HoldAt or not Hub.FarmTarget or not Hub.FarmOn() then return end
    for _, joint in ipairs(Hub.StandingJoints) do
        if joint.Parent then joint.Transform = CFrame.identity end
    end
end))
-- Smooth travel measured on a full Solmar/Forbidden route. Server acceptance
-- is checked at each destination; slower travel remains available on rejection.
Hub.TravelSpeed = 800
function Hub.TrackTravel(goal, server)
    if not S.AutoStory or typeof(server) ~= "Vector3" then return end
    local distance = (server - goal).Magnitude
    local progress = Hub.TravelProgress
    if not progress or (progress.Goal - goal).Magnitude > 1 then
        Hub.TravelProgress = {Goal = goal, Distance = distance}
    elseif distance + 20 < progress.Distance then
        progress.Distance, Hub.StoryProgressAt = distance, os.clock()
    end
end
function Hub.TravelSegment(goal, speed)
    local root, hum = Hub.Root()
    if not root or not hum or hum.Health <= 0 or root.Anchored then return false end
    local from = root.Position
    local distance = (goal - from).Magnitude
    local duration, started = distance / speed, os.clock()
    local flat = Vector3.new(goal.X - from.X, 0, goal.Z - from.Z)
    local facing = flat.Magnitude > 0.1 and flat.Unit or root.CFrame.LookVector
    local badSince
    repeat
        if not Hub.FarmOn() or not root.Parent or hum.Health <= 0 or root.Anchored then Hub.HoldAt = nil return false end
        local alpha = duration > 0 and math.min(1, (os.clock() - started) / duration) or 1
        local position = from:Lerp(goal, alpha)
        Hub.HoldAt = CFrame.lookAt(position, position + facing)
        local server = player:GetAttribute("ServerPosition")
        Hub.TrackTravel(goal, server)
        if server and (root.Position - server).Magnitude > math.max(800, speed) then
            badSince = badSince or os.clock()
            if os.clock() - badSince > 0.8 then
                Hub.HoldAt = CFrame.new(server)
                task.wait(0.3)
                return false
            end
        else
            badSince = nil
        end
        task.wait()
    until os.clock() - started >= duration
    Hub.HoldAt = CFrame.lookAt(goal, goal + facing)
    task.wait(0.65)
    local server = player:GetAttribute("ServerPosition")
    if server and (server - goal).Magnitude > 30 then
        Hub.HoldAt = CFrame.new(server)
        task.wait(0.3)
        return false
    end
    return true
end
function Hub.Hop(goal)
    local root = Hub.Root()
    if not root or not Hub.FarmOn() then return false end
    Hub.FarmTarget = nil
    -- Markers sit on the floor (NPC feet): a root held there sinks in and cannot walk.
    do
        local _, hum = Hub.Root()
        local ray = RaycastParams.new()
        ray.FilterType = Enum.RaycastFilterType.Exclude
        ray.FilterDescendantsInstances = {player.Character, workspace:FindFirstChild("IgnoreList")}
        local floor = hum and workspace:Raycast(goal + Vector3.new(0, 3, 0), Vector3.new(0, -8, 0), ray)
        local stand = floor and floor.Position.Y + hum.HipHeight + root.Size.Y * 0.5 + 0.2
        if stand and goal.Y < stand then goal = Vector3.new(goal.X, stand, goal.Z) end
    end
    if (goal - root.Position).Magnitude > 600 then
        -- Clear nearby cliffs before crossing the sea, then descend at the island.
        -- Capped so repeated failed trips never ratchet the character into the sky.
        local altitude = math.min(math.max(root.Position.Y, goal.Y) + 60, goal.Y + 250)
        for _, waypoint in ipairs({Vector3.new(root.Position.X, altitude, root.Position.Z),
            Vector3.new(goal.X, altitude, goal.Z), goal}) do
            if not Hub.TravelSegment(waypoint, Hub.TravelSpeed) then
                local currentRoot = Hub.Root()
                if not Hub.FarmOn() or not currentRoot or currentRoot.Anchored then return false end
                Hub.TravelSpeed = 400
                if not Hub.TravelSegment(waypoint, 400) then
                    local currentRoot = Hub.Root()
                    break
                end
            end
        end
        root = Hub.Root()
        if root and (root.Position - goal).Magnitude < 30 then return true end
    end
    -- Short hops also cover a slower fallback when a server rejects smooth travel.
    while Hub.FarmOn() do
        root = Hub.Root()
        if not root or root.Anchored then Hub.HoldAt = nil return false end
        local offset = goal - root.Position
        if offset.Magnitude <= 200 then
            Hub.HoldAt = CFrame.new(goal)
            task.wait(0.35)
            if root.Anchored then Hub.HoldAt = nil return false end
            -- The server position lags a little; give it time before calling it a rejection.
            local server, waitUntil = player:GetAttribute("ServerPosition"), os.clock() + 1.2
            while server and (server - goal).Magnitude > 30 and os.clock() < waitUntil do
                task.wait(0.15)
                server = player:GetAttribute("ServerPosition")
            end
            if server and (server - goal).Magnitude > 30 then
                Hub.HoldAt = CFrame.new(server)
                Hub.Rejections = (Hub.Rejections or 0) + 1
                if S.AutoStory and Hub.Rejections >= 4 then Hub.Rejections = 0 Hub.StopStory("Travel rejected by server") end
                return false
            end
            Hub.Rejections = 0
            return true
        end
        Hub.HoldAt = CFrame.new(root.Position + offset.Unit * 200)
        task.wait(0.9)
        Hub.TrackTravel(goal, player:GetAttribute("ServerPosition"))
    end
    return false
end
-- Cache the level lookup, and bound/yield scans so malformed data cannot stall a frame.
function Hub.BestQuest(level)
    local cached = Hub.BestQuestCache
    if cached and cached.Level == level and os.clock() - cached.At < 2 then return cached.Key end
    local best, bestLevel, count = nil, -1, 0
    for key, quest in pairs(MainModules.QuestsInfo) do
        count += 1
        if count > 4096 then break end
        if count % 64 == 0 then task.wait() end
        local minimum = type(quest) == "table" and tonumber(quest.MinLevel) or 0
        minimum = minimum or 0
        if type(quest) == "table" and quest.GrindingQuest and minimum <= level and minimum > bestLevel then
            best, bestLevel = key, minimum
        end
    end
    Hub.BestQuestCache = {Level = level, Key = best, At = os.clock()}
    return best
end
-- Enemy names still needed by the active grinding quest; nil when there is none.
function Hub.QuestWants()
    local actives = Hub.Data().Quests.Actives or {}
    for key, progress in pairs(actives) do
        local quest = MainModules.QuestsInfo[key]
        if type(quest) == "table" and quest.GrindingQuest then
            local wants, lines = {}, {}
            for index, sub in ipairs(quest.SubQuests or {}) do
                for slot, objective in ipairs(sub.Objectives or {}) do
                    local name = tostring(objective.ObjectiveID or ""):gsub("^Defeat_", "")
                    local done = tonumber(progress[index] and progress[index][slot]) or 0
                    if done < (objective.Goal or 0) then wants[name] = true end
                    table.insert(lines, name .. "  " .. done .. " / " .. tostring(objective.Goal))
                end
            end
            return key, wants, lines
        end
    end
    return nil
end
function Hub.MobsSet()
    local set = {}
    for _, name in ipairs(Hub.MobsOf(S.MobIsland)) do set[name] = true end
    return set
end
function Hub.FarmCandidates(wants)
    local names = {}
    for name, selected in pairs(wants or {}) do if selected then table.insert(names, name) end end
    table.sort(names)
    local signature = wants and table.concat(names, "|") or "*"
    local folder = workspace.Playability.Enemys
    local cache = Hub.FarmCandidateCache
    if cache and cache.Signature == signature and cache.Folder == folder and os.clock() - cache.At < 0.5 then return cache.Items end
    local items = {}
    if not wants or #names > 0 then
        for _, model in ipairs(folder:GetChildren()) do
            local name = tostring(model:GetAttribute("OriginalName") or model.Name)
            if (not wants or wants[name]) and not name:find("History") and model:GetAttribute("IsBoss") ~= true then table.insert(items, model) end
        end
    end
    Hub.FarmCandidateCache = {Signature = signature, Folder = folder, At = os.clock(), Items = items}
    return items
end
function Hub.PickEnemy(wants, root)
    local best, bestDistance, sleeper, sleeperDistance
    for _, model in ipairs(Hub.FarmCandidates(wants)) do
        local part = model:FindFirstChild("HumanoidRootPart")
        local name = tostring(model:GetAttribute("OriginalName") or model.Name)
        if model.Parent and part and (Hub.Skip[model] or 0) < os.clock() and Hub.HP(model) > 0 and model:GetAttribute("Dead") ~= true
            and not name:find("History") and model:GetAttribute("IsBoss") ~= true
            and (not wants or wants[name]) then
            local distance = (part.Position - root.Position).Magnitude
            -- Unrendered or released enemies take no damage: only travel toward far ones.
            -- TargetReleased is a historical log, not a current untargetable flag.
            local inert = model:GetAttribute("Render") == false
            local score = distance + (inert and 10000 or 0)
            if (not inert or distance > 300) and (not bestDistance or score < bestDistance) then best, bestDistance = model, score end
            if inert and (not sleeper or distance < sleeperDistance) then sleeper, sleeperDistance = model, distance end
        end
    end
    -- Only sleeping enemies nearby: go next to the closest one so the server wakes it up.
    best = best or sleeper
    return best, best and (best.HumanoidRootPart.Position - root.Position).Magnitude
end
-- Volcano quests live in a separate interior; never fly through the world to their raw Y.
function Hub.EnsureFarmArea(giverName)
    if giverName ~= "Volcano Island Quest Giver" then return true end
    local root = Hub.Root()
    local giver = RS.NpcAnchors:FindFirstChild(giverName)
    if not root or not giver then task.wait(0.3) return false end
    if math.abs(root.Position.Y - giver.Value.Position.Y) < 600
        and (Vector3.new(root.Position.X, 0, root.Position.Z) - Vector3.new(giver.Value.Position.X, 0, giver.Value.Position.Z)).Magnitude < 2500 then return true end
    local island = workspace.IgnoreList.Int.PrivateAreas:FindFirstChild("Volcano Island")
    local area = island and island:FindFirstChild("VolcanoInterior")
    local entrance = area and area:FindFirstChild("Enter") and area.Enter:FindFirstChild("Entrance")
    if not entrance then Hub.State = "Waiting for Volcano entrance" task.wait(1) return false end
    Hub.State = "Entering Volcano Island"
    return Hub.StoryDoor(entrance.Position, area, function() return Hub.FarmOn() and (S.Farm or S.FarmMob) end)
end
-- Fallback for disconnected navmesh: only use corridors with body clearance on every segment.
function Hub.ClearFarmLine(from, goal)
    if not Hub.PoseFits(goal, Vector3.new(2.4, 4, 2.4)) then return false end
    local delta = goal - from
    local flat = Vector3.new(delta.X, 0, delta.Z)
    local side = flat.Magnitude > 0.01 and Vector3.new(-flat.Z, 0, flat.X).Unit * 1.2 or Vector3.new(1.2, 0, 0)
    Hub.FarmTravelRay = Hub.FarmTravelRay or RaycastParams.new()
    local params = Hub.FarmTravelRay
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {player.Character, workspace.Playability.Enemys, workspace.IgnoreList}
    params.RespectCanCollide = true
    for _, offset in ipairs({Vector3.zero, side, -side, Vector3.new(0, 1.5, 0), Vector3.new(0, -1.5, 0)}) do
        if workspace:Raycast(from + offset, delta, params) then return false end
    end
    return true
end
function Hub.FarmClearTravel(goal)
    local root = Hub.Root()
    if not root then return false end
    local route
    if Hub.ClearFarmLine(root.Position, goal) then route = {goal}
    else
        for _, extra in ipairs({8, 16, 24}) do
            local height = math.max(root.Position.Y, goal.Y) + extra
            local up = Vector3.new(root.Position.X, height, root.Position.Z)
            local over = Vector3.new(goal.X, height, goal.Z)
            if Hub.ClearFarmLine(root.Position, up) and Hub.ClearFarmLine(up, over) and Hub.ClearFarmLine(over, goal) then
                route = {up, over, goal}
                break
            end
        end
    end
    if not route then
        local height = math.max(root.Position.Y, goal.Y) + 8
        for _, radius in ipairs({12, 24, 48, 96, 160, 256}) do
            for turn = 0, 7 do
                local angle = turn * math.pi / 4
                local side = root.Position + Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                local up = Vector3.new(side.X, height, side.Z)
                local over = Vector3.new(goal.X, height, goal.Z)
                if Hub.ClearFarmLine(root.Position, side) and Hub.ClearFarmLine(side, up)
                    and Hub.ClearFarmLine(up, over) and Hub.ClearFarmLine(over, goal) then
                    route = {side, up, over, goal}
                    break
                end
            end
            if route then break end
            task.wait()
        end
    end
    if not route then return false end
    Hub.CancelStoryMotion()
    for _, point in ipairs(route) do
        if not Hub.TravelSegment(point, math.min(Hub.TravelSpeed, 400)) then return false end
    end
    Hub.FarmRouteEvidence = {At = os.clock(), Segments = #route, Accepted = true}
    return true
end
function Hub.FreeFarmRoot(goal, force)
    local root, hum = Hub.Root()
    if not root or not hum or root.Anchored then return false end
    local char = player.Character
    if char:GetAttribute("CarriedNpc") or char:GetAttribute("CarriedChest") then return false end
    if Hub.PoseFits(root.Position, Vector3.new(2.4, 4, 2.4)) and not force then return false end
    if os.clock() < (Hub.FarmUnstuckNext or 0) then return false end
    Hub.FarmUnstuckNext = os.clock() + 2
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char, workspace.Playability.Enemys, workspace.IgnoreList}
    params.RespectCanCollide = true
    local best, distance
    for _, radius in ipairs({3, 6, 12}) do
        for turn = 0, 7 do
            local angle = turn * math.pi / 4
            local spot = root.Position + Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
            local floor = workspace:Raycast(spot + Vector3.new(0, 3, 0), Vector3.new(0, -8, 0), params)
            if floor and floor.Normal.Y > 0.6 and Hub.PoseFits(spot, Vector3.new(2.4, 4, 2.4))
                and (not force or Hub.ClearFarmLine(spot, spot + Vector3.new(0, 8, 0))) then
                local gap = (spot - goal).Magnitude
                if not distance or gap < distance then best, distance = spot, gap end
            end
        end
        if best then break end
    end
    if not best then return false end
    Hub.CancelStoryMotion()
    Hub.HoldAt = CFrame.lookAt(best, best + root.CFrame.LookVector)
    local deadline = os.clock() + 1
    local server
    repeat
        task.wait(0.1)
        server = player:GetAttribute("ServerPosition")
    until server and (server - best).Magnitude < 1.5 or not Hub.FarmOn() or os.clock() >= deadline
    local accepted = server and (server - best).Magnitude < 1.5
    Hub.HoldAt = nil
    Hub.FarmUnstuck = {At = os.clock(), Accepted = accepted == true}
    return accepted == true
end
function Hub.RecoverFarmHome()
    if os.clock() < (Hub.FarmHomeNext or 0) or player:GetAttribute("InCombat") or player:GetAttribute("BossFightLock") then return false end
    local root = Hub.Root()
    local char = player.Character
    if not root or not char or char:GetAttribute("CarriedNpc") or char:GetAttribute("CarriedChest") then return false end
    Hub.FarmHomeNext = os.clock() + 90
    local before = root.Position
    Hub.CancelStoryMotion()
    Hub.State = "Recovering route: returning to spawn"
    Elysium.Network:FireServer("Home", "TeleportToHome", true)
    local home = require(RS.Modules.Addons.AreasSystem).IsClient.Home
    task.wait(0.5)
    local deadline = os.clock() + 15
    repeat task.wait(0.25) until not home.InAction or not Hub.Alive or os.clock() >= deadline
    task.wait(1)
    root = Hub.Root()
    Hub.FarmApproachProgress, Hub.FarmApproachCache, Hub.FarmNav = nil, nil, nil
    return root and (root.Position - before).Magnitude > 30
end
-- Interior platforms are connected by paths; flying straight through them causes rejected travel.
function Hub.MoveToFarmPoint(point, reach)
    local root, hum = Hub.Root()
    if not root or not hum or root.Anchored then task.wait(0.2) return false end
    if (root.Position - point).Magnitude <= (reach or 8) then
        if Hub.StoryWalk then Hub.CancelStoryMotion() end
        return true
    end
    if player:GetAttribute("CurrentLocation") ~= "Volcano Interior" then return Hub.Hop(point) end
    Hub.FarmTarget = nil
    local server = player:GetAttribute("ServerPosition") or root.Position
    local progress = Hub.FarmApproachProgress
    local distance = (server - point).Magnitude
    if not progress or (progress.Point - point).Magnitude > 30 then
        progress = {Point = point, Distance = distance, At = os.clock(), Position = server, MoveAt = os.clock()}
        Hub.FarmApproachProgress = progress
    elseif distance + 5 < progress.Distance then progress.Distance, progress.At = distance, os.clock() end
    if not progress.Position or (server - progress.Position).Magnitude > 2 then progress.Position, progress.MoveAt = server, os.clock() end
    if os.clock() - progress.At > 12 and point.Y - root.Position.Y > 80 then
        Hub.RecoverFarmHome()
        return false
    end
    if not Hub.StoryWalk and root.Position.Y - point.Y > 20 and hum.FloorMaterial == Enum.Material.Air
        and Hub.PoseGrounded(root.Position) then
        Hub.HoldAt = nil
        Hub.State = "Landing on the path"
        task.wait(0.2)
        return false
    end
    local nav = Hub.FarmNav
    if nav and (nav.Goal - point).Magnitude < 5 and os.clock() < nav.Retry then
        task.wait(0.1)
        return false
    end
    Hub.StoryWalkActive = Hub.FarmOn
    local delta = root.Position - point
    local flat = Vector3.new(delta.X, 0, delta.Z)
    local approach = Hub.FarmApproachCache
    if not approach or (approach.Center - point).Magnitude > 3 or os.clock() - approach.At > 0.5 then
        local direction = flat.Magnitude > 0.1 and flat.Unit or Vector3.new(0, 0, 1)
        local radius = math.min(6, (reach or 8) - 2)
        local chosen = point
        for _, turn in ipairs({0, 1, -1, 2, -2, 3, -3, 4}) do
            local angle = turn * math.pi / 4
            local candidate = point + Vector3.new(direction.X * math.cos(angle) - direction.Z * math.sin(angle), 0,
                direction.X * math.sin(angle) + direction.Z * math.cos(angle)) * radius
            if Hub.PoseFits(candidate, Vector3.new(2.4, 4, 2.4)) then chosen = candidate break end
        end
        approach = {Center = point, Point = chosen, At = os.clock()}
        Hub.FarmApproachCache = approach
    end
    local goal = approach.Point
    local stalled = Hub.StoryWalk and (Hub.StoryWalk.Repaths or 0) >= 2
        or os.clock() - (progress.MoveAt or progress.At) > 2
    if (stalled or not Hub.StoryWalk) and Hub.FreeFarmRoot(point, stalled) then return false end
    if ((root.Position - point).Magnitude > 150 or stalled) and os.clock() >= (Hub.FarmFlightNext or 0) then
        Hub.FarmFlightNext = os.clock() + 1
        if Hub.FarmClearTravel(goal) then
            root = Hub.Root()
            return root and (root.Position - point).Magnitude <= (reach or 8)
        end
    end
    if not Hub.PoseGrounded(root.Position) then
        if not Hub.HoldAt then Hub.HoldAt = root.CFrame end
        Hub.State = "Finding a supported approach"
        task.wait(0.2)
        return false
    end
    Hub.HoldAt = nil
    Hub.StoryWalkTo(goal)
    if not Hub.StoryWalk then
        if Hub.FarmClearTravel(goal) then
            root = Hub.Root()
            return root and (root.Position - point).Magnitude <= (reach or 8)
        end
        Hub.FarmNav = {Goal = point, Retry = os.clock() + 1}
    else Hub.FarmNav = nil end
    return false
end
function Hub.TakeQuest(level, key)
    local quest = key and MainModules.QuestsInfo[key]
    local maxLevel = quest and quest.Arguments and quest.Arguments.MaxLevel
    if key and maxLevel and level > maxLevel and Hub.BestQuest(level) ~= key then
        Elysium.Network:FireServer("Quests", "Abandon", key)
        task.wait(1)
        return true
    end
    if key then return false end
    local best = Hub.BestQuest(level)
    local giver = best and RS.NpcAnchors:FindFirstChild(MainModules.QuestsInfo[best].Arguments.Giver)
    if not giver then task.wait(0.3) return false end
    if not Hub.EnsureFarmArea(MainModules.QuestsInfo[best].Arguments.Giver) then return true end
    Hub.FarmTarget, Hub.State = nil, "Taking " .. best
    if Hub.MoveToFarmPoint(giver.Value.Position + Vector3.new(0, 3, 0), 8) then
        task.wait(0.4)
        Elysium.Network:FireServer("Quests", "AcceptGrinding", best)
        task.wait(1)
    end
    return true
end
function Hub.FarmStep()
    local root, hum = Hub.Root()
    if not root or not hum or hum.Health <= 0 then Hub.HoldAt, Hub.FarmTarget = nil, nil Hub.State = "Waiting for respawn" task.wait(1) return end
    if root.Anchored then Hub.State = "Waiting for character" task.wait(0.3) return end
    Hub.Equip(hum)
    -- Low health: wait high above the fight until it recovers.
    if S.AntiDie and hum.Health <= hum.MaxHealth * Hub.RetreatRatio() then
        Hub.FarmTarget, Hub.State, Hub.Recovering = nil, "Recovering health", true
        Hub.HoldAt = Hub.RecoverySpot(root)
        repeat task.wait(0.5) until not S.AntiDie or not Hub.FarmOn() or hum.Health >= hum.MaxHealth * Hub.ResumeRatio() or hum.Health <= 0 or player.Character ~= hum.Parent
        if not S.AntiDie then Hub.CancelRecovery() end
        Hub.Recovering = nil
        return
    end
    local level = tonumber(Hub.Data().Statistics.Level) or 1
    local key, wants = Hub.QuestWants()
    local currentGiver = S.FarmMob and (tostring(S.MobIsland) .. " Quest Giver")
        or (key and MainModules.QuestsInfo[key].Arguments.Giver)
    if currentGiver and not Hub.EnsureFarmArea(currentGiver) then return end
    if S.FarmMob then
        wants = next(S.Mobs or {}) and S.Mobs or Hub.MobsSet()
    elseif Hub.TakeQuest(level, key) then return end
    local target, distance = Hub.PickEnemy(wants, root)
    if not target then
        Hub.FarmTarget, Hub.State = nil, "Waiting for enemies"
        -- Farm Mob: go to the island when its mobs are not around.
        local giverName = S.FarmMob and (tostring(S.MobIsland) .. " Quest Giver")
            or (key and MainModules.QuestsInfo[key].Arguments.Giver)
        local giver = giverName and RS.NpcAnchors:FindFirstChild(giverName)
        if giver and #Hub.FarmCandidates(wants) == 0 and (giver.Value.Position - root.Position).Magnitude > 1500 then
            Hub.State = "Traveling to " .. giverName:gsub(" Quest Giver$", "")
            Hub.Hop(giver.Value.Position + Vector3.new(0, 20, 0))
        end
        task.wait(0.5)
        return
    end
    if player:GetAttribute("CurrentLocation") == "Volcano Interior" then
        Hub.State = "Approaching " .. tostring(target:GetAttribute("OriginalName") or target.Name)
        if not Hub.MoveToFarmPoint(target.HumanoidRootPart.Position, 12) then
            local progress = Hub.FarmApproachProgress
            if progress and os.clock() - progress.At > 12 then
                Hub.Skip[target] = os.clock() + 15
                Hub.FarmApproachProgress = nil
                local hold = Hub.HoldAt
                Hub.CancelStoryMotion()
                if hold and not Hub.PoseGrounded(root.Position) then Hub.HoldAt = hold end
            end
            return
        end
    end
    if distance > 220 then
        Hub.FarmTarget, Hub.State = nil, "Traveling"
        -- The server pulls us back from some spots: give up on a target we never get closer to.
        Hub.TravelTries = Hub.TravelTries or setmetatable({}, {__mode = "k"})
        local tries = Hub.TravelTries[target] or {Count = 0, Best = distance}
        tries.Count = distance < tries.Best - 30 and 0 or tries.Count + 1
        tries.Best = math.min(tries.Best, distance)
        Hub.TravelTries[target] = tries
        if tries.Count >= 3 then
            Hub.TravelTries[target] = nil
            Hub.Skip[target] = os.clock() + 60
            return
        end
        Hub.Hop(target.HumanoidRootPart.Position + Vector3.new(0, tonumber(S.Height) or 7, 0))
        return
    end
    return Hub.FightTarget(target)
end
-- Bosses heal while you are away, so boss fights only retreat when health is low.
function Hub.RetreatRatio() return Hub.BossFight and 0.3 or 0.1 end
-- Retreat sideways away from the fight: straight up keeps you in range of fruit skills.
function Hub.RecoverySpot(root, target)
    target = target or Hub.FarmTarget
    local part = target and target.Parent and target:FindFirstChild("HumanoidRootPart")
    local away = part and Vector3.new(root.Position.X - part.Position.X, 0, root.Position.Z - part.Position.Z)
    if not away or away.Magnitude < 1 then away = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5) end
    Hub.RecoveryDir, Hub.RecoveryHealth = away.Unit, nil
    return CFrame.new(root.Position + away.Unit * 320 + Vector3.new(0, 45, 0))
end
function Hub.ResumeRatio() return 0.5 end
function Hub.FightTarget(target)
    local root, hum = Hub.Root()
    if not root or not hum or hum.Health <= 0 then return end
    Hub.FarmTarget, Hub.State = target, "Fighting " .. tostring(target:GetAttribute("OriginalName") or target.Name)
    Hub.HoldAt = Hub.HoldAt or root.CFrame
    task.wait(0.15)
    local last, combo = Hub.HP(target), 1
    local lastDamage, unrendered = os.clock(), nil
    while Hub.FarmOn() and target.Parent and Hub.FarmTarget == target do
        local currentRoot, currentHum = Hub.Root()
        if currentHum ~= hum or not currentRoot or hum.Health <= 0 then
            Hub.HoldAt = nil
            break
        end
        if S.AntiDie and hum.Health <= hum.MaxHealth * Hub.RetreatRatio() then
            if S.AutoStory then
                Hub.StoryRecoverySpot = Hub.RecoverySpot(currentRoot, target)
                Hub.FarmTarget = nil
                Hub.HoldAt = Hub.StoryRecoverySpot
            end
            break
        end
        if not target:FindFirstChild("HumanoidRootPart") then break end
        if target:GetAttribute("Dead") == true then
            Hub.Skip[target] = os.clock() + 6
            Hub.Kills = (Hub.Kills or 0) + 1
            break
        end
        if target:GetAttribute("Render") == false then
            unrendered = unrendered or os.clock()
            if os.clock() - unrendered >= 2 then
                Hub.Skip[target] = os.clock() + 6
                break
            end
        else
            unrendered = nil
        end
        local now = Hub.HP(target)
        if now < last then lastDamage = os.clock() if S.AutoStory then Hub.StoryProgressAt = os.clock() end end
        if os.clock() - lastDamage >= (target:GetAttribute("IsBoss") == true and 10 or 3) then
            Hub.Skip[target] = os.clock() + 6
            break
        end
        -- Enemies respawn in the same model with full health: that is the kill.
        -- Regeneration between hits (bosses) is not a respawn.
        local targetHum = target:FindFirstChildOfClass("Humanoid")
        local max = tonumber(targetHum and targetHum:GetAttribute("HandlerMaxHealth")) or 0
        local respawned = now > last and (max <= 0 or now >= max * 0.95 and last <= max * 0.6)
        if respawned or now <= 0 then
            Hub.Skip[target] = os.clock() + 6
            Hub.Kills = (Hub.Kills or 0) + 1
            break
        end
        last = now
        -- Same pair as the native swing: the activation first, then the hit with the same CallTime.
        local callTime = Elysium.TimeSync:Get()
        Elysium.Network:FireServer("CombatTools", "ActivatedEffects",
            {CallTime = callTime, Action = "Activated", Combo = combo, Class = "Default", DelayTime = 0, ComboType = "Default"}, nil)
        Elysium.Network:FireServer("CombatTools", "DefaultCombo",
            {Results = {target}, Combo = combo, CallTime = callTime, DelayTime = 0.2})
        -- Native combo: 4 hits, then a 0.75 s break (AfterComboTime) before the next string.
        local finished = combo == 4
        combo = combo % 4 + 1
        if finished then task.wait(0.75) end
        -- Skills never hold up the continuous basic-attack loop.
        if next(S.Skills or {}) and not Hub.SkillBusy then
            Hub.SkillBusy = true
            task.spawn(function()
                local ok, err = pcall(Hub.UseSkills)
                Hub.SkillBusy = false
                if not ok then Hub.SkillError = tostring(err) end
            end)
        end
        task.wait(0.35)
    end
    Hub.FarmTarget = nil
end
task.spawn(function()
    while Hub.Alive do
        if Hub.UIReady and Hub.FarmOn() then
            local farming = S.Farm or S.FarmMob
            local step = S.AutoStory and (not farming or Hub.Rank("Story") < Hub.Rank("Farm")) and Hub.StoryStep or Hub.FarmStep
            if S.AutoFish and not (S.AutoStory or S.Farm or S.FarmMob) then step = Hub.FishStep end
            if not (S.AutoStory or S.Farm or S.FarmMob or S.AutoFish) then step = Hub.VoxIdle end
            if S.AutoGeppo and Hub.NeedGeppo and Hub.NeedGeppo() then step = Hub.LearnGeppo end
            if (S.TrainVoxSense or S.TrainVoxArmor) and Hub.VoxCanInterrupt() and Hub.VoxPlan() then step = Hub.VoxTrainStep end
            local ability = Hub.VoxCanInterrupt() and Hub.AbilityNext()
            if ability then step = function() Hub.AbilityStep(ability) end end
            local ok, err = pcall(step)
            if not ok then Hub.FarmError = tostring(err) Hub.State = "Error, retrying" task.wait(1) end
            -- A successful step can return immediately (for example a rejected hop).
            -- Always give Roblox a frame before selecting another step.
            task.wait(0.05)
        else
            Hub.FarmTarget, Hub.HoldAt = nil, nil
            Hub.State = Hub.Paused and "Paused" or "Idle"
            task.wait(0.3)
        end
    end
end)

-- Facture: independent clicking, bounded code redemption and native story actions.
Hub.InteractionClient = require(RS.Modules.Essentials.InteractionSystem).IsClient
Hub.Interaction = Hub.InteractionClient.Interaction
Hub.NativeHold = require(RS.Modules.Essentials.InteractionSystem["InteractionSystem Client"].Interaction.Hold)
table.insert(Hub.Connections, Hub.NativeHold.Ended:Connect(function(name)
    if Hub.StoryHoldContext == name then Hub.StoryHoldContext = nil end
end))
Hub.StoryQuestClient = require(RS.Modules.Essentials.QuestSystem).IsClient
task.wait() -- native modules may lower the calling thread capability
-- Elixir Vendor story recipe: materials plus 1000 Gold, verified in its native dialogue.
Hub.StorySafeConverses = {["MysteriousMonk"] = true, ["ElixirVendor"] = true, ["LowerResident"] = true, ["OneEyedVorn"] = true, ["Zarkan Room Keeper"] = true, ["Activate_Runestone"] = true, ["AldousVenn"] = true, ["AldousVenn_SU"] = true, ["AncientMural"] = true, ["AncientRecord_SL"] = true, ["ArenaMaster"] = true, ["Arms Dealer"] = true, ["Askard"] = true, ["Aurel Room Keeper"] = true, ["BanditPlot_SOL"] = true, ["Blacksmith"] = true, ["BlueHatDeserter"] = true, ["BlueHatGuard"] = true, ["Boat Seller"] = true, ["Bounty Broker"] = true, ["Bounty Clerk"] = true, ["Brother"] = true, ["Brutus"] = true, ["Bugg Henchman"] = true, ["CampPrisonerInformant"] = true, ["CampPrisonerScared"] = true, ["CampPrisonerUnjust"] = true, ["CampWorkerAmisi"] = true, ["CampWorkerHakim"] = true, ["CampWorkerNeferu"] = true, ["CampWorkerSabu"] = true, ["CargoForeman_SU"] = true, ["CargoPorter"] = true, ["CensorWarning"] = true, ["ChalkNotes"] = true, ["ChiefSummons_SOL"] = true, ["CircusJuggler"] = true, ["CircusRingmaster"] = true, ["CitadelGateGuard_SU"] = true, ["CitadelInspector_SU"] = true, ["CityResidentFood"] = true, ["CityResidentMedicine"] = true, ["CityResidentWater"] = true, ["ColiseumClerk"] = true, ["ColiseumDoorman"] = true, ["CommanderDaskel_SU"] = true, ["CorwinHale"] = true, ["Crying Girl"] = true, ["CuriousMan"] = true, ["Defeat_AncientWerewolf"] = true, ["DefeatedIronLotusMaster"] = true, ["DefeatedNarmer"] = true, ["Dellan"] = true, ["Demolition Specialist"] = true, ["DepotClerk_SU"] = true, ["DetaineeFile"] = true, ["DetentionOrder"] = true, ["DunesIceBuyer"] = true, ["ElderResident"] = true, ["ExSoldierRashid"] = true, ["Example"] = true, ["FallenSharkman"] = true, ["FallenYeti"] = true, ["FestivalSpeech_SOL"] = true, ["FishermanToru"] = true, ["FlameMaster"] = true, ["FrostIceMerchant"] = true, ["FrostSurvivor"] = true, ["GarbageCollector"] = true, ["Garrick"] = true, ["Golem Room Keeper"] = true, ["GranlokDocument_SL"] = true, ["GranlokMeeting"] = true, ["GranlokNote_SL"] = true, ["Gromar Room Keeper"] = true, ["Gun Dealer"] = true, ["Hairdresser"] = true, ["HarborShippingMerchant"] = true, ["Hassan"] = true, ["HealerSamira"] = true, ["HiddenNote"] = true, ["HiddenRecord"] = true, ["Hooded Traveler"] = true, ["IronLotusMaster"] = true, ["IslandResident"] = true, ["JesterConfront_SOL"] = true, ["JesterNote_SOL"] = true, ["JesterPlanMeeting_SOL"] = true, ["Kael Room Keeper"] = true, ["Kaeldros Room Keeper"] = true, ["Kraken's Rest Shipwright"] = true, ["LevelLocked"] = true, ["LighthouseMan"] = true, ["LighthouseManDoor"] = true, ["LostExplorer"] = true, ["OldExplorerCafe"] = true, ["LowerMechanic"] = true, ["MarineArrest_SOL"] = true, ["MarinePlot_SOL"] = true, ["Marla"] = true, ["MerchantKarim"] = true, ["Morvath Room Keeper"] = true, ["MourningWoman"] = true, ["MysteriousMonk"] = true, ["Narmer Room Keeper"] = true, ["Nessa"] = true, ["Noctis Room Keeper"] = true, ["OldBram"] = true, ["OldKaito"] = true, ["OldMarineChief"] = true, ["Orange Town Mayor"] = true, ["Orange Town Resident"] = true, ["Oskar"] = true, ["Priest"] = true, ["PrisonGateGuard"] = true, ["PrisonInmates"] = true, ["PrisonKeymaster"] = true, ["PrisonShipCaptain"] = true, ["PrisonerSister"] = true, ["Quest Giver"] = true, ["Raikan Room Keeper"] = true, ["Raikan_SU"] = true, ["RebelPalaceRunner"] = true, ["RebelSignalman"] = true, ["Renshu Room Keeper"] = true, ["ResistanceScout"] = true, ["ResistanceScribe"] = true, ["RestaurantChef"] = true, ["RevolutionLeader"] = true, ["RookieGladiator"] = true, ["Rovan Room Keeper"] = true, ["RustfallMessenger"] = true, ["RustfallOldFarmer"] = true, ["RustfallStormKeeper"] = true, ["Sabotage_OrangeTown_Barrel"] = true, ["ScientistEngraving"] = true, ["ScientistRecord"] = true, ["SeaPostman"] = true, ["SecurityLog"] = true, ["SergeantHalden"] = true, ["ShackledPrisoner"] = true, ["ShipCaptain"] = true, ["Shipwright"] = true, ["Sky Hermit Coach"] = true, ["SkyHermitSummit"] = true, ["SkyPalaceGuardian"] = true, ["SnowmanKid"] = true, ["Solmar Shipwright"] = true, ["SolmarDockClerk"] = true, ["SuspiciousLetter"] = true, ["SuspiciousMan"] = true, ["Tailor"] = true, ["Talk_DonaCeleste"] = true, ["Talk_MarineCaptain"] = true, ["Talk_Nina"] = true, ["Talk_SeuTobias"] = true, ["Talk_SuppliesLady"] = true, ["Talk_Vasco"] = true, ["Talk_VillageChief"] = true, ["Thalara Room Keeper"] = true, ["ThirstyMerchant"] = true, ["TideMaster"] = true, ["TomatoClown"] = true, ["TransferRecord"] = true, ["UpperArchivist_SU"] = true, ["UpperLabSergeant"] = true, ["UpperMessenger_SU"] = true, ["UpperOfficer_SU"] = true, ["ValoriaBlacksmith"] = true, ["ValoriaChampion"] = true, ["ValoriaMerchant"] = true, ["ValoriaResidents"] = true, ["Varek Room Keeper"] = true, ["Veyrn Room Keeper"] = true, ["Void Herald"] = true, ["Vox Gacha"] = true, ["Weapon Dealer"] = true, ["Werewolf Hunter"] = true, ["WindhavenScholar"] = true, ["Witch"] = true, ["WorriedBrother"] = true, ["Yeti Room Keeper"] = true, ["YoungResident"] = true}
Hub.Codes = {"PatchGold", "PatchReset", "Release2026"}
Hub.CodeAttempts = {}
do
    local _, record = Elysium.Network.Require("RemoteEvent", "Codes")
    if record and record.Signal then
        table.insert(Hub.Connections, record.Signal:Connect(function(action, status)
            if not Hub.Alive or action ~= "Redeem" or not Hub.PendingCode then return end
            local code = Hub.PendingCode
            S.CodeResults[code] = {Status = tostring(status), PlaceVersion = game.PlaceVersion}
            Hub.LastCodeResult, Hub.PendingCode = tostring(status), nil
            save()
        end))
    end
end
task.spawn(function()
    while Hub.Alive do
        if Hub.UIReady and S.AutoCodes and not Hub.Paused then
            for _, code in ipairs(Hub.Codes) do
                if not Hub.Alive or not S.AutoCodes or Hub.Paused then break end
                local previous = S.CodeResults[code]
                local terminal = previous and (previous.Status == "Redeemed" or previous.Status == "AlreadyRedeemed"
                    or (previous.Status == "Invalid" or previous.Status == "Expired") and previous.PlaceVersion == game.PlaceVersion)
                if not terminal and (not Hub.CodeAttempts[code] or os.clock() - Hub.CodeAttempts[code] > 60) then
                    Hub.CodeAttempts[code], Hub.PendingCode = os.clock(), code
                    Elysium.Network:FireServer("Codes", "Redeem", code)
                    local untilAt = os.clock() + 5
                    repeat task.wait(0.1) until not Hub.Alive or not Hub.PendingCode or os.clock() >= untilAt
                    Hub.PendingCode = nil
                    task.wait(1.5)
                end
            end
        end
        task.wait(1)
    end
end)
task.spawn(function()
    while Hub.Alive do
        if Hub.UIReady and S.AutoClick and not Hub.Paused and not (S.Farm or S.FarmMob or S.AutoStory) then
            local _, hum = Hub.Root()
            if hum and hum.Health > 0 and not UserInput:GetFocusedTextBox() then
                Hub.Equip(hum)
                local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                if tool then pcall(tool.Activate, tool) end
            end
        end
        task.wait(0.35)
    end
end)
function Hub.WatchStoryHealth(char)
    local hum = char:WaitForChild("Humanoid", 10)
    if not hum or not Hub.Alive then return end
    table.insert(Hub.Connections, hum.HealthChanged:Connect(function(health)
        if not Hub.Alive or not S.AntiDie or not S.AutoStory or not Hub.FarmTarget or health <= 0 or health > hum.MaxHealth * Hub.RetreatRatio() then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and not root.Anchored then
            Hub.StoryRecoverySpot = Hub.RecoverySpot(root, Hub.FarmTarget)
            Hub.RecoveryBoss = Hub.BossFight and Hub.FarmTarget or nil
            Hub.RecoveryBossHP = Hub.RecoveryBoss and Hub.HP(Hub.RecoveryBoss) or nil
            Hub.FarmTarget = nil
            Hub.HoldAt, Hub.State = Hub.StoryRecoverySpot, "Recovering health"
        end
    end))
end
if player.Character then Hub.WatchStoryHealth(player.Character) end
table.insert(Hub.Connections, player.CharacterAdded:Connect(Hub.WatchStoryHealth))
function Hub.CancelStoryMotion()
    if Hub.StoryControls then
        pcall(Hub.StoryControls.Enable, Hub.StoryControls)
        Hub.StoryControls = nil
    end
    local root, hum = Hub.Root()
    if Hub.StoryWalkSpeed then
        local lease = Hub.StoryWalkSpeed
        if lease.Hum.Parent and lease.Hum.WalkSpeed == (lease.Applied or 54) then lease.Hum.WalkSpeed = lease.Speed end
        Hub.StoryWalkSpeed = nil
    end
    if root and hum then hum:MoveTo(root.Position) hum:Move(Vector3.zero) end
    Hub.StoryWalk, Hub.StoryWalkTarget, Hub.StoryWalkJump, Hub.StoryWalkActive = nil, nil, nil, nil
    Hub.HoldAt, Hub.FarmTarget = nil, nil
    if Hub.StoryHoldContext then Hub.NativeHold.Cancel() Hub.StoryHoldContext = nil end
end
table.insert(Hub.Connections, RunService.PreSimulation:Connect(function()
    if not Hub.Alive or not (Hub.StoryOn() or Hub.StoryWalkActive and Hub.StoryWalkActive()) or Hub.Paused or not Hub.StoryWalkTarget then return end
    local root, hum = Hub.Root()
    if not root or not hum or hum.Health <= 0 or root.Anchored or Hub.Interaction.GetLockReason() then return end
    local offset = Hub.StoryWalkTarget - root.Position
    local flat = Vector3.new(offset.X, 0, offset.Z)
    hum:Move(flat.Magnitude > 0.5 and flat.Unit or Vector3.zero, false)
    if Hub.StoryWalkJump then hum.Jump = true end
end))
function Hub.StoryWalkTo(goal)
    if not Hub.StoryControls then
        local controls = require(player.PlayerScripts.PlayerModule):GetControls()
        if controls.controlsEnabled ~= false then controls:Disable() Hub.StoryControls = controls end
    end
    local root, hum = Hub.Root()
    if not root or not hum then return end
    Hub.HoldAt, Hub.FarmTarget = nil, nil
    local char, now = player.Character, os.clock()
    local carrying = char:GetAttribute("CarriedNpc") or char:GetAttribute("CarriedChest")
    if not carrying then
        for name, value in pairs(char:GetAttributes()) do
            if name:match("^Carrying") and value and value ~= 0 then carrying = true break end
        end
    end
    local walk = Hub.StoryWalk
    if walk and (root.Position - (walk.MotionPoint or walk.LastPoint)).Magnitude > 1 then
        walk.MotionPoint, walk.MotionAt = root.Position, now
    end
    local stalled = walk and now - (walk.MotionAt or walk.Started) > 1.5
    if not walk or (walk.Goal - goal).Magnitude > 5 or now - walk.Started > 20 or stalled then
        local retries = stalled and (walk.Repaths or 0) + 1 or 0
        local farmWalking = Hub.StoryWalkActive and not Hub.StoryOn()
        local radius = farmWalking and (retries > 0 and 2.2 or 1.8) or (retries > 0 and 4 or 3)
        local path = game:GetService("PathfindingService"):CreatePath({AgentRadius = radius, AgentHeight = 6, AgentCanJump = true})
        local ok = pcall(path.ComputeAsync, path, root.Position, goal)
        local points
        if ok and path.Status == Enum.PathStatus.Success then
            points = path:GetWaypoints()
        elseif not farmWalking and (root.Position - goal).Magnitude < 60 and retries < 6 then
            -- No navmesh route (doorways, carried items, interiors): walk straight there.
            points = {{Position = root.Position, Action = Enum.PathWaypointAction.Walk}, {Position = goal, Action = Enum.PathWaypointAction.Walk}}
        elseif not farmWalking and retries < 6 and not carrying and Hub.Hop(goal + Vector3.new(0, 2, 0)) then
            Hub.StoryWalk = nil
            return
        else
            if farmWalking then
                Hub.CancelStoryMotion()
                Hub.State = "Finding a walking route"
                task.wait(0.3)
                return
            end
            Hub.StopStory("Walking route unavailable")
            return
        end
        walk = {Goal = goal, Points = points, Index = 2, Started = now, LastPoint = root.Position,
            MotionPoint = root.Position, MotionAt = now, Repaths = retries}
        Hub.StoryWalk = walk
        Hub.StoryWalkTarget, Hub.StoryWalkJump = nil, nil
    end
    if (root.Position - walk.LastPoint).Magnitude > 3 then
        walk.LastPoint, Hub.StoryProgressAt = root.Position, now
    end
    local waypoint = walk.Points[walk.Index]
    while waypoint do
        local offset = root.Position - waypoint.Position
        local flat = Vector3.new(offset.X, 0, offset.Z)
        local previous = walk.Points[walk.Index - 1]
        local crossed = false
        if previous then
            local segment = waypoint.Position - previous.Position
            segment = Vector3.new(segment.X, 0, segment.Z)
            if segment.Magnitude > 0.01 then
                local along = flat:Dot(segment.Unit)
                crossed = along >= 0 and (flat - segment.Unit * along).Magnitude <= 2
            end
        end
        if (flat.Magnitude > 1.5 and not crossed) or math.abs(offset.Y) > 8 then break end
        walk.Index += 1
        waypoint = walk.Points[walk.Index]
    end
    Hub.StoryWalkTarget = waypoint and waypoint.Position or goal
    Hub.StoryWalkJump = waypoint and waypoint.Action == Enum.PathWaypointAction.Jump and walk.JumpedIndex ~= walk.Index or false
    if Hub.StoryWalkJump then walk.JumpedIndex = walk.Index end
    if not carrying then
        if not Hub.StoryWalkSpeed then Hub.StoryWalkSpeed = {Hum = hum, Speed = hum.WalkSpeed} end
        local lease = Hub.StoryWalkSpeed
        local offset = Hub.StoryWalkTarget - root.Position
        local distance = Vector3.new(offset.X, 0, offset.Z).Magnitude
        if hum.WalkSpeed == lease.Speed or hum.WalkSpeed == (lease.Applied or 54) then
            lease.Applied = math.clamp(distance * 12, 18, 54)
            hum.WalkSpeed = lease.Applied
        end
    end
    hum:MoveTo(Hub.StoryWalkTarget)
    task.wait(0.05)
end
function Hub.StopStory(reason)
    S.AutoStory, Hub.FarmTarget, Hub.HoldAt = false, nil, nil
    Hub.StoryRecoverySpot = nil
    Hub.CancelStoryMotion()
    Hub.StoryBlocked, Hub.State = reason, "Story paused"
    if Hub.StoryConverse then pcall(Hub.StoryConverse.End, Hub.StoryConverse) Hub.StoryConverse = nil end
    task.wait() -- restore UI capability after native data reads
    Toggles.ArchivistVSAutoStory.Value = false
    Toggles.ArchivistVSAutoStory:Display()
    save()
    ui:Notify({Title = "Story paused", Description = reason, Time = 7})
end
-- Learn_ steps are unlocked by a side quest (Vox Sense Training): do that quest first.
function Hub.TrainingObjective(data)
    for key, progress in pairs(data.Quests.Actives) do
        local q = MainModules.QuestsInfo[key]
        if type(q) == "table" and not q.HistoryQuest and not q.GrindingQuest and tostring(key):find("Training") then
            for stage, sub in ipairs(q.SubQuests or {}) do
                if not MainModules.QuestsUtils.IsSubQuestCompleted(progress[stage], sub) then
                    for slot, objective in ipairs(sub.Objectives) do
                        local done = tonumber(progress[stage] and progress[stage][slot]) or 0
                        if done < objective.Goal then return key, stage, slot, objective, done end
                    end
                    break
                end
            end
        end
    end
end
function Hub.StoryObjective()
    if Hub.VoxQuest then return Hub.VoxQuestObjective(Hub.Data(), Hub.VoxQuest) end
    local key, stage, slot, objective, done = Hub.StoryObjectiveRaw()
    if objective and tostring(objective.ObjectiveID):match("^Learn_") then
        local tKey, tStage, tSlot, tObjective, tDone = Hub.TrainingObjective(Hub.Data())
        if tObjective then return tKey, tStage, tSlot, tObjective, tDone end
    end
    return key, stage, slot, objective, done
end
function Hub.StoryObjectiveRaw()
    local data = Hub.Data()
    local keys = {}
    for _, key in ipairs(data.Quests.Tracking or {}) do
        if data.Quests.Actives[key] and MainModules.QuestsInfo[key] and MainModules.QuestsInfo[key].HistoryQuest then table.insert(keys, key) end
    end
    for key in pairs(data.Quests.Actives) do
        if MainModules.QuestsInfo[key] and MainModules.QuestsInfo[key].HistoryQuest and not table.find(keys, key) then table.insert(keys, key) end
    end
    for _, key in ipairs(keys) do
        local q, progress = MainModules.QuestsInfo[key], data.Quests.Actives[key]
        for stage, sub in ipairs(q.SubQuests) do
            if not MainModules.QuestsUtils.IsSubQuestCompleted(progress[stage], sub) then
                for slot, objective in ipairs(sub.Objectives) do
                    local done = tonumber(progress[stage] and progress[stage][slot]) or 0
                    if done < objective.Goal and MainModules.QuestsUtils.IsValidObjective(nil, objective) then
                        return key, stage, slot, objective, done
                    end
                end
                break
            end
        end
    end
end
function Hub.StoryPoint(objective)
    local point = type(objective.InterestPoint) == "function" and objective.InterestPoint() or objective.InterestPoint
    if not point then
        local data = workspace.IgnoreList.Data:FindFirstChild("Quests")
        local zones = data and data:FindFirstChild("Zones")
        point = zones and zones:FindFirstChild(objective.ObjectiveID, true)
    end
    if typeof(point) == "Vector3" then return point, nil end
    if typeof(point) == "CFrame" then return point.Position, nil end
    if typeof(point) == "Instance" then
        local npcName = point.Name:match("^Character_(.+)$")
        local npc = npcName and Hub.InteractionClient.NPCs:FindModelByName(npcName)
        if npc and npc:IsDescendantOf(workspace) then return npc:GetPivot().Position, npc end
        if point:IsA("BasePart") then return point.Position, point.Name:match("^Character_") and point or point:FindFirstAncestorOfClass("Model") or point end
        if point:IsA("Model") then return point:GetPivot().Position, point end
    end
    -- A marker that resolves to nothing usable (folder, unloaded area): use the quest zone.
    local data = workspace.IgnoreList.Data:FindFirstChild("Quests")
    local zones = data and data:FindFirstChild("Zones")
    local zone = zones and zones:FindFirstChild(objective.ObjectiveID, true)
    if zone and zone:IsA("BasePart") then return zone.Position, nil end
end
-- Windhaven depot records: the desk documents are flavour; the objective's own prompt
-- (context named like the step) shows standing at the zone centre, at the desk's height.
function Hub.StoryRecords(id)
    if id ~= "Examine_TransferRecord_SU" then return false end
    local areas = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Areas")
    local quests = areas and areas:FindFirstChild("Windhaven") and areas.Windhaven:FindFirstChild("Quests")
    local depot = quests and quests:FindFirstChild("Quest_ReceivingDepot_SU")
    local zones = workspace.IgnoreList.Data.Quests:FindFirstChild("Zones")
    local zone = zones and zones:FindFirstChild(id, true)
    local doc = depot and depot:FindFirstChild("RecordDoc_4")
    if not zone or not doc then return false end
    local goal = Vector3.new(zone.Position.X, doc.Position.Y + 2.5, zone.Position.Z)
    local root = Hub.Root()
    if root and (root.Position - goal).Magnitude > 60 then Hub.Hop(goal) end
    Hub.HoldAt, Hub.FarmTarget = CFrame.lookAt(goal, Vector3.new(doc.Position.X, goal.Y, doc.Position.Z)), nil
    Hub.State = "Story: reading the transfer record"
    local name = id
    local deadline = os.clock() + 3
    repeat task.wait(0.2) until Hub.Interaction.Contexts[name] or os.clock() > deadline
    local context = Hub.Interaction.Contexts[name]
    if context then
        Hub.StoryInteract(name, context)
        task.wait(4.5)
    end
    Hub.StoryProgressAt = os.clock()
    return true
end
-- Talk steps without a quest marker: find the NPC named by the dialogue's actors.
function Hub.StoryFindActor(id)
    local name = id:gsub("^%a+_", "")
    local converse = Elysium.Converse.IsClient.Converses[name]
    local folder = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Int")
    folder = folder and folder:FindFirstChild("NPCs")
    if not converse or not folder then return nil end
    for _, actorName in ipairs(converse.Actors or {name}) do
        for _, model in ipairs(folder:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid")
                and (model.Name == actorName or model.Name:gsub("%s*%b()$", "") == actorName) then
                return model:GetPivot().Position, model
            end
        end
    end
end
function Hub.StoryTalk(actor)
    if not actor then return false end
    local C = Elysium.Converse.IsClient
    local name
    local actorName = actor.Name:gsub("^Character_", "")
    local shortName = actorName:gsub("%s*%b()$", "")
    for key, settings in pairs(C.Converses) do
        local actors = settings.Actors or {}
        if Hub.StorySafeConverses[key] and (table.find(actors, actorName) or table.find(actors, shortName)) then name = key break end
    end
    if not name and Hub.StorySafeConverses[shortName] and C.Converses[shortName] then name = shortName end
    if not name then
        -- Unknown dialogue: open it through the NPC's own talk prompt and drive it with the same filters.
        -- The marker can be a map point next to the NPC (Windhaven sergeant): the talk button is enough.
        local context = Hub.Interaction.Contexts["Dialogue"]
        if context then
            Hub.StoryInteract("Dialogue", context)
            return true
        end
        return false
    end
    return Hub.StoryConverseRun(name, actor:IsA("Model") and actor or nil)
end
-- Enemies hitting you interrupt dialogues: clear the closest attacker first.
function Hub.ClearAttackers(root)
    if not (player:GetAttribute("InCombat") or os.clock() - (Hub.StoryInterruptedAt or 0) < 8) then return false end
    local best, bestDistance
    for _, model in ipairs(workspace.Playability.Enemys:GetChildren()) do
        local part = model:FindFirstChild("HumanoidRootPart")
        if part and Hub.HP(model) > 0 and model:GetAttribute("Dead") ~= true and model:GetAttribute("Render") ~= false
            and model:GetAttribute("TargetReleased") == nil and (Hub.Skip[model] or 0) < os.clock() then
            local distance = (part.Position - root.Position).Magnitude
            if distance < 60 and (not bestDistance or distance < bestDistance) then best, bestDistance = model, distance end
        end
    end
    if not best then return false end
    Hub.StoryProgressAt = os.clock()
    Hub.FightTarget(best)
    return true
end
-- Runs one safe dialogue to its end, never picking purchases or resets.
function Hub.StoryConverseRun(name, model)
    local C = Elysium.Converse.IsClient
    Hub.HoldAt, Hub.FarmTarget = nil, nil
    local dialogue = Hub.InteractionClient.Dialogue.Start(name, model)
    dialogue = dialogue or Hub.InteractionClient.NPCs.CurrentConverse
    if not dialogue and Hub.InteractionClient.Dialogue.GetBlockReason() then
        -- Blocked for now (combat, another prompt): retry later instead of giving up.
        Hub.State = "Story: waiting to talk"
        task.wait(1)
        return true
    end
    -- Zones can open the dialogue on their own; then drive the one already open.
    return Hub.StoryDrive(dialogue)
end
function Hub.StoryDrive(dialogue)
    local C = Elysium.Converse.IsClient
    if not dialogue then return false end
    Hub.StoryConverse = dialogue
    local ended = false
    local connection = dialogue.Ended:Connect(function() ended = true end)
    local wasInterrupted = false
    local interrupted = dialogue.Interrupted:Connect(function() Hub.StoryInterruptedAt, wasInterrupted = os.clock(), true end)
    local lastSegment, repetitions = nil, 0
    for i = 1, 60 do
        task.wait(0.65)
        -- A guard interrupt (distance to a big NPC) ends the UI, but the options still work.
        if (ended and not wasInterrupted) or not Hub.Alive or not Hub.StoryOn() or Hub.Paused then break end
        local segments = C:Resolve(dialogue.ConverseSettings.Segments, dialogue)
        local segment = segments[dialogue.CurrentSegment]
        if not segment then break end
        if lastSegment == dialogue.CurrentSegment then repetitions += 1 else repetitions = 0 end
        lastSegment = dialogue.CurrentSegment
        if repetitions > 3 then break end
        local options = C:Resolve(segment.Options, dialogue)
        local chosen
        for index, option in ipairs(options or {}) do
            option = C:Resolve(option, dialogue)
            local text = tostring(C:Resolve(option.Text, dialogue) or ""):lower()
            if Hub.StoryAllowPay and (text:find("don't have") or text:find("not enough") or text:find("can't afford")) then
                local message = tostring(C:Resolve(segment.Message, dialogue) or ""):gsub(",", "")
                local price = tonumber(message:match("(%d%d%d+)%s*[gc]") or message:match("(%d%d%d+)"))
                local word = message:lower():match("(%a+) thousand")
                local words = {one = 1, two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10,
                    fifteen = 15, twenty = 20, thirty = 30, fifty = 50, hundred = 100}
                price = price or (word and words[word] and words[word] * 1000)
                local gold = tonumber(Hub.Data().Monetization.Gold) or 0
                -- The real price sits in the option's own text ("[Pay 12,500 coins]"); the speech can be outdated.
                pcall(function()
                    for _, value in pairs(debug.getconstants(option.Text)) do
                        local found = type(value) == "string" and value:match("[Pp]ay ([%d,]+)")
                        if found then price = tonumber((found:gsub(",", ""))) break end
                    end
                end)
                -- The game says we lack it: never trust a lower price; farm in steps until it lets us pay.
                Hub.StoryGoldGoal = (price and price > gold) and price or (gold + 2500)
                chosen = nil
                break
            end
            -- Story payments are Gold ("coins"); premium currencies are never chosen.
            local goldPay = Hub.StoryAllowPay and (text:find("coin") or text:find("gold"))
            -- A question that mentions paying ("Will I have to pay ... again?") is talk, not a purchase.
            local question = text:match("%?%s*$") ~= nil and not text:find("%[") and not text:find("%d")
            if (goldPay or question or not text:find("buy") and not text:find("purchase") and not text:find("pay"))
                and not text:find("robux") and not text:find("crystal") and not text:find("fragment") and not text:find("reset")
                and not text:match("^leave[%.!]*$") and not text:match("^goodbye[%.!]*$") then chosen = index break end
        end
        if not chosen or Hub.StoryGoldGoal then break end
        local segmentBefore = dialogue.CurrentSegment
        dialogue:ProcessOption(chosen)
        -- Options often ask the server first: wait for the answer instead of pressing again.
        local waitUntil = os.clock() + 6
        while (not ended or wasInterrupted) and dialogue.CurrentSegment == segmentBefore and os.clock() < waitUntil and Hub.Alive and Hub.StoryOn() do
            task.wait(0.1)
        end
        if wasInterrupted and dialogue.CurrentSegment == segmentBefore then break end
        Hub.StoryProgressAt = os.clock()
    end
    if not ended then pcall(dialogue.End, dialogue) end
    connection:Disconnect()
    interrupted:Disconnect()
    Hub.StoryConverse = nil
    return true
end
function Hub.AdvanceStoryScene()
    local components = MainModules.InterfaceUtils.UIComponents()
    local frame = components.InteractionHUD and components.InteractionHUD.Converse
    if not frame or not frame.Visible then return false end
    if os.clock() < (Hub.SceneClickAt or 0) then return true end
    local buttons = {}
    for _, button in ipairs(frame.Options:GetChildren()) do
        if button:IsA("GuiButton") and button.Visible then table.insert(buttons, button) end
    end
    -- Scripted scene lines have one continuation, never choose among purchases.
    local button = #buttons == 1 and buttons[1] or nil
    local label = button and button:FindFirstChild("Label")
    local signature = tostring(#buttons) .. ":" .. tostring(label and label.Text or frame.ContinueLabel.Visible)
    if signature ~= Hub.SceneSignature then Hub.SceneSignature, Hub.SceneProgressAt = signature, os.clock() end
    if os.clock() - Hub.SceneProgressAt > 60 then Hub.StopStory("Scene needs a verified choice") return true end
    if button then
        local label = button:FindFirstChild("Label")
        local text = label and label.Text:lower() or ""
        for _, word in ipairs({"buy", "pay", "gold", "coin", "robux", "crystal", "gem", "reroll", "reset"}) do
            if text:find(word, 1, true) then Hub.StopStory("Scene choice requires review") return true end
        end
    elseif #buttons == 0 and frame.ContinueLabel.Visible then button = frame end
    if button and type(firesignal) == "function" then
        Hub.SceneClickAt = os.clock() + 0.8
        Hub.StoryProgressAt = os.clock()
        firesignal(button.MouseButton1Click)
    end
    return true
end
Hub.StoryPurchases = {
    Buy_ShipwrightsHammer = {Prefix = "Shipwright", MaxPrice = 5000},
    Buy_NavigatorsMap = {Prefix = "Navigator", MaxPrice = 10000},
    Buy_Boat = {Name = "Boat", MaxPrice = 5000},
}
Hub.PurchaseEvidence = {}
-- Closing a shop from a script can leave the game's interface group on "Menus", which hides the whole
-- HUD (health, quests and the fishing minigame). Put it back once no menu is open.
function Hub.RestoreHud(shop)
    task.wait(0.3)
    local utils = Elysium.InterfaceUtils
    if utils and utils.CurrentGroup == "Menus" and not (shop and shop.Opened) then pcall(utils.ApplyInterfaceGroup, "Default") end
end
function Hub.StoryBuy(id)
    local adapter = Hub.StoryPurchases[id]
    if not adapter then Hub.StopStory("Purchase requires a verified adapter") return end
    local shop = require(RS.Modules.Commerce.ShopSystem).IsClient.ShopShowcaseMenu
    Elysium.Network:FireServer("Elysium_Converse", "Solmar Shipwright")
    local deadline = os.clock() + 4
    repeat task.wait(0.1) until shop.Opened or not Hub.StoryOn() or os.clock() >= deadline
    if not Hub.StoryOn() then return end
    if not shop.Opened or (shop.ShopName ~= "Solmar Boat Shop" and shop.ShopName ~= "Central Town Boat Shop") then
        Hub.StopStory("Verified shop did not open") return
    end
    local info = MainModules.ShopInfo:Get(shop.ShopName)
    local selected, entry
    for index, item in ipairs(info and info.Items or {}) do
        if item.ToolName == adapter.Name or adapter.Prefix and tostring(item.ToolName):sub(1, #adapter.Prefix) == adapter.Prefix then
            selected, entry = index, item break
        end
    end
    -- Prices move with game updates; only Gold under a sane cap is ever bought.
    if not entry or entry.Currency ~= "Gold" or type(entry.Price) ~= "number" or entry.Price <= 0 or entry.Price > adapter.MaxPrice then
        pcall(shop.Close) Hub.StopStory("Shop currency or price changed") return
    end
    local owned = MainModules.ToolsUtils.GetOwnedAmount(nil, entry.ToolName)
    local before = Hub.Data().Monetization
    local gold, premium = before.Gold, before.Fragment
    task.wait()
    if owned > 0 then pcall(shop.Close) Hub.StopStory("Item already owned; check quest") return end
    if gold < entry.Price then pcall(shop.Close) Hub.StoryGoldGoal = entry.Price return end
    if not Hub.StoryOn() or not Hub.Alive then return end
    Elysium.Network:FireServer("ShopSystem", "Purchase", selected, 1)
    local received = false
    deadline = os.clock() + 5
    repeat
        task.wait(0.2)
        received = MainModules.ToolsUtils.GetOwnedAmount(nil, entry.ToolName) > owned
    until received or not Hub.StoryOn() or os.clock() >= deadline
    local after = Hub.Data().Monetization
    table.insert(Hub.PurchaseEvidence, {Id = id, Item = entry.ToolName, Price = entry.Price,
        Currency = entry.Currency, GoldBefore = gold, GoldAfter = after.Gold,
        PremiumBefore = premium, PremiumAfter = after.Fragment, Received = received})
    task.wait()
    pcall(shop.Close)
    Hub.RestoreHud(shop)
    if not received then Hub.StopStory("Purchase was not confirmed") end
end
-- Levers and similar check reach to their own model (Foundry levers, Prison lift): stand next to it first.
-- The reach check is horizontal, to the model's bounding-box centre, and the pull animation needs a still body.
function Hub.StoryUseFocused(name, context)
    local focus = context and context.HighlightParent
    local root = Hub.Root()
    local center
    if typeof(focus) == "Instance" and focus:IsA("Model") and focus:FindFirstChildWhichIsA("BasePart", true) then
        center = focus:GetBoundingBox().Position
    elseif typeof(focus) == "Instance" and focus:IsA("BasePart") then
        center = focus.Position
    end
    if not center or not root then return false end
    local flat = Vector3.new(root.Position.X - center.X, 0, root.Position.Z - center.Z)
    -- Prompt already offered from here (small lever zones): moving would only leave the zone.
    -- Also when the highlighted model sits far from the prompt zone (Solmar flare crate 2).
    if (flat.Magnitude <= 10 or flat.Magnitude > 25) and Hub.Interaction.Contexts[name] then
        Hub.HoldAt = nil
        Hub.HoldPauseUntil = os.clock() + 3
        Hub.StoryInteract(name, context)
        task.wait(3)
        return true
    end
    local away = flat.Magnitude > 0.1 and flat.Unit or Vector3.new(1, 0, 0)
    local spot = Vector3.new(center.X, center.Y + 1, center.Z) + away * 2.5
    if flat.Magnitude > 4 then Hub.Hop(spot) end
    Hub.HoldAt = CFrame.lookAt(spot, Vector3.new(center.X, spot.Y, center.Z))
    task.wait(0.5)
    Hub.StoryInteract(name, context)
    task.wait(3)
    Hub.HoldAt = nil
    return true
end
function Hub.StoryInteract(name, context, active)
    active = active or Hub.StoryOn
    if not context or not Hub.Interaction.CanInteract(context.IgnoreLocks) then return false end
    if context.DisableInCombat and player:GetAttribute("InCombat") then return false end
    if context.Hold and context.Hold > 0 then
        local completed = false
        local char = player.Character
        Hub.NativeHold.Start(name, context.Hold, function()
            if Hub.Alive and active() and not Hub.Paused and player.Character == char and Hub.Interaction.Contexts[name] then
                Hub.Interaction.Interacted:Fire(name)
            end
            Hub.StoryHoldContext, completed = nil, true
        end)
        Hub.StoryHoldContext = name
        local deadline = os.clock() + context.Hold + 2
        repeat task.wait(0.05) until completed or not Hub.Alive or not active() or Hub.Paused or os.clock() >= deadline
        if not completed and Hub.StoryHoldContext == name then Hub.NativeHold.Cancel() Hub.StoryHoldContext = nil end
        return completed
    end
    -- Many objects open a dialogue from their handler; catch it and drive it like a talk.
    local D = Hub.InteractionClient.Dialogue
    local original, opened = D.Start, nil
    D.Start = function(...)
        local result = original(...)
        opened = opened or result
        return result
    end
    -- Standing on the floor: let go of the position hold so the game's own animation can align.
    local root = Hub.Root()
    if root then
        local ray = RaycastParams.new()
        ray.FilterType = Enum.RaycastFilterType.Exclude
        ray.FilterDescendantsInstances = {player.Character}
        if workspace:Raycast(root.Position, Vector3.new(0, -7, 0), ray) then Hub.HoldPauseUntil = os.clock() + 2.5 end
    end
    local ok = pcall(function() Hub.Interaction.Interacted:Fire(name) end)
    task.wait(0.3)
    D.Start = original
    if ok and opened then Hub.StoryDrive(opened) end
    return true
end
-- Route over land from here, or from a spot up to 30 studs away (tight shores next to rocks).
function Hub.CarryRoute(from, goal, near)
    local radii = near and {0, 10, 20, 30} or {0}
    for _, radius in ipairs(radii) do
        for turn = 0, radius == 0 and 0 or 15 do
            local angle = math.rad(turn * 22.5)
            local start = from + Vector3.new(math.cos(angle) * radius, radius == 0 and 0 or 4, math.sin(angle) * radius)
            local path = game:GetService("PathfindingService"):CreatePath({AgentRadius = 3, AgentHeight = 6, AgentCanJump = true, WaypointSpacing = 6})
            local ok = pcall(function() path:ComputeAsync(start, goal) end)
            if ok and path.Status == Enum.PathStatus.Success then
                local points, jumps = {}, {}
                for index, waypoint in ipairs(path:GetWaypoints()) do
                    points[index] = waypoint.Position
                    jumps[index] = waypoint.Action == Enum.PathWaypointAction.Jump
                end
                return points, jumps
            end
        end
    end
end
-- Carrying (NPC, chest): short ground-level steps (about 20 studs/s). Height jumps or
-- fast moves make the game throw the character into the void. On land it follows a
-- PathfindingService route (islands have cliffs and buildings); at sea it swims.
-- Trail markers (market routes) are waypoints, not NPCs: stand on them and let the trail move on.
function Hub.StoryWaypointWait(id, position, root)
    Hub.TalkWaits = Hub.TalkWaits or {}
    local waits = (Hub.TalkWaits[id] or 0) + 1
    Hub.TalkWaits[id] = waits
    if waits > 12 then return false end
    if (position - root.Position).Magnitude > 10 then Hub.Hop(position + Vector3.new(0, 3, 0)) end
    Hub.StoryProgressAt = os.clock()
    task.wait(1)
    return true
end
-- Valoria supply cart: grab it at the dock, walk it to the merchant's zone, release it there.
-- Stealth tails (Windhaven Follow_ steps): the escort's vision cones only see along the ground,
-- so the hub hovers right above the leader (no planar direction to see, 24 studs is past Near 16,
-- inside the server's follow range). While the track waits it stands on the start point.
-- The game's own handler fires Finish once we are inside the objective zone at the end.
function Hub.StoryTail(id)
    if not id:match("^Follow_") and not id:match("^Capture_") then return false end
    local ok, SV = pcall(function()
        return require(RS.Modules.Addons.QuestHandlers["QuestHandlers Client"]["Customs Client"].Windhaven.Windhaven_Stealth.SkylandsVision)
    end)
    local track = ok and SV.TrackForObjective(id)
    local path = track and SV.TrackPath()
    if not track or (track.Kind ~= "Tail" and track.Kind ~= "Flee") or not path then return false end
    local flee = track.Kind == "Flee"
    local root = Hub.Root()
    if not root then return true end
    local state, at = player:GetAttribute("SkylandsTrackState"), player:GetAttribute("SkylandsTrackAt")
    Hub.StoryProgressAt = os.clock()
    if (state ~= "Walking" and state ~= "Arrived") or type(at) ~= "number" then
        local start = SV.RestartPoint(track)
        if not start then return false end
        local goal = start.Position + Vector3.new(0, 3, 0)
        Hub.State = "Story: tailing, waiting at the start"
        if (root.Position - goal).Magnitude > 60 then Hub.Hop(goal) else Hub.HoldAt = CFrame.new(goal) task.wait(0.5) end
        return true
    end
    local duration = path.Duration(track)
    local run = player:GetAttribute("SkylandsTrackRun")
    while Hub.Alive and Hub.StoryOn() and not Hub.Paused and player:GetAttribute("SkylandsTrackRun") == run
        and (player:GetAttribute("SkylandsTrackState") == "Walking" or player:GetAttribute("SkylandsTrackState") == "Arrived") do
        local elapsed = math.max(0, workspace:GetServerTimeNow() - (tonumber(player:GetAttribute("SkylandsTrackAt")) or at))
        local leader = path.ActorCFrame(track, track.Leader, elapsed)
        local spot = leader.Position + Vector3.new(0, flee and 8 or 24, 0)
        -- Flee: the game offers a 0.3 s Capture hold within 12 studs of the running officer.
        local capture = flee and Hub.Interaction.Contexts["Windhaven_Stealth_Capture"]
        if capture then
            Hub.HoldAt, Hub.FarmTarget = CFrame.new(spot), nil
            Hub.State = "Story: capturing the officer"
            Hub.StoryInteract("Windhaven_Stealth_Capture", capture)
            task.wait(0.5)
            return true
        end
        -- At the end the hub must sit inside the objective zone for the game to finish the step.
        if not flee and elapsed >= duration - 3 and not SV.InZone(id, spot, 1) then
            local zones = workspace.IgnoreList.Data.Quests:FindFirstChild("Zones")
            local folder = zones and zones:FindFirstChild("Windhaven")
            local best, gap
            for _, zone in ipairs(folder and folder:GetChildren() or {}) do
                if zone.Name == id and zone:IsA("BasePart") then
                    local d = (zone.Position - leader.Position).Magnitude
                    if not gap or d < gap then best, gap = zone, d end
                end
            end
            if best then
                local top = best.Position.Y + best.Size.Y / 2 - 3
                spot = Vector3.new(leader.Position.X, math.min(spot.Y, top), leader.Position.Z)
                if not SV.InZone(id, spot, 1) then spot = Vector3.new(best.Position.X, math.min(best.Position.Y + 20, top), best.Position.Z) end
            end
        end
        Hub.HoldAt, Hub.FarmTarget = CFrame.lookAt(spot, spot + leader.LookVector), nil
        Hub.State = string.format(flee and "Story: chasing the officer %d / %d s" or "Story: tailing the officer %d / %d s", elapsed, duration)
        Hub.StoryProgressAt = os.clock()
        task.wait()
    end
    return true
end
function Hub.StoryCart(id)
    local root = Hub.Root()
    if not root then task.wait(0.5) return end
    Hub.FarmTarget = nil
    local quests = workspace.IgnoreList.Data.Quests
    local zone = quests:FindFirstChild("Zones") and quests.Zones:FindFirstChild(id, true)
    if player:GetAttribute("ValoriaCartState") == "Pulling" then
        if not zone then task.wait(0.5) return end
        local offset = zone.CFrame:PointToObjectSpace(root.Position)
        local half = zone.Size / 2
        if math.abs(offset.X) <= half.X and math.abs(offset.Z) <= half.Z then
            Hub.CancelStoryMotion()
            Hub.State = "Story: releasing the cart"
            task.wait(2)
            local context = Hub.Interaction.Contexts["Release Cart"]
            if context and player:GetAttribute("ValoriaCartState") == "Pulling" then Hub.StoryInteract("Release Cart", context) end
            task.wait(1.5)
            return
        end
        Hub.State = "Story: pulling the cart"
        Hub.CarryStep(zone.Position)
        return
    end
    local point = quests:FindFirstChild("Waypoints") and quests.Waypoints:FindFirstChild("SupplyCart_VAL", true)
    -- The grab prompt shows within 6 studs of the cart's tip (10.4 studs ahead of its centre).
    local pose = player:GetAttribute("ValoriaCartPose")
    if typeof(pose) ~= "CFrame" then pose = point and point:GetPivot() end
    local spot
    if pose then
        local look = Vector3.new(pose.LookVector.X, 0, pose.LookVector.Z)
        look = look.Magnitude > 0.01 and look.Unit or Vector3.new(0, 0, -1)
        spot = pose.Position + look * 10.441
    end
    local context = Hub.Interaction.Contexts["Pull Supply Cart"]
    if not context then
        if spot and (Vector3.new(spot.X, 0, spot.Z) - Vector3.new(root.Position.X, 0, root.Position.Z)).Magnitude > 3 then
            Hub.Hop(spot + Vector3.new(0, 3, 0))
        end
        Hub.State = "Story: going to the cart"
        Hub.StoryProgressAt = os.clock()
        task.wait(1)
        return
    end
    Hub.State = "Story: grabbing the cart"
    -- Stay on the tip: the prompt vanishes beyond 6 studs from it.
    Hub.HoldAt = root.CFrame
    task.wait(0.3)
    Hub.StoryInteract("Pull Supply Cart", context)
    Hub.HoldAt = nil
    task.wait(1)
end
function Hub.CarryStep(goal)
    local char, root = player.Character, Hub.Root()
    if not char or not root then task.wait(0.25) return end
    Hub.CancelStoryMotion()
    Hub.EscortRay = Hub.EscortRay or RaycastParams.new()
    Hub.EscortRay.FilterType = Enum.RaycastFilterType.Exclude
    Hub.EscortRay.FilterDescendantsInstances = {char, workspace.Playability}
    Hub.StoryProgressAt = os.clock()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then task.wait(0.25) return end
    local under = workspace:Raycast(root.Position + Vector3.new(0, 4, 0), Vector3.new(0, -40, 0), Hub.EscortRay)
    if not under or hum.PlatformStand then
        -- Open sea: the game's swim system follows MoveDirection; steer it every frame
        -- (the chest survives swimming, not diving).
        Hub.HoldAt, Hub.CarryPath = nil, nil
        local check = Hub.SwimCheck
        if not check or (root.Position - check.Pos).Magnitude > 6 then
            Hub.SwimCheck = {Pos = root.Position, At = os.clock()}
        elseif os.clock() - check.At > 6 then
            -- Stuck between rocks: a short jump (30 studs keeps the chest) to a spot with a route.
            local points = Hub.CarryRoute(root.Position, goal, true)
            if points and (points[1] - root.Position).Magnitude < 40 then
                root.CFrame = CFrame.new(points[1] + Vector3.new(0, 3, 0))
                Hub.CarryPath = {Goal = goal, At = os.clock(), Points = points, Index = 1}
                Hub.SwimCheck, Hub.SwimTry = nil, nil
                task.wait(0.5)
                return
            end
            -- No route nearby: swim a while toward the last dry spot or the most open side.
            local best, room = nil, 0
            for angle = 0, 330, 30 do
                local dir = Vector3.new(math.cos(math.rad(angle)), 0, math.sin(math.rad(angle)))
                local hit = workspace:Raycast(root.Position + Vector3.new(0, 2, 0), dir * 80, Hub.EscortRay)
                local free = hit and (hit.Position - root.Position).Magnitude or 80
                if free > room then best, room = dir, free end
            end
            Hub.SwimEscape = Hub.CarryLastLand or (best and root.Position + best * 60)
            Hub.SwimBackUntil, Hub.SwimCheck = os.clock() + 8, nil
            Hub.SwimTry = (Hub.SwimTry or 0) + 1
        end
        local target = goal
        if (Hub.SwimBackUntil or 0) > os.clock() then
            target = Hub.SwimEscape
        elseif (Hub.SwimTry or 0) > 0 then
            -- Each dead end moves the landing point sideways (200, -200, 400, -400...).
            local away = Vector3.new(goal.X - root.Position.X, 0, goal.Z - root.Position.Z)
            if away.Magnitude > 1 then
                local side = away.Unit:Cross(Vector3.yAxis)
                local try = Hub.SwimTry
                local shift = math.ceil(try / 2) * 200 * (try % 2 == 1 and 1 or -1)
                target = goal + side * shift
            end
        end
        local conn = RunService.RenderStepped:Connect(function()
            local flat = Vector3.new(target.X - root.Position.X, 0, target.Z - root.Position.Z)
            if flat.Magnitude <= 1 then return end
            local dir = flat.Unit
            -- Rock or cliff ahead: slide along it instead of pushing into it.
            local wall = workspace:Raycast(root.Position + Vector3.new(0, 2, 0), dir * 6, Hub.EscortRay)
            if wall and math.abs(wall.Normal.Y) < 0.5 then
                local n = Vector3.new(wall.Normal.X, 0, wall.Normal.Z).Unit
                local slide = dir - n * dir:Dot(n)
                if slide.Magnitude < 0.3 then slide = n:Cross(Vector3.yAxis) * (Hub.SwimSide or 1) end
                Hub.SwimSide = (slide:Dot(n:Cross(Vector3.yAxis)) >= 0) and 1 or -1
                dir = (slide.Unit + n * 0.2).Unit
            end
            hum:Move(dir, false)
        end)
        task.wait(0.5)
        conn:Disconnect()
        hum:Move(Vector3.zero, false)
        return
    end
    Hub.SwimCheck, Hub.SwimBackUntil = nil, nil
    -- On land: walk for real (Humanoid:Move) along a route. Forced CFrame moves while
    -- carrying get the character thrown into the void by the server.
    Hub.HoldAt = nil
    local route = Hub.CarryPath
    if not route or route.Goal ~= goal or os.clock() - route.At > 30
        or (route.Points[route.Index] and (route.Points[route.Index] - root.Position).Magnitude > 30) then
        local points, jumps = Hub.CarryRoute(root.Position, goal, true)
        if points then Hub.CarryLastLand, Hub.SwimTry = points[1], nil end
        route = {Goal = goal, At = os.clock(), Points = points or {}, Jumps = jumps or {}, Index = 1, Check = root.Position, CheckAt = os.clock()}
        Hub.CarryPath = route
    end
    -- No progress for 3 s: jump once, then rebuild the route.
    if (root.Position - route.Check).Magnitude > 4 then
        route.Check, route.CheckAt = root.Position, os.clock()
    elseif os.clock() - route.CheckAt > 3 then
        hum.Jump = true
        if os.clock() - route.CheckAt > 6 then Hub.CarryPath = nil end
    end
    local conn = RunService.RenderStepped:Connect(function()
        local point = route.Points[route.Index]
        while point and Vector3.new(point.X - root.Position.X, 0, point.Z - root.Position.Z).Magnitude < 3 do
            route.Index += 1
            point = route.Points[route.Index]
            if route.Jumps[route.Index] then hum.Jump = true end
        end
        local aim = point or goal
        local flat = Vector3.new(aim.X - root.Position.X, 0, aim.Z - root.Position.Z)
        if flat.Magnitude > 0.5 then hum:Move(flat.Unit, false) end
    end)
    task.wait(0.5)
    conn:Disconnect()
    hum:Move(Vector3.zero, false)
end
function Hub.StoryEscortBrother()
    local B = MainModules.BrotherCarryUtils
    local char = player.Character
    local root = Hub.Root()
    if char:GetAttribute("CarriedNpc") == B.CarriedName then
        local delivery = B.GetDelivery()
        if not delivery then Hub.StopStory("Brother delivery marker unavailable") return end
        if (root.Position - delivery.Position).Magnitude > 7 then
            -- Carrying: short ground-level steps (about 20 studs/s). Height jumps or
            -- fast moves make the game throw the character into the void.
            Hub.CarryStep(delivery.Position)
            return
        end
        Hub.HoldAt = nil
        local _, hum = Hub.Root()
        hum:MoveTo(root.Position)
        Hub.StoryWalk, Hub.StoryWalkTarget, Hub.StoryWalkJump = nil, nil, nil
        task.wait(1) -- the native carrying controller performs delivery
    else
        local target = B.GetPlacedRoot(player.UserId) or B.GetPickupRoot()
        if not target then
            local untilAt = os.clock() + 3
            repeat
                task.wait(0.2)
                if not Hub.StoryOn() or char:GetAttribute("CarriedNpc") == B.CarriedName then return end
                target = B.GetPlacedRoot(player.UserId) or B.GetPickupRoot()
            until target or os.clock() >= untilAt
            if not target then Hub.StopStory("Brother pickup marker unavailable") return end
        end
        if (root.Position - target.Position).Magnitude > 5 then Hub.Hop(target.Position + target.CFrame.LookVector * 3.5) end
        Hub.HoldAt = nil
        task.wait(0.4)
        Hub.StoryInteract("Carry Brother", Hub.Interaction.Contexts["Carry Brother"])
        task.wait(0.5)
    end
end
function Hub.Unsink()
    -- Sunk into the floor (after a dialogue or a hop), the humanoid stays in GettingUp
    -- for good and cannot walk: lift it back on top of the floor.
    local root, hum = Hub.Root()
    local stuckState = root and hum and (hum:GetState() == Enum.HumanoidStateType.GettingUp or hum:GetState() == Enum.HumanoidStateType.FallingDown)
    if stuckState and not root.Anchored then
        Hub.SunkAt = Hub.SunkAt or os.clock()
        if os.clock() - Hub.SunkAt > 1.5 then
            Hub.SunkAt = nil
            local ray = RaycastParams.new()
            ray.FilterType = Enum.RaycastFilterType.Exclude
            ray.FilterDescendantsInstances = {player.Character}
            local floor = workspace:Raycast(root.Position + Vector3.new(0, 4, 0), Vector3.new(0, -12, 0), ray)
            local stand = floor and floor.Position.Y + hum.HipHeight + root.Size.Y * 0.5
            if stand and root.Position.Y < stand - 0.5 then
                root.CFrame = root.CFrame + Vector3.new(0, stand + 0.2 - root.Position.Y, 0)
                root.AssemblyLinearVelocity = Vector3.zero
            end
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    else
        Hub.SunkAt = nil
    end
end
-- Runs on its own: a story step that stops early must not leave the character stuck.
task.spawn(function()
    while Hub.Alive do
        if not Hub.Paused then pcall(Hub.Unsink) end
        task.wait(0.3)
    end
end)
-- A skill cast cut short can leave the native "Client" lock on, which blocks doors and
-- interactions. Clear it only when no skill is running for a while.
function Hub.ClearStuckClient()
    local states = Elysium.States.Player()
    local active = false
    pcall(function() active = states:IsActive("Client") end)
    if not active or Hub.SkillBusy then Hub.ClientStuckAt = nil return end
    Hub.ClientStuckAt = Hub.ClientStuckAt or os.clock()
    if os.clock() - Hub.ClientStuckAt > 3 then
        pcall(function() states:Set({"Client"}, false) end)
        Hub.ClientStuckAt = nil
    end
end
-- Resolve the actual trigger, approach on the floor, and confirm the server transfer.
function Hub.StoryDoor(position, actor, active)
    active = active or Hub.StoryOn
    local entrance, nearest
    for _, part in ipairs(actor:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "Entrance" then
            local distance = (part.Position - position).Magnitude
            if not nearest or distance < nearest then entrance, nearest = part, distance end
        end
    end
    -- Inside an interior the marker still points at the outdoor door: leave by the
    -- exit of the room we are in.
    local here = Hub.Root()
    if here and (here.Position - position).Magnitude > 150 then
        local exit, exitGap
        for _, part in ipairs(actor:GetDescendants()) do
            if part:IsA("BasePart") and part.Name == "Entrance" and part.Parent.Name == "Leave" then
                local gap = (part.Position - here.Position).Magnitude
                if gap < 80 and (not exitGap or gap < exitGap) then exit, exitGap = part, gap end
            end
        end
        if exit then entrance, nearest, position = exit, 0, exit.Position end
    end
    if not entrance or nearest > 40 then if active == Hub.StoryOn then Hub.StopStory("Door marker unavailable") end return false end
    local route = entrance.Parent
    local destination = route:FindFirstChild("Destination")
    local opposite = route.Parent:FindFirstChild(route.Name == "Enter" and "Leave" or "Enter")
    local approach = opposite and opposite:FindFirstChild("Destination")
    local reference = approach and approach.Position or entrance.Position
    local offset = entrance.CFrame:PointToObjectSpace(reference)
    local half = entrance.Size * 0.5 - Vector3.new(2, 2, 2)
    offset = Vector3.new(math.clamp(offset.X, -half.X, half.X), math.clamp(offset.Y, -half.Y, half.Y), math.clamp(offset.Z, -half.Z, half.Z))
    local goal = entrance.CFrame:PointToWorldSpace(offset)
    local root, hum = Hub.Root()
    if not root or not hum or not destination then return false end
    local ray = RaycastParams.new()
    ray.FilterType = Enum.RaycastFilterType.Exclude
    ray.FilterDescendantsInstances = {player.Character, workspace.IgnoreList}
    local floor = workspace:Raycast(goal + Vector3.new(0, 3, 0), Vector3.new(0, -40, 0), ray)
    if floor then goal = Vector3.new(goal.X, floor.Position.Y + hum.HipHeight + root.Size.Y * 0.5, goal.Z) end
    for attempt = 1, 3 do
        if not Hub.Alive or not active() or Hub.Paused then return false end
        Hub.CancelStoryMotion()
        if (root.Position - goal).Magnitude > 80 then
            if not Hub.Hop(goal) then return false end
        end
        local deadline = os.clock() + 12
        repeat
            root, hum = Hub.Root()
            if not root or not hum or hum.Health <= 0 then Hub.CancelStoryMotion() return false end
            local localPoint = entrance.CFrame:PointToObjectSpace(root.Position)
            local size = entrance.Size * 0.5
            local inside = math.abs(localPoint.X) < size.X and math.abs(localPoint.Y) < size.Y and math.abs(localPoint.Z) < size.Z
            if inside and Hub.Interaction.Contexts["Enter Area"] then break end
            -- The door prompt already shows next to the door: no need to stand inside its box.
            if Hub.Interaction.Contexts["Enter Area"] and (root.Position - entrance.Position).Magnitude < 14 then break end
            pcall(Hub.ClearStuckClient)
            Hub.StoryWalkActive = active
            Hub.StoryWalkTo(goal)
            Hub.StoryProgressAt = os.clock()
        until not active() or Hub.Paused or os.clock() >= deadline
        Hub.CancelStoryMotion()
        if not active() or Hub.Paused then return false end
        local before, start = player:GetAttribute("CurrentLocation"), root.Position
        local context = Hub.Interaction.Contexts["Enter Area"]
        if context then Hub.StoryInteract("Enter Area", context, active) end
        deadline = os.clock() + 6
        repeat
            task.wait(0.1)
            root = Hub.Root()
            if root and (root.Position - destination.Position).Magnitude < 35
                and ((root.Position - start).Magnitude > 40 or player:GetAttribute("CurrentLocation") ~= before) then
                task.wait(2) -- Let the native fade, location and server position settle.
                root = Hub.Root()
                local server = player:GetAttribute("ServerPosition")
                if not root or (root.Position - destination.Position).Magnitude >= 35
                    or (typeof(server) == "Vector3" and (server - destination.Position).Magnitude >= 35) then
                    continue
                end
                Hub.StoryProgressAt, Hub.Rejections, Hub.DoorFails = os.clock(), 0, 0
                Hub.DoorEvidence = {Route = route:GetFullName(), Attempt = attempt, Confirmed = true, Location = player:GetAttribute("CurrentLocation")}
                return true
            end
        until not active() or Hub.Paused or os.clock() >= deadline
    end
    -- Doors sometimes drop one use (fade still running): try again before giving up.
    Hub.DoorFails = (Hub.DoorFails or 0) + 1
    if Hub.DoorFails < 4 then Hub.StoryProgressAt = os.clock() task.wait(1) return false end
    Hub.DoorFails = 0
    if active == Hub.StoryOn then Hub.StopStory("Door transfer not confirmed") end
    return false
end
-- A single story prompt at the marker (Enter_Lighthouse_FI, Leave_Lighthouse_FI): use it, never shops or spins.
function Hub.StoryUsePrompt()
    local only, count = nil, 0
    for name in pairs(Hub.Interaction.Contexts) do
        local lower = name:lower()
        if name ~= "Dialogue" and not (lower:find("buy") or lower:find("shop") or lower:find("gacha")
            or lower:find("spin") or lower:find("robux") or lower:find("skip") or lower:find("sell")) then
            only, count = name, count + 1
        end
    end
    if count ~= 1 or (Hub.StoryPromptTries or 0) >= 3 then return false end
    Hub.StoryPromptTries = (Hub.StoryPromptTries or 0) + 1
    Hub.StoryInteract(only, Hub.Interaction.Contexts[only])
    task.wait(2.5)
    return true
end
function Hub.StoryStep()
    pcall(Hub.ClearStuckClient)
    local open = Hub.InteractionClient.NPCs.CurrentConverse
    if open and not Hub.StoryConverse then Hub.StoryDrive(open) return end
    local root, hum = Hub.Root()
    if not root or not hum or hum.Health <= 0 then Hub.HoldAt = nil task.wait(1) return end
    local lockReason = Hub.Interaction.GetLockReason()
    if lockReason then
        if root.Anchored or lockReason == "Converse" then
            Hub.HoldAt, Hub.FarmTarget = nil, nil
            Hub.AdvanceStoryScene()
        end
        task.wait(0.5)
        return
    end
    if not S.AntiDie and Hub.StoryRecoverySpot then Hub.CancelRecovery() end
    if S.AntiDie and (hum.Health <= hum.MaxHealth * Hub.RetreatRatio() or Hub.StoryRecoverySpot) then
        if player.Character:GetAttribute("CarriedNpc") then Hub.StopStory("Low health during escort") return end
        if not Hub.StoryRecoverySpot and Hub.BossFight and Hub.FarmTarget then
            Hub.RecoveryBoss, Hub.RecoveryBossHP = Hub.FarmTarget, Hub.HP(Hub.FarmTarget)
            local targetHum = Hub.FarmTarget:FindFirstChildOfClass("Humanoid")
            Hub.BossPeak = Hub.BossPeak or setmetatable({}, {__mode = "k"})
            Hub.BossPeak[Hub.FarmTarget] = math.max(Hub.BossPeak[Hub.FarmTarget] or 0, targetHum and targetHum.MaxHealth or 0)
        end
        Hub.FarmTarget = nil
        -- Boss arenas lock the door while the boss lives and pull us back in: kite around it inside the room.
        local arenaBoss = Hub.RecoveryBoss
        if not (arenaBoss and arenaBoss.Parent) then
            arenaBoss = nil
            for _, model in ipairs(workspace.Playability.Enemys:GetChildren()) do
                local part = model:FindFirstChild("HumanoidRootPart")
                if part and model:GetAttribute("IsBoss") == true and model:GetAttribute("Render") ~= false and Hub.HP(model) > 0
                    and (part.Position - root.Position).Magnitude < 150 then
                    arenaBoss = model break
                end
            end
            Hub.RecoveryBoss = arenaBoss
        end
        local bossRoot = arenaBoss and arenaBoss.Parent and Hub.HP(arenaBoss) > 0 and arenaBoss:FindFirstChild("HumanoidRootPart")
        if bossRoot then
            local center = bossRoot.Position
            Hub.KiteAngle = (Hub.KiteAngle or math.atan2(root.Position.Z - center.Z, root.Position.X - center.X)) + 0.35
            local spot = center + Vector3.new(math.cos(Hub.KiteAngle) * 35, 2, math.sin(Hub.KiteAngle) * 35)
            Hub.StoryRecoverySpot = CFrame.lookAt(spot, Vector3.new(center.X, spot.Y, center.Z))
        else
            Hub.KiteAngle = nil
        end
        Hub.StoryRecoverySpot = Hub.StoryRecoverySpot or Hub.RecoverySpot(root)
        -- Still losing health (long-range fruit skills): move farther away.
        if not bossRoot and Hub.RecoveryHealth and Hub.RecoveryDir and hum.Health < Hub.RecoveryHealth - hum.MaxHealth * 0.02 then
            Hub.StoryRecoverySpot = Hub.StoryRecoverySpot + Hub.RecoveryDir * 220 + Vector3.new(0, 20, 0)
        end
        Hub.RecoveryHealth = hum.Health
        Hub.HoldAt, Hub.State = Hub.StoryRecoverySpot, "Recovering health"
        Hub.StoryProgressAt = os.clock()
        -- Bosses heal back to full once left alone: go back as soon as it starts healing.
        local boss, healing = Hub.RecoveryBoss, false
        if boss and boss.Parent and Hub.HP(boss) > 0 then
            local now = Hub.HP(boss)
            healing = now > (Hub.RecoveryBossHP or now) + 1
            Hub.RecoveryBossHP = math.min(Hub.RecoveryBossHP or now, now)
        end
        if hum.Health >= hum.MaxHealth * Hub.ResumeRatio() or (healing and hum.Health >= hum.MaxHealth * 0.35) then
            -- A boss back at full health after our retreat: too strong for now.
            if boss and boss.Parent then
                local hp, top = Hub.HP(boss), Hub.BossPeak and Hub.BossPeak[boss] or 0
                if top > 0 and hp >= top * 0.999 then
                    Hub.BossHeals = (Hub.BossHeals or 0) + 1
                    if Hub.BossHeals >= 3 then
                        Hub.BossHeals = 0
                        Hub.StoryGrindUntil = os.clock() + 300
                        Hub.Library:Notify({Title = "Archivist Hub", Description = "Boss too strong, leveling up for 5 minutes", Time = 5})
                    end
                else
                    Hub.BossHeals = 0
                end
            end
            Hub.StoryRecoverySpot, Hub.RecoveryBoss, Hub.RecoveryBossHP, Hub.KiteAngle = nil, nil, nil, nil
        else task.wait(0.5) return end
    end
    -- Leveling break after a boss proved too strong.
    if os.clock() < (Hub.StoryGrindUntil or 0) then
        Hub.StoryProgressAt = os.clock()
        Hub.FarmStep()
        Hub.State = "Story: leveling up (" .. math.ceil(Hub.StoryGrindUntil - os.clock()) .. "s)"
        return
    end
    local key, stage, slot, objective, done = Hub.StoryObjective()
    task.wait()
    if not objective then
        Hub.StoryEmptyAt = Hub.StoryEmptyAt or os.clock()
        -- Scripted beats (guard walking to the crates) validate the next step a few seconds later.
        if os.clock() - Hub.StoryEmptyAt > 30 then Hub.StopStory("No active story objective") else task.wait(0.5) end
        return
    end
    Hub.StoryEmptyAt = nil
    local signature = key .. ":" .. stage .. ":" .. slot .. ":" .. done
    if signature ~= Hub.StorySignature then Hub.StorySignature, Hub.StoryProgressAt, Hub.StoryPromptTries = signature, os.clock(), 0 end
    -- Brewing uses the real server timer; announce it once so waiting is visible.
    for _, attribute in ipairs({"PotionFinishTime", "ElixirFinishTime"}) do
        local finish = tonumber(player:GetAttribute(attribute))
        local left = finish and finish - workspace:GetServerTimeNow()
        if left and left > 0 and left < 900 then
            Hub.StoryProgressAt, Hub.HoldAt, Hub.FarmTarget = os.clock(), nil, nil
            local seconds = math.ceil(left)
            local remaining = string.format("%dm %02ds", math.floor(seconds / 60), seconds % 60)
            Hub.State = "Story: brewing, " .. remaining
            if not Hub.BrewNotice or Hub.BrewNotice.Finish ~= finish then
                Hub.BrewNotice = {Finish = finish, Kind = attribute == "ElixirFinishTime" and "Elixir" or "Potion"}
                Hub.Library:Notify({Title = Hub.BrewNotice.Kind .. " brewing", Description = "Ready in " .. remaining, Time = 8})
            end
            task.wait(1)
            return
        end
    end
    if Hub.BrewNotice and workspace:GetServerTimeNow() >= Hub.BrewNotice.Finish then
        Hub.Library:Notify({Title = Hub.BrewNotice.Kind .. " ready", Description = "Collecting from the vendor", Time = 5})
        Hub.BrewNotice = nil
        Hub.StoryProgressAt = os.clock()
    end
    if os.clock() - Hub.StoryProgressAt > 60 then
        -- Fights can stall after a death or a lost target: start the fight over a few times.
        local key = objective.ObjectiveID
        Hub.StallRetries = Hub.StallRetries or {}
        if key:match("^Defeat_") and (Hub.StallRetries[key] or 0) < 3 then
            Hub.StallRetries[key] = (Hub.StallRetries[key] or 0) + 1
            Hub.StoryProgressAt, Hub.FarmTarget, Hub.HoldAt = os.clock(), nil, nil
            table.clear(Hub.Skip)
            return
        end
        Hub.StopStory("Needs manual step: " .. key)
        return
    end
    local id = objective.ObjectiveID
    if not id:match("^Defeat_") then Hub.BossFight = false end
    if Hub.StoryCurrent == "Escort_Brother" and id ~= "Escort_Brother" then Hub.CancelStoryMotion() end
    if Hub.StoryCurrent ~= id then Hub.TalkWaits = {} end
    Hub.StoryCurrent, Hub.State = id, "Story: " .. id
    -- Unlisted Buy_/Pay_ steps are paid through the NPC dialogue, only with Gold options.
    -- Learn_ steps (Askard Vox lessons, 5000 Gold) are paid in Gold only, like Buy_/Pay_.
    if Hub.StoryGoldGoal then
        local gold = tonumber(Hub.Data().Monetization.Gold) or 0
        task.wait()
        if gold < Hub.StoryGoldGoal and (id:match("^Pay_") or id:match("^Buy_") or id:match("^Learn_")) then
            Hub.StoryProgressAt = os.clock()
            Hub.FarmStep()
            Hub.State = "Story: farming Gold " .. gold .. " / " .. Hub.StoryGoldGoal
            return
        end
        Hub.StoryGoldGoal = nil
    end
    Hub.StoryAllowPay = (id:match("^Buy_") or id:match("^Pay_") or id:match("^Learn_")) and not Hub.StoryPurchases[id] and true or false
    if id == "Escort_Brother" then Hub.StoryEscortBrother() return end
    if id == "Deliver_SupplyCart_VAL" then Hub.StoryCart(id) return end
    if Hub.StoryTail(id) then return end
    if Hub.StoryRecords(id) then return end
    local position, actor = Hub.StoryPoint(objective)
    -- Search steps: the marker only hints an area; the NPC waits inside a quest zone (Valoria bar).
    local search = Hub.StorySearchSpots[id]
    if search then
        local zones = workspace.IgnoreList.Data.Quests:FindFirstChild("Zones")
        local zone = zones and zones:FindFirstChild(search.Zone, true)
        if zone and zone:IsA("BasePart") then
            local best, gap
            for _, model in ipairs(workspace.IgnoreList.Int.NPCs:GetDescendants()) do
                if model:IsA("Model") and model.Name == search.Npc then
                    local d = (model:GetPivot().Position - zone.Position).Magnitude
                    if not gap or d < gap then best, gap = model, d end
                end
            end
            position, actor = zone.Position, best or actor
        end
    end
    -- Object steps whose prompt only shows inside a small quest zone away from the marker
    -- (Ancient Structure levers: marker 25 studs short of the 8x10x8 lever zone).
    if position and not id:match("^Talk_") and not id:match("^Defeat_") then
        local zones = workspace.IgnoreList.Data.Quests:FindFirstChild("Zones")
        local zone = zones and zones:FindFirstChild(id, true)
        if zone and zone:IsA("BasePart") and zone.Size.Magnitude < 40 and (position - zone.Position).Magnitude > 10 then
            position = zone.Position
        end
    end
    if not position and (id:match("^Watch_") or id:match("^Listen_") or id:match("^Finish_")) then
        Hub.HoldAt, Hub.FarmTarget = nil, nil
        task.wait(1)
        return
    end
    if not position then
        local island = key:gsub(" %d+$", "")
        if island == "Solmar Prologue" then island = "Solmar Island" end
        local anchor = RS.NpcAnchors:FindFirstChild(island .. " Quest Giver")
        if anchor then player:RequestStreamAroundAsync(anchor.Value.Position, 1) end
        task.wait(0.5)
        position, actor = Hub.StoryPoint(objective)
        if not position then position, actor = Hub.StoryFindActor(id) end
        if not position then Hub.StopStory("Story marker unavailable: " .. id) return end
    end
    if id:match("^Catch_Fish") then Hub.FishOnce(position) return end
    -- Carrying a quest chest: walk it to the NPC, then talk.
    if player.Character:GetAttribute("CarriedChest") ~= nil and actor and actor.Parent ~= workspace.IgnoreList then
        if (position - root.Position).Magnitude > 8 then Hub.CarryStep(position) return end
        Hub.HoldAt = nil
        if not Hub.StoryTalk(actor) then task.wait(1) end
        return
    end
    if actor and actor:IsDescendantOf(workspace) and actor.Parent and actor.Parent.Name == "Chests" and Hub.Interaction.Contexts["Carry Chest"] then
        Hub.HoldAt = nil
        Hub.StoryInteract("Carry Chest", Hub.Interaction.Contexts["Carry Chest"])
        task.wait(1)
        return
    end
    -- InteriorRoutes resolves an entrance/exit before the actual NPC or zone.
    if actor and actor.Name == "PrivateAreas" then
        Hub.StoryDoor(position, actor)
        return
    end
    -- Some fights only count one weapon ("punches only"): read it from the objective text.
    Hub.WeaponOverride = nil
    if id:match("^Defeat_") and type(objective.UIText) == "function" then
        local ok, text = pcall(objective.UIText, objective)
        text = ok and tostring(text):lower() or ""
        if text:find("punch") or text:find("fist") then Hub.WeaponOverride = "Melee"
        elseif text:find("sword only") then Hub.WeaponOverride = "Sword" end
    end
    if id:match("^Defeat_") then
        Hub.Equip(hum)
        local wanted = id:gsub("^Defeat_", "")
        local target, closest
        for _, model in ipairs(workspace.Playability.Enemys:GetChildren()) do
            local part = model:FindFirstChild("HumanoidRootPart")
            local original = tostring(model:GetAttribute("OriginalName") or "")
            if part and (original == wanted or model.Name:gsub("_%d+$", "") == wanted)
                and Hub.HP(model) > 0 and model:GetAttribute("Dead") ~= true
                and (model:GetAttribute("IsBoss") == true or not ((Hub.Skip[model] or 0) > os.clock())) then
                -- Released or unrendered enemies ignore hits: prefer the others.
                local distance = (part.Position - root.Position).Magnitude
                    + (model:GetAttribute("TargetReleased") and 100000 or 0)
                    + (model:GetAttribute("Render") == false and 100000 or 0)
                if not closest or distance < closest then target, closest = model, distance end
            end
        end
        -- Bosses inside an interior (far below the map) are reached through the marker's Enter_ door.
        local door
        for name in pairs(Hub.Interaction.Contexts) do
            if name:match("^Enter_") then door = name break end
        end
        -- Only when we are not down there already (recovery spots can be 250+ studs from the boss).
        local inside = target and target.HumanoidRootPart.Position.Y < position.Y - 400 and (closest % 100000) > 220
            and math.abs(root.Position.Y - target.HumanoidRootPart.Position.Y) > 150
        if inside or (not target and door and (position - root.Position).Magnitude < 25) then
            if door then
                Hub.HoldAt = nil
                if Hub.StoryUseFocused(door, Hub.Interaction.Contexts[door]) then return end
                Hub.StoryInteract(door, Hub.Interaction.Contexts[door])
                task.wait(2.5)
            else
                Hub.Hop(position + Vector3.new(0, 3, 0))
                task.wait(0.5)
            end
            return
        end
        if target then
            -- Damage counts as progress (strong enemies take longer than the 60 s window).
            Hub.StoryHits = Hub.StoryHits or setmetatable({}, {__mode = "k"})
            local health, before = Hub.HP(target), Hub.StoryHits[target]
            if before and health < before then Hub.StoryProgressAt = os.clock() end
            Hub.StoryHits[target] = health
            closest = closest % 100000
            Hub.BossFight = target:GetAttribute("IsBoss") == true
            if closest > 220 then Hub.Hop(target.HumanoidRootPart.Position + Vector3.new(0, S.Height, 0)) end
            Hub.FightTarget(target)
        elseif (position - root.Position).Magnitude < 20 and Hub.StoryUsePrompt() then
            -- The marker is a door toward the enemies (leave an interior first).
        else Hub.Hop(position + Vector3.new(0, 3, 0)) task.wait(0.5) end
        return
    end
    -- The Black Market has several floors. Follow its stairs instead of
    -- holding a CFrame through the floor above the contact.
    if player:GetAttribute("CurrentLocation") == "Black Market" and (position - root.Position).Magnitude > 7 then
        Hub.StoryWalkTo(position)
        return
    end
    -- A hop bounced back here before: keep walking this step instead of hopping again.
    -- The objective's own prompt is already offered: that is close enough.
    local inReach = not id:match("^Talk_") and Hub.Interaction.Contexts[id] ~= nil
    if Hub.WalkOnly == id and not inReach and (Vector3.new(position.X - root.Position.X, 0, position.Z - root.Position.Z)).Magnitude > 7 then
        Hub.StoryWalkTo(position)
        return
    end
    if Hub.StoryWalk then Hub.CancelStoryMotion() end
    -- Markers float above the floor: close horizontally and a little below still counts as there.
    local gap = position - root.Position
    local near = Vector3.new(gap.X, 0, gap.Z).Magnitude <= 7 and math.abs(gap.Y) <= 16
    local npcBody = actor and actor:FindFirstChildOfClass("Humanoid") and actor:FindFirstChild("HumanoidRootPart")
    near = near or npcBody ~= nil and (npcBody.Position - root.Position).Magnitude <= 12
    near = near or inReach
    if not near and gap.Magnitude > 7 then
        local goal = actor and actor:FindFirstChildOfClass("Humanoid") and position + Vector3.new(3, 0, 0) or position + Vector3.new(0, 2, 0)
        local hopped = Hub.Hop(goal)
        -- Interiors (Ancient Structure) bounce the hop back; a short walk gets there.
        local after = Hub.Root()
        if after and gap.Magnitude < 90 and (Vector3.new(position.X - after.Position.X, 0, position.Z - after.Position.Z)).Magnitude > 7 then
            Hub.HoldAt, Hub.WalkOnly = nil, id
            Hub.StoryWalkTo(position)
            return
        end
        if not hopped then return end
    end
    Hub.HoldAt, Hub.FarmTarget = nil, nil
    if Hub.ClearAttackers(root) then return end
    local body = actor and actor:FindFirstChildOfClass("Humanoid") and actor:FindFirstChild("HumanoidRootPart")
    if body and (body.Position - root.Position).Magnitude > 12 then
        local side = Vector3.new(root.Position.X - body.Position.X, 0, root.Position.Z - body.Position.Z)
        side = side.Magnitude > 0.1 and side.Unit or Vector3.new(1, 0, 0)
        Hub.Hop(body.Position + side * 6 + Vector3.new(0, 2, 0))
        return
    end
    task.wait(0.35)
    if id:match("^Buy_") and Hub.StoryPurchases[id] then
        Hub.StoryBuy(id)
    elseif Hub.StoryAllowPay then
        if not (actor and actor:FindFirstChildOfClass("Humanoid")) and Hub.StoryWaypointWait(id, position, root) then return end
        if not (actor and Hub.StoryTalk(actor)) then Hub.StopStory("Payment needs the NPC: " .. id) end
    elseif id:match("^Talk_") then
        if not (actor and actor:FindFirstChildOfClass("Humanoid")) then
            -- The marker is an object (dig spot, chest): use whatever prompt it offers.
            for name, context in pairs(Hub.Interaction.Contexts) do
                if name ~= "Dialogue" then
                    Hub.StoryInteract(name, context)
                    task.wait(2)
                    return
                end
            end
        end
        -- Trail markers (market routes) are waypoints, not NPCs: stand on them and let the trail move on.
        if not (actor and actor:FindFirstChildOfClass("Humanoid")) and Hub.StoryWaypointWait(id, position, root) then return end
        if not Hub.StoryTalk(actor) then Hub.StopStory("Dialogue needs adapter: " .. id) end
    else
        local context = Hub.Interaction.Contexts[id]
        if context then
            if Hub.StoryUseFocused(id, context) then return end
            Hub.StoryInteract(id, context)
            task.wait(2.5)
            return
        end
        if id == "Train_VoxArmor_VX" then
            for name, other in pairs(Hub.Interaction.Contexts) do
                if name:find("Stone") then Hub.StoryInteract(name, other) task.wait(2.5) return end
            end
        end
        -- Report/return objectives point at an NPC: talk to it.
        if actor and actor:FindFirstChildOfClass("Humanoid") and Hub.StoryTalk(actor) then task.wait(1) return end
        -- Context names that are part of the objective id (Sabotage_Barrel_3 uses Barrel_3).
        for name, other in pairs(Hub.Interaction.Contexts) do
            local bare, bareId = name:gsub("^%a+_", ""), id:gsub("^%a+_", "")
            if name ~= "Dialogue" and #name >= 5 and (id:find(name, 1, true) or name:find(id, 1, true)
                or #bare >= 6 and (bareId:find(bare, 1, true) or bare:find(bareId, 1, true))) then
                Hub.StoryInteract(name, other)
                task.wait(2)
                return
            end
        end
        -- Zone objectives (altars, bait) expose a context named after the zone that opens a dialogue.
        for name, other in pairs(Hub.Interaction.Contexts) do
            if Hub.StorySafeConverses[name] and Elysium.Converse.IsClient.Converses[name] then
                Hub.StoryConverseRun(name, nil)
                task.wait(1.5)
                return
            end
            if Hub.StorySafeConverses[name] then Hub.StoryInteract(name, other) task.wait(2.5) return end
        end
        if Hub.StoryUsePrompt() then return end
        -- The quest marker can sit away from the real trigger zone (Collect_HallKey_PI): walk into the zone part.
        local zones = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Data")
        zones = zones and zones:FindFirstChild("Quests") and zones.Quests:FindFirstChild("Zones")
        local zone = zones and zones:FindFirstChild(id, true)
        if zone and zone:IsA("BasePart") then
            local local_ = zone.CFrame:PointToObjectSpace(root.Position)
            local half = zone.Size / 2
            if math.abs(local_.X) > half.X or math.abs(local_.Y) > half.Y or math.abs(local_.Z) > half.Z then
                Hub.Hop(zone.Position)
                Hub.HoldAt = CFrame.new(zone.Position)
                task.wait(0.8)
                Hub.HoldAt = nil
                return
            end
        end
        -- No button yet: the zone was missed (on top of the object). Step around it at its height.
        Hub.NudgeIndex = (Hub.NudgeIndex or 0) % 4 + 1
        local offsets = {Vector3.new(3, 0, 0), Vector3.new(-3, 0, 0), Vector3.new(0, 0, 3), Vector3.new(0, 0, -3)}
        local spot = position + offsets[Hub.NudgeIndex]
        Hub.HoldAt = CFrame.lookAt(spot, Vector3.new(position.X, spot.Y, position.Z))
        task.wait(0.6)
        Hub.HoldAt = nil
        task.wait(0.4)
    end
end

-- Auto Geppo: Sky Hermit quest (500 Gold, checked by the game), 7 checkpoints, learn at the summit.
Hub.GeppoFlags = {Vector3.new(-3467.3, 16.8, -2974.9), Vector3.new(-3426.2, 100.3, -2759.8), Vector3.new(-3595.4, 142.2, -2746.7),
    Vector3.new(-3398.5, 232.4, -2832.8), Vector3.new(-3402.9, 379.9, -2794.4), Vector3.new(-3546.0, 519.9, -2825.3), Vector3.new(-3470.0, 682.6, -2841.4)}
function Hub.NeedGeppo()
    local data = Hub.Data()
    local learned = data.Abilitys and tonumber(data.Abilitys.Geppo) or 0
    return learned < 1 and (Hub.GeppoTries or 0) < 2 and (tonumber(data.Statistics.Level) or 1) >= 10
        and (tonumber(data.Monetization.Gold) or 0) >= 600
end
function Hub.LearnGeppo()
    Hub.GeppoTries = (Hub.GeppoTries or 0) + 1
    Hub.FarmTarget, Hub.State = nil, "Geppo: Sky Hermit"
    if not Hub.Hop(Vector3.new(103.6, 26, 531.9)) then return end
    task.wait(0.6)
    Elysium.Network:FireServer("Elysium_Converse", "SkyHermit", "Accept")
    task.wait(1.5)
    for index, flag in ipairs(Hub.GeppoFlags) do
        if not Hub.FarmOn() or not S.AutoGeppo then return end
        Hub.State = "Geppo: checkpoint " .. index
        if not Hub.Hop(flag + Vector3.new(0, 3, 0)) then return end
        task.wait(0.5)
        Elysium.Network:FireServer("Parkour", "Activate", "Heavenstep Mountain", index)
        task.wait(0.6)
    end
    Hub.State = "Geppo: summit"
    if not Hub.Hop(Vector3.new(-3494, 684, -2833)) then return end
    task.wait(0.6)
    Elysium.Network:FireServer("Elysium_Converse", "SkyHermitSummit", "Learn")
    task.wait(2)
    Hub.HoldAt = nil
    local data = Hub.Data()
    if data.Abilitys and (tonumber(data.Abilitys.Geppo) or 0) >= 1 then
        Hub.GeppoTries = 0
        Hub.Library:Notify({Title = "Geppo learned", Description = "Double jump unlocked", Time = 6})
    end
end

-- Vox (Askard, Skull Island). Mastery levels are paid in Gold through his dialogue (checked by the game).
Hub.VoxAbilities = {Kenbushoku = "TrainVoxSense", Busoshoku = "TrainVoxArmor"}
Hub.VoxFail = {}
function Hub.VoxQuestObjective(data, key)
    local q, progress = MainModules.QuestsInfo[key], data.Quests.Actives[key]
    if type(q) ~= "table" or not progress then return end
    for stage, sub in ipairs(q.SubQuests or {}) do
        if not MainModules.QuestsUtils.IsSubQuestCompleted(progress[stage], sub) then
            for slot, objective in ipairs(sub.Objectives) do
                local done = tonumber(progress[stage] and progress[stage][slot]) or 0
                if done < objective.Goal then return key, stage, slot, objective, done end
            end
            return
        end
    end
end
-- Next training to do: an accepted one first, then one you can pay and have the level for.
function Hub.VoxPlan(data)
    data = data or Hub.Data()
    local VT = MainModules.VoxTraining
    if not (data and VT) then return end
    local abilities = data.Abilitys or {}
    for ability, key in pairs(Hub.VoxAbilities) do
        if S[key] and data.Quests.Actives[VT.Quests[ability]] and (Hub.VoxFail[ability] or 0) < os.clock() then
            return ability, VT.Quests[ability], true
        end
    end
    local gold, level = tonumber(data.Monetization.Gold) or 0, tonumber(data.Statistics.Level) or 1
    for ability, key in pairs(Hub.VoxAbilities) do
        local current = tonumber(abilities[ability]) or 0
        local step = current >= 1 and VT.GetStep(ability, current + 1)
        if S[key] and step and level >= step.MinLevel and gold >= step.Price and (Hub.VoxFail[ability] or 0) < os.clock() then
            return ability, VT.Quests[ability], false
        end
    end
end
-- Never cut an escort, a carried chest or a boss fight.
function Hub.VoxCanInterrupt()
    local char = player.Character
    return char ~= nil and char:GetAttribute("CarriedNpc") == nil and char:GetAttribute("CarriedChest") == nil and not Hub.BossFight
end
function Hub.VoxIdle()
    Hub.FarmTarget, Hub.HoldAt = nil, nil
    Hub.State = "Vox: waiting for Gold or level"
    task.wait(1)
end
function Hub.AskardPoint()
    local ok, point = pcall(function()
        return require(RS.Shared.MainModules.OtherUtils.InterestPoints):Get("Character_Askard")
    end)
    if ok and point then return Hub.StoryPoint({InterestPoint = point, ObjectiveID = "Talk_Askard"}) end
end
function Hub.VoxTrainStep()
    local ability, quest, active = Hub.VoxPlan()
    if not ability then return end
    local name = MainModules.VoxTraining.Names[ability]
    if not active then
        Hub.FarmTarget, Hub.State = nil, "Vox: going to Askard"
        local position = Hub.AskardPoint()
        if not position then Hub.VoxFail[ability] = os.clock() + 60 Hub.State = "Vox: Askard not found" task.wait(1) return end
        local root = Hub.Root()
        if root and (root.Position - position).Magnitude > 12 then
            if not Hub.Hop(position + Vector3.new(4, 2, 0)) then return end
            task.wait(0.6)
        end
        Hub.HoldAt = nil
        Hub.State = "Vox: paying " .. name .. " lesson"
        Elysium.Network:FireServer("Elysium_Converse", "Askard", "AcceptMastery", ability)
        local limit = os.clock() + 5
        repeat task.wait(0.3) until Hub.Data().Quests.Actives[quest] or os.clock() > limit
        local started = Hub.Data().Quests.Actives[quest] ~= nil
        task.wait()
        if started then
            Hub.Library:Notify({Title = "Vox training", Description = name .. " lesson started", Time = 5})
        else
            Hub.VoxFail[ability] = os.clock() + 120
            Hub.State = "Vox: Askard refused"
        end
        return
    end
    -- Run the accepted lesson with the story engine; a stop only pauses this training.
    Hub.VoxQuest = quest
    local stop = Hub.StopStory
    Hub.StopStory = function(reason)
        Hub.VoxFail[ability] = os.clock() + 120
        Hub.FarmTarget, Hub.HoldAt = nil, nil
        Hub.State = "Vox: " .. tostring(reason)
    end
    local ok, err = pcall(Hub.StoryStep)
    Hub.StopStory, Hub.VoxQuest = stop, nil
    if not ok then error(err, 0) end
end
-- Auto Complete abilities: side quests that teach Soru, Vox Sense and Vox Armor, run on the story engine.
-- Soru (Phantom Rush) is free; Askard's lessons cost Gold only (never premium currency).
Hub.AbilityQuests = {
    {Name = "Soru", Toggle = "AutoSoru", Quest = "The Phantom Tablet", Ability = "Soru", Level = 85, Gold = 0,
        Npc = "MysteriousMonk", Anchor = "Mysterious Monk", Point = "Character_MysteriousMonk", Accept = "Accept", Talk = "Talk_MysteriousMonk_SQ"},
    {Name = "Vox Sense", Toggle = "AutoLearnSense", Quest = "Vox Sense Training", Ability = "Kenbushoku", Level = 145, Gold = 5000,
        Npc = "Askard", Anchor = "Askard", Point = "Character_Askard", Accept = "AcceptSense"},
    {Name = "Vox Armor", Toggle = "AutoLearnArmor", Quest = "Vox Armor Training", Ability = "Busoshoku", Level = 145, Gold = 5000,
        Npc = "Askard", Anchor = "Askard", Point = "Character_Askard", Accept = "AcceptArmor", After = "Kenbushoku"},
}
Hub.AbilityFailAt = {}
function Hub.AbilityPlan(spec, data)
    data = data or Hub.Data()
    if not data or not S[spec.Toggle] or os.clock() < (Hub.AbilityFailAt[spec.Name] or 0) then return end
    local abilities = data.Abilitys or {}
    if (tonumber(abilities[spec.Ability]) or 0) >= 1 then return end
    if data.Quests.Actives[spec.Quest] then return "active" end
    if spec.After and (tonumber(abilities[spec.After]) or 0) < 1 then return end
    if (tonumber(data.Statistics.Level) or 1) < spec.Level then return end
    if spec.Gold > 0 and (tonumber(data.Monetization and data.Monetization.Gold) or 0) < spec.Gold then return end
    return "accept"
end
function Hub.AbilityNext()
    local data = Hub.Data()
    for _, spec in ipairs(Hub.AbilityQuests) do
        if Hub.AbilityPlan(spec, data) then return spec end
    end
end
-- Status for the Auto Complete card.
function Hub.AbilityStatus(spec, data)
    local abilities = data and data.Abilitys or {}
    if (tonumber(abilities[spec.Ability]) or 0) >= 1 then return "done" end
    if data and data.Quests.Actives[spec.Quest] then return "in progress" end
    if data and (tonumber(data.Statistics.Level) or 1) < spec.Level then return "level " .. spec.Level end
    return spec.Gold > 0 and (spec.Gold .. " Gold") or "ready"
end
function Hub.NpcPosition(spec)
    local anchor = RS.NpcAnchors:FindFirstChild(spec.Anchor)
    if anchor then return anchor.Value.Position end
    local ok, point = pcall(function()
        return require(RS.Shared.MainModules.OtherUtils.InterestPoints):Get(spec.Point)
    end)
    if ok and point then return Hub.StoryPoint({InterestPoint = point, ObjectiveID = spec.Talk or ("Talk_" .. spec.Npc)}) end
end
function Hub.AbilityGo(spec)
    local position = Hub.NpcPosition(spec)
    if not position then return false end
    local root = Hub.Root()
    if root and (root.Position - position).Magnitude > 12 then
        if not Hub.Hop(position + Vector3.new(4, 2, 0)) then return false end
        task.wait(0.6)
    end
    Hub.HoldAt = nil
    return true
end
function Hub.AbilityStep(spec)
    local plan = Hub.AbilityPlan(spec)
    if not plan then return end
    local fail = function(reason)
        Hub.AbilityFailAt[spec.Name] = os.clock() + 120
        Hub.FarmTarget, Hub.HoldAt = nil, nil
        Hub.State = spec.Name .. ": " .. tostring(reason)
    end
    if plan == "accept" then
        Hub.FarmTarget, Hub.State = nil, spec.Name .. ": going to " .. spec.Anchor
        if not Hub.AbilityGo(spec) then fail(spec.Anchor .. " not found") task.wait(1) return end
        Hub.State = spec.Name .. ": taking the quest"
        Elysium.Network:FireServer("Elysium_Converse", spec.Npc, spec.Accept)
        local limit = os.clock() + 5
        repeat task.wait(0.3) until Hub.Data().Quests.Actives[spec.Quest] or os.clock() > limit
        local started = Hub.Data().Quests.Actives[spec.Quest] ~= nil
        task.wait()
        if not started then fail("quest refused") end
        return
    end
    -- Monk talk: the dialogue ends by sending "Talk" (no cost); send it next to him.
    local _, _, _, objective = Hub.VoxQuestObjective(Hub.Data(), spec.Quest)
    if spec.Talk and objective and objective.ObjectiveID == spec.Talk then
        Hub.FarmTarget, Hub.State = nil, spec.Name .. ": talking to " .. spec.Anchor
        Hub.AbilityGo(spec)
        Elysium.Network:FireServer("Elysium_Converse", spec.Npc, "Talk")
        task.wait(2)
        return
    end
    -- The quest runs on the story engine; a stop only pauses this ability for two minutes.
    Hub.VoxQuest = spec.Quest
    local stop = Hub.StopStory
    Hub.StopStory = fail
    local ok, err = pcall(Hub.StoryStep)
    Hub.StopStory, Hub.VoxQuest = stop, nil
    if not ok then error(err, 0) end
end
-- Auto Vox Armor / Sense: switch the form back on whenever it drops.
task.spawn(function()
    local last = {}
    while Hub.Alive do
        task.wait(1)
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if (S.AutoVoxArmor or S.AutoVoxSense) and hum and hum.Health > 0 and not Hub.Paused and Elysium then
            local okData, data = pcall(Hub.Data)
            local abilities = okData and data and data.Abilitys or {}
            local locked = Hub.Interaction and Hub.Interaction.GetLockReason()
            for ability, key in pairs({Busoshoku = "AutoVoxArmor", Kenbushoku = "AutoVoxSense"}) do
                local wait = char:GetAttribute("Break" .. ability) ~= nil and 15 or 4
                if S[key] and not locked and (tonumber(abilities[ability]) or 0) >= 1 and char:GetAttribute(ability) == nil
                    and os.clock() - (last[ability] or 0) > wait then
                    last[ability] = os.clock()
                    pcall(function() Elysium.Network:FireServer(ability, "Toggle") end)
                end
            end
        end
    end
end)
-- Level Up screen: the game waits for Enter / gamepad A before freeing the character.
task.spawn(function()
    local VIM = game:GetService("VirtualInputManager")
    while Hub.Alive do
        task.wait(0.5)
        local gui = player:FindFirstChild("PlayerGui")
        local hud = gui and gui:FindFirstChild("ScreenGuis")
        hud = hud and hud:FindFirstChild("MainUI")
        hud = hud and hud:FindFirstChild("PowerDiscoveryHUD")
        if hud and hud.Visible and not Hub.Paused and (Hub.FarmOn() or S.AutoVoxArmor or S.AutoVoxSense) then
            task.wait(1.5)
            if hud.Visible then
                pcall(function()
                    VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                    task.wait(0.05)
                    VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                end)
            end
        end
    end
end)
-- Vox tab labels.
task.spawn(function()
    while Hub.Alive do
        local trainText, infoText, abilityText
        pcall(function()
            local data, VT = Hub.Data(), MainModules.VoxTraining
            local abilities, gold = data.Abilitys or {}, tonumber(data.Monetization.Gold) or 0
            local level, lines = tonumber(data.Statistics.Level) or 1, {}
            for _, ability in ipairs({"Kenbushoku", "Busoshoku"}) do
                local current = tonumber(abilities[ability]) or 0
                local step = VT.GetStep(ability, current + 1)
                local text = VT.Names[ability] .. "  Lv." .. current .. "/" .. VT.GetMaxLevel(ability)
                if current < 1 then text ..= "  not learned"
                elseif not step then text ..= "  mastered"
                else
                    text ..= string.format("  next %s Gold", Hub.Commas and Hub.Commas(step.Price) or tostring(step.Price))
                    if level < step.MinLevel then text ..= ", level " .. step.MinLevel end
                end
                table.insert(lines, text)
            end
            table.insert(lines, "Gold  " .. (Hub.Commas and Hub.Commas(gold) or tostring(gold)))
            if Hub.VoxQuest or tostring(Hub.State):find("^Vox") then table.insert(lines, Hub.State) end
            trainText = table.concat(lines, "\n")
            local done = {"Geppo  " .. ((tonumber(abilities.Geppo) or 0) >= 1 and "done" or "500 Gold")}
            for _, spec in ipairs(Hub.AbilityQuests) do table.insert(done, spec.Name .. "  " .. Hub.AbilityStatus(spec, data)) end
            abilityText = table.concat(done, "\n")
        end)
        task.wait() -- restore UI capability after native data reads
        if trainText then pcall(Hub.VoxTrainLabel.SetText, Hub.VoxTrainLabel, trainText) end
        if abilityText then pcall(Hub.AbilityLabel.SetText, Hub.AbilityLabel, abilityText) end
        for mirror, main in pairs(Hub.VoxMirror or {}) do
            local a, b = Toggles[mirror], Toggles[main]
            if a and b and a.Value ~= b.Value then pcall(a.SetValue, a, b.Value) end
        end
        task.wait(1)
    end
end)
-- Auto Equip Best Accessories: score each piece from its real rolled stats, best per slot.
Hub.AccessoryMain = {Sword = "Sword", Melee = "Strength", Gun = "Gun", Fruit = "Vox Fruit"}
function Hub.AccessoryScore(info, data)
    local ok, lines = pcall(function()
        return MainModules.ToolsModifiers.ConvertModifiersInfo(MainModules.ToolsUtils.GetModifiersInfo(info, data), nil, data,
            MainModules.ToolsUtils.GetRollableSet(info))
    end)
    if not ok or type(lines) ~= "table" then return 0 end
    local main, score = Hub.AccessoryMain[S.Weapon] or "Sword", 0
    for _, line in ipairs(lines) do
        local text = tostring(line):gsub("<[^>]*>", "")
        local amount, stat = text:match("([%-%d%.]+)%s+(.+)$")
        amount = tonumber(amount) or 0
        stat = stat and stat:gsub("%s+$", "") or ""
        if stat == main then score += amount
        elseif stat == "Endurance" then score += amount * 0.25
        elseif stat == "Health" or stat == "Stamina" then score += amount * 0.02
        elseif stat:find("Range") or stat:find("Critical") then score += amount * 0.05 end
    end
    return score
end
function Hub.FindTool(list, name)
    for index, item in ipairs(Hub.Data().Tools[list] or {}) do
        if item.Name == name then return index end
    end
end
function Hub.EquipBestAccessories()
    local data = Hub.Data()
    local tools, level = data.Tools, tonumber(data.Statistics.Level) or 1
    local limits = MainModules.ToolsUtils.EquipLimits or {}
    local slots = {}
    Hub.AccessoryBad = Hub.AccessoryBad or {}
    for _, list in ipairs({"Equiped", "Unequiped"}) do
        for _, item in ipairs(tools[list] or {}) do
            local info = MainModules.ToolsInfo:Get(item.Name)
            -- Pieces above your level (or that failed to equip recently) are never chosen.
            local usable = list == "Equiped" or ((tonumber(info and info.Level) or 0) <= level and (Hub.AccessoryBad[item.Name] or 0) < os.clock())
            if info and info.ToolType == "Accessory" and info.SubType and usable then
                slots[info.SubType] = slots[info.SubType] or {}
                table.insert(slots[info.SubType], {Name = item.Name, List = list, Score = Hub.AccessoryScore(info, item)})
            end
        end
    end
    for slot, items in pairs(slots) do
        table.sort(items, function(a, b) return a.Score > b.Score end)
        local keep = tonumber(limits[slot]) or (slot == "Ring" and 2 or 1)
        local equipped, worst = 0, nil
        for _, item in ipairs(items) do
            if item.List == "Equiped" then
                equipped += 1
                if not worst or item.Score < worst.Score then worst = item end
            end
        end
        local best
        for _, item in ipairs(items) do
            if item.List == "Unequiped" then best = item break end
        end
        if best and (equipped < keep or worst and best.Score > worst.Score + 0.01) then
            -- One swap per call; indexes are looked up again from fresh data.
            if equipped >= keep and worst then
                local out = Hub.FindTool("Equiped", worst.Name)
                if out then Elysium.Network:FireServer("ToolsData", "Unequip", out, worst.Name) task.wait(0.8) end
            end
            local into = Hub.FindTool("Unequiped", best.Name)
            if into then Elysium.Network:FireServer("ToolsData", "Equip", into, best.Name) end
            task.wait(1)
            if not Hub.FindTool("Equiped", best.Name) then
                Hub.AccessoryBad[best.Name] = os.clock() + 600
                -- Put the previous piece back so the slot is never left empty.
                local back = worst and Hub.FindTool("Unequiped", worst.Name)
                if back then Elysium.Network:FireServer("ToolsData", "Equip", back, worst.Name) end
            end
            Hub.AccessorySwaps = (Hub.AccessorySwaps or 0) + 1
            Hub.LastAccessorySwap = slot .. ": " .. best.Name .. (worst and (" over " .. worst.Name) or "")
            return true
        end
    end
    return false
end
task.spawn(function()
    while Hub.Alive do
        if Hub.UIReady and S.AutoAccessories and not Hub.Paused then
            local ok, changed = pcall(Hub.EquipBestAccessories)
            if not ok then Hub.AccessoryError = tostring(changed) end
            task.wait(ok and changed and 1.5 or 15)
        else
            task.wait(1)
        end
    end
end)

-- BEGIN fruit-finder.luau
Hub.FruitModule = (function()
-- Archivist Hub - Vox Seas: Auto Fruit Finder.
-- Research and evidence: games/vox-seas/research/fruit-finder.md
--
-- Integration (inside vox-seas.luau, after Hub.Tabs / Hub.Toggles exist):
--     local Fruit = loadFruitFinder(Hub, Elysium, S)      -- this file's returned function
--     Fruit.BuildUI(someGroupbox)                          -- optional, four controls and a status line
-- The module is self-contained: its own settings keys, travel, hold loop and server hop.
-- While it is fetching a fruit it sets Hub.FruitBusy and makes Hub.FarmOn() return false,
-- so Farm / Story stand still and resume by themselves afterwards.
--
-- Facts it relies on (PlaceVersion 12467):
--   * Fruits on the map are Tools in workspace.Playability.DroppedTools (a Persistent model:
--     they replicate at any distance), attribute Fruit = true, Handle with a TouchInterest.
--   * Storing: Network:FireServer("ToolsData", "Store") with the fruit held.
--   * Storage is per fruit name: Tools.MaxStoredFruits + crew slots (bank and listings count).
--   * Servers: ServerList.IsClient:GetActiveServers() and "ServerList" "JoinPublicServer".
-- Nothing here spends currency of any kind.

return function(Hub, Elysium, S)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local HttpService = game:GetService("HttpService")
    local RS = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer
    local MainModules = require(RS:WaitForChild("Shared"):WaitForChild("MainModules"))

    local M = {
        Alive = true, Status = "Off", Fruits = {}, Failed = {}, Connections = {},
        Stats = {Seen = 0, Picked = 0, Stored = 0, Lost = 0, Hops = 0},
        -- Travel numbers measured by the hub on this game (notas.md): 800 studs/s accepted,
        -- 1600 rejected; 200-stud steps every 0.9 s as the slow fallback.
        Speed = 800, SlowSpeed = 400, StepSize = 200, StepWait = 0.9, Clearance = 60,
        -- One natural spawn was seen 60 minutes after the server started and it was gone
        -- about 20 minutes later. One observation only: it orders the hop list (servers
        -- inside that window first), it never blocks a hop.
        SpawnPeriod = 3600, FruitLife = 1200,
        VisitTTL = 1800,     -- seconds before a visited server may be tried again (no StartedAt)
        HopGrace = 2.5,      -- seconds after loading before the first hop (replication margin)
        HopGap = 6,          -- minimum seconds between join requests
        InstantGrab = false, -- touch from any distance without moving. NOT tested: keep off.
        StateFile = "archivist_voxseas_fruit_" .. player.UserId .. ".json",
        LoadedAt = os.clock(),
    }
    Hub.Fruit = M

    -- Settings: own keys, read straight from the hub's file so they survive reloads even
    -- before the hub lists them in its DEFAULTS.
    local DEFAULTS = {FruitFinder = false, FruitHop = false, FruitStore = true, FruitMinRarity = "Common"}
    M.Defaults = DEFAULTS
    do
        local saved
        pcall(function()
            local file = "archivist_voxseas_" .. player.UserId .. ".json"
            if isfile(file) then saved = HttpService:JSONDecode(readfile(file)) end
        end)
        for key, value in pairs(DEFAULTS) do
            if type(Hub.DEFAULTS) == "table" and Hub.DEFAULTS[key] == nil then Hub.DEFAULTS[key] = value end
            if S[key] == nil or type(S[key]) ~= type(value) then
                if type(saved) == "table" and type(saved[key]) == type(value) then S[key] = saved[key] else S[key] = value end
            end
        end
    end

    local RARITY = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical"}
    M.Rarities = RARITY
    local function rank(rarity) return table.find(RARITY, rarity) or 1 end
    local function notify(title, text, time)
        -- DataStore:Get lowers this thread's identity until the next yield; notify from a
        -- fresh resumed thread so the interface call always has its capability.
        task.spawn(function()
            task.wait()
            pcall(function() Hub.Library:Notify({Title = title, Description = text, Time = time or 5}) end)
        end)
    end
    local function rootOf()
        local char = player.Character
        return char and char:FindFirstChild("HumanoidRootPart"), char and char:FindFirstChildOfClass("Humanoid"), char
    end
    local function dropped()
        local playability = workspace:FindFirstChild("Playability")
        return playability and playability:FindFirstChild("DroppedTools")
    end
    local function serverPosition()
        local position = player:GetAttribute("ServerPosition")
        return typeof(position) == "Vector3" and position or nil
    end
    local function info(name)
        local ok, result = pcall(function() return MainModules.ToolsInfo:Get(name) end)
        return ok and type(result) == "table" and result or nil
    end
    function M.On() return M.Alive and Hub.Alive and (S.FruitFinder == true or M.Errand == true) and not Hub.Paused end

    -- Persistent state: visited servers and a small observation log (server age when a fruit
    -- was or was not there), to confirm the spawn period with real data over time.
    function M.LoadState()
        local state
        pcall(function()
            if isfile(M.StateFile) then state = HttpService:JSONDecode(readfile(M.StateFile)) end
        end)
        if type(state) ~= "table" then state = {} end
        if type(state.Visited) ~= "table" then state.Visited = {} end
        if type(state.Log) ~= "table" then state.Log = {} end
        local now = os.time()
        for job, at in pairs(state.Visited) do
            if type(at) ~= "number" or now - at > 7200 then state.Visited[job] = nil end
        end
        return state
    end
    function M.SaveState(state)
        while #state.Log > 200 do table.remove(state.Log, 1) end
        pcall(writefile, M.StateFile, HttpService:JSONEncode(state))
    end
    function M.Observe(fruitName)
        local state = M.LoadState()
        local started
        pcall(function() started = Elysium.ServerList.IsClient.CurrentInfo.DeltaTime end)
        table.insert(state.Log, {T = os.time(), Job = game.JobId, Age = type(started) == "number" and math.floor(os.time() - started) or nil,
            Fruit = fruitName or false})
        state.Visited[game.JobId] = os.time()
        M.SaveState(state)
    end

    -- Storage: one stack per fruit name, up to MaxStoredFruits + crew slots.
    function M.Owned(name)
        local ok, amount = pcall(function()
            local data, total = Elysium.DataStore:Get(), 0
            for _, list in ipairs({data.Tools.Equiped, data.Tools.Unequiped, data.Tools.Bank}) do
                for _, item in ipairs(list) do
                    if item.Name == name then total += item.Quantity or 1 end
                end
            end
            for _, listing in ipairs(data.Market and data.Market.Listings or {}) do
                if listing.ToolData and listing.ToolData.Name == name then total += listing.ToolData.Quantity or 1 end
            end
            return total
        end)
        return ok and amount or 0
    end
    function M.Capacity()
        local ok, amount = pcall(function()
            local extra = player:GetAttribute("CrewFruitSlots")
            return Elysium.DataStore:Get().Tools.MaxStoredFruits + (typeof(extra) == "number" and math.floor(extra) or 0)
        end)
        return ok and amount or 1
    end
    function M.CanStore(name) return M.Owned(name) < M.Capacity() end

    -- Cache by events: DroppedTools.ChildAdded / ChildRemoved. No sweeps.
    function M.IsFruit(tool)
        if not tool:IsA("Tool") then return false end
        if tool:GetAttribute("Fruit") == true then return true end
        local data = info(tool.Name)
        return data ~= nil and data.ToolType == "Dropped Fruit"
    end
    function M.Track(tool)
        if M.Fruits[tool] or not tool:IsA("Tool") then return end
        if not M.IsFruit(tool) then
            -- The attribute can arrive just after the instance.
            local connection
            connection = tool:GetAttributeChangedSignal("Fruit"):Connect(function()
                connection:Disconnect()
                if M.Alive then M.Track(tool) end
            end)
            table.insert(M.Connections, connection)
            return
        end
        local data = info(tool.Name)
        M.Fruits[tool] = {Name = tool.Name, Rarity = data and data.Rarity or "Common", At = os.clock()}
        M.Stats.Seen += 1
        if S.FruitFinder then notify("Fruit Finder", tool.Name .. " on the map", 5) end
    end
    function M.Untrack(tool) M.Fruits[tool] = nil M.Failed[tool] = nil end
    function M.Watch()
        local folder = dropped()
        if not folder or M.Watching == folder then return folder ~= nil end
        M.Watching = folder
        table.insert(M.Connections, folder.ChildAdded:Connect(function(child)
            task.defer(function() if M.Alive then M.Track(child) end end)
        end))
        table.insert(M.Connections, folder.ChildRemoved:Connect(M.Untrack))
        for _, child in ipairs(folder:GetChildren()) do M.Track(child) end
        return true
    end
    function M.Position(tool)
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart", true)
        return handle and handle.Position, handle
    end
    -- Best fruit to fetch now: highest rarity first, then nearest. Skips what cannot be kept.
    function M.Best()
        local folder, root = dropped(), rootOf()
        local best, bestRank, bestDistance
        local minimum = rank(S.FruitMinRarity)
        for tool, entry in pairs(M.Fruits) do
            if tool.Parent ~= folder then
                M.Untrack(tool)
            elseif rank(entry.Rarity) >= minimum and (M.Failed[tool] or 0) < os.clock() then
                local position = M.Position(tool)
                if position and (not S.FruitStore or M.CanStore(entry.Name)) and not (S.AutoDropFruits and M.Owned(entry.Name) > 0) then
                    local distance = root and (position - root.Position).Magnitude or 0
                    local value = rank(entry.Rarity)
                    if not best or value > bestRank or (value == bestRank and distance < bestDistance) then
                        best, bestRank, bestDistance = tool, value, distance
                    end
                elseif position and not entry.FullNotice then
                    entry.FullNotice = true
                    notify("Fruit Finder", "No storage for " .. entry.Name, 6)
                end
            end
        end
        return best
    end

    -- Hold loop: the fetch position is re-applied every frame, like the hub's farm hold.
    table.insert(M.Connections, RunService.Heartbeat:Connect(function()
        local spot = M.HoldAt
        if not spot then return end
        local root, hum = rootOf()
        if not root or not hum or hum.Health <= 0 or root.Anchored or not M.On() then M.HoldAt = nil return end
        root.CFrame = spot
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end))
    -- Farm and Story stand still while a fruit is being fetched.
    do
        local base = Hub.FarmOn
        if type(base) == "function" then
            M.BaseFarmOn = base
            M.WrappedFarmOn = function(...) return not Hub.FruitBusy and base(...) end
            Hub.FarmOn = M.WrappedFarmOn
        end
    end
    function M.SetBusy(busy)
        Hub.FruitBusy = busy or nil
        if busy then
            Hub.HoldAt, Hub.FarmTarget = nil, nil
            if type(Hub.CancelStoryMotion) == "function" then pcall(Hub.CancelStoryMotion) end
        else
            M.HoldAt, M.Target = nil, nil
            -- The story's own stall timer must not count the detour.
            if Hub.StoryProgressAt then Hub.StoryProgressAt = os.clock() end
        end
    end
    -- Reasons not to leave right now. Carrying an NPC or a chest: any forced move makes the
    -- server throw the character into the void (notas.md), so the fruit waits.
    -- Priority tab: fruits wait while a higher ranked mode is on.
    function Hub.FruitBlocked()
        if S.AutoStory and Hub.Rank("Story") < Hub.Rank("Fruits") then return "Story goes first" end
        if (S.Farm or S.FarmMob) and Hub.Rank("Farm") < Hub.Rank("Fruits") then return "Farm goes first" end
    end
    function M.Blocked()
        local root, hum, char = rootOf()
        if not root or not hum or hum.Health <= 0 then return "No character" end
        if root.Anchored then return "Scene running" end
        if char:GetAttribute("CarriedNpc") ~= nil or char:GetAttribute("CarriedChest") ~= nil then return "Carrying" end
        if root.Position.Y < -5000 then return "Out of the map" end
        if type(Hub.FruitBlocked) == "function" then
            local ok, reason = pcall(Hub.FruitBlocked)
            if ok and reason then return tostring(reason) end
        end
        return nil
    end
    function M.Going()
        if not M.On() then return false end
        local target = M.Target
        return target == nil or target.Parent == dropped()
    end
    function M.Segment(goal, speed)
        local root, hum = rootOf()
        if not root or not hum or hum.Health <= 0 or root.Anchored then return false end
        local from = root.Position
        local duration, started = (goal - from).Magnitude / speed, os.clock()
        local flat = Vector3.new(goal.X - from.X, 0, goal.Z - from.Z)
        local facing = flat.Magnitude > 0.1 and flat.Unit or root.CFrame.LookVector
        local badSince
        repeat
            if not M.Going() or not root.Parent or hum.Health <= 0 or root.Anchored then M.HoldAt = nil return false end
            local alpha = duration > 0 and math.min(1, (os.clock() - started) / duration) or 1
            local position = from:Lerp(goal, alpha)
            M.HoldAt = CFrame.lookAt(position, position + facing)
            local server = serverPosition()
            if server and (root.Position - server).Magnitude > math.max(800, speed) then
                badSince = badSince or os.clock()
                if os.clock() - badSince > 0.8 then
                    M.HoldAt = CFrame.new(server)
                    task.wait(0.3)
                    return false
                end
            else
                badSince = nil
            end
            task.wait()
        until os.clock() - started >= duration
        M.HoldAt = CFrame.lookAt(goal, goal + facing)
        task.wait(0.65)
        local server = serverPosition()
        if server and (server - goal).Magnitude > 30 then
            M.HoldAt = CFrame.new(server)
            task.wait(0.3)
            return false
        end
        return true
    end
    -- Go to a point: climb, cruise and descend for long trips; short steps as the fallback.
    function M.Travel(goal)
        local root = rootOf()
        if not root or not M.Going() then return false end
        if (goal - root.Position).Magnitude > 600 then
            local altitude = math.max(root.Position.Y, goal.Y) + M.Clearance
            for _, waypoint in ipairs({Vector3.new(root.Position.X, altitude, root.Position.Z),
                Vector3.new(goal.X, altitude, goal.Z), goal}) do
                if not M.Segment(waypoint, M.Speed) then
                    if not M.Going() or M.Blocked() then M.HoldAt = nil return false end
                    M.Speed = M.SlowSpeed
                    if not M.Segment(waypoint, M.SlowSpeed) then break end
                end
            end
            root = rootOf()
            if root and (root.Position - goal).Magnitude < 30 then return true end
        end
        while M.Going() do
            root = rootOf()
            if not root or root.Anchored or root.Position.Y < -5000 then M.HoldAt = nil return false end
            local offset = goal - root.Position
            if offset.Magnitude <= M.StepSize then
                M.HoldAt = CFrame.new(goal)
                task.wait(0.35)
                local server, waitUntil = serverPosition(), os.clock() + 1.2
                while server and (server - goal).Magnitude > 30 and os.clock() < waitUntil do
                    task.wait(0.15)
                    server = serverPosition()
                end
                if server and (server - goal).Magnitude > 30 then
                    M.HoldAt = CFrame.new(server)
                    return false
                end
                return true
            end
            M.HoldAt = CFrame.new(root.Position + offset.Unit * M.StepSize)
            task.wait(M.StepWait)
        end
        M.HoldAt = nil
        return false
    end

    function M.Mine(tool)
        local _, _, char = rootOf()
        return tool.Parent ~= nil and (tool.Parent == char or tool.Parent == player:FindFirstChildOfClass("Backpack"))
    end
    function M.Touch(handle)
        local touch = firetouchinterest
        local _, _, char = rootOf()
        if type(touch) ~= "function" or not char or not handle.Parent then return end
        for _, name in ipairs({"HumanoidRootPart", "RightFoot", "LeftFoot", "Right Leg", "Left Leg"}) do
            local part = char:FindFirstChild(name)
            if part then
                pcall(touch, part, handle, 0)
                pcall(touch, part, handle, 1)
            end
        end
    end
    -- Pick it up: stand on the handle so the legs overlap it (native Tool touch), with the
    -- executor's touch call as a helper once we are really there.
    function M.Grab(tool)
        local deadline, low = os.clock() + 8, false
        while M.On() and os.clock() < deadline do
            if M.Mine(tool) then return true end
            if tool.Parent ~= dropped() then return false end
            local position, handle = M.Position(tool)
            local root = rootOf()
            if not position or not root or root.Anchored then return false end
            M.HoldAt = CFrame.new(position + Vector3.new(0, low and 0.5 or 2.5, 0))
            low = not low
            task.wait(0.25)
            if handle and (root.Position - handle.Position).Magnitude < 12 then M.Touch(handle) end
            task.wait(0.25)
        end
        return M.Mine(tool)
    end
    -- Store the held fruit. Confirmed by the tool leaving the character and the count going up.
    function M.Store(tool)
        local name = tool.Name
        for _ = 1, 3 do
            local _, hum, char = rootOf()
            if not hum or not char then return false end
            if not M.Mine(tool) then break end
            local before = M.Owned(name)
            task.wait()
            if tool.Parent ~= char then
                pcall(function() hum:EquipTool(tool) end)
                task.wait(0.4)
            end
            if tool.Parent == char then Elysium.Network:FireServer("ToolsData", "Store") end
            local deadline = os.clock() + 3
            repeat task.wait(0.15) until not M.Mine(tool) or M.Owned(name) > before or os.clock() >= deadline
            if M.Owned(name) > before then return true end
        end
        return false
    end
    -- A fruit of ours that is not stored yet (touch pickup leaves it in the hand or backpack).
    function M.Loose()
        local _, _, char = rootOf()
        for _, parent in ipairs({char, player:FindFirstChildOfClass("Backpack")}) do
            for _, tool in ipairs(parent and parent:GetChildren() or {}) do
                if tool:IsA("Tool") and M.IsFruit(tool) then return tool end
            end
        end
        return nil
    end
    -- After a server change the game waits on its start menu: no character until START GAME.
    function M.PressStart()
        local ok, button = pcall(function() return player.PlayerGui.ScreenGuis.StartScreenUI.Buttons.StartGame end)
        if not ok or not button then return false end
        if getconnections then
            for _, connection in ipairs(getconnections(button.Activated)) do pcall(function() connection:Fire() end) end
        elseif firesignal then
            pcall(firesignal, button.Activated)
        else
            return false
        end
        return true
    end
    function M.NeedCharacter(seconds)
        if rootOf() then return true end
        M.Status = "Entering the game"
        M.PressStart()
        local deadline = os.clock() + (seconds or 20)
        repeat task.wait(0.25) until rootOf() or not M.On() or os.clock() >= deadline
        if rootOf() then task.wait(1) return true end
        return false
    end

    function M.Fetch(tool)
        local entry = M.Fruits[tool]
        if not entry then return end
        if not M.NeedCharacter() then return end
        local reason = M.Blocked()
        if reason then M.Status = "Waiting: " .. reason return end
        M.Target = tool
        M.SetBusy(true)
        local ok, err = xpcall(function()
            local got = false
            if M.InstantGrab then
                local _, handle = M.Position(tool)
                local deadline = os.clock() + 1.5
                while handle and not M.Mine(tool) and tool.Parent == dropped() and os.clock() < deadline do
                    M.Touch(handle)
                    task.wait(0.25)
                end
                got = M.Mine(tool)
            end
            if not got then
                local position = M.Position(tool)
                if not position then return end
                M.Status = "Going to " .. entry.Name
                local arrived = M.Travel(position + Vector3.new(0, 5, 0))
                if not arrived then
                    if tool.Parent ~= dropped() then M.Stats.Lost += 1 M.Status = "Fruit taken" return end
                    M.Failed[tool] = os.clock() + 10
                    M.Status = "Travel rejected"
                    return
                end
                M.Status = "Picking " .. entry.Name
                got = M.Grab(tool)
            end
            if not got then
                if tool.Parent ~= dropped() then M.Stats.Lost += 1 M.Status = "Fruit taken"
                else M.Failed[tool] = os.clock() + 30 M.Status = "Pickup failed" end
                return
            end
            M.Stats.Picked += 1
            M.Observe(entry.Name)
            M.HoldAt = nil
            if S.FruitStore then
                M.Status = "Storing " .. entry.Name
                if M.Store(tool) then
                    M.Stats.Stored += 1
                    notify("Fruit Finder", entry.Name .. " stored", 6)
                else
                    notify("Fruit Finder", entry.Name .. " picked, not stored", 8)
                end
            else
                notify("Fruit Finder", entry.Name .. " picked", 6)
            end
            M.Status = "Got " .. entry.Name
        end, function(message) return debug.traceback(tostring(message), 2) end)
        if not ok then M.Error = err M.Status = "Error" end
        M.SetBusy(false)
    end

    -- Server hop through the game's own free list.
    function M.Candidates(list, visited)
        local now, period, result = os.time(), M.SpawnPeriod, {}
        for _, server in ipairs(list) do
            local job = server.JobId
            if type(job) == "string" and job ~= game.JobId and not server.Current
                and (tonumber(server.Players) or 0) < (tonumber(server.MaxPlayers) or 12) then
                local started = type(server.Custom) == "table" and tonumber(server.Custom.StartedAt) or tonumber(server.DeltaTime)
                local seen = visited[job]
                local skip, score
                if started then
                    local age = now - started
                    -- Same hourly cycle as the last visit: nothing new can have appeared.
                    skip = seen ~= nil and math.floor(age / period) == math.floor((seen - started) / period)
                    local phase = age % period
                    if age < period then score = 100000 + period - age
                    elseif phase < M.FruitLife - 90 then score = phase
                    else score = 20000 + period - phase end
                else
                    skip = seen ~= nil and now - seen < M.VisitTTL
                    score = 50000
                end
                if not skip then
                    table.insert(result, {JobId = job, Name = server.Name, Players = tonumber(server.Players) or 0,
                        Score = score + (tonumber(server.Players) or 0) * 5})
                end
            end
        end
        table.sort(result, function(a, b) return a.Score < b.Score end)
        return result
    end
    function M.Hop()
        if M.Hopping or os.clock() - (M.LastJoin or 0) < M.HopGap then return false end
        if not S.AutoLoad or type(Hub.QueueLoad) ~= "function" or not Hub.QueueLoad() then
            M.Status = "Hop needs Auto Execute"
            return false
        end
        M.Hopping = true
        local ok, err = xpcall(function()
            M.Status = "Finding a server"
            local listed, list = pcall(function() return Elysium.ServerList.IsClient:GetActiveServers() end)
            if not listed or type(list) ~= "table" or #list == 0 then M.Status = "No server list" task.wait(5) return end
            local state = M.LoadState()
            state.Visited[game.JobId] = os.time()
            local candidates = M.Candidates(list, state.Visited)
            if #candidates == 0 then
                -- Every listed server was seen this cycle: forget the oldest half and wait a little.
                local jobs = {}
                for job, at in pairs(state.Visited) do table.insert(jobs, {job, at}) end
                table.sort(jobs, function(a, b) return a[2] < b[2] end)
                for index = 1, math.floor(#jobs / 2) do state.Visited[jobs[index][1]] = nil end
                state.Visited[game.JobId] = os.time()
                M.SaveState(state)
                M.Status = "All servers visited"
                task.wait(10)
                return
            end
            for index = 1, math.min(#candidates, 4) do
                if not M.On() or not S.FruitHop or next(M.Fruits) ~= nil and M.Best() then return end
                local server = candidates[index]
                state.Visited[server.JobId] = os.time()
                M.SaveState(state)
                pcall(Hub.Save)
                Hub.QueueLoad()
                M.Status = "Joining " .. tostring(server.Name or "server")
                M.LastJoin = os.clock()
                M.Stats.Hops += 1
                local result = Elysium.Network:SafeInvokeServer(10, "ServerList", "JoinPublicServer", server.JobId)
                M.LastJoinResult = result
                if result == "Success" or result == true or result == nil then
                    -- The teleport takes this client away; if it does not, try the next one.
                    local deadline = os.clock() + 20
                    repeat task.wait(0.5) until not M.On() or os.clock() >= deadline
                else
                    -- Refused (full, closed, or asked from the start menu): enter the game once
                    -- and let the next server be tried.
                    M.Status = "Join refused: " .. tostring(result)
                    if not rootOf() then M.NeedCharacter(20) end
                    task.wait(1.5)
                end
            end
        end, function(message) return debug.traceback(tostring(message), 2) end)
        if not ok then M.Error = err M.Status = "Error" end
        M.Hopping = false
        return ok
    end

    -- Main loop: reads the event cache four times per second; nothing else is scanned.
    task.spawn(function()
        local observed = false
        while M.Alive and Hub.Alive do
            task.wait(0.25)
            if not M.On() then
                if Hub.FruitBusy then M.SetBusy(false) end
                M.Status = S.FruitFinder and "Paused" or "Off"
                continue
            end
            if not M.Watch() then M.Status = "Waiting for the map" continue end
            local ok, err = xpcall(function()
                local tool = M.Best()
                if tool then
                    M.Fetch(tool)
                    return
                end
                local loose = S.FruitStore and M.Loose()
                if loose and M.CanStore(loose.Name) and not M.Blocked() then
                    M.Status = "Storing " .. loose.Name
                    if M.Store(loose) then M.Stats.Stored += 1 end
                    return
                end
                if os.clock() - M.LoadedAt < M.HopGrace then M.Status = "Checking the map" return end
                if not observed then observed = true M.Observe(nil) end
                if not S.FruitHop then M.Status = "Watching the map" return end
                if S.Farm or S.FarmMob or S.AutoStory then M.Status = "Hop waits: farm is on" return end
                if M.Loose() then M.Status = "Holding a fruit: hop off" return end
                M.Hop()
            end, function(message) return debug.traceback(tostring(message), 2) end)
            if not ok then M.Error = err M.Status = "Error" task.wait(2) end
        end
    end)

    -- Interface: four controls and one status line. English, short, no angle brackets.
    function M.BuildUI(box)
        local Toggles, Options = Hub.Toggles, Hub.Options
        box:AddToggle("ArchivistVSFruitFinder", {Text = "Auto Fruit Finder", Default = S.FruitFinder, Tooltip = "Collect fruits on the map"})
        box:AddToggle("ArchivistVSFruitHop", {Text = "Server Hop", Default = S.FruitHop, Tooltip = "Next server when there is no fruit"})
        box:AddToggle("ArchivistVSFruitStore", {Text = "Auto Store", Default = S.FruitStore, Tooltip = "Store each fruit picked"})
        box:AddDropdown("ArchivistVSFruitMinRarity", {Text = "Min Rarity", Values = {"Common", "Rare", "Epic", "Legendary", "Mythical"},
            Default = S.FruitMinRarity, Multi = false})
        for id, key in pairs({ArchivistVSFruitFinder = "FruitFinder", ArchivistVSFruitHop = "FruitHop", ArchivistVSFruitStore = "FruitStore"}) do
            Toggles[id]:OnChanged(function()
                S[key] = Toggles[id].Value == true
                if key == "FruitFinder" and not S[key] and Hub.FruitBusy then M.SetBusy(false) end
                pcall(Hub.Save)
            end)
        end
        Options.ArchivistVSFruitMinRarity:OnChanged(function()
            S.FruitMinRarity = Options.ArchivistVSFruitMinRarity.Value
            pcall(Hub.Save)
        end)
        if type(Hub.AutoToggles) == "table" then
            table.insert(Hub.AutoToggles, "ArchivistVSFruitFinder")
            table.insert(Hub.AutoToggles, "ArchivistVSFruitHop")
        end
        local ok, label = pcall(function() return box:AddLabel("Status: Off") end)
        if ok and label and type(label.SetText) == "function" then
            task.spawn(function()
                local shown
                while M.Alive and Hub.Alive do
                    local text = "Status: " .. tostring(M.Status)
                    if text ~= shown then shown = text pcall(label.SetText, label, text) end
                    task.wait(0.5)
                end
            end)
        end
    end

    function M.Stop()
        M.Alive = false
        for _, connection in ipairs(M.Connections) do pcall(function() connection:Disconnect() end) end
        table.clear(M.Connections)
        if Hub.FruitBusy then M.SetBusy(false) end
        M.HoldAt = nil
        if M.WrappedFarmOn and Hub.FarmOn == M.WrappedFarmOn then Hub.FarmOn = M.BaseFarmOn end
        if Hub.Fruit == M then Hub.Fruit = nil end
    end

    M.Watch()
    return M
end
end)()
-- END fruit-finder.luau
do
    -- Native requires lower the thread capability: yield before touching the interface.
    task.wait()
    local fruitBox = fruitSub:AddGroupbox({Side = "Left", Name = "Fruit Finder", IconName = "apple"})
    local ok, fruit = pcall(Hub.FruitModule, Hub, Elysium, S)
    task.wait()
    if ok then ok, fruit = pcall(fruit.BuildUI, fruitBox) end
    if not ok then Hub.FruitError = tostring(fruit) end
    local gachaBox = fruitSub:AddGroupbox({Side = "Right", Name = "Fruit Gacha", IconName = "dices"})
    gachaBox:AddToggle("ArchivistVSFruitGacha", {Text = "Auto Fruit Gacha", Default = S.FruitGacha, Tooltip = "Spins every 2 hours with Gold"})
    Hub.GachaLabel = gachaBox:AddLabel({Text = "Next spin  -", DoesWrap = true})
    bindToggle("ArchivistVSFruitGacha", "FruitGacha")
    table.insert(Hub.AutoToggles, "ArchivistVSFruitGacha")
    gachaBox:AddToggle("ArchivistVSAutoStoreFruits", {Text = "Auto Store Fruits", Default = S.AutoStoreFruits, Tooltip = "Stores the fruits you carry"})
    gachaBox:AddToggle("ArchivistVSAutoEatFruits", {Text = "Auto Eat Fruits", Default = S.AutoEatFruits, Tooltip = "Eats only a rarer fruit than yours"})
    gachaBox:AddToggle("ArchivistVSAutoDropFruits", {Text = "Auto Drop Fruits", Default = S.AutoDropFruits, Tooltip = "Drops repeated fruits, keeps one"})
    gachaBox:AddDropdown("ArchivistVSDropFruits", {Text = "Always Drop", Tooltip = "Dropped even if not repeated", Values = (function()
        local names = {}
        for name in pairs(MainModules.FruitsUtils.AllFruits or {}) do table.insert(names, tostring(name)) end
        table.sort(names, function(a, b)
            local function info(n) local ok, v = pcall(function() return MainModules.ToolsInfo:Get(n, true) end) return ok and type(v) == "table" and v or nil end
            local ia, ib = info(a), info(b)
            local ra = ({Common = 1, Rare = 2, Epic = 3, Legendary = 4, Mythical = 5})[ia and ia.Rarity] or 9
            local rb = ({Common = 1, Rare = 2, Epic = 3, Legendary = 4, Mythical = 5})[ib and ib.Rarity] or 9
            if ra ~= rb then return ra < rb end
            return a < b
        end)
        task.wait()
        return names
    end)(), AllowNull = true, Default = Hub.SelectedValues(S.DropFruits), Multi = true})
    for _, pair in ipairs({{"ArchivistVSAutoStoreFruits", "AutoStoreFruits"}, {"ArchivistVSAutoEatFruits", "AutoEatFruits"}, {"ArchivistVSAutoDropFruits", "AutoDropFruits"}}) do
        bindToggle(pair[1], pair[2])
        table.insert(Hub.AutoToggles, pair[1])
    end
    Options.ArchivistVSDropFruits:OnChanged(function()
        S.DropFruits = {}
        for name, on in pairs(Options.ArchivistVSDropFruits.Value) do if on then S.DropFruits[name] = true end end
        save()
    end)
    fruitBox:AddToggle("ArchivistVSFruitESP", {Text = "Fruit ESP", Default = S.FruitESP, Tooltip = "Shows every fruit, name and distance"})
    bindToggle("ArchivistVSFruitESP", "FruitESP")
end
do
    task.wait()
    local fishBox = fishTab:AddGroupbox({Side = "Left", Name = "Fishing", IconName = "fish"})
    fishBox:AddToggle("ArchivistVSAutoFish", {Text = "Auto Fish", Default = S.AutoFish, Tooltip = "Casts and reels by itself"})
    fishBox:AddDropdown("ArchivistVSFishSpot", {Text = "Region", Values = {"Nearest Shore", "Saved Point", "Fisherman", "Fisherman Toru"}, Default = (S.FishSpot == nil or S.FishSpot == "Where I Am") and "Nearest Shore" or S.FishSpot, Tooltip = "Where Auto Fish goes"})
    fishBox:AddButton({Text = "Save Fishing Point", Func = function()
        local root = Hub.Root()
        if not root then return end
        local look = root.CFrame.LookVector * Vector3.new(1, 0, 1)
        local dir = Hub.FishDirection(root.Position, look.Magnitude > 0.1 and look.Unit or nil)
        if not dir then
            Hub.Library:Notify({Title = "Fishing", Description = "No open water in front of you", Time = 5})
            return
        end
        S.FishPoint = {root.Position.X, root.Position.Y, root.Position.Z, dir.X, dir.Z}
        S.FishSpot = "Saved Point"
        Hub.FishCenter = nil
        save()
        pcall(function() Options.ArchivistVSFishSpot:SetValue("Saved Point") end)
        Hub.Library:Notify({Title = "Fishing", Description = "Point saved", Time = 4})
    end})
    fishBox:AddToggle("ArchivistVSAutoMinigames", {Text = "Auto Minigames", Default = S.AutoMinigames, Tooltip = "Plays reel, dodge and stones for you"})
    fishBox:AddToggle("ArchivistVSFishWeapon", {Text = "Re-equip Weapon", Default = S.FishWeapon ~= false, Tooltip = "Weapon back in hand after fishing"})
    bindToggle("ArchivistVSAutoFish", "AutoFish")
    bindToggle("ArchivistVSAutoMinigames", "AutoMinigames")
    bindToggle("ArchivistVSFishWeapon", "FishWeapon")
    table.insert(Hub.AutoToggles, "ArchivistVSAutoFish")
    Options.ArchivistVSFishSpot:OnChanged(function()
        S.FishSpot = Options.ArchivistVSFishSpot.Value
        Hub.FishCenter = nil
        save()
    end)
    local alertBox = fishTab:AddGroupbox({Side = "Right", Name = "Catch Notifications", IconName = "bell"})
    alertBox:AddToggle("ArchivistVSFishNotify", {Text = "Notify Catches", Default = S.FishNotify, Tooltip = "Pop-up for each catch"})
    alertBox:AddDropdown("ArchivistVSFishNotifyRarities", {Text = "Rarities", Values = {"Common", "Uncommon", "Rare", "Epic"}, AllowNull = true, Multi = true, Default = Hub.SelectedValues({Common = (S.FishNotifyRarities or {}).Common, Uncommon = (S.FishNotifyRarities or {}).Uncommon, Rare = (S.FishNotifyRarities or {}).Rare, Epic = (S.FishNotifyRarities or {}).Epic})})
    bindToggle("ArchivistVSFishNotify", "FishNotify")
    Options.ArchivistVSFishNotifyRarities:OnChanged(function()
        S.FishNotifyRarities = {}
        for name, on in pairs(Options.ArchivistVSFishNotifyRarities.Value) do if on then S.FishNotifyRarities[name] = true end end
        save()
    end)
    local safetyBox = fishTab:AddGroupbox({Side = "Left", Name = "Safety", IconName = "shield"})
    safetyBox:AddToggle("ArchivistVSFishPausePlayers", {Text = "Pause Near Players", Default = S.FishPausePlayers, Tooltip = "Waits while a player is close"})
    bindToggle("ArchivistVSFishPausePlayers", "FishPausePlayers")
    local statsBox = fishTab:AddGroupbox({Side = "Right", Name = "Session", IconName = "chart-column"})
    local caughtLabel = statsBox:AddLabel({Text = "Caught  0", DoesWrap = true})
    local rateLabel = statsBox:AddLabel({Text = "Per minute  0", DoesWrap = true})
    local lastLabel = statsBox:AddLabel({Text = "Last  -", DoesWrap = true})
    local rarityLabel = statsBox:AddLabel({Text = "Rarities  -", DoesWrap = true})
    local bagLabel = statsBox:AddLabel({Text = "Bag  -", DoesWrap = true})
    local statusLabel = statsBox:AddLabel({Text = "Status  Off", DoesWrap = true})
    task.spawn(function()
        while Hub.Alive do
            pcall(function()
                if not S.AutoFish then Hub.FishRunning = nil end
                local stats = Hub.FishStats
                local minutes = Hub.FishStarted and math.max((os.clock() - Hub.FishStarted) / 60, 1 / 60) or nil
                caughtLabel:SetText(string.format("Caught  %d   Escaped  %d", stats.Caught, stats.Escaped))
                rateLabel:SetText("Per minute  " .. (minutes and string.format("%.1f", stats.Caught / minutes) or "0"))
                lastLabel:SetText("Last  " .. (stats.Last or "-"))
                local parts = {}
                for _, rarity in ipairs({"Common", "Uncommon", "Rare", "Epic", "Legendary"}) do
                    if stats.Rarity[rarity] then table.insert(parts, rarity .. " " .. stats.Rarity[rarity]) end
                end
                rarityLabel:SetText("Rarities  " .. (#parts > 0 and table.concat(parts, ", ") or "-"))
                local total, kinds = 0, 0
                for _, item in ipairs(Hub.Data().Tools.Unequiped) do
                    local info = Hub.FruitInfo and Hub.FruitInfo(item.Name)
                    if info and info.Fishing then total, kinds = total + (tonumber(item.Quantity) or 1), kinds + 1 end
                end
                bagLabel:SetText(string.format("Bag  %d fish, %d kinds", total, kinds))
                local state = tostring(Hub.State or ""):match("^Fishing: (.+)")
                statusLabel:SetText("Status  " .. (S.AutoFish and (state or "Working") or "Off"))
            end)
            task.wait(1)
        end
    end)
end
-- Auto Fruit Gacha (Vox Gacha NPC). Gold only: the roulette's currency is checked before every
-- spin, and the native roll button is never used (it prompts a Robux skip while on cooldown).
Hub.GachaAnchor = Vector3.new(5868.7, 41, 3562.5)
function Hub.GachaRemaining()
    local utils = MainModules.FruitsUtils
    local ok, left = pcall(function() return utils.GachaRemaining() end)
    return ok and tonumber(left) or nil
end
do
    local _, record = Elysium.Network.Require("RemoteEvent", "Roulette")
    if record and record.Signal then
        table.insert(Hub.Connections, record.Signal:Connect(function(kind, settings)
            if kind == "FruitGacha" and type(settings) == "table" then
                Hub.GachaOffer = {Currency = settings.CurrencyType, Price = settings.Price, At = os.clock()}
            end
        end))
    end
end
function Hub.SpinGacha()
    local data = Hub.Data()
    local cost = tonumber(MainModules.FruitsUtils.GachaCost and MainModules.FruitsUtils.GachaCost()) or 5000
    local left = Hub.GachaRemaining()
    task.wait()
    if not left or left > 0 then return false, left end
    Hub.GachaCostNow = cost
    if (tonumber(data.Monetization.Gold) or 0) < cost + 500 then return false, "gold" end
    local fruit = Hub.Fruit
    if Hub.FruitBusy then return false, "busy" end
    -- First try from where the player is; only travel to the Vox Gacha NPC if the server
    -- does not answer from here. Gold only: the offer's currency is checked before spinning.
    local function attempt()
        Hub.GachaOffer = nil
        Elysium.Network:FireServer("Elysium_Converse", "Vox Gacha")
        local deadline = os.clock() + 4
        repeat task.wait(0.1) until Hub.GachaOffer or os.clock() > deadline
        local offer = Hub.GachaOffer
        if not offer then return "no offer" end
        if offer.Currency ~= "Gold" or (tonumber(offer.Price) or math.huge) > cost then return "not gold" end
        if (tonumber(Hub.Data().Monetization.Gold) or 0) < offer.Price + 500 then return "gold" end
        local won = Elysium.Network:SafeInvokeServer(10, "FruitGacha", "Spin")
        local menu = Hub.RouletteMenu
        if not menu then
            local ok, module = pcall(require, RS.Modules.Commerce.ShopSystem["ShopSystem Client"].RouletteMenu)
            menu = ok and module or nil
            Hub.RouletteMenu = menu
        end
        if menu then pcall(menu.ForceClose) end
        local frame = player.PlayerGui:FindFirstChild("RouletteFrame", true)
        if frame and frame.Visible and menu then pcall(menu.Close) end
        if not won then return "no spin" end
        Hub.LastGacha = tostring(won)
        task.wait()
        pcall(function() Hub.Library:Notify({Title = "Fruit Gacha", Description = "Got " .. tostring(won), Time = 8}) end)
        return "spun"
    end
    local result = attempt()
    if result == "spun" or result == "not gold" or result == "gold" then return true, result end
    if Hub.FruitBusy or not fruit or not fruit.Travel then return false, "busy" end
    fruit.Errand = true
    fruit.SetBusy(true)
    local okSpin
    okSpin, result = pcall(function()
        if not fruit.Travel(Hub.GachaAnchor) then return "travel" end
        local outcome = attempt()
        if outcome == "spun" then
            task.wait(4)
            local loose = fruit.Loose and fruit.Loose()
            if loose and S.FruitStore and fruit.CanStore(loose.Name) then fruit.Store(loose) end
        end
        return outcome
    end)
    fruit.Errand = nil
    fruit.SetBusy(false)
    return okSpin, result
end
task.spawn(function()
    while Hub.Alive do
        if Hub.UIReady and S.FruitGacha and not Hub.Paused then
            local ok, result = pcall(Hub.SpinGacha)
            if not ok then Hub.GachaError = tostring(result) end
            if result == "not gold" then
                S.FruitGacha = false
                task.wait()
                pcall(function() Toggles.ArchivistVSFruitGacha:SetValue(false) end)
                Hub.Library:Notify({Title = "Fruit Gacha stopped", Description = "Price is not Gold", Time = 7})
            end
        end
        local left = Hub.GachaRemaining()
        local gold = tonumber(Hub.Data().Monetization.Gold) or 0
        task.wait() -- native data reads lower UI capability until the next yield
        local labelOk, labelErr = pcall(function()
            local need = (Hub.GachaCostNow or 0) + 500
            Hub.GachaLabel:SetText(left and left > 0 and string.format("Next spin  %dm %02ds", math.floor(left / 60), left % 60)
                or (S.FruitGacha and gold < need and string.format("Waiting for Gold  %d / %d", gold, need))
                or ("Next spin  ready" .. (Hub.LastGacha and ("  Last: " .. Hub.LastGacha) or "")))
        end)
        if not labelOk then Hub.GachaLabelError = tostring(labelErr) end
        task.wait(5)
    end
end)

-- Auto Dodge: the story's Dodge minigame (Askard stones, blindfold, spar). Presses through the
-- game's own HandlePress at each note's arrival, exactly like the player's A / D keys.
function Hub.DodgeHandles()
    if not Hub.MinigamesClient then
        local ok, client = pcall(function() return require(RS.Modules.Addons.MinigamesSystem).IsClient end)
        Hub.MinigamesClient = ok and client or false
    end
    local MS = Hub.MinigamesClient
    if not MS or not MS.Active or MS.Active.Name ~= "Dodge" then return nil end
    if not Hub.DodgePress then
        for _, value in pairs(debug.getupvalues(MS.Modules.Dodge.Start)) do
            if type(value) == "function" and debug.getinfo(value).name == "HandlePress" then Hub.DodgePress = value break end
        end
    end
    return Hub.DodgePress
end
-- Fruit items: store, eat and drop through the same remotes as the fruit options menu
-- (ToolsData Store, Fruits Eat with the held tool, Fruits Drop). An eaten fruit is a
-- DevilFruit tool; a fruit is only eaten when it is rarer than that one.
Hub.FruitRank = {Common = 1, Rare = 2, Epic = 3, Legendary = 4, Mythical = 5}
function Hub.FruitInfo(name)
    local ok, info = pcall(function() return MainModules.ToolsInfo:Get(name, true) end)
    return ok and type(info) == "table" and info or nil
end
function Hub.IsFruitItem(name)
    local info = Hub.FruitInfo(name)
    return info ~= nil and info.ToolType == "Dropped Fruit"
end
function Hub.FruitNames()
    local names = {}
    for name in pairs(MainModules.FruitsUtils.AllFruits or {}) do table.insert(names, tostring(name)) end
    table.sort(names, function(a, b)
        local ra = Hub.FruitRank[(Hub.FruitInfo(a) or {}).Rarity] or 9
        local rb = Hub.FruitRank[(Hub.FruitInfo(b) or {}).Rarity] or 9
        if ra ~= rb then return ra < rb end
        return a < b
    end)
    return names
end
-- Rank of the fruit already eaten: 0 for none, 99 when it cannot be read (never replace it).
function Hub.EatenFruitRank()
    local data = Hub.Data()
    for _, list in ipairs({"Equiped", "Unequiped"}) do
        for _, tool in ipairs(data.Tools[list] or {}) do
            local info = Hub.FruitInfo(tool.Name)
            if info and info.ToolType == "DevilFruit" then
                local rank = Hub.FruitRank[info.Rarity]
                if not rank then
                    for _, name in ipairs(Hub.FruitNames()) do
                        local item = Hub.FruitInfo(name)
                        if item and item.Target == tool.Name then rank = Hub.FruitRank[item.Rarity] break end
                    end
                end
                return rank or 99, tool.Name
            end
        end
    end
    for _, holder in ipairs({player.Backpack, player.Character}) do
        for _, tool in ipairs(holder and holder:GetChildren() or {}) do
            if tool:IsA("Tool") and Hub.ToolType(tool) == "Fruit" then return 99, tool.Name end
        end
    end
    return 0
end
-- A fruit tool in hand, taking it out of the inventory first when needed.
function Hub.HoldFruit(name)
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil end
    local tool = char:FindFirstChild(name) or player.Backpack:FindFirstChild(name)
    if not tool then
        for index, item in ipairs(Hub.Data().Tools.Unequiped) do
            if item.Name == name then
                -- Stored fruits come out with Unstore, like the inventory's UNSTORE button.
                Elysium.Network:FireServer("ToolsData", Hub.IsFruitItem(name) and "Unstore" or "Equip", index, name)
                local deadline = os.clock() + 3
                repeat
                    task.wait(0.2)
                    tool = player.Backpack:FindFirstChild(name) or (player.Character and player.Character:FindFirstChild(name))
                until tool or os.clock() > deadline
                break
            end
        end
    end
    if not tool then return nil end
    if tool.Parent ~= char then hum:EquipTool(tool) task.wait(0.5) end
    return tool.Parent == char and tool or nil
end
function Hub.CarriedFruits()
    local found = {}
    for _, holder in ipairs({player.Character, player.Backpack}) do
        for _, tool in ipairs(holder and holder:GetChildren() or {}) do
            if tool:IsA("Tool") and Hub.IsFruitItem(tool.Name) then table.insert(found, tool) end
        end
    end
    return found
end
function Hub.FruitItemsStep()
    if Hub.FruitBusy or Hub.SkillBusy then return end
    -- Eat: the rarest fruit owned, only when it beats the one already eaten.
    if S.AutoEatFruits then
        local current = Hub.EatenFruitRank()
        local best, bestRank
        for _, item in ipairs(Hub.Data().Tools.Unequiped) do
            local info = Hub.IsFruitItem(item.Name) and Hub.FruitInfo(item.Name)
            local rank = info and Hub.FruitRank[info.Rarity] or 0
            if rank > current and (not bestRank or rank > bestRank) then best, bestRank = item.Name, rank end
        end
        for _, tool in ipairs(Hub.CarriedFruits()) do
            local info = Hub.FruitInfo(tool.Name)
            local rank = info and Hub.FruitRank[info.Rarity] or 0
            if rank > current and (not bestRank or rank > bestRank) then best, bestRank = tool.Name, rank end
        end
        if best then
            local tool = Hub.HoldFruit(best)
            if tool then
                local ok, eaten = pcall(function() return Elysium.Network:SafeInvokeServer(5, "Fruits", "Eat", tool) end)
                if ok and eaten == true then
                    task.wait()
                    pcall(function() Hub.Library:Notify({Title = "Fruit eaten", Description = best, Time = 8}) end)
                    task.wait(3)
                    return
                end
            end
        end
    end
    -- Drop: repeated fruits (keeps one of each), then the fruits picked in the list.
    if S.AutoDropFruits then
        local counts = {}
        local tools = Hub.Data().Tools
        for _, list in ipairs({tools.Unequiped or {}, tools.Bank or {}}) do
            for _, item in ipairs(list) do
                if Hub.IsFruitItem(item.Name) then counts[item.Name] = (counts[item.Name] or 0) + (tonumber(item.Quantity) or 1) end
            end
        end
        for _, tool in ipairs(Hub.CarriedFruits()) do counts[tool.Name] = (counts[tool.Name] or 0) + 1 end
        for name, count in pairs(counts) do
            if count > 1 then
                local tool = Hub.HoldFruit(name)
                if tool then
                    Elysium.Network:FireServer("Fruits", "Drop")
                    task.wait()
                    pcall(function() Hub.Library:Notify({Title = "Repeated fruit dropped", Description = name, Time = 6}) end)
                    task.wait(1)
                    return
                end
            end
        end
    end
    if S.AutoDropFruits and next(S.DropFruits or {}) then
        for name in pairs(S.DropFruits) do
            local owned = player.Backpack:FindFirstChild(name) or (player.Character and player.Character:FindFirstChild(name))
            if not owned then
                for _, item in ipairs(Hub.Data().Tools.Unequiped) do if item.Name == name then owned = true break end end
            end
            if owned then
                local tool = Hub.HoldFruit(name)
                if tool then Elysium.Network:FireServer("Fruits", "Drop") task.wait(1) return end
            end
        end
    end
    -- Store: any fruit carried in hand or on the hotbar goes into the inventory.
    if S.AutoStoreFruits then
        for _, tool in ipairs(Hub.CarriedFruits()) do
            if not (S.AutoDropFruits and S.DropFruits and S.DropFruits[tool.Name]) then
                local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if hum and tool.Parent ~= player.Character then hum:EquipTool(tool) task.wait(0.4) end
                if tool.Parent == player.Character then Elysium.Network:FireServer("ToolsData", "Store") task.wait(1) end
                return
            end
        end
    end
end
task.spawn(function()
    while Hub.Alive do
        if Hub.UIReady and not Hub.Paused and (S.AutoEatFruits or S.AutoDropFruits or S.AutoStoreFruits) then
            local ok, err = pcall(Hub.FruitItemsStep)
            if not ok then Hub.FruitItemsError = tostring(err) end
        end
        task.wait(2)
    end
end)

-- Fruit ESP: every fruit on the map with its exact name, rarity and distance.
Hub.FruitESPColors = {
    Common = Color3.fromRGB(200, 200, 200), Rare = Color3.fromRGB(80, 160, 255), Epic = Color3.fromRGB(190, 90, 255),
    Legendary = Color3.fromRGB(255, 190, 40), Mythical = Color3.fromRGB(255, 70, 70),
}
Hub.FruitESPTags = {}
function Hub.FruitESPTag(tool)
    local tag = Hub.FruitESPTags[tool]
    if tag and tag.Gui.Parent then return tag end
    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart", true)
    if not handle then return nil end
    local info = Hub.FruitInfo(tool.Name)
    local rarity = info and info.Rarity or "Common"
    local gui = Instance.new("BillboardGui")
    gui.Name = "ArchivistFruitESP"
    gui.AlwaysOnTop, gui.LightInfluence = true, 0
    gui.Size = UDim2.fromOffset(220, 46)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.MaxDistance = math.huge
    gui.Adornee = handle
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 15
    label.TextStrokeTransparency = 0.2
    label.TextColor3 = Hub.FruitESPColors[rarity] or Color3.new(1, 1, 1)
    label.Parent = gui
    local highlight = Instance.new("Highlight")
    highlight.Name = "ArchivistFruitESP"
    highlight.FillTransparency, highlight.OutlineTransparency = 0.6, 0
    highlight.FillColor = label.TextColor3
    highlight.OutlineColor = label.TextColor3
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = tool
    local parent = (gethui and gethui()) or game:GetService("CoreGui")
    gui.Parent, highlight.Parent = parent, parent
    tag = {Gui = gui, Label = label, Highlight = highlight, Rarity = rarity}
    Hub.FruitESPTags[tool] = tag
    return tag
end
function Hub.ClearFruitESP()
    for tool, tag in pairs(Hub.FruitESPTags) do
        pcall(function() tag.Gui:Destroy() tag.Highlight:Destroy() end)
        Hub.FruitESPTags[tool] = nil
    end
end
table.insert(Hub.Connections, RunService.Heartbeat:Connect(function()
    if not S.FruitESP or not Hub.Alive then
        if next(Hub.FruitESPTags) then Hub.ClearFruitESP() end
        return
    end
    local now = os.clock()
    if Hub.FruitESPAt and now - Hub.FruitESPAt < 0.2 then return end
    Hub.FruitESPAt = now
    local root = Hub.Root()
    local folder = workspace:FindFirstChild("Playability") and workspace.Playability:FindFirstChild("DroppedTools")
    local alive = {}
    for _, tool in ipairs(folder and folder:GetChildren() or {}) do
        if tool:GetAttribute("Fruit") == true or Hub.IsFruitItem(tool.Name) then
            local tag = Hub.FruitESPTag(tool)
            if tag then
                alive[tool] = true
                local handle = tag.Gui.Adornee
                local distance = root and handle and (handle.Position - root.Position).Magnitude or 0
                tag.Label.Text = string.format("%s  (%s)\n%d m", tool.Name, tag.Rarity, math.floor(distance + 0.5))
            end
        end
    end
    for tool, tag in pairs(Hub.FruitESPTags) do
        if not alive[tool] then
            pcall(function() tag.Gui:Destroy() tag.Highlight:Destroy() end)
            Hub.FruitESPTags[tool] = nil
        end
    end
end))

-- Auto Fish: stands on the nearest shore that faces open water (the rod's own rules: not
-- swimming, 0.5-45 studs above the sea, nothing within 35 studs ahead), casts with the
-- game's rod and plays the reel minigame by holding / releasing R2 like a gamepad player.
Hub.FishSpots = {}
Hub.FishCaught = 0
Hub.FishStats = {Caught = 0, Escaped = 0, Rarity = {}}
do
    local _, record = Elysium.Network.Require("RemoteEvent", "MinigamesService")
    if record and record.Signal then
        table.insert(Hub.Connections, record.Signal:Connect(function(action, payload)
            if action ~= "Stop" or type(payload) ~= "table" or payload.name ~= "Fishing" then return end
            local data = type(payload.data) == "table" and payload.data or {}
            if data.Cancel then return end
            local stats = Hub.FishStats
            if data.Fish then
                stats.Caught = stats.Caught + 1
                local rarity = tostring(data.Rarity or "Common")
                stats.Rarity[rarity] = (stats.Rarity[rarity] or 0) + 1
                local info = data.Item and Hub.FruitInfo and Hub.FruitInfo(data.Item)
                stats.Last = tostring(info and info.AlternativeName or data.Item or "Fish") .. " (" .. rarity .. ")"
                if S.FishNotify and (S.FishNotifyRarities or {})[rarity] then
                    task.spawn(function()
                        pcall(function() Hub.Library:Notify({Title = "Caught " .. rarity, Description = stats.Last, Time = 6}) end)
                    end)
                end
            else
                stats.Escaped = stats.Escaped + 1
            end
        end))
    end
end
function Hub.FishMinigame()
    local ok, MS = pcall(function() return require(RS.Modules.Addons.MinigamesSystem).IsClient end)
    return ok and MS or nil
end
function Hub.FishCastParams()
    if not Hub.FishParams then
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Include
        params.FilterDescendantsInstances = {workspace.Map, workspace.Terrain, workspace.Playability.Boats}
        -- Walkways and decor without collision still block a real cast: count every part.
        params.IgnoreWater, params.RespectCanCollide = true, false
        Hub.FishParams = params
        Hub.FishOcean = require(RS.Modules.Essentials.NavigationSystem["NavigationSystem Client"]["SwimSystem Client"].Utils)
    end
    return Hub.FishParams, Hub.FishOcean
end
-- Same checks as the rod before it lets a line go.
function Hub.FishCanCast(stand, dir)
    local params, Utils = Hub.FishCastParams()
    local tip = stand + dir * 35
    local drop = stand.Y - Utils.GetOceanHeight(CFrame.new(tip))
    if drop < 0.5 or drop > 45 then return false end
    if workspace:Raycast(stand + Vector3.new(0, 1.5, 0), dir * 35, params) then return false end
    return workspace:Raycast(Vector3.new(tip.X, stand.Y, tip.Z), Vector3.new(0, -drop, 0), params) == nil
end
function Hub.FishDirection(stand, prefer)
    if prefer and Hub.FishCanCast(stand, prefer) then return prefer end
    for i = 0, 15 do
        local angle = i / 16 * math.pi * 2
        local dir = Vector3.new(math.cos(angle), 0, math.sin(angle))
        if Hub.FishCanCast(stand, dir) then return dir end
    end
end
-- Nearest shore that faces open water, searched in rings outwards from the center.
function Hub.FishSpot(center, radius)
    radius = radius or 80
    local key = string.format("%d,%d,%d", math.floor(center.X / 40), math.floor(center.Z / 40), radius)
    local cached = Hub.FishSpots[key]
    if cached and (cached.Stand or os.clock() < cached.Retry) then return cached.Stand and cached or nil end
    local params, Utils = Hub.FishCastParams()
    local best
    for ring = 0, radius, 6 do
        local steps = math.max(1, math.floor(2 * math.pi * ring / 6))
        for step = 0, steps - 1 do
            local angle = step / steps * math.pi * 2
            local point = center + Vector3.new(math.cos(angle) * ring, 0, math.sin(angle) * ring)
            local hit = workspace:Raycast(point + Vector3.new(0, 80, 0), Vector3.new(0, -160, 0), params)
            if hit and hit.Position.Y > Utils.GetOceanHeight(CFrame.new(hit.Position)) + 0.6 then
                local stand = hit.Position + Vector3.new(0, 3, 0)
                local dir = Hub.FishDirection(stand)
                if dir then best = {Stand = stand, Dir = dir} break end
            end
        end
        if best then break end
        task.wait()
    end
    Hub.FishSpots[key] = best or {Retry = os.clock() + 20}
    return best
end
function Hub.FishRod()
    local char = player.Character
    local rod = char and char:FindFirstChild("Fishing Road") or player.Backpack:FindFirstChild("Fishing Road")
    if rod then return rod end
    for index, tool in ipairs(Hub.Data().Tools.Unequiped) do
        if tool.Name == "Fishing Road" then
            Elysium.Network:FireServer("ToolsData", "Equip", index, tool.Name)
            task.wait(1.2)
            return player.Backpack:FindFirstChild("Fishing Road")
        end
    end
end
-- No rod yet: buy one with Gold at the Solmar boat shop (an interior: in by its door, out the same way).
Hub.RodShop = {Island = "Solmar Island", Area = "SolmarBoatShop", Npc = "Solmar Shipwright", Shop = "Solmar Boat Shop", MaxPrice = 10000}
function Hub.BuyRod()
    if (Hub.RodFailAt or 0) > os.clock() then return false end
    local spec = Hub.RodShop
    local info = MainModules.ShopInfo:Get(spec.Shop)
    local index, entry
    for i, item in ipairs(info and info.Items or {}) do
        if item.ToolName == "Fishing Road" then index, entry = i, item break end
    end
    local gold = tonumber(Hub.Data().Monetization.Gold) or 0
    task.wait()
    if not entry or entry.Currency ~= "Gold" or type(entry.Price) ~= "number" or entry.Price <= 0 or entry.Price > spec.MaxPrice then
        Hub.State, Hub.RodFailAt = "Fishing: rod price is not Gold", os.clock() + 600 return false
    end
    if gold < entry.Price then Hub.State = "Fishing: rod needs " .. entry.Price .. " Gold" task.wait(5) return false end
    local area = workspace.IgnoreList.Int.PrivateAreas:FindFirstChild(spec.Island)
    area = area and area:FindFirstChild(spec.Area)
    local door = area and area:FindFirstChild("Enter") and area.Enter:FindFirstChild("Entrance")
    local npc = workspace.IgnoreList.Int.NPCs.Shops:FindFirstChild(spec.Island)
    npc = npc and npc:FindFirstChild(spec.Npc)
    if not door or not npc then Hub.State, Hub.RodFailAt = "Fishing: rod shop not found", os.clock() + 120 return false end
    local active = function() return Hub.Alive and S.AutoFish end
    Hub.FarmTarget, Hub.HoldAt, Hub.State = nil, nil, "Fishing: buying a rod"
    local root = Hub.Root()
    local inside = root and (root.Position - npc:GetPivot().Position).Magnitude < 60
    if not inside and not Hub.StoryDoor(door.Position, area, active) then Hub.RodFailAt = os.clock() + 30 return false end
    local spot = npc:GetPivot().Position
    root = Hub.Root()
    if root and (root.Position - spot).Magnitude > 8 then Hub.Hop(spot + npc:GetPivot().LookVector * 5) task.wait(0.5) end
    local shop = require(RS.Modules.Commerce.ShopSystem).IsClient.ShopShowcaseMenu
    Elysium.Network:FireServer("Elysium_Converse", spec.Npc)
    local deadline = os.clock() + 4
    repeat task.wait(0.1) until shop.Opened or os.clock() >= deadline
    local bought = false
    if shop.Opened and shop.ShopName == spec.Shop then
        local premium = Hub.Data().Monetization.Fragment
        Elysium.Network:FireServer("ShopSystem", "Purchase", index, 1)
        deadline = os.clock() + 5
        repeat task.wait(0.2) bought = MainModules.ToolsUtils.GetOwnedAmount(nil, "Fishing Road") > 0 until bought or os.clock() >= deadline
        table.insert(Hub.PurchaseEvidence, {Id = "FishingRod", Item = entry.ToolName, Price = entry.Price, Currency = entry.Currency,
            GoldBefore = gold, GoldAfter = Hub.Data().Monetization.Gold, PremiumBefore = premium, PremiumAfter = Hub.Data().Monetization.Fragment, Received = bought})
    end
    task.wait()
    pcall(shop.Close)
    Hub.RestoreHud(shop)
    -- Back outside by the shop's own exit (the marker is the outdoor door).
    Hub.StoryDoor(door.Position, area, active)
    if not bought then Hub.RodFailAt = os.clock() + 60 end
    return bought
end
function Hub.FishOnce(center)
    local root, hum = Hub.Root()
    if not root or not hum then task.wait(0.5) return false end
    if not Hub.FishRod() then
        task.wait()
        if not Hub.BuyRod() then task.wait(1) end
        return false
    end
    -- The island must be streamed in before its shore can be scanned.
    if (root.Position - center).Magnitude > 150 then
        Hub.State = "Fishing: going to the spot"
        Hub.Hop(center + Vector3.new(0, 4, 0))
        task.wait(1)
        return false
    end
    local spot = Hub.FishPinned
    if not spot then
        spot = Hub.FishSpot(center, Hub.FishRadius or 80)
        if not spot then Hub.State = "Fishing: no shore nearby" task.wait(3) return false end
    end
    -- Safety: wait while another player stands close by.
    if S.FishPausePlayers then
        for _, other in ipairs(Players:GetPlayers()) do
            local otherRoot = other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot and (otherRoot.Position - spot.Stand).Magnitude < 60 then
                Hub.State = "Fishing: player nearby"
                task.wait(2)
                return false
            end
        end
    end
    local stand, dir = spot.Stand, spot.Dir
    if (root.Position - stand).Magnitude > 4 then
        if not Hub.Hop(stand) then task.wait(0.5) return false end
    end
    Hub.FarmTarget = nil
    Hub.HoldAt = CFrame.lookAt(stand, stand + dir)
    local rod = Hub.FishRod()
    if not rod then Hub.State = "Fishing: no fishing rod" task.wait(5) return false end
    if rod.Parent ~= player.Character then hum:EquipTool(rod) task.wait(0.8) end
    local MS = Hub.FishMinigame()
    task.wait(0.4)
    Hub.State = "Fishing: casting"
    local camera = workspace.CurrentCamera
    camera.CFrame = CFrame.lookAt(stand + Vector3.new(0, 4, 0) - dir * 10, stand + dir * 20)
    rod:Activate()
    local deadline = os.clock() + 12
    repeat task.wait(0.1) until (MS and MS.Active) or os.clock() > deadline or not Hub.FarmOn()
    if not (MS and MS.Active) then task.wait(1) return false end
    Hub.State = "Fishing: reeling"
    deadline = os.clock() + 60
    repeat task.wait(0.1) Hub.StoryProgressAt = os.clock() until not MS.Active or os.clock() > deadline
    Hub.FishCaught = Hub.FishCaught + 1
    task.wait(3)
    if S.FishWeapon ~= false and not S.AutoFish and Hub.Equip then pcall(Hub.Equip, hum) end
    return true
end
function Hub.FishStep()
    local root = Hub.Root()
    if not root then task.wait(0.5) return end
    if not Hub.FishRunning then Hub.FishRunning, Hub.FishCenter = true, nil end
    if not Hub.FishCenter then
        Hub.FishPinned, Hub.FishRadius = nil, 80
        local region = tostring(S.FishSpot or "Nearest Shore")
        local saved = S.FishPoint
        if region == "Saved Point" and type(saved) == "table" and saved[1] then
            local stand = Vector3.new(saved[1], saved[2], saved[3])
            Hub.FishCenter = stand
            Hub.FishPinned = {Stand = stand, Dir = Vector3.new(saved[4] or 1, 0, saved[5] or 0).Unit}
        else
            local anchor = region ~= "Nearest Shore" and RS.NpcAnchors:FindFirstChild(region)
            Hub.FishCenter = anchor and anchor.Value.Position or root.Position
            if not anchor then Hub.FishRadius = 450 end
        end
    end
    Hub.FishStarted = Hub.FishStarted or os.clock()
    Hub.FishOnce(Hub.FishCenter)
end
do
    local VIM = game:GetService("VirtualInputManager")
    local pulling, lastControl = false, nil
    local function setPull(on)
        if on == pulling then return end
        pulling = on
        pcall(function() VIM:SendKeyEvent(on, Enum.KeyCode.ButtonR2, false, game) end)
    end
    table.insert(Hub.Connections, RunService.RenderStepped:Connect(function()
        local MS = (S.AutoFish or S.AutoStory or S.AutoMinigames) and Hub.Alive and not Hub.Paused and Hub.FishMinigame()
        local active = MS and MS.Active
        if not active or active.Name ~= "Fishing" then lastControl = nil setPull(false) return end
        local hud = Hub.FishHud
        if not hud or not hud.Parent then
            local gui = player.PlayerGui:FindFirstChild("MinigamesHUD", true)
            hud = gui and gui:FindFirstChild("Fishing")
            Hub.FishHud = hud
            if not hud then return end
        end
        local elements = hud:FindFirstChild("GameplayElements")
        local fish, control = elements and elements:FindFirstChild("Fish"), elements and elements:FindFirstChild("Control")
        if not fish or not control then return end
        local fishY, controlY = fish.Position.Y.Scale, control.Position.Y.Scale
        local speed = controlY - (lastControl or controlY)
        lastControl = controlY
        -- Pulling raises the bar (lower Y); look a few frames ahead so it does not overshoot.
        setPull(controlY + speed * 8 > fishY)
    end))
end

-- Auto StoneBreak (Vox Armor training): the gamepad hit (ButtonA / R2) always breaks the first
-- open target, so one press per target that appears clears the whole sequence.
do
    local VIM = game:GetService("VirtualInputManager")
    local pressed = setmetatable({}, {__mode = "k"})
    local releaseAt
    table.insert(Hub.Connections, RunService.RenderStepped:Connect(function()
        if releaseAt then
            releaseAt = nil
            pcall(function() VIM:SendKeyEvent(false, Enum.KeyCode.ButtonA, false, game) end)
            return
        end
        if not Hub.Alive or Hub.Paused or not (S.AutoStory or S.AutoMinigames or S.TrainVoxArmor) then return end
        local MS = Hub.FishMinigame()
        local active = MS and MS.Active
        if not active or active.Name ~= "StoneBreak" then return end
        Hub.StoryProgressAt = os.clock()
        local gui = player.PlayerGui:FindFirstChild("StoneBreakGui")
        local layer = gui and gui:FindFirstChild("Targets", true)
        if not layer then return end
        for _, target in ipairs(layer:GetChildren()) do
            local approach = target.Name:match("^Target%d+$") and target:FindFirstChild("Approach")
            if approach and approach.Visible and not pressed[target] then
                pressed[target] = true
                releaseAt = true
                pcall(function() VIM:SendKeyEvent(true, Enum.KeyCode.ButtonA, false, game) end)
                return
            end
        end
    end))
end
Hub.DodgePressed = setmetatable({}, {__mode = "k"})
table.insert(Hub.Connections, RunService.RenderStepped:Connect(function()
    if not Hub.Alive or not (S.AutoStory or S.AutoMinigames or S.TrainVoxSense) or Hub.Paused or not (debug and debug.getupvalues) then return end
    local press = Hub.DodgeHandles()
    if not press then return end
    local data, notes, started
    for _, value in pairs(debug.getupvalues(press)) do
        if type(value) == "table" then
            if value.Mode ~= nil or value.Count ~= nil then data = value else notes = value end
        elseif type(value) == "number" then started = value end
    end
    if not data or type(notes) ~= "table" then return end
    Hub.StoryProgressAt = os.clock()
    if data.Mode == "Spar" then
        for _, note in ipairs(notes) do
            if not note.Resolved then
                if note.Spawned and not Hub.DodgePressed[note] then Hub.DodgePressed[note] = true press(note.Key) end
                break
            end
        end
        return
    end
    if not started then return end
    local now = os.clock() - started
    for _, note in ipairs(notes) do
        if note.Spawned and not note.Resolved and not Hub.DodgePressed[note] and tonumber(note.Arrival)
            and math.abs(now - note.Arrival) <= 0.05 then
            Hub.DodgePressed[note] = true
            press(note.Key or note.Side)
        end
    end
end))

-- Home session tiles.
task.spawn(function()
    local executor = "Unknown"
    if type(identifyexecutor) == "function" then
        local ok, name = pcall(identifyexecutor)
        if ok then executor = tostring(name) end
    end
    while Hub.Alive do
        pcall(function()
            local elapsed = math.floor(os.clock() - Hub.Started)
            sessionValues.Session.Text = string.format("%02d:%02d", math.floor(elapsed / 60), elapsed % 60)
            sessionValues.Location.Text = tostring(player:GetAttribute("CurrentLocation") or "Vox Seas")
            if Elysium then
                local ok, _, _, free, lines, currents = pcall(Hub.StatPlan)
                task.wait()
                local text = "Free points  " .. tostring(ok and free or "-")
                if ok and #lines > 0 then text ..= "\n" .. table.concat(lines, "\n") end
                Hub.StatsLabel:SetText(text)
            end
            sessionValues.Players.Text = tostring(#Players:GetPlayers())
            sessionValues.Executor.Text = executor
        end)
        task.wait(0.5)
    end
end)
task.spawn(function()
    -- Slow fallback for executors where Idled does not fire.
    while Hub.Alive do
        task.wait(math.random(25, 35))
        if Hub.Alive and S.AntiAFK then antiAfkPulse("Preventive") end
    end
end)
task.wait() -- restore UI capability after native setup
Hub.BootStage("ready")
Hub.SetPaused(false)
Hub.UIReady = true
-- Artwork is optional: a slow image host must never block the menu.
task.spawn(function()
    logo = logo or customAsset("archivist_cosmic_logo_v5_transparent.png", "/archivist-logo.png")
    faces.Open = faces.Open or customAsset("archivist_launcher_king_open_v2.png", "/launcher-king-open.png")
    faces.Closed = faces.Closed or customAsset("archivist_launcher_king_closed_v2.png", "/launcher-king-closed.png")
    task.wait()
    if Hub.Alive then pcall(function() king.Image = (ui.Toggled and faces.Open or faces.Closed) or logo or "" end) end
end)
-- After a server hop or Auto Execute the game opens on its start menu: press START GAME
-- when an automation is on, so farming and the story carry on by themselves.
-- Keeps trying for 90 s: after a reconnect the menu can appear late or ignore the first press.
task.spawn(function()
    if not (S.AutoReconnect or S.AutoLoad or S.AutoStory or S.Farm or S.FarmMob or S.FruitFinder or S.AutoFish) then return end
    local deadline = os.clock() + 90
    task.wait(2)
    while Hub.Alive and os.clock() < deadline do
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local ok, button = pcall(function() return player.PlayerGui.ScreenGuis.StartScreenUI.Buttons.StartGame end)
        local menu = ok and button and button:FindFirstAncestorOfClass("ScreenGui")
        local onMenu = menu and menu.Enabled and button.Visible
        if hrp and not onMenu then return end
        if onMenu then
            for _, signal in ipairs({button.Activated, button.MouseButton1Click}) do
                if getconnections then
                    for _, connection in ipairs(getconnections(signal)) do pcall(function() connection:Fire() end) end
                elseif firesignal then
                    pcall(firesignal, signal)
                end
            end
        end
        task.wait(3)
    end
end)
env.ARCHIVIST_VS_STARTING = nil
env.ARCHIVIST_VS_AUTOEXEC_ERROR = nil
-- The public loader leaves its loading screen up; the hub is ready, so close it.
pcall(function() if env.ARCHIVIST_LOADING then env.ARCHIVIST_LOADING:Destroy() end end)
env.ARCHIVIST_LOADING = nil
return Hub

    end, function(message) return debug.traceback(tostring(message), 2) end)
    if not ok then
        local e = getgenv()
        e.ARCHIVIST_VS_STARTING = nil
        e.ARCHIVIST_VS_BOOT_ERROR = result
        local h = e.ARCHIVIST_VS
        if h and not h.UIReady then
            if type(h.Unload) == "function" then pcall(h.Unload, h)
            else
                h.Alive = false
                for _, c in ipairs(h.Connections or {}) do pcall(function() c:Disconnect() end) end
                if e.ARCHIVIST_VS == h then e.ARCHIVIST_VS = nil end
            end
        end
        pcall(function() game:GetService("RunService"):Set3dRenderingEnabled(true) end)
        local loading = e.ARCHIVIST_LOADING
        if loading then
            pcall(function() loading:Set(0, "Vox Seas could not load at " .. tostring(e.ARCHIVIST_VS_BOOT_STAGE or "startup") .. ". Run the loader again.") end)
            task.delay(8, function() pcall(loading.Destroy, loading) end)
        end
        e.ARCHIVIST_LOADING = nil
        error(result, 0)
    end
    return result
end)()
