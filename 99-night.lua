-- discord.gg/syncrypt

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaminhh/TDT-UI/main/TDTLib.lua"))()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("UserInputService")

local RunService = game:GetService("RunService")

game:GetService("HttpService")

local ProximityPromptService = game:GetService("ProximityPromptService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Items = Workspace:WaitForChild("Items")
local connection

local function v12(p1, p2, p3)
	lib:Notify(p1 or "TDT Hub", p2 or "", p3 or 3)
end

local v13 = lib:CreateWindow({
	Title = "KITS Hub",
	Subtitle = "99 NITF · Universal",
	Keybind = Enum.KeyCode.LeftControl,
	Width = 560,
	Height = 400,
	Home = {
		Title = "KITS HUB - 99 NITF",
		Subtitle = "Universal Script Hub",
		Discord = "https://discord.gg/tdt",
		Web = "https://discord.gg/tdt",
		Version = "KITS Hub v1.0 · DAYKITS"
	}
})
local Main = v13:AddTab("Main")
local Bring = v13:AddTab("Bring")
local Teleport = v13:AddTab("Teleport")
local Player = v13:AddTab("Player")
local Misc = v13:AddTab("Misc")
local Info = v13:AddTab("Info")
local v20 = Main:AddSection("Kill Aura")

_G.KillAura = false
_G.KillAuraRange = 100

local t1 = {
	"axe",
	"katana",
	"chainsaw",
	"cultist king mace",
	"morningstar",
	"infernal sword",
	"spear"
}

local function v22()
	local LocalPlayerName = workspace:FindFirstChild(LocalPlayer.Name)

	if not LocalPlayerName then
		return false
	end

	local ToolHandle = LocalPlayerName:FindFirstChild("ToolHandle")

	if not ToolHandle then
		return false
	end

	local OriginalItem = ToolHandle:FindFirstChild("OriginalItem")

	if not OriginalItem then
		return false
	end

	local Value = OriginalItem.Value
	local Name = typeof(Value) == "Instance" and Value.Name or typeof(Value) == "string" and Value

	if not Name then
		return false
	end

	local v28 = Name:lower()

	for _, v in ipairs(t1) do
		if string.find(v28, v) then
			return true
		end
	end

	return false
end

v20:AddToggle({
	Title = "Kill Aura",
	Flag = "KillAura",
	Default = false,
	Callback = function(p4)
		_G.KillAura = p4

		if not p4 then
			return
		end

		local Characters = workspace:WaitForChild("Characters")
		local Inventory = LocalPlayer:WaitForChild("Inventory")
		local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

		local function v34(p5)
			local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

			return HumanoidRootPart and (p5 - HumanoidRootPart.Position).Magnitude or math.huge
		end

		task.spawn(function()
			while _G.KillAura do
				if v22() then
					for _, child in ipairs(Characters:GetChildren()) do
						if child:IsA("Model") and child:FindFirstChild("HumanoidRootPart") then
							if not (child.Name:find("Lost Child") or child.Name:find("Pelt") or child.Name:find("Deer") or child.Name:find("PeltTrader")) then
								local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

								if HumanoidRootPart then
									if v34(HumanoidRootPart.Position) <= (_G.KillAuraRange or 100) then
										for _, child2 in ipairs(Inventory:GetChildren()) do
											if child2:IsA("Model") and child2:GetAttribute("WeaponDamage") then
												task.spawn(function()
													local HumanoidRootPart2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

													if HumanoidRootPart2 then
														RemoteEvents.ToolDamageObject:InvokeServer(child, child2, "30_" .. child2:GetAttribute("Owner"), HumanoidRootPart2.CFrame)
													end
												end)
											end
										end
									end
								end
							end
						end
					end

					task.wait(0.2)
				else
					task.wait(0.5)
				end
			end
		end)
	end
})
v20:AddSlider({
	Title = "Kill Aura Range",
	Flag = "KillAuraRange",
	Min = 0,
	Max = 150,
	Default = 100,
	Callback = function(p6)
		_G.KillAuraRange = tonumber(p6)
	end
})

local v42 = Main:AddSection("Tree Aura")

_G.ChopAura = false
_G.ChopAuraRange = 100
_G.ChopTreeType = "Small Tree"

local t2 = {
	"axe",
	"chainsaw"
}

local function v44()
	local LocalPlayerName = workspace:FindFirstChild(LocalPlayer.Name)

	if not LocalPlayerName then
		return false
	end

	local ToolHandle = LocalPlayerName:FindFirstChild("ToolHandle")

	if not ToolHandle then
		return false
	end

	local OriginalItem = ToolHandle:FindFirstChild("OriginalItem")

	if not OriginalItem then
		return false
	end

	local Value = OriginalItem.Value
	local Name = typeof(Value) == "Instance" and Value.Name

	if Name then
		Value = Name
	else
		Value = typeof(Value) == "string" and Value
	end

	if not Value then
		return false
	end

	local v50 = Value:lower()

	for _, v in ipairs(t2) do
		if string.find(v50, v) then
			return true
		end
	end

	return false
end
local function v53(p7, p8, p9)
	if not (p7 and p7.Parent and p8 and p8.Parent) then
		return
	end

	local attribute = p8:GetAttribute("Owner")

	if not attribute then
		return
	end

	ReplicatedStorage.RemoteEvents.ToolDamageObject:InvokeServer(unpack({
		p7,
		p8,
		"28_" .. attribute,
		p9
	}))
end
local function v55(p10)
	if not p10 then
		return false
	end

	local Name = p10.Name

	if _G.ChopTreeType == "Small Tree" then
		return Name:find("Small Tree") or Name:find("Small Webbed Tree")
	end

	if _G.ChopTreeType == "Big Tree" then
		return Name:find("TreeBig")
	end

	return false
end
local function v57()
	while _G.ChopAura do
		local Character = LocalPlayer.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			task.wait(0.5)
		elseif v44() then
			local Foliage = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Foliage")

			if Foliage then
				for _, child in ipairs(Foliage:GetChildren()) do
					if child:FindFirstChild("Trunk") and v55(child) and (child.Trunk.Position - HumanoidRootPart.Position).Magnitude <= _G.ChopAuraRange then
						local Inventory = LocalPlayer:FindFirstChild("Inventory")

						if Inventory then
							for _, child2 in ipairs(Inventory:GetChildren()) do
								if child2 and (child2.Name:find("Axe") or child2.Name:find("Chainsaw")) then
									task.spawn(function()
										v53(child, child2, HumanoidRootPart.CFrame)
									end)
								end
							end
						end
					end
				end
			end

			local Landmarks = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks")

			if Landmarks then
				for _, child in ipairs(Landmarks:GetChildren()) do
					if v55(child) then
						local Inventory = LocalPlayer:FindFirstChild("Inventory")

						if Inventory then
							for _, child2 in ipairs(Inventory:GetChildren()) do
								if child2 and (child2.Name:find("Axe") or child2.Name:find("Chainsaw")) then
									task.spawn(function()
										v53(child, child2, child:GetPivot() or child.CFrame)
									end)
								end
							end
						end
					end
				end
			end

			task.wait(0.8)
		else
			task.wait(0.5)
		end
	end
end

v42:AddToggle({
	Title = "Tree Aura",
	Flag = "TreeAura",
	Default = false,
	Callback = function(p11)
		_G.ChopAura = p11

		if p11 then
			task.spawn(v57)
		end
	end
})
v42:AddSlider({
	Title = "Chop Aura Range",
	Flag = "ChopAuraRange",
	Min = 0,
	Max = 150,
	Default = 100,
	Callback = function(p12)
		_G.ChopAuraRange = tonumber(p12)
	end
})
v42:AddDropdown({
	Title = "Tree Type",
	Flag = "ChopTreeType",
	Options = {
		"Small Tree",
		"Big Tree"
	},
	Default = "Small Tree",
	Callback = function(p13)
		_G.ChopTreeType = p13
	end
})

local v72 = Main:AddSection("Auto Stun")

_G.AutoStunDeer = false
_G.AutoStunOwl = false
_G.AutoStunRam = false
v72:AddToggle({
	Title = "Auto Stun Deer",
	Flag = "AutoStunDeer",
	Default = false,
	Callback = function(p14)
		_G.AutoStunDeer = p14

		if not p14 then
			return
		end

		task.spawn(function()
			local MonsterHitByTorch = ReplicatedStorage.RemoteEvents:WaitForChild("MonsterHitByTorch")
			local Characters = workspace:WaitForChild("Characters")

			while _G.AutoStunDeer do
				task.wait(0.1)

				local Deer = Characters:FindFirstChild("Deer")

				if Deer then
					pcall(function()
						MonsterHitByTorch:InvokeServer(Deer)
					end)
				end
			end
		end)
	end
})
v72:AddToggle({
	Title = "Auto Stun Owl",
	Flag = "AutoStunOwl",
	Default = false,
	Callback = function(p15)
		_G.AutoStunOwl = p15

		if not p15 then
			return
		end

		task.spawn(function()
			local MonsterHitByTorch = ReplicatedStorage.RemoteEvents:WaitForChild("MonsterHitByTorch")
			local Characters = workspace:WaitForChild("Characters")

			while _G.AutoStunOwl do
				task.wait(0.1)

				local Owl = Characters:FindFirstChild("Owl")

				if Owl then
					pcall(function()
						MonsterHitByTorch:InvokeServer(Owl)
					end)
				end
			end
		end)
	end
})
v72:AddToggle({
	Title = "Auto Stun Ram",
	Flag = "AutoStunRam",
	Default = false,
	Callback = function(p16)
		_G.AutoStunRam = p16

		if not p16 then
			return
		end

		task.spawn(function()
			local MonsterHitByTorch = ReplicatedStorage.RemoteEvents:WaitForChild("MonsterHitByTorch")
			local Characters = workspace:WaitForChild("Characters")

			while _G.AutoStunRam do
				task.wait(0.1)

				local v81

				for _, child in ipairs(Characters:GetChildren()) do
					if child.Name == "Ram" then
						v81 = child

						break
					end
				end

				if v81 then
					pcall(function()
						MonsterHitByTorch:InvokeServer(v81)
					end)
				end
			end
		end)
	end
})

local v84 = Main:AddSection("Godmode & Survival")

_G.GodModeEnabled = false

local connection2

local function v86(p17)
	if not p17 then
		return
	end

	local Humanoid = p17:WaitForChild("Humanoid", 5)
	local DamagePlayer = ReplicatedStorage:WaitForChild("RemoteEvents", 5):WaitForChild("DamagePlayer", 5)

	if not Humanoid or not DamagePlayer then
		return
	end

	pcall(function()
		DamagePlayer:FireServer(-math.huge)
	end)

	if connection2 then
		connection2:Disconnect()
	end

	connection2 = Humanoid.HealthChanged:Connect(function(health)
		if _G.GodModeEnabled and health < Humanoid.MaxHealth then
			pcall(function()
				DamagePlayer:FireServer(-math.huge)
			end)
		end
	end)
end

v84:AddToggle({
	Title = "Godmode (Bất Tử)",
	Flag = "Godmode",
	Default = false,
	Callback = function(p18)
		_G.GodModeEnabled = p18

		if not p18 then
			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end

			return
		end

		local DamagePlayer = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("DamagePlayer")

		v86(LocalPlayer.Character)
		LocalPlayer.CharacterAdded:Connect(function(character)
			if _G.GodModeEnabled then
				task.wait(0.3)
				v86(character)
			end
		end)
		task.spawn(function()
			while _G.GodModeEnabled do
				local Character = LocalPlayer.Character

				Character = Character and Character:FindFirstChildOfClass("Humanoid")

				if Character and Character.Health < Character.MaxHealth then
					pcall(function()
						DamagePlayer:FireServer(-math.huge)
					end)
				end

				task.wait(0.2)
			end
		end)
		v12("Godmode", "Đã bật chế độ Bất Tử (Kháng 100% sát thương)!", 2.5)
	end
})
_G.AutoGrabChildren = false
v84:AddToggle({
	Title = "Auto Grab Children",
	Flag = "AutoGrabChildren",
	Default = false,
	Callback = function(p19)
		_G.AutoGrabChildren = p19

		if not p19 then
			return
		end

		task.spawn(function()
			local OldSack = LocalPlayer:WaitForChild("Inventory"):WaitForChild("Old Sack")
			local RequestBagStoreItem = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem")

			while _G.AutoGrabChildren do
				local Character = LocalPlayer.Character

				if not Character or not Character:FindFirstChild("HumanoidRootPart") then
					break
				end

				local HumanoidRootPart = Character.HumanoidRootPart
				local CFrame_ = HumanoidRootPart.CFrame

				for _, child in ipairs(workspace.Characters:GetChildren()) do
					if child:IsA("Model") and child:GetAttribute("Lost") == true and child.PrimaryPart then
						HumanoidRootPart.CFrame = child.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
						task.wait(0.1)

						if pcall(function()
							RequestBagStoreItem:InvokeServer(OldSack, child)
						end) then
							v12("Grabbed Lost Child", child.Name, 2)
						end

						HumanoidRootPart.CFrame = CFrame_
						task.wait(0.5)
					end
				end

				task.wait(0.5)
			end
		end)
	end
})

local v98 = Main:AddSection("Auto Cook & Scrapper & Fuel")
local t3 = {
	"Steak",
	"Morsel"
}
local t4 = {}

_G.AutoFood = false
v98:AddToggle({
	Title = "Auto Cook",
	Flag = "AutoFood",
	Default = false,
	Callback = function(p20)
		_G.AutoFood = p20

		if not p20 then
			t4 = {}

			return
		end

		task.spawn(function()
			while _G.AutoFood do
				local n1 = 0

				for _, child in ipairs(Items:GetChildren()) do
					if not _G.AutoFood or n1 >= 5 then
						break
					end

					if table.find(t3, child.Name) and child:IsA("Model") and not table.find(t4, child) then
						local PrimaryPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")

						if PrimaryPart then
							n1 += 1
							child:PivotTo(CFrame.new(0, 18, 0) + Vector3.new(0, 2, 0))
							PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -25, 0)
							pcall(function()
								ReplicatedStorage.RemoteEvents.RequestStartDraggingItem:FireServer(child)
							end)
							pcall(function()
								ReplicatedStorage.RemoteEvents.StopDraggingItem:FireServer(child)
							end)
							table.insert(t4, child)
						end
					end
				end

				task.wait(0.3)
			end
		end)
	end
})

local t5 = {
	"All Items",
	"Log",
	"Sheet Metal",
	"Bolt",
	"Metal Chair",
	"Broken Microwave",
	"Old Car Engine",
	"Old Radio",
	"WashingMachine",
	"Cultist Gem",
	"Tyre",
	"UFO Junk",
	"UFO Component",
	"Broken Fan",
	"Chair"
}

getgenv().AutoScrapperTarget = "All Items"

local t6 = {}

_G.AutoScrapper = false
v98:AddDropdown({
	Title = "Select Scrapper Target",
	Flag = "ScrapperItem",
	Options = t5,
	Default = "All Items",
	Callback = function(p21)
		getgenv().AutoScrapperTarget = p21
	end
})
v98:AddToggle({
	Title = "Auto Scrapper",
	Flag = "AutoScrapper",
	Default = false,
	Callback = function(p22)
		_G.AutoScrapper = p22

		if not p22 then
			t6 = {}

			return
		end

		task.spawn(function()
			local BasePart = workspace.Map.Campground:WaitForChild("Scrapper"):FindFirstChildWhichIsA("BasePart")

			if not BasePart then
				return
			end

			local v108 = BasePart.CFrame + Vector3.new(0, 15, 0)

			while _G.AutoScrapper do
				local n2 = 0

				for _, child in ipairs(Items:GetChildren()) do
					if not _G.AutoScrapper or n2 >= 5 then
						break
					end

					if (getgenv().AutoScrapperTarget == "All Items" and table.find(t5, child.Name) and child.Name ~= "Log" or child.Name == getgenv().AutoScrapperTarget) and child:IsA("Model") and not table.find(t6, child) then
						local PrimaryPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")

						if PrimaryPart then
							n2 += 1
							child:PivotTo(v108 + Vector3.new(0, 2, 0))
							PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -25, 0)
							pcall(function()
								ReplicatedStorage.RemoteEvents.RequestStartDraggingItem:FireServer(child)
							end)
							pcall(function()
								ReplicatedStorage.RemoteEvents.StopDraggingItem:FireServer(child)
							end)
							table.insert(t6, child)
						end
					end
				end

				task.wait(0.3)
			end
		end)
	end
})

local t7 = {
	"All Fuel",
	"Coal",
	"Oil Barrel",
	"Fuel Canister",
	"Log"
}

getgenv().AutoFuelTarget = "All Fuel"

local t8 = {}

_G.AutoFuel = false
v98:AddDropdown({
	Title = "Select Fuel Target",
	Flag = "FuelItem",
	Options = t7,
	Default = "All Fuel",
	Callback = function(p23)
		getgenv().AutoFuelTarget = p23
	end
})
v98:AddToggle({
	Title = "Auto Fuel Campfire",
	Flag = "AutoFuel",
	Default = false,
	Callback = function(p24)
		_G.AutoFuel = p24

		if not p24 then
			t8 = {}

			return
		end

		task.spawn(function()
			while _G.AutoFuel do
				local n3 = 0

				for _, child in ipairs(Items:GetChildren()) do
					if not _G.AutoFuel or n3 >= 5 then
						break
					end

					if (getgenv().AutoFuelTarget == "All Fuel" and table.find(t7, child.Name) or child.Name == getgenv().AutoFuelTarget) and child:IsA("Model") and not table.find(t8, child) then
						local PrimaryPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")

						if PrimaryPart then
							n3 += 1
							child:PivotTo(CFrame.new(0, 18, 0) + Vector3.new(0, 2, 0))
							PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -25, 0)
							pcall(function()
								ReplicatedStorage.RemoteEvents.RequestStartDraggingItem:FireServer(child)
							end)
							pcall(function()
								ReplicatedStorage.RemoteEvents.StopDraggingItem:FireServer(child)
							end)
							table.insert(t8, child)
						end
					end
				end

				task.wait(0.3)
			end
		end)
	end
})

local t9 = {
	"Cultist",
	"Crossbow Cultist",
	"Hologram Emitter"
}

_G.AutoSacrifice = false
v98:AddToggle({
	Title = "Auto Sacrifice",
	Flag = "AutoSacrifice",
	Default = false,
	Callback = function(p25)
		_G.AutoSacrifice = p25

		if not p25 then
			return
		end

		task.spawn(function()
			local v120 = workspace:WaitForChild("Map"):WaitForChild("Landmarks"):WaitForChild("Volcano"):WaitForChild("Functional"):WaitForChild("Ground").CFrame + Vector3.new(0, 20, 0)

			while _G.AutoSacrifice do
				for _, child in ipairs(Items:GetChildren()) do
					if table.find(t9, child.Name) and child:IsA("Model") then
						local PrimaryPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")

						if PrimaryPart then
							child:PivotTo(v120 + Vector3.new(0, 2, 0))
							PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -25, 0)
							task.wait(0.1)
							pcall(function()
								ReplicatedStorage.RemoteEvents.RequestStartDraggingItem:FireServer(child)
							end)
							task.wait(0.1)
							pcall(function()
								ReplicatedStorage.RemoteEvents.StopDraggingItem:FireServer(child)
							end)
						end
					end
				end

				task.wait(0.8)
			end
		end)
	end
})

local v124 = Main:AddSection("Auto Eat & Fishing")

_G.TypeFoodToFill = "Carrot"
_G.AutoEat = false
_HUNGER_THRESHOLD = 100
v124:AddDropdown({
	Title = "Food Type",
	Flag = "FoodType",
	Options = {
		"Carrot",
		"Berry",
		"Cooked Morsel",
		"Cooked Steak"
	},
	Default = "Carrot",
	Callback = function(p26)
		_G.TypeFoodToFill = p26
	end
})
v124:AddSlider({
	Title = "Hunger Threshold",
	Flag = "HungerThreshold",
	Min = 1,
	Max = 200,
	Default = 100,
	Callback = function(p27)
		_HUNGER_THRESHOLD = tonumber(p27)
	end
})
v124:AddToggle({
	Title = "Auto Eat",
	Flag = "AutoEat",
	Default = false,
	Callback = function(p28)
		_G.AutoEat = p28

		if not p28 then
			return
		end

		task.spawn(function()
			local RequestConsumeItem = ReplicatedStorage.RemoteEvents.RequestConsumeItem
			local RequestStartDraggingItem = ReplicatedStorage.RemoteEvents.RequestStartDraggingItem

			local function v127(p29)
				local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

				if not HumanoidRootPart then
					return
				end

				if not (p29.PrimaryPart or p29:FindFirstChildWhichIsA("BasePart")) then
					return
				end

				p29:PivotTo(HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))

				while p29:IsDescendantOf(workspace) do
					pcall(function()
						RequestStartDraggingItem:FireServer(p29)
					end)
					pcall(function()
						RequestConsumeItem:InvokeServer(p29)
					end)
					task.wait(0.05)

					local v129 = not p29:IsDescendantOf(workspace)

					if not v129 then
						v129 = (LocalPlayer:GetAttribute("Hunger") or 0) >= 200
					end

					if v129 then
						break
					end
				end
			end

			while _G.AutoEat do
				if (LocalPlayer:GetAttribute("Hunger") or 0) <= _HUNGER_THRESHOLD then
					for _, child in ipairs(Items:GetChildren()) do
						if child.Name == _G.TypeFoodToFill and child:IsA("Model") then
							v127(child)

							break
						end
					end
				end

				task.wait(0.1)
			end
		end)
	end
})
_G.AutoCatchFishing = false
v124:AddToggle({
	Title = "100% Catch Fish",
	Flag = "AutoCatchFishing",
	Default = false,
	Callback = function(p30)
		_G.AutoCatchFishing = p30

		if not p30 then
			return
		end

		local VirtualInputManager = game:GetService("VirtualInputManager")
		local FishingCatchFrame = LocalPlayer:WaitForChild("PlayerGui", 9e9):WaitForChild("Interface", 9e9):WaitForChild("FishingCatchFrame", 9e9)
		local SuccessArea = FishingCatchFrame:WaitForChild("TimingBar", 9e9):WaitForChild("SuccessArea", 9e9)

		local function v135()
			local v136 = SuccessArea.AbsolutePosition.X + SuccessArea.AbsoluteSize.X / 2
			local v137 = SuccessArea.AbsolutePosition.Y + SuccessArea.AbsoluteSize.Y / 2

			VirtualInputManager:SendMouseButtonEvent(v136, v137, 0, true, game, 0)
			task.wait(0.05)
			VirtualInputManager:SendMouseButtonEvent(v136, v137, 0, false, game, 0)
		end

		local connection3

		connection3 = FishingCatchFrame:GetPropertyChangedSignal("Visible"):Connect(function()
			if not _G.AutoCatchFishing then
				if connection3 then
					connection3:Disconnect()
				end

				return
			end

			if FishingCatchFrame.Visible then
				SuccessArea.Size = UDim2.new(1, 0, 1, 0)
				SuccessArea.Position = UDim2.new(0, 0, 0, 0)
				task.spawn(function()
					while FishingCatchFrame.Visible and _G.AutoCatchFishing do
						v135()
						task.wait(0.02)
					end
				end)
			end
		end)
	end
})
_G.AutoTamingFlute = false
v124:AddToggle({
	Title = "100% Successful Taming Flute",
	Flag = "AutoTamingFlute",
	Default = false,
	Callback = function(p31)
		_G.AutoTamingFlute = p31

		if not p31 then
			return
		end

		local TamingFluteFrame = LocalPlayer:WaitForChild("PlayerGui", 9e9):WaitForChild("Interface", 9e9):WaitForChild("TamingFluteFrame", 9e9)

		if getgenv().TamingConnection then
			getgenv().TamingConnection:Disconnect()
			getgenv().TamingConnection = nil
		end

		getgenv().TamingConnection = TamingFluteFrame:GetPropertyChangedSignal("Visible"):Connect(function()
			if not _G.AutoTamingFlute then
				if getgenv().TamingConnection then
					getgenv().TamingConnection:Disconnect()
					getgenv().TamingConnection = nil
				end

				return
			end

			if TamingFluteFrame.Visible then
				task.spawn(function()
					while TamingFluteFrame.Visible and _G.AutoTamingFlute do
						local SuccessArea = LocalPlayer.PlayerGui.Interface.TamingFluteFrame:WaitForChild("TimingBar", 9e9):WaitForChild("SuccessArea", 9e9)

						SuccessArea.Size = UDim2.new(1, 0, 1, 0)
						SuccessArea.Position = UDim2.new(0, 0, 0, 0)
						task.wait(0.05)
					end
				end)
			end
		end)
	end
})

local v141 = Main:AddSection("Chests & Items")
local t10 = { "None" }
local t11 = {}
local v144

_G.ChestV = "None"
_G.AutoOpenAllChests = false

local function v145()
	local t12 = {}
	local t13 = {}
	local t14 = {}

	for _, child in pairs(workspace.Items:GetChildren()) do
		if child:IsA("Model") and child.Name:find("Chest") then
			for _, descendant in pairs(child:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") then
					local Name = child.Name

					t14[Name] = (t14[Name] or 0) + 1

					local v154 = Name .. " (" .. t14[Name] .. ")"

					table.insert(t12, v154)
					t13[v154] = child

					break
				end
			end
		end
	end

	table.sort(t12)

	if #t12 > 0 then
		t10 = t12
		t11 = t13

		if v144 then
			v144.Refresh(t10)
		end
	end
end

v144 = v141:AddDropdown({
	Title = "Choose Chest To Teleport",
	Flag = "ChestSelect",
	Options = t10,
	Default = "None",
	Callback = function(p32)
		_G.ChestV = p32
	end
})
v141:AddButton({
	Title = "Reset Chest List",
	Primary = false,
	Callback = function()
		v145()
		v12("Chest List", "Đã làm mới danh sách rương!", 2)
	end
})
v141:AddButton({
	Title = "Teleport To Chest",
	Primary = true,
	Callback = function()
		local Character = LocalPlayer.Character

		if not Character or not _G.ChestV or _G.ChestV == "None" then
			return
		end

		if not Character:FindFirstChild("HumanoidRootPart") then
			return
		end

		local v156 = t11[_G.ChestV]

		if v156 then
			Character:PivotTo(v156.PrimaryPart and v156.PrimaryPart.CFrame or v156:GetPivot())
		end
	end
})
v141:AddButton({
	Title = "Open All Chests Once",
	Primary = false,
	Callback = function()
		local t15 = {}

		for _, child in pairs(workspace.Items:GetChildren()) do
			if string.find(child.Name, "Chest") and child.Name ~= "Stronghold Diamond Chest" then
				for _, descendant in pairs(child:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") then
						table.insert(t15, descendant)
					end
				end
			end
		end

		for _, v in ipairs(t15) do
			if v and v:IsA("ProximityPrompt") and v.Enabled then
				pcall(function()
					v.HoldDuration = 0
					fireproximityprompt(v, 1)
				end)
				task.wait(0.05)
			end
		end

		v12("Chest", "Đã mở tất cả rương lân cận!", 2)
	end
})
v141:AddToggle({
	Title = "Auto Open All Chests Loop",
	Flag = "AutoOpenChests",
	Default = false,
	Callback = function(p33)
		_G.AutoOpenAllChests = p33
		task.spawn(function()
			while _G.AutoOpenAllChests do
				for _, child in pairs(workspace.Items:GetChildren()) do
					if string.find(child.Name, "Chest") and child.Name ~= "Stronghold Diamond Chest" then
						for _, descendant in pairs(child:GetDescendants()) do
							if descendant:IsA("ProximityPrompt") and descendant.Enabled then
								pcall(function()
									descendant.HoldDuration = 0
									fireproximityprompt(descendant, 1)
								end)
								task.wait(0.05)
							end
						end
					end
				end

				task.wait(1)
			end
		end)
	end
})

local v168 = Main:AddSection("Team & Auto Collect")

v168:AddToggle({
	Title = "Auto Revive Team",
	Flag = "AutoRevive",
	Default = false,
	Callback = function(p34)
		getgenv().AutoRevive = p34
		task.spawn(function()
			local Characters = workspace:WaitForChild("Characters", 9e9)

			while getgenv().AutoRevive do
				task.wait(1)

				local Inventory = LocalPlayer:FindFirstChild("Inventory")

				if Inventory and Inventory:FindFirstChild("Bandage") then
					for _, child in pairs(Characters:GetChildren()) do
						if string.find(child.Name, "Body") and child:FindFirstChild("HumanoidRootPart") then
							local ProximityAttachment = child.HumanoidRootPart:FindFirstChild("ProximityAttachment")

							if ProximityAttachment and ProximityAttachment:FindFirstChild("ProximityInteraction") then
								fireproximityprompt(ProximityAttachment.ProximityInteraction)
								task.wait(0.5)
							end
						end
					end
				end
			end
		end)
	end
})
v168:AddToggle({
	Title = "Auto SeedBox",
	Flag = "AutoSeedBox",
	Default = false,
	Callback = function(p35)
		getgenv().AutoSeedBox = p35
		task.spawn(function()
			local Items2 = workspace:WaitForChild("Items", 9e9)

			while getgenv().AutoSeedBox do
				for _, child in pairs(Items2:GetChildren()) do
					if child.Name == "Seed Box" then
						pcall(function()
							ReplicatedStorage.RemoteEvents.RequestPlantSeeds:InvokeServer(child)
						end)
					end
				end

				task.wait(0.5)
			end
		end)
	end
})
v168:AddToggle({
	Title = "Auto Pickup Ammo",
	Flag = "AutoPickupAmmo",
	Default = false,
	Callback = function(p36)
		getgenv().AutoPickupAmmo = p36
		task.spawn(function()
			local Items2 = workspace:WaitForChild("Items", 9e9)
			local RequestConsumeItem = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestConsumeItem")

			while getgenv().AutoPickupAmmo do
				for _, child in pairs(Items2:GetChildren()) do
					if (child:IsA("Model") or child:IsA("Part")) and string.find(child.Name, "Ammo") then
						pcall(function()
							RequestConsumeItem:InvokeServer(child)
						end)
					end
				end

				task.wait(0.1)
			end
		end)
	end
})

local v181 = Bring:AddSection("Bring Settings")

_G.ItemToPos = "Player"
_G.BringWithoutTPMode = "Normal"
v181:AddDropdown({
	Title = "Drop Item To",
	Flag = "DropPos",
	Options = {
		"Player",
		"Campfire",
		"Scrapper"
	},
	Default = "Player",
	Callback = function(p37)
		_G.ItemToPos = p37
	end
})
v181:AddDropdown({
	Title = "Bring Mode",
	Flag = "BringMode",
	Options = {
		"Normal",
		"Fast"
	},
	Default = "Normal",
	Callback = function(p38)
		_G.BringWithoutTPMode = p38
	end
})

local function v182(p39)
	if not p39 or #p39 == 0 then
		return
	end

	local CFrame_ = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame

	if _G.ItemToPos == "Campfire" then
		CFrame_ = CFrame.new(0, 18, 0)
	elseif _G.ItemToPos == "Scrapper" then
		local Scrapper = workspace.Map.Campground:FindFirstChild("Scrapper")

		Scrapper = Scrapper and Scrapper:FindFirstChildWhichIsA("BasePart")

		if Scrapper then
			CFrame_ = Scrapper.CFrame + Vector3.new(0, 15, 0)
		end
	end

	local RequestStartDraggingItem = ReplicatedStorage.RemoteEvents.RequestStartDraggingItem
	local StopDraggingItem = ReplicatedStorage.RemoteEvents.StopDraggingItem

	for _, child in ipairs(Items:GetChildren()) do
		if child:IsA("Model") and child.PrimaryPart and (table.find(p39, child.Name) or table.find(p39, "All")) then
			local PrimaryPart = child.PrimaryPart

			pcall(function()
				RequestStartDraggingItem:FireServer(child)
			end)
			child:PivotTo(CFrame_ + Vector3.new(0, 2, 0))
			PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -25, 0)
			pcall(function()
				StopDraggingItem:FireServer(child)
			end)
		end
	end

	v12("Bring", "Đã kéo các vật phẩm đã chọn!", 2)
end
local function v190(p40)
	if not p40 or #p40 == 0 then
		return
	end

	local CFrame_ = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame

	if _G.ItemToPos == "Campfire" then
		CFrame_ = CFrame.new(0, 18, 0)
	elseif _G.ItemToPos == "Scrapper" then
		local Scrapper = workspace.Map.Campground:FindFirstChild("Scrapper")

		Scrapper = Scrapper and Scrapper:FindFirstChildWhichIsA("BasePart")

		if Scrapper then
			CFrame_ = Scrapper.CFrame + Vector3.new(0, 15, 0)
		end
	end

	local RequestStartDraggingItem = ReplicatedStorage.RemoteEvents.RequestStartDraggingItem
	local StopDraggingItem = ReplicatedStorage.RemoteEvents.StopDraggingItem

	for _, child in ipairs(Items:GetChildren()) do
		if child:IsA("Model") and child.PrimaryPart and (table.find(p40, child.Name) or table.find(p40, "All")) then
			local PrimaryPart = child.PrimaryPart

			pcall(function()
				RequestStartDraggingItem:FireServer(child)
			end)
			child:PivotTo(CFrame_ + Vector3.new(0, 2, 0))
			PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -25, 0)
			pcall(function()
				StopDraggingItem:FireServer(child)
			end)
			task.wait(0.05)
		end
	end

	v12("Bring", "Đã kéo xong các vật phẩm!", 2)
end

getgenv().TypeSelect = {
	Fuel = {
		"All",
		"Coal",
		"Oil Barrel",
		"Fuel Canister",
		"Biofuel"
	},
	Resources = {
		"All",
		"Log",
		"Chair",
		"Sapling",
		"Diamond",
		"Cultist",
		"Crossbow Cultist",
		"Alien",
		"Hologram Emitter"
	},
	Food = {
		"All",
		"Morsel",
		"Cooked Morsel",
		"Steak",
		"Cooked Steak",
		"Berry",
		"Carrot",
		"Cake",
		"Chilli",
		"Stew",
		"Meat? Sandwich",
		"Corn",
		"Pumpkin"
	},
	Mental = {
		"All",
		"Broken Fan",
		"Sheet Metal",
		"Bolt",
		"Metal Chair",
		"Broken Microwave",
		"Old Car Engine",
		"Old Radio",
		"WashingMachine",
		"Cultist Gem",
		"Tyre",
		"Gem of the Forest Fragment",
		"UFO Junk",
		"UFO Component"
	},
	Tool = {
		"All",
		"Old Flashlight",
		"Strong Flashlight",
		"Good Axe",
		"Strong Axe",
		"Chainsaw",
		"Good Sack",
		"Giant Sack",
		"Kunai",
		"Morningstar",
		"Wildfire",
		"Infernal Sack",
		"Defense Blueprint",
		"Bear Trap Blueprint",
		"Lava Mine Blueprint",
		"MedKit",
		"Bandage",
		"Spear",
		"Poison Spear",
		"Thorn Body",
		"Obsidiron Body",
		"Obsidiron Hammer",
		"Obsidiron Boots",
		"Cultist King Mace"
	},
	Gun = {
		"All",
		"Revolver",
		"Revolver Ammo",
		"Rifle",
		"Rifle Ammo",
		"Tactical Shotgun",
		"Raygun",
		"Laser Canon",
		"Crossbow",
		"Infernal Crossbow",
		"Leather Body",
		"Iron Body",
		"Alien Amour"
	},
	Other = {
		"All",
		"Halloween Candle",
		"Meteor Shard",
		"Gold Shard",
		"Raw Obsidiron Ore",
		"Scalding Obsidiron Ingot",
		"Obsidiron Ingot",
		"Anvil Front",
		"Anvil Base",
		"Anvil Back",
		"Sacrifice Totem",
		"Bunny Foot",
		"Wolf Pelt",
		"Alpha Wolf Pelt",
		"Bear Pelt",
		"Wolf Corpse",
		"Alpha Wolf Corpse",
		"Bear Corpse",
		"Polar Bear Pelt",
		"Coin Stack",
		"Arctic Wolf Pelt",
		"Mammoth Tusk",
		"Cultist King Antler",
		"Scorpion Shell"
	}
}

for _, v in ipairs({
	"Fuel",
	"Resources",
	"Mental",
	"Food",
	"Tool",
	"Gun",
	"Other"
}) do
	local v200 = getgenv().TypeSelect[v]
	local v201 = Bring:AddSection(v .. " Section")
	local u202 = v200[1]

	v201:AddDropdown({
		Title = "Select " .. v .. " Item",
		Flag = "Bring" .. v,
		Options = v200,
		Default = v200[1],
		Callback = function(p41)
			u202 = p41
		end
	})
	v201:AddButton({
		Title = "Bring " .. v,
		Primary = true,
		Callback = function()
			local v203 = u202 == "All" and v200 or { u202 }

			if _G.BringWithoutTPMode == "Fast" then
				v182(v203)
			else
				v190(v203)
			end
		end
	})
end

local v204 = Teleport:AddSection("Landmarks Teleport")

v204:AddButton({
	Title = "Teleport Campfire",
	Primary = true,
	Callback = function()
		local v205 = LocalPlayer
		local Character = LocalPlayer

		if v205 then
			Character = v205.Character
		end

		if Character and v205.Character:FindFirstChild("HumanoidRootPart") then
			v205.Character:PivotTo(CFrame.new(0, 9, 0))
		end
	end
})
v204:AddButton({
	Title = "Tp to Fish Hut",
	Primary = false,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local FishingHut = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks") and workspace.Map.Landmarks:FindFirstChild("Fishing Hut")

		if HumanoidRootPart and FishingHut then
			HumanoidRootPart.CFrame = FishingHut:GetPivot().Position and CFrame.new(FishingHut:GetPivot().Position) or FishingHut.CFrame
		else
			v12("Teleport Error", "Chưa mở map Fish Hut!", 2)
		end
	end
})
v204:AddButton({
	Title = "Tp to Skills Building",
	Primary = false,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local SkillsBuilding = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks") and workspace.Map.Landmarks:FindFirstChild("Skills Building")

		if HumanoidRootPart and SkillsBuilding then
			HumanoidRootPart.CFrame = SkillsBuilding.PrimaryPart and SkillsBuilding.PrimaryPart.CFrame or SkillsBuilding:GetPivot()
		else
			v12("Teleport Error", "Chưa mở map Skills Building!", 2)
		end
	end
})
v204:AddButton({
	Title = "Tp to Stronghold",
	Primary = false,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local Stronghold = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks") and workspace.Map.Landmarks:FindFirstChild("Stronghold")

		if HumanoidRootPart and Stronghold then
			HumanoidRootPart.CFrame = Stronghold.PrimaryPart and Stronghold.PrimaryPart.CFrame or Stronghold:GetPivot()
		else
			v12("Teleport Error", "Chưa mở map Stronghold!", 2)
		end
	end
})
v204:AddButton({
	Title = "Tp to ToolWorkshop",
	Primary = false,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local ToolWorkshop = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks") and workspace.Map.Landmarks:FindFirstChild("ToolWorkshop")

		if HumanoidRootPart and ToolWorkshop then
			HumanoidRootPart.CFrame = ToolWorkshop.PrimaryPart and ToolWorkshop.PrimaryPart.CFrame or ToolWorkshop:GetPivot()
		else
			v12("Teleport Error", "Chưa mở map ToolWorkshop!", 2)
		end
	end
})
v204:AddButton({
	Title = "Teleport Volcano Sacrifice",
	Primary = true,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local Map = workspace:FindFirstChild("Map")

		Map = Map and Map:FindFirstChild("Landmarks")
		Map = Map and Map:FindFirstChild("Volcano")
		Map = Map and Map:FindFirstChild("Functional")
		Map = Map and Map:FindFirstChild("Sacrifice")

		if HumanoidRootPart and Map then
			local isBasePart = Map:IsA("BasePart") and Map or Map.PrimaryPart or Map:FindFirstChildWhichIsA("BasePart")

			if isBasePart then
				HumanoidRootPart.CFrame = isBasePart.CFrame + Vector3.new(0, 5, 0)
			end
		else
			v12("Teleport Error", "Không tìm thấy Volcano / Sacrifice!", 2)
		end
	end
})
v204:AddButton({
	Title = "Tp to Ice Temple",
	Primary = false,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local IceTemple = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks") and workspace.Map.Landmarks:FindFirstChild("Ice Temple")

		if HumanoidRootPart and IceTemple then
			HumanoidRootPart.CFrame = IceTemple.PrimaryPart and IceTemple.PrimaryPart.CFrame or IceTemple:GetPivot()
		else
			v12("Teleport Error", "Chưa mở map Ice Temple!", 2)
		end
	end
})
v204:AddButton({
	Title = "Tp to Snow Clothing Shop",
	Primary = false,
	Callback = function()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local SnowClothingShop = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Landmarks") and workspace.Map.Landmarks:FindFirstChild("Snow Clothing Shop")

		if HumanoidRootPart and SnowClothingShop then
			HumanoidRootPart.CFrame = SnowClothingShop.PrimaryPart and SnowClothingShop.PrimaryPart.CFrame or SnowClothingShop:GetPivot()
		else
			v12("Teleport Error", "Chưa mở map Snow Clothing Shop!", 2)
		end
	end
})

local v222 = Player:AddSection("Movement & Stats")

_G.Speed = 27
_G.SpeedT = false
_G.JumpPower = 50
_G.JumpPowerT = false
_G.SetSpeedFly = 100
_G.FlyToggle = false
_G.NoclipCharacter = false
v222:AddSlider({
	Title = "WalkSpeed Value",
	Flag = "WalkSpeedVal",
	Min = 16,
	Max = 400,
	Default = 27,
	Callback = function(p42)
		_G.Speed = p42
	end
})
v222:AddToggle({
	Title = "Auto WalkSpeed Loop",
	Flag = "AutoWalkSpeed",
	Default = false,
	Callback = function(p43)
		_G.SpeedT = p43

		while _G.SpeedT do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.WalkSpeed = _G.Speed
			end

			task.wait()
		end
	end
})
v222:AddSlider({
	Title = "JumpPower Value",
	Flag = "JumpPowerVal",
	Min = 27,
	Max = 320,
	Default = 50,
	Callback = function(p44)
		_G.JumpPower = p44

		local Character = LocalPlayer.Character

		if Character and Character:FindFirstChildOfClass("Humanoid") then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if Humanoid.UseJumpPower then
				Humanoid.JumpPower = _G.JumpPower
			else
				Humanoid.JumpHeight = _G.JumpPower
			end
		end
	end
})
v222:AddToggle({
	Title = "Auto JumpPower Loop",
	Flag = "AutoJumpPower",
	Default = false,
	Callback = function(p45)
		_G.JumpPowerT = p45

		local function v225(p46)
			if p46 then
				if p46.UseJumpPower then
					p46.JumpPower = _G.JumpPower
				else
					p46.JumpHeight = _G.JumpPower
				end
			end
		end

		if p45 then
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				v225(LocalPlayer.Character:FindFirstChildOfClass("Humanoid"))
			end

			LocalPlayer.CharacterAdded:Connect(function(character)
				local Humanoid = character:WaitForChild("Humanoid", 9e9)

				task.wait(0.05)
				v225(Humanoid)
			end)
		end
	end
})

local v227 = Player:AddSection("Flight & Noclip")

v227:AddSlider({
	Title = "Fly Speed",
	Flag = "FlySpeed",
	Min = 30,
	Max = 500,
	Default = 100,
	Callback = function(p47)
		_G.SetSpeedFly = p47
	end
})
v227:AddToggle({
	Title = "Fly Toggle",
	Flag = "FlyToggle",
	Default = false,
	Callback = function(p48)
		_G.FlyToggle = p48

		if not _G.FlyToggle then
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.RootPart and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
				LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
				LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
				LocalPlayer.Character.Humanoid.PlatformStand = false
			end
		end

		while _G.FlyToggle do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.RootPart and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
				LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9, 9e9, 9e9)
				LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
				LocalPlayer.Character.Humanoid.PlatformStand = true
				LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = workspace.CurrentCamera.CoordinateFrame
				LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()

				local moveVector = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector()

				if moveVector.X ~= 0 then
					local VelocityHandler = LocalPlayer.Character.HumanoidRootPart.VelocityHandler

					VelocityHandler.Velocity += workspace.CurrentCamera.CFrame.RightVector * (moveVector.X * _G.SetSpeedFly)
				end

				if moveVector.Z ~= 0 then
					local VelocityHandler = LocalPlayer.Character.HumanoidRootPart.VelocityHandler

					VelocityHandler.Velocity -= workspace.CurrentCamera.CFrame.LookVector * (moveVector.Z * _G.SetSpeedFly)
				end
			elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.RootPart then
				if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
					local BodyVelocity = Instance.new("BodyVelocity")

					BodyVelocity.Name = "VelocityHandler"
					BodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
					BodyVelocity.MaxForce = Vector3.zero
					BodyVelocity.Velocity = Vector3.zero
				end

				if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
					local BodyGyro = Instance.new("BodyGyro")

					BodyGyro.Name = "GyroHandler"
					BodyGyro.Parent = LocalPlayer.Character.HumanoidRootPart
					BodyGyro.MaxTorque = Vector3.zero
					BodyGyro.P = 1000
					BodyGyro.D = 50
				end
			end

			task.wait()
		end
	end
})
v227:AddToggle({
	Title = "Noclip",
	Flag = "Noclip",
	Default = false,
	Callback = function(p49)
		_G.NoclipCharacter = p49

		if not _G.NoclipCharacter and LocalPlayer.Character then
			for _, child in pairs(LocalPlayer.Character:GetChildren()) do
				if child:IsA("BasePart") and child.CanCollide == false then
					child.CanCollide = true
				end
			end
		end

		while _G.NoclipCharacter do
			if LocalPlayer.Character then
				for _, child in pairs(LocalPlayer.Character:GetChildren()) do
					if child:IsA("BasePart") and child.CanCollide == true then
						child.CanCollide = false
					end
				end
			end

			task.wait()
		end
	end
})

local v237 = Misc:AddSection("World & Visual Clean")
local t16 = {
	"Anvil Base",
	"Anvil Back",
	"Anvil Front"
}

v237:AddButton({
	Title = "Bring Anvil to Workshop",
	Primary = true,
	Callback = function()
		task.spawn(function()
			local Functional = workspace.Map.Landmarks.ToolWorkshop_MeteorShower:FindFirstChild("Functional")

			Functional = Functional and Functional:FindFirstChild("AnvilHologram")

			if not Functional then
				Functional = workspace.Map.Landmarks.ToolWorkshop:FindFirstChild("Functional")
				Functional = Functional and Functional:FindFirstChild("AnvilHologram")
			end

			if not Functional then
				v12("Anvil", "Đang chờ AnvilHologram xuất hiện...", 2)

				repeat
					task.wait(0.5)
					Functional = workspace.Map.Landmarks.ToolWorkshop_MeteorShower:FindFirstChild("Functional")
					Functional = Functional and Functional:FindFirstChild("AnvilHologram")

					if not Functional then
						Functional = workspace.Map.Landmarks.ToolWorkshop:FindFirstChild("Functional")
						Functional = Functional and Functional:FindFirstChild("AnvilHologram")
					end
				until Functional
			end

			for _, v in ipairs(t16) do
				local v242 = workspace.Items:FindFirstChild(v)

				if v242 and v242:IsA("Model") and v242.PrimaryPart then
					local PrimaryPart = v242.PrimaryPart

					pcall(function()
						sethiddenproperty(PrimaryPart, "NetworkOwnershipRule", Enum.NetworkOwnership.Manual)
					end)
					getgenv().Network = getgenv().Network or {
						BaseParts = {},
						Velocity = Vector3.new(14, 14, 14)
					}

					if not table.find(getgenv().Network.BaseParts, PrimaryPart) then
						table.insert(getgenv().Network.BaseParts, PrimaryPart)
					end

					PrimaryPart.CFrame = Functional.CFrame + Vector3.new(0, 20, 0)
					task.wait(0.05)
					ReplicatedStorage.RemoteEvents.RequestStartDraggingItem:FireServer(v242)
					task.wait(0.05)
					ReplicatedStorage.RemoteEvents.StopDraggingItem:FireServer(v242)

					local v244 = table.find(getgenv().Network.BaseParts, PrimaryPart)

					if v244 then
						table.remove(getgenv().Network.BaseParts, v244)
					end

					pcall(function()
						sethiddenproperty(PrimaryPart, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
					end)
				end
			end

			v12("Anvil", "Đã kéo Anvil về ToolWorkshop!", 2)
		end)
	end
})

local function v245(p50)
	for _, descendant in ipairs(p50:GetDescendants()) do
		if descendant:IsA("Decal") or descendant:IsA("Texture") then
			descendant:Destroy()
		elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("Light") then
			descendant.Enabled = false
		elseif descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui") or descendant:IsA("SurfaceLight") then
			descendant:Destroy()
		elseif descendant:IsA("MeshPart") then
			descendant.TextureID = ""
			descendant.Reflectance = 0
			descendant.Material = Enum.Material.Plastic
			descendant.Color = Color3.fromRGB(127, 127, 127)
		elseif descendant:IsA("UnionOperation") or descendant:IsA("Part") then
			descendant.Material = Enum.Material.Plastic
			descendant.Color = Color3.fromRGB(127, 127, 127)
			descendant.Reflectance = 0
		end
	end
end

_G.UltraClean = false
v237:AddToggle({
	Title = "Ultra Clean Mode (FPS Boost)",
	Flag = "UltraClean",
	Default = false,
	Callback = function(p51)
		_G.UltraClean = p51

		if p51 then
			task.spawn(function()
				while _G.UltraClean do
					pcall(function()
						Lighting.GlobalShadows = false
						Lighting.FogEnd = 9e9
						Lighting.Brightness = 1
						Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
						Lighting.Ambient = Color3.fromRGB(127, 127, 127)

						local Terrain = workspace:FindFirstChildOfClass("Terrain")

						if Terrain then
							Terrain:Clear()
							Terrain.WaterWaveSize = 0
							Terrain.WaterWaveSpeed = 0
							Terrain.WaterReflectance = 0
							Terrain.WaterTransparency = 1
						end

						v245(workspace)

						for _, player in ipairs(Players:GetPlayers()) do
							local Character = player.Character

							if Character then
								for _, child in ipairs(Character:GetChildren()) do
									if child:IsA("Accessory") or child:IsA("Hat") or child:IsA("CharacterMesh") or child:IsA("MeshPart") and child.Name ~= "HumanoidRootPart" then
										child:Destroy()
									end
								end

								v245(Character)
							end
						end
					end)
					task.wait(3)
				end
			end)
		end
	end
})
_G.FullBrightEnabled = false
v237:AddToggle({
	Title = "Full Bright",
	Flag = "FullBright",
	Default = false,
	Callback = function(p52)
		_G.FullBrightEnabled = p52

		if not _G.FullBrightEnabled then
			Lighting.Ambient = Color3.new(0, 0, 0)
			Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
			Lighting.Brightness = 1
			Lighting.ClockTime = 14
			Lighting.FogEnd = 1000
		end

		while _G.FullBrightEnabled do
			Lighting.Ambient = Color3.new(1, 1, 1)
			Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
			Lighting.Brightness = 1
			Lighting.ClockTime = 14
			Lighting.FogEnd = 100000
			task.wait()
		end
	end
})
_G.NoFog = false
v237:AddToggle({
	Title = "No Fog",
	Flag = "NoFog",
	Default = false,
	Callback = function(p53)
		_G.NoFog = p53

		while _G.NoFog do
			local pairs_ = pairs
			local children = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Boundaries") and workspace.Map.Boundaries:GetChildren() or {}

			for _, child in pairs_(children) do
				if not child:IsA("Model") then
					child:Destroy()
				end
			end

			task.wait()
		end
	end
})
_G.AntiVoid = false
_G.AntiVoidY = -150
v237:AddSlider({
	Title = "Anti Void Y Trigger",
	Flag = "AntiVoidY",
	Min = -500,
	Max = 0,
	Default = -150,
	Callback = function(p54)
		_G.AntiVoidY = p54
	end
})
v237:AddToggle({
	Title = "Anti Void Protection",
	Flag = "AntiVoid",
	Default = false,
	Callback = function(p55)
		_G.AntiVoid = p55
	end
})
RunService.Heartbeat:Connect(function()
	if _G.AntiVoid then
		local Character = LocalPlayer.Character

		if Character and Character:FindFirstChild("HumanoidRootPart") then
			local HumanoidRootPart = Character.HumanoidRootPart

			if HumanoidRootPart.Position.Y <= (_G.AntiVoidY or -150) then
				HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position.X, 5, HumanoidRootPart.Position.Z)
			end
		end
	end
end)
v237:AddToggle({
	Title = "Instant Proximity Prompt",
	Flag = "InstantPrompt",
	Default = false,
	Callback = function(p56)
		if p56 then
			if connection then
				connection:Disconnect()
				connection = nil
			end

			if fireproximityprompt then
				connection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
					fireproximityprompt(prompt)
				end)
			end
		elseif connection then
			connection:Disconnect()
			connection = nil
		end
	end
})
_G.UnlockFullMap = false
v237:AddToggle({
	Title = "Unlock Full Map (Circle)",
	Flag = "UnlockMap",
	Default = false,
	Callback = function(p57)
		_G.UnlockFullMap = p57

		local v260 = LocalPlayer
		local HumanoidRootPart = v260.Character and v260.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			v260.CharacterAdded:Wait()
			HumanoidRootPart = v260.Character:WaitForChild("HumanoidRootPart")
		end

		if not p57 then
			return
		end

		local attribute = workspace:GetAttribute("MapRange")

		if attribute ~= 1400 then
			v12("Request Campfire Lv5!", "Cần nâng cấp Campfire lên Lv5 trước khi mở toàn bộ bản đồ!", 4)
			_G.UnlockFullMap = false

			return
		end

		local Position = HumanoidRootPart.Position
		local n4 = 0
		local n5 = 0
		local n6 = 45
		local n7 = 0.17453292519943295

		task.spawn(function()
			while _G.UnlockFullMap and n5 <= attribute do
				HumanoidRootPart.CFrame = CFrame.new(Position.X + n5 * math.cos(n4), 85, Position.Z + n5 * math.sin(n4))
				n4 += n7
				n5 += n6 / 6.2831853071795862 * n7
				task.wait(0.05)
			end

			local now = tick()

			while _G.UnlockFullMap and tick() - now < 3 do
				HumanoidRootPart.CFrame = CFrame.new(Position)
				task.wait(0.1)
			end

			_G.UnlockFullMap = false
			v12("Done", "Đã mở khóa toàn bộ bản đồ thành công!", 3)
		end)
	end
})
_G.AntiAFK = false
v237:AddToggle({
	Title = "Anti AFK",
	Flag = "AntiAFK",
	Default = false,
	Callback = function(p58)
		_G.AntiAFK = p58

		if getgenv().AntiAFKConnection then
			getgenv().AntiAFKConnection:Disconnect()
			getgenv().AntiAFKConnection = nil
		end

		if p58 then
			local getconnections_ = getconnections or get_signal_cons

			if getconnections_ then
				for _, v in pairs(getconnections_(LocalPlayer.Idled)) do
					if v.Disable then
						v:Disable()
					elseif v.Disconnect then
						v:Disconnect()
					end
				end
			end

			getgenv().AntiAFKConnection = LocalPlayer.Idled:Connect(function()
				if not _G.AntiAFK then
					return
				end

				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end
	end
})

local v272 = Info:AddSection("Author & Developer")

v272:AddLabel("Hub Owner: Zaminhh")
v272:AddLabel("UI Library: KITSUI Library v1.0")
v272:AddLabel("Status: Active & Updated")
Info:AddSection("Community & Support"):AddButton({
	Title = "Copy Discord KITS (discord.gg/tdt)",
	Primary = true,
	Callback = function()
		setclipboard("https://discord.gg/tdt")
		v12("Discord", "Đã sao chép link Discord TDT Hub!", 2.5)
	end
})
v12("KITS Hub", "KITS Hub v1.0 đã được nạp thành công!", 3)
