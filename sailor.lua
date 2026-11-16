-- This file was generated at discord.gg/syncrypt

local unpack_ = unpack or table.unpack
local t1 = {
	value1 = game:GetService("Players")
}

t1.value2 = t1.value1.LocalPlayer

while not t1.value2 do
	task.wait(0.5)
	t1.value2 = t1.value1.LocalPlayer
end

t1.value3 = game:GetService("VirtualUser");
(function()
	t1.value2.Idled:Connect(function()
		t1.value3:CaptureController()
		t1.value3:ClickButton2(Vector2.new())
	end)
	task.spawn(function()
		while true do
			task.wait(60)

			local value2 = t1.value2

			if value2 then
				value2 = t1.value2.Character
			end

			local Humanoid = value2 and t1.value2.Character:FindFirstChild("Humanoid")

			if Humanoid then
				local JumpPower = Humanoid.JumpPower

				Humanoid.JumpPower = 0
				Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				task.wait(0.1)
				Humanoid.JumpPower = JumpPower or 50
			end
		end
	end)
end)()
t1.value4 = t1.value2.Character

if not t1.value4 then
	t1.value4 = t1.value2.CharacterAdded:Wait()
end

t1.value5 = t1.value4:WaitForChild("HumanoidRootPart", 30)

if not t1.value5 then
	local _ = t1.value5

	repeat
		task.wait(0.5)
		t1.value5 = t1.value4:FindFirstChild("HumanoidRootPart")
	until t1.value5
end

if getgenv then
	if getgenv().SailorConnections then
		for _, sailorConnection in ipairs(getgenv().SailorConnections) do
			local Connected

			if sailorConnection then
				Connected = sailorConnection.Connected
			else
				Connected = sailorConnection
			end

			if Connected then
				sailorConnection:Disconnect()
			end
		end
	end

	getgenv().SailorConnections = {}
	getgenv().SailorInstanceID = getgenv().SailorInstanceID and getgenv().SailorInstanceID + 1 or 1
end

if getgenv then
	local _ = getgenv().SailorInstanceID
end

t1.value6 = game:GetService("RunService")
t1.value7 = game:GetService("ReplicatedStorage")
t1.value8 = game:GetService("TweenService")
t1.value9 = game:GetService("UserInputService")
t1.value10 = game:GetService("Workspace")

local CombatSystem = t1.value7:WaitForChild("CombatSystem")
local Remotes = CombatSystem:WaitForChild("Remotes")

t1.value11 = require(CombatSystem:WaitForChild("CombatConfig"))
t1.value12 = Remotes.RequestHit
Remotes:FindFirstChild("GilgameshSwingFeedback")

local Remotes2 = t1.value7:WaitForChild("Remotes")

Remotes2:WaitForChild("EquipWeapon")

local AbilitySystem = t1.value7:FindFirstChild("AbilitySystem")

if AbilitySystem then
	AbilitySystem = AbilitySystem:FindFirstChild("Remotes")
end

local Remotes3 = t1.value7:FindFirstChild("Remotes")
local HakiRemote

if Remotes3 then
	HakiRemote = Remotes3:FindFirstChild("HakiRemote")
else
	HakiRemote = Remotes3
end

t1.value13 = HakiRemote

local ObservationHakiRemote

if Remotes3 then
	ObservationHakiRemote = Remotes3:FindFirstChild("ObservationHakiRemote")
else
	ObservationHakiRemote = Remotes3
end

t1.value14 = ObservationHakiRemote

if Remotes3 then
	Remotes3 = Remotes3:FindFirstChild("ConquerorHakiRemote")
end

t1.value15 = Remotes3
t1.value16 = t1.value7:FindFirstChild("RemoteEvents")

local value16 = t1.value16

if value16 then
	value16 = t1.value16:FindFirstChild("QuestAccept")
end

t1.value17 = value16

if t1.value16 then
	t1.value16:FindFirstChild("QuestAbandon")
end

local value162 = t1.value16

if value162 then
	value162 = t1.value16:FindFirstChild("AllocateStat")
end

t1.value18 = value162

local value163 = t1.value16

if value163 then
	value163 = t1.value16:FindFirstChild("ResetStats")
end

t1.value19 = value163

local value164 = t1.value16

if value164 then
	value164 = t1.value16:FindFirstChild("GetPlayerStats")
end

t1.value20 = value164

local value165 = t1.value16

if value165 then
	value165 = t1.value16:FindFirstChild("QuestProgress")
end

local value166 = t1.value16

if value166 then
	value166 = t1.value16:FindFirstChild("QuestUIUpdate")
end

t1.value21 = {
	active = false,
	questlineId = nil,
	currentStage = 1,
	progress = 0,
	goal = 0,
	title = "",
	description = ""
}
t1.value22 = {
	active = false,
	questlineId = nil,
	currentStage = 1,
	progress = 0,
	goal = 6,
	title = "",
	description = ""
}
t1.value23 = Remotes2:FindFirstChild("RequestInventory")
t1.value24 = Remotes2:FindFirstChild("RequestSummonBoss")
Remotes2:FindFirstChild("RequestAutoSpawn")
Remotes2:FindFirstChild("SummonBossResult")

if t1.value7:FindFirstChild("Modules") then
	t1.value7.Modules:FindFirstChild("DungeonConfig")
end

t1.value25 = t1.value10:FindFirstChild("NPCs")
t1.value26 = t1.value10:FindFirstChild("ServiceNPCs")
t1.value27 = {
	{
		questNPC = "QuestNPC1",
		id = "thief_hunt_1",
		title = "Thief Hunter (Lv.0)",
		npcType = "Thief",
		amount = 5,
		recommendedLevel = 0,
		isBoss = false,
		island = "StarterIsland"
	},
	{
		questNPC = "QuestNPC2",
		id = "boss_hunt_1",
		title = "Thief Boss (Lv.100)",
		npcType = "ThiefBoss",
		amount = 1,
		recommendedLevel = 100,
		isBoss = true,
		island = "StarterIsland"
	},
	{
		questNPC = "QuestNPC3",
		id = "monkey_hunt_1",
		title = "Monkey Hunter (Lv.250)",
		npcType = "Monkey",
		amount = 5,
		recommendedLevel = 250,
		isBoss = false,
		island = "JungleIsland"
	},
	{
		questNPC = "QuestNPC4",
		id = "monkey_hunt_2",
		title = "Monkey Boss (Lv.500)",
		npcType = "MonkeyBoss",
		amount = 1,
		recommendedLevel = 500,
		isBoss = true,
		island = "JungleIsland"
	},
	{
		questNPC = "QuestNPC5",
		id = "desert_hunt_1",
		title = "Desert Bandit Hunter (Lv.750)",
		npcType = "DesertBandit",
		amount = 5,
		recommendedLevel = 750,
		isBoss = false,
		island = "DesertIsland"
	},
	{
		questNPC = "QuestNPC6",
		id = "desert_hunt_2",
		title = "Desert Bandit Boss (Lv.1000)",
		npcType = "DesertBoss",
		amount = 1,
		recommendedLevel = 1000,
		isBoss = true,
		island = "DesertIsland"
	},
	{
		questNPC = "QuestNPC7",
		id = "snow_hunt_1",
		title = "Frost Rogue Hunter (Lv.1500)",
		npcType = "FrostRogue",
		amount = 5,
		recommendedLevel = 1500,
		isBoss = false,
		island = "SnowIsland"
	},
	{
		questNPC = "QuestNPC8",
		id = "snow_hunt_2",
		title = "Winter Warden Boss (Lv.2000)",
		npcType = "SnowBoss",
		amount = 1,
		recommendedLevel = 2000,
		isBoss = true,
		island = "SnowIsland"
	},
	{
		questNPC = "QuestNPC9",
		id = "jjk_hunt_1",
		title = "Sorcerer Hunter (Lv.3000)",
		npcType = "Sorcerer",
		amount = 5,
		recommendedLevel = 3000,
		isBoss = false,
		island = "ShibuyaStation"
	},
	{
		questNPC = "QuestNPC10",
		id = "jjk_hunt_2",
		title = "Panda Sorcerer Boss (Lv.4000)",
		npcType = "PandaMiniBoss",
		amount = 1,
		recommendedLevel = 4000,
		isBoss = true,
		island = "ShibuyaStation"
	},
	{
		questNPC = "QuestNPC11",
		id = "hollow_hunt_1",
		title = "Hollow Hunter (Lv.5000)",
		npcType = "Hollow",
		amount = 5,
		recommendedLevel = 5000,
		isBoss = false,
		island = "HuecoMundo"
	},
	{
		questNPC = "QuestNPC12",
		id = "strong_sorcerer_hunt_1",
		title = "Strong Sorcerer Hunter (Lv.6000)",
		npcType = "StrongSorcerer",
		amount = 5,
		recommendedLevel = 6000,
		isBoss = false,
		island = "ShinjukuIsland"
	},
	{
		questNPC = "QuestNPC13",
		id = "curse_hunt_1",
		title = "Curse Hunter (Lv.7000)",
		npcType = "Curse",
		amount = 5,
		recommendedLevel = 7000,
		isBoss = false,
		island = "ShinjukuIsland"
	},
	{
		questNPC = "QuestNPC14",
		id = "slime_warrior_hunt_1",
		title = "Slime Warrior Hunter (Lv.8000)",
		npcType = "SlimeWarrior",
		amount = 5,
		recommendedLevel = 8000,
		isBoss = false,
		island = "SlimeIsland"
	},
	{
		questNPC = "QuestNPC15",
		id = "academy_teacher_hunt_1",
		title = "Academy Challenge (Lv.9000)",
		npcType = "AcademyTeacher",
		amount = 5,
		recommendedLevel = 9000,
		isBoss = false,
		island = "AcademyIsland"
	}
}
t1.value28 = {
	GojoBoss = {
		displayName = "Gojo",
		modelName = "GojoBoss",
		spawnPointName = "TimedBossSpawn_GojoBoss",
		spawnLocation = "ShibuyaStation",
		respawnDelay = 300,
		island = "ShibuyaStation"
	},
	SukunaBoss = {
		displayName = "Sukuna",
		modelName = "SukunaBoss",
		spawnPointName = "TimedBossSpawn_SukunaBoss",
		spawnLocation = "ShibuyaStation",
		respawnDelay = 300,
		island = "ShibuyaStation"
	},
	YujiBoss = {
		displayName = "Yuji",
		modelName = "YujiBoss",
		spawnPointName = "TimedBossSpawn_YujiBoss",
		spawnLocation = "ShibuyaStation",
		respawnDelay = 300,
		island = "ShibuyaStation"
	},
	AizenBoss = {
		displayName = "Aizen",
		modelName = "AizenBoss",
		spawnPointName = "TimedBossSpawn_AizenBoss",
		spawnLocation = "HuecoMundo",
		respawnDelay = 300,
		island = "HuecoMundo"
	},
	JinwooBoss = {
		displayName = "Jinwoo",
		modelName = "JinwooBoss",
		spawnPointName = "TimedBossSpawn_JinwooBoss",
		spawnLocation = "SailorIsland",
		respawnDelay = 390,
		island = "SailorIsland"
	},
	AlucardBoss = {
		displayName = "Alucard",
		modelName = "AlucardBoss",
		spawnPointName = "TimedBossSpawn_AlucardBoss",
		spawnLocation = "SailorIsland",
		respawnDelay = 300,
		island = "SailorIsland"
	},
	MadokaBoss = {
		displayName = "Madoka",
		modelName = "MadokaBoss",
		spawnPointName = "TimedBossSpawn_MadokaBoss",
		spawnLocation = "ValentineIsland",
		respawnDelay = 390,
		island = "ValentineIsland"
	}
}
t1.value29 = {
	SaberBoss = {
		bossId = "SaberBoss",
		displayName = "Saber",
		island = "BossIsland",
		hasDifficulty = false,
		costs = {
			items = {
				itemId = "Boss Key",
				quantity = 1
			},
			money = 100000,
			gems = 175
		}
	},
	QinShiBoss = {
		bossId = "QinShiBoss",
		displayName = "Qin Shi",
		island = "BossIsland",
		hasDifficulty = false,
		costs = {
			items = {
				itemId = "Boss Key",
				quantity = 3
			},
			money = 250000,
			gems = 400
		}
	},
	IchigoBoss = {
		bossId = "IchigoBoss",
		displayName = "Ichigo",
		island = "BossIsland",
		hasDifficulty = false,
		costs = {
			items = {
				itemId = "Boss Key",
				quantity = 5
			},
			money = 350000,
			gems = 600
		}
	},
	GilgameshBoss = {
		bossId = "GilgameshBoss",
		displayName = "Gilgamesh",
		island = "BossIsland",
		hasDifficulty = true,
		difficulties = {
			"Normal",
			"Medium",
			"Hard",
			"Extreme"
		},
		costs = {
			Normal = {
				items = {
					itemId = "Divine Grail",
					quantity = 1
				},
				money = 500000,
				gems = 500
			},
			Medium = {
				items = {
					itemId = "Divine Grail",
					quantity = 2
				},
				money = 650000,
				gems = 650
			},
			Hard = {
				items = {
					itemId = "Divine Grail",
					quantity = 3
				},
				money = 750000,
				gems = 750
			},
			Extreme = {
				items = {
					itemId = "Divine Grail",
					quantity = 4
				},
				money = 1000000,
				gems = 1000
			}
		}
	}
}

local t2 = {
	"Normal",
	"Medium",
	"Hard",
	"Extreme"
}

t1.value30 = {
	StarterIsland = {
		Center = Vector3.new(108, 71, -234),
		DisplayName = "Starter Island"
	},
	JungleIsland = {
		Center = Vector3.new(-529, 44, 430),
		DisplayName = "Jungle Island"
	},
	DesertIsland = {
		Center = Vector3.new(-919, 25, -462),
		DisplayName = "Desert Island"
	},
	SnowIsland = {
		Center = Vector3.new(-391, 64, -1195),
		DisplayName = "Snow Island"
	},
	BossIsland = {
		Center = Vector3.new(812, 23, -1133),
		DisplayName = "Boss Island"
	},
	ShibuyaStation = {
		Center = Vector3.new(1615, 184, 230),
		DisplayName = "Shibuya Station"
	},
	SailorIsland = {
		Center = Vector3.new(221, 68, 797),
		DisplayName = "Sailor Island"
	},
	HuecoMundo = {
		Center = Vector3.new(-534, 72, 1181),
		DisplayName = "Hueco Mundo"
	},
	DungeonIsland = {
		Center = Vector3.new(1374, 20, -907),
		DisplayName = "Dungeon Island"
	},
	ShinjukuIsland = {
		Center = Vector3.new(300, 50, -2126),
		DisplayName = "Shinjuku Island"
	},
	ValentineIsland = {
		Center = Vector3.new(-1248, 32, -1266),
		DisplayName = "Valentine Island"
	},
	SlimeIsland = {
		Center = Vector3.new(-1249, 41, 251),
		DisplayName = "Slime Island"
	},
	AcademyIsland = {
		Center = Vector3.new(954, 48, 1317),
		DisplayName = "Academy Island"
	}
}
t1.value31 = {
	Version = "2.4.0",
	KillAura = {
		Enabled = false,
		Range = 200,
		MaxTargets = 10,
		TargetPlayers = false,
		TargetNPCs = true,
		Whitelist = {},
		Blacklist = {},
		HitsPerFrame = 1,
		WeaponSwitchDelay = 0.5
	},
	AutoHaki = {
		Enabled = false,
		UseArmament = true,
		UseObservation = true,
		UseConqueror = false,
		Interval = 30
	},
	AutoFarm = {
		Enabled = false,
		SelectedQuest = "thief_hunt_1",
		TeleportHeight = 15,
		AutoAcceptQuest = true,
		currentTarget = nil,
		killCount = 0,
		AutoEquipWeapon = true,
		WeaponType = "Melee"
	},
	FullAutoFarm = {
		Enabled = false,
		AutoSwitchQuest = true,
		AutoTeleportToIsland = true,
		AutoEnableKillAura = true,
		AutoEnableHaki = true,
		AttackHeight = 15,
		KillAuraRange = 200,
		TargetLevel = 10000,
		BossPriorityLevel = 6000,
		FarmBosses = false,
		currentQuestIndex = 1,
		lastQuestSwitch = 0,
		QuestSwitchCooldown = 3
	},
	AutoFarmTimedBoss = {
		Enabled = false,
		SelectedBosses = { "All" },
		AttackHeight = 15,
		KillAuraRange = 300,
		bossKillCount = 0,
		currentBoss = nil,
		lastBossCheck = 0,
		BossCheckInterval = 0.5,
		ServerHopEnabled = false,
		ServerHopCooldown = 60,
		lastServerHop = 0,
		visitedServers = {},
		noBossTime = 0,
		currentIslandIndex = 1
	},
	AutoSummonBoss = {
		Enabled = false,
		SelectedBoss = "SaberBoss",
		Difficulty = "Normal",
		AttackHeight = 15,
		KillAuraRange = 300,
		AutoEnableKillAura = true,
		AutoEnableHaki = true,
		bossKillCount = 0,
		lastSpawnAttempt = 0,
		spawnCooldown = 0.5,
		AutoDupeBossKey = false,
		DupeBossKeyCurrency = "Gems",
		DupeBossKeyDelay = 0.5,
		lastDupeTime = 0
	},
	AutoDemoniteEvent = {
		Enabled = false,
		PieceNames = { "DemoniteCore1", "DemoniteCore2" },
		QuestNPC = "AnosQuestNPC",
		QuestlineId = "DemoniteCoreUnlock",
		collectedPieces = {},
		currentPieceIndex = 1
	},
	AutoSlimeEvent = {
		Enabled = false,
		PieceName = "SlimePuzzlePiece",
		QuestNPC = "SlimeCraftNPC",
		QuestlineId = "SlimeCraftUnlock",
		IslandOrder = {
			"DesertIsland",
			"SnowIsland",
			"StarterIsland",
			"JungleIsland",
			"ShibuyaStation",
			"HuecoMundo",
			"ShinjukuIsland"
		},
		collectedPieces = {},
		currentPieceIndex = 1
	},
	AutoDungeonDiscovery = {
		Enabled = false,
		PieceName = "DungeonPuzzlePiece",
		QuestNPC = "DungeonPortalsNPC",
		QuestlineId = "DungeonUnlock",
		MinLevel = 5000,
		IslandOrder = {
			"StarterIsland",
			"JungleIsland",
			"DesertIsland",
			"SnowIsland",
			"ShibuyaStation",
			"HuecoMundo"
		},
		collectedPieces = {},
		currentPieceIndex = 1,
		lastSearchTime = 0,
		searchInterval = 1,
		attemptedIslands = {},
		lastAttemptTime = 0
	},
	AutoJinwooQuest = {
		Enabled = false,
		QuestNPC = "JinwooMovesetNPC",
		QuestlineId = "Jinwoo",
		RequiredItems = {
			{
				name = "Abyss Edge",
				quantity = 6,
				dropFrom = "JinwooBoss",
				chance = 17.5
			},
			{
				name = "Dark Ring",
				quantity = 3,
				dropFrom = "JinwooBoss",
				chance = 7
			},
			{
				name = "Shadow Heart",
				quantity = 1,
				dropFrom = "JinwooBoss",
				chance = 2
			}
		},
		RequiredMoney = 2500000,
		RequiredGems = 7500,
		currentStage = 0,
		ManualStage = 1,
		UseManualStage = false,
		stageProgress = {},
		playerKills = 0,
		npcsKilled = 0,
		damageTaken = 0,
		damageDealt = 0,
		jinwooBossKills = 0,
		farmingItems = false,
		lastProgressCheck = 0,
		questAccepted = false,
		aggroTimer = 0,
		isAggro = false,
		ServerHopEnabled = false,
		ServerHopCooldown = 30,
		lastServerHop = 0,
		visitedServers = {},
		noBossTime = 0
	},
	AutoDungeon = {
		Enabled = false,
		SelectedDungeon = "DoubleDungeon",
		Difficulty = "Easy",
		Dungeons = {
			CidDungeon = {
				PlaceId = 75159314259063,
				MinLevel = 5000,
				KeyCost = 1,
				DisplayName = "Cid Dungeon"
			},
			RuneDungeon = {
				PlaceId = 99684056491472,
				MinLevel = 5000,
				KeyCost = 1,
				DisplayName = "Rune Dungeon"
			},
			DoubleDungeon = {
				PlaceId = 123955125827130,
				MinLevel = 7500,
				KeyCost = 2,
				DisplayName = "Double Dungeon"
			}
		},
		DistanceFromMonster = 10,
		KillAuraRange = 300,
		lastPortalRequest = 0,
		portalRequestCooldown = 5,
		inDungeon = false,
		dungeonClears = 0,
		difficultyVoted = false,
		currentTarget = nil
	},
	AutoStats = {
		Enabled = false,
		SelectedStat = "Melee",
		PointsPerAllocation = 1,
		Interval = 0.5
	},
	AutoSkill = {
		Enabled = true,
		UseZ = true,
		UseX = true,
		UseC = true,
		UseV = true,
		SkillDelay = 0.5,
		ZCooldown = 7,
		XCooldown = 12,
		CCooldown = 20,
		VCooldown = 30
	},
	Teleport = {
		LastLocation = nil,
		SelectedIsland = nil
	}
}
t1.value32 = 0
t1.value33 = nil

if AbilitySystem then
	t1.value33 = AbilitySystem:FindFirstChild("RequestAbility")
end

t1.value34 = {
	Z = 0,
	X = 0,
	C = 0,
	V = 0
}
t1.value35 = {
	"Z",
	"X",
	"C",
	"V"
}
t1.value36 = 0
t1.value37 = {
	"Flame",
	"Bomb",
	"Quake",
	"Light",
	"Invisible"
}
t1.value38 = nil

function t1.value38(p1)
	local v25, v26, v27 = pairs(t1.value11.Weapons)

	while true do
		local v28

		v27, v28 = v25(v26, v27)

		if not v27 then
			break
		end

		if v28.ToolName == p1 then
			return v28.StatType
		end
	end

	for _, v in ipairs(t1.value37) do
		if p1 == v then
			return "Power"
		end
	end

	return nil
end

local function v31()
	local Character = t1.value2.Character

	if Character then
		return Character:FindFirstChildOfClass("Tool")
	else
		return nil
	end
end

function t1.value39()
	local Character = t1.value2.Character

	if Character then
		return Character.FindFirstChildOfClass(Character, "Humanoid")
	else
		return nil
	end
end
function t1.value40()
	local t3 = {}
	local t4 = {}
	local t5 = {}
	local Backpack = t1.value2:FindFirstChild("Backpack")

	if Backpack then
		for _, child in ipairs(Backpack:GetChildren()) do
			if child:IsA("Tool") then
				local v40 = t1.value38(child.Name)

				if v40 == "Melee" then
					table.insert(t3, child)
				elseif v40 == "Sword" then
					table.insert(t4, child)
				elseif v40 == "Power" then
					table.insert(t5, child)
				end
			end
		end

		return t3, t4, t5
	else
		return t3, t4, t5
	end
end
function t1.value41(p2)
	if p2 == "Z" then
		return t1.value31.AutoSkill.ZCooldown
	elseif p2 == "X" then
		return t1.value31.AutoSkill.XCooldown
	elseif p2 == "C" then
		return t1.value31.AutoSkill.CCooldown
	else
		return p2 ~= "V" and 10 or t1.value31.AutoSkill.VCooldown
	end
end
function t1.value42(p3)
	return tick() < t1.value34[p3]
end
function t1.value43(p4)
	t1.value34[p4] = tick() + t1.value41(p4)
end

t1.value44 = nil

function t1.value44(p5)
	if t1.value31.AutoSkill.Enabled then
		local v41

		if p5 == "Z" then
			v41 = not t1.value31.AutoSkill.UseZ
		else
			v41 = false
		end

		if v41 then
			return false
		else
			local v42

			if p5 == "X" then
				v42 = not t1.value31.AutoSkill.UseX
			else
				v42 = false
			end

			if v42 then
				return false
			else
				local v43

				if p5 == "C" then
					v43 = not t1.value31.AutoSkill.UseC
				else
					v43 = false
				end

				if v43 then
					return false
				else
					local v44

					if p5 == "V" then
						v44 = not t1.value31.AutoSkill.UseV
					else
						v44 = false
					end

					if v44 then
						return false
					else
						return not t1.value42(p5)
					end
				end
			end
		end
	else
		return false
	end
end
function t1.value45()
	if not t1.value31.AutoSkill.Enabled then
		return
	end

	if not t1.value33 then
		return
	end

	local Character = t1.value2.Character
	local Tool

	if Character then
		Tool = Character:FindFirstChildOfClass("Tool")
	else
		Tool = nil
	end

	if not Tool then
		return
	end

	for i = 1, 4 do
		local v48 = t1.value35[i]

		if t1.value44(v48) then
			local function v49()
				t1.value33:FireServer(i)
			end

			local t6 = { pcall(v49) }
			local _ = t6[2]

			if t6[1] then
				t1.value43(v48)

				return
			else
				return
			end
		end
	end
end

if value165 then
	value165.OnClientEvent:Connect(function(p6)
		if not p6 then
			return
		end

		local title = p6.questlineId ~= "Jinwoo" and p6.title

		if title then
			title = string.find(string.lower(p6.title), "jinwoo")
		end

		if title then
			t1.value21.active = true
			t1.value21.questlineId = p6.questlineId

			if p6.currentStage then
				t1.value21.currentStage = p6.currentStage
			end

			t1.value21.progress = p6.progress or 0
			t1.value21.goal = p6.goal or 0
			t1.value21.title = p6.title or ""
			t1.value21.description = p6.description or ""
		end

		if p6.questlineId ~= "DungeonUnlock" then
			return
		end

		t1.value22.active = true
		t1.value22.questlineId = p6.questlineId

		if p6.currentStage then
			t1.value22.currentStage = p6.currentStage
		end

		t1.value22.progress = p6.progress or 0
		t1.value22.goal = p6.goal or 6

		if not t1.value31.AutoDungeonDiscovery.Enabled then
			return
		end

		local currentPieceIndex = t1.value22.progress + 1

		if t1.value31.AutoDungeonDiscovery.currentPieceIndex == currentPieceIndex then
			return
		end

		t1.value31.AutoDungeonDiscovery.currentPieceIndex = currentPieceIndex
	end)
end

if value166 then
	value166.OnClientEvent:Connect(function(_, p7)
		if not (p7 and (p7.questlineId == "Jinwoo" or (p7.title and string.find(string.lower(p7.title), "jinwoo") or p7.currentStage))) then
			return
		end

		t1.value21.active = true
		t1.value21.currentStage = p7.currentStage or 1
		t1.value21.progress = p7.progress or 0
		t1.value21.goal = p7.goal or 0
	end)
end

function t1.value46()
	local AutoJinwooQuest = t1.value31 and t1.value31.AutoJinwooQuest
	local PlayerGui, QuestUI, isTextLabel, v58, v59, v60, v61, v62, v63

	if AutoJinwooQuest then
	elseif AutoJinwooQuest then
		return t1.value31.AutoJinwooQuest.ManualStage
	elseif t1.value21.active then
		return t1.value21.currentStage
	else
		PlayerGui = t1.value1.LocalPlayer:FindFirstChild("PlayerGui")

		if PlayerGui then
			QuestUI = PlayerGui:FindFirstChild("QuestUI")

			if QuestUI then
				for _, descendant in ipairs(QuestUI:GetDescendants()) do
					isTextLabel = descendant:IsA("TextLabel")

					if isTextLabel then
						isTextLabel = descendant.Text
					end

					if isTextLabel then
						v58 = string.lower(descendant.Text)
						v59 = string.find(v58, "take") and string.find(v58, "damage")

						if v59 then
							v59 = string.find(v58, "15")
						end

						if v59 then
							return 1
						end

						v60 = string.find(v58, "kill") and string.find(v58, "npc")

						if v60 then
							v60 = string.find(v58, "750")
						end

						if v60 then
							return 2
						end

						v61 = string.find(v58, "deal") and string.find(v58, "damage")

						if v61 then
							v61 = string.find(v58, "100")
						end

						if v61 then
							return 3
						end

						v62 = string.find(v58, "kill") and string.find(v58, "player")

						if v62 then
							v62 = string.find(v58, "20")
						end

						if v62 then
							return 4
						end

						v63 = string.find(v58, "jinwoo") and string.find(v58, "boss")

						if v63 then
							v63 = string.find(v58, "15")
						end

						if v63 then
							return 5
						end
					end
				end

				return nil
			else
				return nil
			end
		else
			return nil
		end
	end

	AutoJinwooQuest = t1.value31.AutoJinwooQuest.UseManualStage

	if AutoJinwooQuest then
		return t1.value31.AutoJinwooQuest.ManualStage
	elseif t1.value21.active then
		return t1.value21.currentStage
	else
		PlayerGui = t1.value1.LocalPlayer:FindFirstChild("PlayerGui")

		if PlayerGui then
			QuestUI = PlayerGui:FindFirstChild("QuestUI")

			if QuestUI then
				for _, descendant in ipairs(QuestUI:GetDescendants()) do
					isTextLabel = descendant:IsA("TextLabel")

					if isTextLabel then
						isTextLabel = descendant.Text
					end

					if isTextLabel then
						v58 = string.lower(descendant.Text)
						v59 = string.find(v58, "take") and string.find(v58, "damage")

						if v59 then
							v59 = string.find(v58, "15")
						end

						if v59 then
							return 1
						end

						v60 = string.find(v58, "kill") and string.find(v58, "npc")

						if v60 then
							v60 = string.find(v58, "750")
						end

						if v60 then
							return 2
						end

						v61 = string.find(v58, "deal") and string.find(v58, "damage")

						if v61 then
							v61 = string.find(v58, "100")
						end

						if v61 then
							return 3
						end

						v62 = string.find(v58, "kill") and string.find(v58, "player")

						if v62 then
							v62 = string.find(v58, "20")
						end

						if v62 then
							return 4
						end

						v63 = string.find(v58, "jinwoo") and string.find(v58, "boss")

						if v63 then
							v63 = string.find(v58, "15")
						end

						if v63 then
							return 5
						end
					end
				end

				return nil
			else
				return nil
			end
		else
			return nil
		end
	end
end

t1.value47 = 0

function t1.value48()
	if tick() - t1.value47 < 3 then
		return
	end

	local AutoJinwooQuest = t1.value31.AutoJinwooQuest

	if not (AutoJinwooQuest and AutoJinwooQuest.Enabled) then
		return
	end

	local v69 = t1.value46()
	local v70

	if v69 then
		v70 = v69 ~= AutoJinwooQuest.currentStage
	else
		v70 = v69
	end

	if not v70 then
		return
	end

	AutoJinwooQuest.currentStage = v69
	AutoJinwooQuest.isAggro = false
	t1.value31.KillAura.TargetPlayers = false
	Library:Notify("Jinwoo Quest Stage " .. v69, 3)
end

t1.value49 = nil

function t1.value50()
	return t1.value2.Character or t1.value2.CharacterAdded:Wait()
end
function t1.value51()
	local HumanoidRootPart = t1.value50()

	if not HumanoidRootPart then
		return HumanoidRootPart
	end

	HumanoidRootPart = HumanoidRootPart:FindFirstChild("HumanoidRootPart")

	return HumanoidRootPart
end

t1.value52 = nil

function t1.value52(p8)
	if not p8 then
		return p8
	end

	p8 = p8:FindFirstChild("Humanoid")

	return p8
end

t1.value53 = nil

function t1.value54(p9)
	local v72 = t1.value52(p9)

	if not v72 then
		return v72
	end

	v72 = v72.Health > 0

	return v72
end
function t1.value55(p10)
	if #t1.value31.KillAura.Whitelist == 0 then
		return true
	else
		local v73 = string.lower(p10)

		for _, v in ipairs(t1.value31.KillAura.Whitelist) do
			if string.find(v73, string.lower(v)) then
				return true
			end
		end

		return false
	end
end
function t1.value56(p11)
	if #t1.value31.KillAura.Blacklist == 0 then
		return false
	else
		local v76 = string.lower(p11)

		for _, v in ipairs(t1.value31.KillAura.Blacklist) do
			if string.find(v76, string.lower(v)) then
				return true
			end
		end

		return false
	end
end
function t1.value57(p12, p13)
	local v79 = t1.value51()

	if not v79 then
		return {}
	end

	local value25 = t1.value25 or t1.value10:FindFirstChild("NPCs")
	local t7 = {}
	local Position = v79.Position
	local _ = p12 * p12
	local TargetNPCs

	if value25 then
		TargetNPCs = t1.value31.KillAura.TargetNPCs
	else
		TargetNPCs = value25
	end

	if TargetNPCs then
		for _, child in ipairs(value25:GetChildren()) do
			local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				local Magnitude = (Position - HumanoidRootPart.Position).Magnitude

				if Magnitude <= p12 then
					local Humanoid = child:FindFirstChildOfClass("Humanoid")

					if Humanoid then
						Humanoid = Humanoid.Health > 0
					end

					if Humanoid then
						table.insert(t7, {
							model = child,
							distance = Magnitude
						})
					end
				end
			end

			if p13 <= #t7 then
				break
			end
		end
	end

	if t1.value31.KillAura.TargetPlayers then
		for _, player_ in ipairs(t1.value1:GetPlayers()) do
			local v92

			if player_ == t1.value2 then
				v92 = false
			else
				v92 = player_.Character
			end

			if v92 then
				local HumanoidRootPart = player_.Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = player_.Character:FindFirstChildOfClass("Humanoid")

				if HumanoidRootPart then
					if Humanoid then
						Humanoid = Humanoid.Health > 0
					end
				else
					Humanoid = HumanoidRootPart
				end

				if Humanoid then
					local Magnitude = (Position - HumanoidRootPart.Position).Magnitude

					if Magnitude <= p12 then
						table.insert(t7, {
							model = player_.Character,
							distance = Magnitude
						})
					end
				end
			end

			if p13 <= #t7 then
				break
			end
		end
	end

	table.sort(t7, function(p14, p15)
		return p14.distance < p15.distance
	end)

	local t8 = {}

	for i, v in ipairs(t7) do
		if p13 < i then
			return t8
		end

		local model = v.model

		table.insert(t8, model)
	end

	return t8
end
function t1.value58()
	if not t1.value12 then
		return
	end

	local function v100()
		t1.value12:FireServer()
	end

	pcall(v100)
end

t1.value59 = nil

function t1.value60()
	if not t1.value31.AutoHaki.Enabled then
		return
	end

	if tick() - t1.value32 < t1.value31.AutoHaki.Interval then
		return
	end

	local UseArmament = t1.value31.AutoHaki.UseArmament

	if UseArmament then
		UseArmament = t1.value13
	end

	if UseArmament then
		local function v102()
			t1.value13:FireServer()
		end

		pcall(v102)
	end

	local UseObservation = t1.value31.AutoHaki.UseObservation

	if UseObservation then
		UseObservation = t1.value14
	end

	if UseObservation then
		local function v104()
			t1.value14:FireServer()
		end

		pcall(v104)
	end

	local UseConqueror = t1.value31.AutoHaki.UseConqueror

	if UseConqueror then
		UseConqueror = t1.value15
	end

	if not UseConqueror then
		return
	end

	local function v106()
		t1.value15:FireServer()
	end

	pcall(v106)
end
function t1.value53(p16, p17)
	local t9 = {}

	if not t1.value25 then
		return t9
	end

	local v108 = string.lower(p16)
	local v109 = ({
		slimewarrior = {
			"slime1",
			"slime2",
			"slime3",
			"slime4",
			"slime5",
			"slime"
		},
		thief = {
			"thief1",
			"thief2",
			"thief3",
			"thief4",
			"thief5"
		},
		monkey = {
			"monkey1",
			"monkey2",
			"monkey3",
			"monkey4",
			"monkey5"
		},
		desertbandit = {
			"desertbandit1",
			"desertbandit2",
			"desertbandit3",
			"desertbandit4",
			"desertbandit5"
		},
		frostrogue = {
			"frostrogue1",
			"frostrogue2",
			"frostrogue3",
			"frostrogue4",
			"frostrogue5"
		},
		sorcerer = {
			"sorcerer1",
			"sorcerer2",
			"sorcerer3",
			"sorcerer4",
			"sorcerer5"
		},
		hollow = {
			"hollow1",
			"hollow2",
			"hollow3",
			"hollow4",
			"hollow5"
		},
		strongsorcerer = {
			"strongsorcerer1",
			"strongsorcerer2",
			"strongsorcerer3",
			"strongsorcerer4",
			"strongsorcerer5"
		},
		curse = {
			"curse1",
			"curse2",
			"curse3",
			"curse4",
			"curse5"
		},
		academyteacher = {
			"academyteacher1",
			"academyteacher2",
			"academyteacher3",
			"academyteacher4",
			"academyteacher5"
		}
	})[v108] or { v108 }
	local ipairs_ = ipairs
	local value25 = t1.value25

	for _, child in ipairs_(value25.GetChildren(value25)) do
		local Humanoid = child:FindFirstChild("Humanoid")
		local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

		if Humanoid then
			if HumanoidRootPart then
				HumanoidRootPart = Humanoid.Health > 0
			end
		else
			HumanoidRootPart = Humanoid
		end

		if HumanoidRootPart then
			local v116 = string.lower(child.Name)
			local v117 = string.find(v116, "boss")
			local v118, v119, v120 = ipairs(v109)
			local v121 = false

			while true do
				local v122

				v120, v122 = v118(v119, v120)

				if not v120 then
					break
				end

				if string.find(v116, v122) then
					v121 = true

					break
				end
			end

			local v123

			if p17 then
				v123 = v121 and v117
			else
				v123 = p17
			end

			if v123 then
				table.insert(t9, child)
			else
				local v124 = not p17

				if v124 then
					if v121 then
						v121 = not v117
					end
				else
					v121 = v124
				end

				if v121 then
					table.insert(t9, child)
				end
			end
		end
	end

	return t9
end
function t1.value61(p18, p19)
	local v125 = t1.value53(p18, p19)

	if #v125 == 0 then
		return nil
	else
		local v126 = t1.value51()

		if v126 then
			local huge = math.huge
			local v128 = nil

			for _, v in ipairs(v125) do
				local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart then
					local Magnitude = (v126.Position - HumanoidRootPart.Position).Magnitude

					if Magnitude < huge then
						v128 = v
						huge = Magnitude
					end
				end
			end

			return v128
		else
			return v125[1]
		end
	end
end
function t1.value62()
	if t1.value25 then
		local v133 = t1.value51()

		if v133 then
			local ipairs_ = ipairs
			local value25 = t1.value25
			local huge = math.huge
			local v137 = nil

			for _, child in ipairs_(value25.GetChildren(value25)) do
				local Humanoid = child:FindFirstChild("Humanoid")
				local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if Humanoid then
					if HumanoidRootPart then
						Humanoid = Humanoid.Health > 0
					else
						Humanoid = HumanoidRootPart
					end
				end

				if Humanoid then
					local Magnitude = (v133.Position - HumanoidRootPart.Position).Magnitude

					if Magnitude < huge then
						v137 = child
						huge = Magnitude
					end
				end
			end

			return v137, huge
		else
			return nil, 0
		end
	else
		return nil, 0
	end
end
function t1.value63()
	local v143 = t1.value51()

	if not v143 then
		return nil, 0
	end

	local v144 = nil
	local huge = math.huge

	if not t1.value25 then
		return v144, huge
	end

	local ipairs_ = ipairs
	local value25 = t1.value25

	for _, child in ipairs_(value25.GetChildren(value25)) do
		local v150 = string.lower(child.Name)
		local v151 = not string.find(v150, "boss")

		if v151 then
			v151 = not string.find(v150, "dummy")
		end

		if v151 then
			local Humanoid = child:FindFirstChild("Humanoid")
			local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

			if Humanoid then
				if HumanoidRootPart then
					Humanoid = Humanoid.Health > 0
				else
					Humanoid = HumanoidRootPart
				end
			end

			if Humanoid then
				local Magnitude = (v143.Position - HumanoidRootPart.Position).Magnitude

				if Magnitude < huge then
					v144 = child
					huge = Magnitude
				end
			end
		end
	end

	return v144, huge
end
function t1.value64(p20)
	if p20 then
		local Humanoid = p20:FindFirstChild("Humanoid")

		return not Humanoid and true or Humanoid.Health <= 0
	else
		return true
	end
end
function t1.value65(p21)
	if t1.value17 then
		t1.value17:FireServer(unpack({ p21 }))

		return true
	else
		return false
	end
end

t1.value49 = 0

function t1.value66()
	if t1.value31.AutoFarm.SelectedQuest then
		local now = tick()

		if now - t1.value49 < 5 then
			return false
		else
			local v157, v158, v159 = ipairs(t1.value27)
			local v160 = nil

			while true do
				v159, v165 = v157(v158, v159)

				if not v159 then
					break
				end

				if v165.id == t1.value31.AutoFarm.SelectedQuest then
					if v165 then
						t1.value49 = now

						return t1.value65(v165.questNPC)
					else
						return false
					end
				end
			end

			local v161 = v160

			if v161 then
				t1.value49 = now

				return t1.value65(v161.questNPC)
			else
				return false
			end
		end
	else
		return false
	end
end
function t1.value67()
	if not t1.value31.AutoFarm.SelectedQuest then
		return nil
	end

	local v162, v163, v164 = ipairs(t1.value27)
	local v166 = nil

	while true do
		local v167

		v164, v167 = v162(v163, v164)

		if not v164 then
			v167 = v166

			break
		end

		if v167.id == t1.value31.AutoFarm.SelectedQuest then
			break
		end
	end

	if not v170 then
		return nil
	end

	local v168 = t1.value51()
	local island

	if v168 then
		island = v170.island
	else
		island = v168
	end

	if island then
		local v169 = t1.value30[v170.island]

		if v169 and (v168.Position - v169.Center).Magnitude > 500 then
			v168.CFrame = CFrame.new(v169.Center + Vector3.new(0, 10, 0))
		end
	end

	local isBoss = v170.isBoss or false
	local v171 = t1.value61(v170.npcType, isBoss)

	if not v171 then
		return t1.value31.AutoFarm.currentTarget
	end

	t1.value31.AutoFarm.currentTarget = v171

	return t1.value31.AutoFarm.currentTarget
end

t1.value68 = 0

function t1.value69()
	local ok, result = pcall(function()
		if t1.value20 then
			local response = t1.value20:InvokeServer()

			return response and response.Level or 1
		else
			return 1
		end
	end)

	return ok and result and result or 1
end
function t1.value70(p22)
	local v175, v176, v177 = ipairs(t1.value27)
	local huge = math.huge
	local v179 = nil

	while true do
		local v180

		v177, v180 = v175(v176, v177)

		if not v177 then
			break
		end

		local v181 = p22 - v180.recommendedLevel
		local v182

		if v181 >= 0 then
			v182 = v181 < huge
		else
			v182 = false
		end

		if v182 then
			t1.value31.FullAutoFarm.currentQuestIndex = v177
		else
			v180 = v179
			v181 = huge
		end

		v179 = v180
		huge = v181
	end

	if v179 then
		return v179
	end

	v179 = t1.value27[1]
	t1.value31.FullAutoFarm.currentQuestIndex = 1

	return v179
end

t1.value71 = nil

function t1.value72(p23)
	local v183 = t1.value30[p23]

	if v183 then
		local v184 = t1.value51()

		if v184 then
			local v185 = v183.Center + Vector3.new(0, 10, 0)

			v184.CFrame = CFrame.new(v185)

			return true
		else
			return false
		end
	else
		return false
	end
end
function t1.value73(p24)
	if t1.value25 then
		local ipairs_ = ipairs
		local value25 = t1.value25

		for _, child in ipairs_(value25.GetChildren(value25)) do
			if child.Name == p24 and true or child.Name:find(p24:gsub("Boss", "")) then
				local Humanoid = child:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid = Humanoid.Health > 0
				end

				if Humanoid then
					return child
				end
			end
		end

		return nil
	else
		return nil
	end
end
function t1.value74(p25, p26)
	local now = tick()

	if now - t1.value31.AutoSummonBoss.lastSpawnAttempt < t1.value31.AutoSummonBoss.spawnCooldown then
		return false
	else
		t1.value31.AutoSummonBoss.lastSpawnAttempt = now

		if t1.value24 then
			local v192 = t1.value29[p25]

			if v192 then
				if v192.hasDifficulty and p26 then
					t1.value24:FireServer(p25, p26)
				else
					t1.value24:FireServer(p25)
				end

				Library:Notify("Spawning " .. v192.displayName .. "...", 3)

				return true
			else
				return false
			end
		else
			return false
		end
	end
end

t1.value71 = nil
t1.value59 = nil

function t1.value75(p27, p28)
	if not p27 then
		return false
	end

	local v193 = t1.value51()
	local Humanoid = t1.value50()

	if Humanoid then
		Humanoid = t1.value50():FindFirstChildOfClass("Humanoid")
	end

	local v195 = not v193
	local v196 = p27.FindFirstChild(p27, "HumanoidRootPart")

	if v195 or not v196 then
		return false
	end

	local AttackHeight = p28 or t1.value31.AutoSummonBoss.AttackHeight

	if Humanoid then
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
	end

	local v198 = v196.Position + Vector3.new(0, AttackHeight, 0)

	v193.CFrame = CFrame.new(v198, v196.Position)
	v193.Velocity = Vector3.new(0, 0, 0)
	v193.RotVelocity = Vector3.new(0, 0, 0)

	if not (t1.value71 and t1.value71.Parent) then
		t1.value71 = Instance.new("BodyVelocity")
		t1.value71.Name = "SummonBossBodyVel"
		t1.value71.Velocity = Vector3.new(0, 0, 0)
		t1.value71.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		t1.value71.Parent = v193
	end

	if t1.value59 and t1.value59.Parent then
		t1.value59.CFrame = CFrame.new(v198, v196.Position)

		return true
	end

	t1.value59 = Instance.new("BodyGyro")
	t1.value59.Name = "SummonBossBodyGyro"
	t1.value59.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	t1.value59.P = 9000000000
	t1.value59.Parent = v193
	t1.value59.CFrame = CFrame.new(v198, v196.Position)

	return true
end
function t1.value76()
	if not t1.value31.AutoSummonBoss.Enabled then
		return
	end

	local AutoSummonBoss = t1.value31.AutoSummonBoss
	local SelectedBoss = AutoSummonBoss.SelectedBoss
	local v201 = t1.value29[SelectedBoss]

	if not v201 then
		return
	end

	if AutoSummonBoss.AutoDupeBossKey then
		local now = tick()

		if now - AutoSummonBoss.lastDupeTime >= AutoSummonBoss.DupeBossKeyDelay then
			AutoSummonBoss.lastDupeTime = now

			local Remotes4 = t1.value7:FindFirstChild("Remotes")
			local PurchaseMerchantItem = Remotes4 and Remotes4:FindFirstChild("MerchantRemotes"):FindFirstChild("PurchaseMerchantItem")

			if PurchaseMerchantItem then
				pcall(function()
					PurchaseMerchantItem:InvokeServer("Boss Key", (0 / 0), AutoSummonBoss.DupeBossKeyCurrency)
				end)
			end
		end
	end

	if AutoSummonBoss.AutoEnableKillAura then
		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = AutoSummonBoss.KillAuraRange
		t1.value31.KillAura.TargetNPCs = true
	end

	if AutoSummonBoss.AutoEnableHaki then
		t1.value31.AutoHaki.Enabled = true
	end

	local v205 = t1.value30[v201.island]
	local v206 = t1.value51()

	if v205 and v206 and (v206.Position - v205.Center).Magnitude > 500 then
		v206.CFrame = CFrame.new(v205.Center + Vector3.new(0, 10, 0))
	end

	local v207 = t1.value73(SelectedBoss)

	if v207 then
		t1.value75(v207, AutoSummonBoss.AttackHeight)

		local Humanoid = v207:FindFirstChildOfClass("Humanoid")

		if Humanoid then
		elseif Humanoid then
			AutoSummonBoss.bossKillCount = AutoSummonBoss.bossKillCount + 1

			return
		else
			return
		end

		Humanoid = Humanoid.Health <= 0

		if Humanoid then
			AutoSummonBoss.bossKillCount = AutoSummonBoss.bossKillCount + 1

			return
		else
			return
		end
	else
		local Difficulty = v201.hasDifficulty and AutoSummonBoss.Difficulty or nil

		t1.value74(SelectedBoss, Difficulty)

		if not v206 then
			return
		end

		for _, child in ipairs(v206.GetChildren(v206)) do
			if child:IsA("BodyVelocity") or child:IsA("BodyGyro") then
				child:Destroy()
			end
		end
	end
end
function t1.value77(p29)
	local ipairs_ = ipairs
	local value10 = t1.value10

	for _, descendant in ipairs_(value10.GetDescendants(value10)) do
		if descendant.Name == p29 then
			local ProximityPrompt = descendant:FindFirstChildOfClass("ProximityPrompt")

			if ProximityPrompt then
				return descendant, ProximityPrompt
			end
		end
	end

	return nil, nil
end
function t1.value78()
	local QuestAccept = t1.value16:FindFirstChild("QuestAccept")

	if not QuestAccept then
		return false
	end

	if not t1.value26 then
		return false
	end

	local ipairs_ = ipairs
	local value26 = t1.value26

	for _, child in ipairs_(value26.GetChildren(value26)) do
		if child.Name == t1.value31.AutoDemoniteEvent.QuestNPC then
			QuestAccept:FireServer(t1.value31.AutoDemoniteEvent.QuestlineId)

			return true
		end
	end

	return false
end
function t1.value79()
	if not t1.value31.AutoDemoniteEvent.Enabled then
		return
	end

	local AutoDemoniteEvent = t1.value31.AutoDemoniteEvent
	local v223 = t1.value51()

	if not v223 then
		return
	end

	for _, pieceName in ipairs(AutoDemoniteEvent.PieceNames) do
		if not AutoDemoniteEvent.collectedPieces[pieceName] then
			local v226, v227 = t1.value77(pieceName)

			if v226 then
				local Position = v226:GetPivot().Position

				v223.CFrame = CFrame.new(Position + Vector3.new(0, 5, 0))

				if not v227 then
					return
				end

				fireproximityprompt(v227)
				AutoDemoniteEvent.collectedPieces[pieceName] = true
				Library:Notify("Collected " .. pieceName .. "!", 3)

				return
			end
		end
	end

	if not (#AutoDemoniteEvent.collectedPieces >= #AutoDemoniteEvent.PieceNames) then
		return
	end

	Library:Notify("Demonite Event Complete!", 5)
	t1.value31.AutoDemoniteEvent.Enabled = false
end
function t1.value80()
	local ipairs_ = ipairs
	local value10 = t1.value10

	for _, descendant in ipairs_(value10.GetDescendants(value10)) do
		if descendant.Name == t1.value31.AutoSlimeEvent.PieceName then
			local ProximityPrompt = descendant:FindFirstChildOfClass("ProximityPrompt")

			if ProximityPrompt then
				return descendant, ProximityPrompt
			end
		end
	end

	return nil, nil
end
function t1.value81()
	local QuestAccept = t1.value16:FindFirstChild("QuestAccept")

	if not QuestAccept then
		return false
	end

	if not t1.value26 then
		return false
	end

	local ipairs_ = ipairs
	local value26 = t1.value26

	for _, child in ipairs_(value26.GetChildren(value26)) do
		if child.Name == t1.value31.AutoSlimeEvent.QuestNPC then
			QuestAccept:FireServer(t1.value31.AutoSlimeEvent.QuestlineId)

			return true
		end
	end

	return false
end
function t1.value82()
	local QuestAccept = t1.value16:FindFirstChild("QuestAccept")

	if not QuestAccept then
		return false
	end

	if not t1.value26 then
		return false
	end

	local ipairs_ = ipairs
	local value26 = t1.value26

	for _, child in ipairs_(value26.GetChildren(value26)) do
		if child.Name == t1.value31.AutoDungeonDiscovery.QuestNPC then
			QuestAccept:FireServer(t1.value31.AutoDungeonDiscovery.QuestlineId)

			return true
		end
	end

	return false
end
function t1.value83()
	if not t1.value31.AutoSlimeEvent.Enabled then
		return
	end

	local AutoSlimeEvent = t1.value31.AutoSlimeEvent
	local v245 = t1.value51()

	if not v245 then
		return
	end

	if AutoSlimeEvent.currentPieceIndex > 7 then
		if not t1.value26 then
			return
		end

		local ipairs_ = ipairs
		local value26 = t1.value26

		for _, child in ipairs_(value26.GetChildren(value26)) do
			if child.Name == AutoSlimeEvent.QuestNPC then
				local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart then
					v245.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 5, 0))

					local ProximityPrompt = child:FindFirstChildOfClass("ProximityPrompt")

					if ProximityPrompt then
						fireproximityprompt(ProximityPrompt)
						Library:Notify("Slime Event Complete!", 5)
						t1.value31.AutoSlimeEvent.Enabled = false

						return
					end
				end
			end
		end
	else
		local v252, v253 = t1.value80()

		if not v252 then
			return
		end

		local Position = v252:GetPivot().Position

		v245.CFrame = CFrame.new(Position + Vector3.new(0, 5, 0))

		if not v253 then
			return
		end

		fireproximityprompt(v253)
		AutoSlimeEvent.currentPieceIndex = AutoSlimeEvent.currentPieceIndex + 1
		Library:Notify("Collected Slime Piece " .. AutoSlimeEvent.currentPieceIndex - 1 .. "/7!", 3)
	end
end

t1.value84 = nil

function t1.value84(p30, p31)
	local v255 = p31 or 300

	for _, descendant in ipairs(t1.value10:GetDescendants()) do
		if descendant.Name == "DungeonPuzzlePiece" and true or descendant.Name:find("DungeonPiece") then
			local ProximityPrompt = descendant:FindFirstChildOfClass("ProximityPrompt")

			if not ProximityPrompt then
				for _, descendant2 in ipairs(descendant:GetDescendants()) do
					if descendant2:IsA("ProximityPrompt") then
						ProximityPrompt = descendant2

						break
					end
				end
			end

			if ProximityPrompt and (descendant:GetPivot().Position - p30).Magnitude <= v255 then
				return descendant, ProximityPrompt
			end
		end
	end

	return nil, nil
end
function t1.value85()
	if not t1.value31.AutoDungeonDiscovery.Enabled then
		return
	end

	local AutoDungeonDiscovery = t1.value31.AutoDungeonDiscovery
	local v262 = t1.value51()

	if not v262 then
		return
	end

	if t1.value69() < AutoDungeonDiscovery.MinLevel then
		return
	end

	local now = tick()

	if now - AutoDungeonDiscovery.lastSearchTime < AutoDungeonDiscovery.searchInterval then
		return
	end

	AutoDungeonDiscovery.lastSearchTime = now

	local currentStage = t1.value22.currentStage
	local progress = t1.value22.progress or 0
	local goal = t1.value22.goal or 6

	if (currentStage or 1) == 2 then
		local v267 = goal or 25

		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = 100

		if t1.value31.AutoSummonBoss then
			t1.value31.AutoSummonBoss.Enabled = true
		end

		if not (v267 <= progress and t1.value26) then
			return
		end

		local ipairs_ = ipairs
		local value26 = t1.value26

		for _, child in ipairs_(value26.GetChildren(value26)) do
			if child.Name == AutoDungeonDiscovery.QuestNPC then
				local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart then
					v262.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 3, 0))

					local ProximityPrompt = child:FindFirstChildOfClass("ProximityPrompt")

					if ProximityPrompt then
						fireproximityprompt(ProximityPrompt)
						Library:Notify("Dungeon Discovery Complete!", 5)
						t1.value31.AutoDungeonDiscovery.Enabled = false
						t1.value31.AutoSummonBoss.Enabled = false

						return
					end
				end
			end
		end

		return
	end

	if not (AutoDungeonDiscovery.currentPieceIndex > 6 and true or progress >= 6) then
		local v274 = AutoDungeonDiscovery.IslandOrder[AutoDungeonDiscovery.currentPieceIndex]

		if v274 then
			local v275 = t1.value30[v274]

			if v275 then
				if (v262.Position - v275.Center).Magnitude > 300 then
					v262.CFrame = CFrame.new(v275.Center + Vector3.new(0, 10, 0))

					return
				else
					local v276, v277 = t1.value84(v275.Center, 300)

					if v276 and v277 then
						local Position = v276:GetPivot().Position

						v262.CFrame = CFrame.new(Position + Vector3.new(0, 3, 0))

						if AutoDungeonDiscovery.attemptedIslands[v274] then
							AutoDungeonDiscovery.currentPieceIndex = AutoDungeonDiscovery.currentPieceIndex + 1
							AutoDungeonDiscovery.attemptedIslands[v274] = nil

							return
						else
							AutoDungeonDiscovery.attemptedIslands[v274] = true

							local progress2 = t1.value22.progress or 0

							for _ = 1, 5 do
								task.wait(0.2)

								local Parent

								if v276 then
									Parent = v276.Parent
								else
									Parent = v276
								end

								if Parent then
									fireproximityprompt(v277)
								end
							end

							local n1 = 0
							local n2 = 5

							while n1 < n2 do
								task.wait(0.3)
								n1 = n1 + 0.3

								local progress3 = t1.value22.progress or 0

								if progress2 < progress3 then
									AutoDungeonDiscovery.attemptedIslands[v274] = nil
									AutoDungeonDiscovery.currentPieceIndex = progress3 + 1
									Library:Notify("Collected Dungeon Piece " .. progress3 .. "/6!", 3)

									return
								end

								if not (v276 and v276.Parent) then
									AutoDungeonDiscovery.attemptedIslands[v274] = nil
									AutoDungeonDiscovery.currentPieceIndex = AutoDungeonDiscovery.currentPieceIndex + 1
									Library:Notify("Collected Dungeon Piece " .. AutoDungeonDiscovery.currentPieceIndex - 1 .. "/6!", 3)

									return
								end
							end

							AutoDungeonDiscovery.currentPieceIndex = AutoDungeonDiscovery.currentPieceIndex + 1

							return
						end
					else
						AutoDungeonDiscovery.currentPieceIndex = AutoDungeonDiscovery.currentPieceIndex + 1

						return
					end
				end
			else
				AutoDungeonDiscovery.currentPieceIndex = AutoDungeonDiscovery.currentPieceIndex + 1

				return
			end
		else
			return
		end
	end

	if not t1.value26 then
		return
	end

	local ipairs_ = ipairs
	local value26 = t1.value26

	for _, child in ipairs_(value26.GetChildren(value26)) do
		if child.Name == AutoDungeonDiscovery.QuestNPC then
			local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				v262.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 3, 0))

				local ProximityPrompt = child:FindFirstChildOfClass("ProximityPrompt")

				if ProximityPrompt then
					fireproximityprompt(ProximityPrompt)
					Library:Notify("Stage 1 Complete! Starting Stage 2...", 3)

					return
				end
			end
		end
	end
end

t1.value86 = {
	Items = {},
	Melee = {},
	Sword = {},
	Power = {},
	Accessories = {},
	Runes = {},
	Auras = {}
}

local UpdateInventory = Remotes2:FindFirstChild("UpdateInventory")

if UpdateInventory then
	UpdateInventory.OnClientEvent:Connect(function(p32, p33)
		local v292

		if p32 then
			v292 = t1.value86[p32]
		else
			v292 = p32
		end

		if not v292 then
			return
		end

		t1.value86[p32] = p33 or {}
	end)
end

t1.value87 = nil
task.spawn(function()
	task.wait(1)

	if not t1.value23 then
		return
	end

	t1.value23:FireServer()
end)
t1.value88 = nil

function t1.value88(p34)
	local n3 = 0

	for _, item in ipairs(t1.value86.Items) do
		local v296

		if type(item) == "string" then
			v296 = item == p34
		else
			v296 = false
		end

		if v296 then
			n3 = n3 + 1
		elseif type(item) == "table" and item.name == p34 then
			n3 = n3 + (item.quantity or 1)
		end
	end

	local v297, v298, v299 = pairs(t1.value86)

	while true do
		local v300

		v299, v300 = v297(v298, v299)

		if not v299 then
			break
		end

		if v299 ~= "Items" then
			for _, v in ipairs(v300) do
				local v303

				if type(v) == "string" then
					v303 = v == p34
				else
					v303 = false
				end

				if v303 then
					n3 = n3 + 1
				elseif type(v) == "table" and v.name == p34 then
					n3 = n3 + (v.quantity or 1)
				end
			end
		end
	end

	if n3 > 0 then
		return n3
	end

	if not player then
		return 0
	end

	local Backpack = player:FindFirstChild("Backpack")

	if Backpack then
		local GetChildren = Backpack.GetChildren

		for _, v in ipairs(GetChildren(Backpack)) do
			if v.Name == p34 then
				n3 = n3 + 1
			end
		end
	end

	local v308 = t1.value50()

	if not v308 then
		return n3
	end

	for _, child in ipairs(v308.GetChildren(v308)) do
		local isTool = child:IsA("Tool")

		if isTool then
			isTool = child.Name == p34
		end

		if isTool then
			n3 = n3 + 1
		end
	end

	return n3
end
function t1.value89()
	if t1.value25 then
		local ipairs_ = ipairs
		local value25 = t1.value25

		for _, child in ipairs_(value25.GetChildren(value25)) do
			if child.Name == "JinwooBoss" and true or child.Name:find("Jinwoo") then
				local Humanoid = child:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid = Humanoid.Health > 0
				end

				if Humanoid then
					return child
				end
			end
		end

		return nil
	else
		return nil
	end
end

t1.value90 = nil

local value7 = t1.value7
local v318 = value7.FindFirstChild(value7, "SafeZoneModule")

t1.value91 = nil
t1.value92 = v318

function t1.value93(p35)
	local Character, HumanoidRootPart, Position, t10, v323, v324, v325, v326

	if not t1.value92 then
		Character = p35.Character

		if Character then
			HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				Position = HumanoidRootPart.Position
				t10 = {
					{
						name = "StarterIsland",
						center = Vector3.new(108, 71, -234),
						size = Vector3.new(455, 280, 350)
					},
					{
						name = "BossIsland",
						center = Vector3.new(812, 23, -1133),
						size = Vector3.new(380, 220, 400)
					},
					{
						name = "SailorIsland",
						center = Vector3.new(221, 68, 797),
						size = Vector3.new(494, 192, 562)
					},
					{
						name = "DungeonIsland",
						center = Vector3.new(1374, 20, -907),
						size = Vector3.new(300, 100, 250)
					}
				}

				for _, v in ipairs(t10) do
					v323 = v.size / 2
					v324 = v.center - v323
					v325 = v.center + v323
					v326 = Position.X >= v324.X

					if v326 then
						v326 = Position.X <= v325.X

						if v326 then
							v326 = Position.Y >= v324.Y

							if v326 then
								if Position.Y <= v325.Y and Position.Z >= v324.Z then
									v326 = Position.Z <= v325.Z
								else
									v326 = false
								end
							end
						end
					end

					if v326 then
						return true
					end
				end

				return false
			else
				return true
			end
		else
			return true
		end
	end

	local function v329()
		local value92 = require(t1.value92)
		local IsPlayerSafe

		if value92 then
			IsPlayerSafe = value92.IsPlayerSafe
		else
			IsPlayerSafe = value92
		end

		if IsPlayerSafe then
			return value92.IsPlayerSafe(p35)
		else
			return false
		end
	end

	local t11 = { pcall(v329) }
	local v333 = t11[2]

	if t11[1] then
		return v333
	else
		Character = p35.Character

		if Character then
			HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				Position = HumanoidRootPart.Position
				t10 = {
					{
						name = "StarterIsland",
						center = Vector3.new(108, 71, -234),
						size = Vector3.new(455, 280, 350)
					},
					{
						name = "BossIsland",
						center = Vector3.new(812, 23, -1133),
						size = Vector3.new(380, 220, 400)
					},
					{
						name = "SailorIsland",
						center = Vector3.new(221, 68, 797),
						size = Vector3.new(494, 192, 562)
					},
					{
						name = "DungeonIsland",
						center = Vector3.new(1374, 20, -907),
						size = Vector3.new(300, 100, 250)
					}
				}

				for _, v in ipairs(t10) do
					v323 = v.size / 2
					v324 = v.center - v323
					v325 = v.center + v323
					v326 = Position.X >= v324.X

					if v326 then
						v326 = Position.X <= v325.X

						if v326 then
							v326 = Position.Y >= v324.Y

							if v326 then
								if Position.Y <= v325.Y and Position.Z >= v324.Z then
									v326 = Position.Z <= v325.Z
								else
									v326 = false
								end
							end
						end
					end

					if v326 then
						return true
					end
				end

				return false
			else
				return true
			end
		else
			return true
		end
	end
end
function t1.value94()
	if t1.value17 then
		local t12 = { t1.value31.AutoJinwooQuest.QuestNPC }

		t1.value17:FireServer(unpack_({ unpack(t12) }))
		Library:Notify("Jinwoo Quest Started!", 3)

		return true
	else
		return false
	end
end
function t1.value95(p36)
	t1.value25 = t1.value10:FindFirstChild("NPCs")

	if not t1.value25 then
		return nil, nil, nil
	end

	local ipairs_ = ipairs
	local value25 = t1.value25

	local function v339(p37)
		if not p36 or #p36 == 0 then
			return true
		else
			for _, v in ipairs(p36) do
				if v == "All" and true or v == p37 then
					return true
				end
			end

			return false
		end
	end

	for _, child in ipairs_(value25.GetChildren(value25)) do
		local Name = child.Name
		local Humanoid = child:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

		for k, v in pairs(t1.value28) do
			local displayName = v.displayName or ""
			local v350

			if Name == k then
				v350 = true
			elseif displayName == "" then
				v350 = false
			else
				v350 = string.find(Name, displayName)
			end

			if v350 then
				local v351

				if Humanoid then
					if Humanoid.Health > 0 then
						v351 = HumanoidRootPart
					else
						v351 = false
					end
				else
					v351 = Humanoid
				end

				if v351 and v339(k) then
					return child, k, v
				end
			end
		end
	end

	return nil, nil, nil
end

t1.value96 = {}
t1.value97 = nil
t1.value98 = nil
t1.value99 = nil
t1.value91 = nil
t1.value100 = nil
t1.value90 = nil
t1.value87 = nil

function t1.value101(p38, p39)
	if not (p38 and p39) then
		return false
	end

	local v352 = t1.value51()
	local Humanoid = t1.value50()

	if Humanoid then
		Humanoid = t1.value50():FindFirstChildOfClass("Humanoid")
	end

	local HumanoidRootPart = p38:FindFirstChild("HumanoidRootPart")
	local v355 = not v352
	local Humanoid2 = p38:FindFirstChildOfClass("Humanoid")

	if v355 or not HumanoidRootPart then
		return false
	end

	if Humanoid2 then
		Humanoid2 = Humanoid2.Health <= 0
	end

	if Humanoid2 then
		return false
	end

	local AttackHeight = t1.value31.AutoFarmTimedBoss.AttackHeight
	local position = HumanoidRootPart.Position + Vector3.new(0, AttackHeight, 0)

	v352.CFrame = CFrame.new(position, HumanoidRootPart.Position)

	if Humanoid then
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
	end

	v352.Anchored = true
	v352.Anchored = false
	t1.value31.KillAura.Enabled = true
	t1.value31.KillAura.Range = t1.value31.AutoFarmTimedBoss.KillAuraRange
	t1.value31.AutoHaki.Enabled = true

	if not (t1.value87 and t1.value87.Parent) then
		t1.value87 = Instance.new("Attachment")
		t1.value87.Name = "TimedBossAttachment"
		t1.value87.Parent = v352
	end

	if not (t1.value91 and t1.value91.Parent) then
		t1.value91 = Instance.new("AlignPosition")
		t1.value91.Mode = Enum.PositionAlignmentMode.OneAttachment
		t1.value91.Attachment0 = t1.value87
		t1.value91.RigidityEnabled = true
		t1.value91.MaxForce = math.huge
		t1.value91.Parent = v352
	end

	if t1.value90 and t1.value90.Parent then
		t1.value91.Position = position
		t1.value90.CFrame = CFrame.new(position, HumanoidRootPart.Position)

		return true
	end

	t1.value90 = Instance.new("AlignOrientation")
	t1.value90.Mode = Enum.OrientationAlignmentMode.OneAttachment
	t1.value90.Attachment0 = t1.value87
	t1.value90.RigidityEnabled = true
	t1.value90.MaxTorque = math.huge
	t1.value90.Parent = v352
	t1.value91.Position = position
	t1.value90.CFrame = CFrame.new(position, HumanoidRootPart.Position)

	return true
end
function t1.value102()
	if t1.value91 then
		t1.value91:Destroy()
		t1.value91 = nil
	end

	if t1.value90 then
		t1.value90:Destroy()
		t1.value90 = nil
	end

	if t1.value87 then
		t1.value87:Destroy()
		t1.value87 = nil
	end

	if t1.value97 then
		t1.value97:Destroy()
	end

	if not t1.value99 then
		return
	end

	t1.value99:Destroy()
end
function t1.value103()
	if not t1.value31.AutoJinwooQuest.Enabled then
		return
	end

	t1.value48()

	local AutoJinwooQuest = t1.value31.AutoJinwooQuest
	local now = tick()

	if now - AutoJinwooQuest.lastProgressCheck < 0.5 then
		return
	end

	AutoJinwooQuest.lastProgressCheck = now

	local v361 = t1.value51()

	if not v361 then
		return
	end

	if AutoJinwooQuest.currentStage == 0 then
		AutoJinwooQuest.currentStage = 1
	end

	if not AutoJinwooQuest.questAccepted then
		t1.value94()
		AutoJinwooQuest.questAccepted = true

		return
	end

	if AutoJinwooQuest.currentStage == 1 then
		local v362 = t1.value95(nil)

		if not v362 then
			AutoJinwooQuest.isAggro = false

			return
		end

		local HumanoidRootPart = v362:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local v366 = HumanoidRootPart.Position + Vector3.new(0, 3, 0)

		v361.CFrame = CFrame.new(v366, HumanoidRootPart.Position)
		v361.Velocity = Vector3.new(0, 0, 0)
		v361.RotVelocity = Vector3.new(0, 0, 0)

		local JinwooStage1BodyVel = v361:FindFirstChild("JinwooStage1BodyVel")
		local JinwooStage1BodyGyro = v361:FindFirstChild("JinwooStage1BodyGyro")

		if not JinwooStage1BodyVel then
			local BodyVelocity = Instance.new("BodyVelocity")

			BodyVelocity.Name = "JinwooStage1BodyVel"
			BodyVelocity.Velocity = Vector3.new(0, 0, 0)
			BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			BodyVelocity.Parent = v361
		end

		if JinwooStage1BodyGyro then
			JinwooStage1BodyGyro.CFrame = CFrame.new(v366, HumanoidRootPart.Position)

			if AutoJinwooQuest.isAggro then
				if now - AutoJinwooQuest.aggroTimer < 2 then
					t1.value31.KillAura.Enabled = true

					return
				else
					t1.value31.KillAura.Enabled = false

					return
				end
			else
				t1.value31.KillAura.Enabled = true
				t1.value31.KillAura.Range = 30
				t1.value31.AutoHaki.Enabled = true
				AutoJinwooQuest.isAggro = true
				AutoJinwooQuest.aggroTimer = now

				return
			end
		end

		JinwooStage1BodyGyro = Instance.new("BodyGyro")
		JinwooStage1BodyGyro.Name = "JinwooStage1BodyGyro"
		JinwooStage1BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		JinwooStage1BodyGyro.P = 9000000000
		JinwooStage1BodyGyro.Parent = v361
		JinwooStage1BodyGyro.CFrame = CFrame.new(v366, HumanoidRootPart.Position)

		if AutoJinwooQuest.isAggro then
			if now - AutoJinwooQuest.aggroTimer < 2 then
				t1.value31.KillAura.Enabled = true

				return
			else
				t1.value31.KillAura.Enabled = false

				return
			end
		else
			t1.value31.KillAura.Enabled = true
			t1.value31.KillAura.Range = 30
			t1.value31.AutoHaki.Enabled = true
			AutoJinwooQuest.isAggro = true
			AutoJinwooQuest.aggroTimer = now

			return
		end
	end

	if AutoJinwooQuest.currentStage == 2 then
		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = 300
		t1.value31.AutoHaki.Enabled = true

		local v370 = t1.value63()

		if v370 then
			local HumanoidRootPart = v370:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				return
			end

			local v373 = HumanoidRootPart.Position + Vector3.new(0, 15, 0)

			v361.CFrame = CFrame.new(v373, HumanoidRootPart.Position)
			v361.Velocity = Vector3.new(0, 0, 0)
			v361.RotVelocity = Vector3.new(0, 0, 0)

			local JinwooStage2BodyVel = v361:FindFirstChild("JinwooStage2BodyVel")
			local JinwooStage2BodyGyro = v361:FindFirstChild("JinwooStage2BodyGyro")

			if not JinwooStage2BodyVel then
				local BodyVelocity = Instance.new("BodyVelocity")

				BodyVelocity.Name = "JinwooStage2BodyVel"
				BodyVelocity.Velocity = Vector3.new(0, 0, 0)
				BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				BodyVelocity.Parent = v361
			end

			if JinwooStage2BodyGyro then
				JinwooStage2BodyGyro.CFrame = CFrame.new(v373, HumanoidRootPart.Position)

				return
			end

			JinwooStage2BodyGyro = Instance.new("BodyGyro")
			JinwooStage2BodyGyro.Name = "JinwooStage2BodyGyro"
			JinwooStage2BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			JinwooStage2BodyGyro.P = 9000000000
			JinwooStage2BodyGyro.Parent = v361
			JinwooStage2BodyGyro.CFrame = CFrame.new(v373, HumanoidRootPart.Position)

			return
		else
			local v377 = t1.value62()
			local HumanoidRootPart = v377 and v377:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				return
			end

			local v379 = HumanoidRootPart.Position + Vector3.new(0, 15, 0)

			v361.CFrame = CFrame.new(v379, HumanoidRootPart.Position)
			v361.Velocity = Vector3.new(0, 0, 0)
			v361.RotVelocity = Vector3.new(0, 0, 0)

			local JinwooStage2BodyVel = v361:FindFirstChild("JinwooStage2BodyVel")
			local JinwooStage2BodyGyro = v361:FindFirstChild("JinwooStage2BodyGyro")

			if not JinwooStage2BodyVel then
				local BodyVelocity = Instance.new("BodyVelocity")

				BodyVelocity.Name = "JinwooStage2BodyVel"
				BodyVelocity.Velocity = Vector3.new(0, 0, 0)
				BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				BodyVelocity.Parent = v361
			end

			if JinwooStage2BodyGyro then
				JinwooStage2BodyGyro.CFrame = CFrame.new(v379, HumanoidRootPart.Position)

				return
			end

			JinwooStage2BodyGyro = Instance.new("BodyGyro")
			JinwooStage2BodyGyro.Name = "JinwooStage2BodyGyro"
			JinwooStage2BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			JinwooStage2BodyGyro.P = 9000000000
			JinwooStage2BodyGyro.Parent = v361
			JinwooStage2BodyGyro.CFrame = CFrame.new(v379, HumanoidRootPart.Position)

			return
		end
	end

	if AutoJinwooQuest.currentStage == 3 then
		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = 300
		t1.value31.AutoHaki.Enabled = true

		local v383 = t1.value62()
		local HumanoidRootPart = v383 and v383:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local v385 = HumanoidRootPart.Position + Vector3.new(0, 15, 0)

		v361.CFrame = CFrame.new(v385, HumanoidRootPart.Position)
		v361.Velocity = Vector3.new(0, 0, 0)
		v361.RotVelocity = Vector3.new(0, 0, 0)

		local JinwooStage3BodyVel = v361:FindFirstChild("JinwooStage3BodyVel")
		local JinwooStage3BodyGyro = v361:FindFirstChild("JinwooStage3BodyGyro")

		if not JinwooStage3BodyVel then
			local BodyVelocity = Instance.new("BodyVelocity")

			BodyVelocity.Name = "JinwooStage3BodyVel"
			BodyVelocity.Velocity = Vector3.new(0, 0, 0)
			BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			BodyVelocity.Parent = v361
		end

		if JinwooStage3BodyGyro then
			JinwooStage3BodyGyro.CFrame = CFrame.new(v385, HumanoidRootPart.Position)

			return
		end

		JinwooStage3BodyGyro = Instance.new("BodyGyro")
		JinwooStage3BodyGyro.Name = "JinwooStage3BodyGyro"
		JinwooStage3BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		JinwooStage3BodyGyro.P = 9000000000
		JinwooStage3BodyGyro.Parent = v361
		JinwooStage3BodyGyro.CFrame = CFrame.new(v385, HumanoidRootPart.Position)

		return
	end

	if AutoJinwooQuest.currentStage == 4 then
		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = 100
		t1.value31.KillAura.TargetPlayers = true
		t1.value31.AutoHaki.Enabled = true

		local v389, v390, v391 = ipairs(t1.value1:GetPlayers())
		local t13 = {}

		while true do
			local v393

			v391, v393 = v389(v390, v391)

			if not v391 then
				break
			end

			local v394

			if v393 == t1.value2 then
				v394 = false
			else
				v394 = v393.Character
			end

			if v394 then
				local HumanoidRootPart = v393.Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = v393.Character:FindFirstChildOfClass("Humanoid")

				if HumanoidRootPart then
					if Humanoid then
						if Humanoid.Health > 0 then
							Humanoid = not t1.value93(v393)
						else
							Humanoid = false
						end
					end
				else
					Humanoid = HumanoidRootPart
				end

				if Humanoid then
					table.insert(t13, {
						player = v393,
						hrp = HumanoidRootPart,
						dist = (v361.Position - HumanoidRootPart.Position).Magnitude
					})
				end
			end
		end

		table.sort(t13, function(p40, p41)
			return p40.dist < p41.dist
		end)

		if not (#t13 > 0) then
			local teleportIndex = AutoJinwooQuest.teleportIndex or 1
			local t14 = {
				0,
				60,
				120,
				180,
				240,
				300
			}
			local v399 = t14[teleportIndex % #t14 + 1]
			local v400 = math.rad(v399)
			local v401 = v361.Position + Vector3.new(math.cos(v400) * 500, 0, math.sin(v400) * 500)

			v361.CFrame = CFrame.new(v401)
			AutoJinwooQuest.teleportIndex = teleportIndex + 1

			return
		end

		local v402 = t13[1]
		local v403 = v402.hrp.Position + Vector3.new(0, 10, 0)

		v361.CFrame = CFrame.new(v403, v402.hrp.Position)
		v361.Velocity = Vector3.new(0, 0, 0)
		v361.RotVelocity = Vector3.new(0, 0, 0)

		local JinwooBodyVel = v361:FindFirstChild("JinwooBodyVel")
		local JinwooBodyGyro = v361:FindFirstChild("JinwooBodyGyro")

		if not JinwooBodyVel then
			local BodyVelocity = Instance.new("BodyVelocity")

			BodyVelocity.Name = "JinwooBodyVel"
			BodyVelocity.Velocity = Vector3.new(0, 0, 0)
			BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			BodyVelocity.Parent = v361
		end

		if JinwooBodyGyro then
			JinwooBodyGyro.CFrame = CFrame.new(v402.hrp.Position + Vector3.new(0, 10, 0), v402.hrp.Position)

			return
		end

		JinwooBodyGyro = Instance.new("BodyGyro")
		JinwooBodyGyro.Name = "JinwooBodyGyro"
		JinwooBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		JinwooBodyGyro.P = 9000000000
		JinwooBodyGyro.Parent = v361
		JinwooBodyGyro.CFrame = CFrame.new(v402.hrp.Position + Vector3.new(0, 10, 0), v402.hrp.Position)
	else
		if AutoJinwooQuest.currentStage ~= 5 then
			if not (AutoJinwooQuest.currentStage > 5) then
				return
			end

			Library:Notify("Jinwoo Quest Complete!", 5)
			t1.value31.AutoJinwooQuest.Enabled = false

			return
		end

		local v407 = t1.value89()

		if v407 then
			AutoJinwooQuest.noBossTime = 0
			t1.value101(v407, t1.value28.JinwooBoss)

			return
		end

		AutoJinwooQuest.noBossTime = AutoJinwooQuest.noBossTime + 0.5

		local ServerHopEnabled = AutoJinwooQuest.ServerHopEnabled

		if ServerHopEnabled then
			ServerHopEnabled = AutoJinwooQuest.noBossTime >= AutoJinwooQuest.ServerHopCooldown
		end

		if not ServerHopEnabled then
			return
		end

		local JobId = game.JobId
		local v410

		if JobId then
			v410 = not table.find(AutoJinwooQuest.visitedServers, JobId)
		else
			v410 = JobId
		end

		if v410 then
			local visitedServers = AutoJinwooQuest.visitedServers

			table.insert(visitedServers, JobId)
		end

		Library:Notify("JinwooBoss not found - Server hopping...", 3)

		local HttpService = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")

		local function v414()
			return HttpService:JSONDecode(unpack_({ game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100") }))
		end

		local ok, result = pcall(v414)
		local data = ok and result

		if data then
			data = result.data
		end

		if not data then
			AutoJinwooQuest.noBossTime = 0

			return
		end

		local v418, v419, v420 = ipairs(result.data)
		local t15 = {}

		while true do
			local v422

			v420, v422 = v418(v419, v420)

			if not v420 then
				break
			end

			local v423

			if v422.playing < v422.maxPlayers then
				v423 = v422.playing > 0
			else
				v423 = false
			end

			if v423 and not table.find(AutoJinwooQuest.visitedServers, v422.id) then
				table.insert(t15, v422)
			end
		end

		table.sort(t15, function(p42, p43)
			return p42.playing < p43.playing
		end)

		if not (#t15 > 0) then
			AutoJinwooQuest.noBossTime = 0

			return
		end

		local v424 = t15[1]
		local v425 = nil

		local function v426()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, v425.id)
		end

		v425 = v424
		pcall(v426)
		AutoJinwooQuest.noBossTime = 0
	end
end
function t1.value104()
	if not t1.value31.FullAutoFarm.Enabled then
		return
	end

	local now = tick()
	local v428 = t1.value69()

	if t1.value31.FullAutoFarm.AutoEnableHaki then
		t1.value31.AutoHaki.Enabled = true
		t1.value31.AutoHaki.UseArmament = true
		t1.value31.AutoHaki.UseObservation = true
	end

	if t1.value31.FullAutoFarm.AutoEnableKillAura then
		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = t1.value31.FullAutoFarm.KillAuraRange
		t1.value31.KillAura.TargetNPCs = true
	end

	t1.value31.AutoFarm.AutoEquipWeapon = true

	local v429 = t1.value31.FullAutoFarm.FarmBosses and not t1.value31.AutoFarmTimedBoss.Enabled

	if v429 then
		v429 = t1.value31.FullAutoFarm.BossPriorityLevel <= v428
	end

	if v429 then
		local v430, _, v432 = t1.value95(nil)

		if v430 then
			t1.value31.KillAura.Enabled = true
			t1.value31.KillAura.Range = 300
			t1.value31.AutoHaki.Enabled = true

			local island = v432.island
			local v434 = t1.value30[island]
			local v435 = t1.value51()

			if not (v434 and v435 and (v435.Position - v434.Center).Magnitude > 500) then
				t1.value101(v430, v432)

				return
			end

			v435.CFrame = CFrame.new(v434.Center + Vector3.new(0, 20, 0))
			t1.value101(v430, v432)

			return
		end
	end

	local v436 = t1.value51()
	local AutoSwitchQuest

	if v436 then
		AutoSwitchQuest = t1.value31.FullAutoFarm.AutoSwitchQuest
	else
		AutoSwitchQuest = v436
	end

	if AutoSwitchQuest then
		local v438 = t1.value70(v428)
		local island

		if v438 then
			island = v438.island
		else
			island = v438
		end

		if island then
			local v440 = t1.value30[v438.island]

			if v440 and (v436.Position - v440.Center).Magnitude > 500 then
				v436.CFrame = CFrame.new(v440.Center + Vector3.new(0, 20, 0))
			end
		end
	end

	if t1.value31.FullAutoFarm.AutoSwitchQuest then
		local v441 = t1.value70(v428)

		if v441 and (t1.value31.AutoFarm.SelectedQuest ~= v441.id and now - t1.value31.FullAutoFarm.lastQuestSwitch >= t1.value31.FullAutoFarm.QuestSwitchCooldown) then
			t1.value31.AutoFarm.SelectedQuest = v441.id
			t1.value31.FullAutoFarm.lastQuestSwitch = now

			local AutoTeleportToIsland = t1.value31.FullAutoFarm.AutoTeleportToIsland

			if AutoTeleportToIsland then
				AutoTeleportToIsland = v441.island
			end

			if AutoTeleportToIsland then
				t1.value72(v441.island)
			end
		end
	end

	if t1.value31.AutoFarm.AutoAcceptQuest then
		t1.value66()
	end

	if t1.value64(t1.value31.AutoFarm.currentTarget) then
		t1.value31.AutoFarm.currentTarget = nil
	end

	local currentTarget = t1.value31.AutoFarm.currentTarget

	if not (currentTarget and t1.value54(currentTarget)) then
		currentTarget = t1.value67()
	end

	local v444

	if currentTarget then
		v444 = t1.value54(currentTarget)
	else
		v444 = currentTarget
	end

	if not v444 then
		return
	end

	local v445 = t1.value51()
	local Humanoid = t1.value50()

	if Humanoid then
		Humanoid = t1.value50():FindFirstChildOfClass("Humanoid")
	end

	local HumanoidRootPart = currentTarget:FindFirstChild("HumanoidRootPart")

	if not (v445 and HumanoidRootPart) then
		return
	end

	if Humanoid then
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
	end

	local AttackHeight = t1.value31.FullAutoFarm.AttackHeight
	local v449 = HumanoidRootPart.Position + Vector3.new(0, AttackHeight, 0)

	v445.CFrame = CFrame.new(v449, HumanoidRootPart.Position)
	v445.Velocity = Vector3.new(0, 0, 0)
	v445.RotVelocity = Vector3.new(0, 0, 0)

	local FullAutoFarmBodyVel = v445:FindFirstChild("FullAutoFarmBodyVel")
	local FullAutoFarmBodyGyro = v445:FindFirstChild("FullAutoFarmBodyGyro")

	if not FullAutoFarmBodyVel then
		local BodyVelocity = Instance.new("BodyVelocity")

		BodyVelocity.Name = "FullAutoFarmBodyVel"
		BodyVelocity.Velocity = Vector3.new(0, 0, 0)
		BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		BodyVelocity.Parent = v445
	end

	if not FullAutoFarmBodyGyro then
		FullAutoFarmBodyGyro = Instance.new("BodyGyro")
		FullAutoFarmBodyGyro.Name = "FullAutoFarmBodyGyro"
		FullAutoFarmBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		FullAutoFarmBodyGyro.P = 9000000000
		FullAutoFarmBodyGyro.Parent = v445
	end

	FullAutoFarmBodyGyro.CFrame = CFrame.new(v449, HumanoidRootPart.Position)
end

t1.value105 = nil

function t1.value105()
	if not t1.value31.AutoFarm.AutoEquipWeapon then
		return
	end

	if tick() - t1.value36 < 0.5 then
		return
	end

	local v453 = t1.value39()

	if not v453 then
		return
	end

	local WeaponType = t1.value31.AutoFarm.WeaponType or "Melee"
	local v455, v456, v457 = t1.value40()
	local v458 = v31()

	if v458 then
		local v459 = t1.value38(v458.Name)
		local v460

		if v459 == WeaponType then
			v460 = true
		elseif WeaponType == "Devil Fruits" then
			v460 = v459 == "Power"
		else
			v460 = false
		end

		if v460 then
			return
		else
			v453:UnequipTools()

			return
		end
	end

	local v461 = nil
	local v462

	if WeaponType == "Melee" then
		v462 = #v455 > 0
	else
		v462 = false
	end

	if v462 then
		v461 = v455[1]
	else
		local v463

		if WeaponType == "Sword" then
			v463 = #v456 > 0
		else
			v463 = false
		end

		if v463 then
			v461 = v456[1]
		else
			local v464

			if WeaponType == "Devil Fruits" then
				v464 = #v457 > 0
			else
				v464 = false
			end

			if v464 then
				v461 = v457[1]
			elseif #v455 > 0 then
				v461 = v455[1]
			elseif #v456 > 0 then
				v461 = v456[1]
			elseif #v457 > 0 then
				v461 = v457[1]
			end
		end
	end

	if not v461 then
		return
	end

	v453:EquipTool(v461)
end
function t1.value106()
	if not t1.value31.AutoStats.Enabled then
		return
	end

	if not t1.value18 then
		return
	end

	if tick() - t1.value68 < t1.value31.AutoStats.Interval then
		return
	end

	local ok, result = pcall(function()
		if t1.value20 then
			local value20 = t1.value20

			return value20.InvokeServer(value20)
		else
			return nil
		end
	end)

	if not (ok and result) then
		return
	end

	local StatPoints = result.StatPoints or 0

	if StatPoints < t1.value31.AutoStats.PointsPerAllocation then
		return
	end

	local SelectedStat = t1.value31.AutoStats.SelectedStat
	local PointsPerAllocation = t1.value31.AutoStats.PointsPerAllocation
	local v471 = math.min(PointsPerAllocation, StatPoints)

	pcall(function()
		t1.value18:FireServer(SelectedStat, v471)
	end)
end

t1.value107 = nil
t1.value98 = 0

function t1.value108()
	if not t1.value31.KillAura.Enabled then
		return
	end

	local now = tick()

	if now - t1.value98 < 0.15 then
		return
	end

	t1.value98 = now

	local Character = t1.value2.Character
	local Tool

	if Character then
		Tool = Character:FindFirstChildOfClass("Tool")
	else
		Tool = nil
	end

	if Tool then
		if not (#t1.value57(t1.value31.KillAura.Range, t1.value31.KillAura.MaxTargets) > 0) then
			return
		end

		t1.value58()
		t1.value45()
	else
		if not t1.value31.AutoFarm.AutoEquipWeapon then
			return
		end

		t1.value105()
	end
end
function t1.value109()
	if not t1.value31.AutoFarm.Enabled then
		return
	end

	if not t1.value31.AutoFarm.SelectedQuest then
		return
	end

	if t1.value31.AutoFarm.AutoAcceptQuest then
		t1.value66()
	end

	if t1.value64(t1.value31.AutoFarm.currentTarget) then
		t1.value31.AutoFarm.currentTarget = nil
	end

	local currentTarget = t1.value31.AutoFarm.currentTarget

	if not (currentTarget and t1.value54(currentTarget)) then
		currentTarget = t1.value67()
	end

	local v476

	if currentTarget then
		v476 = t1.value54(currentTarget)
	else
		v476 = currentTarget
	end

	if not v476 then
		t1.value31.KillAura.Enabled = false

		return
	end

	local v477 = t1.value51()
	local Humanoid = t1.value50()

	if Humanoid then
		Humanoid = Humanoid:FindFirstChildOfClass("Humanoid")
	end

	local HumanoidRootPart = currentTarget:FindFirstChild("HumanoidRootPart")

	if not (v477 and HumanoidRootPart) then
		t1.value31.KillAura.Enabled = true

		return
	end

	if Humanoid then
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
	end

	local TeleportHeight = t1.value31.AutoFarm.TeleportHeight
	local v481 = HumanoidRootPart.Position + Vector3.new(0, TeleportHeight, 0)

	v477.CFrame = CFrame.new(v481, HumanoidRootPart.Position)
	v477.Velocity = Vector3.new(0, 0, 0)
	v477.RotVelocity = Vector3.new(0, 0, 0)

	local AutoFarmBodyVel = v477:FindFirstChild("AutoFarmBodyVel")
	local AutoFarmBodyGyro = v477:FindFirstChild("AutoFarmBodyGyro")

	if not AutoFarmBodyVel then
		local BodyVelocity = Instance.new("BodyVelocity")

		BodyVelocity.Name = "AutoFarmBodyVel"
		BodyVelocity.Velocity = Vector3.new(0, 0, 0)
		BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		BodyVelocity.Parent = v477
	end

	if not AutoFarmBodyGyro then
		AutoFarmBodyGyro = Instance.new("BodyGyro")
		AutoFarmBodyGyro.Name = "AutoFarmBodyGyro"
		AutoFarmBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		AutoFarmBodyGyro.P = 9000000000
		AutoFarmBodyGyro.Parent = v477
	end

	AutoFarmBodyGyro.CFrame = CFrame.new(v481, HumanoidRootPart.Position)
	t1.value31.KillAura.Enabled = true
end

local function v485()
	if not t1.value31.AutoFarmTimedBoss.Enabled then
		return
	end

	local now = tick()
	local AutoFarmTimedBoss = t1.value31.AutoFarmTimedBoss

	if now - AutoFarmTimedBoss.lastBossCheck < AutoFarmTimedBoss.BossCheckInterval then
		return
	end

	AutoFarmTimedBoss.lastBossCheck = now

	local v488 = t1.value51()

	if not v488 then
		return
	end

	local SelectedBosses = AutoFarmTimedBoss.SelectedBosses
	local t16 = {}

	if not SelectedBosses or (#SelectedBosses == 0 and true or SelectedBosses[1] == "All") then
		for k, _ in pairs(t1.value28) do
			table.insert(t16, k)
		end
	else
		t16 = SelectedBosses
	end

	local v493, _, v495 = t1.value95(AutoFarmTimedBoss.SelectedBosses)

	if v493 then
		AutoFarmTimedBoss.currentBoss = v493
		AutoFarmTimedBoss.noBossTime = 0
		t1.value101(v493, v495)

		return
	end

	AutoFarmTimedBoss.currentBoss = nil
	t1.value102()
	AutoFarmTimedBoss.noBossTime = AutoFarmTimedBoss.noBossTime + AutoFarmTimedBoss.BossCheckInterval

	local ServerHopEnabled = AutoFarmTimedBoss.ServerHopEnabled

	if ServerHopEnabled then
		ServerHopEnabled = AutoFarmTimedBoss.noBossTime >= AutoFarmTimedBoss.ServerHopCooldown
	end

	if not ServerHopEnabled then
		if not AutoFarmTimedBoss.currentIslandIndex then
			AutoFarmTimedBoss.currentIslandIndex = 1
		end

		local v497 = t16[AutoFarmTimedBoss.currentIslandIndex]
		local v498

		if v497 then
			v498 = t1.value28[v497]
		else
			v498 = v497
		end

		if v498 then
			local island = t1.value28[v497].island
			local v500 = t1.value30[island]

			if v500 and (v488.Position - v500.Center).Magnitude > 500 then
				v488.CFrame = CFrame.new(v500.Center + Vector3.new(0, 20, 0))
			end
		end

		AutoFarmTimedBoss.currentIslandIndex = AutoFarmTimedBoss.currentIslandIndex + 1

		if not (AutoFarmTimedBoss.currentIslandIndex > #t16) then
			return
		end

		AutoFarmTimedBoss.currentIslandIndex = 1

		return
	end

	local JobId = game.JobId
	local v502

	if JobId then
		v502 = not table.find(AutoFarmTimedBoss.visitedServers, JobId)
	else
		v502 = JobId
	end

	if v502 then
		local visitedServers = AutoFarmTimedBoss.visitedServers

		table.insert(visitedServers, JobId)
	end

	Library:Notify("No bosses found - Server hopping...", 3)

	local HttpService = game:GetService("HttpService")
	local game_ = game

	local function v506()
		return HttpService:JSONDecode(unpack_({ game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100") }))
	end

	local v507 = game_.GetService(game_, "TeleportService")
	local ok, result = pcall(v506)

	if ok then
		if result then
			ok = result.data
		else
			ok = result
		end
	end

	if not ok then
		AutoFarmTimedBoss.noBossTime = 0

		return
	end

	local t17 = {}

	for _, v in ipairs(result.data) do
		local v513

		if v.playing < v.maxPlayers then
			v513 = v.playing > 0
		else
			v513 = false
		end

		if v513 and not table.find(AutoFarmTimedBoss.visitedServers, v.id) then
			table.insert(t17, v)
		end
	end

	table.sort(t17, function(p44, p45)
		return p44.playing < p45.playing
	end)

	if not (#t17 > 0) then
		AutoFarmTimedBoss.noBossTime = 0

		return
	end

	local v514 = t17[1]

	pcall(function()
		v507:TeleportToPlaceInstance(game.PlaceId, v514.id)
	end)
	AutoFarmTimedBoss.noBossTime = 0
end

function t1.value110()
	return t1.value88("Dungeon Key")
end
function t1.value111(p46)
	local Remotes4 = t1.value7:FindFirstChild("Remotes")

	if Remotes4 then
		local RequestDungeonPortal = Remotes4:FindFirstChild("RequestDungeonPortal")

		if RequestDungeonPortal then
			RequestDungeonPortal:FireServer(p46)

			return true
		else
			return false
		end
	else
		return false
	end
end
function t1.value112(p47)
	local Remotes4 = t1.value7:FindFirstChild("Remotes")

	if Remotes4 then
		local DungeonWaveVote = Remotes4:FindFirstChild("DungeonWaveVote")

		if DungeonWaveVote then
			DungeonWaveVote:FireServer(p47)

			return true
		else
			return false
		end
	else
		return false
	end
end

t1.value113 = nil

function t1.value114()
	local ipairs_ = ipairs
	local value10 = t1.value10

	for _, descendant in ipairs_(value10.GetDescendants(value10)) do
		if descendant.Name == "ActiveDungeonPortal" and true or (descendant.Name:match("^Portal_") or descendant.Name:match("DungeonPortal")) then
			local ProximityPrompt = descendant:FindFirstChildWhichIsA("ProximityPrompt")

			if not ProximityPrompt then
				for _, descendant2 in ipairs(descendant:GetDescendants()) do
					if descendant2:IsA("ProximityPrompt") then
						ProximityPrompt = descendant2

						break
					end
				end
			end

			if ProximityPrompt then
				return descendant, ProximityPrompt
			end
		end
	end

	return nil, nil
end
function t1.value115()
	local PlaceId = game.PlaceId
	local AutoDungeon = t1.value31.AutoDungeon

	for k, dungeon in pairs(AutoDungeon.Dungeons) do
		if dungeon.PlaceId == PlaceId then
			return true, k
		end
	end

	local LocalPlayer = game:GetService("Players").LocalPlayer
	local PlayerGui

	if LocalPlayer then
		PlayerGui = LocalPlayer.PlayerGui
	else
		PlayerGui = LocalPlayer
	end

	if PlayerGui then
		local ipairs_ = ipairs
		local PlayerGui2 = LocalPlayer.PlayerGui

		for _, child in ipairs_(PlayerGui2.GetChildren(PlayerGui2)) do
			local v536 = child.Name:lower()

			if string.find(v536, "dungeontimer") or (string.find(v536, "dungeon_timer") or (string.find(v536, "wavetimer") or string.find(v536, "raidtimer"))) then
				return true, AutoDungeon.SelectedDungeon
			end
		end
	end

	if t1.value10:FindFirstChild("DungeonPortal") or t1.value10:FindFirstChild("Portal") then
		return false, nil
	end

	if t1.value10:FindFirstChild("DungeonMap") or t1.value10:FindFirstChild("RaidMap") then
		return true, AutoDungeon.SelectedDungeon
	end

	if t1.value7:FindFirstChild("Remotes") then
		return false, nil
	end

	local v537 = not t1.value10:FindFirstChild("IslandZones")

	if v537 then
	elseif v537 then
		return true, AutoDungeon.SelectedDungeon
	else
		return false, nil
	end

	v537 = not t1.value10:FindFirstChild("Map")

	if v537 then
		return true, AutoDungeon.SelectedDungeon
	else
		return false, nil
	end
end

t1.value116 = nil
t1.value117 = nil
t1.value100 = nil

function t1.value118()
	local AutoDungeon = t1.value31.AutoDungeon

	if not AutoDungeon.Enabled then
		return
	end

	local now = tick()
	local v540 = t1.value51()

	if not v540 then
		return
	end

	local t18 = { t1.value115() }
	local _ = t18[2]

	if not t18[1] then
		AutoDungeon.inDungeon = false
		AutoDungeon.difficultyVoted = false
		AutoDungeon.currentTarget = nil
		AutoDungeon._loggedNoNPC = false

		if t1.value116 then
			t1.value116:Destroy()
		end

		if t1.value117 then
			t1.value117:Destroy()
		end

		if t1.value100 then
			t1.value100:Destroy()
			t1.value100 = nil
		end

		local SelectedDungeon = AutoDungeon.SelectedDungeon
		local v544 = AutoDungeon.Dungeons[SelectedDungeon]

		if not v544 then
			return
		end

		if t1.value69() < v544.MinLevel then
			if AutoDungeon._loggedLevel then
				return
			end

			AutoDungeon._loggedLevel = true

			return
		elseif t1.value110() < v544.KeyCost then
			if AutoDungeon._loggedKeys then
				return
			end

			AutoDungeon._loggedKeys = true

			return
		else
			AutoDungeon._loggedLevel = false
			AutoDungeon._loggedKeys = false

			if not (now - AutoDungeon.lastPortalRequest >= AutoDungeon.portalRequestCooldown) then
				return
			end

			AutoDungeon.lastPortalRequest = now
			t1.value111(SelectedDungeon)

			return
		end
	end

	AutoDungeon.inDungeon = true

	if not AutoDungeon.difficultyVoted then
		AutoDungeon.difficultyVoted = true
		t1.value112(AutoDungeon.Difficulty)
	end

	local currentTarget = AutoDungeon.currentTarget

	if currentTarget then
		currentTarget = t1.value64(AutoDungeon.currentTarget)
	end

	if currentTarget then
		AutoDungeon.currentTarget = nil
	end

	local NPCs = t1.value10:FindFirstChild("NPCs")
	local currentTarget2 = AutoDungeon.currentTarget
	local HumanoidRootPart = nil

	if currentTarget2 then
		HumanoidRootPart = currentTarget2:FindFirstChild("HumanoidRootPart")
	elseif NPCs then
		local GetChildren = NPCs.GetChildren
		local huge = math.huge

		for _, v in ipairs(GetChildren(NPCs)) do
			local Humanoid = v:FindFirstChildOfClass("Humanoid")
			local v554 = v.FindFirstChild(v, "HumanoidRootPart")

			if Humanoid then
				if Humanoid.Health > 0 then
					Humanoid = v554
				else
					Humanoid = false
				end
			end

			if Humanoid then
				local Magnitude = (v554.Position - v540.Position).Magnitude

				if Magnitude < huge then
					HumanoidRootPart = v554
					currentTarget2 = v
					huge = Magnitude
				end
			end
		end

		if currentTarget2 then
			AutoDungeon.currentTarget = currentTarget2
		end
	end

	if currentTarget2 and HumanoidRootPart then
		local Humanoid = t1.value50()

		if Humanoid then
			Humanoid = Humanoid:FindFirstChildOfClass("Humanoid")
		end

		local DistanceFromMonster = AutoDungeon.DistanceFromMonster
		local v558 = -HumanoidRootPart.CFrame.LookVector * DistanceFromMonster
		local position = HumanoidRootPart.Position + v558 + Vector3.new(0, 0, 0)

		v540.CFrame = CFrame.new(position, HumanoidRootPart.Position)

		if Humanoid then
			Humanoid.WalkSpeed = 0
			Humanoid.JumpPower = 0
			Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
		end

		v540.Anchored = true
		v540.Anchored = false

		if not (t1.value100 and t1.value100.Parent) then
			t1.value100 = Instance.new("Attachment")
			t1.value100.Name = "DungeonBehindAttachment"
			t1.value100.Parent = v540
		end

		if not (t1.value116 and t1.value116.Parent) then
			t1.value116 = Instance.new("AlignPosition")
			t1.value116.Mode = Enum.PositionAlignmentMode.OneAttachment
			t1.value116.Attachment0 = t1.value100
			t1.value116.RigidityEnabled = true
			t1.value116.MaxForce = math.huge
			t1.value116.Parent = v540
		end

		if t1.value117 and t1.value117.Parent then
			t1.value116.Position = position
			t1.value117.CFrame = CFrame.new(position, HumanoidRootPart.Position)
			t1.value31.KillAura.Enabled = true
			t1.value31.KillAura.Range = AutoDungeon.KillAuraRange
			t1.value31.AutoHaki.Enabled = true

			return
		end

		t1.value117 = Instance.new("AlignOrientation")
		t1.value117.Mode = Enum.OrientationAlignmentMode.OneAttachment
		t1.value117.Attachment0 = t1.value100
		t1.value117.RigidityEnabled = true
		t1.value117.MaxTorque = math.huge
		t1.value117.Parent = v540
		t1.value116.Position = position
		t1.value117.CFrame = CFrame.new(position, HumanoidRootPart.Position)
		t1.value31.KillAura.Enabled = true
		t1.value31.KillAura.Range = AutoDungeon.KillAuraRange
		t1.value31.AutoHaki.Enabled = true
	else
		AutoDungeon.currentTarget = nil

		if t1.value116 then
			t1.value116:Destroy()
			t1.value116 = nil
		end

		if t1.value117 then
			t1.value117:Destroy()
			t1.value117 = nil
		end

		if t1.value100 then
		elseif AutoDungeon._loggedNoNPC then
			return
		else
			AutoDungeon._loggedNoNPC = true

			return
		end

		t1.value100:Destroy()
		t1.value100 = nil

		if AutoDungeon._loggedNoNPC then
			return
		else
			AutoDungeon._loggedNoNPC = true

			return
		end
	end
end

t1.value113 = 0

function t1.value119()
	local AutoJinwooQuest = t1.value31.AutoJinwooQuest

	if not AutoJinwooQuest.Enabled then
		return
	end

	local now = tick()

	if now - t1.value113 < 0.1 then
		return
	end

	t1.value113 = now

	local v562 = t1.value51()

	if not v562 then
		return
	end

	local JinwooBodyGyro = v562:FindFirstChild("JinwooBodyGyro")

	if not JinwooBodyGyro then
		return
	end

	if AutoJinwooQuest.currentStage ~= 4 then
		return
	end

	local v564, v565, v566 = ipairs(t1.value1:GetPlayers())
	local t19 = {}

	while true do
		local v568

		v566, v568 = v564(v565, v566)

		if not v566 then
			break
		end

		local v569

		if v568 == t1.value2 then
			v569 = false
		else
			v569 = v568.Character
		end

		if v569 then
			local HumanoidRootPart = v568.Character:FindFirstChild("HumanoidRootPart")
			local Humanoid = v568.Character:FindFirstChildOfClass("Humanoid")

			if HumanoidRootPart then
				if Humanoid then
					if Humanoid.Health > 0 then
						Humanoid = not t1.value93(v568)
					else
						Humanoid = false
					end
				end
			else
				Humanoid = HumanoidRootPart
			end

			if Humanoid then
				table.insert(t19, {
					player = v568,
					hrp = HumanoidRootPart,
					dist = (v562.Position - HumanoidRootPart.Position).Magnitude
				})
			end
		end
	end

	if not (#t19 > 0) then
		return
	end

	table.sort(t19, function(p48, p49)
		return p48.dist < p49.dist
	end)

	local v572 = t19[1]

	JinwooBodyGyro.CFrame = CFrame.new(v572.hrp.Position + Vector3.new(0, 10, 0), v572.hrp.Position)
end

t1.value107 = 0

function t1.value120()
	if not t1.value31.AutoFarmTimedBoss.Enabled then
		return
	end

	local now = tick()

	if now - t1.value107 < 0.1 then
		return
	end

	t1.value107 = now

	local v574 = t1.value51()

	if not v574 then
		return
	end

	local currentBoss = t1.value31.AutoFarmTimedBoss.currentBoss

	if not currentBoss then
		t1.value102()

		return
	end

	local HumanoidRootPart = currentBoss:FindFirstChild("HumanoidRootPart")
	local Humanoid = currentBoss:FindFirstChildOfClass("Humanoid")

	if not HumanoidRootPart then
		t1.value31.AutoFarmTimedBoss.currentBoss = nil
		t1.value102()

		return
	end

	if Humanoid then
		Humanoid = Humanoid.Health <= 0
	end

	if Humanoid then
		t1.value31.AutoFarmTimedBoss.currentBoss = nil
		t1.value102()

		return
	end

	t1.value31.KillAura.Enabled = true
	t1.value31.KillAura.Range = t1.value31.AutoFarmTimedBoss.KillAuraRange
	t1.value31.AutoHaki.Enabled = true

	local AttackHeight = t1.value31.AutoFarmTimedBoss.AttackHeight
	local position = HumanoidRootPart.Position + Vector3.new(0, AttackHeight, 0)

	if (v574.Position - HumanoidRootPart.Position).Magnitude > 100 then
		v574.CFrame = CFrame.new(position, HumanoidRootPart.Position)
	end

	if t1.value91 then
		t1.value91.Position = position
	end

	if not t1.value90 then
		return
	end

	t1.value90.CFrame = CFrame.new(position, HumanoidRootPart.Position)
end

t1.value121 = nil

function t1.value121()
	if not (t1.value31.Dupe and t1.value31.Dupe.SpamBuyBossKey) then
		return
	end

	local now = tick()

	if now - t1.value31.Dupe.lastSpamBuy < t1.value31.Dupe.SpamBuyDelay then
		return
	end

	t1.value31.Dupe.lastSpamBuy = now

	local Remotes4 = t1.value7:FindFirstChild("Remotes")

	if not Remotes4 then
		return
	end

	local MerchantRemotes = Remotes4:FindFirstChild("MerchantRemotes")

	if not MerchantRemotes then
		return
	end

	local PurchaseMerchantItem = MerchantRemotes:FindFirstChild("PurchaseMerchantItem")

	if not PurchaseMerchantItem then
		return
	end

	pcall(function()
		PurchaseMerchantItem:InvokeServer("Boss Key", 99)
	end)
end
function t1.value122()
	t1.value105()
	t1.value60()
	t1.value108()
	t1.value104()
	t1.value109()
	t1.value106()
	v485()
	t1.value118()
	t1.value76()
	t1.value79()
	t1.value83()
	t1.value85()
	t1.value103()
	t1.value121()
	t1.value119()
	t1.value120()
end

local s1 = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"

t1.value123 = loadstring(game:HttpGet(s1 .. "Library.lua"))()

local lib = loadstring(game:HttpGet(s1 .. "addons/ThemeManager.lua"))()
local lib2 = loadstring(game:HttpGet(s1 .. "addons/SaveManager.lua"))()

t1.value124 = t1.value123.Options

local _ = t1.value123.Toggles

t1.value123.ForceCheckbox = false
t1.value123.ShowToggleFrameInKeybinds = true

local v588 = t1.value123:CreateWindow({
	Title = "ember hub",
	Footer = "v" .. t1.value31.Version .. " | discord.gg/J2PM9X9x7z",
	Icon = 78282255576376,
	NotifySide = "Right",
	ShowCustomCursor = true,
	AutoShow = true
})
local t20 = {
	Main = v588:AddTab("Main", "star"),
	Combat = v588:AddTab("Combat", "swords"),
	Farm = v588:AddTab("Farm", "zap"),
	AutoQuest = v588:AddTab("Auto Quest", "scroll"),
	Stats = v588:AddTab("Stats", "box"),
	Teleport = v588:AddTab("Teleport", "map-pin"),
	Dupe = v588:AddTab("Dupe", "copy"),
	Settings = v588:AddTab("Settings", "settings")
}
local v590 = t20.Combat:AddLeftGroupbox("Kill Aura")

v590.AddToggle(v590, "KillAura_Enabled", {
	Text = "Enable Kill Aura",
	Default = false,
	Tooltip = "Automatically attack nearby enemies",
	Callback = function(p50)
		t1.value31.KillAura.Enabled = p50
	end
})

local v591 = t20.Combat:AddLeftGroupbox("Auto Haki")

v591.AddToggle(v591, "AutoHaki_Enabled", {
	Text = "Enable Auto Haki",
	Default = false,
	Tooltip = "Automatically activate Haki",
	Callback = function(p51)
		t1.value31.AutoHaki.Enabled = p51
	end
})
v591.AddToggle(v591, "AutoHaki_Armament", {
	Text = "Armament Haki",
	Default = true,
	Tooltip = "Auto activate Armament Haki",
	Callback = function(p52)
		t1.value31.AutoHaki.UseArmament = p52
	end
})
v591.AddToggle(v591, "AutoHaki_Observation", {
	Text = "Observation Haki",
	Default = true,
	Tooltip = "Auto activate Observation Haki",
	Callback = function(p53)
		t1.value31.AutoHaki.UseObservation = p53
	end
})
v591.AddToggle(v591, "AutoHaki_Conqueror", {
	Text = "Conqueror Haki",
	Default = false,
	Tooltip = "Auto activate Conqueror Haki",
	Callback = function(p54)
		t1.value31.AutoHaki.UseConqueror = p54
	end
})
v591.AddSlider(v591, "AutoHaki_Interval", {
	Text = "Interval (seconds)",
	Default = 30,
	Min = 5,
	Max = 120,
	Rounding = 0,
	Tooltip = "Time between Haki activations",
	Callback = function(p55)
		t1.value31.AutoHaki.Interval = p55
	end
})

local v592 = t20.Combat:AddRightGroupbox("Auto Skills")

v592.AddToggle(v592, "AutoSkill_Enabled", {
	Text = "Enable Auto Skills",
	Default = true,
	Tooltip = "Auto use skills when Kill Aura is active",
	Callback = function(p56)
		t1.value31.AutoSkill.Enabled = p56
	end
})
v592.AddToggle(v592, "AutoSkill_Z", {
	Text = "Use Z Skill",
	Default = true,
	Tooltip = "Auto use Z skill",
	Callback = function(p57)
		t1.value31.AutoSkill.UseZ = p57
	end
})
v592.AddToggle(v592, "AutoSkill_X", {
	Text = "Use X Skill",
	Default = true,
	Tooltip = "Auto use X skill",
	Callback = function(p58)
		t1.value31.AutoSkill.UseX = p58
	end
})
v592.AddToggle(v592, "AutoSkill_C", {
	Text = "Use C Skill",
	Default = true,
	Tooltip = "Auto use C skill",
	Callback = function(p59)
		t1.value31.AutoSkill.UseC = p59
	end
})
v592.AddToggle(v592, "AutoSkill_V", {
	Text = "Use V Skill",
	Default = true,
	Tooltip = "Auto use V skill",
	Callback = function(p60)
		t1.value31.AutoSkill.UseV = p60
	end
})
v592:AddSlider("AutoSkill_ZCooldown", {
	Text = "Z Cooldown (sec)",
	Default = 7,
	Min = 1,
	Max = 30,
	Rounding = 1,
	Tooltip = "Cooldown for Z skill",
	Callback = function(p61)
		t1.value31.AutoSkill.ZCooldown = p61
	end
})
v592.AddSlider(v592, "AutoSkill_XCooldown", {
	Text = "X Cooldown (sec)",
	Default = 12,
	Min = 1,
	Max = 60,
	Rounding = 1,
	Tooltip = "Cooldown for X skill",
	Callback = function(p62)
		t1.value31.AutoSkill.XCooldown = p62
	end
})
v592.AddSlider(v592, "AutoSkill_CCooldown", {
	Text = "C Cooldown (sec)",
	Default = 20,
	Min = 1,
	Max = 90,
	Rounding = 1,
	Tooltip = "Cooldown for C skill",
	Callback = function(p63)
		t1.value31.AutoSkill.CCooldown = p63
	end
})
v592:AddSlider("AutoSkill_VCooldown", {
	Text = "V Cooldown (sec)",
	Default = 30,
	Min = 1,
	Max = 120,
	Rounding = 1,
	Tooltip = "Cooldown for V skill",
	Callback = function(p64)
		t1.value31.AutoSkill.VCooldown = p64
	end
})

local v593 = t20.Combat:AddRightGroupbox("Auto Equip Weapons")

v593.AddToggle(v593, "AutoEquip_Enabled", {
	Text = "Auto Equip Weapons",
	Default = true,
	Tooltip = "Automatically equip weapons",
	Callback = function(p65)
		t1.value31.AutoFarm.AutoEquipWeapon = p65
	end
})
v593.AddDropdown(v593, "AutoEquip_WeaponType", {
	Values = { "Melee", "Sword", "Devil Fruits" },
	Default = 1,
	Text = "Weapon Type",
	Tooltip = "Select weapon type to auto equip",
	Callback = function(p66)
		t1.value31.AutoFarm.WeaponType = p66
	end
})

local v594 = t20.Farm:AddLeftGroupbox("Auto Farm")
local t21 = {
	Values = (function()
		local t22 = {}

		for _, v in ipairs(t1.value27) do
			if v.isBoss then
				local v599 = "[BOSS] " .. v.title

				table.insert(t22, v599)
			else
				local title = v.title

				table.insert(t22, title)
			end
		end

		return t22
	end)(),
	Default = 1,
	Text = "Select Quest",
	Tooltip = "Choose quest to farm",
	Searchable = true,
	Callback = function(p67)
		local v601 = p67:gsub("^%[BOSS%] ", "")

		for _, v in ipairs(t1.value27) do
			if v.title == v601 then
				t1.value31.AutoFarm.SelectedQuest = v.id
				t1.value31.AutoFarm.currentTarget = nil

				return
			end
		end
	end
}

v594.AddDropdown(v594, "AutoFarm_QuestSelect", t21)
v594.AddToggle(v594, "AutoFarm_Enabled", {
	Text = "Enable Auto Farm",
	Default = false,
	Tooltip = "Automatically farm quest NPCs with safe hover",
	Callback = function(p68)
		t1.value31.AutoFarm.Enabled = p68

		if p68 then
			return
		end

		t1.value31.AutoFarm.currentTarget = nil

		local Humanoid = t1.value50()

		if Humanoid then
			Humanoid = Humanoid:FindFirstChildOfClass("Humanoid")
		end

		local v605 = t1.value51()

		if Humanoid then
			Humanoid.WalkSpeed = 16
			Humanoid.JumpPower = 50
		end

		if not v605 then
			return
		end

		local GetChildren = v605.GetChildren

		for _, v in ipairs(GetChildren(v605)) do
			if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
				v:Destroy()
			end
		end
	end
})
v594.AddSlider(v594, "AutoFarm_TeleportHeight", {
	Text = "Hover Height",
	Default = 15,
	Min = 5,
	Max = 50,
	Rounding = 0,
	Tooltip = "Height above target",
	Callback = function(p69)
		t1.value31.AutoFarm.TeleportHeight = p69
	end
})

local v609 = t20.Main:AddLeftGroupbox("Full Auto Farm")

v609:AddToggle("FullAutoFarm_Enabled", {
	Text = "Enable Full Auto Farm",
	Default = false,
	Tooltip = "Complete automation: Quest switching, Kill Aura, Haki, Leveling to 10k",
	Callback = function(p70)
		t1.value31.FullAutoFarm.Enabled = p70

		if p70 then
			return
		end

		local Humanoid = t1.value50()

		if Humanoid then
			Humanoid = Humanoid:FindFirstChildOfClass("Humanoid")
		end

		local v611 = t1.value51()

		if Humanoid then
			Humanoid.WalkSpeed = 16
			Humanoid.JumpPower = 50
		end

		if not v611 then
			return
		end

		local GetChildren = v611.GetChildren

		for _, v in ipairs(GetChildren(v611)) do
			if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
				v:Destroy()
			end
		end
	end
})
v609.AddToggle(v609, "FullAutoFarm_AutoSwitchQuest", {
	Text = "Auto Switch Quest",
	Default = true,
	Tooltip = "Automatically switch to appropriate quest for your level",
	Callback = function(p71)
		t1.value31.FullAutoFarm.AutoSwitchQuest = p71
	end
})
v609.AddToggle(v609, "FullAutoFarm_AutoTeleport", {
	Text = "Auto Teleport to Island",
	Default = true,
	Tooltip = "Teleport to the island where quest NPCs are located",
	Callback = function(p72)
		t1.value31.FullAutoFarm.AutoTeleportToIsland = p72
	end
})
v609.AddToggle(v609, "FullAutoFarm_AutoKillAura", {
	Text = "Auto Enable Kill Aura",
	Default = true,
	Tooltip = "Automatically enable Kill Aura when farming",
	Callback = function(p73)
		t1.value31.FullAutoFarm.AutoEnableKillAura = p73
	end
})
v609.AddToggle(v609, "FullAutoFarm_AutoHaki", {
	Text = "Auto Enable Haki",
	Default = true,
	Tooltip = "Automatically enable Haki when farming",
	Callback = function(p74)
		t1.value31.FullAutoFarm.AutoEnableHaki = p74
	end
})
v609.AddToggle(v609, "FullAutoFarm_FarmBosses", {
	Text = "Farm Bosses (Priority)",
	Default = false,
	Tooltip = "When enabled, will stop farming NPCs to kill timed bosses when available. OFF = only farm NPCs for levels",
	Callback = function(p75)
		t1.value31.FullAutoFarm.FarmBosses = p75

		if not p75 then
			return
		end

		t1.value123:Notify("Boss farming enabled - will prioritize bosses", 3)
	end
})
v609.AddSlider(v609, "FullAutoFarm_AttackHeight", {
	Text = "Attack Height",
	Default = 15,
	Min = 5,
	Max = 50,
	Rounding = 0,
	Tooltip = "Height above target when attacking",
	Callback = function(p76)
		t1.value31.FullAutoFarm.AttackHeight = p76
	end
})
v609.AddSlider(v609, "FullAutoFarm_KillAuraRange", {
	Text = "Kill Aura Range",
	Default = 200,
	Min = 50,
	Max = 500,
	Rounding = 0,
	Tooltip = "Range for Kill Aura attacks",
	Callback = function(p77)
		t1.value31.FullAutoFarm.KillAuraRange = p77

		if not t1.value31.FullAutoFarm.Enabled then
			return
		end

		t1.value31.KillAura.Range = p77
	end
})
v609.AddSlider(v609, "FullAutoFarm_BossPriorityLevel", {
	Text = "Boss Priority Level",
	Default = 6000,
	Min = 0,
	Max = 10000,
	Rounding = 0,
	Tooltip = "When level >= this, prioritize timed boss over normal farming",
	Callback = function(p78)
		t1.value31.FullAutoFarm.BossPriorityLevel = p78
	end
})
v609.AddSlider(v609, "FullAutoFarm_QuestCooldown", {
	Text = "Quest Switch Cooldown",
	Default = 3,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Tooltip = "Seconds to wait before switching quests",
	Callback = function(p79)
		t1.value31.FullAutoFarm.QuestSwitchCooldown = p79
	end
})

local v615 = t20.Main:AddRightGroupbox("Auto Dungeon")

v615.AddToggle(v615, "AutoDungeon_Enabled", {
	Text = "Enable Auto Dungeon",
	Default = false,
	Tooltip = "Request portal → Enter → Farm NPCs → Repeat",
	Callback = function(p80)
		t1.value31.AutoDungeon.Enabled = p80
	end
})
v615.AddDropdown(v615, "AutoDungeon_SelectedDungeon", {
	Text = "Select Dungeon",
	Default = "DoubleDungeon",
	Values = { "CidDungeon", "RuneDungeon", "DoubleDungeon" },
	Tooltip = "Dungeon to farm",
	Callback = function(p81)
		t1.value31.AutoDungeon.SelectedDungeon = p81
	end
})
v615:AddDropdown("AutoDungeon_Difficulty", {
	Text = "Difficulty",
	Default = "Easy",
	Values = {
		"Easy",
		"Normal",
		"Medium",
		"Hard",
		"Extreme"
	},
	Tooltip = "Easy=Easy | Hard/Extreme=Shadow Monarch Quest",
	Callback = function(p82)
		t1.value31.AutoDungeon.Difficulty = p82
	end
})
v615.AddSlider(v615, "AutoDungeon_Distance", {
	Text = "Distance From Monster",
	Default = 10,
	Min = 3,
	Max = 30,
	Rounding = 0,
	Tooltip = "Distance behind monster when attacking",
	Callback = function(p83)
		t1.value31.AutoDungeon.DistanceFromMonster = p83
	end
})
v615:AddSlider("AutoDungeon_Range", {
	Text = "Kill Aura Range",
	Default = 300,
	Min = 100,
	Max = 500,
	Rounding = 0,
	Tooltip = "Range for Kill Aura when farming dungeon",
	Callback = function(p84)
		t1.value31.AutoDungeon.KillAuraRange = p84
	end
})
v615:AddButton({
	Text = "Enter Dungeon Now",
	Func = function()
		t1.value111(t1.value31.AutoDungeon.SelectedDungeon)
	end,
	Tooltip = "Fire remote to enter selected dungeon"
})

local v616 = t20.Main:AddLeftGroupbox("Auto Timed Boss")

v616.AddDropdown(v616, "AutoFarmTimedBoss_SelectBoss", {
	Text = "Select Boss(es)",
	Default = "All",
	Values = {
		"All",
		"GojoBoss",
		"SukunaBoss",
		"YujiBoss",
		"AizenBoss",
		"JinwooBoss",
		"AlucardBoss",
		"MadokaBoss"
	},
	Multi = true,
	Tooltip = "Select one or more bosses to farm",
	Callback = function(p85)
		t1.value31.AutoFarmTimedBoss.SelectedBosses = p85
	end
})
v616.AddToggle(v616, "AutoFarmTimedBoss_Enabled", {
	Text = "Enable Auto Farm Timed Boss",
	Default = false,
	Tooltip = "Infinite Loop: Find → Teleport → Kill → Repeat",
	Callback = function(p86)
		t1.value31.AutoFarmTimedBoss.Enabled = p86
	end
})
v616.AddSlider(v616, "AutoFarmTimedBoss_Height", {
	Text = "Attack Height",
	Default = 15,
	Min = 5,
	Max = 50,
	Rounding = 0,
	Tooltip = "Height above boss when attacking",
	Callback = function(p87)
		t1.value31.AutoFarmTimedBoss.AttackHeight = p87
	end
})
v616.AddSlider(v616, "AutoFarmTimedBoss_Range", {
	Text = "Kill Aura Range",
	Default = 300,
	Min = 100,
	Max = 500,
	Rounding = 0,
	Tooltip = "Range for Kill Aura when farming boss",
	Callback = function(p88)
		t1.value31.AutoFarmTimedBoss.KillAuraRange = p88
	end
})
v616.AddToggle(v616, "AutoFarmTimedBoss_ServerHop", {
	Text = "Server Hop (No Boss)",
	Default = false,
	Tooltip = "Auto server hop when no bosses found - prefers low pop servers, skips visited servers",
	Callback = function(p89)
		t1.value31.AutoFarmTimedBoss.ServerHopEnabled = p89

		if not p89 then
			return
		end

		t1.value31.AutoFarmTimedBoss.visitedServers = {}
		t1.value31.AutoFarmTimedBoss.noBossTime = 0
		t1.value123:Notify("Server Hop enabled for Timed Boss", 3)
	end
})
v616.AddSlider(v616, "AutoFarmTimedBoss_ServerHopCooldown", {
	Text = "Server Hop Cooldown",
	Default = 60,
	Min = 30,
	Max = 300,
	Rounding = 0,
	Tooltip = "Seconds to wait before server hopping when no bosses found",
	Callback = function(p90)
		t1.value31.AutoFarmTimedBoss.ServerHopCooldown = p90
	end
})

local Discord = t20.Main:AddRightGroupbox("Discord")

Discord:AddLabel("Join our Discord!")
Discord:AddLabel("discord.gg/J2PM9X9x7z")
Discord:AddButton({
	Text = "Copy Discord Link",
	Func = function()
		if setclipboard then
			setclipboard("https://discord.gg/J2PM9X9x7z")
			t1.value123:Notify("Discord link copied!", 3)
		else
			t1.value123:Notify("discord.gg/J2PM9X9x7z", 5)
		end
	end,
	Tooltip = "Copy Discord invite link to clipboard"
})

local v618 = t20.Farm:AddRightGroupbox("Auto Summon Boss")

v618.AddDropdown(v618, "AutoSummonBoss_SelectBoss", {
	Values = {
		"SaberBoss",
		"QinShiBoss",
		"IchigoBoss",
		"GilgameshBoss"
	},
	Default = 1,
	Text = "Select Boss",
	Tooltip = "Choose which summonable boss to farm",
	Callback = function(p91)
		t1.value31.AutoSummonBoss.SelectedBoss = p91
	end
})
v618:AddDropdown("AutoSummonBoss_Difficulty", {
	Values = t2,
	Default = 1,
	Text = "Difficulty",
	Tooltip = "Select difficulty (for Gilgamesh)",
	Callback = function(p92)
		t1.value31.AutoSummonBoss.Difficulty = p92
	end
})
v618.AddToggle(v618, "AutoSummonBoss_Enabled", {
	Text = "Enable Auto Summon Boss",
	Default = false,
	Tooltip = "Auto spawn and farm selected boss",
	Callback = function(p93)
		t1.value31.AutoSummonBoss.Enabled = p93

		if not p93 then
			return
		end

		t1.value31.AutoSummonBoss.bossKillCount = 0
		t1.value123:Notify("Auto Summon Boss started!", 3)
	end
})
v618.AddSlider(v618, "AutoSummonBoss_Height", {
	Text = "Attack Height",
	Default = 15,
	Min = 5,
	Max = 50,
	Rounding = 0,
	Tooltip = "Height above boss when attacking",
	Callback = function(p94)
		t1.value31.AutoSummonBoss.AttackHeight = p94
	end
})
v618.AddSlider(v618, "AutoSummonBoss_Range", {
	Text = "Kill Aura Range",
	Default = 300,
	Min = 100,
	Max = 500,
	Rounding = 0,
	Tooltip = "Range for Kill Aura when farming",
	Callback = function(p95)
		t1.value31.AutoSummonBoss.KillAuraRange = p95
	end
})
v618.AddToggle(v618, "AutoSummonBoss_AutoKillAura", {
	Text = "Auto Enable Kill Aura",
	Default = true,
	Tooltip = "Automatically enable Kill Aura when farming",
	Callback = function(p96)
		t1.value31.AutoSummonBoss.AutoEnableKillAura = p96
	end
})
v618:AddToggle("AutoSummonBoss_AutoHaki", {
	Text = "Auto Enable Haki",
	Default = true,
	Tooltip = "Automatically enable Haki when farming",
	Callback = function(p97)
		t1.value31.AutoSummonBoss.AutoEnableHaki = p97
	end
})
v618:AddLabel("")
v618:AddLabel("Auto Dupe Boss Key:")
v618.AddToggle(v618, "AutoSummonBoss_AutoDupeBossKey", {
	Text = "Auto Dupe Boss Key",
	Default = false,
	Tooltip = "Auto spam Boss Key dupe (NaN) for infinite keys",
	Callback = function(p98)
		t1.value31.AutoSummonBoss.AutoDupeBossKey = p98

		if not p98 then
			return
		end

		t1.value123:Notify("Auto Dupe Boss Key enabled!", 3)
	end
})
v618.AddDropdown(v618, "AutoSummonBoss_DupeCurrency", {
	Text = "Currency",
	Default = "Gems",
	Values = { "Gems", "Money" },
	Tooltip = "Select currency to dupe with",
	Callback = function(p99)
		t1.value31.AutoSummonBoss.DupeBossKeyCurrency = p99
	end
})
v618.AddSlider(v618, "AutoSummonBoss_DupeDelay", {
	Text = "Dupe Delay",
	Default = 0.5,
	Min = 0.1,
	Max = 2,
	Rounding = 1,
	Tooltip = "Delay between dupe attempts (seconds)",
	Callback = function(p100)
		t1.value31.AutoSummonBoss.DupeBossKeyDelay = p100
	end
})

local v619 = t20.AutoQuest:AddLeftGroupbox("Auto Quest")

v619.AddToggle(v619, "AutoDemoniteEvent_Enabled", {
	Text = "Auto Demonite Event",
	Default = false,
	Tooltip = "Accept quest + Auto collect Demonite Pieces",
	Callback = function(p101)
		t1.value31.AutoDemoniteEvent.Enabled = p101

		if not p101 then
			return
		end

		t1.value78()
		t1.value123:Notify("Auto Demonite Event started!", 3)
	end
})
v619.AddToggle(v619, "AutoSlimeEvent_Enabled", {
	Text = "Auto Slime Event",
	Default = false,
	Tooltip = "Accept quest + Auto collect Slime Pieces (7 pieces)",
	Callback = function(p102)
		t1.value31.AutoSlimeEvent.Enabled = p102

		if not p102 then
			return
		end

		t1.value31.AutoSlimeEvent.collectedPieces = {}
		t1.value31.AutoSlimeEvent.currentPieceIndex = 1
		t1.value81()
		t1.value123:Notify("Auto Slime Event started!", 3)
	end
})
v619.AddToggle(v619, "AutoDungeonDiscovery_Enabled", {
	Text = "Auto Dungeon Discovery",
	Default = false,
	Tooltip = "Auto collect 6 Dungeon Pieces across islands (Requires Level 5000)",
	Callback = function(p103)
		t1.value31.AutoDungeonDiscovery.Enabled = p103

		if not p103 then
			return
		end

		if t1.value31.AutoDungeonDiscovery.currentPieceIndex > 6 then
			t1.value31.AutoDungeonDiscovery.currentPieceIndex = 1
		end

		t1.value31.AutoDungeonDiscovery.attemptedIslands = {}
		t1.value82()
		t1.value123:Notify("Auto Dungeon Discovery started!", 3)
	end
})

local v620 = t20.AutoQuest:AddRightGroupbox("Auto Jinwoo Quest")

v620.AddToggle(v620, "AutoJinwooQuest_Enabled", {
	Text = "Enable Auto Jinwoo Quest",
	Default = false,
	Tooltip = "Full Auto: Farm items → Accept quest → Complete all stages → Get Jinwoo Sword",
	Callback = function(p104)
		t1.value31.AutoJinwooQuest.Enabled = p104

		if not p104 then
			return
		end

		t1.value31.AutoJinwooQuest.currentStage = 0
		t1.value31.AutoJinwooQuest.farmingItems = false
		t1.value31.AutoJinwooQuest.questAccepted = false
		t1.value123:Notify("Auto Jinwoo Quest started!", 3)
	end
})
v620.AddToggle(v620, "AutoJinwooQuest_UseManualStage", {
	Text = "Use Manual Stage",
	Default = false,
	Tooltip = "Use manually selected stage instead of auto-detect",
	Callback = function(p105)
		t1.value31.AutoJinwooQuest.UseManualStage = p105

		if not p105 then
			return
		end

		t1.value31.AutoJinwooQuest.currentStage = t1.value31.AutoJinwooQuest.ManualStage
	end
})
v620.AddDropdown(v620, "AutoJinwooQuest_ManualStage", {
	Text = "Manual Stage",
	Default = "1",
	Options = {
		"1",
		"2",
		"3",
		"4",
		"5"
	},
	Tooltip = "Stage 1: Take 15M damage | Stage 2: Kill 750 NPCs | Stage 3: Deal 100M damage | Stage 4: Kill 20 players | Stage 5: Kill JinwooBoss 15x",
	Callback = function(p106)
		t1.value31.AutoJinwooQuest.ManualStage = tonumber(p106) or 1

		if not t1.value31.AutoJinwooQuest.UseManualStage then
			return
		end

		t1.value31.AutoJinwooQuest.currentStage = t1.value31.AutoJinwooQuest.ManualStage
	end
})
v620.AddToggle(v620, "AutoJinwooQuest_ServerHop", {
	Text = "Server Hop (Stage 5)",
	Default = false,
	Tooltip = "Auto server hop to find JinwooBoss - prefers low pop servers, skips visited servers",
	Callback = function(p107)
		t1.value31.AutoJinwooQuest.ServerHopEnabled = p107

		if not p107 then
			return
		end

		t1.value31.AutoJinwooQuest.visitedServers = {}
		t1.value31.AutoJinwooQuest.noBossTime = 0
		t1.value123:Notify("Server Hop enabled for Stage 5", 3)
	end
})
v620.AddSlider(v620, "AutoJinwooQuest_ServerHopCooldown", {
	Text = "Server Hop Cooldown",
	Default = 30,
	Min = 10,
	Max = 120,
	Rounding = 0,
	Tooltip = "Seconds to wait before server hopping when boss not found",
	Callback = function(p108)
		t1.value31.AutoJinwooQuest.ServerHopCooldown = p108
	end
})
v620:AddButton({
	Text = "Check Required Items",
	Func = function()
		local _ = t1.value31.AutoJinwooQuest
		local ok, result = pcall(function()
			if t1.value20 then
				return t1.value20:InvokeServer()
			else
				return nil
			end
		end)
		local Money, Gems

		if ok and result then
			Money = result.Money or 0
			Gems = result.Gems or 0
		else
			Money = 0
			Gems = 0
		end

		t1.value123:Notify("Check console for item requirements!", 5)
	end,
	DoubleClick = false,
	Tooltip = "Print required items to console"
})

local v626 = t20.Stats:AddLeftGroupbox("Auto Stats")

v626.AddToggle(v626, "AutoStats_Enabled", {
	Text = "Enable Auto Stats",
	Default = false,
	Tooltip = "Automatically allocate stat points",
	Callback = function(p109)
		t1.value31.AutoStats.Enabled = p109
	end
})
v626.AddDropdown(v626, "AutoStats_SelectedStat", {
	Values = {
		"Melee",
		"Defense",
		"Sword",
		"Power"
	},
	Default = 1,
	Text = "Select Stat",
	Tooltip = "Choose which stat to allocate points to",
	Callback = function(p110)
		t1.value31.AutoStats.SelectedStat = p110
	end
})
v626:AddSlider("AutoStats_PointsPerAllocation", {
	Text = "Points Per Allocation",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Tooltip = "Points to allocate per cycle",
	Callback = function(p111)
		t1.value31.AutoStats.PointsPerAllocation = p111
	end
})
v626.AddSlider(v626, "AutoStats_Interval", {
	Text = "Interval (seconds)",
	Default = 0.5,
	Min = 0.1,
	Max = 5,
	Rounding = 1,
	Tooltip = "Time between allocations",
	Callback = function(p112)
		t1.value31.AutoStats.Interval = p112
	end
})
v626:AddButton({
	Text = "Reset All Stats",
	Func = function()
		if t1.value19 then
			t1.value19:FireServer()
			t1.value123:Notify("Stats reset!", 3)
		else
			t1.value123:Notify("ResetStats remote not found!", 3, "error")
		end
	end,
	Tooltip = "Reset all stats (use with caution)",
	Risky = true
})

local v627 = t20.Stats:AddRightGroupbox("Stats Info")

v627:AddLabel("Stat Points Info:")
v627:AddLabel("- Melee: +10 damage per point")
v627:AddLabel("- Defense: +50 HP per point")
v627:AddLabel("- Sword: +10 damage per point")
v627:AddLabel("- Power: +10 damage per point")

local v628 = t20.Dupe:AddLeftGroupbox("Merchant Dupe")

t1.value31.Dupe = t1.value31.Dupe or {
	ShopItems = {},
	SelectedItem = nil,
	SelectedCurrency = nil,
	SpamBuyBossKey = false,
	SpamBuyDelay = 0.1,
	lastSpamBuy = 0
}
v628:AddButton({
	Text = "Scan Shop",
	Func = function()
		local Remotes4 = t1.value7:FindFirstChild("Remotes")

		if not Remotes4 then
			t1.value123:Notify("Remotes not found!", 3, "error")

			return
		end

		local MerchantRemotes = Remotes4:FindFirstChild("MerchantRemotes")

		if not MerchantRemotes then
			t1.value123:Notify("MerchantRemotes not found!", 3, "error")

			return
		end

		local v631 = MerchantRemotes.FindFirstChild(MerchantRemotes, "GetMerchantStock")

		if not v631 then
			t1.value123:Notify("GetMerchantStock not found!", 3, "error")

			return
		end

		local t23 = { pcall(function()
				return v631:InvokeServer()
			end) }
		local v633 = t23[2]

		if not t23[1] then
			t1.value123:Notify("Failed to scan shop!", 3, "error")

			return
		end

		if not (v633 and v633.success) then
			local v634

			if v633 then
				v634 = v633.error == "level"
			else
				v634 = v633
			end

			if v634 then
				t1.value123:Notify("Need level " .. (v633.levelRequired or "?") .. " for Merchant!", 3, "error")

				return
			else
				t1.value123:Notify("Shop scan failed!", 3, "error")

				return
			end
		end

		t1.value31.Dupe.ShopItems = {}

		local t24 = {}
		local t25 = {
			["Clan Reroll"] = true,
			["Race Reroll"] = true,
			["Trait Reroll"] = true,
			["Haki Color Reroll"] = true
		}

		if v633.stock then
			for k, v in pairs(v633.stock) do
				if not t25[k] then
					table.insert(t24, k)
					t1.value31.Dupe.ShopItems[k] = {
						currency = v.currency or "Gems",
						price = v.price or 0,
						stock = v.stock or 0
					}
				end
			end
		end

		table.sort(t24)

		if #t24 == 0 then
			t1.value123:Notify("No items in shop!", 3, "error")

			return
		end

		t1.value123:Notify("Found " .. #t24 .. " items!", 5)

		local Dupe_SelectItem = t1.value124.Dupe_SelectItem

		if not Dupe_SelectItem then
			return
		end

		Dupe_SelectItem:SetValues(t24)

		if not (#t24 > 0) then
			return
		end

		Dupe_SelectItem:SetValue(t24[1])
	end,
	Tooltip = "Scan shop items with currency"
})
v628.AddDropdown(v628, "Dupe_SelectItem", {
	Text = "Select Item",
	Default = "",
	Values = {},
	Tooltip = "Select item from shop",
	Callback = function(p113)
		t1.value31.Dupe.SelectedItem = p113

		if not t1.value31.Dupe.ShopItems[p113] then
			return
		end

		t1.value31.Dupe.SelectedCurrency = t1.value31.Dupe.ShopItems[p113].currency

		local Dupe_SelectCurrency = t1.value124.Dupe_SelectCurrency

		if not Dupe_SelectCurrency then
			return
		end

		Dupe_SelectCurrency:SetValue(t1.value31.Dupe.SelectedCurrency)
	end
})
v628.AddDropdown(v628, "Dupe_SelectCurrency", {
	Text = "Currency",
	Default = "Gems",
	Values = { "Gems", "Money" },
	Tooltip = "Auto-detected from shop",
	Callback = function(p114)
		t1.value31.Dupe.SelectedCurrency = p114
	end
})
v628.AddButton(v628, {
	Text = "Make NaN",
	Func = function()
		local Remotes4 = t1.value7:FindFirstChild("Remotes")

		if not Remotes4 then
			t1.value123:Notify("Remotes not found!", 3, "error")

			return
		end

		local MerchantRemotes = Remotes4:FindFirstChild("MerchantRemotes")

		if not MerchantRemotes then
			t1.value123:Notify("MerchantRemotes not found!", 3, "error")

			return
		end

		local PurchaseMerchantItem = MerchantRemotes:FindFirstChild("PurchaseMerchantItem")

		if not PurchaseMerchantItem then
			t1.value123:Notify("PurchaseMerchantItem not found!", 3, "error")

			return
		end

		local SelectedItem = t1.value31.Dupe.SelectedItem
		local SelectedCurrency = t1.value31.Dupe.SelectedCurrency or "Gems"

		if not SelectedItem or SelectedItem == "" then
			t1.value123:Notify("Select an item first!", 3, "error")

			return
		end

		local t26 = { pcall(function()
				PurchaseMerchantItem:InvokeServer(SelectedItem, (0 / 0), SelectedCurrency)
			end) }
		local v647 = t26[2]

		if t26[1] then
			t1.value123:Notify(SelectedCurrency .. " is now NaN!", 5)
		else
			t1.value123:Notify("Failed: " .. tostring(v647), 3, "error")
		end
	end,
	Tooltip = "Buy with 0/0 = NaN currency"
})
v628:AddLabel("")
v628:AddLabel("Dupe Key:")
v628.AddToggle(v628, "Dupe_SpamBuyBossKey", {
	Text = "Dupe Boss Key x99",
	Default = false,
	Tooltip = "Auto spam buy Boss Key x99 continuously",
	Callback = function(p115)
		t1.value31.Dupe.SpamBuyBossKey = p115

		if not p115 then
			return
		end

		t1.value123:Notify("Dupe Boss Key enabled!", 3)
	end
})

local v648 = t20.Dupe:AddRightGroupbox("How it works")

v648:AddLabel("1. Click \'Scan Shop\'")
v648:AddLabel("2. Select item (currency auto-detected)")
v648:AddLabel("3. Click \'Make NaN\'")
v648:AddLabel("")
v648:AddLabel("⚠️ WARNING:")
v648:AddLabel("Selected item in inventory will become NaN!")
v648:AddLabel("After rejoin, that item = 0 (LOST)")
v648:AddLabel("Only use items you DON\'T need!")
v648:AddLabel("")
v648:AddLabel("💡 Dupe Key Info:")
v648:AddLabel("Use when you have NO Boss Key in inventory!")
v648:AddLabel("If you have keys, spawn boss first!")
v648:AddLabel("Then use Dupe Key to get infinite keys!")

local Teleport = t20.Teleport:AddLeftGroupbox("Teleport")

Teleport:AddButton({
	Text = "Save Current Position",
	Func = function()
		local v650 = t1.value51()

		if not v650 then
			return
		end

		t1.value31.Teleport.LastLocation = v650.Position
		t1.value123:Notify("Position saved!", 3)
	end,
	Tooltip = "Save current position for later use"
})
Teleport.AddButton(Teleport, {
	Text = "Teleport to Saved Position",
	Func = function()
		if t1.value31.Teleport.LastLocation then
			local v651 = t1.value51()

			if v651 then
				v651.CFrame = CFrame.new(t1.value31.Teleport.LastLocation)
				t1.value123:Notify("Teleported!", 3)

				return
			else
				return
			end
		end

		t1.value123:Notify("No position saved!", 3, "error")
	end,
	Tooltip = "Teleport to saved position"
})
Teleport:AddButton({
	Text = "Teleport to Random NPC",
	Func = function()
		if not t1.value25 then
			return
		end

		local children = t1.value25:GetChildren()

		if #children > 0 then
			local v653 = children[math.random(1, #children)]
			local HumanoidRootPart = v653:FindFirstChild("HumanoidRootPart")
			local v655 = t1.value51()

			if HumanoidRootPart and v655 then
				v655.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 5, 0))
				t1.value123:Notify("Teleported to " .. v653.Name, 3)

				return
			else
				return
			end
		end

		t1.value123:Notify("No NPCs found!", 3, "error")
	end,
	Tooltip = "Teleport to a random NPC"
})

local Teleport2 = t20.Teleport
local v657 = Teleport2.AddLeftGroupbox(Teleport2, "Shop Teleport")

t1.value125 = {}
t1.value126 = {}
t1.value127 = { "(Refresh)" }
t1.value128 = t1.value127[1]
t1.value129 = ""
t1.value130 = nil

function t1.value130(p116)
	if p116 then
		for _, descendant in ipairs(p116:GetDescendants()) do
			if descendant:IsA("ProximityPrompt") then
				return descendant
			end
		end

		return nil
	else
		return nil
	end
end

local function v660(p117)
	local v661 = t1.value130(p117)

	if v661 then
		local ActionText = v661.ActionText
		local ObjectText = v661.ObjectText
		local v664

		if ActionText then
			if ObjectText then
				if ActionText == "" then
					v664 = false
				else
					v664 = ObjectText ~= ""
				end
			else
				v664 = ObjectText
			end
		else
			v664 = ActionText
		end

		if v664 then
			return string.format("%s | %s (%s)", p117.Name, ObjectText, ActionText)
		else
			local v665

			if ObjectText then
				v665 = ObjectText ~= ""
			else
				v665 = ObjectText
			end

			if v665 then
				return string.format("%s | %s", p117.Name, ObjectText)
			else
				local v666

				if ActionText then
					v666 = ActionText ~= ""
				else
					v666 = ActionText
				end

				if v666 then
					return string.format("%s | %s", p117.Name, ActionText)
				else
					return p117.Name
				end
			end
		end
	else
		return p117.Name
	end
end

t1.value131 = nil

function t1.value131(p118)
	local Name = p118 and (p118.Name or "") or ""

	return Name:find("Craft") and "Craft" or (Name:find("Buyer") and "Buyers" or ((Name:find("Moveset") or Name:find("Mastery")) and "Moveset/Mastery" or ((Name:find("Haki") or (Name:find("Observation") or Name:find("Conqueror"))) and "Haki" or ((Name:find("Summon") or Name:find("Summoner")) and "Summon" or ((Name:find("Merchant") or Name == "Cupid") and "Merchant" or (t1.value130(p118) and "Shop" or "Other"))))))
end
function t1.value132()
	local value125 = {}

	t1.value125 = value125
	t1.value126 = {}
	t1.value127 = {}

	if t1.value26 then
		local ipairs_ = ipairs
		local value26 = t1.value26

		for _, child in ipairs_(value26.GetChildren(value26)) do
			if child:IsA("Model") then
				local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart then
					local Name = child.Name
					local v675

					if Name then
						v675 = Name:match("^QuestNPC%d+$") and true or false
					else
						v675 = false
					end

					HumanoidRootPart = not v675
				end

				if HumanoidRootPart then
					local v676 = t1.value131(child)

					t1.value125[v676] = t1.value125[v676] or {}
					t1.value126[v676] = t1.value126[v676] or {}

					local v677 = v660(child)

					if not t1.value125[v676][v677] then
						t1.value125[v676][v677] = child

						local v678 = t1.value126[v676]

						table.insert(v678, v677)
					end
				end
			end
		end
	end

	local v679, v680, v681 = pairs(t1.value126)

	while true do
		v681 = v679(v680, v681)

		if not v681 then
			break
		end

		local value127 = t1.value127

		table.insert(value127, v681)
	end

	table.sort(t1.value127)

	if #t1.value127 == 0 then
		t1.value127 = { "(None)" }
		t1.value126[t1.value127[1]] = { "(None)" }
		t1.value125[t1.value127[1]] = {}
	else
		for _, v in ipairs(t1.value127) do
			table.sort(t1.value126[v])
		end
	end

	local value124 = t1.value124

	if value124 then
		value124 = t1.value124.ShopTeleport_Category
	end

	local SetValues

	if value124 then
		SetValues = value124.SetValues
	else
		SetValues = value124
	end

	if SetValues then
		value124:SetValues(t1.value127)
		value124:SetValue(t1.value127[1])
	end

	t1.value128 = t1.value127[1]

	local v687 = t1.value126[t1.value128] or { "(None)" }
	local value1242 = t1.value124

	if value1242 then
		value1242 = t1.value124.ShopTeleport_SelectedNPC
	end

	local SetValues2

	if value1242 then
		SetValues2 = value1242.SetValues
	else
		SetValues2 = value1242
	end

	if not SetValues2 then
		t1.value129 = v687[1]

		return
	end

	value1242:SetValues(v687)
	value1242:SetValue(v687[1])
	t1.value129 = v687[1]
end

local t27 = {
	Values = t1.value127,
	Default = 1,
	Text = "Category",
	Tooltip = "Auto-categorized ServiceNPCs (QuestNPC excluded)",
	Callback = function(p119)
		t1.value128 = p119

		local v691 = t1.value126[t1.value128] or { "(None)" }
		local value124 = t1.value124

		if value124 then
			value124 = t1.value124.ShopTeleport_SelectedNPC
		end

		local SetValues

		if value124 then
			SetValues = value124.SetValues
		else
			SetValues = value124
		end

		if not SetValues then
			t1.value129 = v691[1]

			return
		end

		value124:SetValues(v691)
		value124:SetValue(v691[1])
		t1.value129 = v691[1]
	end
}

v657.AddDropdown(v657, "ShopTeleport_Category", t27)
v657:AddDropdown("ShopTeleport_SelectedNPC", {
	Values = { "(Refresh)" },
	Default = 1,
	Text = "Select NPC",
	Tooltip = "NPCs in selected category",
	Callback = function(p120)
		t1.value129 = p120
	end
})
v657:AddButton({
	Text = "Refresh Shop NPCs",
	Func = function()
		t1.value132()
		t1.value123:Notify("Shop NPC list refreshed!", 3)
	end,
	Tooltip = "Refresh list of shop NPCs in ServiceNPCs"
})
v657:AddButton({
	Text = "Teleport to Shop NPC",
	Func = function()
		local v694 = t1.value125[t1.value128]
		local v695 = v694 and v694[t1.value129] or nil

		if v695 then
			local HumanoidRootPart = v695:FindFirstChild("HumanoidRootPart")
			local v697 = t1.value51()

			if HumanoidRootPart and v697 then
				v697.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 5, 0))
				t1.value123:Notify("Teleported to " .. v695.Name, 3)

				return
			else
				t1.value123:Notify("Shop NPC HRP not found!", 3, "error")

				return
			end
		else
			t1.value123:Notify("No shop NPC selected!", 3, "error")
		end
	end,
	Tooltip = "Teleport to selected shop NPC"
})
t1.value132()

local v698 = t20.Teleport:AddRightGroupbox("Teleport Island")
local t28 = {
	Values = (function()
		local t29 = {}

		for k, v in pairs(t1.value30) do
			local v703 = v.DisplayName .. " (" .. k .. ")"

			table.insert(t29, v703)
		end

		table.sort(t29)

		return t29
	end)(),
	Default = 1,
	Text = "Select Island",
	Tooltip = "Choose island to teleport to",
	Searchable = true,
	Callback = function(p121)
		local match = p121:match("%((.-)%)")

		t1.value31.Teleport.SelectedIsland = match
	end
}

v698.AddDropdown(v698, "Teleport_IslandSelect", t28)
v698.AddButton(v698, {
	Text = "Teleport to Island",
	Func = function()
		local SelectedIsland = t1.value31.Teleport.SelectedIsland

		if not SelectedIsland then
			t1.value123:Notify("No island selected!", 3, "error")

			return
		end

		local v706 = t1.value30[SelectedIsland]

		if not v706 then
			t1.value123:Notify("Island not found!", 3, "error")

			return
		end

		local v707 = t1.value51()

		if not v707 then
			return
		end

		v707.CFrame = CFrame.new(v706.Center + Vector3.new(0, 10, 0))
		t1.value123:Notify("Teleported to " .. v706.DisplayName, 3)
	end,
	Tooltip = "Teleport to selected island"
})
t20.Teleport:AddRightGroupbox("Quick Teleport"):AddButton({
	Text = "Teleport to Spawn",
	Func = function()
		local v708 = t1.value51()

		if not v708 then
			return
		end

		local Spawns = t1.value10:FindFirstChild("Spawns")
		local v710

		if Spawns then
			v710 = #Spawns:GetChildren() > 0
		else
			v710 = Spawns
		end

		if not v710 then
			return
		end

		local v711 = Spawns.GetChildren(Spawns)[1]

		if not v711:IsA("BasePart") then
			return
		end

		v708.CFrame = v711.CFrame
		t1.value123:Notify("Teleported to spawn!", 3)
	end,
	Tooltip = "Teleport to spawn location"
})

local Misc = t20.Farm:AddLeftGroupbox("Misc")

Misc.AddButton(Misc, {
	Text = "Refresh All Connections",
	Func = function()
		if getgenv().SailorConnections then
			for _, sailorConnection in ipairs(getgenv().SailorConnections) do
				local Connected

				if sailorConnection then
					Connected = sailorConnection.Connected
				else
					Connected = sailorConnection
				end

				if Connected then
					sailorConnection:Disconnect()
				end
			end
		end

		local connection = t1.value6.Heartbeat:Connect(t1.value122)
		local getgenv_ = getgenv

		if getgenv_ then
			getgenv_ = getgenv().SailorConnections
		end

		if not getgenv_ then
			t1.value123:Notify("Connections refreshed!", 3)

			return
		end

		local SailorConnections = getgenv().SailorConnections

		table.insert(SailorConnections, connection)
		t1.value123:Notify("Connections refreshed!", 3)
	end,
	Tooltip = "Reset all event connections"
})
Misc:AddButton({
	Text = "Print Current Stats",
	Func = function()
		t1.value123:Notify("Stats printed to console!", 3)
	end,
	Tooltip = "Print current settings to console"
})

local Menu = t20.Settings:AddLeftGroupbox("Menu")

Menu:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
	Default = "LeftControl",
	NoUI = true,
	Text = "Menu keybind"
})
Menu:AddButton("Unload", function()
	t1.value123:Unload()
end)

local Discord2 = t20.Settings:AddLeftGroupbox("Discord")

Discord2:AddLabel("Join our Discord!")
Discord2:AddLabel("discord.gg/J2PM9X9x7z")
Discord2.AddButton(Discord2, {
	Text = "Copy Discord Link",
	Func = function()
		if setclipboard then
			setclipboard("https://discord.gg/J2PM9X9x7z")
			t1.value123:Notify("Discord link copied!", 3)
		else
			t1.value123:Notify("discord.gg/J2PM9X9x7z", 5)
		end
	end,
	Tooltip = "Copy Discord invite link to clipboard"
})
t1.value124.MenuKeybind:OnClick(function()
	t1.value123:Toggle()
end)
t1.value123.ToggleKeybind = t1.value124.MenuKeybind;
(function()
	local ScreenGui = Instance.new("ScreenGui")

	ScreenGui.Name = "SailorPiece_ToggleIcon"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.IgnoreGuiInset = true

	local syn_ = syn

	if syn_ then
		syn_ = syn.protect_gui
	end

	if syn_ then
		syn.protect_gui(ScreenGui)
		ScreenGui.Parent = CoreGui
	elseif get_hidden_gui or get_hui then
		ScreenGui.Parent = get_hidden_gui() or CoreGui
	else
		ScreenGui.Parent = t1.value2:WaitForChild("PlayerGui")
	end

	local ImageButton = Instance.new("ImageButton")

	ImageButton.Name = "ToggleButton"
	ImageButton.Size = UDim2.new(0, 85, 0, 85)
	ImageButton.Position = UDim2.new(0, 10, 0.5, -42)
	ImageButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	ImageButton.BorderSizePixel = 0
	ImageButton.Image = "rbxassetid://78282255576376"
	ImageButton.ImageTransparency = 0
	ImageButton.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 18)
	UICorner.Parent = ImageButton

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(0, 0, 0)
	UIStroke.Thickness = 3
	UIStroke.Transparency = 0.3
	UIStroke.Parent = ImageButton

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "MenuLabel"
	TextLabel.Size = UDim2.new(1, 0, 0, 22)
	TextLabel.Position = UDim2.new(0, 0, 1, -24)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "Menu"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 16
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextStrokeTransparency = 0.5
	TextLabel.Parent = ImageButton

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Name = "DiscordLabel"
	TextLabel2.Size = UDim2.new(1, 0, 0, 14)
	TextLabel2.Position = UDim2.new(0, 0, 1, 5)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = "discord.gg/J2PM9X9x7z"
	TextLabel2.TextColor3 = Color3.fromRGB(150, 150, 150)
	TextLabel2.TextSize = 10
	TextLabel2.Font = Enum.Font.Gotham
	TextLabel2.TextStrokeTransparency = 0.7
	TextLabel2.Parent = ScreenGui

	local u728 = false
	local u729 = nil
	local Position = nil
	local Position2 = nil

	ImageButton.InputBegan:Connect(function(input)
		if not (input.UserInputType == Enum.UserInputType.MouseButton1 and true or input.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		u728 = true
		Position = input.Position
		Position2 = ImageButton.Position

		local connection = nil

		connection = input.Changed:Connect(function()
			if input.UserInputState ~= Enum.UserInputState.End then
				return
			end

			connection:Disconnect()

			if (input.Position - Position).Magnitude < 10 then
				t1.value123:Toggle()
			end

			u728 = false
		end)
	end)
	ImageButton.InputChanged:Connect(function(input)
		if not (input.UserInputType == Enum.UserInputType.MouseMovement and true or input.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		u729 = input
	end)
	ImageButton.InputEnded:Connect(function(input)
		if not (input.UserInputType == Enum.UserInputType.MouseButton1 and true or input.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		u728 = false
	end)
	t1.value9.InputChanged:Connect(function(input)
		local v733

		if input == u729 then
			v733 = u728
		else
			v733 = false
		end

		if not v733 then
			return
		end

		local v734 = input.Position - Position

		ImageButton.Position = UDim2.new(Position2.X.Scale, Position2.X.Offset + v734.X, Position2.Y.Scale, Position2.Y.Offset + v734.Y)
	end)
	ImageButton.MouseEnter:Connect(function()
		local value8 = t1.value8
		local v736 = ImageButton
		local tweenInfo = TweenInfo.new(0.2)
		local color3 = Color3.fromRGB(50, 50, 50)
		local UDim2_ = UDim2

		value8.Create(value8, v736, tweenInfo, {
			BackgroundColor3 = color3,
			Size = UDim2_.new(0, 95, 0, 95)
		}):Play()
	end)
	ImageButton.MouseLeave:Connect(function()
		local value8 = t1.value8
		local v741 = ImageButton
		local tweenInfo = TweenInfo.new(0.2)
		local Color3_ = Color3

		value8.Create(value8, v741, tweenInfo, {
			BackgroundColor3 = Color3_.fromRGB(30, 30, 30),
			Size = UDim2.new(0, 85, 0, 85)
		}):Play()
	end)

	return ScreenGui
end)()
lib:SetLibrary(t1.value123)
lib2:SetLibrary(t1.value123)
lib2:IgnoreThemeSettings()
lib2:SetIgnoreIndexes({ "MenuKeybind" })
lib:SetFolder("SailorPiece")
lib2:SetFolder("SailorPiece/configs")
lib2:BuildConfigSection(t20.Settings)
lib:ApplyToTab(t20.Settings)
lib2:LoadAutoloadConfig();
(function()
	t1.value2.CharacterAdded:Connect(function(character)
		t1.value4 = character
		character:WaitForChild("HumanoidRootPart")
	end)

	local connection = t1.value6.Heartbeat:Connect(t1.value122)
	local getgenv_ = getgenv

	if getgenv_ then
		getgenv_ = getgenv().SailorConnections
	end

	if not getgenv_ then
		t1.value123:Notify("HybridE3 - Sailor Piece Free v" .. t1.value31.Version .. " loaded! | discord.gg/J2PM9X9x7z", 5)

		return
	end

	local SailorConnections = getgenv().SailorConnections

	table.insert(SailorConnections, connection)
	t1.value123:Notify("HybridE3 - Sailor Piece Free v" .. t1.value31.Version .. " loaded! | discord.gg/J2PM9X9x7z", 5)
end)()
