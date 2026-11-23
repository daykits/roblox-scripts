-- ====================================================================
    --         HUB MONOCHROME EDITION (DOORS INTEGRATED FRAMEWORK)
    --       Полная оптимизация под телефоны (Touch) и ПК (Universal Fade)
    -- ====================================================================

    -- ====================================================================
    --   ТЕМА ОФОРМЛЕНИЯ ПО УМОЛЧАНИЮ: "halloween" | "normal"
    --   Переключается в Настройках (кнопка "Тема хаба")
    -- ====================================================================
    local getgenv = getgenv or function() return _G end

    local DEFAULT_THEME = "halloween"

    local DEV_MODE = true

    local function VerifyAuth()
        if DEV_MODE then return true end
        
        local dispatch = getgenv()._DOORS_AUTH_DISPATCH
        if type(dispatch) ~= "function" then
            return false
        end

        local payload = dispatch()
        if type(payload) ~= "table" or not payload.Token or not payload.UserId or not payload.Key then
            return false
        end

        local lp = game:GetService("Players").LocalPlayer
        if not lp or lp.UserId ~= payload.UserId then
            return false
        end

        local currentWindow = math.floor(os.time() / 60)
        for offset = -1, 1 do
            local window = currentWindow + offset
            local seedStr = tostring(payload.Key) .. "::" .. tostring(payload.UserId) .. "::" .. tostring(window) .. "::DOORS_SECURE_AUTH"
            local hash = 5381
            for i = 1, #seedStr do
                hash = ((hash * 33) + seedStr:byte(i)) % 2147483647
            end
            if tostring(hash) == tostring(payload.Token) then
                return true
            end
        end
        return false
    end

    if not VerifyAuth() then
        local lp = game:GetService("Players").LocalPlayer
        if lp then
            pcall(function() lp:Kick("Direct execution prohibited [SEC_AUTH_FAIL]") end)
        end
        return
    end

    -- Защита от дублирования интерфейса и скриптов
    if getgenv()._HUBHUBHUB_ACTIVE and type(getgenv()._HUBHUBHUB_ACTIVE.unload) == "function" then
        pcall(getgenv()._HUBHUBHUB_ACTIVE.unload)
        task.wait(0.2)
    end

    local FUN_TAB_URL = "https://raw.githubusercontent.com/daykits/TEST-ALL/refs/heads/main/DoorsFunHubHubHub.lua"
    local CHANGELOG_URL = "https://pastefy.app/nTmPhlZA/raw"

    if not game:IsLoaded() then
        local startLoaded = tick()
        repeat
            task.wait(0.2)
        until game:IsLoaded() or (tick() - startLoaded > 15)
    end

    local DoorsUniverseId = 2440500124
    local doorsPlaces = {
        [6516141723] = true,  -- Lobby
        [6839171747] = true,  -- Hotel (Floor 1)
        [11099661448] = true, -- The Mines (Floor 2)
        [10525288220] = true, -- Retro / Event
    }
    local isDoors = (game.GameId == DoorsUniverseId)
        or (doorsPlaces[game.PlaceId] == true)
        or (game.GameId == 0)
        or (game.GameId == nil)
    if not isDoors then
        local lp = game:GetService("Players").LocalPlayer
        if lp then lp:Kick("Only for doors. GET OUT!") end
        return
    end

    -- === GLOBAL REGISTRY & UTILITIES ===
    local G = {
        Services = {
            Players = game:GetService("Players"),
            TweenService = game:GetService("TweenService"),
            UserInputService = game:GetService("UserInputService"),
            RunService = game:GetService("RunService"),
            HttpService = game:GetService("HttpService"),
            ProximityPromptService = game:GetService("ProximityPromptService"),
            PathfindingService = game:GetService("PathfindingService"),
            VirtualInputManager = (function()
                local ok, s = pcall(function() return game:GetService("VirtualInputManager") end)
                return ok and s or nil
            end)(),
            SoundService = game:GetService("SoundService"),
            MarketplaceService = game:GetService("MarketplaceService"),
            Workspace = game:GetService("Workspace"),
            Lighting = game:GetService("Lighting"),
            Debris = game:GetService("Debris"),
            Stats = game:GetService("Stats"),
            ReplicatedStorage = game:GetService("ReplicatedStorage"),
            CollectionService = game:GetService("CollectionService"),
            StarterGui = game:GetService("StarterGui")
        },
        Math = {
            v3 = Vector3.new,
            ud2 = UDim2.new,
            ud = UDim.new,
            c3 = Color3.fromRGB,
            cf = CFrame.new,
            tw = TweenInfo.new,
            rgb = Color3.fromRGB,
            deg = math.deg,
            atan2 = math.atan2,
            rad = math.rad,
            cos = math.cos,
            sin = math.sin,
            clamp = math.clamp,
            floor = math.floor,
            pi = math.pi
        }
    }

    local player = G.Services.Players.LocalPlayer
    local startPlayerWait = tick()
    while not player and (tick() - startPlayerWait < 15) do
        task.wait(0.05)
        player = G.Services.Players.LocalPlayer
    end
    if not player then
        player = G.Services.Players.LocalPlayer or (function()
            local p = nil
            pcall(function() p = G.Services.Players.PlayerAdded:Wait() end)
            return p or G.Services.Players.LocalPlayer
        end)()
    end
    local isHardwareStopCam = false

    local function getGameMainTableSafe()
        local ok, m = pcall(function()
            return (getrenv and getrenv()._G and getrenv()._G.m) or _G.m
        end)
        if ok and type(m) == "table" then
            return m
        end
        return nil
    end

    local function isAnyCutscenePlaying()
        if isHardwareStopCam then return true end

        local gd = G.Services.ReplicatedStorage:FindFirstChild("GameData")
        if gd then
            local inCut = gd:FindFirstChild("InCutscene")
            if inCut and inCut:IsA("BoolValue") and inCut.Value == true then return true end
            local finalCut = gd:FindFirstChild("FinalCutscene")
            if finalCut and finalCut:IsA("BoolValue") and finalCut.Value == true then return true end
        end

        local cam = G.Services.Workspace.CurrentCamera
        if cam then
            if cam:FindFirstChild("AnimationRoot") or cam:FindFirstChild("TempCC") or cam:FindFirstChild("TempBlur") then
                return true
            end
        end

        local char = player.Character
        if char then
            if char:GetAttribute("InCutscene") == true 
            or char:GetAttribute("Cutscene") == true 
            or char:GetAttribute("Animating") == true 
            or char:GetAttribute("AnimatingClient") == true 
            or char:GetAttribute("Climbing") == true 
            or char:GetAttribute("Hiding") == true then
                return true
            end
        end

        local pGui = player:FindFirstChild("PlayerGui")
        if pGui then
            if pGui:FindFirstChild("BrightOverlay") then return true end
            local mainUI = pGui:FindFirstChild("MainUI")
            if mainUI and not mainUI.Enabled then return true end
        end

        if player:GetAttribute("InCutscene") == true then return true end
        return false
    end
    local PlayerGui = player:WaitForChild("PlayerGui", 20) or player:FindFirstChild("PlayerGui")
    local Camera = G.Services.Workspace.CurrentCamera or G.Services.Workspace:FindFirstChildOfClass("Camera")
    local isTouchDevice = G.Services.UserInputService.TouchEnabled

    local KEY_CONFIG = {
        FOLDER = "HubHubHub_Configs",
        SESSION_RESTORE_FILE = "AutoRestore_Session.json",
        COLORS_FILE = "ESP_Colors.json",
        KEYBINDS_FILE = "Keybinds.json",
        VERSION_FILE = "LastSeenVersion.txt",
        LANG_FILE = "Language.json"
    }

    local states = {
        language = "English",
        menuKey = "F1",
        espDoors = false, espDupe = false, chestHighlight = false, itemsEsp = false, leverHighlight = false,
        timerLeverEsp = false, smoothieHighlight = false, keyHighlight = false, wardrobeEsp = false,
        liveHintBookEsp = false, figureEsp = false, liveBreakerEsp = false, fuseEsp = false,
        anchorEsp = false, grumbleEsp = false, pumpEsp = false, mandrakeEsp = false,
        groundskeeperEsp = false, monumentEsp = false, brambleEsp = false, outdoorsLeverEsp = false,
        bridgePatch = false,
        autoRooms = false,
        antiSeekFlood = false,
        a60Alert = false,
        a120Alert = false,
        antiSeekObstacles = false,
        presentsEsp = false, generatorEsp = false, monsterEsp = false, playerEsp = false, distanceEsp = false, espNames = true, tracerEsp = false, gpsPath = false,
        honchoBoxEsp = false, louieEsp = false,
        rushAlert = false, ambushAlert = false, blitzAlert = false,
        frozenAmbushAlert = false, surgeAlert = false, bashAlert = false, bushAlert = false, scribblesAlert = false, shiftAlert = false,
        antiDread = false, antiEyes = false, antiLookman = false, antiA90 = false, antiDupe = false, antiSnare = false,
        giggleRemoveHitbox = false, screechRemover = false, noPaintRoomDoor = false, antiGloom = false, antiHalt = false,
        antiDrone = false, antiJeff = false, antiVacuum = false, antiCurrents = false,
        antiSurgeDamage = false, positionSpoof = false, antiAlma = false,
        antiScribbles = false, autoTellerTicket = false, antiNoise = false,
        infItems = false,
        reachEnabled = false, reachDistance = 15,
        instantPrompt = false, fullbright = false, fullbrightBrightness = 2, autoInteract = false, autoLoot = false, antiLag = false,
        autoLootFilter = { gold = true, essential = true, normal = true, containers = true },
        superFps = false, speedEnabled = false, speedValue = 50, fovValue = 70, watermark = true,
        noclip = false, autoPadlock = false,
        customLight = false, lightR = 255, lightG = 0, lightB = 255, newYearMode = false, showWelcome = false,
        theme = DEFAULT_THEME,
        jumpEnabled = false, jumpPowerValue = 50, holyGrenade = false, trashBasket = false, pipeMode = false,
        pipeSoundEnabled = true, pipeVolumeMult = 100, autoHide = false,
        autoBreakerLegit = false, autoAnchor = false, autoHeartbeat = false,
        glowstickEnabled = false, glowstickOrbit = true, glowstickSpeed = 4, glowstickRadius = 8, glowstickHeight = 0, glowstickTapShoot = false,
        musicLoop = true, musicVolume = 50,
        thirdPerson = false, thirdPersonDistance = 7.5,
        noCamEffects = false,
        noCamShake = false,
        tvStandEsp = false,
        scrapperEsp = false, 
        fireAlarmEsp = false, 
        cartEsp = false,
        creakBypass = false,
        antiMonument = false,
        statOxygen = false,
        statBackdoorTimer = false,
        statHonchoTimer = false,
        monsterFilter = {
            rush = true, ambush = true, blitz = true, frozenambush = true,
            figure = true, seek = true, grumble = true, eyes = true,
            lookman = true, halt = true, screech = true, giggle = true,
            dread = true, groundskeeper = true, bash = true, bush = true,
            scribbles = true, teller = true, jeff = true, creak = true, a60 = true, a120 = true, a160 = true, noise = true,
            bramble = true, mandrake = true, monument = true, louie = true
        },
        chairManipulation = false,
        chairFlySpeed = 50,
        chairThrowForce = 145,
        resizerActive = false,
        resizerTool = false,
        resizerScaleStep = 12
    }

    -- === СОХРАНЕНИЕ И ЗАГРУЗКА ЯЗЫКА ===
    local function saveLanguage()
        if not writefile then return end
        pcall(function()
            if makefolder and isfolder and not isfolder(KEY_CONFIG.FOLDER) then makefolder(KEY_CONFIG.FOLDER) end
            writefile(KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.LANG_FILE, G.Services.HttpService:JSONEncode({language = states.language}))
        end)
    end

    local function loadLanguage()
        if not readfile or not isfile then return end
        pcall(function()
            local path = KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.LANG_FILE
            if isfile(path) then
                local decoded = G.Services.HttpService:JSONDecode(readfile(path))
                if type(decoded) == "table" and decoded.language then
                    states.language = decoded.language
                end
            end
        end)
    end
    loadLanguage()

    local customKeybinds = {}
    local cachedAlmaBody = nil
    local S_CONTEXT = nil

    local HIGHLIGHT_COLORS = {
        door = {G.Math.rgb(150, 200, 255), G.Math.rgb(50, 100, 200)}, player = {G.Math.rgb(255, 225, 60), G.Math.rgb(220, 170, 0)},
        dupe = {G.Math.rgb(255, 0, 0), G.Math.rgb(150, 0, 0)}, chest = {G.Math.rgb(230, 230, 230), G.Math.rgb(150, 150, 150)},
        lever = {G.Math.rgb(220, 220, 220), G.Math.rgb(130, 130, 130)}, timerLever = {G.Math.rgb(255, 170, 0), G.Math.rgb(180, 100, 0)},
        a60 = {G.Math.rgb(255, 60, 60), G.Math.rgb(180, 0, 0)},
        a120 = {G.Math.rgb(255, 210, 0), G.Math.rgb(180, 140, 0)},
        a160 = {G.Math.rgb(255, 100, 200), G.Math.rgb(180, 50, 150)},
        noise = {G.Math.rgb(0, 230, 255), G.Math.rgb(0, 150, 200)},
        coinroll = {G.Math.rgb(255, 215, 0), G.Math.rgb(180, 150, 0)},
        peachcobbler = {G.Math.rgb(255, 170, 90), G.Math.rgb(180, 90, 30)},
        candle = {G.Math.rgb(255, 195, 60), G.Math.rgb(210, 130, 20)},
        m249 = {G.Math.rgb(255, 60, 60), G.Math.rgb(180, 20, 20)},
        lightmachinegun = {G.Math.rgb(255, 60, 60), G.Math.rgb(180, 20, 20)},
        knockbackstick = {G.Math.rgb(255, 0, 150), G.Math.rgb(180, 0, 100)},
        creak = {G.Math.rgb(180, 20, 255), G.Math.rgb(120, 0, 190)},
        tvStand = {G.Math.rgb(0, 220, 255), G.Math.rgb(0, 140, 200)},
        scrapper = {G.Math.rgb(255, 140, 0), G.Math.rgb(180, 80, 0)},
        fireAlarm = {G.Math.rgb(255, 60, 60), G.Math.rgb(180, 20, 20)},
        cart = {G.Math.rgb(255, 215, 0), G.Math.rgb(180, 150, 0)},
        smoothie = {G.Math.rgb(240, 240, 240), G.Math.rgb(140, 140, 140)}, key = {G.Math.rgb(255, 215, 0), G.Math.rgb(255, 165, 0)},
        wardrobe = {G.Math.rgb(100, 255, 100), G.Math.rgb(0, 150, 0)}, liveHintBook = {G.Math.rgb(100, 200, 255), G.Math.rgb(0, 100, 200)},
        figure = {G.Math.rgb(255, 100, 100), G.Math.rgb(150, 0, 0)}, item = {G.Math.rgb(170, 0, 255), G.Math.rgb(100, 0, 255)},
        fuse = {G.Math.rgb(255, 50, 50), G.Math.rgb(180, 0, 0)}, anchor = {G.Math.rgb(0, 255, 255), G.Math.rgb(0, 150, 150)},
        grumble = {G.Math.rgb(255, 80, 0), G.Math.rgb(150, 40, 0)}, pump = {G.Math.rgb(50, 100, 255), G.Math.rgb(0, 0, 150)},
        mandrake = {G.Math.rgb(139, 69, 19), G.Math.rgb(160, 82, 45)}, groundskeeper = {G.Math.rgb(70, 70, 70), G.Math.rgb(30, 30, 30)},
        monument = {G.Math.rgb(100, 255, 255), G.Math.rgb(0, 150, 150)}, bramble = {G.Math.rgb(0, 255, 0), G.Math.rgb(0, 150, 0)},
        louie = {G.Math.rgb(205, 133, 63), G.Math.rgb(139, 69, 19)},
        vineLever = {G.Math.rgb(255, 140, 0), G.Math.rgb(160, 80, 0)}, presents = {G.Math.rgb(0, 255, 0), G.Math.rgb(255, 0, 0)},
        generator = {G.Math.rgb(0, 255, 180), G.Math.rgb(0, 160, 120)}, rush = {G.Math.rgb(255, 20, 20), G.Math.rgb(180, 0, 0)},
        ambush = {G.Math.rgb(0, 255, 100), G.Math.rgb(0, 150, 50)}, blitz = {G.Math.rgb(0, 220, 255), G.Math.rgb(0, 130, 200)},
        frozenAmbush = {G.Math.rgb(100, 220, 255), G.Math.rgb(50, 130, 220)}, eyes = {G.Math.rgb(120, 180, 255), G.Math.rgb(50, 100, 255)},
        lookman = {G.Math.rgb(255, 40, 40), G.Math.rgb(150, 0, 0)}, halt = {G.Math.rgb(0, 255, 220), G.Math.rgb(0, 160, 150)},
        screech = {G.Math.rgb(60, 60, 60), G.Math.rgb(20, 20, 20)}, giggle = {G.Math.rgb(180, 255, 0), G.Math.rgb(120, 180, 0)},
        seek = {G.Math.rgb(180, 0, 0), G.Math.rgb(100, 0, 0)}, dread = {G.Math.rgb(80, 80, 100), G.Math.rgb(30, 30, 40)},
        monster = {G.Math.rgb(255, 0, 50), G.Math.rgb(180, 0, 0)}, lotuspetal = {G.Math.rgb(255, 130, 220), G.Math.rgb(190, 40, 140)},
        bash = {G.Math.rgb(255, 80, 20), G.Math.rgb(180, 20, 0)}, bush = {G.Math.rgb(0, 220, 80), G.Math.rgb(0, 140, 40)},
        paperplane = {G.Math.rgb(255, 180, 220), G.Math.rgb(180, 100, 150)}, laserpointer = {G.Math.rgb(255, 50, 80), G.Math.rgb(180, 0, 30)},
        fihflakes = {G.Math.rgb(100, 220, 255), G.Math.rgb(0, 140, 190)}, pizza = {G.Math.rgb(255, 160, 40), G.Math.rgb(190, 90, 0)},
        honchoCorrect = {G.Math.rgb(0, 255, 120), G.Math.rgb(0, 180, 80)},
        honchoWrong = {G.Math.rgb(120, 120, 130), G.Math.rgb(70, 70, 80)}
    }

    local function saveCustomColors()
        if not writefile then return end
        pcall(function()
            if makefolder and isfolder and not isfolder(KEY_CONFIG.FOLDER) then makefolder(KEY_CONFIG.FOLDER) end
            local serializable = {}
            for k, v in pairs(HIGHLIGHT_COLORS) do
                serializable[k] = {
                    {G.Math.floor(v[1].R * 255), G.Math.floor(v[1].G * 255), G.Math.floor(v[1].B * 255)},
                    {G.Math.floor(v[2].R * 255), G.Math.floor(v[2].G * 255), G.Math.floor(v[2].B * 255)}
                }
            end
            writefile(KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.COLORS_FILE, G.Services.HttpService:JSONEncode(serializable))
        end)
    end

    local function loadCustomColors()
        if not readfile or not isfile then return end
        pcall(function()
            local path = KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.COLORS_FILE
            if isfile(path) then
                local decoded = G.Services.HttpService:JSONDecode(readfile(path))
                if type(decoded) == "table" then
                    for k, v in pairs(decoded) do
                        if HIGHLIGHT_COLORS[k] and type(v) == "table" and v[1] and v[2] then
                            HIGHLIGHT_COLORS[k] = {
                                G.Math.rgb(v[1][1], v[1][2], v[1][3]),
                                G.Math.rgb(v[2][1], v[2][2], v[2][3])
                            }
                        end
                    end
                end
            end
        end)
    end
    loadCustomColors()

    local function saveCustomKeybinds()
        if not writefile then return end
        pcall(function()
            if makefolder and isfolder and not isfolder(KEY_CONFIG.FOLDER) then makefolder(KEY_CONFIG.FOLDER) end
            writefile(KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.KEYBINDS_FILE, G.Services.HttpService:JSONEncode(customKeybinds))
        end)
    end

    local function loadCustomKeybinds()
        if not readfile or not isfile then return end
        pcall(function()
            local path = KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.KEYBINDS_FILE
            if isfile(path) then
                local decoded = G.Services.HttpService:JSONDecode(readfile(path))
                if type(decoded) == "table" then
                    for k, v in pairs(decoded) do
                        customKeybinds[k] = tostring(v)
                    end
                end
            end
        end)
        if not customKeybinds["noclipPhase"] then customKeybinds["noclipPhase"] = "V" end
        if not customKeybinds["noclipUp"] or customKeybinds["noclipUp"] == "Space" then customKeybinds["noclipUp"] = "Equals" end
        if not customKeybinds["noclipDown"] or customKeybinds["noclipDown"] == "LeftControl" then customKeybinds["noclipDown"] = "Minus" end
    end
    loadCustomKeybinds()

    local function getPivotPos(obj)
        if not obj then return nil end
        if obj:IsA("BasePart") then return obj.Position end
        if obj:IsA("Model") then
            local pp = obj.PrimaryPart
            if pp then return pp.Position end
            local anyPart = obj:FindFirstChildWhichIsA("BasePart")
            if anyPart then return anyPart.Position end
        end
        return nil
    end

    local function getPivotCF(obj)
        if not obj then return G.Math.cf() end
        if obj:IsA("BasePart") then return obj.CFrame end
        if obj:IsA("Model") then
            local pp = obj.PrimaryPart
            if pp then return pp.CFrame end
            local anyPart = obj:FindFirstChildWhichIsA("BasePart")
            if anyPart then return anyPart.CFrame end
        end
        return G.Math.cf()
    end

    local function isMonsterDescendant(obj)
        local cur = obj
        local ws = G.Services.Workspace
        while cur and cur ~= ws do
            local n = tostring(cur.Name):lower()
            if n:find("rush") or n:find("ambush") or n:find("blitz") or n:find("figure") or n:find("eyes") or n:find("lookman") or n:find("halt") 
            or n:find("shade") or n:find("screech") or n:find("grumble") or n:find("dread") or n:find("seek") 
            or n:find("giggle") or n:find("surge") or n:find("thunder") or n:find("groundskeeper") or n:find("bash") or n:find("bush") or n:find("drone") or n:find("staticguy") or n:find("scribble") or n:find("scribbles") or n:find("alma") or n:find("teller") or n:find("jeff") or n:find("honcho") or n:find("creak") or n:find("bramble") or n:find("mandrake") or n:find("monument") or n:find("mousehole") or n:find("louie")
            or n:find("a60") or n:find("a-60") or n:find("a120") or n:find("a-120") or n:find("a160") or n:find("a-160") then
                return true
            end
            cur = cur.Parent
        end
        return false
    end

    local MONSTER_ESP_NAMES = {
        ["RushMoving"] = {col="rush", key="rush", isRushLike=true},
        ["AmbushMoving"] = {col="ambush", key="ambush", isRushLike=true},
        ["BackdoorRush"] = {col="blitz", key="blitz", isRushLike=true},
        ["A60"] = {col="a60", key="a60", isRushLike=true},
        ["A-60"] = {col="a60", key="a60", isRushLike=true},
        ["A_60"] = {col="a60", key="a60", isRushLike=true},
        ["A120"] = {col="a120", key="a120", isRushLike=true},
        ["A-120"] = {col="a120", key="a120", isRushLike=true},
        ["A_120"] = {col="a120", key="a120", isRushLike=true},
        ["FrozenAmbush"] = {col="frozenAmbush", key="frozenambush", isRushLike=true},
        ["BashMoving"] = {col="bash", key="bash", isRushLike=true},
        ["NoiseModel"] = {col="noise", key="noise", isRushLike=false},
        ["Noise"] = {col="noise", key="noise", isRushLike=false},
        ["Creak"] = {col="creak", key="creak", isRushLike=false},
        ["CreakEntity"] = {col="creak", key="creak", isRushLike=false},
        ["Bash"] = {col="bash", key="bash", isRushLike=true},
        ["BushMoving"] = {col="bush", key="bush", isRushLike=true},
        ["Bush"] = {col="bush", key="bush", isRushLike=true},
        ["BushEntity"] = {col="bush", key="bush", isRushLike=true},
        ["ScribblesMoving"] = {col="rush", key="scribbles", isRushLike=true},
        ["ScribbleMoving"] = {col="rush", key="scribbles", isRushLike=true},
        ["Scribbles"] = {col="rush", key="scribbles", isRushLike=true},
        ["Eyes"] = {col="eyes", key="eyes", isRushLike=false},
        ["EyesRushMode"] = {col="eyes", key="eyes", isRushLike=false},
        ["Lookman"] = {col="lookman", key="lookman", isRushLike=false},
        ["Shade"] = {col="halt", key="halt", isRushLike=false},
        ["ShadeRushMode"] = {col="halt", key="halt", isRushLike=false},
        ["Screech"] = {col="screech", key="screech", isRushLike=false},
        ["ScreechRushMode"] = {col="screech", key="screech", isRushLike=false},
        ["ScreechRetro"] = {col="screech", key="screech", isRushLike=false},
        ["Giggle"] = {col="giggle", key="giggle", isRushLike=false},
        ["Dread"] = {col="dread", key="dread", isRushLike=false},
        ["DreadRushMode"] = {col="dread", key="dread", isRushLike=false},
        ["TellerRig"] = {col="monster", key="teller", isRushLike=false},
        ["JeffTheKiller"] = {col="monster", key="jeff", isRushLike=false},
        ["FigureRig"] = {col="figure", key="figure", isRushLike=false},
        ["Grumbo"] = {col="grumble", key="grumble", isRushLike=false},
        ["GrumbleRig"] = {col="grumble", key="grumble", isRushLike=false},
        ["Groundskeeper"] = {col="groundskeeper", key="groundskeeper", isRushLike=false},
        ["Seek_Rig"] = {col="seek", key="seek", isRushLike=false},
        ["SeekMoving"] = {col="seek", key="seek", isRushLike=false},
        ["LiveEntityBramble"] = {col="bramble", key="bramble", isRushLike=false},
        ["Bramble"] = {col="bramble", key="bramble", isRushLike=false},
        ["MandrakeLive"] = {col="mandrake", key="mandrake", isRushLike=false},
        ["Mandrake"] = {col="mandrake", key="mandrake", isRushLike=false},
        ["MonumentEntity"] = {col="monument", key="monument", isRushLike=false},
        ["MouseHole"] = {col="louie", key="louie", isRushLike=false},
        ["Louie"] = {col="louie", key="louie", isRushLike=false}
    }

    local function isRealMonumentEntity(obj)
        if not obj or typeof(obj) ~= "Instance" or not obj:IsA("Model") then return false end
        if obj.Name ~= "MonumentEntity" then return false end
        return (obj:FindFirstChild("Top") ~= nil) or (obj:GetAttribute("LoadModule") == "MonumentEntity")
    end

    local MONSTER_TYPES_FAST = {
        rush = true, noise = true, a60 = true, a120 = true, a160 = true, ambush = true,
        blitz = true, frozenAmbush = true, figure = true, grumble = true, groundskeeper = true,
        eyes = true, lookman = true, halt = true, screech = true, giggle = true, dread = true,
        seek = true, bash = true, bush = true, scribbles = true, monster = true, teller = true,
        jeff = true, creak = true, bramble = true, mandrake = true, monument = true, louie = true
    }

    local function isMonsterInstance(obj, typeName)
        if typeName and (MONSTER_ESP_NAMES[typeName] or MONSTER_TYPES_FAST[typeName]) then
            return true
        end
        if not obj or typeof(obj) ~= "Instance" then return false end
        local n = obj.Name
        if n == "MonumentSpawn" then return false end
        if MONSTER_ESP_NAMES[n] then return true end
        return false
    end

    -- === PERMANENT SCREECHON SYSTEM ===
    local function updateScreechOnAttribute()
        local char = player.Character
        if not char then return end
        if states and states.antiEyes then
            if char:GetAttribute("ScreechOn") ~= true then
                char:SetAttribute("ScreechOn", true)
            end
        else
            if char:GetAttribute("ScreechOn") == true then
                char:SetAttribute("ScreechOn", nil)
            end
        end
    end

    local screechConn = nil
    local function bindScreechListener(char)
        if not char then return end
        if screechConn then screechConn:Disconnect() screechConn = nil end

        updateScreechOnAttribute()

        screechConn = char:GetAttributeChangedSignal("ScreechOn"):Connect(function()
            if states and states.antiEyes and char:GetAttribute("ScreechOn") ~= true then
                char:SetAttribute("ScreechOn", true)
            end
        end)
    end

    if player.Character then
        bindScreechListener(player.Character)
    end
    player.CharacterAdded:Connect(bindScreechListener)

    G.Services.CollectionService:GetInstanceAddedSignal("EyesParticle"):Connect(function(particle)
        if states and states.antiEyes and particle:IsA("ParticleEmitter") then
            particle.Texture = "rbxassetid://18280184574"
        end
    end)

    -- === ANTI-EYES & LOOKMAN SPOOF SYSTEM ===
    local cachedEyesActive = false
    local cachedLookmanActive = false
    local activeEyesModels = {}
    local activeLookmanModels = {}

    local function checkEntity(inst)
        if not inst or not inst:IsA("Model") then return end
        local name = inst.Name
        local isSeekEye = name:find("Seek") or name:find("SeekEye") or name:find("Seek_Eye")
        if not isSeekEye and (name == "Eyes" or name == "EyesRushMode" or (name:find("Eyes") and not name:find("Wall"))) then
            if not table.find(activeEyesModels, inst) then
                activeEyesModels[#activeEyesModels + 1] = inst
                cachedEyesActive = true
            end
        elseif name == "Lookman" or name == "BackdoorLookman" or name:find("Lookman") then
            if not table.find(activeLookmanModels, inst) then
                activeLookmanModels[#activeLookmanModels + 1] = inst
                cachedLookmanActive = true
            end
        end
    end

    local liveEntities = G.Services.Workspace:WaitForChild("LiveEntities", 5)
    if liveEntities then
        liveEntities.ChildAdded:Connect(checkEntity)
        for _, child in ipairs(liveEntities:GetChildren()) do checkEntity(child) end
    end
    G.Services.Workspace.ChildAdded:Connect(checkEntity)

    task.spawn(function()
        while true do
            task.wait(isTouchDevice and 0.12 or 0.06)

            for i = #activeEyesModels, 1, -1 do
                local m = activeEyesModels[i]
                if not m or not m.Parent then
                    table.remove(activeEyesModels, i)
                end
            end

            for i = #activeLookmanModels, 1, -1 do
                local m = activeLookmanModels[i]
                if not m or not m.Parent then
                    table.remove(activeLookmanModels, i)
                end
            end

            cachedEyesActive = (states and states.antiEyes and #activeEyesModels > 0) or false
            cachedLookmanActive = (states and states.antiLookman and #activeLookmanModels > 0) or false

            if cachedEyesActive or cachedLookmanActive then
                pcall(function()
                    local rs = G.Services.ReplicatedStorage
                    local remotes = rs:FindFirstChild("RemotesFolder") or rs:FindFirstChild("EntityInfo")
                    local motor = remotes and remotes:FindFirstChild("MotorReplication")
                    if motor then
                        motor:FireServer(-650)
                    end
                end)
            end
        end
    end)

    -- === NAMECALL HOOKS ===
    local CreakSpoof = { active = false, yaw10 = nil }
    local HookStore = { NC = nil }
    local setnamecallmethod = setnamecallmethod

    getgenv()._HUBHUBHUB_RESTORE_NC = function()
        local orig = HookStore and HookStore.NC
        if not orig then return false end

        local ok = pcall(function() hookmetamethod(game, "__namecall", orig) end)
        if not ok then
            ok = pcall(function()
                local mt = getrawmetatable(game)
                setreadonly(mt, false)
                mt.__namecall = orig
                setreadonly(mt, true)
            end)
        end

        if ok then
            HookStore.NC = nil
            return true
        end
        return false
    end

    if hookmetamethod then
        pcall(function()
            HookStore.NC = hookmetamethod(game, "__namecall", function(self, ...)
                local origNC = HookStore.NC
                if not origNC then return nil end

                local getMethod = getnamecallmethod
                local method = getMethod and getMethod()
                if not method then return origNC(self, ...) end

                if method == "FireServer" or method == "fireServer" then
                    local remoteName = self.Name

                    if remoteName == "MotorReplication" then
                        if cachedEyesActive or cachedLookmanActive then
                            if setnamecallmethod then setnamecallmethod(method) end
                            return origNC(self, -650)
                        end

                    elseif remoteName == "TargetCameraDirection" then
                        if cachedEyesActive or cachedLookmanActive then
                            if setnamecallmethod then setnamecallmethod(method) end
                            return origNC(self, Vector3.new(0, -1, 0))
                        end
                    end

                    if states and states.antiScribbles and remoteName == "IfYoureExploitingDeleteThis" then
                        return nil
                    end

                    if states and states.antiDread and remoteName == "Dread" then
                        return nil
                    end

                    if states and states.antiSeekFlood and (remoteName == "SeekSlop" or (remoteName == "Remote" and self.Parent and self.Parent.Name == "SeekFlood")) then
                        return nil
                    end

                    if states and states.antiDrone then
                        if remoteName == "WalkedInto" or remoteName == "ShoulderChecked" or remoteName == "Trampled" then
                            return nil
                        end
                    end

                    if states and states.screechRemover and remoteName == "Screech" then
                        local par = self.Parent
                        if par and par.Name == "RemotesFolder" then
                            if setnamecallmethod then setnamecallmethod(method) end
                            return origNC(self, true)
                        end
                    end

                elseif (method == "WorldToViewportPoint" or method == "worldToViewportPoint" 
                    or method == "WorldToScreenPoint" or method == "worldToScreenPoint"
                    or method == "PointToScreenPoint" or method == "pointToScreenPoint") and self.ClassName == "Camera" then

                    local isScriptCall = checkcaller and checkcaller()
                    if not isScriptCall and states and (states.antiEyes or states.antiLookman or states.antiAlma) then
                        local pt = ...
                        if typeof(pt) == "Vector3" then
                            if states.antiEyes and cachedEyesActive and #activeEyesModels > 0 then
                                for i = 1, #activeEyesModels do
                                    local em = activeEyesModels[i]
                                    if em and em.Parent then
                                        local ep = getPivotPos(em)
                                        if ep then
                                            local dx, dy, dz = ep.X - pt.X, ep.Y - pt.Y, ep.Z - pt.Z
                                            if (dx*dx + dy*dy + dz*dz) <= 2500 then
                                                return Vector3.new(-9999, -9999, -1000), false
                                            end
                                        end
                                    end
                                end
                            end

                            if states.antiLookman and cachedLookmanActive and #activeLookmanModels > 0 then
                                for i = 1, #activeLookmanModels do
                                    local lm = activeLookmanModels[i]
                                    if lm and lm.Parent then
                                        local lp = getPivotPos(lm)
                                        if lp then
                                            local dx, dy, dz = lp.X - pt.X, lp.Y - pt.Y, lp.Z - pt.Z
                                            if (dx*dx + dy*dy + dz*dz) <= 2500 then
                                                return Vector3.new(-9999, -9999, -1000), false
                                            end
                                        end
                                    end
                                end
                            end

                            if states.antiAlma and cachedAlmaBody and cachedAlmaBody.Parent then
                                local ap = cachedAlmaBody.Position
                                local dx, dy, dz = ap.X - pt.X, ap.Y - pt.Y, ap.Z - pt.Z
                                if (dx*dx + dy*dy + dz*dz) <= 16 then
                                    return Vector3.new(-9999, -9999, -1000), false
                                end
                            end
                        end
                    end

                    if setnamecallmethod then setnamecallmethod(method) end
                    return origNC(self, ...)
                end

                if setnamecallmethod then setnamecallmethod(method) end
                return origNC(self, ...)
            end)
        end)
    end

    -- === ТЕЛЕПОРТ И ВОССТАНОВЛЕНИЕ СЕССИИ ===
    local function saveAutoRestoreSession()
        if not writefile then return end
        pcall(function()
            if makefolder and isfolder and not isfolder(KEY_CONFIG.FOLDER) then 
                makefolder(KEY_CONFIG.FOLDER) 
            end
            writefile(KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.SESSION_RESTORE_FILE, G.Services.HttpService:JSONEncode({
                timestamp = os.time(),
                states = states
            }))
        end)
    end

    local function registerTeleportQueue()
        local queueFunc = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
        if queueFunc then
            pcall(function()
                queueFunc([[
                    task.spawn(function()
                        local maxWait = 25
                        local startTime = tick()
                        repeat task.wait(0.4) until game:IsLoaded() or (tick() - startTime > maxWait)
                        task.wait(1.5)
                        pcall(function()
                            if game.GameId == 2440500124 or game.GameId == 0 then
                                local function tryExecute(code)
                                    if type(code) == "string" and code ~= "" then
                                        local fn = loadstring(code)
                                        if fn then fn() end
                                    end
                                end
                                if isfile and readfile and isfile("HubHubHub_Configs/HubMain.lua") then
                                    local c = readfile("HubHubHub_Configs/HubMain.lua")
                                    tryExecute(c)
                                elseif isfile and readfile and isfile("HubHubHub_Configs/HubReinject.lua") then
                                    local c = readfile("HubHubHub_Configs/HubReinject.lua")
                                    tryExecute(c)
                                end
                            end
                        end)
                    end)
                ]])
            end)
        end
    end

    pcall(function()
        player.OnTeleport:Connect(function(state)
            if state == Enum.TeleportState.Started or state == Enum.TeleportState.InProgress then
                saveAutoRestoreSession()
                registerTeleportQueue()
            end
        end)
    end)

    local function parseStrMap(str)
        local t = {}
        for pair in str:gmatch("%S+") do
            local k, v = pair:match("([^:]+):([^:]+)")
            if k and v then t[k] = v else t[pair] = true end
        end
        return t
    end

    local ESP_DICTIONARY = {
        English = parseStrMap([[
            door:Door dupe:Fake Door tv_stand:TV Stand stairwellscrapper:Scrapper chest:Chest chest_vine:Vine Chest chestvine:Vine Chest
            lever:Lever timerLever:Backdoor Lever vinelever:Vine Lever breaker:Breaker anchor:Anchor waterpump:Valve wheel:Valve generator:Generator
            wardrobe:Wardrobe hidingspot:Wardrobe hidingspot1:Wardrobe hidingspot2:Wardrobe hidingspot3:Wardrobe hidingspot4:Wardrobe hidingspot5:Wardrobe hidingspot6:Wardrobe hidingspot7:Wardrobe hidingspot8:Wardrobe
            key:Key keyelectrical:Electric Key keyretro:Retro Key keyiron:Iron Key keybackdoor:Backdoor Key keygarage:Garage Key skeletonkey:Skeleton Key
            lockpick:Lockpick shears:Shears multitool:Multitool chestboxlocked:Locked Chest a60:A-60 a120:A-120 a160:A-160
            fuse:Fuse generatorfuse:Fuse livebreakerpolepickup:Breaker
            livehintbook:Book hintbook:Book libraryhintpaper:Code Paper libraryhintpaperhard:Hardcore Paper
            figure:Figure grumble:Grumble mandrake:Mandrake groundskeeper:Groundskeeper monument:Monument bramble:Bramble
            rush:Rush ambush:Ambush blitz:Blitz frozenambush:Frozen Ambush bash:Bash bush:Bush scribbles:Scribbles monster:Monster
            player:Player eyes:Eyes lookman:Lookman halt:Halt screech:Screech seek:Seek giggle:Giggle dread:Dread
            smoothie:Smoothie riftsmoothie:Moonlight Float donut:Donut bread:Bread cheese:Cheese pizza:Pizza peachcobbler:Peach Cobbler gweensoda:Gween Soda
            bandage:Bandage bandagepack:Bandage Pack battery:Battery batterypack:Battery Pack
            lighter:Lighter flashlight:Flashlight bulklight:Bulklight shakelight:Shakelight straplight:Straplight lantern:Lantern
            candle:Candle riftcandle:Moonlight Candle glowstick:Glowstick glowsticks:Glowstick
            starjug:Starlight Jug starbottle:Starlight Bottle starvial:Starlight Vial riftjar:Rift Jar
            laserpointer:Laser Pointer alarmclock:Alarm Clock gummyflashlight:Gummy Flashlight
            holygrenade:Holy Grenade goldgun:Gold Blaster knockbackstick:Admin Stick boxinggloves:Boxing Gloves
            bomb:Bomb bigbomb:Big Bomb knockbomb:Knockbomb bigproptool:Throwable Prop lightmachinegun:M249 m249:M249
            crucifix:Crucifix pocketmirror:Pocket Mirror stopsign:Stop Sign snakebox:Snake Box compass:Compass aloevera:Aloe Vera
            nanner:Banana nannerpeel:Banana Peel paperplane:Paper Plane paperplanepickup:Paper Plane
            gold:Gold goldpile:Gold coinroll:Coin Roll tipjar:Tip Jar
            fihflakes:Fish Flakes honeypot:Honey Pot lotuspetal:Lotus Petal lotuspetalpickup:Lotus Petal lotusholder:Lotus Petal
            presents:Present present:Present archivesstoragebox:Box louie:Louie mousehole:Mouse Hole creak:Creak
            stairwellfirealarm:Fire Alarm noisemodel:Noise noise:Noise shoppingcart:Shopping Cart
        ]]),
        Russian = parseStrMap([[
            door:Дверь dupe:Фейк Дверь tv_stand:ТВ Стойка stairwellscrapper:Утилизатор chest:Сундук chest_vine:Сундук в лианах chestvine:Сундук в лианах
            lever:Рычаг timerLever:Рычаг Бэкдор vinelever:Рычаг Лиан breaker:Рубильник anchor:Якорь waterpump:Вентиль wheel:Вентиль generator:Генератор
            wardrobe:Шкаф hidingspot:Шкаф hidingspot1:Шкаф hidingspot2:Шкаф hidingspot3:Шкаф hidingspot4:Шкаф hidingspot5:Шкаф hidingspot6:Шкаф hidingspot7:Шкаф hidingspot8:Шкаф
            key:Ключ keyelectrical:Электро Ключ keyretro:Ретро Ключ keyiron:Железный Ключ keybackdoor:Бэкдор Ключ keygarage:Ключ от Гаража skeletonkey:Скелетный Ключ
            lockpick:Отмычки shears:Ножницы multitool:Мультитул chestboxlocked:Закрытый Сундук
            fuse:Предохранитель generatorfuse:Предохранитель livebreakerpolepickup:Рубильник a60:A-60 a120:A-120 a160:A-160
            livehintbook:Книга hintbook:Книга libraryhintpaper:Лист с Кодом libraryhintpaperhard:Хардкорный Лист
            figure:Фигура grumble:Грамбл mandrake:Мандрагора groundskeeper:Смотритель monument:Монумент bramble:Брамбл
            rush:Раш ambush:Амбуш blitz:Блиц frozenambush:Фроз. Амбуш bash:Баш bush:Буш scribbles:Скриббл monster:Монстр
            player:Игрок eyes:Глаза lookman:Лукмен halt:Халт screech:Скрич seek:Сик giggle:Гиггл dread:Дред
            smoothie:Смузи riftsmoothie:Лунное Смузи donut:Пончик bread:Хлеб cheese:Сыр donut:Пончик pizza:Пицца peachcobbler:Персиковый Пирог gweensoda:Гвин Сода
            bandage:Бинт bandagepack:Пачка Бинтов battery:Батарейка batterypack:Пачка Батареек
            lighter:Зажигалка flashlight:Фонарик bulklight:Большой Фонарь shakelight:Динамо-Фонарь straplight:Налобный Фонарь lantern:Фонарь
            candle:Свеча riftcandle:Лунная Свеча glowstick:Глоустик glowsticks:Глоустик
            starjug:Банка Звездного Света starbottle:Бутыль Звездного Света starvial:Флакон Звездного Света riftjar:Банка Рифта
            laserpointer:Лазерная Указка alarmclock:Будильник gummyflashlight:Желейный Фонарик
            holygrenade:Святая Граната goldgun:Золотой Бластер knockbackstick:Админ Палка boxinggloves:Перчатки
            bomb:Бомба bigbomb:Большая Бомба knockbomb:Отталкивающая Бомба bigproptool:Бросаемый Предмет lightmachinegun:Пулемёт M249 m249:Пулемёт M249
            crucifix:Крест pocketmirror:Карманное Зеркало stopsign:Знак СТОП snakebox:Коробка со Змеей compass:Компас riftjar:Банка Рифта aloevera:Алоэ Вера
            nanner:Банан nannerpeel:Банановая Кожура paperplane:Бумажный Самолетик paperplanepickup:Бумажный Самолетик
            gold:Золото goldpile:Золото coinroll:Рулон Монет tipjar:Баночка Чаевых
            fihflakes:Корм для Рыб honeypot:Горшочек Меда lotuspetal:Лепесток Лотоса lotuspetalpickup:Лепесток Лотоса lotusholder:Лепесток Лотоса
            presents:Подарок present:Подарок archivesstoragebox:Коробка honchoCorrect:Верно honchoWrong:Неверно louie:Луи mousehole:Норка Мыши creak:Крик
            stairwellfirealarm:Пож. Сигнализация noisemodel:Нойс noise:Нойс shoppingcart:Тележка
        ]])
    }

    local LOCALIZATION = {
        English = {
            Tab_Esp = "ESP", Tab_Alerts = "ALERTS", Tab_Anti = "ANTI", Tab_Misc = "MISC", Tab_Fun = "FUN", Tab_Event = "EVENT", Tab_Settings = "SETTINGS",
            titleAlert = "ALERT", titleWarning = "WARNING", titleSuccess = "SUCCESS", titleInfo = "NOTIFICATION",
            espDoors = "Door ESP", espDupe = "Dupe ESP", itemsEsp = "Items ESP", chestHighlight = "Chest ESP", antiMonument = "Anti Monument",
            leverHighlight = "Lever ESP", timerLeverEsp = "Backdoor Lever", fuseEsp = "Fuse ESP", anchorEsp = "Anchor ESP",
            gpsPath = " Guide Path Seek (Mines chase 1)",
            antiSeekFlood = "Anti Seek Flood",
            distanceEsp = "Distance ESP (Meters)", espNames = "Show ESP Labels",
            a60Alert = "A-60 Alert",
            distanceEsp = "Distance ESP (Meters)", espNames = "Show ESP Labels", tracerEsp = "Tracer ESP",
            a120Alert = "A-120 Alert",
            msgA60 = "A-60 DETECTED!",
            msgA120 = "A-120 DETECTED!",
            autoRooms = "Auto Rooms (A-1000)",
            msgRoomsComplete = "ROOMS COMPLETED! (A-1000 REACHED)",
            mOpt_a60 = "A-60",
            mOpt_a120 = "A-120",
            mOpt_a160 = "A-160",
            bridgePatch = "Bridge Patcher",
            antiSeekObstacles = "Anti Seek Obstacles",
            grumbleEsp = "Grumble ESP", pumpEsp = "Valves ESP", keyHighlight = "Key ESP", wardrobeEsp = "Wardrobe ESP",
            liveHintBookEsp = "Book ESP", figureEsp = "Figure ESP", liveBreakerEsp = "Breaker ESP", mandrakeEsp = "Mandrake ESP",
            groundskeeperEsp = "Groundskeeper", monumentEsp = "Monument ESP", brambleEsp = "Bramble ESP", outdoorsLeverEsp = "Vine Lever",
            presentsEsp = "Presents ESP", generatorEsp = "Generator ESP", monsterEsp = "Monster ESP (Boxes)", playerEsp = "Player ESP",
            distanceEsp = "Distance ESP", tracerEsp = "Tracer ESP",
            honchoBoxEsp = "Honcho Storage & Deposit ESP", louieEsp = "Louie ESP",
            rushAlert = "Rush Alert", ambushAlert = "Ambush Alert", blitzAlert = "Blitz Alert",
            frozenAmbushAlert = "Frozen Ambush", surgeAlert = "Surge Alert", bashAlert = "Bash Alert", bushAlert = "Bush Alert", scribblesAlert = "Scribbles Alert", shiftAlert = "Nightshift Alert",
            antiDread = "Anti Dread", antiEyes = "Anti Eyes", antiLookman = "Anti Lookman",
            antiA90 = "Anti Ransom", antiDupe = "Anti Dupe", antiSnare = "Anti Snare", giggleRemoveHitbox = "Anti Giggle",
            screechRemover = "Anti Screech", noPaintRoomDoor = "No Paint Door", antiGloom = "Anti Gloom", antiHalt = "Anti Halt",
            antiDrone = "Anti Drone", antiJeff = "Anti Jeff", antiVacuum = "Anti Vacuum", antiCurrents = "Anti Currents",
            antiSurgeDamage = "Anti Surge", positionSpoof = "Anti Rush-like Monsters", antiAlma = "Anti Alma",
            antiScribbles = "Anti Scribbles", autoTellerTicket = "Auto Teller Ticket",
            infItems = "Infinite Items",
            giveRiftSmoothie = "Inf. Moonlight Float",
            giveStarBottle = "Inf. Starlight Bottle",
            msgItemGiven = "Item added to inventory!",
            sectionStats = "STATS & TIMERS",
            statOxygen = "Show Oxygen Level",
            statBackdoorTimer = "Show Backdoor Timer",
            noCamEffects = "No Camera Effects",
            noCamShake = "No Camera Shakes",
            tvStandEsp = "TV Stand ESP",
            scrapperEsp = "Scrapper ESP",
            statHonchoTimer = "Show Honcho Door Timer",
            reachEnabled = "Extended Reach", reachDistance = "Reach Distance",
            instantPrompt = "Instant Interact", fullbright = "Fullbright", fullbrightBrightness = "Fullbright Brightness", autoInteract = "Auto Interact", autoLoot = "Auto Loot", autoLootFilter = "Auto Loot Targets", antiLag = "FPS Boost",
            mOpt_gold = "Gold", mOpt_essential = "Essential (keys & switches)", mOpt_normal = "Normal (other)", mOpt_containers = "Lockers / Drawers / Chests",
            superFps = "Super FPS", speedEnabled = "Speedhack", speedValue = "Speed Power", fovValue = "Custom FOV", watermark = "Watermark",
            noclip = "NoClip (Phase)", autoPadlock = "Auto Padlock (Room 50)", msgPadlockPaper = "Don't forget to get a paper!",
            newYearMode = "New Year Mode", customLight = "Custom Light", lightR = "Red", lightG = "Green", lightB = "Blue",
            themeSection = "HUB THEME", themeToNormal = "Back to Normal Style", themeToHalloween = "🎃 Halloween Style",
            showWelcome = "Show Notification", jumpEnabled = "Enable Jump", jumpPowerValue = "Jump Power", holyGrenade = "Holy Grenade",
            trashBasket = "Trash Can", pipeMode = "Pipe Mode", pipeSoundEnabled = "Replace Sounds", pipeVolumeMult = "Pipe Volume",
            autoHide = "Auto Hide",
            autoBreakerLegit = "Auto Breaker 100 (Legit)", autoAnchor = "Auto Anchor Solver", autoHeartbeat = "Auto Heartbeat (Q/E)",
            glowstickEnabled = "Glowstick Control", glowstickOrbit = "Glowstick Orbit", glowstickSpeed = "Orbit Speed",
            glowstickRadius = "Orbit Distance", glowstickHeight = "Orbit Height", glowstickTapShoot = "Tap Screen to Shoot",
            musicLoop = "Loop Track", musicVolume = "Volume", btnLoad = "Load", btnDel = "Del", btnSave = "Save",
            thirdPerson = "Third Person View",
            thirdPersonDistance = "Camera Distance",
            slideEnabled = "Sliding Enabled",
            btnExport = "Export", btnImport = "Import",
            btnNoFog = "No Fog (Remove)", btnNoJammin = "No Jammin (Delete)",
            msgRush = "RUSH DETECTED!", msgAmbush = "AMBUSH DETECTED!", msgBlitz = "BLITZ DETECTED!",
            msgFrozenAmbush = "FROZEN AMBUSH DETECTED!", msgSurge = "⚡ SURGE / LIGHTNING INCOMING!", msgBash = "💥 BASH DETECTED!", msgBush = "🌿 BUSH DETECTED!", msgScribbles = "✏️ SCRIBBLES DETECTED!", msgA90Del = "✅ RANSOM BLOCKED & BYPASSED",
            msgNightshift = "⚠️ NIGHTSHIFT STARTED! BE CAREFUL!",
            msgHiding = "Monster Detected! Navigating to locker...", msgUnhiding = "Clear! Exiting locker...",
            msgAutoHideWait = "Danger incoming! Waiting near locker...", msgAutoHideEnter = "Monster within 100 studs! Hiding in locker...",
            msgAutoHideRebound = "Ambush rebound! Cycling locker to prevent kick...", msgAutoHideExit = "Monster passed! Exiting locker...",
            msgSpeedWarning = "⚠️ If Speed > 40: Rooms may load slowly & cause stucks!", msgAnchorSolved = "Anchor Solved & Lever Pulled!",
            msgRestored = "✅ Re-injected & settings restored!",
            langBtn = "Language: English", tipToggle = "Tip: Press %s to Toggle Menu",
            searchPlaceholder = "Search features...",
            menuKeyBtn = "Menu Keybind: ", pressAnyKey = "Press any key...",
            btnGetKey = "Get Key", btnPaste = "Paste", btnActivate = "Activate",
            keyPrompt = "Enter Key...", keyEmpty = "Please enter key!",
            keyInvalid = "Invalid Key!", keyNetErr = "Network error! Key not loaded",
            keyPasted = "Key pasted from clipboard!",
            msgLoaded = "Loaded: ", msgSaved = "Saved: ", msgDeleted = "Deleted: ",
            msgExported = "Config copied to clipboard!", msgImported = "Config imported successfully!",
            msgInvalidData = "Invalid config format in clipboard!",
            modalCloseTitle = "EXIT MENU",
            modalCloseDesc = "Are you sure you want to unload and close the interface?",
            modalBtnConfirm = "Exit", modalBtnCancel = "Cancel",
            chairManipulation = "Chair Manipulation", chairFlySpeed = "Chair fly speed", chairThrowForce = "Chair Throw Force",
            resizerActive = "Universal Resizer", resizerTool = "Resizer Tool", resizerScaleStep = "Resize Multiplier",
            spawnPotujnolit = "Spawn Potujnolit", despawnPotujnolit = "Despawn Potujnolit", antiNoise = "Anti Noise",
            btnSlamTV = "Slam TV (Manual)",
            noclipPhase = "NoClip Phase (Hold)",
            noclipUp = "NoClip Fly (Up)",
            noclipDown = "NoClip Fly (Down)",
            btnBringSalvage = "TP All Salvage (Junk)",
            msgSalvageBrought = "Salvage items brought: %d",
            msgNoSalvage = "No salvage items found!",
            msgTVSlammed = "TV knocked down!",
            msgTVNotFound = "TV_Stand not found!",
            fireAlarmEsp = "Fire Alarms ESP",
            cartEsp = "Shopping Carts ESP",
            creakBypass = "Creak Bypass (Look Spoof)",
            monsterFilter = "Monster Filter: Targets",
            dropSelectAll = "ALL",
            dropClearAll = "RESET",
            btnViewChangelog = "📋 View Changelog",
            mOpt_rush = "Rush", mOpt_ambush = "Ambush", mOpt_blitz = "Blitz", mOpt_frozenambush = "Frozen Ambush",
            mOpt_figure = "Figure", mOpt_seek = "Seek", mOpt_grumble = "Grumble", mOpt_eyes = "Eyes",
            mOpt_lookman = "Lookman", mOpt_halt = "Halt", mOpt_screech = "Screech", mOpt_giggle = "Giggle",
            mOpt_dread = "Dread", mOpt_groundskeeper = "Groundskeeper", mOpt_bash = "Bash", mOpt_bush = "Bush",
            mOpt_scribbles = "Scribbles", mOpt_teller = "Teller", mOpt_jeff = "Jeff The Killer", mOpt_creak = "Creak", mOpt_noise = "Noise", mOpt_bramble = "Bramble",
            mOpt_mandrake = "Mandrake",
            mOpt_monument = "Monument",
            mOpt_louie = "Louie"
        },
        Russian = {
            Tab_Esp = "ЕСП", Tab_Alerts = "АЛЕРТЫ", Tab_Anti = "АНТИ", Tab_Misc = "РАЗНОЕ", Tab_Fun = "ВЕСЕЛЬЕ", Tab_Event = "ИВЕНТ", Tab_Settings = "НАСТРОЙКИ",
            titleAlert = "ТРЕВОГА", titleWarning = "ВНИМАНИЕ", titleSuccess = "УСПЕХ", titleInfo = "ИНФОРМАЦИЯ",
            espDoors = "ЕСП Дверей", espDupe = "ЕСП Фейк Дверей", itemsEsp = "ЕСП Предметов", chestHighlight = "ЕСП Сундуков",
            leverHighlight = "ЕСП Рычагов", timerLeverEsp = "Рычаг Бэкдор", fuseEsp = "ЕСП Предохранителей", anchorEsp = "ЕСП Якорей",
            grumbleEsp = "ЕСП Грамбла", pumpEsp = "ЕСП Вентилей", keyHighlight = "ЕСП Ключей", wardrobeEsp = "ЕСП Шкафов",
            liveHintBookEsp = "ЕСП Книг", figureEsp = "ЕСП Фигуры", liveBreakerEsp = "ЕСП Рубильников", mandrakeEsp = "ЕСП Мандрагоры",
            groundskeeperEsp = "ЕСП Смотрителя", monumentEsp = "ЕСП Монументов", brambleEsp = "ЕСП Брамбла", outdoorsLeverEsp = "Рычаг Лиан",
            presentsEsp = "ЕСП Подарков", generatorEsp = "ЕСП Генераторов", monsterEsp = "ЕСП Монстров (Коробки)", playerEsp = "ЕСП Игроков (Yellow)",
            distanceEsp = "Дистанция ESP", tracerEsp = "Трейсеры ESP", gpsPath = "GPS Линия Пути",
            bridgePatch = "Авто-Мост",
            a60Alert = "Алерт A-60",
            distanceEsp = "Дистанция ESP (Метры)", espNames = "Надписи ESP (Текст)",
            a120Alert = "Алерт A-120",
            msgA60 = "A-60 ОБНАРУЖЕН!",
            msgA120 = "A-120 ОБНАРУЖЕН!",
            autoRooms = "Авто Rooms (A-1000)",
            msgRoomsComplete = "ROOMS ПРОЙДЕНЫ! (A-1000 ДОСТИГНУТ)",
            antiSeekFlood = "Анти-Жижа Сика (200 дверь)",
            mOpt_a60 = "A-60",
            mOpt_a120 = "A-120",
            mOpt_a160 = "A-160",
            honchoBoxEsp = "ЕСП Коробок и Приемников Хончо", louieEsp = "ЕСП Луи (Норка)",
            rushAlert = "Предупреждение Раша", ambushAlert = "Предупреждение Амбуша", blitzAlert = "Предупреждение Блица",
            frozenAmbushAlert = "Алерт Фроз. Амбуш", surgeAlert = "Алерт Всплеска (Surge)", bashAlert = "Предупреждение Баша", bushAlert = "Предупреждение Буша", scribblesAlert = "Предупреждение Скрибблса", shiftAlert = "Алерт Ночной Смены",
            antiDread = "Анти Дред", antiEyes = "Анти Глаза", antiLookman = "Анти Лукмен",
            antiA90 = "Анти Рансом", antiDupe = "Анти Дюп", antiSnare = "Анти Снейр", giggleRemoveHitbox = "Анти Гиггл", antiMonument = "Анти Монумент",
            screechRemover = "Анти Скрич", noPaintRoomDoor = "Убрать дверь с картинами", antiGloom = "Анти Глумбеты", antiHalt = "Анти Халт",
            antiDrone = "Анти Дрон", antiJeff = "Анти Джефф", antiVacuum = "Анти Вакуум", antiCurrents = "Анти Электролужи",
            antiSurgeDamage = "Анти Всплеск", positionSpoof = "Анти Рашоподобные Монстры", antiAlma = "Анти Алма",
            antiScribbles = "Анти Скрибблс", autoTellerTicket = "Авто Билет Теллера",
            thirdPerson = "Вид от 3-го лица",
            thirdPersonDistance = "Дистанция камеры",
            slideEnabled = "Слайдинг (Скольжение)",
            antiSeekObstacles = "Анти-Препятствия Сика",
            sectionStats = "СТАТИСТИКА И ТАЙМЕРЫ",
            statOxygen = "Уровень кислорода (Oxygen)",
            statBackdoorTimer = "Таймер Бэкдора (Haste)",
            statHonchoTimer = "Таймер Хончо (Взлом двери)",
            infItems = "Бесконечные Предметы",
            giveRiftSmoothie = "Беск. Лунный Коктейль",
            giveStarBottle = "Беск. Бутылка Света",
            noCamEffects = "Без эффектов камеры",
            noCamShake = "Без тряски камеры",
            tvStandEsp = "ЕСП ТВ Стойки",
            scrapperEsp = "ЕСП Утилизатора",
            msgItemGiven = "Предмет выдан в инвентарь!",
            reachEnabled = "Дальность взаимодействия", reachDistance = "Дистанция захвата",
            instantPrompt = "Мгновенное Взаимод.", fullbright = "Свечение", fullbrightBrightness = "Яркость свечения", autoInteract = "Авто Взаимодействие", autoLoot = "Авто Сбор Лута", autoLootFilter = "Цели Авто-Лута", antiLag = "ФПС Буст",
            mOpt_gold = "Золото", mOpt_essential = "Необходимые (ключи и переключатели)", mOpt_normal = "Обычные (остальные)", mOpt_containers = "Шкафчики (тумбочки, сундуки)",
            superFps = "Супер ФПС", speedEnabled = "Спидхак", speedValue = "Мощность Скорости", fovValue = "Угол Обзора (FOV)", watermark = "Водяной Знак",
            noclip = "Ноуклип (Фазинг)", autoPadlock = "Авто Падлок (Комн. 50)", msgPadlockPaper = "Не забудьте взять лист с кодом!",
            newYearMode = "Новый Год", customLight = "Свой Свет", lightR = "Красный", lightG = "Зеленый", lightB = "Синий",
            themeSection = "ТЕМА ХАБА", themeToNormal = "Вернуть обычный стиль", themeToHalloween = "🎃 Хэллоуинский стиль",
            showWelcome = "Показать уведомление", jumpEnabled = "Включить Прыжок", jumpPowerValue = "Высота Прыжка", holyGrenade = "Святая Граната",
            trashBasket = "Мусорное Ведро", pipeMode = "Режим Трубы", pipeSoundEnabled = "Замена Звуков", pipeVolumeMult = "Громкость Труб",
            autoHide = "Авто Прятанье",
            autoBreakerLegit = "Авто Щиток 100 (Легит)", autoAnchor = "Авто Якоря 150", autoHeartbeat = "Авто Сердцебиение (Q/E)",
            glowstickEnabled = "Контроль Глоустиков", glowstickOrbit = "Орбита Глоустиков", glowstickSpeed = "Скорость Орбиты",
            glowstickRadius = "Радиус Орбиты", glowstickHeight = "Высота Орбиты", glowstickTapShoot = "Стрельба Тапом",
            musicLoop = "Зациклить трек", musicVolume = "Громкость", btnLoad = "Загр", btnDel = "Удал", btnSave = "Сохр",
            btnExport = "Экспорт", btnImport = "Импорт",
            btnNoFog = "Убрать Туман", btnNoJammin = "Удалить Jammin",
            msgRush = "РАШ ЛЕТИТ!", msgAmbush = "АМБУШ ЛЕТИТ!", msgBlitz = "БЛИЦ ЛЕТИТ!",
            msgFrozenAmbush = "FROZEN AMBUSH ОБНАРУЖЕН!", msgSurge = "⚡ ВСПЛЕСК / МОЛНИЯ (SURGE)!", msgBash = "💥 БАШ ЛЕТИТ!", msgBush = "🌿 БУШ ЛЕТИТ!", msgScribbles = "✏️ СКРИББЛС ЛЕТИТ!", msgA90Del = "✅ РАНСОМ ЗАБЛОКИРОВАН",
            msgNightshift = "⚠️ НАЧАЛАСЬ НОЧНАЯ СМЕНА В АРХИВАХ!",
            msgHiding = "Монстр обнаружен! Идем в шкаф в обход стен...", msgUnhiding = "Чисто! Выходим из шкафа...",
            msgAutoHideWait = "Монстр летит! Встаем перед свободным шкафом...", msgAutoHideEnter = "Монстр ближе 100 студов! Залезаем...",
            msgAutoHideRebound = "Амбуш разворачивается! Перезаходим в шкаф...", msgAutoHideExit = "Монстр пролетел! Вылезаем из шкафа...",
            msgSpeedWarning = "⚠️ Если Скорость > 40: Комнаты могут не успевать грузиться (застревания)!", msgAnchorSolved = "Код введен и рычаг нажат!",
            msgRestored = "✅ Скрипт перезапущен и функции восстановлены!",
            langBtn = "Язык: Русский", tipToggle = "Подсказка: Нажми %s для меню",
            searchPlaceholder = "Поиск функций...",
            menuKeyBtn = "Клавиша Меню: ", pressAnyKey = "Нажмите клавишу...",
            btnGetKey = "Получить", btnPaste = "Вставить", btnActivate = "Войти",
            keyPrompt = "Введите ключ...", keyEmpty = "Введите ключ!",
            keyInvalid = "Неверный ключ!", keyNetErr = "Ошибка сети! Ключ не получен",
            keyPasted = "Ключ вставлен из буфера!",
            msgLoaded = "Loaded: ", msgSaved = "Saved: ", msgDeleted = "Deleted: ",
            msgExported = "Конфиг скопирован в буфер!", msgImported = "Конфиг успешно импортирован!",
            msgInvalidData = "Неверный формат конфига в буфере!",
            modalCloseTitle = "ЗАКРЫТЬ МЕНЮ?",
            modalCloseDesc = "Вы уверены, что хотите полностью выгрузить и закрыть интерфейс?",
            noclipPhase = "Ноуклип Фазинг (Зажатие)",
            noclipUp = "Ноуклип Полет (Вверх)",
            noclipDown = "Ноуклип Полет (Вниз)",
            modalBtnConfirm = "Выйти", modalBtnCancel = "Отмена",
            chairManipulation = "Манипуляция Стульями", chairFlySpeed = "Скорость полета стула", chairThrowForce = "Сила броска стула",
            resizerActive = "Универсальный Ресайзер", resizerTool = "Инструмент Ресайзера", resizerScaleStep = "Шаг Масштабирования",
            spawnPotujnolit = "Заспавнить Потужноліт", despawnPotujnolit = "Убрать Потужноліт", antiNoise = "Анти Нойс",
            btnSlamTV = "Опрокинуть ТВ (Вручную)",
            msgTVSlammed = "Телевизор опрокинут!",
            btnBringSalvage = "Притянуть весь мусор",
            msgSalvageBrought = "Притянуто предметов: %d шт.",
            msgNoSalvage = "Мусор/вещи депозита не найдены!",
            msgTVNotFound = "TV_Stand не найден!", fireAlarmEsp = "ЕСП Сигнализаций",
            cartEsp = "ЕСП Тележек",
            creakBypass = "Creak Обход (Спуф взгляда)",
            monsterFilter = "Фильтр монстров: Выбор целей",
            dropSelectAll = "ВСЕ",
            dropClearAll = "СБРОС",
            btnViewChangelog = "📋 Посмотреть Ченджлог",
            mOpt_rush = "Раш", mOpt_ambush = "Амбуш", mOpt_blitz = "Блиц", mOpt_frozenambush = "Фроз. Амбуш",
            mOpt_figure = "Фигура", mOpt_seek = "Сик", mOpt_grumble = "Грамбл", mOpt_eyes = "Глаза",
            mOpt_lookman = "Лукмен", mOpt_halt = "Халт", mOpt_screech = "Скрич", mOpt_giggle = "Гиггл",
            mOpt_dread = "Дред", mOpt_groundskeeper = "Смотритель", mOpt_bash = "Баш", mOpt_bush = "Буш",
            mOpt_scribbles = "Скрибблс", mOpt_teller = "Теллер", mOpt_jeff = "Джефф Убийца", mOpt_creak = "Крик", mOpt_noise = "Нойс", mOpt_bramble = "Брамбл",
            mOpt_mandrake = "Мандрагора",
            mOpt_monument = "Монумент",
            mOpt_louie = "Луи (Норка)"
        }
    }

    local STRICT_FURNITURE_BLACKLIST = parseStrMap("bookcase bookshelf shelf shelves table dresser drawercontainer drawer desk desk_bell desk_lampstart lightstand fireplace fireplace_logs luggage_cart_crouch window chandelier starterelevator elevator riftspawn wall_clock door doornormal chestboxlocked sideroom28 sideroom30 sideroom chestbox wardrobe rooms_locker toolshed largelocker locker_large locker_small locker_small_locked toolbox toolbox_locked sideroomdupe movingdoor snare gloompile minesgenerator windowtobreak lightfixture neon parts assets alternate light_fixtures hitbox main knobs knob handle canvas surfacegui currentrooms room bed pillar column carpet rug curtain oldwoodentable dresser_single ladder grabpart circularvent grate stonebase archivescubicleleft archivescubicleright archiveswaitingseats principalchair archivesterminal archivescoffeemachine archiveslargeprinter vendor_shakelightvendingmachine archivesofficechair archivesclock archivesdesk archivesdesk-honcho archivesdesk-curved archiveskeyboard archivestrashcan archivesfloordecor concrete monitor screen teller terminal sector coffee printer sugar creamer milk archiveshanddryer handdryer dryer archiveslamp lamp archiveswatercooler watercooler cooler archiveslocketbroken archiveslockerbroken brokenlocker brokenlocket painting_tall painting_small painting_verybig regal_chair blockeddoor blockeddoormodel leafwall symbol model collisionpart avoidpart promptblocker holder itemspawn lootholder floorlootitem loot spawnpile woodwall archivesportalinterior archivesportal elevator archivesfihfih fihfih tank archivesfihtank chair officechair seat givetakeprompt")

    local STRICT_FURNITURE_KEYWORDS = {
        "room", "assets", "parts", "geometry", "desk", "drawer", "table", "chair",
        "seat", "wardrobe", "locker", "hidingspot", "door", "wall", "light", "pillar",
        "printer", "cooler", "trashcan", "terminal", "coffee", "keyboard", "stand",
        "screen", "avoid", "blocker", "concrete", "leafwall", "teller", "stem"
    }

    local STRICT_ITEM_NAMES = parseStrMap([[
        keyobtain:key key:key keyelectrical:key keyretro:key keyiron:key keybackdoor:key keygarage:key
        skeletonkey:skeletonkey lockpick:lockpick shears:shears multitool:multitool
        fuseobtain:fuse fuse:fuse generatorfuse:fuse livebreakerpolepickup:breaker breaker:breaker
        livehintbook:livehintbook hintbook:livehintbook libraryhintpaper:item libraryhintpaperhard:item
        mandrakelive:mandrake mandrake:mandrake
        glowsticklive:glowstick glowsticks:glowstick glowstick:glowstick
        smoothie:smoothie riftsmoothie:riftsmoothie donut:donut bread:bread cheese:cheese pizza:pizza peachcobbler:peachcobbler gweensoda:gweensoda
        bandage:bandage bandagepack:bandagepack battery:battery batterypack:batterypack
        lighter:lighter flashlight:flashlight bulklight:bulklight shakelight:shakelight straplight:straplight lantern:lantern
        candle:candle candlelive:candle candlewall:candle riftcandle:riftcandle possessedcandle:candle
        starjug:starjug starbottle:starbottle starvial:starvial riftjar:riftjar
        laserpointer:laserpointer alarmclock:alarmclock gummyflashlight:gummyflashlight
        holygrenade:holygrenade goldgun:goldgun knockbackstick:knockbackstick boxinggloves:boxinggloves
        bomb:bomb bigbomb:bigbomb knockbomb:knockbomb bigproptool:item lightmachinegun:item m249:item
        crucifix:crucifix pocketmirror:pocketmirror stopsign:item snakebox:item compass:item aloevera:item
        nanner:item nannerpeel:item paperplane:paperplane paperplanepickup:paperplane
        gold:gold goldpile:gold coinroll:coinroll tipjar:item
        fihflakes:fihflakes fihflake:fihflakes honeypot:honeypot
        lotuspetal:lotuspetal lotuspetalpickup:lotuspetal lotusholder:lotuspetal
        cringlepresent:present present:present archivesstoragebox:archivesstoragebox
    ]])

    -- Необходимые предметы для авто-лута: ключи, отмычки и переключатели/рычаги
    local ESSENTIAL_ITEM_KEYS = {
        key = true, skeletonkey = true, lockpick = true, shears = true, multitool = true,
        fuse = true, breaker = true, lever = true, switch = true
    }

    local ESSENTIAL_LOOT_WORDS = {
        "key", "ключ", "skeleton", "скелет", "lockpick", "отмыч", "multitool", "shears",
        "fuse", "предохранит", "breaker", "рубильник", "lever", "рычаг",
        "switch", "переключател", "тумблер"
    }

    local function isEssentialLootType(ot, act, pModelName, pParentName, pPromptName)
        local sources = {ot, act, pModelName, pParentName, pPromptName}
        for _, src in ipairs(sources) do
            if src and src ~= "" then
                local mappedKey = STRICT_ITEM_NAMES[src]
                if mappedKey and ESSENTIAL_ITEM_KEYS[mappedKey] then
                    return true
                end
                for _, word in ipairs(ESSENTIAL_LOOT_WORDS) do
                    if src:find(word, 1, true) then
                        return true
                    end
                end
            end
        end
        return false
    end

    local ESP_TARGETS = {
        ["ChestBox"] = {state="chestHighlight", col="chest"},
        ["Chest_Vine"] = {state="chestHighlight", col="chest"},
        ["StairwellFireAlarm"] = {state="fireAlarmEsp", col="fireAlarm"},
        ["ShoppingCart"] = {state="cartEsp", col="cart"},
        ["ChestVine"] = {state="chestHighlight", col="chest"},
        ["ChestBoxLocked"] = {state="chestHighlight", col="chest"},
        ["TV_Stand"] = {state="tvStandEsp", col="tvStand"},
        ["StairwellScrapper"] = {state="scrapperEsp", col="scrapper"},
        ["DepotHalloween"] = {state="scrapperEsp", col="scrapper"},
        ["LeverForGate"] = {state="leverHighlight", col="lever"},
        ["TimerLever"] = {state="timerLeverEsp", col="timerLever"},
        ["Smoothie"] = {state="itemsEsp", col="smoothie"},
        ["KeyObtain"] = {state="keyHighlight", col="key"},
        ["LiveHintBook"] = {state="liveHintBookEsp", col="liveHintBook"},
        ["FigureRig"] = {state="figureEsp", col="figure", monsterKey="figure"},
        ["LiveBreakerPolePickup"] = {state="liveBreakerEsp", col="lever"},
        ["FuseObtain"] = {state="fuseEsp", col="fuse"},
        ["MinesAnchor"] = {state="anchorEsp", col="anchor"},
        ["Grumbo"] = {state="grumbleEsp", col="grumble", monsterKey="grumble"},
        ["GrumbleRig"] = {state="grumbleEsp", col="grumble", monsterKey="grumble"},
        ["MandrakeLive"] = {state="mandrakeEsp", col="mandrake", monsterKey="mandrake"},
        ["Groundskeeper"] = {state="groundskeeperEsp", col="groundskeeper", monsterKey="groundskeeper"},
        ["MonumentEntity"] = {state="monumentEsp", col="monument", monsterKey="monument"},
        ["LiveEntityBramble"] = {state="brambleEsp", col="bramble", monsterKey="bramble"},
        ["MinesGenerator"] = {state="generatorEsp", col="generator"},
        ["MouseHole"] = {state="louieEsp", col="louie", monsterKey="louie"},
        ["LotusPetalPickup"] = {state="itemsEsp", col="lotuspetal"},
        ["LotusHolder"] = {state="itemsEsp", col="lotuspetal"},
        ["Snare"] = {anti="antiSnare"},
        ["GloomPile"] = {anti="antiGloom"},
        ["MovingDoor"] = {anti="noPaintRoomDoor"}
    }

    local ALERT_NAMES = {
        ["RushMoving"] = {st="rushAlert", msg="msgRush"},
        ["AmbushMoving"] = {st="ambushAlert", msg="msgAmbush"},
        ["BackdoorRush"] = {st="blitzAlert", msg="msgBlitz"},
        ["FrozenAmbush"] = {st="frozenAmbushAlert", msg="msgFrozenAmbush"},
        ["BashMoving"] = {st="bashAlert", msg="msgBash"},
        ["A60"] = {st="a60Alert", msg="msgA60"},
        ["A-60"] = {st="a60Alert", msg="msgA60"},
        ["A120"] = {st="a120Alert", msg="msgA120"},
        ["A-120"] = {st="a120Alert", msg="msgA120"},
        ["A160"] = {st="a120Alert", msg="msgA120"},
        ["A-160"] = {st="a120Alert", msg="msgA120"},
        ["Bash"] = {st="bashAlert", msg="msgBash"},
        ["BushMoving"] = {st="bushAlert", msg="msgBush"},
        ["Bush"] = {st="bushAlert", msg="msgBush"},
        ["BushEntity"] = {st="bushAlert", msg="msgBush"},
        ["ScribblesMoving"] = {st="scribblesAlert", msg="msgScribbles"},
        ["ScribbleMoving"] = {st="scribblesAlert", msg="msgScribbles"},
        ["Scribbles"] = {st="scribblesAlert", msg="msgScribbles"}
    }

    local objectRoomMap = setmetatable({}, {__mode = "k"})

    local function getText(key)
        local lang = states.language or "Russian"
        return (LOCALIZATION[lang] and LOCALIZATION[lang][key]) or (LOCALIZATION.Russian and LOCALIZATION.Russian[key]) or key
    end

    local function getEspLocalizedName(typeName, itemKey, rawCustomLabel)
        local lang = states.language or "Russian"
        local lDict = ESP_DICTIONARY[lang] or ESP_DICTIONARY.Russian or {}
        local eDict = ESP_DICTIONARY.English or {}
        local baseName = nil

        if itemKey then
            local k = tostring(itemKey):lower()
            if lDict[k] then baseName = lDict[k] elseif eDict[k] then baseName = eDict[k] end
        end
        if not baseName and typeName then
            local t = tostring(typeName):lower()
            if lDict[t] then baseName = lDict[t] elseif eDict[t] then baseName = eDict[t] end
        end
        if not baseName and rawCustomLabel then
            local r = tostring(rawCustomLabel):lower()
            if lDict[r] then baseName = lDict[r] elseif eDict[r] then baseName = eDict[r] end
        end
        if not baseName and ((itemKey and tostring(itemKey):lower():find("hidingspot")) or (typeName and tostring(typeName):lower():find("hidingspot")) or (rawCustomLabel and tostring(rawCustomLabel):lower():find("hidingspot"))) then
            baseName = lDict["wardrobe"] or eDict["wardrobe"] or "Шкаф"
        end
        baseName = baseName or rawCustomLabel or typeName or "Item"

        -- Подстановка номера двери цифрой: Door 101 / Дверь 101
        if (typeName == "door" or typeName == "dupe") and rawCustomLabel and rawCustomLabel ~= "" then
            return baseName .. " " .. tostring(rawCustomLabel)
        end

        -- Подстановка буквы якоря: Anchor [E] / Якорь [E]
        if typeName == "anchor" and rawCustomLabel and rawCustomLabel ~= "" and rawCustomLabel ~= "anchor" then
            return baseName .. " [" .. tostring(rawCustomLabel) .. "]"
        end

        return baseName
    end

    local function isInsideJeffShop(obj)
        if not obj then return false end
        local cur = obj
        local ws = G.Services.Workspace
        while cur and cur ~= ws do
            local n = tostring(cur.Name):lower()
            if n:find("jeffshop") or (n:find("jeff") and n:find("shop")) then
                return true
            end
            cur = cur.Parent
        end
        return false
    end

    local function isValidPickupItem(obj)
        if not obj or not obj.Parent then return false end
        local ws = G.Services.Workspace
        if obj == ws or obj == ws:FindFirstChild("CurrentRooms") then return false end

        -- Игнорируем любые предметы, находящиеся внутри Jeffshop_Hotel
        if isInsideJeffShop(obj) then return false end
        
        if obj.Parent == ws:FindFirstChild("CurrentRooms") or tonumber(obj.Name) ~= nil then
            return false
        end

        local name = tostring(obj.Name):lower()
        if STRICT_FURNITURE_BLACKLIST[name] then return false end

        for i = 1, #STRICT_FURNITURE_KEYWORDS do
            if string.find(name, STRICT_FURNITURE_KEYWORDS[i], 1, true) then
                return false
            end
        end

        if obj:IsA("Model") then
            if #obj:GetChildren() > 20 then return false end
            local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if pp and (pp.Size.X > 6 or pp.Size.Y > 6 or pp.Size.Z > 6) then
                return false
            end
        elseif obj:IsA("BasePart") then
            if obj.Size.X > 5.5 or obj.Size.Y > 5.5 or obj.Size.Z > 5.5 or obj.Size.Magnitude < 0.1 then
                return false
            end
        end

        if STRICT_ITEM_NAMES[name] then
            return true, STRICT_ITEM_NAMES[name], obj, obj.Name
        end

        if obj:IsA("Tool") then
            if obj:GetAttribute("TicketID") then return false end
            local itemKey = STRICT_ITEM_NAMES[name] or "item"
            return true, itemKey, obj, obj.Name
        end

        if obj:FindFirstChild("PickedUpEvent") then
            local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
            local ot = prompt and prompt.ObjectText or obj.Name
            local itemKey = STRICT_ITEM_NAMES[name] or STRICT_ITEM_NAMES[ot:lower()] or "item"
            return true, itemKey, obj, (prompt and prompt.ObjectText ~= "" and prompt.ObjectText) or obj.Name
        end

        if name == "goldpile" or name == "gold" then
            return true, "gold", obj, "Gold"
        end

        local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt") 
            or (obj:IsA("Model") and obj:FindFirstChildWhichIsA("ProximityPrompt", true))
            
        if prompt then
            local pName = prompt.Name:lower()
            local act = (prompt.ActionText or ""):lower()
            local ot = (prompt.ObjectText or ""):lower()

            if pName == "givetakeprompt" or pName == "activateeventprompt" or pName == "interactprompt" or pName == "hideprompt" 
            or pName == "seatprompt" or pName == "manualopenprompt" or pName == "trashcanprompt" 
            or pName == "lidprompt" or pName == "entryprompt" or act == "sit" or pName:find("stem") or ot:find("stem") then
                return false
            end

            local isItemPrompt = (pName == "moduleprompt" or pName == "lootprompt" or pName == "itemprompt" 
                or pName == "itemholderprompt" or pName == "portraitdupeprompt"
                or act == "obtain" or act == "collect" or act == "take" or act == "grab" or act == "pick up")

            if isItemPrompt or STRICT_ITEM_NAMES[ot] then
                local itemKey = STRICT_ITEM_NAMES[name] or STRICT_ITEM_NAMES[ot] or "item"
                return true, itemKey, obj, (prompt.ObjectText ~= "" and prompt.ObjectText) or obj.Name
            end
        end

        return false
    end

    -- === ВСПОМОГАТЕЛЬНЫЕ UI ФУНКЦИИ ===
    local function create(className, properties, children)
        local obj = Instance.new(className)
        for k, v in pairs(properties or {}) do obj[k] = v end
        if children then for _, child in ipairs(children) do child.Parent = obj end end
        return obj
    end

    local function cCorner(r, p) return create("UICorner", {CornerRadius = G.Math.ud(0, r or 8), Parent = p}) end
    local function cStroke(c, t, p) return create("UIStroke", {Color = c or G.Math.rgb(55, 55, 65), Thickness = t or 1, Parent = p}) end
    local function cTextConstraint(minS, maxS, p)
        return create("UITextSizeConstraint", {
            MinTextSize = minS or 8,
            MaxTextSize = maxS or 11,
            Parent = p
        })
    end

    local function getGuiParent()
        local s, h = pcall(function() return gethui and gethui() end)
        if s and h and typeof(h) == "Instance" then return h end
        local s2, cg = pcall(function() return game:GetService("CoreGui") end)
        if s2 and cg then
            local canCore = pcall(function()
                local t = Instance.new("Folder")
                t.Parent = cg
                t:Destroy()
            end)
            if canCore then return cg end
        end
        local pGui = PlayerGui or player:FindFirstChild("PlayerGui")
        if not pGui then
            local t0 = tick()
            repeat
                task.wait(0.1)
                pGui = player:FindFirstChild("PlayerGui")
            until pGui or (tick() - t0 > 15)
        end
        return pGui or player:WaitForChild("PlayerGui", 10) or player:FindFirstChild("PlayerGui")
    end

    -- Очистка старых GUI окон
    pcall(function()
        local p = getGuiParent()
        if p then
            local old = p:FindFirstChild("HubHubHubUI_BW_Main")
            if old then old:Destroy() end
            local oldNotif = p:FindFirstChild("HubNotifications_Monochrome")
            if oldNotif then oldNotif:Destroy() end
            local oldClean = p:FindFirstChild("CleanHub_BW_Main")
            if oldClean then oldClean:Destroy() end
        end
    end)

    local cachedDataPingStat = nil
    local function getRealPing()
        local ping = 0
        pcall(function()
            if not cachedDataPingStat then
                local net = G.Services.Stats and G.Services.Stats:FindFirstChild("Network")
                local ssi = net and net:FindFirstChild("ServerStatsItem")
                cachedDataPingStat = ssi and ssi:FindFirstChild("Data Ping")
            end
            if cachedDataPingStat and cachedDataPingStat.GetValue then
                ping = G.Math.floor(cachedDataPingStat:GetValue())
            end
        end)
        if ping <= 0 then
            pcall(function()
                if player and player.GetNetworkPing then
                    local p = player:GetNetworkPing()
                    if p then ping = G.Math.floor(p * 1000) end
                end
            end)
        end
        return math.max(1, ping)
    end

    local function getPromptWorldPosition(prompt)
        if not prompt or not prompt.Parent then return nil end
        local p = prompt.Parent
        if p:IsA("Attachment") then return p.WorldPosition end
        if p:IsA("BasePart") then return p.Position end
        if p:IsA("Model") then return getPivotPos(p) end
        local ancestorPart = prompt:FindFirstAncestorWhichIsA("BasePart")
        if ancestorPart then return ancestorPart.Position end
        local ancestorModel = prompt:FindFirstAncestorWhichIsA("Model")
        if ancestorModel then return getPivotPos(ancestorModel) end
        return nil
    end

    local _activeTriggeringPrompts = setmetatable({}, {__mode = "k"})

    local function triggerPromptInstance(prompt, forceTrigger)
        if not prompt or not prompt.Parent then return end
        if not forceTrigger and not prompt.Enabled then return end
        if prompt:GetAttribute("_ServerEnabled") == false then return end

        local now = tick()
        local isInstant = (states and states.instantPrompt) or (prompt.HoldDuration <= 0)
        local cd = isInstant and 0.08 or math.max(0.25, (prompt.HoldDuration or 0) + 0.05)
        if not forceTrigger and _activeTriggeringPrompts[prompt] and (now - _activeTriggeringPrompts[prompt] < cd) then
            return
        end
        _activeTriggeringPrompts[prompt] = now

        -- Убираем клиентский тег одноразового отключения, чтобы промпт замка не пропадал при отказе сервера
        pcall(function()
            if G.Services.CollectionService:HasTag(prompt, "DisableWhenEnabledOnClient") then
                G.Services.CollectionService:RemoveTag(prompt, "DisableWhenEnabledOnClient")
            end
        end)

        task.spawn(function()
            pcall(function()
                if forceTrigger and not prompt.Enabled then
                    prompt.Enabled = true
                end
                if fireproximityprompt then
                    local holdTime = (states and states.instantPrompt) and 0 or (prompt.HoldDuration or 0)
                    fireproximityprompt(prompt, holdTime, true)
                else
                    prompt:InputHoldBegin()
                    local holdTime = (states and states.instantPrompt) and 0.01 or math.max(0.03, prompt.HoldDuration or 0.03)
                    task.wait(holdTime)
                    prompt:InputHoldEnd()
                end
            end)
        end)
    end

    -- ====================================================================
    -- [ФИКС №1] ЛЕГКИЙ SMART FADE (Твинит только окно, без тысяч потомков)
    -- ====================================================================
    local function setSmartFade(targetFrame, isFading)
        if not targetFrame then return end
        local tweenInfo = G.Math.tw(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local targetTrans = isFading and 0.25 or 0

        pcall(function()
            G.Services.TweenService:Create(targetFrame, tweenInfo, {BackgroundTransparency = targetTrans}):Play()
            local sidebar = targetFrame:FindFirstChild("Sidebar")
            if sidebar then
                G.Services.TweenService:Create(sidebar, tweenInfo, {BackgroundTransparency = isFading and 0.35 or 0}):Play()
            end
            local backdrop = targetFrame:FindFirstChild("ContentBackdrop")
            if backdrop then
                G.Services.TweenService:Create(backdrop, tweenInfo, {BackgroundTransparency = isFading and 0.30 or 0}):Play()
            end
        end)
    end

    -- Адаптивный Drag & Drop (мышь и мультитач на мобильных)
    local function makeDraggable(gui, target)
        target = target or gui
        local dragging, dragInput, dragStart, startPos
        
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = target.Position
                setSmartFade(target, true)
            end
        end)
        
        G.Services.UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    dragging = false
                    setSmartFade(target, false)
                end
            end 
        end)
        
        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        G.Services.UserInputService.InputChanged:Connect(function(input)
            if dragging and input == dragInput then
                local delta = input.Position - dragStart
                target.Position = G.Math.ud2(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    -- ====================================================================
    --                  СИСТЕМА УВЕДОМЛЕНИЙ (TOASTS)
    -- ====================================================================
    local NotificationGui = create("ScreenGui", {
        Name = "HubNotifications_Monochrome",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = getGuiParent()
    })

    -- ====================================================================
    --   ПАЛИТРЫ ХАБА: обычная (монохром) и хэллоуинская (тыква + фиолет)
    --   HW — "живая" палитра: при смене темы значения подменяются,
    --   а уже созданные элементы плавно перекрашиваются в S.setTheme
    -- ====================================================================
    local PALETTES = {
        normal = {
            BG          = G.Math.rgb(14, 14, 18),
            BG_BOTTOM   = G.Math.rgb(14, 14, 18),
            PANEL       = G.Math.rgb(22, 22, 28),
            PANEL_2     = G.Math.rgb(32, 32, 40),
            STROKE      = G.Math.rgb(50, 50, 60),
            STROKE_DIM  = G.Math.rgb(42, 42, 52),
            ORANGE      = G.Math.rgb(240, 240, 250),
            ORANGE_SOFT = G.Math.rgb(235, 235, 245),
            ORANGE_DIM  = G.Math.rgb(120, 120, 135),
            PURPLE      = G.Math.rgb(150, 150, 165),
            TEXT        = G.Math.rgb(255, 255, 255),
            TEXT_DIM    = G.Math.rgb(200, 200, 215),
            TINT        = G.Math.rgb(45, 45, 58),
            TRACK_OFF   = G.Math.rgb(40, 40, 50),
            ON_DOT      = G.Math.rgb(16, 16, 20),
            DOT_OFF     = G.Math.rgb(150, 150, 165)
        },
        halloween = {
            BG          = G.Math.rgb(16, 12, 22),
            BG_BOTTOM   = G.Math.rgb(10, 8, 14),
            PANEL       = G.Math.rgb(24, 18, 30),
            PANEL_2     = G.Math.rgb(33, 25, 41),
            STROKE      = G.Math.rgb(66, 44, 78),
            STROKE_DIM  = G.Math.rgb(52, 42, 62),
            ORANGE      = G.Math.rgb(255, 140, 40),
            ORANGE_SOFT = G.Math.rgb(255, 178, 96),
            ORANGE_DIM  = G.Math.rgb(150, 88, 34),
            PURPLE      = G.Math.rgb(158, 100, 232),
            TEXT        = G.Math.rgb(255, 244, 232),
            TEXT_DIM    = G.Math.rgb(158, 145, 165),
            TINT        = G.Math.rgb(52, 34, 20),
            TRACK_OFF   = G.Math.rgb(48, 40, 58),
            ON_DOT      = G.Math.rgb(28, 18, 10),
            DOT_OFF     = G.Math.rgb(150, 140, 158)
        }
    }

    local HW = {}
    local THEME_EMOJI = ""

    local function applyPalette(name)
        local src = PALETTES[name] or PALETTES.normal
        for k, v in pairs(src) do HW[k] = v end
        THEME_EMOJI = (name == "halloween") and "🎃 " or ""
    end

    applyPalette(DEFAULT_THEME)

    local NOTIFY_COLORS = {
        Info = HW.ORANGE_SOFT,
        Success = HW.ORANGE,
        Warning = HW.PURPLE,
        Error = G.Math.rgb(255, 75, 75),
        Background = HW.BG,
        Stroke = HW.STROKE
    }

    local activeToastList = {}
    local recentNotifications = {}

    local function getToastResponsiveConfig()
        local cam = G.Services.Workspace.CurrentCamera or Camera
        local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
        local isSmall = vp.X < 750 or isTouchDevice
        local cardWidth = isSmall and G.Math.clamp(G.Math.floor(vp.X * 0.42), 200, 250) or 290
        local cardHeight = isSmall and 48 or 56

        return {
            CARD_WIDTH = cardWidth,
            CARD_HEIGHT = cardHeight,
            PADDING = isSmall and 6 or 8,
            OFFSET_X = isSmall and 10 or 20,
            OFFSET_Y = isSmall and 12 or 22,
            ANIM_TIME = 0.3,
            TITLE_SIZE = isSmall and 11 or 12,
            DESC_SIZE = isSmall and 9 or 11,
            BAR_WIDTH = 3,
            MAX_STACK = 4,
            isSmall = isSmall
        }
    end

    local function repositionToasts()
        local cfg = getToastResponsiveConfig()
        for i, data in ipairs(activeToastList) do
            local targetY = cfg.OFFSET_Y + (i - 1) * (cfg.CARD_HEIGHT + cfg.PADDING)
            local targetPos = G.Math.ud2(1, -(cfg.CARD_WIDTH + cfg.OFFSET_X), 0, targetY)
            G.Services.TweenService:Create(data.frame, G.Math.tw(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = targetPos
            }):Play()
        end
    end

    local function showNotification(message, nType, title, duration)
        if not message or message == "" then return end
        
        local now = tick()
        if recentNotifications[message] and (now - recentNotifications[message]) < 3.5 then
            return
        end
        recentNotifications[message] = now

        duration = duration or 3.5
        nType = nType or "Info"
        local accentColor = NOTIFY_COLORS[nType] or NOTIFY_COLORS.Info
        local cfg = getToastResponsiveConfig()

        if not title then
            if nType == "Error" then title = getText("titleAlert")
            elseif nType == "Warning" then title = getText("titleWarning")
            elseif nType == "Success" then title = getText("titleSuccess")
            else title = getText("titleInfo") end
        end

        if #activeToastList >= cfg.MAX_STACK then
            local oldest = activeToastList[1]
            if oldest and oldest.dismiss then oldest.dismiss() end
        end

        local nextIndex = #activeToastList + 1
        local spawnY = cfg.OFFSET_Y + (nextIndex - 1) * (cfg.CARD_HEIGHT + cfg.PADDING)
        local startPos = G.Math.ud2(1, 40, 0, spawnY)
        local finalPos = G.Math.ud2(1, -(cfg.CARD_WIDTH + cfg.OFFSET_X), 0, spawnY)

        local frame = create("Frame", {
            Name = "Toast_" .. tick(),
            Size = G.Math.ud2(0, cfg.CARD_WIDTH, 0, cfg.CARD_HEIGHT),
            Position = startPos,
            BackgroundColor3 = NOTIFY_COLORS.Background,
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Parent = NotificationGui
        }, {
            cCorner(8),
            create("UIStroke", {Color = NOTIFY_COLORS.Stroke, Thickness = 1}),
            create("Frame", {
                Name = "Accent",
                Size = G.Math.ud2(0, cfg.BAR_WIDTH, 1, 0),
                BackgroundColor3 = accentColor,
                BorderSizePixel = 0
            }),
            create("TextLabel", {
                Name = "Title",
                Size = G.Math.ud2(1, -18, 0, cfg.isSmall and 14 or 18),
                Position = G.Math.ud2(0, 12, 0, 4),
                BackgroundTransparency = 1,
                Text = tostring(title),
                TextColor3 = accentColor,
                Font = Enum.Font.GothamBold,
                TextSize = cfg.TITLE_SIZE,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            create("TextLabel", {
                Name = "Desc",
                Size = G.Math.ud2(1, -18, 0, cfg.isSmall and 24 or 28),
                Position = G.Math.ud2(0, 12, 0, 20),
                BackgroundTransparency = 1,
                Text = tostring(message),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamMedium,
                TextSize = cfg.DESC_SIZE,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            create("Frame", {
                Name = "TimerBar",
                Size = G.Math.ud2(1, 0, 0, 2),
                Position = G.Math.ud2(0, 0, 1, -2),
                BackgroundColor3 = accentColor,
                BorderSizePixel = 0
            })
        })

        local isDismissed = false
        local notifyData = { frame = frame }

        local function dismissToast()
            if isDismissed then return end
            isDismissed = true

            local exitTween = G.Services.TweenService:Create(frame, G.Math.tw(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = G.Math.ud2(1, 40, 0, frame.Position.Y.Offset),
                BackgroundTransparency = 1
            })
            exitTween:Play()
            exitTween.Completed:Wait()

            for i, item in ipairs(activeToastList) do
                if item == notifyData then
                    table.remove(activeToastList, i)
                    break
                end
            end

            frame:Destroy()
            repositionToasts()
        end
        notifyData.dismiss = dismissToast
        activeToastList[#activeToastList + 1] = notifyData

        G.Services.TweenService:Create(frame, G.Math.tw(cfg.ANIM_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = finalPos
        }):Play()

        local tBar = frame:FindFirstChild("TimerBar")
        if tBar then
            G.Services.TweenService:Create(tBar, G.Math.tw(duration, Enum.EasingStyle.Linear), {
                Size = G.Math.ud2(0, 0, 0, 2)
            }):Play()
        end

        task.delay(duration, dismissToast)
    end

    -- === АНОНСЫ ОТ СЕРВЕРА В СТИЛЕ ХАБА ===
    task.spawn(function()
        if getgenv()._DOORS_HUB_ANNOUNCEMENT_ACTIVE then return end
        getgenv()._DOORS_HUB_ANNOUNCEMENT_ACTIVE = true

        local HttpService = G.Services.HttpService
        local reqFunc = (syn and syn.request) or request or http_request or (http and http.request)
        if not reqFunc then return end

        local ANNOUNCEMENT_URL = "https://justbot-cpjk.onrender.com/api/announcement"
        local lastSeenNoticeId = nil

        while task.wait(45) do
            local ok, response = pcall(function()
                return reqFunc({
                    Url = ANNOUNCEMENT_URL .. "?nocache=" .. tostring(os.time()),
                    Method = "GET",
                    Headers = {
                        ["Cache-Control"] = "no-cache, no-store, must-revalidate",
                        ["Pragma"] = "no-cache"
                    }
                })
            end)

            if ok and response and response.StatusCode == 200 and response.Body then
                local decodeOk, data = pcall(function()
                    return HttpService:JSONDecode(response.Body)
                end)

                if decodeOk and data and type(data) == "table" then
                    if data.active and data.id and data.id ~= lastSeenNoticeId then
                        lastSeenNoticeId = data.id

                        local toastType = "Info"
                        if data.type == "warning" then toastType = "Warning"
                        elseif data.type == "error" then toastType = "Error" end

                        showNotification(data.message or "", toastType, data.title or "DOORS HUB", 9.0)
                    end
                end
            end
        end
    end)

    local function isMonsterAllowed(monsterKey)
        if not states.monsterFilter then return true end
        local k = tostring(monsterKey):lower()
        return states.monsterFilter[k] ~= false
    end

    -- ====================================================================
    --                  ДЕКОМПОЗИЦИЯ ДВИЖКА (CORE MODULES)
    -- ====================================================================
    local function SetupCore(S)
        S.getPivotPos = getPivotPos
        S.getPivotCF = getPivotCF
        -- ====================================================================
        -- [СИСТЕМА] АНТИ-ПРЕПЯТСТВИЯ СИКА (РУКИ, ОГОНЬ, ЛЮСТРЫ, ШКАФЫ)
        -- ====================================================================
        local neutralizedSeekObstacles = setmetatable({}, {__mode = "k"})

        S.neutralizeSeekObstacleInstance = function(inst)
            if not states.antiSeekObstacles or not inst or not inst.Parent then return end
            if neutralizedSeekObstacles[inst] then return end

            local name = inst.Name
            local isSeekArm = (name == "Seek_Arm" or name:find("Seek_Arm"))
            local isChandelier = (name == "ChandelierObstruction" or name:find("ChandelierObstruction"))
            local isKillObstacle = (inst:GetAttribute("LoadModule") == "AnimatedObstacleKill")

            if isSeekArm or isChandelier or isKillObstacle then
                neutralizedSeekObstacles[inst] = true

                pcall(function()
                    for _, desc in ipairs(inst:GetDescendants()) do
                        if desc:IsA("BasePart") then
                            local dName = desc.Name
                            -- 1. Полная ликвидация урона (Огонь, Люстры, Руки Сика)
                            if dName == "HurtPart" or dName == "AnimatorPart" or desc:GetAttribute("Damage") ~= nil then
                                desc.CanTouch = false
                                desc.CanQuery = false
                                desc.CanCollide = false
                                
                                local tt = desc:FindFirstChildWhichIsA("TouchTransmitter")
                                if tt then tt:Destroy() end

                                if getconnections then
                                    for _, conn in ipairs(getconnections(desc.Touched)) do
                                        pcall(function() conn:Disable() end)
                                    end
                                end
                            end

                            -- 2. Отключение физических препятствий (пробегаем насквозь)
                            if dName == "Collision" or dName == "Palm" or dName == "Base" or dName == "String" then
                                desc.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end

        S.scanAndNeutralizeSeekObstacles = function()
            if not states.antiSeekObstacles then return end
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not cr then return end

            local cur = S.CachedCurrentRoom or 0
            for r = cur - 1, cur + 2 do
                local room = cr:FindFirstChild(tostring(r))
                if room then
                    local assets = room:FindFirstChild("Assets")
                    if assets then
                        for _, child in ipairs(assets:GetChildren()) do
                            S.neutralizeSeekObstacleInstance(child)
                        end
                    end
                    for _, child in ipairs(room:GetChildren()) do
                        S.neutralizeSeekObstacleInstance(child)
                    end
                end
            end
        end
        -- ====================================================================
        -- [СИСТЕМА] АНТИ-ЖИЖА СИКА (ТОЛЬКО БЛОКИРОВКА УРОНА И КАСАНИЙ)
        -- ====================================================================
        local neutralizedDamParts = setmetatable({}, {__mode = "k"})

        local function disableDamHazardTouch(part)
            if not part or not part:IsA("BasePart") or neutralizedDamParts[part] then return end
            neutralizedDamParts[part] = true
            pcall(function()
                part.CanTouch = false
                part.CanQuery = false
                local tt = part:FindFirstChildWhichIsA("TouchTransmitter")
                if tt then tt:Destroy() end
                if getconnections then
                    for _, conn in ipairs(getconnections(part.Touched)) do
                        pcall(function() conn:Disable() end)
                    end
                end
            end)
        end

        S.toggleAntiSeekFlood = function(enabled)
            states.antiSeekFlood = enabled
            pcall(function()
                local fr = G.Services.ReplicatedStorage:FindFirstChild("FloorReplicated")
                local cr = fr and fr:FindFirstChild("ClientRemote")
                local sf = cr and cr:FindFirstChild("SeekFlood")
                if sf then
                    sf:SetAttribute("Static", enabled and true or nil)
                end
            end)
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(0.25)
                if not states.antiSeekFlood then continue end

                pcall(function()
                    local fr = G.Services.ReplicatedStorage:FindFirstChild("FloorReplicated")
                    local cr = fr and fr:FindFirstChild("ClientRemote")
                    local sf = cr and cr:FindFirstChild("SeekFlood")
                    if sf and sf:GetAttribute("Static") ~= true then
                        sf:SetAttribute("Static", true)
                    end
                end)

                local ws = G.Services.Workspace
                local rooms = ws:FindFirstChild("CurrentRooms")
                local room100 = rooms and (rooms:FindFirstChild("100") or rooms:FindFirstChild("Sewer_Dam"))

                if room100 then
                    local liveFlood = room100:FindFirstChild("LiveSeekFlood")
                    if liveFlood then disableDamHazardTouch(liveFlood) end

                    local damHandler = room100:FindFirstChild("_DamHandler")
                    if damHandler then
                        for _, name in ipairs({"SeekFloodline", "Flood1", "Flood2", "Flood3"}) do
                            local p = damHandler:FindFirstChild(name)
                            if p then disableDamHazardTouch(p) end
                        end
                        for _, ch in ipairs(damHandler:GetChildren()) do
                            if ch.Name == "SeekHand" or ch.Name == "TrueSeekStuff" then
                                for _, p in ipairs(ch:GetDescendants()) do
                                    if p:IsA("BasePart") then
                                        p.CanCollide = false
                                        disableDamHazardTouch(p)
                                    end
                                end
                            end
                        end
                    end
                end

                for _, ch in ipairs(ws:GetChildren()) do
                    if ch.Name == "SeekMound" and ch:IsA("BasePart") then
                        ch.CanCollide = false
                        disableDamHazardTouch(ch)
                    end
                end

                -- Удаляем силы утягивания в жижу с персонажа, если они успели навеситься
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, child in ipairs(hrp:GetChildren()) do
                        if (child:IsA("VectorForce") or child:IsA("AlignPosition")) and child.Name ~= "CustomMove" then
                            pcall(function() child:Destroy() end)
                        end
                    end
                end
            end
        end)
        local creakRayParams = RaycastParams.new()
        creakRayParams.FilterType = Enum.RaycastFilterType.Include
        creakRayParams.RespectCanCollide = true
        creakRayParams.CollisionGroup = "Player"

        local function hasCreakLoS(fromPos, toPos)
            local rooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not rooms then return true end
            creakRayParams.FilterDescendantsInstances = {rooms}
            return G.Services.Workspace:Raycast(fromPos, toPos - fromPos, creakRayParams) == nil
        end

        local lastRawCreakState = ""
        local cachedCreakAggro = 0
        local cachedCreakWalk = 1

        local function readCreakAggression(creakModel)
            if not creakModel or not creakModel.Parent then return 0 end
            local animCtrl = creakModel:FindFirstChild("AnimationController") or creakModel:FindFirstChildOfClass("Humanoid")
            local animator = animCtrl and animCtrl:FindFirstChildOfClass("Animator")
            local graph = animator and animator:FindFirstChild("CreakGraph")
            if not graph then return 0 end

            local raw = graph:GetAttribute("State")
            if not raw or raw == "" then return 0 end
            if raw == lastRawCreakState then return cachedCreakAggro end

            lastRawCreakState = raw
            local ok, data = pcall(G.Services.HttpService.JSONDecode, G.Services.HttpService, raw)
            if ok and data and data.Aggression then
                cachedCreakAggro = math.clamp(tonumber(data.Aggression) or 0, -1, 1)
                cachedCreakWalk = tonumber(data.WalkSpeed) or cachedCreakWalk
                return cachedCreakAggro
            end
            return cachedCreakAggro
        end

        local function readCreakWalkSpeed(creakModel)
            readCreakAggression(creakModel)
            return cachedCreakWalk
        end

        S.CreakSpoof = CreakSpoof

        local bodyGuardActive = false
        local bodyGuardDir = nil
        local bodyGuardSavedHum = nil
        local bodyGuardSavedAutoRotate = nil

        local pokeUntil = 0
        local pokeDir = nil

        local function setBodyGuard(on, dir)
            bodyGuardActive = (on and dir ~= nil) and true or false
            bodyGuardDir = bodyGuardActive and dir or nil
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hum then
                bodyGuardSavedHum = nil
                bodyGuardSavedAutoRotate = nil
                return
            end
            if bodyGuardActive then
                if bodyGuardSavedHum ~= hum then
                    bodyGuardSavedHum = hum
                    bodyGuardSavedAutoRotate = hum.AutoRotate
                end
                hum.AutoRotate = false
            elseif bodyGuardSavedHum == hum and bodyGuardSavedAutoRotate ~= nil then
                hum.AutoRotate = bodyGuardSavedAutoRotate
                bodyGuardSavedHum = nil
                bodyGuardSavedAutoRotate = nil
            end
        end

        local creakRS = G.Services.RunService or game:GetService("RunService")
        creakRS.RenderStepped:Connect(function()
            if isAnyCutscenePlaying() then return end
            local dir = nil
            if os.clock() < pokeUntil then
                dir = pokeDir
            elseif bodyGuardActive then
                dir = bodyGuardDir
            end
            if not dir then return end
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + dir)
        end)

        local creakPromptDone = setmetatable({}, {__mode = "k"})
        S.neutralizeCreakModel = function(creak)
            if not creak or not creak.Parent or creakPromptDone[creak] then return end
            creakPromptDone[creak] = true
            pcall(function()
                for _, desc in ipairs(creak:GetDescendants()) do
                    if desc:IsA("ProximityPrompt") and desc.Enabled then
                        desc.Enabled = false
                    end
                end
            end)
        end

        local cachedCreakInstance = nil
        local nextCreakScan = 0
        local nextDeepCreakScan = 0
        local function findCreakInstance()
            if cachedCreakInstance and cachedCreakInstance.Parent and cachedCreakInstance:IsA("Model") then 
                return cachedCreakInstance 
            end
            local ws = G.Services.Workspace
            local live = ws:FindFirstChild("LiveEntities")
            if live then
                for _, child in ipairs(live:GetChildren()) do
                    if child:IsA("Model") and child.Name:find("Creak") then 
                        cachedCreakInstance = child 
                        return child 
                    end
                end
            end
            local now = tick()
            if now < nextCreakScan then return nil end
            nextCreakScan = now + 0.5
            local rooms = ws:FindFirstChild("CurrentRooms")
            if rooms then
                for _, room in ipairs(rooms:GetChildren()) do
                    local c = room:FindFirstChild("Creak") or room:FindFirstChild("CreakEntity")
                    -- [ФИКС]: Проверяем, что это именно Model монстра, а не дверной звук скрипа (Sound)
                    if c and c.Parent and c:IsA("Model") then 
                        cachedCreakInstance = c 
                        return c 
                    end
                end
                if now >= nextDeepCreakScan then
                    nextDeepCreakScan = now + 2
                    local scanned = 0
                    for _, room in ipairs(rooms:GetChildren()) do
                        scanned = scanned + 1
                        if scanned > 8 then break end
                        for _, desc in ipairs(room:GetChildren()) do
                            if desc:IsA("Model") and (desc.Name == "Creak" or desc.Name == "CreakEntity") then
                                cachedCreakInstance = desc
                                return desc
                            end
                        end
                    end
                end
            end
            local c = ws:FindFirstChild("Creak") or ws:FindFirstChild("CreakEntity")
            if c and c.Parent and c:IsA("Model") then 
                cachedCreakInstance = c 
                return c 
            end
            return nil
        end

        task.spawn(function()
            local GUARD_DIST = 60
            local POKE_TIME = 0.2
            local POKE_GAP = 2.0
            local POKE_GAP_HOT = 0.7
            local lastPoke = 0

            while S.Runtime.running do
                task.wait(0.04)

                local creak = states.creakBypass and findCreakInstance() or nil
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                -- [ФИКС]: Обязательная проверка creak:IsA("Model")
                if creak and creak.Parent and creak:IsA("Model") and hrp then
                    S.neutralizeCreakModel(creak)
                    local creakRoot = creak:FindFirstChild("HumanoidRootPart")
                        or creak.PrimaryPart
                        or creak:FindFirstChildWhichIsA("BasePart")

                    if creakRoot then
                        local delta = creakRoot.Position - hrp.Position
                        local flat = Vector3.new(delta.X, 0, delta.Z)
                        local dist = delta.Magnitude

                        if flat.Magnitude > 0.1 and dist <= GUARD_DIST then
                            local toCreak = flat.Unit
                            setBodyGuard(true, -toCreak)

                            local aggro = readCreakAggression(creak) or -1
                            local wspeed = readCreakWalkSpeed(creak)
                            local hot = dist < 12 or aggro > 0.15 or wspeed > 1.2
                            local now = os.clock()
                            if now - lastPoke >= (hot and POKE_GAP_HOT or POKE_GAP) then
                                lastPoke = now
                                pokeUntil = now + POKE_TIME
                                pokeDir = toCreak
                            end
                        else
                            setBodyGuard(false, nil)
                        end
                    else
                        setBodyGuard(false, nil)
                    end
                else
                    setBodyGuard(false, nil)
                end
            end
        end)

        local function getMonumentRootPart(monument)
            if not isRealMonumentEntity(monument) then return nil end
            local top = monument:FindFirstChild("Top")
            if top then
                local r = top:FindFirstChild("Root") or top:FindFirstChildWhichIsA("BasePart")
                if r then return r end
            end
            return monument:FindFirstChild("Root", true) or monument.PrimaryPart or monument:FindFirstChildWhichIsA("BasePart", true)
        end

        local cachedMonumentModels = {}
        local lastMonumentCacheScan = 0

        local function getAllActiveMonuments(maxDist)
            local now = tick()
            -- Сканируем появление новых монументов только 1 раз в 0.8 сек, а не 20 раз в секунду
            if (now - lastMonumentCacheScan) >= 0.8 then
                lastMonumentCacheScan = now
                table.clear(cachedMonumentModels)
                local ws = G.Services.Workspace
                for _, child in ipairs(ws:GetChildren()) do
                    if child.Name == "MonumentEntity" and isRealMonumentEntity(child) then
                        cachedMonumentModels[#cachedMonumentModels + 1] = child
                    end
                end
                local live = ws:FindFirstChild("LiveEntities")
                if live then
                    for _, child in ipairs(live:GetChildren()) do
                        if child.Name == "MonumentEntity" and isRealMonumentEntity(child) then
                            cachedMonumentModels[#cachedMonumentModels + 1] = child
                        end
                    end
                end
            end

            local list = {}
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local myPos = hrp and hrp.Position
            local limit = maxDist or 180

            for i = 1, #cachedMonumentModels do
                local inst = cachedMonumentModels[i]
                if inst and inst.Parent then
                    local rPart = getMonumentRootPart(inst)
                    if rPart then
                        local d = myPos and (rPart.Position - myPos).Magnitude or 0
                        if not myPos or d <= limit then
                            list[#list + 1] = { model = inst, root = rPart, dist = d }
                        end
                    end
                end
            end

            if #list > 1 then
                table.sort(list, function(a, b) return a.dist < b.dist end)
            end
            return list
        end

        local monumentCycleIndex = 1
        local lastMonumentSwitchClock = 0
        local currentMonumentLookDir = nil

        task.spawn(function()
            while S.Runtime.running do
                task.wait(0.05)
                if states.antiMonument then
                    local activeList = getAllActiveMonuments(180)
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local head = char and (char:FindFirstChild("Head") or hrp)

                    if #activeList > 0 and hrp and head then
                        local now = os.clock()
                        if #activeList > 1 then
                            if (now - lastMonumentSwitchClock) >= 1.0 then
                                lastMonumentSwitchClock = now
                                monumentCycleIndex = (monumentCycleIndex % #activeList) + 1
                            end
                            if monumentCycleIndex > #activeList then
                                monumentCycleIndex = 1
                            end
                        else
                            monumentCycleIndex = 1
                        end

                        local chosen = activeList[monumentCycleIndex]
                        local targetPart = chosen and chosen.root

                        if targetPart and targetPart.Parent then
                            local delta = targetPart.Position - hrp.Position
                            local flat = Vector3.new(delta.X, 0, delta.Z)
                            if flat.Magnitude > 0.1 then
                                currentMonumentLookDir = flat.Unit
                                -- Как в анти-скрипе (Creak): поворачиваем персонажа лицом к текущему активному монументу
                                if not bodyGuardActive and os.clock() >= pokeUntil then
                                    setBodyGuard(true, currentMonumentLookDir)
                                end
                            end

                            local targetVector = (targetPart.Position - head.Position).Unit
                            player:SetAttribute("LookVector", targetVector)
                            if char then char:SetAttribute("LookVector", targetVector) end

                            local remotes = G.Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
                            if remotes then
                                local camDirRemote = remotes:FindFirstChild("TargetCameraDirection")
                                if camDirRemote and camDirRemote:IsA("RemoteEvent") then
                                    camDirRemote:FireServer(targetVector)
                                end
                                local monEvent = remotes:FindFirstChild("MonumentEvent")
                                if monEvent and monEvent:IsA("UnreliableRemoteEvent") then
                                    pcall(function() monEvent:FireServer(targetVector) end)
                                end
                            end
                        end
                    else
                        currentMonumentLookDir = nil
                        if not states.creakBypass then
                            setBodyGuard(false, nil)
                            if player:GetAttribute("LookVector") ~= nil then
                                player:SetAttribute("LookVector", nil)
                                if char then char:SetAttribute("LookVector", nil) end
                            end
                        end
                    end
                else
                    if currentMonumentLookDir ~= nil then
                        currentMonumentLookDir = nil
                        if not states.creakBypass then
                            setBodyGuard(false, nil)
                        end
                    end
                end
            end
        end)

        S.swapRemoteState = function(name, isProtected)
            if not S.Remotes.folder then return end
            local real = S.RealEvents[name] or S.Remotes.folder:FindFirstChild(name)
            if real and real:IsA("RemoteEvent") then
                S.RealEvents[name] = real
                if not S.FakeEvents[name] then
                    local fake = Instance.new("RemoteEvent")
                    fake.Name = name
                    fake.Parent = G.Services.ReplicatedStorage
                    S.FakeEvents[name] = fake
                end
                if isProtected then
                    real.Parent = G.Services.ReplicatedStorage
                    S.FakeEvents[name].Parent = S.Remotes.folder
                else
                    S.FakeEvents[name].Parent = G.Services.ReplicatedStorage
                    real.Parent = S.Remotes.folder
                end
            end
        end

        S.POSITION_SPOOF = function(char, enabled)
            if not char then return end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local collision = char:FindFirstChild("Collision")
            local crouch = collision and collision:FindFirstChild("CollisionCrouch")
            local lowerTorso = char:FindFirstChild("LowerTorso")
            local root = lowerTorso and lowerTorso:FindFirstChild("Root")

            local targetHip = enabled and 0.09 or 2.0
            local targetColSize = enabled and G.Math.v3(1, 1, 1) or G.Math.v3(2, 3.5, 2)
            local targetCrouchSize = enabled and G.Math.v3(1, 1, 1) or G.Math.v3(2, 2.5, 2)
            local targetC1 = enabled and G.Math.cf(0, -2.3, 0) or G.Math.cf(0, 0, 0)

            if humanoid and math.abs(humanoid.HipHeight - targetHip) > 0.01 then
                humanoid.HipHeight = targetHip
            end
            if collision and collision:IsA("BasePart") and (collision.Size - targetColSize).Magnitude > 0.05 then
                collision.Size = targetColSize
            end
            if crouch and crouch:IsA("BasePart") and (crouch.Size - targetCrouchSize).Magnitude > 0.05 then
                crouch.Size = targetCrouchSize
            end
            if root and root.C1 ~= targetC1 then
                root.C1 = targetC1
            end
        end

        S.updatePositionSpoof = function(enabled)
            local char = player.Character
            if not char then return end
            if enabled then
                S.POSITION_SPOOF(char, true)
                if not S.Remotes.crouch then S.updateRemotes() end
                if S.Remotes.crouch then pcall(function() S.Remotes.crouch:FireServer(true) end) end
            else
                S.POSITION_SPOOF(char, false)
                player:SetAttribute("Crouching", false)
                if char:GetAttribute("Hiding") ~= true then
                    pcall(function() char:PivotTo(char:GetPivot() * G.Math.cf(0, 4, 0)) end)
                end
                if not S.Remotes.crouch then S.updateRemotes() end
                if S.Remotes.crouch then pcall(function() S.Remotes.crouch:FireServer(false) end) end
            end
        end

        S.surgeConnected = false
        S.screechConnected = false
        S.updateRemotes = function()
            pcall(function()
                local rs = G.Services.ReplicatedStorage
                S.Remotes.folder = rs:WaitForChild("RemotesFolder", 3) or rs:FindFirstChild("EntityInfo") or rs:FindFirstChild("Bricks")
                if S.Remotes.folder then
                    S.Remotes.crouch = S.Remotes.folder:FindFirstChild("Crouch")
                    S.Remotes.surge = S.Remotes.folder:FindFirstChild("SurgeRemote")
                    S.Remotes.statistics = S.Remotes.folder:FindFirstChild("Statistics")
                    S.Remotes.dropItem = S.Remotes.folder:FindFirstChild("DropItem")

                    local screechRemote = S.Remotes.folder:FindFirstChild("Screech")
                    if screechRemote and not S.screechConnected then
                        S.screechConnected = true
                        S.Runtime.connections[#S.Runtime.connections + 1] = screechRemote.OnClientEvent:Connect(function()
                            if states and states.screechRemover then
                                task.defer(function()
                                    screechRemote:FireServer(true)
                                end)
                                if S.cleanScreechLogic then
                                    S.cleanScreechLogic()
                                end
                            end
                        end)
                    end

                    for _, evName in ipairs({"SurgeRemote"}) do
                        local ev = S.Remotes.folder:FindFirstChild(evName)
                        if ev and ev:IsA("RemoteEvent") then
                            S.RealEvents[evName] = ev
                            if not S.FakeEvents[evName] then
                                local f = Instance.new("RemoteEvent")
                                f.Name = evName
                                f.Parent = rs
                                S.FakeEvents[evName] = f
                            end
                        end
                    end

                    if states.antiSurgeDamage then S.swapRemoteState("SurgeRemote", true) end

                    if S.Remotes.surge and not S.surgeConnected then
                        S.surgeConnected = true
                        S.Runtime.connections[#S.Runtime.connections + 1] = S.Remotes.surge.OnClientEvent:Connect(function()
                            if states.surgeAlert and (tick() - S.Timers.lastSurgeAlert > 2.5) then
                                S.Timers.lastSurgeAlert = tick()
                                showNotification(getText("msgSurge"), "Warning")
                            end
                        end)
                    end
                end
            end)
        end
        S.updateRemotes()

        S.cleanLookmanLogic = function() end
        S.cleanEyesLogic = function() end

        S.NeutralizeAlmaModel = function(model)
            if not states.antiAlma or not model or not model:IsA("Model") or not model.Parent then return end
            local body = model:FindFirstChild("Body")
            if body then cachedAlmaBody = body end

            local config = model:FindFirstChild("Config") or model:WaitForChild("Config", 2)
            if not config then return end

            task.spawn(function()
                pcall(function()
                    local idle = config:FindFirstChild("idle") or config:WaitForChild("idle", 2)
                    if idle then
                        if idle:FindFirstChild("angerGain") then idle.angerGain.Value = 0 end
                        if idle:FindFirstChild("angerIndirectGain") then idle.angerIndirectGain.Value = 0 end
                        if idle:FindFirstChild("angerCone") then idle.angerCone.Value = 0 end
                        if idle:FindFirstChild("angerDecay") then idle.angerDecay.Value = 9999 end
                    end
                    local attack = config:FindFirstChild("attack") or config:WaitForChild("attack", 2)
                    if attack then
                        if attack:FindFirstChild("hitDistance") then attack.hitDistance.Value = 0 end
                        if attack:FindFirstChild("minigameLength") then attack.minigameLength.Value = 0.1 end
                    end
                end)
            end)
        end

        S.HookAlmaMinigame = function(gui)
            if not states.antiAlma or not gui then return end
            local minigameFrame = gui:FindFirstChild("EyeStaringGame") or gui:WaitForChild("EyeStaringGame", 2)
            if not minigameFrame then return end
            local eye = minigameFrame:FindFirstChild("Eye") or minigameFrame:WaitForChild("Eye", 2)
            if not eye then return end
            local eyeMain = eye:FindFirstChild("EyeMain") or eye:WaitForChild("EyeMain", 2)
            local eyeInput = eye:FindFirstChild("EyePlayerInput") or eye:WaitForChild("EyePlayerInput", 2)
            if eyeMain and eyeInput then
                local connection
                connection = G.Services.RunService.RenderStepped:Connect(function()
                    if not states.antiAlma or not minigameFrame.Parent or not eye.Parent then
                        if connection then connection:Disconnect() end
                        return
                    end
                    eyeInput.Size = eyeMain.Size
                end)
                S.Runtime.connections[#S.Runtime.connections + 1] = connection
            end
        end

        S.CleanAlmaCameraFX = function(child)
            if not states.antiAlma or not child then return end
            if child.Name == "AlmaBlur" or child.Name == "AlmaColorCorrection" then
                task.defer(function() pcall(function() child:Destroy() end) end)
            end
        end

        S.CleanAlmaGui = function(child)
            if not states.antiAlma or not child then return end
            if child.Name == "AlmaUI" then
                task.defer(function() pcall(function() child:Destroy() end) end)
            end
        end

        S.scanAlmaImmediate = function()
            if not states.antiAlma then return end
            local ws = G.Services.Workspace
            for _, child in ipairs(ws:GetChildren()) do
                if child.Name:lower():find("alma") then S.NeutralizeAlmaModel(child) end
            end
            local cr = ws:FindFirstChild("CurrentRooms")
            if cr then
                for _, room in ipairs(cr:GetChildren()) do
                    local a = room:FindFirstChild("Alma")
                    if a then S.NeutralizeAlmaModel(a) end
                end
            end
            local cam = ws.CurrentCamera or Camera
            if cam then
                for _, child in ipairs(cam:GetChildren()) do S.CleanAlmaCameraFX(child) end
            end
            if PlayerGui:FindFirstChild("AlmaUI") then pcall(function() PlayerGui.AlmaUI:Destroy() end) end
            local mainUI = PlayerGui:FindFirstChild("MainUI")
            local mainFrame = mainUI and mainUI:FindFirstChild("MainFrame")
            if mainFrame and mainFrame:FindFirstChild("EyeStaringGame") then S.HookAlmaMinigame(mainFrame) end
        end

        S.checkAndKillJeff = function(obj)
            if not states.antiJeff or not obj then return end
            if obj.Name == "JeffTheKiller" then
                task.delay(0.2, function()
                    if obj and obj.Parent then
                        local hum = obj:FindFirstChildOfClass("Humanoid") or obj:WaitForChild("Humanoid", 2)
                        if hum then hum.Health = 0 end
                    end
                end)
            end
        end

        S.securePuddle = function(puddle)
            if not states.antiCurrents or not puddle or not puddle:IsA("BasePart") or not puddle.Parent then return end
            pcall(function()
                puddle.CanTouch = false
                puddle.CanQuery = false
                if getconnections then
                    for _, conn in ipairs(getconnections(puddle.Touched)) do
                        pcall(function() conn:Disable() end)
                    end
                end
            end)

            if S.createdPuddlePlatforms[puddle] and S.createdPuddlePlatforms[puddle].Parent then return end

            pcall(function()
                local pSize = puddle.Size
                local pCF = puddle.CFrame
                local barrier = Instance.new("Part")
                barrier.Name = "AntiCurrentsSafePlatform"
                barrier.Size = Vector3.new(pSize.X + 2.0, 0.75, pSize.Z + 2.0)
                barrier.CFrame = pCF + Vector3.new(0, 0.75, 0)
                barrier.Transparency = 1
                barrier.Anchored = true
                barrier.CanCollide = true
                barrier.CanTouch = false
                barrier.CanQuery = false
                barrier.Material = Enum.Material.SmoothPlastic
                barrier.Parent = G.Services.Workspace

                S.createdPuddlePlatforms[puddle] = barrier

                puddle.AncestryChanged:Connect(function(_, parentPart)
                    if not parentPart then
                        if barrier and barrier.Parent then barrier:Destroy() end
                        S.createdPuddlePlatforms[puddle] = nil
                    end
                end)
            end)
        end

        S.checkAndSecurePuddle = function(obj)
            if not states.antiCurrents or not obj or not obj:IsA("BasePart") then return end
            local rawName = obj.Name
            local name = rawName and tostring(rawName):lower() or ""
            if name == "" then return end

            if name == "puddle" or name == "water" or name == "discharge" or name:find("puddle") or name:find("water") or name:find("hazard") then
                S.securePuddle(obj)
            end
        end

        S.scanAllRoomsForPuddles = function()
            if not states.antiCurrents then return end
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if cr then
                for _, room in ipairs(cr:GetChildren()) do
                    local water = room:FindFirstChild("Water")
                    if water then
                        for _, desc in ipairs(water:GetChildren()) do
                            if desc:IsA("BasePart") then S.checkAndSecurePuddle(desc) end
                        end
                    end
                    for _, desc in ipairs(room:GetChildren()) do
                        if desc:IsA("BasePart") then S.checkAndSecurePuddle(desc) end
                    end
                end
            end
        end

        S.setPuddleImmunity = function(enable)
            states.antiCurrents = enable
            if enable then
                S.scanAllRoomsForPuddles()
            else
                for puddle, platform in pairs(S.createdPuddlePlatforms) do
                    if platform and platform.Parent then pcall(function() platform:Destroy() end) end
                    if puddle and puddle:IsA("BasePart") and puddle.Parent then
                        pcall(function()
                            puddle.CanTouch = true
                            puddle.CanQuery = true
                            if getconnections then
                                for _, conn in ipairs(getconnections(puddle.Touched)) do
                                    pcall(function() conn:Enable() end)
                                end
                            end
                        end)
                    end
                end
                table.clear(S.createdPuddlePlatforms)
            end
        end

        S.cleanDroneLogic = function(obj)
            if not states.antiDrone or not obj or typeof(obj) ~= "Instance" then return end
            local name = tostring(obj.Name):lower()
            local isDroneOrStampede = (
                name == "drone" or name == "staticguy" or name == "dronesactor" or name == "stampede"
                or name:find("drone") or name:find("staticguy") or name:find("stampede")
                or G.Services.CollectionService:HasTag(obj, "Drone") or G.Services.CollectionService:HasTag(obj, "StaticGuy") or G.Services.CollectionService:HasTag(obj, "Stampede")
                or obj:GetAttribute("StaticEnabled") ~= nil
                or obj:FindFirstChild("Trampled") ~= nil
                or obj:FindFirstChild("WalkedInto") ~= nil
            )

            if isDroneOrStampede then
                pcall(function()
                    obj:SetAttribute("Enabled", false)
                    obj:SetAttribute("SwitchingPosition", true)

                    for _, remName in ipairs({"WalkedInto", "ShoulderChecked", "Trampled"}) do
                        local rem = obj:FindFirstChild(remName)
                        if rem then
                            if getconnections then
                                for _, conn in ipairs(getconnections(rem.OnClientEvent)) do pcall(function() conn:Disable() end) end
                            end
                            rem.Parent = nil
                        end
                    end

                    for _, desc in ipairs(obj:GetDescendants()) do
                        if desc:IsA("BasePart") then
                            desc.CanTouch = false
                            desc.CanQuery = false
                            desc.CanCollide = false
                        end
                    end
                end)
            end
        end

        S.scanAndPurgeAllDrones = function()
            if not states.antiDrone then return end
            local ws = G.Services.Workspace
            for _, child in ipairs(ws:GetChildren()) do S.cleanDroneLogic(child) end
            local liveEnts = ws:FindFirstChild("LiveEntities")
            if liveEnts then for _, child in ipairs(liveEnts:GetChildren()) do S.cleanDroneLogic(child) end end
        end

        S.ForcePermanentSilentState = function()
            if isAnyCutscenePlaying() then return end
            local char = player.Character
            if char and (states.speedEnabled or states.autoHide or states.autoRooms) then
                char:SetAttribute("Crouching", true)
                local col = char:FindFirstChild("Collision")
                if col and col:IsA("BasePart") then
                    col.CollisionGroup = "PlayerCrouching"
                    col.CanCollide = false
                end
                if not S.Remotes.crouch and S.Remotes.folder then
                    S.Remotes.crouch = S.Remotes.folder:FindFirstChild("Crouch")
                end
                if S.Remotes.crouch then
                    pcall(function() S.Remotes.crouch:FireServer(true, true) end)
                end
            end
        end

        S.RestoreFriction = function(char)
            if not char then return end
            pcall(function()
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CustomPhysicalProperties = nil end
                end
            end)
        end

        S.RestoreCharacterNormalState = function(char)
            if not char then return end
            S.RestoreFriction(char)
            pcall(function()
                char:SetAttribute("Crouching", false)
                char:SetAttribute("Hiding", false)
                player:SetAttribute("Hiding", false)
                local col = char:FindFirstChild("Collision")
                if col and col:IsA("BasePart") then col.CanCollide = true end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
                if not S.Remotes.crouch and S.Remotes.folder then
                    S.Remotes.crouch = S.Remotes.folder:FindFirstChild("Crouch")
                end
                if S.Remotes.crouch then S.Remotes.crouch:FireServer(false, false) end
            end)
        end

        S.SetupCharacterSpeed = function(char)
            if not char then return end

            char:GetAttributeChangedSignal("Crouching"):Connect(function()
                if states.speedEnabled or states.autoHide or states.autoRooms then
                    S.ForcePermanentSilentState()
                end
            end)

            char:GetAttributeChangedSignal("RestrictMovement"):Connect(function()
                if states.antiDrone and char:GetAttribute("RestrictMovement") == true then
                    char:SetAttribute("RestrictMovement", false)
                end
            end)

            if states.speedEnabled then
                S.ForcePermanentSilentState()
            end
        end
    end
    local function SetupArchivesAdditions(S)
        -- ====================================================================
        -- ПОЛНОСТЬЮ ИСПРАВЛЕННЫЙ ТРЕКЕР ХОНЧО (ПО АТРИБУТАМ КОМНАТ 203-206)
        -- ====================================================================
        S.HonchoTracker = {
            active = false,
            stage = 1,                 -- Сектор (1, 2, 3 или 4)
            maxStages = 4,
            stageState = "None",       -- "Office", "WaitingTerminal", "Active", "Cleared", "Breached", "Victory"
            stageStartTime = 0,
            stageStartTimes = {},      -- Жесткая фиксация старта таймера для каждого из 4 этапов
            stageHits = {},            -- Удары по воротам для каждого этапа отдельно
            normalDuration = 150,      -- 2 минуты 30 секунд (150 сек) без звезд
            starlightDuration = 90,    -- 1 мин 30 сек (90 сек) со звездами
            isStarlight = false,
            hitCount = 0,
            lastBangTick = 0,
            remainingBoxes = 0,
            correctBoxes = 0,
            totalBoxes = 0,
            honchoModel = nil,
            hookedGates = setmetatable({}, {__mode = "k"})
        }

        local function verifyHonchoStarlight(model)
            if model and model.Parent then
                for _, desc in ipairs(model:GetDescendants()) do
                    if desc:IsA("Decal") and desc.Color3.R > 500 then
                        return true
                    elseif desc:IsA("ParticleEmitter") and (desc.Name == ".ARMSHINE" or desc.Name == "ARMSHINE" or desc.Name == "YellowParticle") and desc.Enabled then
                        return true
                    end
                end
            end
            return false
        end

        local function hookHonchoGate(gate, stageIdx)
            if not gate or S.HonchoTracker.hookedGates[gate] then return end
            S.HonchoTracker.hookedGates[gate] = true

            local base = gate.PrimaryPart or gate:FindFirstChild("Base") or gate:FindFirstChildWhichIsA("BasePart")
            if not base then return end

            -- Считаем уже существующие TempClone (если скрипт запущен во время ударов)
            local initialClones = 0
            for _, ch in ipairs(base:GetChildren()) do
                if ch:IsA("Sound") and ch.Name == "TempClone" then
                    initialClones = initialClones + 1
                end
            end
            if initialClones > (S.HonchoTracker.stageHits[stageIdx] or 0) then
                S.HonchoTracker.stageHits[stageIdx] = initialClones
            end

            -- Каждый новый удар Хончо создает Sound "TempClone" внутри Base
            S.Runtime.connections[#S.Runtime.connections + 1] = base.ChildAdded:Connect(function(ch)
                if ch:IsA("Sound") and (ch.Name == "TempClone" or ch.Name:find("Bang")) then
                    local now = tick()
                    if (now - S.HonchoTracker.lastBangTick) > 0.3 then
                        S.HonchoTracker.lastBangTick = now
                        S.HonchoTracker.stageHits[stageIdx] = (S.HonchoTracker.stageHits[stageIdx] or 0) + 1
                        if S.HonchoTracker.stage == stageIdx then
                            S.HonchoTracker.hitCount = S.HonchoTracker.stageHits[stageIdx]
                        end
                    end
                end
            end)
        end

        -- Главный фоновый поток Хончо (работает в любом секторе по RawName без привязки к 201..207)
        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 0.25 or 0.15)

                if states.statHonchoTimer then
                    local ws = G.Services.Workspace
                    local cr = ws:FindFirstChild("CurrentRooms")
                    local curRoomNum = tonumber(player:GetAttribute("CurrentRoom")) or S.CachedCurrentRoom or 0

                    -- Проверяем модель HonchoRig в LiveEntities на наличие Starlight
                    local liveEnts = ws:FindFirstChild("LiveEntities")
                    local hModel = liveEnts and (liveEnts:FindFirstChild("HonchoRig") or liveEnts:FindFirstChild("Honcho"))
                    if hModel and verifyHonchoStarlight(hModel) then
                        S.HonchoTracker.isStarlight = true
                    end

                    if cr then
                        local curRoom = cr:FindFirstChild(tostring(curRoomNum))
                        local rawName = curRoom and tostring(curRoom:GetAttribute("RawName") or "") or ""

                        -- Ищем номер комнаты офиса (Archives_HonchoOffice), чтобы от него точно считать этапы 1..4
                        local officeRoomNum = S.HonchoTracker.officeRoomNum
                        if not officeRoomNum then
                            for _, rm in ipairs(cr:GetChildren()) do
                                if tostring(rm:GetAttribute("RawName") or "") == "Archives_HonchoOffice" then
                                    officeRoomNum = tonumber(rm.Name)
                                    S.HonchoTracker.officeRoomNum = officeRoomNum
                                    break
                                end
                            end
                        end

                        -- 1. Комнаты перед погоней (вход и сам офис Хончо)
                        if rawName == "Archives_HonchoOfficeEntrance" or rawName == "Archives_HonchoOffice" then
                            if rawName == "Archives_HonchoOffice" then
                                S.HonchoTracker.officeRoomNum = curRoomNum
                            end
                            S.HonchoTracker.stage = 1
                            S.HonchoTracker.stageState = "Office"
                            S.HonchoTracker.active = false
                            S.HonchoTracker.stageStartTime = 0
                            table.clear(S.HonchoTracker.stageStartTimes)
                            table.clear(S.HonchoTracker.stageHits)

                            -- Проверка выпитой бутылки StarBottle в катсцене офиса
                            if curRoom then
                                local cutSetup = curRoom:FindFirstChild("ConfrontationCutsceneSetup")
                                local initRig = cutSetup and cutSetup:FindFirstChild("HonchoRigInitial")
                                local starBottle = initRig and initRig:FindFirstChild("StarBottle")
                                local drinkSnd = starBottle and starBottle:FindFirstChild("sound_drink")
                                if drinkSnd and drinkSnd:IsA("Sound") and drinkSnd.IsPlaying then
                                    S.HonchoTracker.isStarlight = true
                                end
                            end

                        -- 2. Финальная комната после всех 4 пазлов (СТРОГО по RawName == Archives_HonchoEnd)
                        elseif rawName == "Archives_HonchoEnd" then
                            S.HonchoTracker.stage = 4
                            S.HonchoTracker.stageState = "Victory"
                            S.HonchoTracker.active = false

                        -- 3. Комнаты пазлов Хончо (Archives_HonchoPuzzle1..4)
                        elseif rawName:find("Archives_HonchoPuzzle") or (curRoom and curRoom:FindFirstChild("ArchivesHonchoRoom")) then
                            -- Вычисляем номер секции (1, 2, 3 или 4) относительно комнаты офиса или подсчетом пазл-комнат
                            local stageIdx = 1
                            if officeRoomNum and curRoomNum > officeRoomNum then
                                stageIdx = math.clamp(curRoomNum - officeRoomNum, 1, 4)
                            else
                                local puzzleCount = 0
                                for _, rm in ipairs(cr:GetChildren()) do
                                    local rNum = tonumber(rm.Name) or 0
                                    local rRaw = tostring(rm:GetAttribute("RawName") or "")
                                    if rNum <= curRoomNum and (rRaw:find("Archives_HonchoPuzzle") or rm:FindFirstChild("ArchivesHonchoRoom")) then
                                        puzzleCount = puzzleCount + 1
                                    end
                                end
                                stageIdx = math.clamp(puzzleCount, 1, 4)
                            end

                            S.HonchoTracker.stage = stageIdx

                            if curRoom then
                                local gate = curRoom:FindFirstChild("ArchivesHonchoGate")
                                if gate then
                                    hookHonchoGate(gate, stageIdx)
                                    local base = gate.PrimaryPart or gate:FindFirstChild("Base")
                                    if base then
                                        local clones = 0
                                        for _, ch in ipairs(base:GetChildren()) do
                                            if ch:IsA("Sound") and ch.Name == "TempClone" then
                                                clones = clones + 1
                                            end
                                        end
                                        if clones > (S.HonchoTracker.stageHits[stageIdx] or 0) then
                                            S.HonchoTracker.stageHits[stageIdx] = clones
                                        end
                                    end
                                end
                                S.HonchoTracker.hitCount = S.HonchoTracker.stageHits[stageIdx] or 0

                                local totalB = tonumber(curRoom:GetAttribute("TotalBoxes")) or 2
                                local correctB = tonumber(curRoom:GetAttribute("CorrectBoxes")) or 0
                                local puzzleDone = (curRoom:GetAttribute("PuzzleComplete") == true) or (totalB > 0 and correctB >= totalB)
                                local gateState = tostring(curRoom:GetAttribute("GateState") or "")
                                local termActivated = (curRoom:GetAttribute("TerminalActivated") == "HoldShut")

                                if not termActivated then
                                    local assets = curRoom:FindFirstChild("Assets")
                                    local term = assets and assets:FindFirstChild("ArchivesTerminal") or curRoom:FindFirstChild("ArchivesTerminal")
                                    if term and term:GetAttribute("Activated") == true then
                                        termActivated = true
                                    end
                                end

                                S.HonchoTracker.totalBoxes = totalB
                                S.HonchoTracker.correctBoxes = correctB
                                S.HonchoTracker.remainingBoxes = math.max(0, totalB - correctB)

                                if not termActivated then
                                    S.HonchoTracker.stageState = "WaitingTerminal"
                                    S.HonchoTracker.active = false
                                else
                                    if not S.HonchoTracker.stageStartTimes[stageIdx] then
                                        S.HonchoTracker.stageStartTimes[stageIdx] = tick()
                                    end
                                    S.HonchoTracker.stageStartTime = S.HonchoTracker.stageStartTimes[stageIdx]

                                    if puzzleDone then
                                        S.HonchoTracker.stageState = "Cleared"
                                        S.HonchoTracker.active = false
                                    elseif gateState == "Broken" and not puzzleDone then
                                        S.HonchoTracker.stageState = "Breached"
                                        S.HonchoTracker.active = false
                                    else
                                        S.HonchoTracker.stageState = "Active"
                                        S.HonchoTracker.active = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)

        S.destroyScribblesPaper = function(item)
            if not states.antiScribbles or not item then return end
            if item.Name == "ScribblesPaper" or (item:IsA("BasePart") and item:FindFirstChild("VectorForce")) then
                task.defer(function()
                    pcall(function() item:Destroy() end)
                end)
            end
        end

        S.cleanExistingPapers = function()
            if not states.antiScribbles then return end
            for _, v in ipairs(G.Services.Workspace:GetChildren()) do
                if v.Name == "ScribblesPaper" then pcall(function() v:Destroy() end) end
            end
        end

        S.getTicketItem = function()
            local char = player.Character
            local backpack = player:FindFirstChild("Backpack")
            if char then
                for _, item in ipairs(char:GetChildren()) do
                    if item:IsA("Tool") and item:GetAttribute("TicketID") then
                        return item, "Character"
                    end
                end
            end
            if backpack then
                for _, item in ipairs(backpack:GetChildren()) do
                    if item:IsA("Tool") and item:GetAttribute("TicketID") then
                        return item, "Backpack"
                    end
                end
            end
            return nil, nil
        end

        S.unequipTicket = function()
            local char = player.Character
            local backpack = player:FindFirstChild("Backpack")
            if char and backpack then
                local tool = char:FindFirstChildWhichIsA("Tool")
                if tool and tool:GetAttribute("TicketID") then
                    tool.Parent = backpack
                end
            end
        end

        S.isTellerBusy = false
        S.handleTeller = function(teller)
            if not states.autoTellerTicket or S.isTellerBusy or not teller or not teller.Parent then return end

            local prompt = teller:FindFirstChild("GiveTakePrompt", true)
            if not prompt or not prompt:IsA("ProximityPrompt") or not prompt.Enabled then 
                return 
            end

            local ticket, location = S.getTicketItem()
            local aggressiveGui = teller:FindFirstChild("AggressiveGui", true)
            local servingSound = teller:FindFirstChild("Serving", true)
            local isServing = (aggressiveGui and aggressiveGui.Enabled) or (servingSound and servingSound.IsPlaying)

            if not ticket and not isServing then
                S.isTellerBusy = true
                prompt.HoldDuration = 0
                prompt.RequiresLineOfSight = false
                triggerPromptInstance(prompt)
                task.wait(1.5)
                S.unequipTicket()
                S.isTellerBusy = false
                return
            end

            if ticket and isServing then
                S.isTellerBusy = true
                local char = player.Character
                if location == "Backpack" and char then
                    ticket.Parent = char
                    task.wait(0.15)
                end
                prompt.HoldDuration = 0
                prompt.RequiresLineOfSight = false
                triggerPromptInstance(prompt)
                task.wait(1.5)
                S.isTellerBusy = false
                return
            end
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 1.2 or 0.6)
                if states.autoTellerTicket and not S.isTellerBusy then
                    local liveEntities = G.Services.Workspace:FindFirstChild("LiveEntities")
                    if liveEntities then
                        for _, entity in ipairs(liveEntities:GetChildren()) do
                            if entity.Name:find("Teller") or entity:FindFirstChild("GiveTakePrompt") then
                                pcall(S.handleTeller, entity)
                            end
                        end
                    end
                end
            end
        end)

        -- ANTI-NOISE: AUTO & MANUAL TV SLAM
        local isTVSlamExecuting = false

        local function claimTVNetworkPhysics()
            pcall(function()
                if typeof(setsimulationradius) == "function" then
                    setsimulationradius(math.huge, math.huge)
                end
                if typeof(sethiddenproperty) == "function" then
                    sethiddenproperty(player, "SimulationRadius", 1e8)
                    sethiddenproperty(player, "MaximumSimulationRadius", 1e8)
                end
            end)
        end

        local function findTVStandModel()
            local rooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if rooms then
                local cur = S.CachedCurrentRoom or 0
                for r = cur - 1, cur + 2 do
                    local room = rooms:FindFirstChild(tostring(r))
                    if room then
                        local assets = room:FindFirstChild("Assets")
                        local tv = assets and assets:FindFirstChild("TV_Stand") or room:FindFirstChild("TV_Stand")
                        if tv then return tv end
                    end
                end
            end
            return nil
        end

        local function getDistanceToTVModel(tv)
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp or not tv then return math.huge end

            local collider = tv:FindFirstChild("Collider") or tv:FindFirstChildWhichIsA("BasePart")
            if not collider then return math.huge end

            local dx = collider.Position.X - hrp.Position.X
            local dy = collider.Position.Y - hrp.Position.Y
            local dz = collider.Position.Z - hrp.Position.Z
            return math.sqrt(dx * dx + dy * dy + dz * dz)
        end

        S.executeInstantTVSlam = function()
            if isTVSlamExecuting then return false end

            local tv = findTVStandModel()
            if not tv then
                showNotification(getText("msgTVNotFound"), "Warning")
                return false
            end

            local collider = tv:FindFirstChild("Collider") or tv:FindFirstChildWhichIsA("BasePart")
            if not collider then return false end

            isTVSlamExecuting = true

            task.spawn(function()
                local success = pcall(function()
                    local prompt = tv:FindFirstChild("CartPrompt", true) or tv:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        prompt.MaxActivationDistance = 40
                        prompt.RequiresLineOfSight = false
                        prompt.HoldDuration = 0
                        triggerPromptInstance(prompt)
                    end

                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp and typeof(firetouchinterest) == "function" then
                        firetouchinterest(hrp, collider, 0)
                        task.wait()
                        firetouchinterest(hrp, collider, 1)
                    end

                    claimTVNetworkPhysics()

                    for _, part in ipairs(tv:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = false
                            part.CanCollide = true
                            pcall(function()
                                if typeof(sethiddenproperty) == "function" then
                                    sethiddenproperty(part, "NetworkIsSleeping", false)
                                end
                            end)
                        end
                    end

                    local rootPart = collider.AssemblyRootPart or collider
                    local forwardDir = rootPart.CFrame.LookVector
                    local rightAxis = rootPart.CFrame.RightVector

                    local tumbleTorque = -rightAxis * 160
                    local slamVelocity = (forwardDir * 60) + Vector3.new(0, -35, 0)

                    local elapsed = 0
                    local conn
                    conn = G.Services.RunService.Heartbeat:Connect(function(dt)
                        elapsed = elapsed + dt
                        if elapsed > 0.35 or not rootPart or not rootPart.Parent or not S.Runtime.running then
                            if conn then conn:Disconnect() end
                            isTVSlamExecuting = false
                            showNotification(getText("msgTVSlammed"), "Success")
                            return
                        end

                        claimTVNetworkPhysics()
                        rootPart.AssemblyAngularVelocity = tumbleTorque
                        rootPart.AssemblyLinearVelocity = slamVelocity
                    end)
                end)

                if not success then
                    isTVSlamExecuting = false
                end
            end)

            return true
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 0.15 or 0.08)
                if states.antiNoise and not isTVSlamExecuting then
                    local tv = findTVStandModel()
                    if tv then
                        local dist = getDistanceToTVModel(tv)
                        if dist <= 15 then
                            S.executeInstantTVSlam()
                            task.wait(2.5)
                        end
                    end
                end
            end
        end)
    end

    -- ====================================================================
    --     СИСТЕМА ТРЕЙСЕРОВ (TRACERS MANAGER) — 100% GUI ГАРАНТИЯ
    -- ====================================================================
    local function SetupTracers(S)
        S.hasDrawing = false
        S.tracerPool = {}
        local POOL_SIZE = isTouchDevice and 26 or 40

        -- Удаляем старый оверлей, если он остался от прошлого запуска
        pcall(function()
            local old = S.ScreenGui:FindFirstChild("HubTracers_Container")
            if old then old:Destroy() end
        end)

        -- Контейнер трейсеров прямо внутри рабочего ScreenGui с максимальным слоем
        local tracerContainer = create("Folder", {
            Name = "HubTracers_Container",
            Parent = S.ScreenGui
        })
        S.tracerContainer = tracerContainer

        -- Пул экранных линий толщиной 2.5px
        for i = 1, POOL_SIZE do
            local lineFrame = create("Frame", {
                Name = "TracerLine_" .. i,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BorderSizePixel = 0,
                BackgroundColor3 = G.Math.rgb(255, 255, 255),
                BackgroundTransparency = 0.1,
                Visible = false,
                ZIndex = 80,
                Parent = tracerContainer
            })
            S.tracerPool[i] = lineFrame
        end

        S.clearAllTracers = function()
            for _, f in ipairs(S.tracerPool) do
                f.Visible = false
            end
        end

        S.tracerSkipCounter = 0
        S.updateTracersFrame = function()
            if not states.tracerEsp or not S.Runtime.running then
                S.clearAllTracers()
                return
            end

            -- Оптимизация частоты на мобильных устройствах
            if isTouchDevice then
                S.tracerSkipCounter = (S.tracerSkipCounter + 1) % 2
                if S.tracerSkipCounter ~= 0 then return end
            end

            local cam = G.Services.Workspace.CurrentCamera or Camera
            if not cam then return end

            local vpSize = cam.ViewportSize
            -- Начало луча: нижний центр экрана
            local originPoint = Vector2.new(vpSize.X * 0.5, vpSize.Y)
            local currentCount = 0

            local function drawTracerTo(pos, color)
                if currentCount >= POOL_SIZE or not pos then return end

                local screenPos, onScreen = cam:WorldToViewportPoint(pos)
                -- Объект должен быть впереди камеры (Z > 0) и попадать в обзор экрана
                if not onScreen or screenPos.Z <= 0 then return end

                currentCount = currentCount + 1
                local line = S.tracerPool[currentCount]
                if line then
                    local dx = screenPos.X - originPoint.X
                    local dy = screenPos.Y - originPoint.Y
                    local length = math.sqrt(dx * dx + dy * dy)
                    local angle = math.deg(math.atan2(dy, dx))

                    line.Size = G.Math.ud2(0, length, 0, 1.5)
                    line.Position = G.Math.ud2(0, (originPoint.X + screenPos.X) * 0.5, 0, (originPoint.Y + screenPos.Y) * 0.5)
                    line.Rotation = angle
                    line.BackgroundColor3 = color or G.Math.rgb(255, 255, 255)
                    line.Visible = true
                end
            end

            -- 1. Трейсеры ко всем активным объектам (двери, ключи, вентили, монстры, рычаги)
            for obj, data in pairs(S.activeHighlights) do
                if currentCount >= POOL_SIZE then break end
                if obj and obj.Parent then
                    local targetPos = (data.adorneePart and data.adorneePart:IsA("BasePart") and data.adorneePart.Position) or getPivotPos(obj)
                    if targetPos then
                        local colors = HIGHLIGHT_COLORS[data.typeName] or HIGHLIGHT_COLORS[data.itemKey] or HIGHLIGHT_COLORS.item
                        local lineColor = (colors and colors[1]) or G.Math.rgb(255, 255, 255)
                        drawTracerTo(targetPos, lineColor)
                    end
                end
            end

            -- 2. Трейсеры к союзникам (игрокам)
            if states.playerEsp and S.activePlayerHighlights then
                for p, pData in pairs(S.activePlayerHighlights) do
                    if currentCount >= POOL_SIZE then break end
                    if p and p.Parent and pData.root and pData.root.Parent then
                        local pColor = HIGHLIGHT_COLORS.player and HIGHLIGHT_COLORS.player[1] or G.Math.rgb(255, 225, 60)
                        drawTracerTo(pData.root.Position, pColor)
                    end
                end
            end

            -- 3. Авто-трейсер к следующей двери, даже если "Door ESP" выключен!
            if not states.espDoors and currentCount < POOL_SIZE and S.getTargetDoorStrict then
                local targetDoor = S.getTargetDoorStrict()
                if targetDoor and targetDoor.Parent then
                    local dPos = getPivotPos(targetDoor)
                    if dPos then
                        drawTracerTo(dPos, HIGHLIGHT_COLORS.door and HIGHLIGHT_COLORS.door[1] or G.Math.rgb(150, 200, 255))
                    end
                end
            end

            -- Скрываем свободные линии пула
            for j = currentCount + 1, POOL_SIZE do
                if S.tracerPool[j] then
                    S.tracerPool[j].Visible = false
                end
            end
        end
    end

    -- ====================================================================
    --                  СИСТЕМА ESP И СКАНЕРЫ КОМНАТ
    -- ====================================================================
    local function SetupESPAndScanners(S)
        -- [ПЕРЕНЕСЕНО СЮДА]: Теперь таблица видна для всех функций ниже
        local scannedRooms = setmetatable({}, {__mode = "k"})

        S.updateCachedScreenCenter = function()
            local cam = G.Services.Workspace.CurrentCamera or Camera
            if cam then
                S.CachedScreenCenter = Vector2.new(cam.ViewportSize.X * 0.5, cam.ViewportSize.Y)
            end
        end

        S.clearRoomCaches = function()
            table.clear(scannedRooms)
            table.clear(objectRoomMap)
        end
        S.updateCachedScreenCenter()
        S.CachedCurrentRoom = 0
        S.updateCachedRoom = function()
            local attr = nil
            pcall(function()
                local raw = player and player:GetAttribute("CurrentRoom")
                if raw ~= nil then attr = tonumber(raw) end
            end)
            if attr then 
                S.CachedCurrentRoom = attr 
                return attr 
            end

            pcall(function()
                local gd = G.Services.ReplicatedStorage:FindFirstChild("GameData")
                local lr = gd and gd:FindFirstChild("LatestRoom")
                if lr and lr:IsA("ValueBase") and lr.Value ~= nil then
                    local n = tonumber(lr.Value)
                    if n then attr = n end
                end
            end)
            if attr then 
                S.CachedCurrentRoom = attr 
                return attr 
            end

            local char = player and player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not hrp or not cr then return S.CachedCurrentRoom end

            local closestIndex, closestDist = S.CachedCurrentRoom, math.huge
            local myP = hrp.Position
            for _, room in ipairs(cr:GetChildren()) do
                local num = tonumber(tostring(room.Name))
                if num then
                    local pivot = getPivotPos(room)
                    if pivot then
                        local dx, dy, dz = pivot.X - myP.X, pivot.Y - myP.Y, pivot.Z - myP.Z
                        local dSq = dx*dx + dy*dy + dz*dz
                        if dSq < closestDist then
                            closestDist = dSq
                            closestIndex = num
                        end
                    end
                end
            end
            S.CachedCurrentRoom = closestIndex
            return closestIndex
        end
        S.updateCachedRoom()

        S.getCurrentRoomNumber = function()
            return S.CachedCurrentRoom
        end

        S.getObjectRoomNumber = function(obj)
            if not obj then return nil end
            if objectRoomMap[obj] ~= nil then 
                return objectRoomMap[obj] or nil 
            end
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not cr then return nil end
            local cur = obj
            while cur and cur.Parent do
                if cur.Parent == cr then 
                    local num = tonumber(tostring(cur.Name))
                    if num then
                        objectRoomMap[obj] = num
                        return num
                    end
                end
                cur = cur.Parent
            end
            objectRoomMap[obj] = false
            return nil
        end

        S.isObjectInAllowedRooms = function(obj)
            if not obj or not obj.Parent then return false end
            if isMonsterInstance(obj) or (obj.Name and MONSTER_ESP_NAMES[obj.Name]) then return true end

            local rNum = S.getObjectRoomNumber(obj)
            local curRoom = S.CachedCurrentRoom
            if rNum ~= nil then 
                return (rNum >= curRoom - 1) and (rNum <= curRoom + 2) 
            end

            if obj:IsA("Player") or (player.Character and obj:IsDescendantOf(player.Character)) then return true end

            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local pPos = getPivotPos(obj)
            if hrp and pPos then 
                local maxAllowed = isTouchDevice and 140 or 170
                local dx, dy, dz = pPos.X - hrp.Position.X, pPos.Y - hrp.Position.Y, pPos.Z - hrp.Position.Z
                return (dx*dx + dy*dy + dz*dz) <= (maxAllowed * maxAllowed)
            end
            return false
        end

        S.purgeOldRoomESP = function()
            local curRoom = S.CachedCurrentRoom
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local myPos = hrp and hrp.Position
            local maxAllowedSq = isTouchDevice and (150 * 150) or (190 * 190)

            for obj, data in pairs(S.activeHighlights) do
                local shouldRemove = false

                if not obj or not obj.Parent then
                    shouldRemove = true
                elseif data.isMonster or isMonsterInstance(obj, data.typeName) then
                    shouldRemove = false
                else
                    local rNum = S.getObjectRoomNumber(obj)
                    if rNum ~= nil then
                        if rNum < curRoom - 1 or rNum > curRoom + 2 then 
                            shouldRemove = true 
                        end
                    elseif myPos then
                        local objPos = getPivotPos(obj)
                        if not objPos then
                            shouldRemove = true
                        else
                            local dx, dy, dz = objPos.X - myPos.X, objPos.Y - myPos.Y, objPos.Z - myPos.Z
                            if (dx*dx + dy*dy + dz*dz) > maxAllowedSq then 
                                shouldRemove = true 
                            end
                        end
                    end
                end

                if shouldRemove then
                    if data.group then pcall(function() data.group:Destroy() end) end
                    if S.activeTracers and S.activeTracers[obj] then 
                        pcall(function() S.activeTracers[obj]:Destroy() end) 
                        S.activeTracers[obj] = nil 
                    end
                    if S.tracerLines and S.tracerLines[obj] then
                        pcall(function() S.tracerLines[obj]:Remove() end)
                        S.tracerLines[obj] = nil
                    end
                    S.activeHighlights[obj] = nil
                    objectRoomMap[obj] = nil
                end
            end
        end
        -- ====================================================================
        --     1. GPS: УЛЬТРА-БЫСТРЫЙ (ОДНОКРАТНЫЙ РАСЧЕТ И КЭШ ТРАССЫ)
        -- ====================================================================
        S.GPS = {
            AnchorPart = nil,
            PoolSize = isTouchDevice and 26 or 40,
            Beams = {},
            Attachments = {},
            LastCompute = 0,
            LastPlayerPos = Vector3.new(0, 0, 0),
            Initialized = false,
            CachedTrack = nil,
            LastSolvedRoom = -1
        }

        local function getGpsAnchorPart()
            if S.GPS.AnchorPart and S.GPS.AnchorPart.Parent then return S.GPS.AnchorPart end
            local part = Instance.new("Part")
            part.Name = "HubGPS_AnchorBase"
            part.Anchored = true
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
            part.Transparency = 1
            part.Size = Vector3.new(1, 1, 1)
            part.CFrame = CFrame.new(0, 0, 0)
            part.Parent = workspace.Terrain
            S.GPS.AnchorPart = part
            return part
        end

        local function initGpsPool()
            if S.GPS.Initialized and #S.GPS.Beams > 0 then return end
            local anchor = getGpsAnchorPart()

            for i = 1, S.GPS.PoolSize do
                local att = Instance.new("Attachment")
                att.Name = "GPS_Att_" .. i
                att.Parent = anchor
                S.GPS.Attachments[i] = att
            end

            for i = 1, S.GPS.PoolSize - 1 do
                local beam = Instance.new("Beam")
                beam.Name = "GPS_Beam_" .. i
                beam.Attachment0 = S.GPS.Attachments[i]
                beam.Attachment1 = S.GPS.Attachments[i + 1]
                beam.Width0 = 1.4
                beam.Width1 = 1.4
                beam.FaceCamera = true
                beam.Segments = 1

                beam.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 245, 255))
                })
                beam.Transparency = NumberSequence.new(0)
                beam.LightEmission = 1
                beam.LightInfluence = 0
                beam.Enabled = false
                beam.Parent = anchor

                S.GPS.Beams[i] = beam
            end

            S.GPS.Initialized = true
        end

        S.clearGPSPath = function()
            for _, b in ipairs(S.GPS.Beams) do
                b.Enabled = false
            end
        end

        local function isStrictMinecartRange()
            local cur = S.CachedCurrentRoom or 0
            local curDoor = (cur < 100 and cur > 0) and (cur + 100) or cur

            local attrRoom = tonumber(player:GetAttribute("CurrentRoom") or 0) or 0
            local attrDoor = (attrRoom < 100 and attrRoom > 0) and (attrRoom + 100) or attrRoom

            local gd = G.Services.ReplicatedStorage:FindFirstChild("GameData")
            local lr = gd and gd:FindFirstChild("LatestRoom") and tonumber(gd.LatestRoom.Value) or 0
            local lrDoor = (lr < 100 and lr > 0) and (lr + 100) or lr

            -- Определяем реальную дверь игрока
            local playerDoor = (attrDoor > 0) and attrDoor or curDoor

            -- Если игрок уже вошел в 150-ю комнату — сразу выключаем
            if playerDoor >= 150 then
                return false
            end

            -- Если игрок в 149-й, а сервер заранее прелоаднул 150-ю (lrDoor == 150), проверяем дистанцию до входа в 150-ю
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if cr and hrp then
                local room50 = cr:FindFirstChild("50")
                local ent50 = room50 and room50:FindFirstChild("RoomEntrance")
                if ent50 and playerDoor >= 149 then
                    local entPos = getPivotPos(ent50)
                    if entPos and (hrp.Position - entPos).Magnitude < 12 then
                        return false
                    end
                end
            end

            -- Строго с 146 по 149 включительно (в 145-й НЕ включается!)
            if playerDoor >= 146 and playerDoor <= 149 then
                return true
            end

            -- На случай если атрибут CurrentRoom задерживается на 145 в первую секунду въезда в открытую 146-ю
            if lrDoor >= 146 and lrDoor <= 149 and cr and hrp then
                local room46 = cr:FindFirstChild("46")
                local ent46 = room46 and room46:FindFirstChild("RoomEntrance")
                if ent46 then
                    local entPos = getPivotPos(ent46)
                    if entPos and (hrp.Position - entPos).Magnitude < 35 then
                        return true
                    end
                end
            end

            return false
        end

        -- Решает путь A* внутри одной конкретной комнаты (от её входа до её выхода)
        local function solveSingleRoomNodes(room, prevExitPos)
            local rn = room:FindFirstChild("RunnerNodes")
            if not rn then return nil, 0 end

            local nodes = {}
            for _, child in ipairs(rn:GetChildren()) do
                if child:IsA("BasePart") then
                    nodes[#nodes + 1] = child.Position
                end
            end
            if #nodes < 2 then return nil, #nodes end

            local rEnt = room:FindFirstChild("RoomEntrance")
            local door = room:FindFirstChild("Door")
            local rExit = room:FindFirstChild("RoomExit")

            local startRef = (rEnt and getPivotPos(rEnt)) or prevExitPos or nodes[1]
            local endRef = (door and getPivotPos(door)) or (rExit and getPivotPos(rExit)) or nodes[#nodes]

            local startIdx, endIdx = 1, #nodes
            local minStartD, minEndD = math.huge, math.huge

            for i = 1, #nodes do
                local pos = nodes[i]
                local dS = (pos.X - startRef.X)^2 + (pos.Y - startRef.Y)^2 + (pos.Z - startRef.Z)^2
                if dS < minStartD then minStartD = dS; startIdx = i end

                local dE = (pos.X - endRef.X)^2 + (pos.Y - endRef.Y)^2 + (pos.Z - endRef.Z)^2
                if dE < minEndD then minEndD = dE; endIdx = i end
            end

            local neighbors = {}
            local hasEdge = {}
            for i = 1, #nodes do
                neighbors[i] = {}
                hasEdge[i] = {}
            end

            local function addEdge(a, b)
                if a ~= b and not hasEdge[a][b] then
                    hasEdge[a][b] = true
                    hasEdge[b][a] = true
                    neighbors[a][#neighbors[a] + 1] = b
                    neighbors[b][#neighbors[b] + 1] = a
                end
            end

            for i = 1, #nodes do
                local p1 = nodes[i]
                local best1, best2 = nil, nil
                local d1, d2 = math.huge, math.huge

                for j = 1, #nodes do
                    if i ~= j then
                        local p2 = nodes[j]
                        local distSq = (p1.X - p2.X)^2 + (p1.Y - p2.Y)^2 + (p1.Z - p2.Z)^2
                        if distSq <= 784 then -- 28 студов внутри комнаты
                            addEdge(i, j)
                        end
                        if distSq < d1 then
                            d2, best2 = d1, best1
                            d1, best1 = distSq, j
                        elseif distSq < d2 then
                            d2, best2 = distSq, j
                        end
                    end
                end

                -- Гарантируем отсутствие разрывов на прямых участках рельс
                if best1 and d1 <= 2025 then addEdge(i, best1) end
                if best2 and d2 <= 2025 then addEdge(i, best2) end
            end

            local openSet = { startIdx }
            local cameFrom = {}
            local gScore, fScore = {}, {}
            for i = 1, #nodes do gScore[i] = math.huge; fScore[i] = math.huge end
            gScore[startIdx] = 0
            local endPos = nodes[endIdx]
            fScore[startIdx] = (nodes[startIdx] - endPos).Magnitude
            local closedSet = {}

            local closestIdx = startIdx
            local closestDist = fScore[startIdx]

            while #openSet > 0 do
                local current = openSet[1]
                local curOpenIdx = 1
                for k = 2, #openSet do
                    local n = openSet[k]
                    if fScore[n] < fScore[current] then current = n; curOpenIdx = k end
                end

                if current == endIdx then
                    closestIdx = endIdx
                    break
                end

                table.remove(openSet, curOpenIdx)
                closedSet[current] = true

                local curP = nodes[current]
                local dGoal = (curP - endPos).Magnitude
                if dGoal < closestDist then
                    closestDist = dGoal
                    closestIdx = current
                end

                for _, nb in ipairs(neighbors[current]) do
                    if not closedSet[nb] then
                        local nbP = nodes[nb]
                        local tentG = gScore[current] + (curP - nbP).Magnitude
                        if tentG < gScore[nb] then
                            cameFrom[nb] = current
                            gScore[nb] = tentG
                            fScore[nb] = tentG + (nbP - endPos).Magnitude
                            local found = false
                            for _, o in ipairs(openSet) do if o == nb then found = true break end end
                            if not found then openSet[#openSet + 1] = nb end
                        end
                    end
                end
            end

            local roomPath = {}
            local curr = closestIdx
            while curr do
                table.insert(roomPath, 1, nodes[curr])
                curr = cameFrom[curr]
            end
            return roomPath, #nodes
        end

        -- Собирает и сшивает пути строго для комнат 46, 47, 48, 49 (двери 146..149)
        local function computeCleanTrackOnce()
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not cr then return nil, 0 end

            local rawTrack = {}
            local totalNodes = 0
            local lastExitPos = nil

            for rNum = 46, 50 do
                local room = cr:FindFirstChild(tostring(rNum))
                if room then
                    local roomPath, rNodeCount = solveSingleRoomNodes(room, lastExitPos)
                    totalNodes = totalNodes + (rNodeCount or 0)
                    if roomPath and #roomPath >= 2 then
                        for i = 1, #roomPath do
                            local pt = roomPath[i]
                            if #rawTrack == 0 or (pt - rawTrack[#rawTrack]).Magnitude > 1.5 then
                                rawTrack[#rawTrack + 1] = pt
                            end
                        end
                        lastExitPos = rawTrack[#rawTrack]
                    end
                end
            end

            if #rawTrack < 2 then return nil, 0 end

            -- Интерполяция длинных сегментов по 7 студов для плавного скольжения лучей впереди игрока
            local smoothTrack = {}
            for i = 1, #rawTrack - 1 do
                local a = rawTrack[i]
                local b = rawTrack[i + 1]
                local dist = (b - a).Magnitude
                local steps = math.max(1, math.floor(dist / 7))
                for s = 0, steps - 1 do
                    smoothTrack[#smoothTrack + 1] = a:Lerp(b, s / steps)
                end
            end
            smoothTrack[#smoothTrack + 1] = rawTrack[#rawTrack]

            return smoothTrack, totalNodes
        end

        S.updateGPSPath = function()
            if not states.gpsPath or not S.Runtime.running or not isStrictMinecartRange() then
                S.clearGPSPath()
                S.GPS.CachedTrack = nil
                S.GPS.LastNodeCount = 0
                return
            end

            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then S.clearGPSPath() return end

            local now = tick()
            local curRoom = S.CachedCurrentRoom or 0

            -- Проверяем появление новых комнат (46..49) каждые 0.35 сек, чтобы мгновенно достраивать линию вперед
            if not S.GPS.CachedTrack or S.GPS.LastSolvedRoom ~= curRoom or (now - (S.GPS.LastCompute or 0) > 0.35) then
                S.GPS.LastCompute = now
                local newTrack, nodeCount = computeCleanTrackOnce()
                if newTrack and #newTrack >= 2 then
                    if not S.GPS.CachedTrack or nodeCount ~= (S.GPS.LastNodeCount or 0) or S.GPS.LastSolvedRoom ~= curRoom then
                        S.GPS.CachedTrack = newTrack
                        S.GPS.LastNodeCount = nodeCount
                        S.GPS.LastSolvedRoom = curRoom
                    end
                end
            end

            local track = S.GPS.CachedTrack
            if not track or #track < 2 then S.clearGPSPath() return end

            local pPos = hrp.Position
            initGpsPool()

            -- Находим ближайшую точку трассы к игроку
            local closestIdx = 1
            local minD = math.huge
            for i = 1, #track do
                local tPos = track[i]
                local d = (tPos.X - pPos.X)^2 + ((tPos.Y - pPos.Y) * 1.5)^2 + (tPos.Z - pPos.Z)^2
                if d < minD then
                    minD = d
                    closestIdx = i
                end
            end

            local maxBeams = S.GPS.PoolSize
            local finishIdx = math.min(#track, closestIdx + maxBeams - 1)
            local count = 0

            for i = closestIdx, finishIdx do
                count = count + 1
                local att = S.GPS.Attachments[count]
                if att then
                    att.WorldPosition = track[i] + Vector3.new(0, 0.6, 0)
                end
            end

            for i = 1, S.GPS.PoolSize - 1 do
                local beam = S.GPS.Beams[i]
                if beam then
                    beam.Enabled = (i < count)
                end
            end
        end

        S.toggleGPSPath = function(enabled)
            states.gpsPath = enabled
            if not enabled or not isStrictMinecartRange() then
                S.clearGPSPath()
                S.GPS.CachedTrack = nil
                S.GPS.LastNodeCount = 0
            else
                task.spawn(S.updateGPSPath)
            end
        end

        -- Очистка старых платформ в Workspace при перезапуске скрипта
        pcall(function()
            for _, ch in ipairs(G.Services.Workspace:GetChildren()) do
                if ch.Name == "HubSafeBridgePlatform" then
                    ch:Destroy()
                end
            end
        end)

        S.BridgePatcher = {
            ActiveBridges = setmetatable({}, {__mode = "k"}),
            Completed = setmetatable({}, {__mode = "k"}),
            Pending = setmetatable({}, {__mode = "k"}),
            ScannedRooms = setmetatable({}, {__mode = "k"}),
            DisabledKills = setmetatable({}, {__mode = "k"}),
            Conn = nil
        }

        local function getBridgeRoomModel(inst)
            if not inst then return nil end
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if cr then
                local cur = inst
                while cur and cur.Parent do
                    if cur.Parent == cr then
                        return cur
                    end
                    cur = cur.Parent
                end
            end
            return inst:FindFirstAncestorOfClass("Model")
        end

        local function getFlatHorizontalCFrame(pos, sourceCF)
            local look = sourceCF.LookVector
            local flatLook = Vector3.new(look.X, 0, look.Z)
            if flatLook.Magnitude < 0.001 then
                flatLook = Vector3.new(0, 0, -1)
            else
                flatLook = flatLook.Unit
            end
            return CFrame.lookAt(pos, pos + flatLook)
        end

        local function spawnBridgeSegment(keyObj, cframe, sizeVec)
            local existing = S.BridgePatcher.ActiveBridges[keyObj]
            if existing and existing.Parent then
                existing.Size = sizeVec
                existing.CFrame = cframe
                return
            end

            local bridge = Instance.new("Part")
            bridge.Name = "HubSafeBridgePlatform"
            bridge.Anchored = true
            bridge.CanCollide = true
            bridge.CanTouch = false
            bridge.CanQuery = false
            bridge.CastShadow = false
            bridge.Transparency = 0 -- 0 = полностью непрозрачный, 0.35 = полупрозрачный
            bridge.Color = Color3.fromRGB(225, 225, 255) -- Голубой цвет (чтобы было видно в темноте Шахт)
            bridge.Material = Enum.Material.ForceField -- Или Enum.Material.Neon / Enum.Material.WoodPlanks
            bridge.TopSurface = Enum.SurfaceType.Smooth
            bridge.BottomSurface = Enum.SurfaceType.Smooth
            bridge.Size = sizeVec
            bridge.CFrame = cframe
            bridge.Parent = G.Services.Workspace

            S.BridgePatcher.ActiveBridges[keyObj] = bridge

            keyObj.AncestryChanged:Connect(function(_, parentInst)
                if not parentInst then
                    if bridge and bridge.Parent then
                        pcall(function() bridge:Destroy() end)
                    end
                    S.BridgePatcher.ActiveBridges[keyObj] = nil
                    S.BridgePatcher.Completed[keyObj] = nil
                    S.BridgePatcher.Pending[keyObj] = nil
                end
            end)
        end

        -- 1. Отключаем только смертельный урон у KillBrick (без создания гигантской плиты на всю пещеру)
        S.patchKillBrick = function(kb)
            if not states.bridgePatch or not kb or not kb:IsA("BasePart") or not kb.Parent then return end
            if S.BridgePatcher.Completed[kb] then return end

            S.BridgePatcher.Completed[kb] = true
            S.BridgePatcher.DisabledKills[kb] = true
            pcall(function()
                kb.CanTouch = false
                kb.CanQuery = false
                kb.CanCollide = false
                local tt = kb:FindFirstChildWhichIsA("TouchTransmitter")
                if tt then tt:Destroy() end
            end)
        end

        -- 2. Соединяет верхние края разрыва (PlayerBarrier) между двумя половинами моста в комнате
        S.patchRoomStaticBridges = function(room)
            if not states.bridgePatch or not room or not room.Parent then return end

            local allBarriers = {}
            for _, ch in ipairs(room:GetChildren()) do
                if ch.Name == "Parts" then
                    for _, sub in ipairs(ch:GetChildren()) do
                        if sub.Name == "Bridge" then
                            for _, part in ipairs(sub:GetChildren()) do
                                if part:IsA("BasePart") and part.Name == "PlayerBarrier" and part.Size.X > 12 and part.Size.Y < 4 then
                                    allBarriers[#allBarriers + 1] = part
                                end
                            end
                        elseif sub:IsA("BasePart") and sub.Name == "PlayerBarrier" and sub.Size.X > 12 and sub.Size.Y < 4 then
                            allBarriers[#allBarriers + 1] = sub
                        end
                    end
                end
            end

            if #allBarriers < 2 then
                return
            end

            -- Оставляем только верхние горизонтальные края обрыва (отсеиваем наклонные пандусы, которые на 0.65 студа ниже)
            local topEdges = {}
            for i = 1, #allBarriers do
                local cur = allBarriers[i]
                local isLowerRamp = false
                for j = 1, #allBarriers do
                    if i ~= j then
                        local other = allBarriers[j]
                        if (other.Position - cur.Position).Magnitude < 9.0 and (other.Position.Y > cur.Position.Y + 0.2) then
                            isLowerRamp = true
                            break
                        end
                    end
                end
                if not isLowerRamp then
                    topEdges[#topEdges + 1] = cur
                end
            end

            local used = {}
            for i = 1, #topEdges do
                local a = topEdges[i]
                if not used[a] and not S.BridgePatcher.Completed[a] then
                    local bestB = nil
                    local bestDist = math.huge
                    for j = i + 1, #topEdges do
                        local b = topEdges[j]
                        if not used[b] and not S.BridgePatcher.Completed[b] then
                            if math.abs(a.Position.Y - b.Position.Y) < 1.0 then
                                local dist = (a.Position - b.Position).Magnitude
                                if dist >= 12.0 and dist <= 28.0 and dist < bestDist then
                                    bestDist = dist
                                    bestB = b
                                end
                            end
                        end
                    end

                    if bestB then
                        used[a] = true
                        used[bestB] = true
                        S.BridgePatcher.Completed[a] = true
                        S.BridgePatcher.Completed[bestB] = true

                        local midPos = (a.Position + bestB.Position) * 0.5
                        local width = a.Size.X -- 15.12
                        local height = a.Size.Y -- 2.75 (TopY ровно -26.54)
                        local lookCF = CFrame.lookAt(midPos, bestB.Position)

                        spawnBridgeSegment(a, lookCF, Vector3.new(width, height, bestDist))
                        S.BridgePatcher.Pending[room] = nil
                    else
                        S.BridgePatcher.Pending[room] = "RoomStaticBridges"
                    end
                end
            end
        end

        -- 3. Точная заплатка (15.12 x 15.8) для обрушающихся мостов LiveObstructionBridge в Room 44
        S.patchObstructionBridge = function(bridgeModel)
            if not states.bridgePatch or not bridgeModel or not bridgeModel.Parent then return end
            if S.BridgePatcher.Completed[bridgeModel] then return end

            local col = bridgeModel:FindFirstChild("Collision") or bridgeModel:FindFirstChild("AnimateCore")
            if not col or not col:IsA("BasePart") then
                S.BridgePatcher.Pending[bridgeModel] = "ObstructionBridge"
                return
            end

            local deckY = col.Position.Y + 0.62
            for _, ch in ipairs(bridgeModel:GetChildren()) do
                if ch:IsA("BasePart") and ch.Name:find("^Part%d+") then
                    deckY = ch.Position.Y + (ch.Size.Y * 0.5)
                    break
                end
            end

            local thickness = 0.35
            local targetPos = Vector3.new(col.Position.X, deckY - (thickness * 0.5), col.Position.Z)
            local targetCF = getFlatHorizontalCFrame(targetPos, col.CFrame)
            local sx = math.clamp(col.Size.X, 14.0, 15.2)
            local sz = math.clamp(col.Size.Z, 14.0, 16.0)

            spawnBridgeSegment(bridgeModel, targetCF, Vector3.new(sx, thickness, sz))
            S.BridgePatcher.Completed[bridgeModel] = true
            S.BridgePatcher.Pending[bridgeModel] = nil
        end

        local function checkAndPatchObject(inst)
            if not inst or not inst.Parent or S.BridgePatcher.Completed[inst] then return end

            if inst:IsA("BasePart") then
                local n = inst.Name
                if n == "KillBrick" or n == "killbrick" or inst:GetAttribute("DeathCause") == "Seek" or inst:GetAttribute("DeathReason") == "JumpFail" then
                    S.patchKillBrick(inst)
                elseif n == "PlayerBarrier" then
                    local rm = getBridgeRoomModel(inst)
                    if rm then S.patchRoomStaticBridges(rm) end
                end
            elseif inst:IsA("Model") or inst:IsA("Folder") then
                local n = inst.Name
                if n == "LiveObstructionBridge" or n:find("ObstructionBridge") then
                    S.patchObstructionBridge(inst)
                elseif n == "Bridge" then
                    local rm = getBridgeRoomModel(inst)
                    if rm then S.patchRoomStaticBridges(rm) end
                end
            end
        end

        S.patchRoomBridges = function(room)
            if not room or not room.Parent or not states.bridgePatch then return end
            if S.BridgePatcher.ScannedRooms[room] then return end
            S.BridgePatcher.ScannedRooms[room] = true

            for _, ch in ipairs(room:GetChildren()) do
                checkAndPatchObject(ch)
            end

            S.patchRoomStaticBridges(room)

            local assets = room:FindFirstChild("Assets")
            if assets then
                for _, ch in ipairs(assets:GetChildren()) do
                    checkAndPatchObject(ch)
                end
            end
        end

        S.toggleBridgePatch = function(enabled)
            states.bridgePatch = enabled
            if enabled then
                table.clear(S.BridgePatcher.ScannedRooms)
                local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
                if cr then
                    for _, room in ipairs(cr:GetChildren()) do
                        S.patchRoomBridges(room)
                    end
                end
            else
                for _, bridge in pairs(S.BridgePatcher.ActiveBridges) do
                    if bridge and bridge.Parent then pcall(function() bridge:Destroy() end) end
                end
                for _, ch in ipairs(G.Services.Workspace:GetChildren()) do
                    if ch.Name == "HubSafeBridgePlatform" then
                        pcall(function() ch:Destroy() end)
                    end
                end
                for kb in pairs(S.BridgePatcher.DisabledKills) do
                    if kb and kb.Parent and kb:IsA("BasePart") then pcall(function() kb.CanTouch = true end) end
                end
                table.clear(S.BridgePatcher.ActiveBridges)
                table.clear(S.BridgePatcher.Completed)
                table.clear(S.BridgePatcher.Pending)
                table.clear(S.BridgePatcher.ScannedRooms)
                table.clear(S.BridgePatcher.DisabledKills)
            end
        end

        local currentRooms = G.Services.Workspace:WaitForChild("CurrentRooms", 8)
        if currentRooms and not S.BridgePatcher.Conn then
            S.BridgePatcher.Conn = currentRooms.DescendantAdded:Connect(function(desc)
                if states.bridgePatch then
                    checkAndPatchObject(desc)
                end
            end)
            S.Runtime.connections[#S.Runtime.connections + 1] = S.BridgePatcher.Conn
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 1.0 or 0.7)
                if states.bridgePatch then
                    local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
                    if cr then
                        local cur = S.CachedCurrentRoom or 0
                        for r = cur - 1, cur + 2 do
                            local rm = cr:FindFirstChild(tostring(r))
                            if rm and not S.BridgePatcher.ScannedRooms[rm] then
                                S.patchRoomBridges(rm)
                            end
                        end
                    end

                    for target, kind in pairs(S.BridgePatcher.Pending) do
                        if not target or not target.Parent then
                            S.BridgePatcher.Pending[target] = nil
                        elseif kind == "KillBrick" then
                            S.patchKillBrick(target)
                        elseif kind == "RoomStaticBridges" then
                            S.patchRoomStaticBridges(target)
                        elseif kind == "ObstructionBridge" then
                            S.patchObstructionBridge(target)
                        end
                    end
                end
            end
        end)
        -- HONCHO STORAGE & DEPOSIT ESP
        S.HonchoData = {
            activeHighlights = {},
            activeBillboards = {},
            trackedObjects = {}
        }

        local honchoPartCache = setmetatable({}, {__mode = "k"})

        local function cleanHonchoString(str)
            if not str then return "" end
            local clean = string.upper(tostring(str))
            return string.gsub(clean, "%s+", "")
        end

        local function findAnyBasePart(instance)
            if not instance then return nil end
            if honchoPartCache[instance] and honchoPartCache[instance].Parent then
                return honchoPartCache[instance]
            end

            if instance:IsA("BasePart") then
                honchoPartCache[instance] = instance
                return instance
            end

            if instance:IsA("Model") and instance.PrimaryPart then
                honchoPartCache[instance] = instance.PrimaryPart
                return instance.PrimaryPart
            end

            local mainPart = instance:FindFirstChild("Main") or instance:FindFirstChild("Base") or instance:FindFirstChild("Handle")
            if mainPart and mainPart:IsA("BasePart") then
                honchoPartCache[instance] = mainPart
                return mainPart
            end

            local recursivePart = instance:FindFirstChildWhichIsA("BasePart", true)
            if recursivePart then
                honchoPartCache[instance] = recursivePart
                return recursivePart
            end

            return nil
        end

        local function removeHonchoESP(instance)
            if S.HonchoData.activeHighlights[instance] then
                if S.HonchoData.activeHighlights[instance].Parent then
                    S.HonchoData.activeHighlights[instance]:Destroy()
                end
                S.HonchoData.activeHighlights[instance] = nil
            end
            if S.HonchoData.activeBillboards[instance] then
                if S.HonchoData.activeBillboards[instance].Parent then
                    S.HonchoData.activeBillboards[instance]:Destroy()
                end
                S.HonchoData.activeBillboards[instance] = nil
            end
            S.HonchoData.trackedObjects[instance] = nil
            honchoPartCache[instance] = nil
        end

        S.clearAllHonchoESP = function()
            for inst in pairs(S.HonchoData.trackedObjects) do
                removeHonchoESP(inst)
            end
            table.clear(S.HonchoData.activeHighlights)
            table.clear(S.HonchoData.activeBillboards)
            table.clear(S.HonchoData.trackedObjects)
            table.clear(honchoPartCache)
        end

        local function createHonchoESP(targetModel, labelPrefix, codeText, mainColor)
            if not targetModel or not targetModel.Parent then return end

            local existing = S.HonchoData.trackedObjects[targetModel]
            if existing then
                if existing.Prefix == labelPrefix and existing.Code == codeText then
                    if S.HonchoData.activeHighlights[targetModel] then
                        S.HonchoData.activeHighlights[targetModel].FillColor = mainColor
                    end
                    if existing.Label then
                        existing.Label.TextColor3 = mainColor
                    end
                    return
                end
            end

            removeHonchoESP(targetModel)

            local highlight = Instance.new("Highlight")
            highlight.Name = "Honcho_Highlight"
            highlight.FillColor = mainColor
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.3
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Adornee = targetModel
            highlight.Parent = targetModel
            S.HonchoData.activeHighlights[targetModel] = highlight

            local adorneePart = findAnyBasePart(targetModel)
            if adorneePart then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "Honcho_Billboard"
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0, 180, 0, 40)
                billboard.StudsOffset = Vector3.new(0, 2.2, 0)
                billboard.Adornee = adorneePart

                local textLabel = Instance.new("TextLabel")
                textLabel.Name = "InfoLabel"
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = mainColor
                textLabel.TextStrokeTransparency = 0
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.TextSize = 17
                textLabel.Text = "[" .. labelPrefix .. ": " .. codeText .. "]"
                textLabel.Parent = billboard

                billboard.Parent = adorneePart

                S.HonchoData.activeBillboards[targetModel] = billboard
                S.HonchoData.trackedObjects[targetModel] = {
                    Prefix = labelPrefix,
                    Code = codeText,
                    Label = textLabel,
                    Part = adorneePart,
                    lastDist = -1
                }
            end
        end

        local function getMyAssignedCode()
            local char = player.Character
            if char then
                for _, item in ipairs(char:GetChildren()) do
                    if item:IsA("Tool") or item.Name == "ArchivesStorageBox" then
                        local boxId = item:GetAttribute("Tool_BoxID") or item:GetAttribute("BoxID")
                        if boxId then return cleanHonchoString(boxId) end
                    end
                end
            end

            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                for _, item in ipairs(backpack:GetChildren()) do
                    if item:IsA("Tool") or item.Name == "ArchivesStorageBox" then
                        local boxId = item:GetAttribute("Tool_BoxID") or item:GetAttribute("BoxID")
                        if boxId then return cleanHonchoString(boxId) end
                    end
                end
            end

            local pGui = player:FindFirstChild("PlayerGui")
            local permUI = pGui and pGui:FindFirstChild("PermUI")
            local honchoComplete = permUI and permUI:FindFirstChild("HonchoComplete", true)
            if honchoComplete then
                for _, item in ipairs(honchoComplete:GetChildren()) do
                    if item:IsA("ImageLabel") and item.Visible then
                        local num = item:FindFirstChild("Number") or item:FindFirstChildWhichIsA("TextLabel")
                        if num and num.Text ~= "" then
                            return cleanHonchoString(num.Text)
                        end
                    end
                end
            end

            return nil
        end

        local function extractBoxOrDepositCode(obj, isDeposit)
            local attr = isDeposit and obj:GetAttribute("BoxID") or (obj:GetAttribute("Tool_BoxID") or obj:GetAttribute("BoxID"))
            if attr and tostring(attr) ~= "" then
                return cleanHonchoString(attr)
            end
            local lbl = obj:FindFirstChild("Label", true) or obj:FindFirstChild("Number", true)
            if lbl and lbl:IsA("TextLabel") and lbl.Text ~= "" then
                return cleanHonchoString(lbl.Text)
            end
            return ""
        end

        S.updateHonchoScan = function()
            if not states.honchoBoxEsp then
                S.clearAllHonchoESP()
                return
            end

            local ws = G.Services.Workspace
            local currentRooms = ws:FindFirstChild("CurrentRooms")
            if not currentRooms then
                S.clearAllHonchoESP()
                return
            end

            local curRoomNum = S.CachedCurrentRoom or tonumber(player:GetAttribute("CurrentRoom")) or 0
            local activeRoom = currentRooms:FindFirstChild(tostring(curRoomNum))
            if not activeRoom then
                S.clearAllHonchoESP()
                return
            end

            local myCode = getMyAssignedCode()
            local roomDepositCodes = {}
            local validDeposits = {}
            local validBoxes = {}

            -- 1. Сканируем ТОЛЬКО активную комнату игрока (чтобы старые секции 203, 204, 205 не мешали!)
            for _, child in ipairs(activeRoom:GetChildren()) do
                if child:IsA("Model") and (child.Name == "ArchivesPackageDeposit" or (child.Name:find("Deposit") and child:GetAttribute("BoxID") ~= nil)) then
                    -- Если внутри BoxPart уже лежит сданная коробка (Tool) или есть атрибут Depositor — этот приемник уже выполнен!
                    local boxPart = child:FindFirstChild("BoxPart")
                    local alreadyFilled = (child:GetAttribute("Depositor") ~= nil) or (boxPart and boxPart:FindFirstChild("ArchivesStorageBox") ~= nil)
                    if not alreadyFilled then
                        local depCode = extractBoxOrDepositCode(child, true)
                        if depCode ~= "" then
                            roomDepositCodes[depCode] = true
                            validDeposits[#validDeposits + 1] = {Model = child, Code = depCode}
                        end
                    end
                elseif child.Name == "ArchivesHonchoRoom" then
                    for _, box in ipairs(child:GetChildren()) do
                        if box:IsA("Model") and box.Name == "ArchivesStorageBox" then
                            local boxCode = extractBoxOrDepositCode(box, false)
                            if boxCode ~= "" then
                                validBoxes[#validBoxes + 1] = {Model = box, Code = boxCode}
                            end
                        end
                    end
                elseif child:IsA("Model") and child.Name == "ArchivesStorageBox" then
                    local boxCode = extractBoxOrDepositCode(child, false)
                    if boxCode ~= "" then
                        validBoxes[#validBoxes + 1] = {Model = child, Code = boxCode}
                    end
                end
            end

            -- 2. Также проверяем выброшенные на пол коробки в Workspace.Drops
            local drops = ws:FindFirstChild("Drops")
            if drops then
                for _, drop in ipairs(drops:GetChildren()) do
                    if drop:IsA("Model") and drop.Name == "ArchivesStorageBox" then
                        local boxCode = extractBoxOrDepositCode(drop, false)
                        if boxCode ~= "" then
                            validBoxes[#validBoxes + 1] = {Model = drop, Code = boxCode}
                        end
                    end
                end
            end

            local currentMatched = {}

            -- Подсвечиваем только нужные коробки для текущей комнаты
            for b = 1, #validBoxes do
                local boxData = validBoxes[b]
                local model = boxData.Model
                local code = boxData.Code

                local isMyCode = (myCode and myCode ~= "" and code == myCode)
                local isRoomCode = (roomDepositCodes[code] == true)

                if isMyCode then
                    currentMatched[model] = true
                    createHonchoESP(model, "YOUR BOX", code, Color3.fromRGB(0, 255, 120))
                elseif isRoomCode then
                    currentMatched[model] = true
                    createHonchoESP(model, "ROOM BOX", code, Color3.fromRGB(255, 220, 40))
                end
            end

            -- Подсвечиваем только незаполненные приемники текущей комнаты
            for d = 1, #validDeposits do
                local depData = validDeposits[d]
                local model = depData.Model
                local code = depData.Code
                local isMyDeposit = (myCode and myCode ~= "" and code == myCode)

                currentMatched[model] = true
                if isMyDeposit then
                    createHonchoESP(model, "YOUR DEPOSIT", code, Color3.fromRGB(200, 70, 255))
                else
                    createHonchoESP(model, "DEPOSIT", code, Color3.fromRGB(80, 180, 255))
                end
            end

            for inst in pairs(S.HonchoData.trackedObjects) do
                if not currentMatched[inst] or not inst.Parent then
                    removeHonchoESP(inst)
                end
            end
        end

        task.spawn(function()
            while S.Runtime.running do
                if states.honchoBoxEsp then
                    pcall(S.updateHonchoScan)
                end
                task.wait(isTouchDevice and 0.8 or 0.5)
            end
        end)

        -- ====================================================================
        -- [ИСПРАВЛЕННЫЙ HIGHLIGHT]: 3D БОКС ДЛЯ ДВЕРЕЙ ЧЕРЕЗ СТЕНЫ (BoxHandleAdornment)
        -- ====================================================================
        local function getDoorNumberStr(obj)
            if not obj then return nil end
            local doorModel = (obj:IsA("Model") and (obj.Name == "Door" or obj.Name == "DoorFake") and obj)
                or obj:FindFirstAncestor("Door")
                or obj:FindFirstAncestor("DoorFake")
                or (obj:IsA("Model") and obj)
                or obj:FindFirstAncestorOfClass("Model")

            if doorModel then
                local sign = doorModel:FindFirstChild("Sign", true) or doorModel:FindFirstChild("StSign", true)
                local signText = sign and (sign:FindFirstChild("SignText", true) or sign:FindFirstChildWhichIsA("TextLabel", true))
                if signText and signText:IsA("TextLabel") and signText.Text ~= "" then
                    local raw = tostring(signText.Text):gsub("^%s*(.-)%s*$", "%1")
                    local asNum = tonumber(raw)
                    if asNum then return tostring(asNum) end
                    if raw ~= "" then return raw end
                end

                local roomId = doorModel:GetAttribute("RoomID")
                if roomId ~= nil then
                    local roomModel = doorModel.Parent
                    local isMines = roomModel and roomModel:GetAttribute("_FromMines") == true
                    local numId = tonumber(roomId)
                    if numId and isMines and numId < 100 then
                        return tostring(numId + 100)
                    end
                    return tostring(roomId)
                end
            end

            local rNum = S.getObjectRoomNumber and S.getObjectRoomNumber(obj)
            if rNum ~= nil then
                return tostring(rNum + 1)
            end
            return nil
        end

        S.applyHighlight = function(obj, typeName, itemKey, rawCustomLabel, isRushLikeMonster)
            if not obj or not obj.Parent then return end
            -- Предметы и объекты внутри JeffShop_Hotel не подсвечиваем никогда
            if isInsideJeffShop(obj) then
                local existing = S.activeHighlights[obj]
                if existing then
                    pcall(function() if existing.group then existing.group:Destroy() end end)
                    S.activeHighlights[obj] = nil
                end
                return
            end
            if S.activeHighlights[obj] then
                if S.activeHighlights[obj].group and S.activeHighlights[obj].group.Parent and S.activeHighlights[obj].adorneePart and S.activeHighlights[obj].adorneePart.Parent then
                    return
                else
                    pcall(function() if S.activeHighlights[obj].group then S.activeHighlights[obj].group:Destroy() end end)
                    S.activeHighlights[obj] = nil
                end
            end

            local isMon = isRushLikeMonster or isMonsterInstance(obj, typeName)
            if isMon and itemKey and not (
                (states.monsterEsp and isMonsterAllowed(itemKey))
                or (itemKey == "figure" and states.figureEsp)
                or (itemKey == "groundskeeper" and states.groundskeeperEsp)
                or (itemKey == "grumble" and states.grumbleEsp)
                or (itemKey == "bramble" and states.brambleEsp)
                or (itemKey == "monument" and states.monumentEsp)
                or (itemKey == "mandrake" and states.mandrakeEsp)
                or (itemKey == "louie" and states.louieEsp)
            ) then
                return
            end
            if not isMon and not S.isObjectInAllowedRooms(obj) then return end

            -- Если это дверь или фейк-дверь — автоматически определяем её номер
            if (typeName == "door" or typeName == "dupe") and not rawCustomLabel then
                rawCustomLabel = getDoorNumberStr(obj)
            end

            local fallbackPart = obj:IsA("BasePart") and obj 
                or (obj:IsA("Model") and (obj:FindFirstChild("Root") or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj:FindFirstChild("Torso") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)))

            if not fallbackPart and obj:IsA("Model") and typeName ~= "door" then
                task.spawn(function()
                    local t0 = tick()
                    while obj and obj.Parent and (tick() - t0 < 6.0) do
                        local foundPart = obj:FindFirstChild("Root") or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj:FindFirstChild("Torso") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                        if foundPart then
                            S.applyHighlight(obj, typeName, itemKey, rawCustomLabel, isRushLikeMonster)
                            break
                        end
                        task.wait(0.15)
                    end
                end)
                return
            end
            
            local colors = HIGHLIGHT_COLORS[typeName] or HIGHLIGHT_COLORS[itemKey] or HIGHLIGHT_COLORS.item
            if not colors then colors = HIGHLIGHT_COLORS.item end
            
            local espGroup = create("Folder", {Name = typeName.."Esp", Parent = obj})

            local targetAdornee = fallbackPart or obj
            local targetPosObj = fallbackPart or obj
            local bbOffset = G.Math.v3(0, 2.2, 0)

            -- Точная привязка для Фигуры и Смотрителя
            if typeName == "figure" or itemKey == "figure" or typeName == "groundskeeper" or itemKey == "groundskeeper" then
                local mainPart = (obj:IsA("Model") and (obj:FindFirstChild("Root") or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj:FindFirstChild("Torso") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)))
                    or (obj:IsA("BasePart") and obj)
                if mainPart then
                    targetAdornee = mainPart
                    targetPosObj = mainPart
                    bbOffset = G.Math.v3(0, 3.5, 0)
                end
            end

            -- Точная привязка для живого Монумента (MonumentEntity -> Top -> Root)
            if typeName == "monument" or itemKey == "monument" then
                if not isRealMonumentEntity(obj) then return end
                local topModel = obj:FindFirstChild("Top")
                local monRoot = (topModel and (topModel:FindFirstChild("Root") or topModel:FindFirstChildWhichIsA("BasePart")))
                    or obj:FindFirstChild("Root", true)
                if monRoot then
                    targetAdornee = monRoot
                    targetPosObj = monRoot
                    bbOffset = G.Math.v3(0, 2.5, 0)
                end
            end

            -- Точная привязка для Луи к детали Darkness
            if typeName == "louie" or itemKey == "louie" then
                local darknessPart = (obj:IsA("BasePart") and obj) 
                    or (obj:IsA("Model") and (obj:FindFirstChild("Darkness", true) or obj:FindFirstChildWhichIsA("BasePart", true)))
                if darknessPart then
                    targetAdornee = darknessPart
                    targetPosObj = darknessPart
                    bbOffset = G.Math.v3(0, 1.6, 0)
                end
            end

            -- СПЕЦИАЛЬНАЯ ПОДСВЕТКА ДЛЯ ДВЕРЕЙ (Невидимый парт + 3D Box ESP)
            if typeName == "door" then
                local doorModel = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model") or obj
                local doorPart = doorModel:FindFirstChild("Door") or (obj:IsA("BasePart") and obj) or doorModel:FindFirstChildWhichIsA("BasePart")
                
                local cf = doorModel:IsA("Model") and doorModel:GetPivot() or (doorPart and doorPart.CFrame) or G.Math.cf()
                local size = Vector3.new(4.6, 8.2, 0.8)

                if doorPart and doorPart:IsA("BasePart") then
                    local origCF = doorPart:FindFirstChild("OriginalCFrameValue")
                    if origCF and origCF:IsA("CFrameValue") then
                        cf = origCF.Value
                    else
                        cf = doorPart.CFrame
                    end
                    size = Vector3.new(
                        math.clamp(doorPart.Size.X, 3.8, 5.5),
                        math.clamp(doorPart.Size.Y, 7.5, 9.2),
                        math.clamp(doorPart.Size.Z, 0.6, 1.5)
                    )
                elseif doorModel:IsA("Model") then
                    local bboxCF, bboxSize = doorModel:GetBoundingBox()
                    cf = bboxCF
                    size = Vector3.new(
                        math.clamp(bboxSize.X, 3.8, 5.5),
                        math.clamp(bboxSize.Y, 7.5, 9.2),
                        math.clamp(bboxSize.Z, 0.6, 1.5)
                    )
                end

                local doorHitbox = Instance.new("Part")
                doorHitbox.Name = "DoorESPHitbox"
                doorHitbox.Size = size
                doorHitbox.CFrame = cf
                doorHitbox.Transparency = 1
                doorHitbox.Anchored = true
                doorHitbox.CanCollide = false
                doorHitbox.CanTouch = false
                doorHitbox.CanQuery = false
                doorHitbox.Material = Enum.Material.SmoothPlastic
                doorHitbox.Parent = espGroup

                local boxAdorn = Instance.new("BoxHandleAdornment")
                boxAdorn.Name = "DoorBoxESP"
                boxAdorn.Adornee = doorHitbox
                boxAdorn.Size = size
                boxAdorn.Color3 = colors[1]
                boxAdorn.Transparency = 0.55
                boxAdorn.AlwaysOnTop = true
                boxAdorn.ZIndex = 10
                boxAdorn.Parent = espGroup

                targetAdornee = doorHitbox
                targetPosObj = doorHitbox
                bbOffset = G.Math.v3(0, (size.Y * 0.5) + 0.8, 0)
            else
                create("Highlight", {
                    Adornee = obj,
                    FillColor = colors[1],
                    OutlineColor = colors[2],
                    FillTransparency = 0.55,
                    OutlineTransparency = 0.15,
                    DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                    Parent = espGroup
                })
            end

            if isRushLikeMonster then
                local adorneePart = obj:IsA("BasePart") and obj or (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true))
                if adorneePart and espGroup and espGroup.Parent then
                    local bSize = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Size or G.Math.v3(6, 6, 6)) or adorneePart.Size
                    if bSize.Magnitude < 2 then bSize = G.Math.v3(6, 6, 6) end
                    create("BoxHandleAdornment", {
                        Name = "RushBoxESP",
                        Adornee = adorneePart,
                        Size = bSize + G.Math.v3(0.6, 0.6, 0.6),
                        Color3 = colors[1],
                        Transparency = 0.5,
                        AlwaysOnTop = true,
                        ZIndex = 10,
                        Parent = espGroup
                    })
                else
                    task.defer(function()
                        if not espGroup or not espGroup.Parent or not obj.Parent then return end
                        local part = obj:IsA("BasePart") and obj or (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true))
                        if part then
                            local bSize = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Size or G.Math.v3(6, 6, 6)) or part.Size
                            if bSize.Magnitude < 2 then bSize = G.Math.v3(6, 6, 6) end
                            create("BoxHandleAdornment", {
                                Name = "RushBoxESP",
                                Adornee = part,
                                Size = bSize + G.Math.v3(0.6, 0.6, 0.6),
                                Color3 = colors[1],
                                Transparency = 0.5,
                                AlwaysOnTop = true,
                                ZIndex = 10,
                                Parent = espGroup
                            })
                        end
                    end)
                end
            end

            -- Текстовая плашка с названием и дистанцией
            local bb = create("BillboardGui", {
                Size = G.Math.ud2(0, 140, 0, 24),
                AlwaysOnTop = true,
                Enabled = (states.espNames ~= false),
                Adornee = targetAdornee,
                StudsOffset = bbOffset,
                MaxDistance = math.huge,
                Parent = espGroup
            })
            local cachedFriendlyName = getEspLocalizedName(typeName, itemKey, rawCustomLabel)
            local textLabel = create("TextLabel", {
                Name = "DistText",
                Size = G.Math.ud2(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Visible = (states.espNames ~= false),
                TextColor3 = colors[1],
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextStrokeTransparency = 0.2,
                TextStrokeColor3 = G.Math.c3(0, 0, 0),
                Text = cachedFriendlyName,
                Parent = bb
            })
            
            S.activeHighlights[obj] = {
                group = espGroup,
                billboard = bb,
                label = textLabel,
                typeName = typeName,
                itemKey = itemKey,
                rawCustomLabel = rawCustomLabel,
                cachedName = cachedFriendlyName,
                lastDist = -999,
                isMonster = isMon,
                adorneePart = targetPosObj
            }

            -- Если табличка двери ещё догружается сервером — дожидаемся SignText и обновляем номер
            if typeName == "door" or typeName == "dupe" then
                task.spawn(function()
                    local t0 = tick()
                    while obj and obj.Parent and S.activeHighlights[obj] and (tick() - t0 < 2.5) do
                        local updatedNum = getDoorNumberStr(obj)
                        if updatedNum and updatedNum ~= S.activeHighlights[obj].rawCustomLabel then
                            S.activeHighlights[obj].rawCustomLabel = updatedNum
                            S.activeHighlights[obj].cachedName = getEspLocalizedName(typeName, itemKey, updatedNum)
                            S.activeHighlights[obj].lastDist = -999
                            if not states.distanceEsp and S.activeHighlights[obj].label then
                                S.activeHighlights[obj].label.Text = S.activeHighlights[obj].cachedName
                            end
                            break
                        end
                        task.wait(0.25)
                    end
                end)
            end
            
            obj.AncestryChanged:Connect(function(_, p)
                if not p then
                    if S.activeHighlights[obj] then
                        pcall(function() if S.activeHighlights[obj].group then S.activeHighlights[obj].group:Destroy() end end)
                        S.activeHighlights[obj] = nil
                    end
                    if S.tracerLines and S.tracerLines[obj] then
                        pcall(function() S.tracerLines[obj]:Remove() end)
                        S.tracerLines[obj] = nil
                    end
                    objectRoomMap[obj] = nil
                end
            end)
        end

        S.triggerMonsterAlert = function(rawName, sourceObj)
            if not rawName or type(rawName) ~= "string" then return end
            if not states or type(states) ~= "table" then return end

            local conf = ALERT_NAMES[rawName]
            if not conf then
                local l = rawName:lower()
                if l:find("scribble") then conf = {st="scribblesAlert", msg="msgScribbles"}
                elseif l:find("bush") then conf = {st="bushAlert", msg="msgBush"}
                elseif l:find("bash") then conf = {st="bashAlert", msg="msgBash"}
                elseif l:find("frozenambush") then conf = {st="frozenAmbushAlert", msg="msgFrozenAmbush"}
                elseif l:find("ambush") then conf = {st="ambushAlert", msg="msgAmbush"}
                elseif l:find("a60") or l:find("a-60") then conf = {st="a60Alert", msg="msgA60"}
                elseif l:find("a120") or l:find("a-120") or l:find("a160") or l:find("a-160") then conf = {st="a120Alert", msg="msgA120"}
                elseif l:find("blitz") then conf = {st="blitzAlert", msg="msgBlitz"}
                elseif l:find("rush") then conf = {st="rushAlert", msg="msgRush"}
                end
            end

            if conf and conf.st and states[conf.st] == true then
                local rootModel = sourceObj
                if sourceObj and typeof(sourceObj) == "Instance" then
                    rootModel = (sourceObj:IsA("Model") and sourceObj) or sourceObj:FindFirstAncestorOfClass("Model") or sourceObj
                end

                if rootModel and typeof(rootModel) == "Instance" then
                    if rootModel:GetAttribute("HubAlerted") == true or S.alertedEntities[rootModel] then return end
                    rootModel:SetAttribute("HubAlerted", true)
                    S.alertedEntities[rootModel] = true
                end

                local now = tick()
                local lastTrigger = S.AlertCooldowns[conf.st] or 0
                local cd = 2.0

                if (now - lastTrigger) >= cd then
                    S.AlertCooldowns[conf.st] = now
                    local alertMsg = (conf.msg and getText(conf.msg)) or "MONSTER DETECTED!"
                    showNotification(alertMsg, "Error", nil, 4.0)
                end
            end
        end

        S.checkObject = function(obj)
            if not obj or typeof(obj) ~= "Instance" or not obj.Parent then return end

            local rawName = obj.Name
            local oName = rawName and tostring(rawName) or ""
            if oName == "" then return end

            local oNameLower = oName:lower()
                -- [ДОБАВЛЕНО]: Подсветка свечи (Candle) с ModulePrompt в Предметы ЕСП
            if states.itemsEsp and (oName == "Candle" or oNameLower == "candle") and obj:IsA("Model") then
                local prompt = obj:FindFirstChild("ModulePrompt", true) 
                    or obj:FindFirstChildWhichIsA("ProximityPrompt", true)

                -- Проверяем, что это именно подбираемая свеча с промптом ModulePrompt
                if prompt and prompt.Name == "ModulePrompt" then
                    if not S.activeHighlights[obj] then
                        S.applyHighlight(obj, "item", "candle", "Candle", false)
                        return
                    end
                end
            end
            if (states.itemsEsp or states.smoothieHighlight) and (oNameLower:find("smoothie") or (obj.Parent and tostring(obj.Parent.Name):lower():find("smoothie"))) then
                local targetModel = nil

                if oName == "SmoothieSpawner" or oNameLower:find("smoothiespawner") then
                    -- Если передан сам спавнер, ищем внутри модельку смузи
                    targetModel = obj:FindFirstChild("Smoothie", true)
                    if targetModel and targetModel:FindFirstChildWhichIsA("Model") then
                        targetModel = targetModel:FindFirstChildWhichIsA("Model")
                    end
                elseif oName == "Smoothie" and obj.Parent and obj.Parent.Name:lower():find("spawner") then
                    -- Если передан узел Smoothie внутри спавнера, проверяем, есть ли внутри отдельная моделька
                    local innerModel = obj:FindFirstChildWhichIsA("Model")
                    targetModel = innerModel or obj
                elseif obj:IsA("Model") and obj.Parent and obj.Parent.Name == "Smoothie" then
                    -- Сама внутренняя моделька смузи
                    targetModel = obj
                end

                if targetModel and targetModel.Parent and not S.activeHighlights[targetModel] then
                    S.applyHighlight(targetModel, "smoothie", "smoothie", nil, false)
                    return
                end
            end
            -- [ЕСП ВЕНТИЛЕЙ]: Подсветка ИСКЛЮЧИТЕЛЬНО колеса вентиля (Valve / Wheel)
            local isPumpObj = (oName == "WaterPump" or oNameLower:find("waterpump") or oName == "SewerPump" 
                or oName == "Wheel" or oName == "ValvePrompt" 
                or (obj:IsA("BasePart") and obj.Name:lower():find("wheel") and obj.Parent and obj.Parent.Name:lower():find("pump")))

            if isPumpObj then
                if states.pumpEsp then
                    local targetWheel = nil
                    if obj:IsA("Model") then
                        targetWheel = obj:FindFirstChild("Wheel", true) 
                            or obj:FindFirstChild("wheel", true)
                            or obj:FindFirstChildWhichIsA("MeshPart", true)
                    elseif obj:IsA("ProximityPrompt") then
                        targetWheel = obj.Parent:IsA("BasePart") and obj.Parent or obj.Parent:FindFirstChildWhichIsA("BasePart", true)
                    elseif obj:IsA("BasePart") then
                        targetWheel = obj
                    end

                    -- Подсвечиваем ТОЛЬКО само колесо (MeshPart Wheel)
                    if targetWheel and targetWheel.Parent and targetWheel:IsA("BasePart") then
                        if not S.activeHighlights[targetWheel] then
                            S.applyHighlight(targetWheel, "pump", "wheel", nil, false)
                        end
                    end
                end
                -- ОБЯЗАТЕЛЬНЫЙ ВЫХОД: чтобы корпус насоса ни при каких условиях не подсвечивался вторым слоем
                return
            end
            -- [ЕСП ЛУИ ИЗ ФИЛЬТРА МОНСТРОВ]: Работает напрямую через Monster ESP и фильтр монстров
            if states.monsterEsp and isMonsterAllowed("louie") and (oName == "MouseHole" or oName == "Louie" or oNameLower == "mousehole" or oNameLower == "louie") then
                local target = nil
                if oName == "MouseHole" or oNameLower == "mousehole" then
                    target = obj:FindFirstChild("Darkness") or obj:FindFirstChildWhichIsA("BasePart", true) or obj
                elseif oName == "Louie" or oNameLower == "louie" then
                    target = (obj.Parent and obj.Parent:FindFirstChild("Darkness")) or obj:FindFirstChildWhichIsA("BasePart", true) or (obj.Parent and obj.Parent:IsA("Model") and obj.Parent) or obj
                end

                if target and target.Parent and not S.activeHighlights[target] and not S.activeHighlights[obj] then
                    S.applyHighlight(target, "louie", "louie", "Louie", false)
                end
                return
            end
            -- [ЕСП ФИГУРЫ И БОССОВ]: Поддержка Monster ESP, фильтра монстров и отдельных тумблеров
            if oName == "FigureRig" or oNameLower:find("figurerig") or (oName == "Figure" and obj:IsA("Model")) then
                if states.figureEsp or (states.monsterEsp and isMonsterAllowed("figure")) then
                    S.applyHighlight(obj, "figure", "figure", "Figure", false)
                end
                return
            end
            if oName == "Groundskeeper" or (oNameLower:find("groundskeeper") and obj:IsA("Model")) then
                if states.groundskeeperEsp or (states.monsterEsp and isMonsterAllowed("groundskeeper")) then
                    S.applyHighlight(obj, "groundskeeper", "groundskeeper", "Groundskeeper", false)
                end
                return
            end
            if (oName == "Grumbo" or oName == "GrumbleRig" or oNameLower:find("grumble")) and obj:IsA("Model") then
                if states.grumbleEsp or (states.monsterEsp and isMonsterAllowed("grumble")) then
                    S.applyHighlight(obj, "grumble", "grumble", "Grumble", false)
                end
                return
            end
            if (oName == "LiveEntityBramble" or oName == "Bramble" or oNameLower:find("bramble")) and obj:IsA("Model") then
                if states.brambleEsp or (states.monsterEsp and isMonsterAllowed("bramble")) then
                    S.applyHighlight(obj, "bramble", "bramble", "Bramble", false)
                end
                return
            end
            if oName == "MonumentSpawn" then return end
            if isRealMonumentEntity(obj) then
                if states.monumentEsp or (states.monsterEsp and isMonsterAllowed("monument")) then
                    S.applyHighlight(obj, "monument", "monument", "Monument", false)
                end
                return
            end
            if states.fireAlarmEsp and (oName == "StairwellFireAlarm" or obj:GetAttribute("LoadModule") == "StairwellFireAlarm") then
                S.applyHighlight(obj, "fireAlarm", "stairwellfirealarm", nil, false)
                return
            end
            if states.cartEsp and (oName == "ShoppingCart" or obj:GetAttribute("LoadModule") == "ShoppingCart") then
                S.applyHighlight(obj, "cart", "shoppingcart", nil, false)
                return
            end
            if states.tvStandEsp and (oName == "TV_Stand" or oNameLower:find("tv_stand")) then
                S.applyHighlight(obj, "tvStand", "tv_stand", nil, false)
                return
            end
            if states.scrapperEsp and (oName == "StairwellScrapper" or oName == "DepotHalloween"
                or oNameLower:find("stairwellscrapper") or oNameLower:find("scrapper") or oNameLower:find("depothalloween")) then
                S.applyHighlight(obj, "scrapper", "stairwellscrapper", nil, false)
                return
            end

            if states.giggleRemoveHitbox and (oName == "Giggle" or oNameLower:find("giggle")) then
                pcall(function() obj:Destroy() end)
                return
            end

            if oName == "SideroomDupe" or oName == "DoorFake" then
                if states.antiDupe then
                    if oName == "DoorFake" then
                        pcall(function() obj:Destroy() end)
                    else
                        local df = obj:FindFirstChild("DoorFake")
                        if df then pcall(function() df:Destroy() end) end
                    end
                elseif states.espDupe then
                    local targetDoor = (oName == "DoorFake" and (obj:FindFirstChild("Door") or obj)) or (obj:FindFirstChild("DoorFake") and obj.DoorFake:FindFirstChild("Door"))
                    if targetDoor then
                        S.applyHighlight(targetDoor, "dupe", "dupe", nil, false)
                    end
                end
                return
            end

            if S.activeHighlights[obj] then return end

            local hasActiveEsp = states.espDoors or states.espDupe or states.itemsEsp or states.chestHighlight 
                or states.leverHighlight or states.timerLeverEsp or states.outdoorsLeverEsp or states.wardrobeEsp 
                or states.keyHighlight or states.fuseEsp or states.anchorEsp or states.liveBreakerEsp 
                or states.liveHintBookEsp or states.smoothieHighlight or states.monsterEsp or states.figureEsp 
                or states.grumbleEsp or states.mandrakeEsp or states.groundskeeperEsp or states.monumentEsp 
                or states.brambleEsp or states.presentsEsp or states.generatorEsp or states.louieEsp 
                or states.pumpEsp or states.fireAlarmEsp or states.cartEsp or states.tvStandEsp 
                or states.scrapperEsp or states.autoLoot

            local hasActiveAnti = states.antiDupe or states.antiSnare or states.antiGloom or states.noPaintRoomDoor
                or states.giggleRemoveHitbox or states.screechRemover or states.antiA90 or states.antiDread
                or states.antiHalt or states.antiAlma or states.antiDrone or states.antiJeff
                or states.antiCurrents or states.antiScribbles or states.antiLag or states.customLight
                or states.newYearMode

            if not hasActiveEsp and not hasActiveAnti then return end

            local cName = obj.ClassName
            if cName ~= "Model" and cName ~= "Tool" and cName ~= "ProximityPrompt" and not obj:IsA("Light") and cName ~= "BasePart" then
                return
            end

            if obj:IsA("Light") then
                if S.FunModule and S.FunModule.onLightFound then
                    S.FunModule.onLightFound(obj)
                end
                return
            end

            S.checkAndKillJeff(obj)

            if states.antiAlma and (oNameLower:find("alma") or oName == "Alma") then S.NeutralizeAlmaModel(obj) end
            if states.screechRemover and oNameLower:find("screech") then S.neutralizeScreechInstance(obj); return end
            if states.antiA90 and (oNameLower:find("a90") or oNameLower:find("ransom")) then S.cleanA90Logic() end
            if states.antiDread and (oName:find("Dread") or oName == "Ambience_Dark") then task.defer(S.cleanDreadLogic); return end
            if states.antiHalt and (oName == "Shade" or oName == "Jumpscare_Shade" or oName == "Halt") then task.defer(S.cleanHaltLogic); return end
            if states.antiCurrents and obj:IsA("BasePart") then S.checkAndSecurePuddle(obj) end
            if states.antiScribbles then S.destroyScribblesPaper(obj) end
            S.cleanDroneLogic(obj)

            if oName == "ArchivesStorageBox" or oName == "ArchivesPackageDeposit" or oName:find("POTUJNOLIT") or oNameLower:find("stem") then
                return
            end

            if cName == "ProximityPrompt" then
                local parent = obj.Parent
                if parent and not S.activeHighlights[parent] then
                    local pModel = parent:IsA("Model") and parent or parent:FindFirstAncestorOfClass("Model")
                    if pModel and not S.activeHighlights[pModel] and pModel.Parent ~= G.Services.Workspace:FindFirstChild("CurrentRooms") and not tonumber(pModel.Name) then
                        S.checkObject(pModel)
                    end
                end
                return
            end

            if not S.isObjectInAllowedRooms(obj) then return end

            if obj:IsA("Model") and oName == "Door" then
                if states.espDoors then 
                    S.applyHighlight(obj:FindFirstChild("Door") or obj:FindFirstChild("Panel") or obj, "door", "door", nil, false) 
                end
                return
            end
            -- Определение якорей и считывание их букв (A, B, C, D, E)
            if oName == "MinesAnchor" then
                if states.anchorEsp then
                    local function getAnchorLetter(model)
                        if not model then return nil end
                        local sign = model:FindFirstChild("Sign")
                        local signText = sign and sign:FindFirstChildWhichIsA("TextLabel", true)
                        local txt = (signText and signText.Text ~= "" and signText.Text) or model:GetAttribute("AnchorID")
                        if txt and txt ~= "" and txt ~= " " then
                            return tostring(txt):gsub("%s+", "")
                        end
                        return nil
                    end

                    local letter = getAnchorLetter(obj)
                    S.applyHighlight(obj, "anchor", "anchor", letter, false)

                    -- Если знак еще реплицируется сервером, дожидаемся появления текста
                    if not letter then
                        task.spawn(function()
                            local t0 = tick()
                            while obj and obj.Parent and (tick() - t0 < 3.5) do
                                task.wait(0.2)
                                local foundLetter = getAnchorLetter(obj)
                                if foundLetter then
                                    if S.activeHighlights[obj] then
                                        S.activeHighlights[obj].rawCustomLabel = foundLetter
                                        S.activeHighlights[obj].cachedName = getEspLocalizedName("anchor", "anchor", foundLetter)
                                        S.activeHighlights[obj].lastDist = -999
                                    end
                                    break
                                end
                            end
                        end)
                    end
                end
                return
            end
            if states.wardrobeEsp and obj:IsA("Model") then
                if not oNameLower:find("small") and not oNameLower:find("broken") then
                    if oNameLower:find("hidingspot") or oNameLower == "wardrobe" or oNameLower == "rooms_locker" or oNameLower == "toolshed" or oNameLower == "largelocker" or oNameLower == "locker_large" then
                        S.applyHighlight(obj, "wardrobe", "wardrobe", nil, false)
                        return
                    end
                end
            end

            local map = ESP_TARGETS[oName]
            if map then
                local shouldShowMap = (map.state and states[map.state])
                    or (map.monsterKey and states.monsterEsp and isMonsterAllowed(map.monsterKey))
                if shouldShowMap then 
                    S.applyHighlight(obj, map.col, map.monsterKey or map.col, nil, false); return
                elseif map.anti and states[map.anti] then 
                    task.defer(function() if obj and obj.Parent then obj:Destroy() end end); return 
                end
            end

            if states.itemsEsp or states.autoLoot or states.keyHighlight or states.fuseEsp or states.smoothieHighlight or states.mandrakeEsp then
                local isValid, itemKey, itemTarget, rawLabel = isValidPickupItem(obj)
                if isValid and itemTarget and not S.activeHighlights[itemTarget] then
                    local tName = tostring(itemTarget.Name):lower()
                    local rText = tostring(rawLabel or ""):lower()
                    local isMandrake = (itemKey == "mandrake") 
                        or (tName:find("mandrake") ~= nil) 
                        or (rText:find("mandrake") ~= nil)

                    if isMandrake then
                        itemKey = "mandrake"
                    end

                    local shouldShow = false
                    if isMandrake then
                        shouldShow = states.mandrakeEsp
                    else
                        shouldShow = states.itemsEsp 
                            or (itemKey == "key" and states.keyHighlight) 
                            or (itemKey == "fuse" and states.fuseEsp) 
                            or (itemKey == "smoothie" and states.smoothieHighlight)
                    end

                    if shouldShow then
                        S.applyHighlight(itemTarget, (HIGHLIGHT_COLORS[itemKey] and itemKey) or (map and map.col) or "item", itemKey, rawLabel, false)
                        return
                    end
                end
            end

            if states.antiLag and (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")) then 
                if not isMonsterDescendant(obj) and not (player.Character and obj:IsDescendantOf(player.Character)) then 
                    obj:Destroy()
                end
            end
        end

        S.scanRoomFast = function(room)
            if not room or not room.Parent then return end

            if states.bridgePatch then
                S.patchRoomBridges(room)
            end

            -- [ИСПРАВЛЕНО]: Глубокий поиск вентилей в дамбе (Комната 100) и затопленных залах
            if states.pumpEsp then
                task.defer(function()
                    for _, desc in ipairs(room:GetDescendants()) do
                        if desc:IsA("Model") and (desc.Name == "WaterPump" or desc.Name == "SewerPump") then
                            S.checkObject(desc)
                        elseif desc:IsA("ProximityPrompt") and desc.Name == "ValvePrompt" then
                            S.checkObject(desc)
                        end
                    end
                end)
            end

            if scannedRooms[room] and not states.fireAlarmEsp and not states.cartEsp and not states.scrapperEsp and not states.pumpEsp then 
                return 
            end
            scannedRooms[room] = true

            S.optimizeRoomCollisions(room)
            if states.superFps then
                S.optimizeRoomForSuperFps(room)
            end
            S.cleanRoomHazardsSpecific(room)

            local rNum = tonumber(room.Name)

            local door = room:FindFirstChild("Door")
            if door and states.espDoors then
                if rNum then objectRoomMap[door] = rNum end
                local doorPart = door:FindFirstChild("Door") or door:FindFirstChild("Panel") or door:FindFirstChildWhichIsA("BasePart") or door
                S.applyHighlight(doorPart, "door", "door", nil, false)
            end

            -- Проверка прямых объектов комнаты и боковых комнат (Sideroom)
            for _, child in ipairs(room:GetChildren()) do
                if rNum then objectRoomMap[child] = rNum end
                S.checkObject(child)

                -- [ДОБАВЛЕНО]: Сканирование боковых комнат (Sideroom28, Sideroom30 и т.д.)
                if child:IsA("Model") and child.Name:lower():find("sideroom") then
                    for _, sideChild in ipairs(child:GetChildren()) do
                        if rNum then objectRoomMap[sideChild] = rNum end
                        S.checkObject(sideChild)
                    end

                    local sideAssets = child:FindFirstChild("Assets")
                    if sideAssets then
                        for _, sideProp in ipairs(sideAssets:GetChildren()) do
                            if rNum then objectRoomMap[sideProp] = rNum end
                            S.checkObject(sideProp)
                        end
                    end
                end
            end
            -- [БЫСТРОЕ СКАНИРОВАНИЕ МОНСТРОВ И БОССОВ БЕЗ GETDESCENDANTS]
            for _, folderName in ipairs({"FigureSetup", "_NestHandler", "Mandrakes", "GroundskeeperSetup"}) do
                local subFolder = room:FindFirstChild(folderName)
                if subFolder then
                    for _, subChild in ipairs(subFolder:GetChildren()) do
                        if rNum then objectRoomMap[subChild] = rNum end
                        S.checkObject(subChild)
                    end
                end
            end

            local assets = room:FindFirstChild("Assets")
            if assets then
                for _, prop in ipairs(assets:GetChildren()) do
                    if rNum then objectRoomMap[prop] = rNum end
                    S.checkObject(prop)
                        
                    for _, sub in ipairs(prop:GetChildren()) do
                        if rNum then objectRoomMap[sub] = rNum end
                        S.checkObject(sub)
                        local pNameLow = prop.Name:lower()
                        local subNameLow = sub.Name:lower()
                        if pNameLow:find("smoothie") or subNameLow:find("smoothie") then
                            for _, inner in ipairs(sub:GetChildren()) do
                                if rNum then objectRoomMap[inner] = rNum end
                                S.checkObject(inner)
                            end
                        end

                        local subName = sub.Name:lower()
                        local isRealContainer = subName:find("drawer") or subName:find("container") 
                            or subName:find("desk") or subName:find("dresser") 
                            or subName:find("chest") or subName:find("safe")

                        if isRealContainer then
                            for _, insideLoot in ipairs(sub:GetChildren()) do
                                if rNum then objectRoomMap[insideLoot] = rNum end
                                S.checkObject(insideLoot)
                            end
                        end
                    end
                end
            end
        end

        S.refreshEsp = function()
            for obj, data in pairs(S.activeHighlights) do
                local keep = false
                local isMon = data.isMonster or isMonsterInstance(obj, data.typeName)
                local mKey = data.itemKey or data.typeName
                if isMon then
                    keep = (states.monsterEsp and isMonsterAllowed(mKey))
                        or (mKey == "figure" and states.figureEsp)
                        or (mKey == "grumble" and states.grumbleEsp)
                        or (mKey == "groundskeeper" and states.groundskeeperEsp)
                        or (mKey == "monument" and states.monumentEsp)
                        or (mKey == "bramble" and states.brambleEsp)
                        or (mKey == "mandrake" and states.mandrakeEsp)
                        or (mKey == "louie" and states.louieEsp)
                elseif S.isObjectInAllowedRooms(obj) then
                    if data.typeName == "fireAlarm" then keep = states.fireAlarmEsp
                    elseif data.typeName == "cart" then keep = states.cartEsp
                    elseif data.typeName == "tvStand" or data.itemKey == "tv_stand" then keep = states.tvStandEsp
                    elseif data.typeName == "scrapper" or data.itemKey == "stairwellscrapper" then keep = states.scrapperEsp
                    elseif obj.Name == "Door" or data.typeName == "door" then keep = states.espDoors
                    elseif data.typeName == "dupe" then keep = states.espDupe
                    elseif data.typeName == "wardrobe" or (obj.Name and obj.Name:lower():find("hidingspot")) then
                        keep = states.wardrobeEsp and not obj.Name:lower():find("small") and not obj.Name:lower():find("broken")
                    elseif data.typeName == "presents" then keep = states.presentsEsp or states.itemsEsp
                    elseif data.typeName == "generator" then keep = states.generatorEsp
                    elseif data.typeName == "louie" or data.typeName == "mousehole" or data.itemKey == "louie" then
                        keep = states.monsterEsp and isMonsterAllowed("louie")
                    elseif data.typeName == "key" then keep = states.keyHighlight or states.itemsEsp
                    elseif data.typeName == "fuse" then keep = states.fuseEsp or states.itemsEsp
                    elseif data.typeName == "liveHintBook" or data.itemKey == "livehintbook" then keep = states.liveHintBookEsp or states.itemsEsp
                    elseif data.typeName == "item" or data.typeName == "lotuspetal" or data.itemKey == "lotuspetal" or data.typeName == "paperplane" or data.typeName == "laserpointer" or data.typeName == "fihflakes" or data.typeName == "pizza" then
                        if tostring(obj.Name):lower():find("mandrake") or (data.rawCustomLabel and tostring(data.rawCustomLabel):lower():find("mandrake")) then
                            keep = states.mandrakeEsp
                        else
                            keep = states.itemsEsp
                        end
                    elseif data.typeName == "chest" or data.itemKey == "chest_vine" or data.itemKey == "chestvine" then keep = states.chestHighlight
                    elseif data.typeName == "lever" then keep = states.leverHighlight or states.liveBreakerEsp or states.outdoorsLeverEsp
                    elseif data.typeName == "timerLever" then keep = states.timerLeverEsp
                    elseif data.typeName == "smoothie" then keep = states.smoothieHighlight or states.itemsEsp
                    elseif data.typeName == "figure" or data.itemKey == "figure" then keep = states.figureEsp or (states.monsterEsp and isMonsterAllowed("figure"))
                    elseif data.typeName == "anchor" then
                        keep = states.anchorEsp
                        if keep and obj and (not data.rawCustomLabel or data.rawCustomLabel == "" or data.rawCustomLabel == "anchor") then
                            local sign = obj:FindFirstChild("Sign")
                            local signText = sign and sign:FindFirstChildWhichIsA("TextLabel", true)
                            local txt = (signText and signText.Text ~= "" and signText.Text) or obj:GetAttribute("AnchorID")
                            if txt and txt ~= "" and txt ~= " " then
                                data.rawCustomLabel = tostring(txt):gsub("%s+", "")
                            end
                        end
                    elseif data.typeName == "grumble" then keep = states.grumbleEsp or states.monsterEsp
                    elseif data.typeName == "pump" then 
                        keep = states.pumpEsp and (obj:IsA("BasePart") or obj.Name == "Wheel")
                    elseif data.typeName == "mandrake" or data.itemKey == "mandrake" or tostring(obj.Name):lower():find("mandrake") then
                        keep = states.mandrakeEsp
                    elseif data.typeName == "groundskeeper" then keep = states.groundskeeperEsp or states.monsterEsp
                    elseif data.typeName == "monument" then keep = states.monumentEsp
                    elseif data.typeName == "bramble" then keep = states.brambleEsp
                    elseif isMon or MONSTER_ESP_NAMES[obj.Name] then
                        keep = states.monsterEsp 
                    end
                end
                
                if not keep or not obj.Parent then
                    if data.group then pcall(function() data.group:Destroy() end) end
                    if S.tracerLines and S.tracerLines[obj] then
                        pcall(function() S.tracerLines[obj]:Remove() end)
                        S.tracerLines[obj] = nil
                    end
                    S.activeHighlights[obj] = nil
                    objectRoomMap[obj] = nil
                else
                    local colors = HIGHLIGHT_COLORS[data.typeName] or HIGHLIGHT_COLORS[data.itemKey] or HIGHLIGHT_COLORS.item
                    if data.highlight then
                        data.highlight.FillColor = colors[1]
                        data.highlight.OutlineColor = colors[2]
                    end
                    if data.label then
                        data.label.TextColor3 = colors[1]
                    end
                    data.cachedName = getEspLocalizedName(data.typeName, data.itemKey, data.rawCustomLabel)
                    data.lastDist = -999
                end
            end
            if S.updateAllPlayerEsp then S.updateAllPlayerEsp(states.playerEsp) end
            if S.updateHonchoScan then S.updateHonchoScan() end
        end

        S.scanRooms = function()
            task.spawn(function()
                S.updateCachedRoom()
                local curRoom = S.CachedCurrentRoom
                local rooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
                
                if rooms then
                    for _, roomModel in ipairs(rooms:GetChildren()) do
                        local rNum = tonumber(roomModel.Name)
                        if not rNum or (rNum >= curRoom - 1 and rNum <= curRoom + 2) then
                            if not scannedRooms[roomModel] then
                                S.scanRoomFast(roomModel)
                            end
                        end
                    end

                    if states.monsterEsp or states.figureEsp or states.grumbleEsp or states.groundskeeperEsp then
                        for _, r in ipairs(rooms:GetChildren()) do
                            local rNum = tonumber(r.Name)
                            if not rNum or (rNum < curRoom - 1 or rNum > curRoom + 2) then
                                for _, child in ipairs(r:GetChildren()) do
                                    local cn = child.Name
                                    if MONSTER_ESP_NAMES[cn] or cn == "FigureRig" or cn == "Grumbo" or cn == "GrumbleRig" or cn == "Groundskeeper" or cn == "Seek_Rig" then
                                        S.checkObject(child)
                                    end
                                end
                            end
                        end
                    end
                end

                local ws = G.Services.Workspace
                for _, ch in ipairs(ws:GetChildren()) do
                    local cName = ch.ClassName
                    if cName == "Model" or cName == "Tool" or cName == "Light" then 
                        S.checkObject(ch) 
                    end
                end

                local currentCam = ws.CurrentCamera or Camera
                if currentCam then
                    for _, camChild in ipairs(currentCam:GetChildren()) do
                        if camChild.Name == "NoiseModel" or camChild.Name:find("Noise") then
                            S.checkObject(camChild)
                        end
                    end
                end

                local drops = ws:FindFirstChild("Drops")
                if drops then 
                    for _, drop in ipairs(drops:GetChildren()) do S.checkObject(drop) end 
                end

                if states.playerEsp and S.updateAllPlayerEsp then S.updateAllPlayerEsp(true) end
                if states.infItems and S.updateAllInfPrompts then S.updateAllInfPrompts(true) end
                if states.antiAlma then S.scanAlmaImmediate() end
                if states.antiDrone then S.scanAndPurgeAllDrones() end
                if states.antiScribbles then S.cleanExistingPapers() end
            end)
        end

        S.espToggle = function(on) 
            if on then 
                S.scanRooms() 
            else 
                S.refreshEsp() 
            end 
        end

        S.lastRefreshTrigger = 0
        S.queueRoomRefresh = function()
            local now = tick()
            if (now - S.lastRefreshTrigger) < 0.1 then return end
            S.lastRefreshTrigger = now

            task.defer(function()
                if not S.Runtime.running then return end
                S.updateCachedRoom()
                S.purgeOldRoomESP()
                S.scanRooms()
            end)
        end
    end

    -- ====================================================================
    --                  СИСТЕМА СОЛВЕРОВ И ПРОМПТОВ
    -- ====================================================================
    local function SetupSolvers(S)
        S.Caches.promptOriginalDist = setmetatable({}, {__mode = "k"})
        S.Caches.promptOriginalLoS = setmetatable({}, {__mode = "k"})
        S.ClassifiedPrompts = setmetatable({}, {__mode = "k"})

        S.openedContainers = S.openedContainers or setmetatable({}, {__mode = "k"})

        -- Проверка: является ли промпт замком или находится внутри запертого контейнера
        S.getLockState = function(prompt)
            if not prompt or not prompt.Parent then return false, false end

            local pPromptName = prompt.Name:lower()
            local act = (prompt.ActionText or ""):lower()
            local ot = (prompt.ObjectText or ""):lower()
            local pParent = prompt.Parent
            local pParentName = pParent and pParent.Name:lower() or ""

            -- Прямые признаки промпта замка
            local isDirectLockPrompt = (
                prompt:GetAttribute("GateTool") ~= nil
                or prompt:GetAttribute("UsingTool") == "Unlock"
                or prompt:GetAttribute("UsingToolExtra") ~= nil
                or ot:find("lock") or ot:find("замок") or ot:find("vine") or ot:find("лиан")
                or act:find("unlock") or act:find("отпереть") or act:find("взломать") or act:find("pick") or act:find("cut")
                or pParentName == "lock" or pParentName == "skulllock" or pParentName == "cuttablevines" or pParentName == "cellar"
                or pPromptName:find("unlock") or pPromptName == "lockprompt"
            )

            -- Проверяем только саму модель контейнера (останавливаемся на папке Assets или модели Комнаты)
            local cur = pParent
            local ws = G.Services.Workspace
            local cr = ws:FindFirstChild("CurrentRooms")
            local isContainerLocked = false

            while cur and cur ~= ws and cur ~= cr and cur.Name ~= "Assets" and not tonumber(cur.Name) do
                if cur:IsA("Model") then
                    -- Убираем задержку появления промптов внутри открытых ящиков (PromptShowDelay 1-3 сек -> 0)
                    if cur:GetAttribute("PromptShowDelay") and cur:GetAttribute("PromptShowDelay") > 0 then
                        pcall(function() cur:SetAttribute("PromptShowDelay", 0) end)
                    end

                    local mName = cur.Name:lower()
                    if cur:GetAttribute("Locked") == true then
                        isContainerLocked = true
                    elseif (mName == "locker_small_locked" or mName == "chestboxlocked" or mName == "toolbox_locked") and cur:GetAttribute("Locked") ~= false then
                        isContainerLocked = true
                    elseif mName == "chest_vine" and cur:FindFirstChild("CuttableVines") then
                        isContainerLocked = true
                    elseif cur:FindFirstChild("Lock") or cur:FindFirstChild("SkullLock") then
                        local lockObj = cur:FindFirstChild("Lock") or cur:FindFirstChild("SkullLock")
                        if lockObj and lockObj:FindFirstChildWhichIsA("ProximityPrompt", true) then
                            isContainerLocked = true
                        end
                    end
                end
                cur = cur.Parent
            end

            return isDirectLockPrompt, isContainerLocked
        end

        S.getPromptInfo = function(prompt)
            if not prompt or not prompt.Parent then return false end

            -- Полностью игнорируем промпты внутри JeffShop_Hotel: ни авто-лут, ни авто-интеракт
            if isInsideJeffShop(prompt) then
                S.ClassifiedPrompts[prompt] = false
                return false
            end

            local pPromptName = prompt.Name:lower()
            if pPromptName == "fprompt" or prompt:GetAttribute("InfiniteItems") ~= nil or pPromptName == "givetakeprompt" then 
                return false 
            end

            local act = (prompt.ActionText or ""):lower()
            local ot = (prompt.ObjectText or ""):lower()
            local pModel = prompt:FindFirstAncestorOfClass("Model")
            local pModelName = pModel and pModel.Name:lower() or ""
            local pParentName = prompt.Parent and prompt.Parent.Name:lower() or ""

            -- 1. ПОЛНЫЙ ИГНОР АВТОМАТОВ (шейклайты, торговые автоматы, вендоры)
            local isVendor = (
                ot:find("vendor") or ot:find("vending") or ot:find("shakelight") or ot:find("автомат")
                or pModelName:find("vendor") or pModelName:find("vending") or pModelName:find("shakelight")
                or pParentName:find("vendor") or pParentName:find("vending") or pParentName:find("shakelight")
                or pPromptName:find("vendor") or pPromptName:find("vending")
                or (pModel and (pModel:GetAttribute("LoadModule") == "Vendor" or pModel:GetAttribute("Vend") ~= nil))
                or (prompt.Parent and (prompt.Parent:GetAttribute("LoadModule") == "Vendor" or prompt.Parent:GetAttribute("Vend") ~= nil))
            )
            if isVendor then
                S.ClassifiedPrompts[prompt] = false
                return false
            end

            -- 2. ЖЕЛЕЗНЫЙ ЗАПРЕТ НА ПРЯТКИ: любое действие спрятаться — НИКОГДА не нажимаем
            if act:find("hide") or act:find("прят") or act:find("залез") or pPromptName:find("hide") then
                S.ClassifiedPrompts[prompt] = false
                return false
            end

            -- 3. ЗАПРЕТ НА ЗАКРЫТИЕ: если ящик/шкаф уже открыт (Close / Закрыть) — не трогаем
            if act:find("close") or act:find("закр") or act:find("shut") then
                S.ClassifiedPrompts[prompt] = false
                return false
            end

            -- ЗАЩИТА ЗАМКОВ: не трогаем замки и запертые контейнеры (пока Locked == true)
            local isDirectLock, isContainerLocked = S.getLockState(prompt)
            if isDirectLock or isContainerLocked then
                return false
            end

            -- Проверяем кэш только если действие не изменилось
            local cached = S.ClassifiedPrompts[prompt]
            if cached ~= nil then
                if cached == false then return false end
                -- Если контейнер реально открылся на сервере (появился атрибут Interactions), больше не нажимаем
                if (cached.isChest or cached.isDrawer) and prompt:GetAttribute("Interactions") ~= nil then
                    return false
                end
                return cached
            end

            if pModelName:find("teller") or (pModel and pModel:FindFirstChild("GiveTakePrompt")) then
                S.ClassifiedPrompts[prompt] = false
                return false
            end

            if pModelName:find("stem") or pModelName:find("meld") or pParentName:find("stem") or pParentName:find("meld") 
            or ot:find("stem") or ot:find("meld") or pPromptName:find("stem") or pPromptName:find("meld") then
                S.ClassifiedPrompts[prompt] = false
                return false
            end

            -- Определение обычного незапертого сундука / шкафчика лута
            local isChest = (
                ot:find("chest") or ot:find("сундук") or pModelName:find("chest") or pParentName:find("chest")
                or pModelName == "locker_small" or pModelName == "toolbox"
            )

            -- Определение ручки ящика тумбочки
            local isDrawer = (
                ot:find("drawer") or ot:find("ящик") or ot:find("тумб")
                or pModelName:find("drawer") or pParentName:find("drawer")
                or pPromptName:find("drawer") or pParentName:find("knob")
            ) and not isChest

            -- Если контейнер уже был открыт на сервере ранее
            if (isChest or isDrawer) and prompt:GetAttribute("Interactions") ~= nil then
                return false
            end

            local isChair = ot:find("chair") or ot:find("seat") or pModelName:find("chair") or pModelName:find("seat") or act == "sit"
            local isTerminal = ot:find("terminal") or pModelName:find("terminal")
            local isForgetMeNot = ot:find("forgetmenot") or ot:find("vinedoor")
            local isBlacklistedInteract = (
                ot == "painting" or ot:find("painting") or ot == "desk bell" 
                or ot:find("wardrobe") or (ot:find("locker") and not isChest) or ot:find("shoelocker") 
                or ot:find("shoe") or ot:find("vent") or isTerminal or isForgetMeNot 
                or isVendor or isChair or pPromptName == "fusesprompt" or pPromptName:find("breaker")
                or pPromptName:find("hide") or act:find("hide") or act:find("прят") or act:find("залез")
            )

            -- ЛУТ: шкафы с действием Loot/Search, золото, предметы, тумбочки и сундуки
            local isLootAction = act:find("loot") or act:find("лут") or act:find("search") or act:find("обыск")
            local isLoot = (
                isLootAction
                or ot == "🪙" or ot:find("gold") or ot:find("coin") or pModelName:find("gold") or pParentName:find("gold")
                or act:find("take") or act:find("grab") or act:find("obtain") or act:find("collect") or act:find("pick up") or act:find("gather") or act:find("steal")
                or (STRICT_ITEM_NAMES[ot] and not tostring(ot):find("chestboxlocked"))
                or (STRICT_ITEM_NAMES[pModelName] and not tostring(pModelName):find("chestboxlocked"))
                or (STRICT_ITEM_NAMES[pParentName] and not tostring(pParentName):find("chestboxlocked"))
                or isChest or isDrawer
            )

            -- Определяем золото
            local isGoldLoot = (
                ot == "🪙" or ot:find("gold") or ot:find("coin") or ot:find("золот") or ot:find("монет")
                or act:find("gold") or act:find("coin") or act:find("золот") or act:find("монет")
                or pModelName:find("gold") or pModelName:find("coin")
                or pParentName:find("gold") or pParentName:find("coin")
                or pPromptName:find("gold") or pPromptName:find("coin")
                or STRICT_ITEM_NAMES[ot] == "gold"
                or STRICT_ITEM_NAMES[pModelName] == "gold"
                or STRICT_ITEM_NAMES[pParentName] == "gold"
            )

            -- Интеракт: рычаги, кнопки, двери, вентили (без шкафов и без пряток)
            local isInteract = (
                act:find("interact") or act:find("pull") or act:find("turn") or act:find("open") 
                or act:find("flip") or act:find("toggle") or act:find("use") or act:find("solve") 
                or act:find("push") or act:find("activate") or act:find("press") or act:find("crank")
                or isChest or isDrawer
            ) and not isBlacklistedInteract

            local info = {
                isLoot = isLoot and not isVendor,
                isGold = isLoot and not isVendor and isGoldLoot,
                isEssential = isLoot and not isVendor and isEssentialLootType(ot, act, pModelName, pParentName, pPromptName),
                isInteract = isInteract,
                isDrawer = isDrawer,
                isLock = false,
                isChest = isChest or isLootAction
            }

            S.ClassifiedPrompts[prompt] = info
            return info
        end
        -- Проверка, разрешён ли авто-лут для данного типа добычи
        S.isAutoLootAllowed = function(pInfo)
            if not pInfo or not pInfo.isLoot then return false end
            local filter = states.autoLootFilter
            if type(filter) ~= "table" then return true end
            if pInfo.isGold then
                return filter.gold ~= false
            end
            if pInfo.isDrawer or pInfo.isChest then
                return filter.containers ~= false
            end
            if pInfo.isEssential then
                return filter.essential ~= false
            end
            return filter.normal ~= false
        end

        S.Caches.promptOriginalDist = S.Caches.promptOriginalDist or setmetatable({}, {__mode = "k"})
        S.Caches.promptOriginalLoS = S.Caches.promptOriginalLoS or setmetatable({}, {__mode = "k"})
        S.Caches.promptOriginalFacing = S.Caches.promptOriginalFacing or setmetatable({}, {__mode = "k"})
        S.Caches.promptOriginalGateLOS = S.Caches.promptOriginalGateLOS or setmetatable({}, {__mode = "k"})
        S.Caches.promptOriginalGateSector = S.Caches.promptOriginalGateSector or setmetatable({}, {__mode = "k"})

        S.applyInstantToPrompt = function(prompt)
            if not prompt or not prompt:IsA("ProximityPrompt") then return end
            if not S.Caches.promptDurations[prompt] then 
                S.Caches.promptDurations[prompt] = prompt.HoldDuration 
            end

            pcall(function()
                if G.Services.CollectionService:HasTag(prompt, "DisableWhenEnabledOnClient") then
                    G.Services.CollectionService:RemoveTag(prompt, "DisableWhenEnabledOnClient")
                end
            end)

            if states.instantPrompt then
                local prName = tostring(prompt.Name):lower()
                local pName = tostring(prompt.Parent and prompt.Parent.Name or ""):lower()

                local isSpecialMinigame = (
                    prName == "fusesprompt" or prName:find("breaker") 
                    or pName:find("anchor") or prName:find("anchor") 
                    or prName == "reviveprompt"
                )

                if not isSpecialMinigame then
                    prompt.HoldDuration = 0
                end
            else
                if S.Caches.promptDurations[prompt] ~= nil then
                    prompt.HoldDuration = S.Caches.promptDurations[prompt]
                end
            end
        end

        S.updateAllPromptsInstant = function(enabled)
            for prompt in pairs(S.Caches.prompts) do
                if prompt and prompt.Parent and prompt:IsA("ProximityPrompt") then
                    if enabled then
                        S.applyInstantToPrompt(prompt)
                    elseif S.Caches.promptDurations[prompt] ~= nil then
                        prompt.HoldDuration = S.Caches.promptDurations[prompt]
                    end
                end
            end
        end

        S.restorePromptDurations = function()
            for prompt, dur in pairs(S.Caches.promptDurations) do
                if prompt and prompt.Parent and prompt:IsA("ProximityPrompt") then
                    prompt.HoldDuration = dur
                end
            end
            table.clear(S.Caches.promptDurations)
        end

        S.applyReachToPrompt = function(prompt)
            if not prompt or not prompt:IsA("ProximityPrompt") or not prompt.Parent then return end

            pcall(function()
                if G.Services.CollectionService:HasTag(prompt, "DisableWhenEnabledOnClient") then
                    G.Services.CollectionService:RemoveTag(prompt, "DisableWhenEnabledOnClient")
                end
            end)

            -- Назначаем PrimaryPart только самому объекту промпта (НЕ трогая модель комнаты и катсцены!)
            local p1 = prompt.Parent
            if p1 and p1:IsA("Model") and (p1:GetAttribute("PromptShowDelay") or 0) > 0 then
                p1:SetAttribute("PromptShowDelay", 0)
            end
            local p2 = p1 and p1.Parent
            if p2 and p2:IsA("Model") and (p2:GetAttribute("PromptShowDelay") or 0) > 0 then
                p2:SetAttribute("PromptShowDelay", 0)
            end
            -- Сохраняем исходные параметры ДО любых изменений
            if S.Caches.promptOriginalDist[prompt] == nil then
                local d = prompt.MaxActivationDistance
                S.Caches.promptOriginalDist[prompt] = (d > 0 and d) or 10
                S.Caches.promptOriginalLoS[prompt] = prompt.RequiresLineOfSight
                S.Caches.promptOriginalFacing[prompt] = prompt:GetAttribute("GateFacing")
                S.Caches.promptOriginalGateLOS[prompt] = prompt:GetAttribute("GateLOS")
                S.Caches.promptOriginalGateSector[prompt] = prompt:GetAttribute("GateSector")
            end

            local pName = tostring(prompt.Parent and prompt.Parent.Name or ""):lower()
            local ot = tostring(prompt.ObjectText or ""):lower()
            local prName = tostring(prompt.Name):lower()
            local grand = prompt.Parent and prompt.Parent.Parent and tostring(prompt.Parent.Parent.Name):lower() or ""

            local isDirectLock, isContainerLocked = S.getLockState(prompt)
            local isLockOrLockedContainer = isDirectLock or isContainerLocked

            if states.reachEnabled then
                local isDrawerKnob = (prName == "activateeventprompt") and ((pName == "knobs") or ot:find("drawer") or ot:find("ящик"))
                local isInsideContainer = grand:find("drawer") or grand:find("desk") or grand:find("dresser") or pName:find("container")

                if isLockOrLockedContainer then
                    -- Для замков не завышаем дистанцию выше серверного лимита (8 студов), чтобы сервер не отклонял открытие
                    local origD = S.Caches.promptOriginalDist[prompt] or 8
                    prompt.MaxActivationDistance = math.min(tonumber(states.reachDistance) or 15, math.max(origD, 8))
                    prompt.RequiresLineOfSight = false
                elseif isDrawerKnob then
                    prompt.MaxActivationDistance = math.min(tonumber(states.reachDistance) or 15, 11)
                    prompt.RequiresLineOfSight = false
                elseif isInsideContainer then
                    prompt.MaxActivationDistance = math.min(tonumber(states.reachDistance) or 15, 12)
                    prompt.RequiresLineOfSight = false
                else
                    prompt.MaxActivationDistance = tonumber(states.reachDistance) or 15
                    prompt.RequiresLineOfSight = false
                end

                if not isInsideContainer then
                    prompt:SetAttribute("GateFacing", 180)
                    prompt:SetAttribute("GateLOS", false)
                    if prompt:GetAttribute("GateSector") and prompt:GetAttribute("GateSector") ~= "Any" then
                        prompt:SetAttribute("GateSector", "Any")
                    end
                end
            else
                if S.Caches.promptOriginalDist[prompt] ~= nil then
                    prompt.MaxActivationDistance = S.Caches.promptOriginalDist[prompt]
                    prompt.RequiresLineOfSight = S.Caches.promptOriginalLoS[prompt]
                    prompt:SetAttribute("GateFacing", S.Caches.promptOriginalFacing[prompt])
                    prompt:SetAttribute("GateLOS", S.Caches.promptOriginalGateLOS[prompt])
                    prompt:SetAttribute("GateSector", S.Caches.promptOriginalGateSector[prompt])
                end
            end

            if isLockOrLockedContainer then
                prompt:SetAttribute("GateCrouch", nil)
                prompt:SetAttribute("GateFacing", 180)
                prompt:SetAttribute("GateLOS", false)
                prompt:SetAttribute("GateSector", "Any")
            end
        end

        S.updateAllPromptsReach = function(enabled)
            for prompt in pairs(S.Caches.prompts) do
                if prompt and prompt.Parent and prompt:IsA("ProximityPrompt") then
                    S.applyReachToPrompt(prompt)
                end
            end
        end

        S.getAnchorKeysToPress = function(targetCodeStr, adder)
            local result = ""
            for digitStr in tostring(targetCodeStr):gmatch("%d") do
                local targetDigit = tonumber(digitStr)
                if targetDigit then
                    local toPress = (targetDigit - adder) % 10
                    result = result .. tostring(toPress < 0 and (toPress + 10) or toPress)
                end
            end
            return result
        end

        S.updateAnchorCache = function()
            table.clear(S.AnchorData.models); S.AnchorData.codeScreen = nil
            local currentRooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
            local room50 = currentRooms and (currentRooms:FindFirstChild("50") or currentRooms:FindFirstChild("150"))
            if not room50 then return end
            local nestHandler = room50:FindFirstChild("_NestHandler") or room50
            S.AnchorData.codeScreen = nestHandler:FindFirstChild("CodeScreen")

            for _, child in ipairs(nestHandler:GetChildren()) do
                if child.Name == "MinesAnchor" then
                    local sign = child:FindFirstChild("Sign")
                    local signText = sign and sign:FindFirstChildWhichIsA("TextLabel", true)
                    local letter = signText and signText.Text or child:GetAttribute("AnchorID")
                    if letter and letter ~= "" then S.AnchorData.models[letter] = child end
                end
            end
        end

        S.getActiveAnchorAndTargetCode = function()
            local hintFrame = PlayerGui:FindFirstChild("AnchorHintFrame", true)
            if hintFrame and hintFrame.Visible then
                local codeLabel, anchorLabel = hintFrame:FindFirstChild("Code"), hintFrame:FindFirstChild("AnchorCode")
                if codeLabel and anchorLabel and codeLabel.Text ~= "" and anchorLabel.Text ~= "" then return anchorLabel.Text, codeLabel.Text end
            end
            if S.AnchorData.codeScreen then
                local gui = S.AnchorData.codeScreen:FindFirstChildWhichIsA("SurfaceGui", true)
                local frame = gui and gui:FindFirstChild("Frame")
                if frame and frame.Visible then
                    local codeLabel, anchorLabel = frame:FindFirstChild("Code"), frame:FindFirstChild("AnchorCode")
                    if codeLabel and anchorLabel and codeLabel.Text ~= "" and anchorLabel.Text ~= "" then return anchorLabel.Text, codeLabel.Text end
                end
            end
            return nil, nil
        end

        S.getAnchorAdder = function(anchorModel)
            if not anchorModel then return 0 end
            if anchorModel:GetAttribute("Adder") ~= nil then return tonumber(anchorModel:GetAttribute("Adder")) or 0 end
            local note = anchorModel:FindFirstChild("Note")
            local noteText = note and note:FindFirstChildWhichIsA("TextLabel", true)
            return (noteText and noteText.Text ~= "") and (tonumber(noteText.Text) or 0) or 0
        end

        S.clickAnchorScreenPoint = function(x, y)
            pcall(function()
                if G.Services.VirtualInputManager then
                    G.Services.VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1); task.wait(0.04)
                    G.Services.VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
                end
            end)
        end

        S.clickAnchor3DPart = function(part)
            if not part then return end
            pcall(function()
                local cd = part:FindFirstChildWhichIsA("ClickDetector")
                if cd and fireclickdetector then fireclickdetector(cd) end
                local cam = G.Services.Workspace.CurrentCamera or Camera
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then S.clickAnchorScreenPoint(screenPos.X, screenPos.Y) end
            end)
        end

        S.clickAnchorGreenLever = function(anchorModel)
            if not anchorModel then return end
            
            for _, desc in ipairs(anchorModel:GetDescendants()) do
                if desc:IsA("ClickDetector") and fireclickdetector then
                    pcall(function() fireclickdetector(desc) end)
                elseif desc:IsA("ProximityPrompt") then
                    pcall(function() triggerPromptInstance(desc) end)
                end
            end

            local remote = anchorModel:FindFirstChild("AnchorRemote") or anchorModel:FindFirstChildWhichIsA("RemoteFunction", true)
            if remote and remote:IsA("RemoteFunction") then
                pcall(function() remote:InvokeServer("Lever") end)
                pcall(function() remote:InvokeServer(true) end)
            elseif remote and remote:IsA("RemoteEvent") then
                pcall(function() remote:FireServer("Lever") end)
                pcall(function() remote:FireServer(true) end)
            end

            local keypad = anchorModel:FindFirstChild("Keypad")
            local b2, b3, b6 = keypad and keypad:FindFirstChild("2"), keypad and keypad:FindFirstChild("3"), keypad and keypad:FindFirstChild("6")
            local leverTipX, leverTipY
            local cam = G.Services.Workspace.CurrentCamera or Camera

            if b2 and b3 and b6 then
                local s2 = cam:WorldToViewportPoint(b2.Position)
                local s3 = cam:WorldToViewportPoint(b3.Position)
                local s6 = cam:WorldToViewportPoint(b6.Position)
                leverTipX = s3.X + ((s3.X - s2.X) * 3.3)
                leverTipY = s3.Y - ((s6.Y - s3.Y) * 1.1)
            else
                leverTipX = cam.ViewportSize.X * 0.755; leverTipY = cam.ViewportSize.Y * 0.380
            end

            pcall(function()
                S.clickAnchorScreenPoint(leverTipX, leverTipY); task.wait(0.06)
                S.clickAnchorScreenPoint(leverTipX - 25, leverTipY + 20); task.wait(0.06)
                S.clickAnchorScreenPoint(leverTipX, leverTipY)
            end)
        end

        S.processSolveAnchor = function(anchorModel, keysToPressStr)
            if not anchorModel or not anchorModel.Parent or S.AnchorData.isSolving then return end
            S.AnchorData.isSolving = true
            task.spawn(function()
                local remote, keypad = anchorModel:FindFirstChild("AnchorRemote"), anchorModel:FindFirstChild("Keypad")
                local keyCodes = {
                    ["0"] = Enum.KeyCode.Zero, ["1"] = Enum.KeyCode.One, ["2"] = Enum.KeyCode.Two, ["3"] = Enum.KeyCode.Three,
                    ["4"] = Enum.KeyCode.Four, ["5"] = Enum.KeyCode.Five, ["6"] = Enum.KeyCode.Six, ["7"] = Enum.KeyCode.Seven,
                    ["8"] = Enum.KeyCode.Eight, ["9"] = Enum.KeyCode.Nine
                }
                for i = 1, #keysToPressStr do
                    local digit = keysToPressStr:sub(i, i)
                    local keyNum = tonumber(digit)
                    if keypad then
                        local keyPart = keypad:FindFirstChild(digit)
                        if keyPart and keyPart:IsA("BasePart") then 
                            S.clickAnchor3DPart(keyPart)
                            local cd = keyPart:FindFirstChildWhichIsA("ClickDetector")
                            if cd and fireclickdetector then fireclickdetector(cd) end
                        end
                    end
                    if keyCodes[digit] and G.Services.VirtualInputManager then
                        pcall(function()
                            G.Services.VirtualInputManager:SendKeyEvent(true, keyCodes[digit], false, game); task.wait(0.02)
                            G.Services.VirtualInputManager:SendKeyEvent(false, keyCodes[digit], false, game)
                        end)
                    end
                    if remote and remote:IsA("RemoteFunction") then 
                        pcall(function() remote:InvokeServer(digit) end)
                        pcall(function() remote:InvokeServer(keyNum) end) 
                    elseif remote and remote:IsA("RemoteEvent") then
                        pcall(function() remote:FireServer(digit) end)
                        pcall(function() remote:FireServer(keyNum) end)
                    end
                    task.wait(0.18)
                end
                task.wait(0.25); S.clickAnchorGreenLever(anchorModel); task.wait(0.3)
                showNotification(getText("msgAnchorSolved"), "Success")
                task.wait(0.8)
                S.AnchorData.isSolving = false
            end)
        end

        S.applySwitchState = function(breakerModel, id, state)
            if not breakerModel then return end
            
            local rem = breakerModel:FindFirstChildWhichIsA("RemoteEvent", true) 
                or (S.Remotes.folder and (S.Remotes.folder:FindFirstChild("ElevatorBreaker") or S.Remotes.folder:FindFirstChild("BreakerSwitch")))
            if rem then
                pcall(function() rem:FireServer(id, state) end)
            end

            for _, child in ipairs(breakerModel:GetChildren()) do
                if child.Name == "BreakerSwitch" and (child:GetAttribute("ID") == id or tonumber(child.Name:match("%d+")) == id) then
                    pcall(function()
                        local cd = child:FindFirstChildWhichIsA("ClickDetector", true)
                        if cd and fireclickdetector then fireclickdetector(cd) end
                        local pr = child:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if pr then triggerPromptInstance(pr) end

                        if child:GetAttribute("Enabled") ~= state then
                            child:SetAttribute("Enabled", state)
                            if child:FindFirstChild("Sound") then child.Sound:Play() end
                            local prismatic = child:FindFirstChild("PrismaticConstraint", true)
                            if prismatic then prismatic.TargetPosition = state and -0.2 or 0.2 end
                            if child:FindFirstChild("Light") then child.Light.Material = state and Enum.Material.Neon or Enum.Material.Glass end
                        end
                    end)
                    break
                end
            end
        end

        S.PadlockData = {
            hints = {},
            currentCode = nil,
            isUnlocked = false
        }

        local function getHintPaper()
            local char = player.Character
            if char then
                local tool = char:FindFirstChild("LibraryHintPaper")
                if tool then return tool end
            end
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local tool = backpack:FindFirstChild("LibraryHintPaper")
                if tool then return tool end
            end
            return G.Services.Workspace:FindFirstChild("LibraryHintPaper", true)
        end

        local function scanExistingPermUIHints()
            local permUI = PlayerGui:FindFirstChild("PermUI")
            local hintsFolder = permUI and permUI:FindFirstChild("Hints")
            if not hintsFolder then return end

            for _, child in ipairs(hintsFolder:GetChildren()) do
                if child.Name == "Icon" and child:IsA("ImageLabel") then
                    local textLabel = child:FindFirstChildOfClass("TextLabel")
                    if textLabel and textLabel.Text ~= "" then
                        local shapeIndex = G.Math.floor((child.ImageRectOffset.X + 25) / 50)
                        S.PadlockData.hints[shapeIndex] = tostring(textLabel.Text)
                    end
                end
            end
        end

        local function tryCalculateCode()
            if S.PadlockData.isUnlocked then return nil end
            local paper = getHintPaper()
            local paperUI = paper and paper:FindFirstChild("UI", true)
            if not paperUI then return nil end

            local digits = {}
            local knownCount = 0

            for slotIndex = 1, 5 do
                local slot = paperUI:FindFirstChild(tostring(slotIndex), true)
                if slot and slot:IsA("ImageLabel") then
                    local shapeIndex = G.Math.floor((slot.ImageRectOffset.X + 25) / 50)
                    local digit = S.PadlockData.hints[shapeIndex]
                    if digit ~= nil then
                        digits[slotIndex] = tostring(digit)
                        knownCount = knownCount + 1
                    else
                        digits[slotIndex] = "_"
                    end
                else
                    digits[slotIndex] = "_"
                end
            end

            if knownCount == 5 then
                return digits[1] .. digits[2] .. digits[3] .. digits[4] .. digits[5]
            end
            return nil
        end

        task.spawn(function()
            local rf = G.Services.ReplicatedStorage:WaitForChild("RemotesFolder", 5)
            local phRemote = rf and rf:WaitForChild("PadlockHint", 5)
            if phRemote then
                S.Runtime.connections[#S.Runtime.connections + 1] = phRemote.OnClientEvent:Connect(function(shapeId, digitValue)
                    if shapeId == nil then
                        table.clear(S.PadlockData.hints)
                        S.PadlockData.currentCode = nil
                        return
                    end
                    if digitValue ~= nil then
                        S.PadlockData.hints[G.Math.floor(shapeId)] = tostring(digitValue)
                    end
                end)
            end
        end)

        task.spawn(function()
            while S.Runtime.running do
                if not states.autoPadlock or S.PadlockData.isUnlocked then
                    task.wait(1.5)
                else
                    task.wait(0.35)
                    scanExistingPermUIHints()
                    local solved = tryCalculateCode()
                    if solved then
                        S.PadlockData.currentCode = solved
                        local padlock = G.Services.Workspace:FindFirstChild("Padlock", true)
                        if padlock and padlock:FindFirstChild("Padlocked") then
                            if not padlock.Padlocked.Value then
                                S.PadlockData.isUnlocked = true
                            else
                                local char = player.Character
                                local root = char and char:FindFirstChild("HumanoidRootPart")
                                local padBase = padlock:FindFirstChild("Main") or padlock:FindFirstChild("Base") or padlock.PrimaryPart or padlock:FindFirstChildOfClass("BasePart")
                                if root and padBase then
                                    local dx, dy, dz = root.Position.X - padBase.Position.X, root.Position.Y - padBase.Position.Y, root.Position.Z - padBase.Position.Z
                                    if (dx*dx + dy*dy + dz*dz) <= 4225 then
                                        S.PadlockData.isUnlocked = true
                                        pcall(function()
                                            local rf = G.Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
                                            local plRemote = rf and rf:FindFirstChild("PL")
                                            if plRemote then
                                                plRemote:FireServer(solved)
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
        -- [ОБХОД PROMPTGATE]: МЯГКАЯ СИНХРОНИЗАЦИЯ БЕЗ ВОЙНЫ С ДВИЖКОМ
        local primaryPartFixed = setmetatable({}, {__mode = "k"})

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 0.35 or 0.2)
                
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local myPos = hrp and hrp.Position
                if not myPos then continue end

                for prompt in pairs(S.Caches.prompts) do
                    if prompt and prompt.Parent and prompt:IsA("ProximityPrompt") and prompt.Name ~= "FPrompt" then
                        if prompt:GetAttribute("_ServerEnabled") ~= false then
                            local pPos = getPromptWorldPosition(prompt)
                            if pPos then
                                local dx = pPos.X - myPos.X
                                local dy = pPos.Y - myPos.Y
                                local dz = pPos.Z - myPos.Z
                                if (dx*dx + dy*dy + dz*dz) <= 2025 then
                                    local pParent = prompt.Parent

                                    -- Удаляем клиентский тег отключения промпта при нажатии
                                    if G.Services.CollectionService:HasTag(prompt, "DisableWhenEnabledOnClient") then
                                        pcall(function()
                                            G.Services.CollectionService:RemoveTag(prompt, "DisableWhenEnabledOnClient")
                                        end)
                                    end

                                    -- Назначаем PrimaryPart только контейнеру (НЕ перезаписывая PrimaryPart комнаты!)
                                    local cMod = pParent
                                    local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
                                    while cMod and cMod ~= G.Services.Workspace and cMod ~= cr and cMod.Parent ~= cr and cMod.Name ~= "Assets" do
                                        if cMod:IsA("Model") and not primaryPartFixed[cMod] then
                                            primaryPartFixed[cMod] = true
                                            if cMod:GetAttribute("PromptShowDelay") and cMod:GetAttribute("PromptShowDelay") > 0 then
                                                pcall(function() cMod:SetAttribute("PromptShowDelay", 0) end)
                                            end
                                        end
                                        cMod = cMod.Parent
                                    end

                                    -- Снимаем ограничения ракурса, сектора, видимости и приседания
                                    -- ВАЖНО: НЕ удаляем GateTool, чтобы PromptGate корректно отслеживал наличие отмычки/ключа в руках!
                                    if prompt:GetAttribute("GateFacing") ~= 180 then
                                        prompt:SetAttribute("GateFacing", 180)
                                    end
                                    if prompt:GetAttribute("GateLOS") ~= false then
                                        prompt:SetAttribute("GateLOS", false)
                                    end
                                    if prompt:GetAttribute("GateSector") and prompt:GetAttribute("GateSector") ~= "Any" then
                                        prompt:SetAttribute("GateSector", "Any")
                                    end
                                    if prompt:GetAttribute("GateCrouch") ~= nil then
                                        prompt:SetAttribute("GateCrouch", nil)
                                    end

                                    -- Разблокируем промпт ТОЛЬКО если он был скрыт из-за камеры/угла/приседания, но НЕ из-за отсутствия предмета (Tool)
                                    local reason = prompt:GetAttribute("_GateReason")
                                    if (reason == "Facing" or reason == "LOS" or reason == "Sector" or reason == "Crouch") and prompt.Enabled == false then
                                        prompt:SetAttribute("_GateReason", nil)
                                        prompt:SetAttribute("_GateDisabled", nil)
                                        prompt.Enabled = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
    -- ====================================================================
    --                  ОСНОВНОЙ КОМПОНЕНТ UI (SETUP UI)
    -- ====================================================================
    local function SetupUI(S)
        local function cTextConstraint(minS, maxS, p)
            return create("UITextSizeConstraint", {MinTextSize = minS or 8, MaxTextSize = maxS or 11, Parent = p})
        end

        local function updateRowChildren(row, childHeight)
            if not row then return end
            local children = {}
            for _, child in ipairs(row:GetChildren()) do
                if child:IsA("GuiObject") and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
                    table.insert(children, child)
                end
            end
            local n = #children
            if n == 0 then return end
            local gap = 6
            local h = childHeight or row.Size.Y.Offset
            if h <= 0 then h = 38 end
            for _, child in ipairs(children) do
                child.Size = G.Math.ud2(1 / n, -math.floor(((n - 1) * gap) / n), 0, h)
            end
        end

        local viewport = Camera.ViewportSize
        local initialWidth = G.Math.clamp(viewport.X * 0.48, 480, 640)
        local initialHeight = G.Math.clamp(viewport.Y * 0.58, 330, 440)

        -- Главное окно
        S.MainFrame = create("Frame", {
            Name = "MainFrame",
            Size = G.Math.ud2(0, initialWidth, 0, initialHeight),
            Position = G.Math.ud2(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = HW.BG,
            Active = true,
            ClipsDescendants = true,
            Parent = S.ScreenGui
        }, {
            cCorner(14),
            cStroke(HW.STROKE, 1.5),
            create("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new(HW.BG, HW.BG_BOTTOM)
            }),
            create("UISizeConstraint", {MinSize = Vector2.new(450, 300), MaxSize = Vector2.new(900, 650)})
        })

        S.MainScale = create("UIScale", {Scale = 1, Parent = S.MainFrame})

        -- Верхняя плашка (Titlebar)
        S.TopBar = create("Frame", {
            Name = "TopBar",
            Size = G.Math.ud2(1, 0, 0, 42),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Parent = S.MainFrame
        }, {
            create("TextLabel", {
                Name = "HubTitle",
                Size = G.Math.ud2(0, 220, 1, 0),
                Position = G.Math.ud2(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = THEME_EMOJI .. "HUBHUBHUB",
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBlack,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        })
        makeDraggable(S.TopBar, S.MainFrame)

        -- Кнопка закрытия
        S.closeBtn = create("TextButton", {
            Name = "CloseBtn",
            Size = G.Math.ud2(0, 28, 0, 28),
            Position = G.Math.ud2(1, -36, 0.5, -14),
            BackgroundColor3 = HW.PANEL_2,
            Text = "X",
            TextColor3 = HW.TEXT_DIM,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            AutoButtonColor = false,
            Parent = S.TopBar
        }, { cCorner(7), cStroke(HW.STROKE, 1) })

        -- Кнопка сворачивания
        S.minBtn = create("TextButton", {
            Name = "MinBtn",
            Size = G.Math.ud2(0, 28, 0, 28),
            Position = G.Math.ud2(1, -70, 0.5, -14),
            BackgroundColor3 = HW.PANEL_2,
            Text = "—",
            TextColor3 = HW.TEXT_DIM,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            AutoButtonColor = false,
            Parent = S.TopBar
        }, { cCorner(7), cStroke(HW.STROKE, 1) })

        S.closeBtn.MouseEnter:Connect(function()
            G.Services.TweenService:Create(S.closeBtn, G.Math.tw(0.15), {BackgroundColor3 = G.Math.rgb(200, 45, 45), TextColor3 = G.Math.rgb(255, 255, 255)}):Play()
        end)
        S.closeBtn.MouseLeave:Connect(function()
            G.Services.TweenService:Create(S.closeBtn, G.Math.tw(0.15), {BackgroundColor3 = HW.PANEL_2, TextColor3 = HW.TEXT_DIM}):Play()
        end)

        S.minBtn.MouseEnter:Connect(function()
            G.Services.TweenService:Create(S.minBtn, G.Math.tw(0.15), {BackgroundColor3 = HW.PURPLE, TextColor3 = G.Math.rgb(255, 255, 255)}):Play()
        end)
        S.minBtn.MouseLeave:Connect(function()
            G.Services.TweenService:Create(S.minBtn, G.Math.tw(0.15), {BackgroundColor3 = HW.PANEL_2, TextColor3 = HW.TEXT_DIM}):Play()
        end)

        -- Ручка изменения размера в правом нижнем углу
        S.ResizeGrip = create("ImageButton", {
            Name = "ResizeCorner",
            Size = G.Math.ud2(0, 20, 0, 20),
            Position = G.Math.ud2(1, 0, 1, 0),
            AnchorPoint = Vector2.new(1, 1),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5854832560",
            ImageColor3 = G.Math.rgb(140, 140, 150),
            ImageTransparency = 0.4,
            ZIndex = 25,
            Parent = S.MainFrame
        })

        S.isResizing = false
        S.resizeStartPos = Vector2.new(0, 0)
        S.resizeStartSize = Vector2.new(S.MainFrame.AbsoluteSize.X, S.MainFrame.AbsoluteSize.Y)

        S.ResizeGrip.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                S.isResizing = true
                S.resizeStartPos = Vector2.new(input.Position.X, input.Position.Y)
                S.resizeStartSize = Vector2.new(S.MainFrame.AbsoluteSize.X, S.MainFrame.AbsoluteSize.Y)
                G.Services.TweenService:Create(S.ResizeGrip, G.Math.tw(0.1), {ImageColor3 = G.Math.rgb(255, 255, 255), ImageTransparency = 0}):Play()
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.UserInputService.InputChanged:Connect(function(input)
            if S.isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = Vector2.new(input.Position.X, input.Position.Y) - S.resizeStartPos
                S.MainFrame.Size = G.Math.ud2(0, G.Math.clamp(S.resizeStartSize.X + delta.X, 450, 900), 0, G.Math.clamp(S.resizeStartSize.Y + delta.Y, 300, 650))
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.UserInputService.InputEnded:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and S.isResizing then
                S.isResizing = false
                G.Services.TweenService:Create(S.ResizeGrip, G.Math.tw(0.2), {ImageColor3 = G.Math.rgb(140, 140, 150), ImageTransparency = 0.4}):Play()
            end
        end)

        -- Боковая панель категорий (Sidebar)
        S.Sidebar = create("Frame", {
            Name = "Sidebar",
            Size = G.Math.ud2(0, 130, 1, -42),
            Position = G.Math.ud2(0, 0, 0, 42),
            BackgroundColor3 = HW.PANEL,
            BorderSizePixel = 0,
            ZIndex = 5,
            Parent = S.MainFrame
        }, {
            cCorner(14),
            create("Frame", {Name = "TopPatch", Size = G.Math.ud2(1, 0, 0, 16), Position = G.Math.ud2(0, 0, 0, 0), BackgroundColor3 = HW.PANEL, BorderSizePixel = 0}),
            create("Frame", {Name = "RightPatch", Size = G.Math.ud2(0, 16, 1, 0), Position = G.Math.ud2(1, -16, 0, 0), BackgroundColor3 = HW.PANEL, BorderSizePixel = 0})
        })

        S.SidebarContent = create("Frame", {
            Name = "ButtonContainer",
            Size = G.Math.ud2(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 6,
            Parent = S.Sidebar
        }, {
            create("UIPadding", {PaddingTop = G.Math.ud(0, 8)}),
            create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center})
        })

        -- Единая подложка контента
        S.ContentBackdrop = create("Frame", {
            Name = "ContentBackdrop",
            Size = G.Math.ud2(1, -130, 1, -42),
            Position = G.Math.ud2(0, 130, 0, 42),
            BackgroundColor3 = HW.BG_BOTTOM,
            BorderSizePixel = 0,
            ZIndex = 4,
            Parent = S.MainFrame
        }, {
            cCorner(14)
        })

        -- Контентная зона и поиск
        S.Content = create("Frame", {
            Name = "Content",
            Size = G.Math.ud2(1, -130, 1, -42),
            Position = G.Math.ud2(0, 130, 0, 42),
            BackgroundTransparency = 1,
            ZIndex = 5,
            Parent = S.MainFrame
        })

        S.SearchContainer = create("Frame", {
            Name = "SearchBarFrame",
            Size = G.Math.ud2(1, -20, 0, 32),
            Position = G.Math.ud2(0, 10, 0, 6),
            BackgroundColor3 = HW.PANEL,
            ZIndex = 6,
            Parent = S.Content
        }, {
            cCorner(6),
            cStroke(HW.STROKE, 1),
            create("ImageLabel", {
                Size = G.Math.ud2(0, 14, 0, 14),
                Position = G.Math.ud2(0, 9, 0.5, -7),
                BackgroundTransparency = 1,
                Image = "rbxassetid://3926305904",
                ImageRectOffset = Vector2.new(964, 324),
                ImageRectSize = Vector2.new(36, 36),
                ImageColor3 = HW.ORANGE_DIM
            })
        })

        S.SearchBox = create("TextBox", {
            Size = G.Math.ud2(1, -56, 1, 0),
            Position = G.Math.ud2(0, 30, 0, 0),
            BackgroundTransparency = 1,
            PlaceholderText = getText("searchPlaceholder"),
            Text = "",
            TextColor3 = HW.TEXT,
            PlaceholderColor3 = HW.TEXT_DIM,
            Font = Enum.Font.GothamMedium,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
            ZIndex = 7,
            Parent = S.SearchContainer
        })

        S.SearchClearBtn = create("TextButton", {
            Name = "ClearSearchBtn",
            Size = G.Math.ud2(0, 22, 0, 22),
            Position = G.Math.ud2(1, -26, 0.5, -11),
            BackgroundColor3 = HW.PANEL_2,
            Text = "✖",
            TextColor3 = HW.TEXT_DIM,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            Visible = false,
            AutoButtonColor = false,
            ZIndex = 8,
            Parent = S.SearchContainer
        }, { cCorner(11) })

        S.SearchClearBtn.MouseButton1Click:Connect(function()
            S.SearchBox.Text = ""
            S.SearchClearBtn.Visible = false
            if S.applySearchFilter then S.applySearchFilter("") end
        end)

        -- Плавающая кнопка для телефонов
        S.MiniButton = create("TextButton", {
            Size = G.Math.ud2(0, 48, 0, 48),
            Position = G.Math.ud2(0, 20, 0.5, -24),
            BackgroundColor3 = HW.BG,
            Text = "",
            Visible = false,
            Parent = S.ScreenGui
        }, {
            cCorner(12),
            cStroke(HW.STROKE, 1.5),
            create("ImageLabel", {
                Size = G.Math.ud2(1, -14, 1, -14),
                Position = G.Math.ud2(0, 7, 0, 7),
                BackgroundTransparency = 1,
                Image = "rbxassetid://7059346373",
                ImageColor3 = G.Math.rgb(240, 240, 245),
                ScaleType = Enum.ScaleType.Fit
            })
        })
        makeDraggable(S.MiniButton)

        -- Модальное окно подтверждения закрытия
        S.ModalOverlay = create("Frame", {
            Name = "ModalOverlay",
            Size = G.Math.ud2(1, 0, 1, 0),
            BackgroundColor3 = G.Math.rgb(0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            ZIndex = 50,
            Parent = S.MainFrame
        }, { cCorner(14) })

        S.ModalCard = create("Frame", {
            Name = "ModalCard",
            Size = G.Math.ud2(0, 290, 0, 145),
            Position = G.Math.ud2(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = HW.PANEL,
            ZIndex = 51,
            Parent = S.ModalOverlay
        }, {
            cCorner(10),
            cStroke(HW.STROKE, 1.5),
            create("TextLabel", {
                Name = "Title",
                Size = G.Math.ud2(1, -20, 0, 24),
                Position = G.Math.ud2(0, 10, 0, 14),
                BackgroundTransparency = 1,
                Text = getText("modalCloseTitle"),
                TextColor3 = G.Math.rgb(255, 255, 255),
                Font = Enum.Font.GothamBlack,
                TextSize = 13,
                ZIndex = 52
            }),
            create("TextLabel", {
                Name = "Desc",
                Size = G.Math.ud2(1, -28, 0, 36),
                Position = G.Math.ud2(0, 14, 0, 42),
                BackgroundTransparency = 1,
                Text = getText("modalCloseDesc"),
                TextColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextWrapped = true,
                ZIndex = 52
            })
        })

        S.ModalBtnRow = create("Frame", {
            Size = G.Math.ud2(1, -24, 0, 32),
            Position = G.Math.ud2(0, 12, 1, -44),
            BackgroundTransparency = 1,
            ZIndex = 52,
            Parent = S.ModalCard
        }, {
            create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = G.Math.ud(0.06, 0), HorizontalAlignment = Enum.HorizontalAlignment.Center})
        })

        S.modalBtnCancel = create("TextButton", {
            Size = G.Math.ud2(0.47, 0, 1, 0),
            BackgroundColor3 = HW.PANEL_2,
            Text = getText("modalBtnCancel"),
            TextColor3 = HW.TEXT,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            ZIndex = 53,
            Parent = S.ModalBtnRow
        }, { cCorner(6), cStroke(HW.STROKE, 1) })

        S.modalBtnConfirm = create("TextButton", {
            Size = G.Math.ud2(0.47, 0, 1, 0),
            BackgroundColor3 = G.Math.rgb(210, 45, 45),
            Text = getText("modalBtnConfirm"),
            TextColor3 = G.Math.rgb(255, 255, 255),
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            ZIndex = 53,
            Parent = S.ModalBtnRow
        }, { cCorner(6) })

        S.showCloseConfirmation = function(show)
            if show then
                S.ModalOverlay.Visible = true
                S.ModalCard.Size = G.Math.ud2(0, 260, 0, 130)
                G.Services.TweenService:Create(S.ModalOverlay, G.Math.tw(0.2), {BackgroundTransparency = 0.45}):Play()
                G.Services.TweenService:Create(S.ModalCard, G.Math.tw(0.25, Enum.EasingStyle.Back), {Size = G.Math.ud2(0, 290, 0, 145)}):Play()
            else
                local t = G.Services.TweenService:Create(S.ModalOverlay, G.Math.tw(0.18), {BackgroundTransparency = 1})
                G.Services.TweenService:Create(S.ModalCard, G.Math.tw(0.18), {Size = G.Math.ud2(0, 260, 0, 130)}):Play()
                t:Play()
                t.Completed:Connect(function()
                    if S.ModalOverlay.BackgroundTransparency >= 0.99 then
                        S.ModalOverlay.Visible = false
                    end
                end)
            end
        end

        S.closeBtn.MouseButton1Click:Connect(function() S.showCloseConfirmation(true) end)
        S.modalBtnCancel.MouseButton1Click:Connect(function() S.showCloseConfirmation(false) end)

        S.modalBtnConfirm.MouseButton1Click:Connect(function()
            if S.applySuperFps then S.applySuperFps(false) end
            S.Runtime.running = false
            states.creakBypass = false
            if S.toggleGPSPath then S.toggleGPSPath(false) end
            if S.toggleAntiSeekFlood then S.toggleAntiSeekFlood(false) end
            states.antiSeekObstacles = false
            states.autoRooms = false
            if S.Runtime.autoRoomsThread then task.cancel(S.Runtime.autoRoomsThread) end
            if S.toggleBridgePatch then S.toggleBridgePatch(false) end
            if player:GetAttribute("LookVector") ~= nil then player:SetAttribute("LookVector", nil) end
            if player.Character and player.Character:GetAttribute("LookVector") ~= nil then player.Character:SetAttribute("LookVector", nil) end
            states.antiEyes = false
            states.statOxygen = false
            states.statBackdoorTimer = false
            pcall(function()
                local screechModule = S.getScreechModule()
                if screechModule then screechModule:SetAttribute("Static", nil) end
            end)
            states.statHonchoTimer = false
            if S.StatsHUD then S.StatsHUD:Destroy() end
            updateScreechOnAttribute()
            states.antiNoise = false
            states.antiMonument = false
            states.speedEnabled = false
            states.fullbright = false
            states.antiAlma = false
            states.noclip = false
            states.autoPadlock = false
            states.thirdPerson = false
            if S.applyFullbrightProperties then S.applyFullbrightProperties(true) end

            if S.FunModule and S.FunModule.cleanup then
                S.FunModule.cleanup()
            end

            states.autoHide = false
            states.noCamEffects = false
            states.noCamShake = false
            states.tvStandEsp = false
            states.scrapperEsp = false
            if S.applyNoCamEffects then S.applyNoCamEffects(false) end
            states.autoLoot = false
            states.autoInteract = false
            states.instantPrompt = false
            states.reachEnabled = false
            states.glowstickEnabled = false
            states.autoAnchor = false
            states.autoHeartbeat = false
            states.playerEsp = false
            states.infItems = false
            states.antiScribbles = false
            states.autoTellerTicket = false
            states.positionSpoof = false
            states.honchoBoxEsp = false
            if S.clearAllHonchoESP then S.clearAllHonchoESP() end
            if S.updatePositionSpoof then S.updatePositionSpoof(false) end
            if S.updateAllInfPrompts then S.updateAllInfPrompts(false) end
            if S.updateAllPromptsReach then S.updateAllPromptsReach(false) end
            if S.applyAntiVacuum then S.applyAntiVacuum(false) end
            if S.setPuddleImmunity then S.setPuddleImmunity(false) end
            
            if S.swapRemoteState then S.swapRemoteState("SurgeRemote", false) end
            if S.updateAllPlayerEsp then S.updateAllPlayerEsp(false) end
            if S.restorePromptDurations then S.restorePromptDurations() end
            if S.updateJumpState then S.updateJumpState(false) end
            
            if S.clearAllTracers then S.clearAllTracers() end
            if S.mobileNoclipContainer then S.mobileNoclipContainer:Destroy() end
            if S.Runtime.autoHideThread then task.cancel(S.Runtime.autoHideThread) end
            if S.RestoreCharacterNormalState then S.RestoreCharacterNormalState(player.Character) end
            if S.RestoreCharacterTransparency then S.RestoreCharacterTransparency(player.Character) end

            pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_ThirdPersonHook") end)
            pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_StopCamProbe") end)
            pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_NoCamShake") end)
            if getgenv()._HUBHUBHUB_RESTORE_NC then getgenv()._HUBHUBHUB_RESTORE_NC() end

            for _, conn in ipairs(S.Runtime.connections) do if conn.Connected then conn:Disconnect() end end
            table.clear(S.Runtime.connections)
            for obj, data in pairs(S.activeHighlights) do
                if data.group then pcall(function() data.group:Destroy() end) end
            end
            table.clear(S.activeHighlights); table.clear(S.Caches.lights); table.clear(S.Caches.rooms); table.clear(S.Caches.prompts)
            S.ScreenGui:Destroy()
            if NotificationGui then NotificationGui:Destroy() end
            getgenv()._HUBHUBHUB_ACTIVE = nil
        end)
    end

    -- ====================================================================
    --                  ИНИЦИАЛИЗАЦИЯ И СБОРКА СТРУКТУРЫ
    -- ====================================================================
    local function LoadMainScript()
        
        local S = {}

        -- [ФИКС]: Загружаем сохранённые состояния ДО создания интерфейса
        local function loadInitialSession()
            if not readfile or not isfile then return end
            local sessionPath = KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.SESSION_RESTORE_FILE
            if isfile(sessionPath) then
                local ok, data = pcall(function() 
                    return G.Services.HttpService:JSONDecode(readfile(sessionPath)) 
                end)
                if ok and type(data) == "table" and data.states then
                    for k, v in pairs(data.states) do
                        if states[k] ~= nil then
                            if type(v) == "table" and type(states[k]) == "table" then
                                for subK, subV in pairs(v) do states[k][subK] = subV end
                            else
                                states[k] = v
                            end
                        end
                    end
                end
            end
        end
        loadInitialSession()
        -- Применяем сохранённую тему ДО сборки интерфейса
        applyPalette(states.theme or DEFAULT_THEME)
        S.cleanDreadLogic = function() end
        S.cleanScreechLogic = function() end
        S.cleanA90Logic = function() end
        S.cleanHaltLogic = function() end
        S.cleanGiggleLogic = function() end
        S.neutralizeScreechInstance = function() end
        S.removePlayerEsp = function() end
        S.updateAllPlayerEsp = function() end
        S.updateAllInfPrompts = function() end
        S.updateAllPromptsReach = function() end
        S.updateAllPromptsInstant = function() end
        S.restorePromptDurations = function() end

        S.Runtime = {
            running = true, connections = {}, hasShownSpeedWarning = false,
            autoRoomsThread = nil,
            autoHideThread = nil, globalPipeConn = nil,
            sharedPath = G.Services.PathfindingService:CreatePath({ AgentRadius = 1.8, AgentHeight = 5.0, AgentCanJump = false, WaypointSpacing = 2.4 })
        }

        -- ====================================================================
        --             АВТО-УДАЛЕНИЕ VAULTCOVER НА ФОНЕ
        -- ====================================================================
        local function checkAndRemoveVaultCover(inst)
            if not inst then return end
            if inst.Name == "VaultCover" then
                pcall(function()
                    inst:Destroy()
                end)
            end
        end

        -- 1. Удаление, если объект уже есть в иерархии
        pcall(function()
            local sgDirect = player:FindFirstChild("ScreenGui")
            if sgDirect then
                local vc = sgDirect:FindFirstChild("VaultCover")
                if vc then vc:Destroy() end
            end

            local pGui = player:FindFirstChild("PlayerGui")
            if pGui then
                local sgGui = pGui:FindFirstChild("ScreenGui")
                if sgGui then
                    local vc = sgGui:FindFirstChild("VaultCover")
                    if vc then vc:Destroy() end
                end
                local deepVc = pGui:FindFirstChild("VaultCover", true)
                if deepVc then deepVc:Destroy() end
            end
        end)

        -- 2. Мгновенная реакция при появлении объекта (0ms задержка)
        S.Runtime.connections[#S.Runtime.connections + 1] = player.DescendantAdded:Connect(function(desc)
            checkAndRemoveVaultCover(desc)
        end)

        local initialPGui = player:FindFirstChild("PlayerGui")
        if initialPGui then
            S.Runtime.connections[#S.Runtime.connections + 1] = initialPGui.DescendantAdded:Connect(function(desc)
                checkAndRemoveVaultCover(desc)
            end)
        end

        -- 3. Фоновый сторож (Watchdog)
        task.spawn(function()
            while S.Runtime.running do
                task.wait(0.3)
                pcall(function()
                    local directTarget = player:FindFirstChild("ScreenGui")
                    if directTarget then
                        local vc = directTarget:FindFirstChild("VaultCover")
                        if vc then vc:Destroy() end
                    end

                    local currentPGui = player:FindFirstChild("PlayerGui")
                    if currentPGui then
                        local guiTarget = currentPGui:FindFirstChild("ScreenGui")
                        if guiTarget then
                            local vc = guiTarget:FindFirstChild("VaultCover")
                            if vc then vc:Destroy() end
                        end

                        local anyVc = currentPGui:FindFirstChild("VaultCover", true)
                        if anyVc then anyVc:Destroy() end
                    end
                end)
            end
        end)

        S.Caches = {
            lights = setmetatable({}, {__mode = "k"}), rooms = setmetatable({}, {__mode = "k"}),
            doors = setmetatable({}, {__mode = "k"}), prompts = setmetatable({}, {__mode = "k"}),
            promptDurations = setmetatable({}, {__mode = "k"}), promptCooldowns = setmetatable({}, {__mode = "k"}),
            promptOriginalDist = setmetatable({}, {__mode = "k"}), promptOriginalLoS = setmetatable({}, {__mode = "k"}),
            heartbeatHalves = setmetatable({}, {__mode = "k"}), neutralizedScreech = setmetatable({}, {__mode = "k"}),
            lootedHidingSpots = setmetatable({}, {__mode = "k"}),
            cachedBreaker = nil, room100Cleared = false
        }

        S.EntityCache = { eyes = setmetatable({}, {__mode = "k"}), lookman = setmetatable({}, {__mode = "k"}) }
        S.Timers = { 
            text = 0, watermark = 0, light = 0, speedSync = 0, frameCount = 0, frameTime = 0,
            lastRoomUpdate = 0, lastKnownRoom = -1, isLootWorkerBusy = false, 
            currentFPS = 60, lastSurgeAlert = 0, lastPurge = 0,
            lastScreechWatchdog = 0, tracerFrameSkip = 0,
            lastFullbrightCheck = 0, lastPlayerPos = Vector3.new(0, 0, 0)
        }

        S.Remotes = { folder = nil, crouch = nil, a90 = nil, screech = nil, surge = nil, statistics = nil, dropItem = nil }
        S.FakeEvents = { SurgeRemote = nil }
        S.RealEvents = { SurgeRemote = nil }

        S.AnchorData = { isSolving = false, models = {}, codeScreen = nil }
        S.BreakerData = { tracked = {}, roundSeen = {}, lastSeenCode = "" }
        S.AlertCooldowns = {}
        S.alertedEntities = setmetatable({}, {__mode = "k"})

        S.InfItemNames = {
            Lock = true, ChestBoxLocked = true, Cellar = true, Chest_Vine = true,
            CuttableVines = true, SkullLock = true, Toolbox_Locked = true,
            Lock1 = true, Lock2 = true
        }
        S.InfStoredPrompts = {}
        S.InfUsedObjects = setmetatable({}, {__mode = "k"})

        S.UI_STORAGE = {}
        S.activeHighlights = {}
        S.activeTracers = {}
        S.activePlayerHighlights = {}
        S.TabBtns = {}
        S.currentActiveTabBtn = nil
        S.localizedLabels = {}
        S.registeredSearchElements = {}
        S.registeredRows = {}
        S.keybindBtn = nil
        S.createdPuddlePlatforms = {}
        S.VacuumBarriers = {}
        S.Pages = {}
        S.CachedScreenCenter = Vector2.new(640, 360)

        local lighting = G.Services.Lighting
        S.OrigLightingData = {
            Brightness = lighting.Brightness, ClockTime = lighting.ClockTime, FogEnd = lighting.FogEnd,
            FogStart = lighting.FogStart, GlobalShadows = lighting.GlobalShadows, Ambient = lighting.Ambient,
            OutdoorAmbient = lighting.OutdoorAmbient, ExposureCompensation = lighting.ExposureCompensation
        }

        S.currentFullbrightApplied = false
        S.FBEffectOriginals = setmetatable({}, {__mode = "k"})
        S.FB_NEUTRALIZED = {}

        local function fbSnapshot(effect, fields)
            local rec = S.FBEffectOriginals[effect]
            if not rec then
                rec = {}
                S.FBEffectOriginals[effect] = rec
                S.FB_NEUTRALIZED[#S.FB_NEUTRALIZED + 1] = effect
            end
            for _, f in ipairs(fields) do
                if rec[f] == nil then
                    local ok, v = pcall(function() return effect[f] end)
                    if ok then rec[f] = v end
                end
            end
        end

        S.suppressScreenEffects = function()
            local lgt = G.Services.Lighting
            for _, effect in ipairs(lgt:GetChildren()) do
                if effect:IsA("ColorCorrectionEffect") then
                    if effect.Enabled and (effect.Contrast ~= 0 or effect.Saturation ~= 0 or effect.TintColor.R < 1 or effect.TintColor.G < 1 or effect.TintColor.B < 1) then
                        fbSnapshot(effect, {"Contrast", "Saturation", "TintColor"})
                        effect.Contrast = 0
                        effect.Saturation = 0
                        effect.TintColor = Color3.fromRGB(255, 255, 255)
                    end
                elseif effect:IsA("Atmosphere") then
                    if (effect.Density > 0 or effect.Haze > 0 or effect.Glare > 0) then
                        fbSnapshot(effect, {"Density", "Haze", "Glare"})
                        effect.Density = 0
                        effect.Haze = 0
                        effect.Glare = 0
                    end
                elseif effect:IsA("BloomEffect") then
                    if effect.Enabled and effect.Intensity > 0.8 then
                        fbSnapshot(effect, {"Intensity"}); effect.Intensity = 0.5
                    end
                elseif effect:IsA("BlurEffect") then
                    if effect.Enabled and effect.Size > 0 then
                        fbSnapshot(effect, {"Size"}); effect.Size = 0
                    end
                elseif effect:IsA("SunRaysEffect") then
                    if effect.Enabled and effect.Intensity > 0 then
                        fbSnapshot(effect, {"Intensity"}); effect.Intensity = 0
                    end
                end
            end
        end

        S.restoreScreenEffects = function()
            for i = #S.FB_NEUTRALIZED, 1, -1 do
                local effect = S.FB_NEUTRALIZED[i]
                local rec = S.FBEffectOriginals[effect]
                if rec and effect and effect.Parent then
                    for f, v in pairs(rec) do pcall(function() effect[f] = v end) end
                end
                S.FBEffectOriginals[effect] = nil
                S.FB_NEUTRALIZED[i] = nil
            end
        end

        S.applyFullbrightProperties = function(forceOrig)
            local lgt = G.Services.Lighting
            if states.fullbright and not forceOrig then
                local targetBrightness = states.fullbrightBrightness or 2
                lgt.Brightness = targetBrightness
                lgt.ClockTime = 14
                lgt.FogEnd = 100000000
                lgt.FogStart = 0
                lgt.GlobalShadows = false
                lgt.Ambient = G.Math.rgb(150, 150, 150)
                lgt.OutdoorAmbient = G.Math.rgb(150, 150, 150)
                lgt.ExposureCompensation = 0
                S.currentFullbrightApplied = true
                S.suppressScreenEffects()
            else
                if S.currentFullbrightApplied or forceOrig then
                    lgt.Brightness = S.OrigLightingData.Brightness or 1
                    lgt.ClockTime = S.OrigLightingData.ClockTime or 14
                    lgt.FogEnd = S.OrigLightingData.FogEnd or 1000
                    lgt.FogStart = S.OrigLightingData.FogStart or 0
                    lgt.GlobalShadows = (S.OrigLightingData.GlobalShadows ~= nil) and S.OrigLightingData.GlobalShadows or true
                    lgt.Ambient = S.OrigLightingData.Ambient or G.Math.rgb(0, 0, 0)
                    lgt.OutdoorAmbient = S.OrigLightingData.OutdoorAmbient or G.Math.rgb(0, 0, 0)
                    lgt.ExposureCompensation = S.OrigLightingData.ExposureCompensation or 0
                    S.currentFullbrightApplied = false
                    S.restoreScreenEffects()
                end
            end
        end

        S.ScreenGui = create("ScreenGui", {
            Name = "CleanHub_BW_Main",
            Parent = getGuiParent(),
            ResetOnSpawn = false,
            IgnoreGuiInset = true
        })

        -- No Camera Shakes (Безопасный хук через Update без поломки экземпляров тряски в катсценах)
       -- Безопасное отключение тряски камеры через _G.m.csgo без require модулей
        G.Services.RunService:BindToRenderStep("DOORS_NoCamShake", 198, function()
            if states and states.noCamShake then
                local m = getGameMainTableSafe()
                if m then
                    m.csgo = CFrame.new()
                end
            end
        end)

        -- ====================================================================
        -- [ИСПРАВЛЕНО] NO CAMERA EFFECTS (БЕЗ ЗАЛИПАНИЯ ГЛИТЧА И ОВЕРЛЕЕВ)
        -- ====================================================================
        local effectNames = {
            "OxygenBlur", "OxygenCC", "MainColorCorrection", "Sanity", 
            "XBoxColor", "DailyRunColorCorrection", "BL_Blur", "JournalBlur", "DepthOfField"
        }
        local vignetteNames = {
            "DamageVignette", "DamageVignetteDirectional", "SanityVignette", "BrutalVignette", 
            "GlitchScreen", "GlitchEffect", "SeekVignette", "BlinkVignette", "EyelidsVignette", 
            "HideVignette", "PumpkinVignette", "WeirdVignette"
        }

        local savedEffectStates = {}
        local vignetteListeners = setmetatable({}, {__mode = "k"})

        S.applyNoCamEffects = function(enabled)
            local lgt = G.Services.Lighting
            for _, name in ipairs(effectNames) do
                local eff = lgt:FindFirstChild(name)
                if eff and eff:IsA("PostEffect") then
                    if enabled then
                        if savedEffectStates[eff] == nil then 
                            savedEffectStates[eff] = eff.Enabled 
                        end
                        eff.Enabled = false
                    else
                        if savedEffectStates[eff] ~= nil then 
                            eff.Enabled = savedEffectStates[eff] 
                        end
                    end
                end
            end

            local cam = G.Services.Workspace.CurrentCamera or Camera
            if cam then
                for _, child in ipairs(cam:GetChildren()) do
                    -- Не трогаем временные эффекты катсцен (TempCC, TempBlur), чтобы не ломать переходы
                    if child:IsA("PostEffect") and child.Name ~= "TempCC" and child.Name ~= "TempBlur" then
                        if enabled then
                            if savedEffectStates[child] == nil then 
                                savedEffectStates[child] = child.Enabled 
                            end
                            child.Enabled = false
                        else
                            if savedEffectStates[child] ~= nil then 
                                child.Enabled = savedEffectStates[child] 
                            end
                        end
                    end
                end
            end

            local pGui = player:FindFirstChild("PlayerGui")
            local mainUI = pGui and pGui:FindFirstChild("MainUI")
            local mainFrame = mainUI and mainUI:FindFirstChild("MainFrame")
            
            if mainFrame then
                for _, vName in ipairs(vignetteNames) do
                    local vig = mainFrame:FindFirstChild(vName)
                    if vig and vig:IsA("GuiObject") then
                        if enabled then
                            vig.Visible = false
                            
                            if not vignetteListeners[vig] then
                                vignetteListeners[vig] = vig:GetPropertyChangedSignal("Visible"):Connect(function()
                                    if states and states.noCamEffects and vig.Visible then
                                        vig.Visible = false
                                    end
                                end)
                                S.Runtime.connections[#S.Runtime.connections + 1] = vignetteListeners[vig]
                            end
                        else
                            if vignetteListeners[vig] then
                                pcall(function() vignetteListeners[vig]:Disconnect() end)
                                vignetteListeners[vig] = nil
                            end
                        end
                    end
                end
            end

            if not enabled then
                table.clear(savedEffectStates)
            end
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 0.45 or 0.3)
                if states.noCamEffects then 
                    S.applyNoCamEffects(true) 
                end
            end
        end)

        SetupCore(S)
        SetupArchivesAdditions(S)
        SetupTracers(S)
        SetupESPAndScanners(S)
        SetupSolvers(S)

        -- Третье лицо
        local raycastParamsTP = RaycastParams.new()
        raycastParamsTP.FilterType = Enum.RaycastFilterType.Exclude
        local shoulderOffset = Vector3.new(1.6, 0.4, 0)
        local charLtmCache = setmetatable({}, {__mode = "k"})
        local wasInCutsceneTP = false

        local function setCharacterLtm(char, value)
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    if charLtmCache[part] == nil then
                        charLtmCache[part] = part.LocalTransparencyModifier
                    end
                    pcall(function() part.LocalTransparencyModifier = value end)
                end
            end
        end

        S.RestoreCharacterTransparency = function(char)
            char = char or player.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    local prev = charLtmCache[part]
                    if prev ~= nil then
                        pcall(function() part.LocalTransparencyModifier = prev end)
                        charLtmCache[part] = nil
                    end
                    -- Гарантируем, что голова и аксессуары не перекрывают камеру от 1-го лица в катсценах
                    if part.Name == "Head" or part:FindFirstAncestorOfClass("Accessory") then
                        pcall(function() part.LocalTransparencyModifier = 1 end)
                    end
                end
            end
        end

        local preCamFinalPos = nil
        local STOP_CAM_PROBE = Vector3.new(0, 0.00390625, 0)

        -- Приоритет 198 (ровно перед camfinal = 199 в Camera.lua): ставим микро-метку позиции
        pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_StopCamProbe") end)
        G.Services.RunService:BindToRenderStep("DOORS_StopCamProbe", 198, function()
            local cam = G.Services.Workspace.CurrentCamera
            if not cam then return end
            local cf = cam.CFrame
            local probePos = cf.Position + STOP_CAM_PROBE
            preCamFinalPos = probePos
            cam.CFrame = (cf - cf.Position) + probePos
        end)

        -- Приоритет 210 (после camfinal = 199 и staticViewmodel = 205 в Movement.lua)
        local function updateThirdPersonCamera()
            local cam = G.Services.Workspace.CurrentCamera or Camera
            if not cam then return end

            -- Если camfinal (на 199) НЕ перезаписал cam.CFrame, значит в игре сейчас Parent.stopcam == true!
            if preCamFinalPos and (cam.CFrame.Position - preCamFinalPos).Magnitude < 0.0001 then
                -- Возвращаем чистую позицию кадра катсцены без микро-метки
                cam.CFrame = (cam.CFrame - cam.CFrame.Position) + (preCamFinalPos - STOP_CAM_PROBE)
                cam.Focus = cam.CFrame
                isHardwareStopCam = true
            else
                isHardwareStopCam = false
            end

            if not states.thirdPerson then return end

            if isAnyCutscenePlaying() then
                if not wasInCutsceneTP then
                    wasInCutsceneTP = true
                    S.RestoreCharacterTransparency(player.Character)
                end
                return
            end
            wasInCutsceneTP = false

            local char = player.Character
            if not char then return end

            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health <= 0 then return end

            local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
            if not head then return end

            setCharacterLtm(char, 0)

            local baseRig = cam:FindFirstChild("BaseRig")
            if baseRig then
                for _, part in ipairs(baseRig:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.LocalTransparencyModifier = 1
                    end
                end
            end

            local baseCF = cam.CFrame
            local origin = head.Position 
                + (baseCF.RightVector * shoulderOffset.X) 
                + (baseCF.UpVector * shoulderOffset.Y)

            local targetDist = tonumber(states.thirdPersonDistance) or 7.5
            local targetDir = -baseCF.LookVector * targetDist
            raycastParamsTP.FilterDescendantsInstances = {char, cam}
            
            local hit = G.Services.Workspace:Raycast(origin, targetDir, raycastParamsTP)
            local dist = targetDist
            if hit then
                dist = math.clamp((hit.Position - origin).Magnitude - 0.4, 1, targetDist)
            end

            cam.CFrame = (baseCF - baseCF.Position + origin) - (baseCF.LookVector * dist)
            cam.Focus = CFrame.new(origin)
        end

        pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_ThirdPersonHook") end)
        G.Services.RunService:BindToRenderStep("DOORS_ThirdPersonHook", 210, updateThirdPersonCamera)

        local function toggleThirdPersonMode(enabled)
            states.thirdPerson = enabled
            local cam = G.Services.Workspace.CurrentCamera or Camera
            if not enabled then
                S.RestoreCharacterTransparency(player.Character)
                if cam then
                    local baseRig = cam:FindFirstChild("BaseRig")
                    if baseRig then
                        for _, part in ipairs(baseRig:GetDescendants()) do
                            if part:IsA("BasePart") or part:IsA("Decal") then
                                part.LocalTransparencyModifier = 0
                            end
                        end
                    end
                end
            end
        end

        S.getCurrentEquippableTool = function()
            local char = player.Character
            if not char then return nil end
            local tool = char:FindFirstChild("Lockpick") or char:FindFirstChild("SkeletonKey") or char:FindFirstChild("Shears") or char:FindFirstChild("Multitool")
            if tool then return tool end
            local bp = player:FindFirstChild("Backpack")
            if bp then
                return bp:FindFirstChild("Lockpick") or bp:FindFirstChild("SkeletonKey") or bp:FindFirstChild("Shears") or bp:FindFirstChild("Multitool")
            end
            return nil
        end

        S.checkPromptForInf = function(obj)
            if not obj or not obj:IsA("ProximityPrompt") then return end
            -- [КРИТИЧЕСКИЙ ФИКС FPS]: Запрещаем клонам и FPrompt попадать в список обработки
            if obj.Name == "FPrompt" or obj:GetAttribute("InfiniteItems") ~= nil then return end

            local parent = obj.Parent
            local grand = parent and parent.Parent
            if (parent and S.InfItemNames[parent.Name]) or obj.Name == "FusesPrompt" or (grand and grand.Name == "Locker_Small_Locked") then
                if not table.find(S.InfStoredPrompts, obj) then
                    S.InfStoredPrompts[#S.InfStoredPrompts + 1] = obj
                end
            end
        end

        S.setupInfPrompt = function(prompt)
            if not prompt or not prompt.Parent or not states.infItems then return end
            -- Полный запрет повторного клонирования клона
            if prompt.Name == "FPrompt" or prompt:GetAttribute("InfiniteItems") ~= nil then return end

            local parentObj = prompt.Parent
            if S.InfUsedObjects[parentObj] then return end
            if parentObj:FindFirstChild("FPrompt") then return end -- Уже создан, не спавнить дубликаты!

            local tool = S.getCurrentEquippableTool()
            if not tool then
                if prompt:GetAttribute("InfiniteItems") then
                    local fp = parentObj:FindFirstChild("FPrompt")
                    if fp then fp:Destroy() end
                    prompt:SetAttribute("InfiniteItems", nil)
                    prompt:SetAttribute("Tool", nil)
                    prompt.Enabled = true
                    prompt.ClickablePrompt = true
                end
                return
            end
            local toolName = tool.Name

            prompt.Enabled = false
            prompt.ClickablePrompt = false
            prompt:SetAttribute("InfiniteItems", true)
            prompt:SetAttribute("Tool", toolName)

            local clone = prompt:Clone()
            clone.Name = "FPrompt"
            clone.MaxActivationDistance = prompt.MaxActivationDistance

            -- Очищаем клон от ограничений движка DOORS
            clone:SetAttribute("InfiniteItems", true)
            clone:SetAttribute("Tool", nil)
            clone:SetAttribute("GateTool", nil)
            clone:SetAttribute("GateNoTool", nil)
            clone:SetAttribute("GateCrouch", nil)
            clone:SetAttribute("GateFacing", 180)
            clone:SetAttribute("GateLOS", false)
            clone:SetAttribute("GateSector", "Any")
            clone:SetAttribute("_GateDisabled", nil)
            clone:SetAttribute("_GateReason", nil)
            clone.RequiresLineOfSight = false

            clone.Parent = parentObj
            clone.Enabled = true
            clone.ClickablePrompt = true

            clone.Triggered:Connect(function()
                S.InfUsedObjects[parentObj] = true
                if clone and clone.Parent then clone:Destroy() end

                task.spawn(function()
                    local curTool = S.getCurrentEquippableTool()
                    if not curTool then
                        prompt:SetAttribute("InfiniteItems", nil)
                        prompt:SetAttribute("Tool", nil)
                        prompt.Enabled = true
                        prompt.ClickablePrompt = true
                        return
                    end

                    local dropInstance = nil
                    local dropConn
                    local dropsFolder = G.Services.Workspace:FindFirstChild("Drops")
                    if dropsFolder then
                        dropConn = dropsFolder.ChildAdded:Connect(function(child)
                            if child.Name == toolName then
                                dropInstance = child
                                if dropConn then dropConn:Disconnect() dropConn = nil end
                            end
                        end)
                    end

                    if not S.Remotes.dropItem then S.updateRemotes() end
                    if S.Remotes.dropItem then
                        S.Remotes.dropItem:FireServer(curTool)
                    elseif S.Remotes.folder and S.Remotes.folder:FindFirstChild("DropItem") then
                        S.Remotes.folder.DropItem:FireServer(curTool)
                    end

                    local t0 = tick()
                    while not dropInstance and tick() - t0 < 0.35 do task.wait() end
                    if dropConn then dropConn:Disconnect() dropConn = nil end

                    task.defer(function()
                        prompt.Enabled = true
                        triggerPromptInstance(prompt, true)
                    end)

                    if dropInstance then
                        local dp = dropInstance:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if dp then
                            triggerPromptInstance(dp)
                        end
                    end

                    prompt:SetAttribute("InfiniteItems", nil)
                    prompt:SetAttribute("Tool", nil)
                    prompt.Enabled = true
                    prompt.ClickablePrompt = true
                end)
            end)
        end

        S.cleanStoredInfPrompts = function()
            for i = #S.InfStoredPrompts, 1, -1 do
                local p = S.InfStoredPrompts[i]
                if not p or not p.Parent then
                    table.remove(S.InfStoredPrompts, i)
                end
            end
        end

        S.updateAllInfPrompts = function(enabled)
            if enabled then
                table.clear(S.InfStoredPrompts)
                for prompt in pairs(S.Caches.prompts) do
                    if prompt and prompt.Parent then
                        S.checkPromptForInf(prompt)
                    end
                end
            else
                for _, prompt in ipairs(S.InfStoredPrompts) do
                    if prompt and prompt.Parent and prompt:GetAttribute("InfiniteItems") then
                        local fp = prompt.Parent:FindFirstChild("FPrompt")
                        if fp then fp:Destroy() end
                        prompt:SetAttribute("InfiniteItems", nil)
                        prompt:SetAttribute("Tool", nil)
                        prompt.Enabled = true
                        prompt.ClickablePrompt = true
                    end
                end
                table.clear(S.InfStoredPrompts)
            end
        end

        -- Анти-вакуум
        local neutralizedVacuums = setmetatable({}, {__mode = "k"})

        local function neutralizeAndBlockVacuum(sideroom)
            if not sideroom or not sideroom:IsA("Model") or sideroom.Name ~= "SideroomSpace" then return end
            if not states.antiVacuum then return end
            if neutralizedVacuums[sideroom] then return end
            neutralizedVacuums[sideroom] = true

            task.defer(function()
                if not sideroom.Parent or not states.antiVacuum then return end

                local colPart = sideroom:FindFirstChild("Collision") or sideroom:WaitForChild("Collision", 1.5)
                local startPart = sideroom:FindFirstChild("Start") or sideroom:WaitForChild("Start", 1.5)
                local partsFolder = sideroom:FindFirstChild("Parts")
                local floorPart = partsFolder and partsFolder:FindFirstChild("Floor")

                if colPart and colPart:IsA("BasePart") then
                    colPart.CanTouch = false
                    colPart.CanQuery = false
                    colPart.CanCollide = true
                end

                if startPart and startPart:IsA("BasePart") then
                    startPart.CanTouch = false
                    startPart.CanQuery = false
                    startPart.CanCollide = true
                end

                if floorPart and floorPart:IsA("BasePart") then
                    floorPart.CanTouch = false
                    floorPart.CanQuery = false
                end

                if not sideroom:FindFirstChild("AntiVacuum_Wall") then
                    local refPart = startPart or colPart
                    if refPart and refPart:IsA("BasePart") then
                        local wall = Instance.new("Part")
                        wall.Name = "AntiVacuum_Wall"
                        wall.Anchored = true
                        wall.CanCollide = true
                        wall.CanTouch = false
                        wall.CanQuery = true
                        wall.Transparency = 1
                        wall.CastShadow = false
                        wall.Material = Enum.Material.SmoothPlastic
                        
                        wall.CFrame = refPart.CFrame
                        wall.Size = Vector3.new(
                            math.max(refPart.Size.X, 10),
                            math.max(refPart.Size.Y, 14),
                            math.max(refPart.Size.Z, 6)
                        )
                        wall.Parent = sideroom
                    end
                end
            end)
        end

        S.protectVacuumRoom = function(roomModel)
            if not roomModel or not roomModel:IsA("Model") then return end
            if not states.antiVacuum then return end

            local sideroom = roomModel:FindFirstChild("SideroomSpace")
            if sideroom then
                neutralizeAndBlockVacuum(sideroom)
            end
        end

        local function scanAndNeutralizeAllVacuums()
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not cr then return end

            for _, room in ipairs(cr:GetChildren()) do
                local sideroom = room:FindFirstChild("SideroomSpace")
                if sideroom and not neutralizedVacuums[sideroom] then
                    neutralizeAndBlockVacuum(sideroom)
                end
            end
        end

        local function restoreAllVacuums()
            table.clear(neutralizedVacuums)
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not cr then return end

            for _, room in ipairs(cr:GetChildren()) do
                local sideroom = room:FindFirstChild("SideroomSpace")
                if sideroom then
                    local wall = sideroom:FindFirstChild("AntiVacuum_Wall")
                    if wall then wall:Destroy() end

                    local colPart = sideroom:FindFirstChild("Collision")
                    if colPart and colPart:IsA("BasePart") then
                        colPart.CanTouch = true
                        colPart.CanQuery = true
                        colPart.CanCollide = false
                    end

                    local startPart = sideroom:FindFirstChild("Start")
                    if startPart and startPart:IsA("BasePart") then
                        startPart.CanTouch = true
                        startPart.CanQuery = true
                        startPart.CanCollide = false
                    end

                    local floorPart = sideroom:FindFirstChild("Floor", true)
                    if floorPart and floorPart:IsA("BasePart") then
                        floorPart.CanTouch = true
                        floorPart.CanQuery = true
                    end
                end
            end
        end

        S.applyAntiVacuum = function(enabled)
            states.antiVacuum = enabled
            if enabled then
                scanAndNeutralizeAllVacuums()
            else
                restoreAllVacuums()
            end
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 2.0 or 1.2)
                if states.antiVacuum then scanAndNeutralizeAllVacuums() end
            end
        end)

        -- Ночная смена
        pcall(function()
            local gameData = G.Services.ReplicatedStorage:WaitForChild("GameData", 4)
            if gameData then
                local archivesDayPhase = gameData:FindFirstChild("ArchivesDayPhase")
                if archivesDayPhase then
                    local lastPhase = tostring(archivesDayPhase.Value or "")
                    S.Runtime.connections[#S.Runtime.connections + 1] = archivesDayPhase.Changed:Connect(function(val)
                        local currentPhase = tostring(val or "")
                        if states.shiftAlert and currentPhase:lower():find("night") and not lastPhase:lower():find("night") then
                            showNotification(getText("msgNightshift"), "Warning", nil, 4.0)
                        end
                        lastPhase = currentPhase
                    end)
                end
            end
        end)

        S.executeNoJammin = function()
            local deletedCount = 0
            local ss = G.Services.SoundService
            pcall(function()
                local pGui = player:FindFirstChild("PlayerGui")
                local mainUI = pGui and pGui:FindFirstChild("MainUI")
                local initiator = mainUI and mainUI:FindFirstChild("Initiator")
                local mainGame = initiator and initiator:FindFirstChild("Main_Game")
                local health = mainGame and mainGame:FindFirstChild("Health")
                if health then
                    for _, child in ipairs(health:GetChildren()) do
                        if child.Name:lower():find("jam") then
                            if child:IsA("Sound") then child:Stop() end
                            child:Destroy()
                            deletedCount = deletedCount + 1
                        end
                    end
                end
            end)
            pcall(function()
                local mainSoundGroup = ss:FindFirstChild("Main")
                if mainSoundGroup then
                    if mainSoundGroup:IsA("SoundGroup") then mainSoundGroup.Volume = 1 end
                    for _, child in ipairs(mainSoundGroup:GetChildren()) do
                        local cName = child.Name:lower()
                        if cName:find("jam") or cName:find("muffl") or cName:find("equal") or cName:find("lowpass") or cName:find("filter") or cName:find("duck") or child:IsA("EqualizerSoundEffect") or child:IsA("CompressorSoundEffect") or child:IsA("PitchShiftSoundEffect") or child:IsA("DistortionSoundEffect") or child:IsA("ReverbSoundEffect") then
                            child:Destroy()
                            deletedCount = deletedCount + 1
                        end
                    end
                end
                for _, desc in ipairs(ss:GetDescendants()) do
                    local dName = desc.Name:lower()
                    if dName:find("jam") then
                        if desc:IsA("Sound") then desc:Stop() end
                        desc:Destroy()
                        deletedCount = deletedCount + 1
                    elseif desc:IsA("SoundGroup") and desc.Volume < 1 then
                        desc.Volume = 1
                    end
                end
            end)
            if deletedCount > 0 then
                showNotification(states.language == "Russian" and ("Удален Jam & фильтры ("..deletedCount..")") or ("Deleted Jam & sound filters ("..deletedCount..")"), "Success")
            else
                showNotification(states.language == "Russian" and "Jam / фильтры не найдены" or "Jam / filters not found", "Warning")
            end
        end

        S.executeNoFog = function()
            local lgt = G.Services.Lighting
            pcall(function()
                lgt.FogEnd = 100000000
                lgt.FogStart = 0
                for _, child in ipairs(lgt:GetChildren()) do
                    if child:IsA("Atmosphere") then
                        child.Density = 0
                        child.Haze = 0
                        child.Glare = 0
                    end
                end
            end)
            showNotification(states.language == "Russian" and "Туман успешно удален!" or "Fog successfully removed!", "Success")
        end

        S.cleanA90Logic = function()
            if not states.antiA90 then return end
            player:SetAttribute("Invincibility", true)
            if player.Character then 
                player.Character:SetAttribute("Invincibility", true)
                player.Character:SetAttribute("HeldRansom", false)
            end
            player:SetAttribute("HeldRansom", false)

            local mainUI = PlayerGui:FindFirstChild("MainUI")
            if not mainUI then return end

            local jumpscare = mainUI:FindFirstChild("Jumpscare")
            if jumpscare then
                local jA90 = jumpscare:FindFirstChild("Jumpscare_A90")
                if jA90 and jA90.Visible then
                    jA90.Visible = false
                    jA90.BackgroundTransparency = 1
                end
            end

            local mainFrame = mainUI:FindFirstChild("MainFrame")
            if mainFrame then
                local hotbar = mainFrame:FindFirstChild("Hotbar")
                if hotbar then
                    for _, slot in ipairs(hotbar:GetChildren()) do
                        local heldRansom = slot:FindFirstChild("HeldRansom")
                        if heldRansom and heldRansom.Visible then heldRansom.Visible = false end
                    end
                end
            end
        end

        local a90Gui = PlayerGui or player:FindFirstChild("PlayerGui")
        if a90Gui then
            S.Runtime.connections[#S.Runtime.connections + 1] = a90Gui.DescendantAdded:Connect(function(desc)
                if not states.antiA90 then return end
                local name = desc.Name
                if name == "Jumpscare_A90" or name == "HeldRansom" or name == "RansomFrame" or name == "lvignette" then
                    pcall(function()
                        if desc:IsA("GuiObject") then desc.Visible = false end
                        S.cleanA90Logic()
                    end)
                end
            end)
        end

        S.applyPlayerEsp = function(otherPlayer)
            if not states.playerEsp or otherPlayer == player or not otherPlayer then return end
            local char = otherPlayer.Character
            local hrp = char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
            if not hrp or S.activePlayerHighlights[otherPlayer] then return end

            local espGroup = create("Folder", {Name = "PlayerEsp_" .. otherPlayer.Name, Parent = char})
            create("Highlight", {
                Adornee = char, FillColor = HIGHLIGHT_COLORS.player[1], OutlineColor = HIGHLIGHT_COLORS.player[2],
                FillTransparency = 0.5, OutlineTransparency = 0.1, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, Parent = espGroup
            })
            local bb = create("BillboardGui", {Size = G.Math.ud2(0, 160, 0, 24), AlwaysOnTop = true, Adornee = hrp, StudsOffset = G.Math.v3(0, 3.2, 0), MaxDistance = 600, Parent = espGroup})
            local nameToShow = (otherPlayer.DisplayName and otherPlayer.DisplayName ~= "") and otherPlayer.DisplayName or otherPlayer.Name
            local textLabel = create("TextLabel", {
                Name = "PlayerTag", Size = G.Math.ud2(1, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = HIGHLIGHT_COLORS.player[1],
                Font = Enum.Font.GothamBold, TextSize = 12, TextStrokeTransparency = 0.3, TextStrokeColor3 = G.Math.rgb(10, 10, 15), Text = nameToShow, Parent = bb
            })
            S.activePlayerHighlights[otherPlayer] = {group = espGroup, label = textLabel, char = char, root = hrp, rawName = nameToShow}
        end

        S.removePlayerEsp = function(otherPlayer)
            if not otherPlayer then return end
            local data = S.activePlayerHighlights[otherPlayer]
            if data then
                pcall(function()
                    if data.group and data.group.Parent then data.group:Destroy() end
                end)
                S.activePlayerHighlights[otherPlayer] = nil
            end
        end

        S.updateAllPlayerEsp = function(enabled)
            if enabled then
                for _, p in ipairs(G.Services.Players:GetPlayers()) do if p ~= player then S.applyPlayerEsp(p) end end
            else
                for p, _ in pairs(S.activePlayerHighlights) do S.removePlayerEsp(p) end
                table.clear(S.activePlayerHighlights)
            end
        end

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.Players.PlayerAdded:Connect(function(newPlayer)
            if newPlayer == player then return end
            newPlayer.CharacterAdded:Connect(function() task.wait(0.5) if states.playerEsp then S.applyPlayerEsp(newPlayer) end end)
        end)
        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.Players.PlayerRemoving:Connect(S.removePlayerEsp)

        -- Анти-Скрич
        S.getScreechModule = function()
            local pGui = player:FindFirstChild("PlayerGui")
            local mainUI = pGui and pGui:FindFirstChild("MainUI")
            local initiator = mainUI and mainUI:FindFirstChild("Initiator")
            local mainGame = initiator and initiator:FindFirstChild("Main_Game")
            local remoteListener = mainGame and mainGame:FindFirstChild("RemoteListener")
            local modules = remoteListener and remoteListener:FindFirstChild("Modules")
            return modules and modules:FindFirstChild("Screech", true), mainUI
        end

        local hookedScreechFunc = false

        S.cleanScreechLogic = function()
            if not states.screechRemover then return end
            pcall(function()
                local screechModule, mainUI = S.getScreechModule()

                if screechModule then
                    screechModule:SetAttribute("Static", true)

                    if not hookedScreechFunc and hookfunction then
                        local ok, fn = pcall(require, screechModule)
                        if ok and typeof(fn) == "function" then
                            hookedScreechFunc = true
                            hookfunction(fn, function(a1, ...)
                                if states and states.screechRemover then
                                    pcall(function()
                                        local rf = G.Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
                                        if rf and rf:FindFirstChild("Screech") then
                                            rf.Screech:FireServer(true)
                                        end
                                    end)
                                    return
                                end
                                return fn(a1, ...)
                            end)
                        end
                    end
                end

                local rs = G.Services.RunService
                for i = 1, 50 do
                    pcall(function() rs:UnbindFromRenderStep("screechStuff" .. i) end)
                end

                local cam = G.Services.Workspace.CurrentCamera or Camera
                if cam then
                    for _, obj in ipairs(cam:GetChildren()) do
                        if obj.Name:lower():find("screech") then obj:Destroy() end
                    end
                end

                local ws = G.Services.Workspace
                for _, obj in ipairs(ws:GetChildren()) do
                    if obj.Name:lower():find("screech") then obj:Destroy() end
                end

                if mainUI then
                    local jumpscare = mainUI:FindFirstChild("Jumpscare")
                    if jumpscare then
                        local jSeek = jumpscare:FindFirstChild("Jumpscare_Seek")
                        if jSeek then jSeek.Visible = false end
                        local jScreech = jumpscare:FindFirstChild("Jumpscare_Screech")
                        if jScreech then jScreech.Visible = false end
                    end
                end
            end)
        end

        S.neutralizeScreechInstance = function(sModel)
            if not states.screechRemover or not sModel then return end
            pcall(function()
                local rs = G.Services.RunService
                for i = 1, 50 do pcall(function() rs:UnbindFromRenderStep("screechStuff" .. i) end) end
                sModel:Destroy()
            end)
        end

        S.cleanGiggleLogic = function(inst)
            if states.giggleRemoveHitbox and inst and inst.Name:lower():find("giggle") then pcall(function() inst:Destroy() end) end
        end

        -- Анти-Халт
        local HALT_SOUND_NAMES = {
            Ambience_Shade = true, Shade_Music = true, ShadeMusic = true,
            Halt_Music = true, HaltMusic = true, Whisper = true,
            WhisperClose = true, WhisperWeird = true, Burst = true,
        }
        local function isHaltSoundName(name)
            if HALT_SOUND_NAMES[name] then return true end
            local n = string.lower(name)
            return string.find(n, "shade", 1, true) ~= nil
                or string.find(n, "whisper", 1, true) ~= nil
                or string.find(n, "halt", 1, true) ~= nil
        end

        local function muteHaltSoundsIn(root, shallow)
            if not root then return end
            local list = shallow and root:GetChildren() or root:GetDescendants()
            for _, s in ipairs(list) do
                if s:IsA("Sound") and isHaltSoundName(s.Name) then
                    pcall(function()
                        if s.Playing or s.Volume > 0 then s.Volume = 0; s:Stop() end
                    end)
                end
            end
        end

        S._haltDeepUntil = 0
        S._haltMusicSaved = nil

        local function muteHaltMusicBus(on)
            local main = G.Services.SoundService:FindFirstChild("Main")
            local music = main and main:FindFirstChild("Music")
            if not music then return end
            local normal, intense = music:FindFirstChild("Normal"), music:FindFirstChild("Intense")
            if on then
                if S._haltMusicSaved == nil then
                    S._haltMusicSaved = {
                        Music = music.Volume,
                        Normal = normal and normal.Volume or nil,
                        Intense = intense and intense.Volume or nil,
                    }
                end
                music.Volume = 0
                if normal then normal.Volume = 0 end
                if intense then intense.Volume = 0 end
            elseif S._haltMusicSaved then
                local sv = S._haltMusicSaved
                S._haltMusicSaved = nil
                music.Volume = sv.Music
                if normal and sv.Normal then normal.Volume = sv.Normal end
                if intense and sv.Intense then intense.Volume = sv.Intense end
            end
        end

        S.cleanHaltLogic = function()
            if not states.antiHalt then return end

            local ws = G.Services.Workspace
            local ss = G.Services.SoundService
            local lgt = G.Services.Lighting

            local mainUI = PlayerGui:FindFirstChild("MainUI")
            if mainUI then
                local mainFrame = mainUI:FindFirstChild("MainFrame") or mainUI
                for _, vName in ipairs({"HaltVignette", "ShadeVignette", "Shade_Vignette", "GlitchVignette", "HaltGlitch", "SurgeVignette", "BlueVignette", "WhiteVignette"}) do
                    local vig = mainFrame:FindFirstChild(vName, true)
                    if vig then 
                        if vig:IsA("GuiObject") then vig.Visible = false end
                        pcall(function() vig:Destroy() end)
                    end
                end
                local jumpscareFrame = mainUI:FindFirstChild("Jumpscare", true)
                if jumpscareFrame then
                    local jShade = jumpscareFrame:FindFirstChild("Jumpscare_Shade")
                    if jShade then 
                        if jShade:IsA("GuiObject") then jShade.Visible = false end
                        pcall(function() jShade:Destroy() end)
                    end
                end
            end

            local function purgeShade(container)
                if not container then return end
                for _, obj in ipairs(container:GetChildren()) do
                    local n = obj.Name
                    if n == "Shade" or n == "ShadeRushMode" or n == "Halt" or n:lower():find("shade") then
                        pcall(function()
                            for _, s in ipairs(obj:GetDescendants()) do 
                                if s:IsA("Sound") then 
                                    s.Volume = 0
                                    s:Stop() 
                                end 
                            end
                            obj:Destroy()
                        end)
                    end
                end
            end

            purgeShade(ws)
            local liveEntities = ws:FindFirstChild("LiveEntities")
            if liveEntities then
                purgeShade(liveEntities)
            end

            local now = os.clock()
            local haltPresent = ws:FindFirstChild("Shade") or ws:FindFirstChild("ShadeRushMode") or ws:FindFirstChild("Halt")
            if not haltPresent then
                for _, c in ipairs(ws:GetChildren()) do
                    if c:IsA("Sound") and isHaltSoundName(c.Name) then 
                        haltPresent = c 
                        break 
                    end
                end
            end
            if haltPresent then S._haltDeepUntil = now + 15 end
            local deep = now < S._haltDeepUntil

            pcall(function()
                muteHaltSoundsIn(ss)
                muteHaltSoundsIn(ws, true)
                muteHaltSoundsIn(ws.CurrentCamera or Camera)
                if deep then muteHaltSoundsIn(game:GetService("ReplicatedStorage")) end
                muteHaltMusicBus(deep)

                lgt.ExposureCompensation = 0
                for _, effect in ipairs(lgt:GetChildren()) do
                    if effect.Name == "Ambience_Shade" or effect.Name == "Ambience_Glitch" then 
                        effect:Destroy() 
                    end
                end

                local cam = ws.CurrentCamera or Camera
                if cam then
                    for _, obj in ipairs(cam:GetChildren()) do
                        if obj.Name == "Ambience_Shade" or obj.Name == "Ambience_Glitch" then 
                            obj:Destroy() 
                        end
                    end
                end
            end)
        end

        task.spawn(function()
            while true do
                task.wait(0.4)
                if states.antiHalt then
                    S.cleanHaltLogic()
                elseif S._haltMusicSaved then
                    muteHaltMusicBus(false)
                end
            end
        end)

        -- Анти-Дред
        S.getDreadModule = function()
            local pGui = player:FindFirstChild("PlayerGui")
            local mainUI = pGui and pGui:FindFirstChild("MainUI")
            local initiator = mainUI and mainUI:FindFirstChild("Initiator")
            local mainGame = initiator and initiator:FindFirstChild("Main_Game")
            local remoteListener = mainGame and mainGame:FindFirstChild("RemoteListener")
            local modules = remoteListener and remoteListener:FindFirstChild("Modules")
            return modules and modules:FindFirstChild("Dread", true), mainUI
        end

        S.cleanDreadLogic = function()
            if not states.antiDread then return end
            pcall(function()
                local dreadModule, mainUI = S.getDreadModule()
                if dreadModule then dreadModule:SetAttribute("Static", true) end

                local ws = G.Services.Workspace
                local cam = ws.CurrentCamera or Camera
                local dreadWasActive = (ws:FindFirstChild("Dread") ~= nil) or (cam and cam:FindFirstChild("LiveSanity") ~= nil)

                local d1, d2 = ws:FindFirstChild("Dread"), ws:FindFirstChild("DreadRushMode")
                if d1 then d1:Destroy() end; if d2 then d2:Destroy() end
                local darkAmbience = ws:FindFirstChild("Ambience_Dark")
                if darkAmbience and darkAmbience:IsA("Sound") then darkAmbience.Volume = 0; darkAmbience:Stop() end

                if cam then
                    for _, e in ipairs(cam:GetChildren()) do
                        if e.Name == "LiveSanity" or e.Name:find("Sanity") then
                            if e:IsA("PostEffect") then e.Enabled = false end
                        end
                    end
                end
                local main = G.Services.SoundService:FindFirstChild("Main")
                if main then
                    for _, e in ipairs(main:GetChildren()) do
                        if e.Name:find("Sanity") then e:Destroy() end
                    end
                end

                if dreadWasActive then
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp.Anchored then hrp.Anchored = false end
                end

                local mainFrame = mainUI and mainUI:FindFirstChild("MainFrame")
                if mainFrame then
                    local dv = mainFrame:FindFirstChild("DreadVignette")
                    if dv and dv:IsA("GuiObject") then dv.Visible = false end
                end
            end)
        end

        task.spawn(function()
            while true do
                task.wait(0.5)
                if states.antiDread then S.cleanDreadLogic() end
                if states.screechRemover then S.cleanScreechLogic() end
            end
        end)

        -- Очистка опасностей комнат
        S.cleanRoomHazardsSpecific = function(room)
            if not room or not room.Parent then return end
            pcall(function()
                for _, desc in ipairs(room:GetChildren()) do
                    local dName = desc.Name
                    if states.giggleRemoveHitbox and dName:lower():find("giggle") then 
                        desc:Destroy()
                    elseif states.antiSnare and dName == "Snare" then 
                        desc:Destroy()
                    elseif states.antiGloom and dName == "GloomPile" then 
                        desc:Destroy()
                    elseif states.noPaintRoomDoor and dName == "MovingDoor" then 
                        local rNum = tonumber(room.Name)
                        if rNum ~= 50 and rNum ~= 49 and rNum ~= 100 and rNum ~= 99 then
                            desc:Destroy()
                        end
                    elseif states.antiDupe and (dName == "SideroomDupe" or dName == "DoorFake") then
                        if dName == "DoorFake" then
                            desc:Destroy()
                        else
                            local doorFake = desc:FindFirstChild("DoorFake")
                            if doorFake then doorFake:Destroy() end
                        end
                    end
                    if states.antiVacuum then S.protectVacuumRoom(room) end
                    S.cleanDroneLogic(desc)
                    S.checkAndKillJeff(desc)
                    if states.antiAlma then S.NeutralizeAlmaModel(desc) end
                    if states.antiScribbles then S.destroyScribblesPaper(desc) end
                    
                    -- [ДОБАВЛЕНО]: Нейтрализация препятствий Сика в комнате
                    if states.antiSeekObstacles and S.neutralizeSeekObstacleInstance then
                        S.neutralizeSeekObstacleInstance(desc)
                    end
                end

                -- ВОТ ЗДЕСЬ НАХОДИТСЯ ПАПКА ASSETS:
                local assets = room:FindFirstChild("Assets")
                if assets then
                    for _, a in ipairs(assets:GetChildren()) do
                        local aName = a.Name
                        if states.giggleRemoveHitbox and aName:lower():find("giggle") then
                            a:Destroy()
                        elseif states.antiDupe and (aName == "DoorFake" or aName == "SideroomDupe") then
                            if aName == "DoorFake" then
                                a:Destroy()
                            else
                                local df = a:FindFirstChild("DoorFake")
                                if df then df:Destroy() end
                            end
                        end
                        
                        -- [ДОБАВЛЕНО]: Нейтрализация упавших люстр, огня и полок внутри Assets
                        if states.antiSeekObstacles and S.neutralizeSeekObstacleInstance then
                            S.neutralizeSeekObstacleInstance(a)
                        end
                    end
                end

                if states.antiCurrents then
                    local water = room:FindFirstChild("Water")
                    if water then
                        for _, desc in ipairs(water:GetChildren()) do
                            if desc:IsA("BasePart") then S.checkAndSecurePuddle(desc) end
                        end
                    end
                    for _, desc in ipairs(room:GetChildren()) do
                        if desc:IsA("BasePart") then S.checkAndSecurePuddle(desc) end
                    end
                end
            end)
        end

        S.cleanAllActiveRooms = function()
            local currentRooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if not currentRooms then return end
            for _, room in ipairs(currentRooms:GetChildren()) do S.cleanRoomHazardsSpecific(room) end
            if states.antiVacuum then S.applyAntiVacuum(true) end
            if states.antiCurrents then S.scanAllRoomsForPuddles() end
            if states.antiDrone then S.scanAndPurgeAllDrones() end
            if states.antiAlma then S.scanAlmaImmediate() end
            if states.antiScribbles then S.cleanExistingPapers() end
        end

        S.clearRoom100InvisibleWalls = function()
            if S.Caches.room100Cleared then return end
            pcall(function()
                local curRooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
                local r100 = curRooms and (curRooms:FindFirstChild("100") or curRooms:FindFirstChild("50"))
                if r100 then
                    S.Caches.room100Cleared = true
                    for _, desc in ipairs(r100:GetDescendants()) do
                        if desc:IsA("BasePart") then
                            local n = desc.Name:lower()
                            if n:find("windowtobreak") then
                                desc.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end

        task.spawn(function()
            while S.Runtime.running do
                if not states.autoBreakerLegit then
                    task.wait(1.5)
                else
                    task.wait(0.08)
                    local breaker = S.Caches.cachedBreaker
                    if not breaker or not breaker.Parent then
                        local curRooms = G.Services.Workspace:FindFirstChild("CurrentRooms")
                        local r100 = curRooms and (curRooms:FindFirstChild("100") or curRooms:FindFirstChild("50"))
                        if r100 then
                            breaker = r100:FindFirstChild("ElevatorBreaker", true)
                            S.Caches.cachedBreaker = breaker
                        end
                    end

                    if breaker and breaker:FindFirstChild("SurfaceGui") then
                        S.clearRoom100InvisibleWalls()

                        local surfaceGui = breaker.SurfaceGui
                        local codeLabel = surfaceGui:FindFirstChild("Code", true)
                        local frameContainer = surfaceGui:FindFirstChild("Frame", true)

                        if codeLabel and frameContainer then
                            local codeBox = frameContainer:FindFirstChild("Code")
                            local codeFrame = codeBox and codeBox:FindFirstChild("Frame")
                            local currentText = codeLabel.Text

                            if currentText ~= S.BreakerData.lastSeenCode then
                                S.BreakerData.lastSeenCode = currentText
                                if currentText ~= "..." and currentText ~= "" and currentText ~= "ELEVATOR POWER ON" then
                                    local num = tonumber(currentText)
                                    local isLit = codeFrame and (codeFrame.BackgroundTransparency < 0.5)
                                    if num then
                                        S.BreakerData.roundSeen[num] = true
                                        S.BreakerData.tracked[num] = isLit
                                        S.applySwitchState(breaker, num, isLit)
                                    elseif currentText == "??" then
                                        local missingNumber = nil
                                        for i = 1, 10 do if not S.BreakerData.roundSeen[i] then missingNumber = i break end end
                                        if missingNumber then
                                            local isMysteryLit = codeFrame and (codeFrame.BackgroundTransparency < 0.5)
                                            S.BreakerData.tracked[missingNumber] = isMysteryLit
                                            S.applySwitchState(breaker, missingNumber, isMysteryLit)
                                        end
                                    end
                                elseif currentText == "..." or currentText == "ELEVATOR POWER ON" then
                                    table.clear(S.BreakerData.roundSeen)
                                    if currentText == "ELEVATOR POWER ON" then table.clear(S.BreakerData.tracked) end
                                end
                            end
                        end
                    end
                end
            end
        end)

        local openedContainers = setmetatable({}, {__mode = "k"})
        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.ProximityPromptService.PromptTriggered:Connect(function(prompt)
            if prompt then
                local isDirectLock, isContainerLocked = false, false
                if S.getLockState then
                    isDirectLock, isContainerLocked = S.getLockState(prompt)
                end

                -- Если это замок или запертый контейнер, проверяем через 0.25с: если сервер не открыл замок, возвращаем Enabled = true!
                if isDirectLock or isContainerLocked then
                    task.delay(0.25, function()
                        if prompt and prompt.Parent and prompt:GetAttribute("_ServerEnabled") ~= false then
                            local stillDirectLock, stillLocked = S.getLockState(prompt)
                            if (stillDirectLock or stillLocked) and not prompt.Enabled and prompt:GetAttribute("InfiniteItems") == nil then
                                local gateReason = prompt:GetAttribute("_GateReason")
                                if gateReason ~= "Tool" and gateReason ~= "NoTool" then
                                    prompt.Enabled = true
                                end
                            end
                        end
                    end)
                else
                    local ot = tostring(prompt.ObjectText or ""):lower()
                    local act = tostring(prompt.ActionText or ""):lower()
                    if (ot:find("drawer") or ot:find("ящик") or ot:find("chest") or ot:find("сундук") or ot:find("desk") or ot:find("стол"))
                        and not (act:find("close") or act:find("закр")) then
                        openedContainers[prompt] = true
                        S.openedContainers[prompt] = true
                    end
                end
            end

            if not states.autoAnchor or S.AnchorData.isSolving then return end
            local anchorModel = prompt:FindFirstAncestor("MinesAnchor")
            if anchorModel then
                S.updateAnchorCache()
                local letter, targetCodeStr = S.getActiveAnchorAndTargetCode()
                if targetCodeStr then
                    local keysToPress = S.getAnchorKeysToPress(targetCodeStr, S.getAnchorAdder(anchorModel))
                    task.wait(1.0)
                    S.processSolveAnchor(anchorModel, keysToPress)
                end
            end
        end)

        S.triggerHeartbeatHit = function(side, btn)
            pcall(function()
                local vim = G.Services.VirtualInputManager
                local keyCode = (side == "left") and Enum.KeyCode.Q or Enum.KeyCode.E
                if vim then
                    vim:SendKeyEvent(true, keyCode, false, game)
                    task.wait(0.015)
                    vim:SendKeyEvent(false, keyCode, false, game)
                end
                if btn and btn.Visible then
                    local x = btn.AbsolutePosition.X + (btn.AbsoluteSize.X * 0.5)
                    local y = btn.AbsolutePosition.Y + (btn.AbsoluteSize.Y * 0.5)
                    if vim then
                        vim:SendMouseButtonEvent(x, y, 0, true, game, 1)
                        task.wait(0.015)
                        vim:SendMouseButtonEvent(x, y, 0, false, game, 1)
                    end
                end
            end)
        end

        S.handleLiveHalf = function(child)
            if not states.autoHeartbeat or not child or S.Caches.heartbeatHalves[child] or child.Name ~= "LiveHalf" then return end
            S.Caches.heartbeatHalves[child] = true
            task.spawn(function()
                task.wait(0.02)
                local heart = child.Parent
                if not heart then return end
                local hbFrame = heart:FindFirstAncestor("Heartbeat")
                local btnLeft = hbFrame and hbFrame:FindFirstChild("ButtonTapLeft")
                local btnRight = hbFrame and hbFrame:FindFirstChild("ButtonTapRight")
                local isLeft = child.AbsolutePosition.X < heart.AbsolutePosition.X
                local side = isLeft and "left" or "right"
                local targetBtn = isLeft and btnLeft or btnRight
                local frameConn

                frameConn = G.Services.RunService.RenderStepped:Connect(function()
                    if not S.Runtime.running or not states.autoHeartbeat or not child or not child.Parent or child.Name == "Jeffery" or not heart or not heart.Parent then
                        if frameConn then frameConn:Disconnect() end
                        return
                    end
                    if math.abs(child.AbsolutePosition.X - heart.AbsolutePosition.X) <= 20 then
                        if frameConn then frameConn:Disconnect() end
                        S.triggerHeartbeatHit(side, targetBtn)
                    end
                end)
            end)
        end

        local livePGui = PlayerGui or player:WaitForChild("PlayerGui", 10) or player:FindFirstChild("PlayerGui")
        if livePGui then
            S.Runtime.connections[#S.Runtime.connections + 1] = livePGui.DescendantAdded:Connect(function(desc)
                if desc.Name == "LiveHalf" then S.handleLiveHalf(desc) end
                if states.antiAlma and desc.Name == "EyeStaringGame" then S.HookAlmaMinigame(desc.Parent or desc) end
            end)

            S.Runtime.connections[#S.Runtime.connections + 1] = livePGui.ChildAdded:Connect(function(child)
                if states.antiAlma then S.CleanAlmaGui(child) end
            end)
        end

        S.checkExistingHeartbeatHalves = function()
            if not states.autoHeartbeat then return end
            pcall(function() for _, desc in ipairs(PlayerGui:GetDescendants()) do if desc.Name == "LiveHalf" then S.handleLiveHalf(desc) end end end)
        end

        task.defer(function()
            for _, desc in ipairs(G.Services.Workspace:GetDescendants()) do 
                if desc:IsA("ProximityPrompt") then 
                    S.Caches.prompts[desc] = true 
                    S.checkPromptForInf(desc)
                    if G.Services.CollectionService:HasTag(desc, "DisableWhenEnabledOnClient") then
                        pcall(function() G.Services.CollectionService:RemoveTag(desc, "DisableWhenEnabledOnClient") end)
                    end
                elseif desc:IsA("Model") and desc:GetAttribute("PromptShowDelay") and desc:GetAttribute("PromptShowDelay") > 0 then
                    pcall(function() desc:SetAttribute("PromptShowDelay", 0) end)
                end 
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.ProximityPromptService.PromptShown:Connect(function(prompt)
            if not prompt or not prompt.Parent then return end
            
            S.Caches.prompts[prompt] = true
            if states.infItems then S.checkPromptForInf(prompt) end

            pcall(function()
                if G.Services.CollectionService:HasTag(prompt, "DisableWhenEnabledOnClient") then
                    G.Services.CollectionService:RemoveTag(prompt, "DisableWhenEnabledOnClient")
                end
            end)

            -- Применяем модификаторы сразу при появлении промпта на экране
            if states.instantPrompt then S.applyInstantToPrompt(prompt) end
            if states.reachEnabled then S.applyReachToPrompt(prompt) end

            -- Для ручек ящиков и шкафов: убираем блокировку по углу камеры
            if prompt.Name == "ActivateEventPrompt" or (prompt.Parent and prompt.Parent.Name == "Knobs") then
                if prompt:GetAttribute("GateFacing") ~= 180 then
                    prompt:SetAttribute("GateFacing", 180)
                    prompt:SetAttribute("GateLOS", false)
                end
            end

            -- [МГНОВЕННЫЙ АВТО-ЛУТ ПРИ ПОЯВЛЕНИИ ПРОМПТА (0ms задержка)]
            if (states.autoLoot or states.autoInteract) and prompt.Name ~= "FPrompt" then
                task.defer(function()
                    if not prompt or not prompt.Parent then return end
                    local pInfo = S.getPromptInfo(prompt)
                    if pInfo and ((states.autoLoot and S.isAutoLootAllowed(pInfo)) or (states.autoInteract and pInfo.isInteract)) then
                        triggerPromptInstance(prompt, true)
                    end
                end)
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            if not prompt or not prompt.Parent or not prompt.Enabled then return end

            if states.instantPrompt then
                local prName = tostring(prompt.Name):lower()
                local pName = tostring(prompt.Parent and prompt.Parent.Name or ""):lower()
                local isSpecialMinigame = (
                    prName == "fusesprompt" or prName:find("breaker") 
                    or pName:find("anchor") or prName:find("anchor") 
                    or prName == "reviveprompt"
                )

                if not isSpecialMinigame then
                    prompt.HoldDuration = 0
                    task.spawn(function()
                        pcall(function()
                            if fireproximityprompt then
                                fireproximityprompt(prompt, 0, true)
                            else
                                prompt:InputHoldBegin()
                                task.wait(0.01)
                                prompt:InputHoldEnd()
                            end
                        end)
                    end)
                end
            end
        end)

        task.spawn(function()
            while S.Runtime.running do
                if not states.infItems then
                    task.wait(1.5)
                else
                    task.wait(0.2)
                    S.cleanStoredInfPrompts()
                    for _, prompt in ipairs(S.InfStoredPrompts) do
                        if prompt and prompt.Parent then S.setupInfPrompt(prompt) end
                    end
                end
            end
        end)

        -- Водяной знак
        S.wmFrame = create("Frame", {
            Name = "Watermark",
            Size = G.Math.ud2(0, 260, 0, 28),
            Position = G.Math.ud2(0.5, -130, 0, 10),
            BackgroundColor3 = HW.BG,
            BackgroundTransparency = 0.15,
            Visible = states.watermark,
            Parent = S.ScreenGui
        }, {
            cCorner(8),
            cStroke(HW.STROKE, 1.2),
            create("TextLabel", {
                Name = "StatsTxt",
                Size = G.Math.ud2(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = THEME_EMOJI .. "HUBHUBHUB  |  FPS: 60  |  Ping: 0ms",
                TextColor3 = HW.ORANGE_SOFT,
                Font = Enum.Font.GothamBold,
                TextSize = 11
            })
        })
        makeDraggable(S.wmFrame)

        S.updateWatermarkAdaptation = function()
            local cam = G.Services.Workspace.CurrentCamera or Camera
            if cam and S.wmFrame then
                S.updateCachedScreenCenter()
                local isSmall = cam.ViewportSize.X < 450
                if S.wmFrame:FindFirstChild("StatsTxt") then S.wmFrame.StatsTxt.TextSize = isSmall and 9 or 11 end
            end
        end
        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(S.updateWatermarkAdaptation)
        S.updateWatermarkAdaptation()

        S.applyZeroFriction = function(char)
            if not char then return end
            pcall(function() for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0) end end end)
        end

        -- Super FPS
        S.SuperFpsCache = {
            parts = setmetatable({}, {__mode = "k"}),
            textures = setmetatable({}, {__mode = "k"}),
            lightingEffects = setmetatable({}, {__mode = "k"})
        }

        S.optimizeInstanceForSuperFps = function(inst)
            if not inst or not inst.Parent then return end
            if inst:IsDescendantOf(player.Character) then return end
            if isMonsterDescendant(inst) then return end
            if inst:FindFirstAncestorOfClass("Tool") then return end

            local n = inst.Name:lower()
            if n:find("paper") or n:find("hint") or n:find("canvas") or n:find("painting") or n:find("sign") or n:find("padlock") or n:find("book") then
                return
            end

            if inst:IsA("BasePart") then
                if not S.SuperFpsCache.parts[inst] then
                    S.SuperFpsCache.parts[inst] = {
                        Material = inst.Material,
                        CastShadow = inst.CastShadow,
                        Reflectance = inst.Reflectance
                    }
                end
                inst.Material = Enum.Material.SmoothPlastic
                inst.CastShadow = false
                inst.Reflectance = 0

            elseif inst:IsA("Texture") or inst:IsA("Decal") then
                local pName = inst.Parent and inst.Parent.Name:lower() or ""
                if not (pName:find("paper") or pName:find("book") or pName:find("canvas") or pName:find("painting") or pName:find("sign")) then
                    if not S.SuperFpsCache.textures[inst] then
                        S.SuperFpsCache.textures[inst] = inst.Transparency
                    end
                    inst.Transparency = 1
                end
            end
        end

        S.optimizeRoomForSuperFps = function(roomModel)
            if not roomModel or not roomModel.Parent then return end
            for _, desc in ipairs(roomModel:GetDescendants()) do S.optimizeInstanceForSuperFps(desc) end
        end

        S.applySuperFps = function(enable)
            states.superFps = enable
            local lgt = G.Services.Lighting
            for _, eff in ipairs(lgt:GetChildren()) do
                if eff:IsA("DepthOfFieldEffect") or eff:IsA("SunRaysEffect") or eff:IsA("BloomEffect") then
                    if enable then
                        if S.SuperFpsCache.lightingEffects[eff] == nil then S.SuperFpsCache.lightingEffects[eff] = eff.Enabled end
                        eff.Enabled = false
                    else
                        if S.SuperFpsCache.lightingEffects[eff] ~= nil then eff.Enabled = S.SuperFpsCache.lightingEffects[eff] end
                    end
                end
            end

            if enable then
                local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
                if cr then
                    for _, room in ipairs(cr:GetChildren()) do S.optimizeRoomForSuperFps(room) end
                end
                for _, obj in ipairs(G.Services.Workspace:GetChildren()) do
                    if obj ~= cr and not obj:IsA("Terrain") and not obj:IsA("Camera") then
                        if obj:IsA("BasePart") then S.optimizeInstanceForSuperFps(obj)
                        elseif obj:IsA("Model") and not obj:FindFirstChildOfClass("Humanoid") then S.optimizeRoomForSuperFps(obj) end
                    end
                end
            else
                for part, orig in pairs(S.SuperFpsCache.parts) do
                    if part and part.Parent then
                        part.Material = orig.Material
                        part.CastShadow = orig.CastShadow
                        part.Reflectance = orig.Reflectance
                    end
                end
                for tex, origTrans in pairs(S.SuperFpsCache.textures) do
                    if tex and tex.Parent then tex.Transparency = origTrans end
                end
                table.clear(S.SuperFpsCache.parts)
                table.clear(S.SuperFpsCache.textures)
                table.clear(S.SuperFpsCache.lightingEffects)
            end
        end

        S.optimizeRoomCollisions = function(roomModel)
            if not roomModel or S.Caches.rooms[roomModel] then return end
            S.Caches.rooms[roomModel] = true
            task.defer(function()
                local container = roomModel:FindFirstChild("Assets") or roomModel
                for _, desc in ipairs(container:GetChildren()) do
                    if desc:IsA("BasePart") then
                        local name = desc.Name:lower()
                        if (name:find("paper") or name:find("trash") or name:find("leaf")) and not (name:find("carpet") or name:find("rug") or name:find("floor")) then
                            desc.CanCollide = false
                        end
                    end
                end
            end)
        end

        S.realWalkTo = function(targetPos, targetSpeed)
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp or hum.Health <= 0 then return end

            local spd = targetSpeed or states.speedValue or 24
            local diff = targetPos - hrp.Position
            local flatDiff = G.Math.v3(diff.X, 0, diff.Z)

            if (flatDiff.X * flatDiff.X + flatDiff.Z * flatDiff.Z) > 0.09 then
                local moveDir = flatDiff.Unit
                S.ForcePermanentSilentState()
                hum:Move(moveDir, false)
                local targetVelocity = G.Math.v3(moveDir.X * spd, hrp.AssemblyLinearVelocity.Y, moveDir.Z * spd)
                hrp.AssemblyLinearVelocity = targetVelocity

                local colPart = char:FindFirstChild("CollisionPart")
                if colPart then colPart.AssemblyLinearVelocity = targetVelocity end
                local colCrouch = char:FindFirstChild("Collision", true) and char.Collision:FindFirstChild("CollisionCrouch")
                if colCrouch then colCrouch.AssemblyLinearVelocity = targetVelocity end

                if moveDir.Magnitude > 0.01 then hrp.CFrame = hrp.CFrame:Lerp(G.Math.cf(hrp.Position, hrp.Position + moveDir), 0.4) end
            else
                hum:Move(G.Math.v3(), false)
                hrp.AssemblyLinearVelocity = G.Math.v3(0, hrp.AssemblyLinearVelocity.Y, 0)
                local colPart = char:FindFirstChild("CollisionPart")
                if colPart then colPart.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity end
            end
        end

        S.stopCharacter = function()
            local char = player.Character
            local hum, hrp = char and char:FindFirstChildOfClass("Humanoid"), char and char:FindFirstChild("HumanoidRootPart")
            if hum then hum:Move(G.Math.v3(), false) end
            if hrp then hrp.AssemblyLinearVelocity = G.Math.v3(0, hrp.AssemblyLinearVelocity.Y, 0) end
        end

        S.checkAEntity = function()
            local DANGER_ENTITIES = {
                "A60", "A-60", "A120", "A-120", "A160", "A-160",
                "RushMoving", "AmbushMoving", "BackdoorRush", "FrozenAmbush", 
                "BashMoving", "Bash", "BushMoving", "Bush", "ScribblesMoving", "ScribbleMoving", "Scribbles"
            }
            local ws = G.Services.Workspace
            local found = nil
            local foundName = "None"

            -- 1. Сначала мгновенный поиск в корне Workspace
            for _, name in ipairs(DANGER_ENTITIES) do
                local ent = ws:FindFirstChild(name)
                if ent then
                    found = ent
                    foundName = name
                    break
                end
            end

            -- 2. Если в корне нет, ищем только в соседних комнатах (а не во всей цепочке 1-1000)
            if not found then
                local cr = ws:FindFirstChild("CurrentRooms")
                if cr then
                    local cur = S.CachedCurrentRoom or 0
                    for r = cur - 1, cur + 3 do
                        local room = cr:FindFirstChild(tostring(r))
                        if room then
                            for _, name in ipairs(DANGER_ENTITIES) do
                                local ent = room:FindFirstChild(name)
                                if ent then
                                    found = ent
                                    foundName = name
                                    break
                                end
                            end
                        end
                        if found then break end
                    end
                end
            end

            if found then
                local pivot = getPivotPos(found)
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                return true, foundName, (pivot and hrp) and (pivot - hrp.Position).Magnitude or 0, found
            end

            return false, "None", 0, nil
        end

        S.getLockerStandPos = function(lockerModel)
            local c = getPivotCF(lockerModel)
            return c.Position + (c.LookVector * 2.8), c.Position
        end

        S.isPlayerTrulyHidden = function(lockerModel)
            local char = player.Character
            if not char then return false end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if char:GetAttribute("Hiding") == true or player:GetAttribute("Hiding") == true then return true end
            if lockerModel then
                local hiddenVal = lockerModel:FindFirstChild("HiddenPlayer")
                if hiddenVal and (hiddenVal.Value == player or hiddenVal.Value == char or tostring(hiddenVal.Value) == player.Name) then return true end
            end
            if hrp and hrp.Anchored and lockerModel then
                local center = getPivotPos(lockerModel)
                if center then
                    local dx, dy, dz = hrp.Position.X - center.X, hrp.Position.Y - center.Y, hrp.Position.Z - center.Z
                    if (dx*dx + dy*dy + dz*dz) < 16.0 then return true end
                end
            end
            return false
        end

        S.isLockerOccupiedByOtherPlayer = function(lockerModel)
            if not lockerModel then return true end
            local hiddenVal = lockerModel:FindFirstChild("HiddenPlayer")
            if hiddenVal and hiddenVal.Value ~= nil and (hiddenVal.Value ~= player and hiddenVal.Value ~= player.Character and tostring(hiddenVal.Value) ~= player.Name) then return true end
            local center = getPivotPos(lockerModel)
            if center then
                for _, oPlr in ipairs(G.Services.Players:GetPlayers()) do
                    if oPlr ~= player and oPlr.Character then
                        local oHrp = oPlr.Character:FindFirstChild("HumanoidRootPart")
                        if oHrp and oHrp.Anchored then
                            local dx, dy, dz = oHrp.Position.X - center.X, oHrp.Position.Y - center.Y, oHrp.Position.Z - center.Z
                            if (dx*dx + dy*dy + dz*dz) < 12.25 then return true end
                        end
                    end
                end
            end
            return false
        end

        S.forceExitLocker = function(locker)
            local char = player.Character
            local hrp, hum = char and char:FindFirstChild("HumanoidRootPart"), char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            local remotes = G.Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
            if remotes and remotes:FindFirstChild("GetOutOfHiding") then remotes.GetOutOfHiding:FireServer() end
            char:SetAttribute("Hiding", false)
            player:SetAttribute("Hiding", false)
            hrp.Anchored = false
            for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.Anchored = false end end
            if locker and locker.model then
                for _, part in ipairs(locker.model:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
            end

            local lockerCF = locker and locker.model and getPivotCF(locker.model) or hrp.CFrame
            local exitPos = locker and locker.standPos or (lockerCF.Position + lockerCF.LookVector * 3.5)
            local lookOutDir = lockerCF.LookVector

            hrp.CFrame = G.Math.cf(exitPos, exitPos + lookOutDir)
            hrp.AssemblyLinearVelocity = lookOutDir * 15
            task.wait(0.08)
            hum:MoveTo(exitPos + lookOutDir * 4)
            task.wait(0.12)
            S.RestoreCharacterNormalState(char)
        end

        S.computeSafePath = function(startPos, endPos)
            -- Если цель ближе 18 студов (шкаф или дверь рядом), идем напрямую без тяжелого зависания ComputeAsync
            local directDist = (startPos - endPos).Magnitude
            if directDist <= 18 then
                return { {Position = endPos, Action = Enum.PathWaypointAction.Walk} }
            end

            local path = S.Runtime.sharedPath
            local success = pcall(function() path:ComputeAsync(startPos, endPos) end)
            if success and path.Status == Enum.PathStatus.Success then
                local wps = path:GetWaypoints()
                if #wps > 0 then return wps end
            end
            return { {Position = endPos, Action = Enum.PathWaypointAction.Walk} }
        end

        S.navigatePathTo = function(targetPos, speed, isLockerTarget)
            local char = player.Character
            local hum, hrp = char and char:FindFirstChildOfClass("Humanoid"), char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp or hum.Health <= 0 then return false end
            S.applyZeroFriction(char)

            local baseSpeed = speed or states.speedValue or 24
            local waypoints = S.computeSafePath(hrp.Position, targetPos)
            local wpIndex, stuckTimer, lastPos = 1, 0, hrp.Position

            while wpIndex <= #waypoints and (states.autoRooms or states.autoHide) and S.Runtime.running do
                if not isLockerTarget and S.checkAEntity() then return false end
                local currentWpObj = waypoints[wpIndex]
                local currentWp = currentWpObj.Position
                local fdx, fdz = currentWp.X - hrp.Position.X, currentWp.Z - hrp.Position.Z
                local dist = math.sqrt(fdx*fdx + fdz*fdz)

                if (currentWpObj.Action == Enum.PathWaypointAction.Jump or (currentWp.Y - hrp.Position.Y) > 1.6) and hum.FloorMaterial ~= Enum.Material.Air then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end

                S.realWalkTo(currentWp, baseSpeed)
                G.Services.RunService.Heartbeat:Wait()

                local pdx, pdy, pdz = hrp.Position.X - lastPos.X, hrp.Position.Y - lastPos.Y, hrp.Position.Z - lastPos.Z
                if (pdx*pdx + pdy*pdy + pdz*pdz) < 0.0225 then
                    stuckTimer = stuckTimer + 0.016
                    if stuckTimer > 0.25 and stuckTimer <= 0.6 then
                        if hum.FloorMaterial ~= Enum.Material.Air then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            hrp.AssemblyLinearVelocity = G.Math.v3(hrp.AssemblyLinearVelocity.X, 20, hrp.AssemblyLinearVelocity.Z)
                        end
                    elseif stuckTimer > 0.6 then
                        local backVector = -hrp.CFrame.LookVector
                        hrp.AssemblyLinearVelocity = G.Math.v3(backVector.X * 16, 4, backVector.Z * 16)
                        task.wait(0.15)
                        S.stopCharacter()
                        waypoints = S.computeSafePath(hrp.Position, targetPos)
                        wpIndex = 1
                        stuckTimer = 0
                    end
                else
                    stuckTimer = 0
                    lastPos = hrp.Position
                end
                if dist <= ((wpIndex == #waypoints) and 1.8 or 2.2) then wpIndex = wpIndex + 1 end
            end
            return true
        end

        S.getClosestFreeLocker = function()
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return nil end
            local candidates = {}
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if cr then
                local cur = S.CachedCurrentRoom or 0
                
                local function checkLockerModel(desc)
                    if not desc or not desc:IsA("Model") then return end
                    local dNameLower = desc.Name:lower()
                    local isLocker = (dNameLower:find("hidingspot") or dNameLower == "rooms_locker" or dNameLower == "wardrobe" or dNameLower == "locker_large" or dNameLower == "largelocker" or dNameLower == "toolshed")
                    if isLocker and not dNameLower:find("small") and not dNameLower:find("broken") then
                        local prompt = desc:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt and prompt.Enabled and not S.isLockerOccupiedByOtherPlayer(desc) then
                            local standPos, centerPos = S.getLockerStandPos(desc)
                            local dx, dy, dz = standPos.X - hrp.Position.X, standPos.Y - hrp.Position.Y, standPos.Z - hrp.Position.Z
                            local distSq = dx*dx + dy*dy + dz*dz
                            -- Ограничиваем дистанцию до 130 студов, чтобы бот не пытался бежать через пол-карты
                            if distSq <= 16900 then
                                candidates[#candidates + 1] = { model = desc, prompt = prompt, standPos = standPos, centerPos = centerPos, distSq = distSq }
                            end
                        end
                    end
                end

                for r = cur - 1, cur + 2 do
                    local room = cr:FindFirstChild(tostring(r))
                    if room then
                        -- В Rooms шкафы Rooms_Locker всегда лежат внутри папки Assets
                        local assets = room:FindFirstChild("Assets")
                        if assets then
                            for _, desc in ipairs(assets:GetChildren()) do
                                checkLockerModel(desc)
                            end
                        end
                        for _, desc in ipairs(room:GetChildren()) do
                            checkLockerModel(desc)
                        end
                    end
                end
            end
            table.sort(candidates, function(a, b) return a.distSq < b.distSq end)
            return candidates[1]
        end

        S.startAutoHideRoutine = function()
            if S.Runtime.autoHideThread then task.cancel(S.Runtime.autoHideThread) end
            S.Runtime.autoHideThread = task.spawn(function()
                while states.autoHide and S.Runtime.running do
                    task.wait(0.12)
                    local char = player.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if char and hum and hrp and hum.Health > 0 then
                        local entPresent, entName, entDist, entModel = S.checkAEntity()
                        if entPresent and entModel and entModel.Parent then
                            local locker = S.getClosestFreeLocker()
                            if locker then
                                showNotification(getText("msgAutoHideWait"), "Warning")
                                S.navigatePathTo(locker.standPos, states.speedValue or 24, true)
                                local isAmbushType = (entName == "AmbushMoving" or entName == "FrozenAmbush")

                                while states.autoHide and S.Runtime.running do
                                    local dangerPresent, _, curDist = S.checkAEntity()
                                    if not dangerPresent then break end

                                    if S.isLockerOccupiedByOtherPlayer(locker.model) then
                                        local newLocker = S.getClosestFreeLocker()
                                        if newLocker and newLocker.model ~= locker.model then 
                                            locker = newLocker
                                            S.navigatePathTo(locker.standPos, states.speedValue or 24, true) 
                                        end
                                    end
                                    hrp.CFrame = G.Math.cf(hrp.Position, G.Math.v3(locker.centerPos.X, hrp.Position.Y, locker.centerPos.Z))

                                    if curDist <= 100 or curDist == 0 then
                                        showNotification(getText("msgAutoHideEnter"), "Warning")
                                        local hideStart = tick()
                                        while states.autoHide and S.checkAEntity() and not S.isPlayerTrulyHidden(locker.model) and (tick() - hideStart < 3.5) do
                                            hrp.CFrame = G.Math.cf(hrp.Position, G.Math.v3(locker.centerPos.X, hrp.Position.Y, locker.centerPos.Z))
                                            if locker.prompt and locker.prompt.Enabled then triggerPromptInstance(locker.prompt) end
                                            task.wait(0.12)
                                        end

                                        if isAmbushType then
                                            while states.autoHide and S.Runtime.running do
                                                local ambPresent, _, ambDist = S.checkAEntity()
                                                if not ambPresent then break end
                                                if ambDist > 140 then
                                                    S.forceExitLocker(locker)
                                                    showNotification(getText("msgAutoHideRebound"), "Warning")
                                                    task.wait(0.3)
                                                    while states.autoHide and S.Runtime.running do
                                                        local rebPresent, _, rebDist = S.checkAEntity()
                                                        if not rebPresent then break end
                                                        hrp.CFrame = G.Math.cf(hrp.Position, G.Math.v3(locker.centerPos.X, hrp.Position.Y, locker.centerPos.Z))
                                                        if rebDist <= 100 then
                                                            showNotification(getText("msgAutoHideEnter"), "Warning")
                                                            local reHideStart = tick()
                                                            while states.autoHide and S.checkAEntity() and not S.isPlayerTrulyHidden(locker.model) and (tick() - reHideStart < 3.0) do
                                                                if locker.prompt and locker.prompt.Enabled then triggerPromptInstance(locker.prompt) end
                                                                task.wait(0.12)
                                                            end
                                                            break
                                                        end
                                                        task.wait(0.08)
                                                    end
                                                end
                                                task.wait(0.15)
                                            end
                                        else
                                            while states.autoHide and S.checkAEntity() do task.wait(0.15) end
                                        end
                                        task.wait(1.0)
                                        if not S.checkAEntity() then 
                                            S.forceExitLocker(locker)
                                            showNotification(getText("msgAutoHideExit"), "Success") 
                                        end
                                        break
                                    else
                                        S.realWalkTo(locker.standPos, states.speedValue or 24)
                                    end
                                    task.wait(0.08)
                                end
                                S.RestoreCharacterNormalState(char)
                            else
                                task.wait(0.2)
                            end
                        end
                    end
                end
            end)
        end
        -- ====================================================================
        --                СИСТЕМА AUTO ROOMS (A-1000 RUNNER)
        -- ====================================================================
        S.Caches.doors = S.Caches.doors or setmetatable({}, {__mode = "k"})

        S.extractDoorFromRoomModel = function(roomModel)
            if not roomModel then return nil end
            if S.Caches.doors[roomModel] and S.Caches.doors[roomModel].Parent then return S.Caches.doors[roomModel] end
            if S.optimizeRoomCollisions then S.optimizeRoomCollisions(roomModel) end

            local door = roomModel:FindFirstChild("Door")
            if door then
                local part = door:FindFirstChild("Hidden") or door:FindFirstChild("Door") or door:FindFirstChild("Hinge") or door.PrimaryPart or (door:IsA("BasePart") and door)
                if part then S.Caches.doors[roomModel] = part return part end
            end
            local exit = roomModel:FindFirstChild("RoomExit", true) or roomModel:FindFirstChild("DoorExit", true)
            if exit and exit:IsA("BasePart") then S.Caches.doors[roomModel] = exit return exit end
            return nil
        end

        S.getTargetDoorStrict = function()
            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not cr or not hrp then return nil, nil, 0 end

            local currRoomNum = S.getCurrentRoomNumber() or 0
            local roomModel = cr:FindFirstChild(tostring(currRoomNum))
            local nextRoomModel = cr:FindFirstChild(tostring(currRoomNum + 1))

            if nextRoomModel then
                local currDoor = roomModel and S.extractDoorFromRoomModel(roomModel)
                local nextDoor = S.extractDoorFromRoomModel(nextRoomModel)
                if currDoor then
                    if (currDoor.Position - hrp.Position).Magnitude < 6.5 and nextDoor then return nextDoor, nextRoomModel, currRoomNum + 1 end
                    return currDoor, roomModel, currRoomNum
                elseif nextDoor then return nextDoor, nextRoomModel, currRoomNum + 1 end
            end
            if roomModel then
                local door = S.extractDoorFromRoomModel(roomModel)
                if door then return door, roomModel, currRoomNum end
            end
            local highestNum, highestRoom = -1, nil
            for _, r in ipairs(cr:GetChildren()) do
                local n = tonumber(r.Name)
                if n and n > highestNum and n >= currRoomNum then highestNum = n; highestRoom = r end
            end
            if highestRoom then
                local door = S.extractDoorFromRoomModel(highestRoom)
                if door then return door, highestRoom, highestNum end
            end
            return nil, nil, currRoomNum
        end

        S.startAutoRoomsRoutine = function()
            if S.Runtime.autoRoomsThread then task.cancel(S.Runtime.autoRoomsThread) end

            S.Runtime.autoRoomsThread = task.spawn(function()
                local lastAlertNotificationTick = 0

                while states.autoRooms and S.Runtime.running do
                    local char = player.Character
                    local hum, hrp = char and char:FindFirstChildOfClass("Humanoid"), char and char:FindFirstChild("HumanoidRootPart")
                    if not char or not hum or not hrp or hum.Health <= 0 then
                        task.wait(0.4)
                        continue
                    end
                    S.applyZeroFriction(char)

                    local entPresent, entName, entDist = S.checkAEntity()
                    if entPresent then
                        -- Если включен Anti-Rush (positionSpoof), монстр не может вас убить!
                        -- Не останавливаем бота в бесконечную панику: просто приседаем и продолжаем движение
                        if states.positionSpoof then
                            task.wait(0.12)
                            continue
                        end

                        local now = tick()
                        if (now - lastAlertNotificationTick) > 6.0 then
                            lastAlertNotificationTick = now
                            showNotification(getText("msgHiding"), "Warning", nil, 3.5)
                        end

                        local locker = S.getClosestFreeLocker()
                        if locker then
                            S.navigatePathTo(locker.standPos, states.speedValue or 24, true)
                            hrp.CFrame = G.Math.cf(hrp.Position, G.Math.v3(locker.centerPos.X, hrp.Position.Y, locker.centerPos.Z))
                            task.wait(0.04)
                            local hideStartTime = tick()
                            while states.autoRooms and S.checkAEntity() and not S.isPlayerTrulyHidden(locker.model) and (tick() - hideStartTime < 4.5) do
                                if (G.Math.v3(locker.centerPos.X, 0, locker.centerPos.Z) - G.Math.v3(hrp.Position.X, 0, hrp.Position.Z)).Magnitude > 3.0 then
                                    S.realWalkTo(locker.centerPos, 14)
                                    task.wait(0.08)
                                end
                                hrp.CFrame = G.Math.cf(hrp.Position, G.Math.v3(locker.centerPos.X, hrp.Position.Y, locker.centerPos.Z))
                                if locker.prompt and locker.prompt.Enabled then triggerPromptInstance(locker.prompt) end
                                task.wait(0.18)
                            end
                            while states.autoRooms and S.checkAEntity() do task.wait(0.15) end
                            task.wait(1.5)
                            S.forceExitLocker(locker)
                            showNotification(getText("msgUnhiding"), "Success", nil, 2.5)
                        else
                            -- КРИТИЧЕСКИЙ ФИКС: если шкафа рядом нет, обязательно уступаем поток (yield),
                            -- чтобы цикл не исполнялся 100 000 раз в секунду и не вешал игру
                            task.wait(0.25)
                        end
                        continue
                    end

                    local targetPart, targetContainer, targetRoomNum = S.getTargetDoorStrict()
                    if targetRoomNum >= 1000 then
                        showNotification(getText("msgRoomsComplete"), "Success", nil, 6.0)
                        states.autoRooms = false
                        break
                    end

                    if targetPart and targetContainer then
                        local targetPos = targetPart.Position
                        S.navigatePathTo(targetPos, states.speedValue or 24, false)
                        if (targetPart.Position - hrp.Position).Magnitude < 6.0 then
                            local passDir = targetPart.CFrame.LookVector
                            local pushSteps = 0
                            while pushSteps < 6 and states.autoRooms and not S.checkAEntity() do
                                S.realWalkTo(hrp.Position + passDir * 8, states.speedValue or 24)
                                G.Services.RunService.Heartbeat:Wait()
                                pushSteps = pushSteps + 1
                            end
                        end
                    else
                        S.realWalkTo(hrp.Position + hrp.CFrame.LookVector * 6, states.speedValue or 24)
                        G.Services.RunService.Heartbeat:Wait()
                    end
                end
                S.RestoreCharacterNormalState(player.Character)
            end)
        end
        local pendingRooms = setmetatable({}, {__mode = "k"})
        local currentRoomsFolder = G.Services.Workspace:WaitForChild("CurrentRooms", 8)
        if currentRoomsFolder then
            S.Runtime.connections[#S.Runtime.connections + 1] = currentRoomsFolder.ChildAdded:Connect(function(room)
                if states.espDoors then
                    task.defer(function()
                        if room and room.Parent then
                            local rNum = tonumber(room.Name)
                            local door = room:FindFirstChild("Door")
                            if door then
                                if rNum then objectRoomMap[door] = rNum end
                                local doorPart = door:FindFirstChild("Door") or door:FindFirstChild("Panel") or door:FindFirstChildWhichIsA("BasePart") or door
                                S.applyHighlight(doorPart, "door", "door", nil, false)
                            end
                        end
                    end)
                end

                pendingRooms[room] = true
                task.delay(0.18, function()
                    pendingRooms[room] = nil
                    if not S.Runtime.running or not room.Parent then return end
                    S.scanRoomFast(room)
                    if states.antiVacuum then S.protectVacuumRoom(room) end
                end)
            end)

            local IGNORED_DESC_NAMES = {
                Pinetree = true, Birchtree = true, Leaves = true, Bush = true,
                CatTails = true, Tails = true, PeskyWeeds = true, HidingShrub = true,
                Leaf1 = true, Leaf2 = true, Leaf3 = true, MonumentSpawn = true,
                MandrakeHole = true, CawLive = true, Garden_Lantern = true
            }

            S.Runtime.connections[#S.Runtime.connections + 1] = currentRoomsFolder.DescendantAdded:Connect(function(desc)
                if not S.Runtime.running then return end
                local dName = desc.Name
                if IGNORED_DESC_NAMES[dName] then return end

                local cName = desc.ClassName
                if states.antiSeekObstacles and cName == "Model" then
                    S.neutralizeSeekObstacleInstance(desc)
                end
                if cName ~= "Model" and cName ~= "Tool" and cName ~= "ProximityPrompt" and cName ~= "Light" then
                    if states.antiCurrents and cName == "BasePart" then
                        S.checkAndSecurePuddle(desc)
                    elseif states.antiScribbles and desc.Name == "ScribblesPaper" then
                        S.destroyScribblesPaper(desc)
                    end
                    return
                end

                if states.giggleRemoveHitbox and desc.Name:find("Giggle") then
                    desc:Destroy()
                    return
                end
                if states.antiDupe and (desc.Name == "DoorFake" or desc.Name == "SideroomDupe") then
                    if desc.Name == "DoorFake" then desc:Destroy() else local df = desc:FindFirstChild("DoorFake") if df then df:Destroy() end end
                    return
                end
                if states.antiVacuum and cName == "Model" and desc.Name == "SideroomSpace" then
                    neutralizeAndBlockVacuum(desc)
                    return
                end

                local p = desc.Parent
                local roomCandidate = (p and p.Parent == currentRoomsFolder and p) or (p and p.Parent and p.Parent.Parent == currentRoomsFolder and p.Parent)
                if roomCandidate and pendingRooms[roomCandidate] then return end

                S.checkObject(desc)
                if cName == "ProximityPrompt" then
                    S.Caches.prompts[desc] = true
                    if states.infItems then S.checkPromptForInf(desc) end
                    if states.instantPrompt then S.applyInstantToPrompt(desc) end
                    if states.reachEnabled then S.applyReachToPrompt(desc) end
                end
            end)
        end

        S.Runtime.connections[#S.Runtime.connections + 1] = player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
            task.delay(0.45, function()
                if S.Runtime.running then S.queueRoomRefresh() end
            end)
        end)

        S.setupCameraChildAdded = function()
            if S.Runtime.camChildConn and S.Runtime.camChildConn.Connected then
                S.Runtime.camChildConn:Disconnect()
            end
            local cam = G.Services.Workspace.CurrentCamera or Camera
            S.Runtime.camChildConn = cam.ChildAdded:Connect(function(child)
                if child.Name == "NoiseModel" or child.Name:find("Noise") then
                    task.defer(function()
                        S.checkObject(child)
                    end)
                end
                if not child or not child.Parent then return end
                pcall(function()
                    if states.antiAlma then S.CleanAlmaCameraFX(child) end
                    if states.screechRemover and child.Name and child.Name:lower():find("screech") then S.neutralizeScreechInstance(child) end
                    if states.antiHalt and (child.Name == "Shade" or child.Name == "Jumpscare_Shade" or child.Name == "Halt") then S.cleanHaltLogic() end
                    if states.antiDread and child.Name and child.Name:find("Dread") then S.cleanDreadLogic() end
                end)
            end)
        end
        S.setupCameraChildAdded()

        S.candidateQueue = {}
        local openedContainersHistory = setmetatable({}, {__mode = "k"})
        local promptCooldowns = setmetatable({}, {__mode = "k"})
        local lastDoorCheck = 0

        task.spawn(function()
            while S.Runtime.running do
                -- Ускоренный интервал: 0.05с на ПК и 0.08с на телефонах
                task.wait(isTouchDevice and 0.08 or 0.05)

                if (states.autoLoot or states.autoInteract) and not S.Timers.isLootWorkerBusy then
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local pGui = player:FindFirstChild("PlayerGui")
                        local mainUI = pGui and pGui:FindFirstChild("MainUI")
                        local mainFrame = mainUI and mainUI:FindFirstChild("MainFrame")
                        local isMinigameActive = false
                        if mainFrame then
                            for _, mgName in ipairs({"LockpickGame", "Lockpick", "Minigame", "EyeStaringGame"}) do
                                local mg = mainFrame:FindFirstChild(mgName, true)
                                if mg and mg:IsA("GuiObject") and mg.Visible then
                                    isMinigameActive = true
                                    break
                                end
                            end
                        end

                        if not isMinigameActive then
                            local myPos = hrp.Position
                            local now = tick()
                            table.clear(S.candidateQueue)

                            local maxReach = states.reachEnabled and (tonumber(states.reachDistance) or 15) or 12
                            local maxDistSq = maxReach * maxReach
                            local containerDistSq = math.min(maxDistSq, 132) -- ~11.5 студов для ящиков и шкафчиков

                            -- Быстрое открытие незапертых дверей
                            if states.autoInteract and (now - lastDoorCheck >= 0.25) and typeof(firetouchinterest) == "function" then
                                lastDoorCheck = now
                                local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
                                if cr then
                                    local curR = cr:FindFirstChild(tostring(S.CachedCurrentRoom)) or cr:FindFirstChild(tostring(S.CachedCurrentRoom + 1))
                                    if curR then
                                        local door = curR:FindFirstChild("Door")
                                        local lock = door and (door:FindFirstChild("Lock") or door:FindFirstChild("Padlock"))
                                        if door and not (lock and lock:FindFirstChildWhichIsA("ProximityPrompt", true)) then
                                            local doorPart = door:FindFirstChild("Door") or door:FindFirstChild("Panel") or door:FindFirstChildWhichIsA("BasePart")
                                            if doorPart then
                                                local dx, dy, dz = doorPart.Position.X - myPos.X, doorPart.Position.Y - myPos.Y, doorPart.Position.Z - myPos.Z
                                                if (dx*dx + dy*dy + dz*dz) <= maxDistSq then
                                                    firetouchinterest(hrp, doorPart, 0)
                                                    firetouchinterest(hrp, doorPart, 1)
                                                end
                                            end
                                        end
                                    end
                                end
                            end

                            for prompt in pairs(S.Caches.prompts) do
                                if prompt and prompt.Parent and prompt.Name ~= "FPrompt" and prompt:GetAttribute("_ServerEnabled") ~= false then
                                    -- Если PromptGate скрыл промпт ящика из-за угла камеры/луча/приседания, разблокируем его
                                    if not prompt.Enabled then
                                        local gateReason = prompt:GetAttribute("_GateReason")
                                        if gateReason == "Facing" or gateReason == "LOS" or gateReason == "Sector" or gateReason == "Crouch" then
                                            prompt.Enabled = true
                                        end
                                    end

                                    if prompt.Enabled then
                                        local pPos = getPromptWorldPosition(prompt)
                                        if pPos then
                                            local dx = pPos.X - myPos.X
                                            local dy = pPos.Y - myPos.Y
                                            local dz = pPos.Z - myPos.Z
                                            local distSq = dx*dx + dy*dy + dz*dz

                                            if distSq <= maxDistSq then
                                                local pInfo = S.getPromptInfo(prompt)
                                                if pInfo then
                                                    local isLootAction = states.autoLoot and S.isAutoLootAllowed(pInfo)
                                                    local isInteractAction = states.autoInteract and pInfo.isInteract

                                                    if isLootAction or isInteractAction then
                                                        local allowedDistSq = (pInfo.isDrawer or pInfo.isChest) and containerDistSq or maxDistSq
                                                        if distSq <= allowedDistSq then
                                                            local lastTime = promptCooldowns[prompt] or 0
                                                            -- Короткий кулдаун 0.22с для ящиков: если на 11 студах сервер еще не достал, через 0.22с на 8 студах он сразу откроет!
                                                            local cd = (pInfo.isChest or pInfo.isDrawer) and 0.22 or 0.08
                                                            if (now - lastTime) >= cd then
                                                                S.candidateQueue[#S.candidateQueue + 1] = {
                                                                    prompt = prompt,
                                                                    distSq = distSq,
                                                                    isLoot = isLootAction,
                                                                    isDrawer = pInfo.isDrawer,
                                                                    isChest = pInfo.isChest,
                                                                    isHidingSpotLoot = pInfo.isHidingSpotLoot
                                                                }
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if prompt and not prompt.Parent then
                                        S.Caches.prompts[prompt] = nil
                                    end
                                end
                            end

                            if #S.candidateQueue > 0 then
                                S.Timers.isLootWorkerBusy = true

                                -- Сначала собираем предметы и золото, затем открываем ящики и шкафчики
                                table.sort(S.candidateQueue, function(a, b)
                                    local aFloor = not a.isChest and not a.isDrawer
                                    local bFloor = not b.isChest and not b.isDrawer
                                    if aFloor ~= bFloor then return aFloor == true end
                                    return a.distSq < b.distSq
                                end)

                                local maxBatch = isTouchDevice and 6 or 10
                                local count = 0

                                for i = 1, #S.candidateQueue do
                                    if count >= maxBatch then break end
                                    local candidate = S.candidateQueue[i]
                                    local p = candidate.prompt

                                    if p and p.Parent then
                                        promptCooldowns[p] = now
                                        triggerPromptInstance(p, true)
                                        count = count + 1
                                    end
                                end

                                S.Timers.isLootWorkerBusy = false
                            end
                        end
                    end
                end
            end
        end)

        S.updateJumpState = function(enabled)
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if char then char:SetAttribute("CanJump", enabled) end
            player:SetAttribute("CanJump", enabled)
            
            if hum then 
                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, enabled)
                hum.UseJumpPower = true
                local targetPower = tonumber(states.jumpPowerValue) or 50
                local grav = (G.Services.Workspace.Gravity > 0) and G.Services.Workspace.Gravity or 196.2
                local calculatedHeight = (targetPower * targetPower) / (2 * grav)

                hum.JumpPower = enabled and targetPower or 0
                hum.JumpHeight = enabled and calculatedHeight or 0
            end
        end

        S.setupJumpListeners = function(char)
            if not char then return end
            local hum = char:WaitForChild("Humanoid", 4) or char:FindFirstChildOfClass("Humanoid")
            if not hum then return end

            S.Runtime.connections[#S.Runtime.connections + 1] = hum.StateChanged:Connect(function(oldState, newState)
                if states.jumpEnabled and newState == Enum.HumanoidStateType.Jumping then
                    local targetPower = tonumber(states.jumpPowerValue) or 50
                    local grav = (G.Services.Workspace.Gravity > 0) and G.Services.Workspace.Gravity or 196.2
                    local calculatedHeight = (targetPower * targetPower) / (2 * grav)

                    hum.UseJumpPower = true
                    hum.JumpPower = targetPower
                    hum.JumpHeight = calculatedHeight

                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local curVel = root.AssemblyLinearVelocity
                        root.AssemblyLinearVelocity = G.Math.v3(curVel.X, targetPower, curVel.Z)
                        task.defer(function()
                            if root and root.Parent and states.jumpEnabled then
                                local v = root.AssemblyLinearVelocity
                                root.AssemblyLinearVelocity = G.Math.v3(v.X, targetPower, v.Z)
                            end
                        end)
                    end
                end
            end)
        end

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.UserInputService.JumpRequest:Connect(function()
            if states.jumpEnabled then
                local char = player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 and hum.FloorMaterial ~= Enum.Material.Air then
                    local targetPower = tonumber(states.jumpPowerValue) or 50
                    local grav = (G.Services.Workspace.Gravity > 0) and G.Services.Workspace.Gravity or 196.2
                    local calculatedHeight = (targetPower * targetPower) / (2 * grav)

                    hum.UseJumpPower = true
                    hum.JumpPower = targetPower
                    hum.JumpHeight = calculatedHeight
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)

                    local curVel = hrp.AssemblyLinearVelocity
                    hrp.AssemblyLinearVelocity = G.Math.v3(curVel.X, targetPower, curVel.Z)
                end
            end
        end)

        -- Noclip / Phase
        S.isPhasing = false
        S.lockedYCoord = 0
        S.isMobileNoclipHeld = false
        S.mobileFlyUpHeld = false
        S.mobileFlyDownHeld = false

        local isPhaseHeld = false
        local isUpHeld = false
        local isDownHeld = false

        local cachedControls = nil
        local function getControlsModule()
            if cachedControls then return cachedControls end
            pcall(function()
                local ps = player:FindFirstChild("PlayerScripts")
                local pm = ps and ps:FindFirstChild("PlayerModule")
                if pm then cachedControls = require(pm):GetControls() end
            end)
            return cachedControls
        end

        local function formatKeyLabel(key)
            if key == "Equals" then return "= (+)"
            elseif key == "Minus" then return "- (_)"
            elseif key == "KeypadPlus" then return "Num +"
            elseif key == "KeypadMinus" then return "Num -" end
            return tostring(key)
        end

        local function notifyNoclipControls()
            if not isTouchDevice then
                local isRu = (states.language == "Russian")
                local pKey = formatKeyLabel(customKeybinds["noclipPhase"] or "V")
                local uKey = formatKeyLabel(customKeybinds["noclipUp"] or "Equals")
                local dKey = formatKeyLabel(customKeybinds["noclipDown"] or "Minus")

                local title = isRu and "УПРАВЛЕНИЕ НОУКЛИПОМ" or "NOCLIP CONTROLS"
                local desc = isRu 
                    and string.format("[%s] — Сквозь стену\n[%s] — Вверх | [%s] — Вниз", pKey, uKey, dKey)
                    or string.format("[%s] — Phase wall\n[%s] — Fly Up | [%s] — Fly Down", pKey, uKey, dKey)
                showNotification(desc, "Info", title, 5.0)
            end
        end
        S.notifyNoclipControls = notifyNoclipControls

        S.startPhasing = function()
            if S.isPhasing then return end
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                S.lockedYCoord = hrp.Position.Y
                S.isPhasing = true
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end

        S.stopPhasing = function()
            if not S.isPhasing then return end
            S.isPhasing = false

            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end

            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        if p.Name == "Collision" or p.Name == "CollisionPart" or p.Name == "HumanoidRootPart" 
                        or p.Name == "Torso" or p.Name == "UpperTorso" or p.Name == "LowerTorso" then
                            p.CanCollide = true
                        end
                    end
                end
            end
        end

        local function updatePhasingState()
            local shouldPhase = states.noclip and (
                isPhaseHeld or isUpHeld or isDownHeld 
                or S.isMobileNoclipHeld or S.mobileFlyUpHeld or S.mobileFlyDownHeld
            )
            if shouldPhase then
                if not S.isPhasing then S.startPhasing() end
            else
                if S.isPhasing then S.stopPhasing() end
            end
        end

        -- Мобильный блок ноуклипа
        S.mobileNoclipContainer = create("Frame", {
            Name = "HubMobileNoclipContainer",
            Size = G.Math.ud2(0, 54, 0, 166),
            Position = G.Math.ud2(1, -74, 1, -225),
            BackgroundTransparency = 1,
            Visible = isTouchDevice and (states.noclip == true),
            Parent = S.ScreenGui,
            ZIndex = 25
        }, {
            create("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = G.Math.ud(0, 7),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
        makeDraggable(S.mobileNoclipContainer)

        S.mobileNoclipUpBtn = create("TextButton", {
            Name = "NoclipUpBtn",
            Size = G.Math.ud2(0, 46, 0, 46),
            LayoutOrder = 1,
            BackgroundColor3 = G.Math.rgb(26, 26, 34),
            BackgroundTransparency = 0.25,
            Text = "▲",
            TextColor3 = G.Math.rgb(255, 255, 255),
            Font = Enum.Font.GothamBlack,
            TextSize = 20,
            Parent = S.mobileNoclipContainer,
            ZIndex = 26
        }, { cCorner(23), cStroke(G.Math.rgb(75, 75, 95), 1.5) })

        S.mobileNoclipButton = create("TextButton", {
            Name = "HubMobileNoclipBtn",
            Size = G.Math.ud2(0, 52, 0, 52),
            LayoutOrder = 2,
            BackgroundColor3 = G.Math.rgb(26, 26, 34),
            BackgroundTransparency = 0.25,
            Text = "👻",
            TextColor3 = G.Math.rgb(255, 255, 255),
            Font = Enum.Font.GothamBlack,
            TextSize = 24,
            Parent = S.mobileNoclipContainer,
            ZIndex = 26
        }, { cCorner(26), cStroke(G.Math.rgb(75, 75, 95), 1.5) })

        S.mobileNoclipDownBtn = create("TextButton", {
            Name = "NoclipDownBtn",
            Size = G.Math.ud2(0, 46, 0, 46),
            LayoutOrder = 3,
            BackgroundColor3 = G.Math.rgb(26, 26, 34),
            BackgroundTransparency = 0.25,
            Text = "▼",
            TextColor3 = G.Math.rgb(255, 255, 255),
            Font = Enum.Font.GothamBlack,
            TextSize = 20,
            Parent = S.mobileNoclipContainer,
            ZIndex = 26
        }, { cCorner(23), cStroke(G.Math.rgb(75, 75, 95), 1.5) })

        local function bindTouchHold(btn, onStateChange)
            btn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    onStateChange(true)
                end
            end)
            G.Services.UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    onStateChange(false)
                end
            end)
        end

        bindTouchHold(S.mobileNoclipButton, function(held)
            S.isMobileNoclipHeld = held
            G.Services.TweenService:Create(S.mobileNoclipButton, G.Math.tw(0.15), {
                BackgroundColor3 = held and G.Math.rgb(40, 150, 80) or G.Math.rgb(26, 26, 34)
            }):Play()
            updatePhasingState()
        end)

        bindTouchHold(S.mobileNoclipUpBtn, function(held)
            S.mobileFlyUpHeld = held
            G.Services.TweenService:Create(S.mobileNoclipUpBtn, G.Math.tw(0.15), {
                BackgroundColor3 = held and G.Math.rgb(40, 150, 80) or G.Math.rgb(26, 26, 34)
            }):Play()
            updatePhasingState()
        end)

        bindTouchHold(S.mobileNoclipDownBtn, function(held)
            S.mobileFlyDownHeld = held
            G.Services.TweenService:Create(S.mobileNoclipDownBtn, G.Math.tw(0.15), {
                BackgroundColor3 = held and G.Math.rgb(40, 150, 80) or G.Math.rgb(26, 26, 34)
            }):Play()
            updatePhasingState()
        end)

        S.updateNoclipVisibility = function(enabled)
            if S.mobileNoclipContainer then
                S.mobileNoclipContainer.Visible = isTouchDevice and (enabled == true)
            end
        end

        -- ПК бинды ноуклипа
        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.UserInputService.InputBegan:Connect(function(input, gp)
            if G.Services.UserInputService:GetFocusedTextBox() then return end
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

            local phaseKey = customKeybinds["noclipPhase"] or "V"
            local upKey = customKeybinds["noclipUp"] or "Equals"
            local downKey = customKeybinds["noclipDown"] or "Minus"
            local kName = input.KeyCode.Name

            if kName == phaseKey and not isTouchDevice then
                if states.noclip then
                    isPhaseHeld = true
                    updatePhasingState()
                else
                    if phaseKey == "V" then
                        states.thirdPerson = not states.thirdPerson
                        if S.UI_STORAGE["thirdPerson"] then
                            for _, ui in ipairs(S.UI_STORAGE["thirdPerson"]) do
                                if ui.update then ui.update(states.thirdPerson) end
                            end
                        end
                        showNotification(getText("thirdPerson") .. ": " .. (states.thirdPerson and "ON" or "OFF"), "Info", nil, 1.5)
                    end
                end
            end

            if not isTouchDevice and states.noclip then
                local matchesUp = (kName == upKey) or (upKey == "Equals" and (kName == "KeypadPlus" or input.KeyCode == Enum.KeyCode.Equals))
                if matchesUp then
                    isUpHeld = true
                    updatePhasingState()
                end

                local matchesDown = (kName == downKey) or (downKey == "Minus" and (kName == "KeypadMinus" or input.KeyCode == Enum.KeyCode.Minus))
                if matchesDown then
                    isDownHeld = true
                    updatePhasingState()
                end
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

            local phaseKey = customKeybinds["noclipPhase"] or "V"
            local upKey = customKeybinds["noclipUp"] or "Equals"
            local downKey = customKeybinds["noclipDown"] or "Minus"
            local kName = input.KeyCode.Name

            if not isTouchDevice then
                if kName == phaseKey then
                    isPhaseHeld = false
                    updatePhasingState()
                end
                local matchesUp = (kName == upKey) or (upKey == "Equals" and (kName == "KeypadPlus" or input.KeyCode == Enum.KeyCode.Equals))
                if matchesUp then
                    isUpHeld = false
                    updatePhasingState()
                end
                local matchesDown = (kName == downKey) or (downKey == "Minus" and (kName == "KeypadMinus" or input.KeyCode == Enum.KeyCode.Minus))
                if matchesDown then
                    isDownHeld = false
                    updatePhasingState()
                end
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.RunService.Stepped:Connect(function()
            if not S.Runtime.running or not states.noclip or not S.isPhasing then return end
            local char = player.Character
            if not char then return end

            local col = char:FindFirstChild("Collision")
            if col then col.CanCollide = false end
            local colPart = char:FindFirstChild("CollisionPart")
            if colPart then colPart.CanCollide = false end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CanCollide = false end
        end)

        local function getPhasingMovementVector(cam, hrp)
            local rawVector = Vector3.zero
            local ctrl = getControlsModule()
            if ctrl and ctrl.GetMoveVector then
                pcall(function() rawVector = ctrl:GetMoveVector() end)
            end

            local camCF = (cam and cam.CFrame) or (hrp and hrp.CFrame) or CFrame.new()
            local forward = camCF.LookVector
            local right = camCF.RightVector
            local flatForward = Vector3.new(forward.X, 0, forward.Z)
            local flatRight = Vector3.new(right.X, 0, right.Z)

            if flatForward.Magnitude > 0.001 then flatForward = flatForward.Unit else flatForward = Vector3.new(0, 0, -1) end
            if flatRight.Magnitude > 0.001 then flatRight = flatRight.Unit else flatRight = Vector3.new(1, 0, 0) end

            if rawVector.Magnitude > 0.05 then
                local wish = (flatRight * rawVector.X) + (flatForward * -rawVector.Z)
                if wish.Magnitude > 0.001 then return wish.Unit, true end
            end

            if not isTouchDevice then
                local uis = G.Services.UserInputService
                local fwd = 0
                local side = 0
                if uis:IsKeyDown(Enum.KeyCode.W) or uis:IsKeyDown(Enum.KeyCode.Up) then fwd = fwd + 1 end
                if uis:IsKeyDown(Enum.KeyCode.S) or uis:IsKeyDown(Enum.KeyCode.Down) then fwd = fwd - 1 end
                if uis:IsKeyDown(Enum.KeyCode.D) or uis:IsKeyDown(Enum.KeyCode.Right) then side = side + 1 end
                if uis:IsKeyDown(Enum.KeyCode.A) or uis:IsKeyDown(Enum.KeyCode.Left) then side = side - 1 end

                if fwd ~= 0 or side ~= 0 then
                    local wish = (flatForward * fwd) + (flatRight * side)
                    if wish.Magnitude > 0.001 then return wish.Unit, true end
                end
            end

            if isPhaseHeld or S.isMobileNoclipHeld then
                return flatForward, true
            end

            return Vector3.zero, false
        end

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.RunService.Heartbeat:Connect(function(dt)
            if not S.Runtime.running or not states.noclip or not S.isPhasing then return end

            local char = player.Character
            if not char then return end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero

            local vertSpeed = 1.3
            local horizSpeed = 1.3

            local uis = G.Services.UserInputService
            local moveY = 0

            local upKeyName = customKeybinds["noclipUp"] or "Equals"
            local downKeyName = customKeybinds["noclipDown"] or "Minus"
            local upCode = Enum.KeyCode[upKeyName]
            local downCode = Enum.KeyCode[downKeyName]

            if not isTouchDevice then
                local isUp = isUpHeld or (upCode and uis:IsKeyDown(upCode)) or (upKeyName == "Equals" and uis:IsKeyDown(Enum.KeyCode.KeypadPlus))
                local isDown = isDownHeld or (downCode and uis:IsKeyDown(downCode)) or (downKeyName == "Minus" and uis:IsKeyDown(Enum.KeyCode.KeypadMinus))
                if isUp then moveY = moveY + 1 end
                if isDown then moveY = moveY - 1 end
            else
                if S.mobileFlyUpHeld then moveY = moveY + 1 end
                if S.mobileFlyDownHeld then moveY = moveY - 1 end
            end

            if moveY ~= 0 then
                S.lockedYCoord = S.lockedYCoord + (moveY * vertSpeed * dt)
            end

            local cam = G.Services.Workspace.CurrentCamera or Camera
            local moveDir, isMoving = getPhasingMovementVector(cam, hrp)
            local currentPos = hrp.Position
            local targetY = S.lockedYCoord

            if isMoving then
                local stepOffset = moveDir * (horizSpeed * dt)
                local newPos = currentPos + stepOffset
                hrp.CFrame = G.Math.cf(
                    G.Math.v3(newPos.X, targetY, newPos.Z),
                    G.Math.v3(newPos.X + moveDir.X, targetY, newPos.Z + moveDir.Z)
                )
                hrp.AssemblyLinearVelocity = moveDir * horizSpeed
            else
                local curRot = hrp.CFrame - hrp.CFrame.Position
                hrp.CFrame = G.Math.cf(currentPos.X, targetY, currentPos.Z) * curRot
                hrp.AssemblyLinearVelocity = Vector3.zero
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = player.CharacterAdded:Connect(function(newChar)
            task.wait(0.5)
            Camera = G.Services.Workspace.CurrentCamera or Camera
            S.updateCachedScreenCenter()
            S.updateRemotes()
            S.setupCameraChildAdded()
            S.Caches.room100Cleared = false
            S.Caches.cachedBreaker = nil
            S.setupJumpListeners(newChar)

            -- Восстановление персонажа и проверка всех включенных функций
            S.SetupCharacterSpeed(newChar)
            if states.jumpEnabled and S.updateJumpState then 
                S.updateJumpState(true) 
            end
            if S.updateNoclipVisibility then 
                S.updateNoclipVisibility(states.noclip) 
            end
            if S.cleanGiggleLogic then 
                S.cleanGiggleLogic(newChar) 
            end

            if S.FunModule and S.FunModule.onCharacterAdded then 
                S.FunModule.onCharacterAdded() 
            end

            -- Вызов глобальной синхронизации для нового тела
            if S.UI_STORAGE and S.UI_STORAGE.syncAll then
                S.UI_STORAGE.syncAll()
            end
        end)
        if player.Character then 
            S.SetupCharacterSpeed(player.Character)
            S.setupJumpListeners(player.Character)
            if states.jumpEnabled then S.updateJumpState(true) end
        end
        
        task.wait()
        SetupUI(S)
    -- ====================================================================
        --                     ПОИСК И ФИЛЬТРАЦИЯ ЭЛЕМЕНТОВ
        -- ====================================================================
        S.applySearchFilter = function(query)
            query = string.lower(query or "")
            if S.SearchClearBtn then
                S.SearchClearBtn.Visible = (query ~= "")
            end

            for _, item in ipairs(S.registeredSearchElements) do
                if item.container and item.container.Parent then
                    if query == "" then
                        item.container.Visible = true
                    else
                        local match = false
                        local mainTxt = string.lower(getText(item.key) or item.key)
                        if string.find(mainTxt, query, 1, true) ~= nil then
                            match = true
                        elseif item.subKeys then
                            for _, sk in ipairs(item.subKeys) do
                                local subTxt = string.lower(getText("mOpt_" .. sk) or getText(sk) or sk)
                                if string.find(subTxt, query, 1, true) ~= nil then
                                    match = true
                                    break
                                end
                            end
                        end
                        item.container.Visible = match
                    end
                end
            end

            for _, rowData in ipairs(S.registeredRows) do
                local row = rowData.frame
                if row and row.Parent then
                    if query == "" then
                        row.Visible = (rowData.defaultVisible ~= false)
                    else
                        local hasVisible = false
                        for _, c in ipairs(row:GetChildren()) do
                            if c:IsA("GuiObject") and not c:IsA("UIListLayout") and not c:IsA("UIPadding") and c.Visible then
                                hasVisible = true
                                break
                            end
                        end
                        row.Visible = hasVisible
                    end
                end
            end
        end

        if S.SearchBox then
            S.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
                S.applySearchFilter(S.SearchBox.Text)
            end)
        end

        -- ====================================================================
        --                     КОНСТРУКТОРЫ ЭЛЕМЕНТОВ UI
        -- ====================================================================
        S.createPage = function(internalName, tabKey)
            local page = create("ScrollingFrame", {
                Name = internalName, 
                Size = G.Math.ud2(1, -20, 1, -44), 
                Position = G.Math.ud2(0, 10, 0, 42), 
                BackgroundTransparency = 1,
                ScrollBarThickness = 3, 
                Visible = false, 
                Parent = S.Content, 
                ZIndex = 6, 
                AutomaticCanvasSize = Enum.AutomaticSize.Y, 
                CanvasSize = G.Math.ud2(0, 0, 0, 0)
            }, {
                create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 6), HorizontalAlignment = Enum.HorizontalAlignment.Center}),
                create("UIPadding", {PaddingTop = G.Math.ud(0, 4), PaddingBottom = G.Math.ud(0, 18)})
            })
            S.Pages[internalName] = page

            local btn = create("TextButton", {
                Size = G.Math.ud2(0.9, 0, 0, 34), 
                BackgroundColor3 = HW.PANEL_2, 
                BackgroundTransparency = 1,
                Text = getText(tabKey), 
                TextColor3 = HW.TEXT_DIM, 
                Font = Enum.Font.GothamBold, 
                TextSize = 11,
                TextScaled = true,
                TextWrapped = true,
                ClipsDescendants = true,
                Parent = S.SidebarContent, 
                ZIndex = 7
            }, { cCorner(6), cTextConstraint(9, 12) })
            S.TabBtns[#S.TabBtns + 1] = {instance = btn, key = tabKey}

            btn.MouseEnter:Connect(function() 
                if S.currentActiveTabBtn ~= btn then 
                    G.Services.TweenService:Create(btn, G.Math.tw(0.15), {TextColor3 = HW.ORANGE_SOFT}):Play() 
                end 
            end)
            btn.MouseLeave:Connect(function() 
                if S.currentActiveTabBtn ~= btn then 
                    G.Services.TweenService:Create(btn, G.Math.tw(0.15), {TextColor3 = HW.TEXT_DIM}):Play() 
                end 
            end)
            btn.MouseButton1Click:Connect(function()
                S.currentActiveTabBtn = btn
                for _, p in pairs(S.Pages) do p.Visible = false end
                for _, b in pairs(S.TabBtns) do
                    if b.instance ~= btn then
                        G.Services.TweenService:Create(b.instance, G.Math.tw(0.2), {TextColor3 = HW.TEXT_DIM, BackgroundTransparency = 1}):Play()
                    end
                end
                page.Visible = true
                G.Services.TweenService:Create(btn, G.Math.tw(0.2), {TextColor3 = HW.ORANGE, BackgroundColor3 = HW.PANEL_2, BackgroundTransparency = 0}):Play()
            end)
            return page
        end

        S.createDivider = function(parent, text, order)
            return create("TextLabel", {
                Size = G.Math.ud2(0.98, 0, 0, 18),
                BackgroundTransparency = 1,
                Text = "— " .. string.upper(text) .. " —",
                TextColor3 = HW.ORANGE_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                LayoutOrder = order or 0,
                TextXAlignment = Enum.TextXAlignment.Center,
                Parent = parent,
                ZIndex = 7
            })
        end

        local function updateRowChildren(row, childHeight)
            if not row then return end
            local children = {}
            for _, child in ipairs(row:GetChildren()) do
                if child:IsA("GuiObject") and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
                    table.insert(children, child)
                end
            end
            local n = #children
            if n == 0 then return end
            local gap = 6
            local h = childHeight or row.Size.Y.Offset
            if h <= 0 then h = 38 end
            for _, child in ipairs(children) do
                child.Size = G.Math.ud2(1 / n, -math.floor(((n - 1) * gap) / n), 0, h)
            end
        end

        S.createRow = function(parent, height, order)
            height = height or 38
            local row = create("Frame", {
                Name = "Row",
                Size = G.Math.ud2(0.98, 0, 0, height),
                BackgroundTransparency = 1,
                LayoutOrder = order or 0,
                Parent = parent,
                ZIndex = 7
            }, {
                create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = G.Math.ud(0, 6),
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            })
            S.registeredRows[#S.registeredRows + 1] = {frame = row, defaultVisible = true, height = height}
            return row
        end

        -- ====================================================================
        -- [ФИКС №3] ЛЕГКИЙ TOGGLE (ЧИСТЫЙ ШРИФТ БЕЗ ТОРМОЗОВ СКРОЛЛА)
        -- ====================================================================
        S.createToggle = function(parent, key, cb)
            if not parent then return end
            local isInsideRow = (parent:IsA("Frame") and parent.Name ~= "Esp" and parent.Name ~= "Alerts" and parent.Name ~= "Anti" and parent.Name ~= "Misc" and parent.Name ~= "Fun" and parent.Name ~= "Event" and parent.Name ~= "Settings")
            local isOn = (states[key] == true)

            local btn = create("TextButton", {
                Name = "Toggle_" .. key,
                Size = isInsideRow and G.Math.ud2(0.48, 0, 0, 36) or G.Math.ud2(0.98, 0, 0, 36),
                BackgroundColor3 = HW.PANEL,
                AutoButtonColor = false,
                Text = "",
                ClipsDescendants = true,
                Parent = parent,
                ZIndex = 7
            }, { cCorner(8), cStroke(isOn and HW.ORANGE_DIM or HW.STROKE_DIM, 1) })

            local label = create("TextLabel", {
                Name = "BtnLabel",
                Size = G.Math.ud2(1, -52, 1, 0),
                Position = G.Math.ud2(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = getText(key),
                TextColor3 = isOn and HW.TEXT or HW.TEXT_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = btn,
                ZIndex = 8
            })

            local switchTrack = create("Frame", {
                Name = "Track",
                Size = G.Math.ud2(0, 32, 0, 16),
                Position = G.Math.ud2(1, -42, 0.5, -8),
                BackgroundColor3 = isOn and HW.ORANGE or HW.TRACK_OFF,
                Parent = btn,
                ZIndex = 8
            }, { cCorner(8) })

            local switchDot = create("Frame", {
                Name = "Dot",
                Size = G.Math.ud2(0, 12, 0, 12),
                Position = isOn and G.Math.ud2(1, -14, 0.5, -6) or G.Math.ud2(0, 2, 0.5, -6),
                BackgroundColor3 = isOn and HW.ON_DOT or HW.DOT_OFF,
                Parent = switchTrack,
                ZIndex = 9
            }, { cCorner(6) })

            local stroke = btn:FindFirstChildOfClass("UIStroke")

            local function updateVisual(state)
                switchTrack.BackgroundColor3 = state and HW.ORANGE or HW.TRACK_OFF
                switchDot.Position = state and G.Math.ud2(1, -14, 0.5, -6) or G.Math.ud2(0, 2, 0.5, -6)
                switchDot.BackgroundColor3 = state and HW.ON_DOT or HW.DOT_OFF
                label.TextColor3 = state and HW.TEXT or HW.TEXT_DIM
                if stroke then
                    stroke.Color = state and HW.ORANGE_DIM or HW.STROKE_DIM
                end
            end

            S.UI_STORAGE[key] = S.UI_STORAGE[key] or {}
            local store = S.UI_STORAGE[key]
            store[#store + 1] = {type = "toggle", track = switchTrack, dot = switchDot, label = label, translationKey = key, update = updateVisual, callback = cb}
            S.registeredSearchElements[#S.registeredSearchElements + 1] = {container = btn, key = key}

            btn.MouseButton1Click:Connect(function()
                states[key] = not states[key]
                updateVisual(states[key])
                saveAutoRestoreSession()
                if cb then cb(states[key]) end
            end)

            return btn
        end

        -- ====================================================================
        -- [ФИКС №2] ОПТИМИЗИРОВАННЫЙ СЛАЙДЕР (БЕЗ СПАМА INPUT ПРИ ДВИЖЕНИИ)
        -- ====================================================================
        S.createSlider = function(parent, min, max, default, key, step, cb)
            if not parent then return end
            step = step or 1
            local initialVal = (states[key] ~= nil) and tonumber(states[key]) or default or min
            states[key] = G.Math.clamp(initialVal, min, max)

            local cont = create("Frame", {
                Name = "Slider_" .. key,
                Size = G.Math.ud2(0.98, 0, 0, 50),
                BackgroundColor3 = HW.PANEL,
                ClipsDescendants = true,
                Parent = parent,
                ZIndex = 7
            }, { cCorner(8), cStroke(HW.STROKE_DIM, 1) })

            local lbl = create("TextLabel", {
                Name = "Title",
                Size = G.Math.ud2(1, -74, 0, 20),
                Position = G.Math.ud2(0, 10, 0, 4),
                BackgroundTransparency = 1,
                Text = getText(key),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = cont,
                ZIndex = 8
            })

            local valBox = create("TextBox", {
                Name = "ValueInput",
                Size = G.Math.ud2(0, 48, 0, 18),
                Position = G.Math.ud2(1, -58, 0, 5),
                BackgroundColor3 = HW.PANEL_2,
                Text = tostring(states[key]),
                TextColor3 = G.Math.rgb(255, 255, 255),
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                ClearTextOnFocus = false,
                Parent = cont,
                ZIndex = 8
            }, { cCorner(4) })

            local decBtn = create("TextButton", {
                Name = "DecBtn",
                Size = G.Math.ud2(0, 24, 0, 20),
                Position = G.Math.ud2(0, 8, 0, 25),
                BackgroundColor3 = HW.PANEL_2,
                Text = "—",
                TextColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                AutoButtonColor = false,
                Parent = cont,
                ZIndex = 9
            }, { cCorner(4), cStroke(HW.STROKE, 1) })

            local incBtn = create("TextButton", {
                Name = "IncBtn",
                Size = G.Math.ud2(0, 24, 0, 20),
                Position = G.Math.ud2(1, -32, 0, 25),
                BackgroundColor3 = HW.PANEL_2,
                Text = "+",
                TextColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                AutoButtonColor = false,
                Parent = cont,
                ZIndex = 9
            }, { cCorner(4), cStroke(HW.STROKE, 1) })

            local hitZone = create("TextButton", {
                Name = "SlideHitZone",
                Size = G.Math.ud2(1, -74, 0, 20),
                Position = G.Math.ud2(0, 37, 0, 25),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                Parent = cont,
                ZIndex = 9
            })

            local slideTrack = create("Frame", {
                Name = "TrackVisual",
                Size = G.Math.ud2(1, 0, 0, 6),
                Position = G.Math.ud2(0, 0, 0.5, -3),
                BackgroundColor3 = HW.BG_BOTTOM,
                BorderSizePixel = 0,
                Parent = hitZone,
                ZIndex = 8
            }, { cCorner(3) })

            local fillPct = G.Math.clamp((states[key] - min) / (max - min), 0, 1)
            local fill = create("Frame", {
                Name = "Fill",
                Size = G.Math.ud2(fillPct, 0, 1, 0),
                BackgroundColor3 = HW.ORANGE,
                Parent = slideTrack,
                ZIndex = 9
            }, { cCorner(3) })

            local function applyVal(val, updateBox)
                val = G.Math.clamp(val, min, max)
                if step > 0 then val = G.Math.floor((val / step) + 0.5) * step end
                states[key] = val
                local pct = G.Math.clamp((val - min) / (max - min), 0, 1)
                fill.Size = G.Math.ud2(pct, 0, 1, 0)
                if updateBox then valBox.Text = tostring(val) end
                saveAutoRestoreSession()
                if cb then cb(val) end
            end

            decBtn.MouseButton1Click:Connect(function()
                applyVal(states[key] - step, true)
            end)

            incBtn.MouseButton1Click:Connect(function()
                applyVal(states[key] + step, true)
            end)

            valBox.FocusLost:Connect(function()
                local num = tonumber(valBox.Text)
                if num then applyVal(num, true) else valBox.Text = tostring(states[key]) end
            end)

            -- Динамическая подписка только при взаимодействии
            local moveConn, endConn
            hitZone.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local function updateFromPos(xPos)
                        local percent = G.Math.clamp((xPos - hitZone.AbsolutePosition.X) / hitZone.AbsoluteSize.X, 0, 1)
                        applyVal(min + (max - min) * percent, true)
                    end

                    updateFromPos(input.Position.X)

                    if moveConn then moveConn:Disconnect() end
                    if endConn then endConn:Disconnect() end

                    moveConn = G.Services.UserInputService.InputChanged:Connect(function(moveInput)
                        if moveInput.UserInputType == Enum.UserInputType.MouseMovement or moveInput.UserInputType == Enum.UserInputType.Touch then
                            updateFromPos(moveInput.Position.X)
                        end
                    end)

                    endConn = G.Services.UserInputService.InputEnded:Connect(function(endInput)
                        if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
                            if moveConn then moveConn:Disconnect() moveConn = nil end
                            if endConn then endConn:Disconnect() endConn = nil end
                        end
                    end)
                end
            end)

            S.UI_STORAGE[key] = S.UI_STORAGE[key] or {}
            local store = S.UI_STORAGE[key]
            store[#store + 1] = {type = "slider", fill = fill, box = valBox, label = lbl, translationKey = key, min = min, max = max, apply = applyVal}
            S.registeredSearchElements[#S.registeredSearchElements + 1] = {container = cont, key = key}

            return cont
        end

        -- ====================================================================
        --       КНОПКА ДЕЙСТВИЯ (ACTION BUTTON)
        -- ====================================================================
        S.createActionButton = function(parent, key, cb)
            if not parent then return end
            local isInsideRow = (parent:IsA("Frame") and parent.Name ~= "Esp" and parent.Name ~= "Alerts" and parent.Name ~= "Anti" and parent.Name ~= "Misc" and parent.Name ~= "Fun" and parent.Name ~= "Event" and parent.Name ~= "Settings")
            
            local label = create("TextLabel", {
                Name = "BtnLabel",
                Size = G.Math.ud2(1, -14, 1, -4),
                Position = G.Math.ud2(0, 7, 0, 2),
                BackgroundTransparency = 1,
                Text = getText(key),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextScaled = true,
                TextWrapped = true,
                ZIndex = 8
            }, { cTextConstraint(8, 11) })

            local btn = create("TextButton", {
                Name = "Action_" .. key,
                Size = isInsideRow and G.Math.ud2(0.48, 0, 0, 38) or G.Math.ud2(0.98, 0, 0, 38),
                Text = "",
                BackgroundColor3 = HW.PANEL_2,
                AutoButtonColor = false,
                ClipsDescendants = true,
                Parent = parent,
                ZIndex = 7
            }, { cCorner(8), cStroke(HW.STROKE_DIM, 1), label })

            S.localizedLabels[#S.localizedLabels + 1] = {instance = label, key = key}
            S.registeredSearchElements[#S.registeredSearchElements + 1] = {container = btn, key = key}

            btn.MouseButton1Click:Connect(function()
                G.Services.TweenService:Create(btn, G.Math.tw(0.08), {BackgroundColor3 = G.Math.rgb(65, 65, 80)}):Play()
                task.delay(0.12, function()
                    G.Services.TweenService:Create(btn, G.Math.tw(0.15), {BackgroundColor3 = G.Math.rgb(28, 28, 36)}):Play()
                end)
                if cb then cb() end
            end)

            return btn
        end

        -- ====================================================================
        --     ВЫПАДАЮЩЕЕ МЕНЮ С БЕЙДЖЕМ И КНОПКАМИ "ВСЕ / СБРОС"
        -- ====================================================================
        S.createDropdown = function(parent, key, items, cb)
            states[key] = states[key] or {}
            local isOpen = false
            local itemRecords = {}
            local subKeysList = {}

            local cont = create("Frame", {
                Name = "Dropdown_" .. key,
                Size = G.Math.ud2(0.98, 0, 0, 42),
                BackgroundColor3 = HW.PANEL,
                ClipsDescendants = true,
                Parent = parent,
                ZIndex = 7
            }, {
                cCorner(8),
                cStroke(HW.STROKE_DIM, 1)
            })

            local headerBtn = create("TextButton", {
                Name = "Header",
                Size = G.Math.ud2(1, 0, 0, 42),
                Position = G.Math.ud2(0, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                ClipsDescendants = true,
                Parent = cont,
                ZIndex = 8
            })

            local titleLabel = create("TextLabel", {
                Name = "Title",
                Size = G.Math.ud2(1, -95, 1, -4),
                Position = G.Math.ud2(0, 12, 0, 2),
                BackgroundTransparency = 1,
                Text = getText(key),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextScaled = true,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                Parent = headerBtn,
                ZIndex = 9
            }, { cTextConstraint(9, 11) })

            local countBadge = create("TextLabel", {
                Name = "CountBadge",
                Size = G.Math.ud2(0, 42, 0, 18),
                Position = G.Math.ud2(1, -66, 0.5, -9),
                BackgroundColor3 = HW.PANEL_2,
                Text = "0/0",
                TextColor3 = HW.ORANGE_SOFT,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                Parent = headerBtn,
                ZIndex = 9
            }, { cCorner(4), cStroke(HW.STROKE, 1) })

            local arrowIcon = create("TextLabel", {
                Name = "Arrow",
                Size = G.Math.ud2(0, 18, 0, 18),
                Position = G.Math.ud2(1, -22, 0.5, -9),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                Parent = headerBtn,
                ZIndex = 9
            })

            local quickBar = create("Frame", {
                Name = "QuickActionBar",
                Size = G.Math.ud2(1, -16, 0, 24),
                Position = G.Math.ud2(0, 8, 0, 42),
                BackgroundTransparency = 1,
                Parent = cont,
                ZIndex = 8
            })

            local btnAll = create("TextButton", {
                Name = "SelectAllBtn",
                Size = G.Math.ud2(0.48, 0, 1, 0),
                Position = G.Math.ud2(0, 0, 0, 0),
                BackgroundColor3 = HW.PANEL_2,
                Text = getText("dropSelectAll"),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                AutoButtonColor = false,
                Parent = quickBar,
                ZIndex = 9
            }, { cCorner(4), cStroke(HW.STROKE, 1) })

            local btnClear = create("TextButton", {
                Name = "ClearAllBtn",
                Size = G.Math.ud2(0.48, 0, 1, 0),
                Position = G.Math.ud2(0.52, 0, 0, 0),
                BackgroundColor3 = HW.PANEL_2,
                Text = getText("dropClearAll"),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                AutoButtonColor = false,
                Parent = quickBar,
                ZIndex = 9
            }, { cCorner(4), cStroke(HW.STROKE, 1) })

            local scrollArea = create("ScrollingFrame", {
                Name = "ItemsScroll",
                Size = G.Math.ud2(1, -16, 0, 124),
                Position = G.Math.ud2(0, 8, 0, 70),
                BackgroundTransparency = 1,
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = G.Math.rgb(75, 75, 90),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = G.Math.ud2(0, 0, 0, 0),
                Parent = cont,
                ZIndex = 8
            }, {
                create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 4)}),
                create("UIPadding", {PaddingTop = G.Math.ud(0, 2), PaddingBottom = G.Math.ud(0, 6)})
            })

            local function updateCounterBadge()
                local activeCount = 0
                for _, item in ipairs(items) do
                    local optKey = (type(item) == "table" and item.key) or item
                    if states[key][optKey] == true then
                        activeCount = activeCount + 1
                    end
                end
                countBadge.Text = string.format("%d/%d", activeCount, #items)
            end

            for _, item in ipairs(items) do
                local optKey = (type(item) == "table" and item.key) or item
                subKeysList[#subKeysList + 1] = optKey

                if states[key][optKey] == nil then
                    local defVal = (type(item) == "table" and item.default) or false
                    states[key][optKey] = defVal
                end

                local isSelected = (states[key][optKey] == true)

                local itemBtn = create("TextButton", {
                    Name = "Item_" .. optKey,
                    Size = G.Math.ud2(1, -4, 0, 32),
                    BackgroundColor3 = isSelected and HW.TINT or HW.PANEL,
                    AutoButtonColor = false,
                    Text = "",
                    ClipsDescendants = true,
                    Parent = scrollArea,
                    ZIndex = 9
                }, {
                    cCorner(6),
                    cStroke(isSelected and HW.ORANGE_DIM or HW.STROKE_DIM, 1)
                })

                local itemLabel = create("TextLabel", {
                    Name = "ItemLabel",
                    Size = G.Math.ud2(1, -42, 1, -4),
                    Position = G.Math.ud2(0, 10, 0, 2),
                    BackgroundTransparency = 1,
                    Text = getText("mOpt_" .. optKey) or getText(optKey),
                    TextColor3 = isSelected and HW.ORANGE_SOFT or HW.TEXT_DIM,
                    Font = Enum.Font.GothamBold,
                    TextSize = 11,
                    TextScaled = true,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    Parent = itemBtn,
                    ZIndex = 10
                }, { cTextConstraint(8, 11) })

                local checkFrame = create("Frame", {
                    Name = "Checkbox",
                    Size = G.Math.ud2(0, 18, 0, 18),
                    Position = G.Math.ud2(1, -26, 0.5, -9),
                    BackgroundColor3 = isSelected and HW.ORANGE or G.Math.rgb(38, 30, 46),
                    Parent = itemBtn,
                    ZIndex = 10
                }, {
                    cCorner(4),
                    cStroke(isSelected and HW.ORANGE_DIM or G.Math.rgb(58, 46, 70), 1),
                    create("ImageLabel", {
                        Name = "Tick",
                        Size = G.Math.ud2(1, -4, 1, -4),
                        Position = G.Math.ud2(0, 2, 0, 2),
                        BackgroundTransparency = 1,
                        Image = "rbxassetid://3926305904",
                        ImageRectOffset = Vector2.new(312, 4),
                        ImageRectSize = Vector2.new(24, 24),
                        ImageColor3 = HW.ON_DOT,
                        ImageTransparency = isSelected and 0 or 1,
                        ZIndex = 11
                    })
                })

                local itemStroke = itemBtn:FindFirstChildOfClass("UIStroke")
                local tickIcon = checkFrame:FindFirstChild("Tick")

                local function updateItemVisual(val)
                    G.Services.TweenService:Create(itemBtn, G.Math.tw(0.15), {
                        BackgroundColor3 = val and HW.TINT or HW.PANEL
                    }):Play()
                    if itemStroke then
                        G.Services.TweenService:Create(itemStroke, G.Math.tw(0.15), {
                            Color = val and HW.ORANGE_DIM or HW.STROKE_DIM
                        }):Play()
                    end
                    G.Services.TweenService:Create(itemLabel, G.Math.tw(0.15), {
                        TextColor3 = val and HW.ORANGE_SOFT or HW.TEXT_DIM
                    }):Play()
                    G.Services.TweenService:Create(checkFrame, G.Math.tw(0.15), {
                        BackgroundColor3 = val and HW.ORANGE or G.Math.rgb(38, 30, 46)
                    }):Play()
                    if tickIcon then
                        G.Services.TweenService:Create(tickIcon, G.Math.tw(0.15), {
                            ImageTransparency = val and 0 or 1
                        }):Play()
                    end
                end

                itemBtn.MouseEnter:Connect(function()
                    if not states[key][optKey] then
                        G.Services.TweenService:Create(itemBtn, G.Math.tw(0.12), {BackgroundColor3 = G.Math.rgb(26, 26, 34)}):Play()
                    end
                end)
                itemBtn.MouseLeave:Connect(function()
                    if not states[key][optKey] then
                        G.Services.TweenService:Create(itemBtn, G.Math.tw(0.12), {BackgroundColor3 = G.Math.rgb(20, 20, 26)}):Play()
                    end
                end)

                itemBtn.MouseButton1Click:Connect(function()
                    states[key][optKey] = not states[key][optKey]
                    updateItemVisual(states[key][optKey])
                    updateCounterBadge()
                    saveAutoRestoreSession()
                    if cb then cb(states[key], optKey, states[key][optKey]) end
                end)

                table.insert(itemRecords, {key = optKey, label = itemLabel, update = updateItemVisual})
            end

            updateCounterBadge()

            btnAll.MouseButton1Click:Connect(function()
                for _, item in ipairs(itemRecords) do
                    states[key][item.key] = true
                    item.update(true)
                end
                updateCounterBadge()
                saveAutoRestoreSession()
                if cb then cb(states[key], "__ALL__", true) end
            end)

            btnClear.MouseButton1Click:Connect(function()
                for _, item in ipairs(itemRecords) do
                    states[key][item.key] = false
                    item.update(false)
                end
                updateCounterBadge()
                saveAutoRestoreSession()
                if cb then cb(states[key], "__NONE__", false) end
            end)

            local function toggleDropdown(forceState)
                if forceState ~= nil then isOpen = forceState else isOpen = not isOpen end
                local visibleCount = math.clamp(#items, 1, 4)
                local targetScrollHeight = (visibleCount * 36) + 8
                local targetContHeight = isOpen and (42 + 28 + targetScrollHeight + 8) or 42

                G.Services.TweenService:Create(cont, G.Math.tw(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = G.Math.ud2(0.98, 0, 0, targetContHeight)
                }):Play()

                G.Services.TweenService:Create(scrollArea, G.Math.tw(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = G.Math.ud2(1, -16, 0, targetScrollHeight)
                }):Play()

                G.Services.TweenService:Create(arrowIcon, G.Math.tw(0.2, Enum.EasingStyle.Quad), {
                    Rotation = isOpen and 180 or 0,
                    TextColor3 = isOpen and G.Math.rgb(255, 255, 255) or G.Math.rgb(150, 150, 165)
                }):Play()
            end

            headerBtn.MouseButton1Click:Connect(function() toggleDropdown() end)

            S.UI_STORAGE[key] = S.UI_STORAGE[key] or {}
            table.insert(S.UI_STORAGE[key], {
                type = "dropdown",
                titleLabel = titleLabel,
                items = itemRecords,
                btnAll = btnAll,
                btnClear = btnClear,
                updateBadge = updateCounterBadge
            })
            S.registeredSearchElements[#S.registeredSearchElements + 1] = {container = cont, key = key, subKeys = subKeysList}

            return cont
        end

        -- ====================================================================
        --                     НАПОЛНЕНИЕ СТРАНИЦ
        -- ====================================================================
        local function BuildEspPage(parent)
            S.createDivider(parent, "GENERAL")
            do local r = S.createRow(parent); S.createToggle(r, "espDoors", S.espToggle); S.createToggle(r, "espDupe", S.espToggle) end
            do local r = S.createRow(parent); S.createToggle(r, "itemsEsp", S.espToggle); S.createToggle(r, "playerEsp", function(on) S.updateAllPlayerEsp(on) end) end
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "espNames", function(on)
                    for _, data in pairs(S.activeHighlights) do
                        if data.billboard then data.billboard.Enabled = on end
                        if data.label then data.label.Visible = on end
                    end
                    for _, pData in pairs(S.activePlayerHighlights) do
                        if pData.label then pData.label.Visible = on end
                    end
                    if S.HonchoData and S.HonchoData.activeBillboards then
                        for _, bb in pairs(S.HonchoData.activeBillboards) do
                            if bb then bb.Enabled = on end
                        end
                    end
                end)
                S.createToggle(r, "distanceEsp", function()
                    for _, data in pairs(S.activeHighlights) do
                        data.lastDist = -999
                        if not states.distanceEsp and data.label then
                            data.label.Text = data.cachedName
                        end
                    end
                end)
            end
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "tracerEsp", function(on) if not on and S.clearAllTracers then S.clearAllTracers() end end)
                S.createToggle(r, "gpsPath", function(on) S.toggleGPSPath(on) end) 
            end
            do local r = S.createRow(parent); S.createToggle(r, "keyHighlight", S.espToggle); S.createToggle(r, "monsterEsp", S.espToggle) end
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "tvStandEsp", S.espToggle)
                S.createToggle(r, "scrapperEsp", S.espToggle) 
            end
            
            S.createDropdown(parent, "monsterFilter", {
                {key = "rush", default = true}, {key = "ambush", default = true}, {key = "blitz", default = true},
                {key = "frozenambush", default = true}, {key = "figure", default = true}, {key = "seek", default = true},
                {key = "a60", default = true},
                {key = "a120", default = true},
                {key = "a160", default = true},
                {key = "noise", default = true},
                {key = "grumble", default = true}, {key = "eyes", default = true}, {key = "lookman", default = true},
                {key = "halt", default = true}, {key = "screech", default = true}, {key = "giggle", default = true},
                {key = "dread", default = true}, {key = "groundskeeper", default = true}, {key = "bash", default = true},
                {key = "bush", default = true}, {key = "scribbles", default = true}, {key = "teller", default = true},
                {key = "jeff", default = true}, {key = "creak", default = true},
                {key = "bramble", default = true}, {key = "mandrake", default = true},
                {key = "monument", default = true}, {key = "louie", default = true}
            }, function(stateTable, updatedKey, isChecked)
                if updatedKey == "__ALL__" then
                    showNotification(states.language == "Russian" and "Все монстры включены в фильтр" or "All monsters enabled in filter", "Success")
                elseif updatedKey == "__NONE__" then
                    showNotification(states.language == "Russian" and "Фильтр монстров очищен" or "Monster filter cleared", "Warning")
                end
                S.refreshEsp()
                S.scanRooms()
            end)

            do 
                local r = S.createRow(parent)
                S.createToggle(r, "fireAlarmEsp", S.espToggle)
                S.createToggle(r, "cartEsp", S.espToggle) 
            end

            S.createDivider(parent, "HOTEL & MINES")
            do local r = S.createRow(parent); S.createToggle(r, "chestHighlight", S.espToggle); S.createToggle(r, "leverHighlight", S.espToggle) end
            do local r = S.createRow(parent); S.createToggle(r, "wardrobeEsp", S.espToggle); S.createToggle(r, "liveHintBookEsp", S.espToggle) end
            do local r = S.createRow(parent); S.createToggle(r, "fuseEsp", S.espToggle); S.createToggle(r, "anchorEsp", S.espToggle) end
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "liveBreakerEsp", S.espToggle)
                S.createToggle(r, "pumpEsp", function(on)
                    if on then
                        if S.clearRoomCaches then S.clearRoomCaches() end
                        S.scanRooms()
                    else
                        S.refreshEsp()
                    end
                end)
            end
            do
                local r = S.createRow(parent)
                S.createToggle(r, "generatorEsp", S.espToggle)
                S.createToggle(r, "presentsEsp", S.espToggle)
            end

            S.createDivider(parent, "OUTDOORS & ARCHIVES")
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "honchoBoxEsp", function(on)
                    if on then
                        if S.updateHonchoScan then S.updateHonchoScan() end
                    else
                        if S.clearAllHonchoESP then S.clearAllHonchoESP() end
                    end
                end)
                S.createToggle(r, "outdoorsLeverEsp", S.espToggle)
            end
            S.createToggle(parent, "timerLeverEsp", S.espToggle)
        end

        local function BuildAlertsPage(parent)
            S.createDivider(parent, "HOTEL & MINES")
            do local r = S.createRow(parent); S.createToggle(r, "rushAlert"); S.createToggle(r, "ambushAlert") end
            do local r = S.createRow(parent); S.createToggle(r, "blitzAlert"); S.createToggle(r, "surgeAlert") end
            do local r = S.createRow(parent); S.createToggle(r, "frozenAmbushAlert") end
            S.createDivider(parent, "ROOMS")
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "a60Alert")
                S.createToggle(r, "a120Alert")
            end
            S.createDivider(parent, "ARCHIVES")
            do local r = S.createRow(parent); S.createToggle(r, "shiftAlert"); S.createToggle(r, "bashAlert") end
            do local r = S.createRow(parent); S.createToggle(r, "scribblesAlert") end
        end

        local function BuildAntiPage(parent)
            S.createDivider(parent, "BYPASS & SPECIAL")
            do
                local r = S.createRow(parent)
                S.createToggle(r, "positionSpoof", function(on) S.updatePositionSpoof(on) end)
                S.createToggle(r, "antiSurgeDamage", function(on) S.swapRemoteState("SurgeRemote", on) end)
            end

            S.createDivider(parent, "ARCHIVES & STAIRWELL")
            do
                local r = S.createRow(parent)
                S.createToggle(r, "antiScribbles", function(on) if on then S.cleanExistingPapers() end end)
                S.createToggle(r, "autoTellerTicket")
            end
            do
                local r = S.createRow(parent)
                S.createToggle(r, "antiNoise")
                S.createActionButton(r, "btnSlamTV", function()
                    if S.executeInstantTVSlam then S.executeInstantTVSlam() end
                end)
            end
            do
                local r = S.createRow(parent)
                S.createToggle(r, "antiAlma", function(on) if on then S.scanAlmaImmediate() end end)
            end

            S.createToggle(parent, "antiDrone", function(on) if on then S.scanAndPurgeAllDrones() end end)
            S.createToggle(parent, "antiCurrents", function(on) S.setPuddleImmunity(on) end)
            do
                local r = S.createRow(parent)
                S.createToggle(r, "creakBypass")
                S.createToggle(r, "antiMonument")
            end

            S.createDivider(parent, "GLOBAL & HAZARDS")
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "antiDread", function(on) if on then S.cleanDreadLogic() end end)
                S.createToggle(r, "antiEyes", function(on) updateScreechOnAttribute() end)
            end
            do local r = S.createRow(parent); S.createToggle(r, "antiLookman") end
            do local r = S.createRow(parent); S.createToggle(r, "antiDupe", function(on) if on then S.cleanAllActiveRooms() end end); S.createToggle(r, "antiSnare", function(on) if on then S.cleanAllActiveRooms() end end) end
            do local r = S.createRow(parent); S.createToggle(r, "antiGloom", function(on) if on then S.cleanAllActiveRooms() end end); S.createToggle(r, "screechRemover", function(on) if on then S.cleanScreechLogic() end end) end
            do local r = S.createRow(parent); S.createToggle(r, "antiHalt", function(on) if on then S.cleanHaltLogic() end end); S.createToggle(r, "giggleRemoveHitbox", function(on) if on then S.cleanAllActiveRooms() end end) end
            do local r = S.createRow(parent); S.createToggle(r, "antiA90", function(on) if on then S.cleanA90Logic() end end); S.createToggle(r, "antiVacuum", function(on) S.applyAntiVacuum(on) end) end
            S.createToggle(parent, "antiJeff")
            S.createToggle(parent, "antiJeff")
            do
                local r = S.createRow(parent)
                S.createToggle(r, "antiSeekObstacles", function(on)
                    if on then
                        S.scanAndNeutralizeSeekObstacles()
                    end
                end)
                S.createToggle(r, "bridgePatch", function(on)
                    if S.toggleBridgePatch then S.toggleBridgePatch(on) end
                end)
            end
            S.createToggle(parent, "antiSeekFlood", function(on)
                if S.toggleAntiSeekFlood then S.toggleAntiSeekFlood(on) end
            end)
        end

        local function BuildMiscPage(parent)
            S.createDivider(parent, "MOVEMENT & SPEED")
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "speedEnabled", function(on) if on then S.ForcePermanentSilentState() else S.RestoreCharacterNormalState(player.Character) end end)
                S.createToggle(r, "jumpEnabled", function(on) S.updateJumpState(on) end) 
            end
            S.createToggle(parent, "noclip", function(on)
                if S.updateNoclipVisibility then S.updateNoclipVisibility(on) end
                if on then
                    if S.notifyNoclipControls then S.notifyNoclipControls() end
                else
                    if S.stopPhasing then S.stopPhasing() end
                end
            end)
            S.createSlider(parent, 20, 100, 50, "speedValue", 1, function(val)
                if val <= 40 then S.Runtime.hasShownSpeedWarning = false
                elseif states.autoHide and val > 40 and not S.Runtime.hasShownSpeedWarning then
                    S.Runtime.hasShownSpeedWarning = true
                    showNotification(getText("msgSpeedWarning"), "Warning")
                end
            end)
            S.createSlider(parent, 30, 120, 50, "jumpPowerValue", 1, function(val)
                states.jumpPowerValue = val
                local char = player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and states.jumpEnabled then 
                    local grav = (G.Services.Workspace.Gravity > 0) and G.Services.Workspace.Gravity or 196.2
                    local calculatedHeight = (val * val) / (2 * grav)

                    hum.UseJumpPower = true
                    hum.JumpPower = val 
                    hum.JumpHeight = calculatedHeight
                end
            end)

            S.createDivider(parent, "CAMERA & VIEW")
            do
                local r = S.createRow(parent)
                S.createToggle(r, "thirdPerson", function(on) toggleThirdPersonMode(on) end)
            end
            S.createSlider(parent, 3, 20, 7.5, "thirdPersonDistance", 0.5)
            S.createSlider(parent, 70, 120, 70, "fovValue", 1)
            do
                local r = S.createRow(parent)
                S.createToggle(r, "noCamEffects", function(on) S.applyNoCamEffects(on) end)
                S.createToggle(r, "noCamShake")
            end

            S.createDivider(parent, "MODIFIERS")
            do local r = S.createRow(parent); S.createActionButton(r, "btnNoFog", S.executeNoFog); S.createActionButton(r, "btnNoJammin", S.executeNoJammin) end

            S.createDivider(parent, "PUZZLES & SOLVERS")
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "autoBreakerLegit")
                S.createToggle(r, "autoPadlock", function(on)
                    if on then showNotification(getText("msgPadlockPaper"), "Warning", nil, 4.5) end
                end)
            end 
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "autoAnchor", function(on) if on then S.updateAnchorCache() end end)
                S.createToggle(r, "autoHeartbeat", function(on) if on then S.checkExistingHeartbeatHalves() end end) 
            end

            S.createDivider(parent, "AUTO PLAY & INTERACTION")
            S.createToggle(parent, "reachEnabled", function(on) S.updateAllPromptsReach(on) end)
            S.createSlider(parent, 1, 20, 15, "reachDistance", 1, function(val)
                states.reachDistance = val
                if states.reachEnabled then S.updateAllPromptsReach(true) end
            end)
            S.createToggle(parent, "infItems", function(on) S.updateAllInfPrompts(on) end)
            S.createToggle(parent, "autoHide", function(on) if on then S.startAutoHideRoutine() else if S.Runtime.autoHideThread then task.cancel(S.Runtime.autoHideThread) end S.RestoreCharacterNormalState(player.Character) end end)
            S.createToggle(parent, "instantPrompt", function(on) S.updateAllPromptsInstant(on) end)
            do local r = S.createRow(parent); S.createToggle(r, "autoLoot"); S.createToggle(r, "autoInteract") end
            S.createDropdown(parent, "autoLootFilter", {
                {key = "gold", default = true},
                {key = "essential", default = true},
                {key = "normal", default = true},
                {key = "containers", default = true}
            })
            S.createToggle(parent, "autoRooms", function(on)
                if on then 
                    if states.speedValue > 40 and not S.Runtime.hasShownSpeedWarning then 
                        S.Runtime.hasShownSpeedWarning = true
                        showNotification(getText("msgSpeedWarning"), "Warning") 
                    end
                    S.startAutoRoomsRoutine()
                else
                    S.Runtime.hasShownSpeedWarning = false
                    if S.Runtime.autoRoomsThread then task.cancel(S.Runtime.autoRoomsThread) end
                    S.RestoreCharacterNormalState(player.Character)
                end
            end)
            S.createDivider(parent, getText("sectionStats") or "STATS & TIMERS")
            do 
                local r = S.createRow(parent)
                S.createToggle(r, "statOxygen", function() S.updateStatsHUDVisibility() end)
                S.createToggle(r, "statBackdoorTimer", function() S.updateStatsHUDVisibility() end)
            end
            S.createToggle(parent, "statHonchoTimer", function() S.updateStatsHUDVisibility() end)
            S.createDivider(parent, "RENDER & OPTIMIZATION")
            do local r = S.createRow(parent)
                S.createToggle(r, "fullbright", function(on) S.applyFullbrightProperties(not on) end)
                S.createToggle(r, "watermark", function(on) S.wmFrame.Visible = on end)
            end
            S.createSlider(parent, 1, 10, 2, "fullbrightBrightness", 1, function() if states.fullbright then S.applyFullbrightProperties() end end)
            do local r = S.createRow(parent); S.createToggle(r, "antiLag", S.espToggle); S.createToggle(r, "superFps", function(on) S.applySuperFps(on) end) end
        end

        S.UI_STORAGE.syncAll = function()
            -- Сброс и сканирование комнат
            if S.clearRoomCaches then S.clearRoomCaches() end
            if S.refreshEsp then S.refreshEsp() end
            S.scanRooms()

            -- Визуал и освещение
            if states.fullbright then 
                S.applyFullbrightProperties(false) 
            else 
                S.applyFullbrightProperties(true) 
            end
            if S.applySuperFps then S.applySuperFps(states.superFps == true) end
            if S.wmFrame then S.wmFrame.Visible = (states.watermark == true) end
            if toggleThirdPersonMode then toggleThirdPersonMode(states.thirdPerson == true) end
            if S.applyNoCamEffects then S.applyNoCamEffects(states.noCamEffects == true) end

            -- Физика и персонаж
            if S.updatePositionSpoof then S.updatePositionSpoof(states.positionSpoof == true) end
            if updateScreechOnAttribute then updateScreechOnAttribute() end
            if S.toggleAntiSeekFlood then S.toggleAntiSeekFlood(states.antiSeekFlood == true) end
            if states.speedEnabled then 
                S.ForcePermanentSilentState() 
            else 
                if S.RestoreCharacterNormalState then S.RestoreCharacterNormalState(player.Character) end 
            end
            if S.updateJumpState then S.updateJumpState(states.jumpEnabled == true) end
            if S.updateNoclipVisibility then S.updateNoclipVisibility(states.noclip == true) end
            if not states.noclip and S.stopPhasing then S.stopPhasing() end

            -- Взаимодействие
            if S.updateAllPromptsInstant then S.updateAllPromptsInstant(states.instantPrompt == true) end
            if S.updateAllPromptsReach then S.updateAllPromptsReach(states.reachEnabled == true) end
            if S.updateAllInfPrompts then S.updateAllInfPrompts(states.infItems == true) end

            -- Автоматизация
            if states.autoHide then
                if S.startAutoHideRoutine then S.startAutoHideRoutine() end
            else
                if S.Runtime.autoHideThread then task.cancel(S.Runtime.autoHideThread); S.Runtime.autoHideThread = nil end
                if S.RestoreCharacterNormalState then S.RestoreCharacterNormalState(player.Character) end
            end

            if states.autoRooms then
                if S.startAutoRoomsRoutine then S.startAutoRoomsRoutine() end
            else
                if S.Runtime.autoRoomsThread then task.cancel(S.Runtime.autoRoomsThread); S.Runtime.autoRoomsThread = nil end
                if S.RestoreCharacterNormalState then S.RestoreCharacterNormalState(player.Character) end
            end

            -- Защита и обходы
            if S.toggleBridgePatch then S.toggleBridgePatch(states.bridgePatch == true) end
            if S.toggleGPSPath then S.toggleGPSPath(states.gpsPath == true) end
            if S.applyAntiVacuum then S.applyAntiVacuum(states.antiVacuum == true) end
            if S.swapRemoteState then S.swapRemoteState("SurgeRemote", states.antiSurgeDamage == true) end
            if S.setPuddleImmunity then S.setPuddleImmunity(states.antiCurrents == true) end
            if states.antiDrone and S.scanAndPurgeAllDrones then S.scanAndPurgeAllDrones() end
            if states.antiAlma and S.scanAlmaImmediate then S.scanAlmaImmediate() end
            if states.antiScribbles and S.cleanExistingPapers then S.cleanExistingPapers() end
            if states.antiSeekObstacles and S.scanAndNeutralizeSeekObstacles then S.scanAndNeutralizeSeekObstacles() end
            if states.antiDread and S.cleanDreadLogic then S.cleanDreadLogic() end
            if states.screechRemover and S.cleanScreechLogic then S.cleanScreechLogic() end
            if states.antiHalt and S.cleanHaltLogic then S.cleanHaltLogic() end

            -- HUD и ESP
            if S.updateStatsHUDVisibility then S.updateStatsHUDVisibility() end
            if S.updateAllPlayerEsp then S.updateAllPlayerEsp(states.playerEsp == true) end
            if states.honchoBoxEsp then
                if S.updateHonchoScan then S.updateHonchoScan() end
            else
                if S.clearAllHonchoESP then S.clearAllHonchoESP() end
            end
            if not states.tracerEsp and S.clearAllTracers then S.clearAllTracers() end

            -- FOV камеры
            local cam = G.Services.Workspace.CurrentCamera or Camera
            if cam then
                cam.FieldOfView = (states.fovValue and states.fovValue > 0) and states.fovValue or 70
            end

            -- Синхронизация внешнего модуля FUN
            if S.FunModule and S.FunModule.syncAll then 
                S.FunModule.syncAll() 
            end

            if S.keybindBtn and S.keybindBtn.Parent then
                S.keybindBtn.Text = getText("menuKeyBtn") .. "[" .. tostring(states.menuKey) .. "]"
            end

            saveAutoRestoreSession()
        end
        -- ====================================================================
        --                     МЕНЕДЖЕР НАСТРОЕК (SETTINGS)
        -- ====================================================================
        S.UI_STORAGE.buildSettings = function(parent)
            S.createDivider(parent, "LANGUAGE & MENU BIND")

            local Cfg = {
                folder = KEY_CONFIG.FOLDER .. "/Profiles",
                buttons = {},
                isListening = false,
                isKeybindListening = false
            }

            -- [ИСПРАВЛЕНО]: Корректное пошаговое создание папок
            if makefolder and isfolder then
                pcall(function()
                    if not isfolder(KEY_CONFIG.FOLDER) then makefolder(KEY_CONFIG.FOLDER) end
                    if not isfolder(Cfg.folder) then makefolder(Cfg.folder) end
                end)
            end

            local langBtn = create("TextButton", {
                Size = G.Math.ud2(0.98, 0, 0, 36),
                BackgroundColor3 = HW.PANEL_2,
                Text = getText("langBtn"),
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                Parent = parent,
                ZIndex = 7
            }, {cCorner(8), cStroke(HW.STROKE, 1)})

            -- ------------------------------------------------------------------
            --   ПЕРЕКЛЮЧАТЕЛЬ ТЕМЫ: кнопка всегда оформлена в ПРОТИВОПОЛОЖНОМ
            --   стиле (вкл. хэллоуин -> кнопка обычная, и наоборот)
            -- ------------------------------------------------------------------
            S.createDivider(parent, getText("themeSection"))

            local themeBtn = create("TextButton", {
                Name = "ThemeSwitchBtn",
                Size = G.Math.ud2(0.98, 0, 0, 34),
                BackgroundColor3 = G.Math.rgb(24, 24, 30),
                Text = "",
                TextColor3 = G.Math.rgb(235, 235, 245),
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                Parent = parent,
                ZIndex = 7
            }, {cCorner(8), cStroke(G.Math.rgb(70, 70, 85), 1)})

            local themeBtnStroke = themeBtn:FindFirstChildOfClass("UIStroke")

            S.styleThemeButton = function(instant)
                local isHW = (states.theme == "halloween")
                local bg, txt, st, label
                if isHW then
                    -- включён хэллоуин: показываем обычный (монохромный) стиль
                    bg, txt, st = G.Math.rgb(24, 24, 30), G.Math.rgb(235, 235, 245), G.Math.rgb(70, 70, 85)
                    label = getText("themeToNormal")
                else
                    -- включён обычный стиль: показываем хэллоуинский
                    bg, txt, st = G.Math.rgb(33, 25, 41), G.Math.rgb(255, 178, 96), G.Math.rgb(150, 88, 34)
                    label = getText("themeToHalloween")
                end
                themeBtn.Text = tostring(label)
                if instant then
                    themeBtn.BackgroundColor3 = bg
                    themeBtn.TextColor3 = txt
                    if themeBtnStroke then themeBtnStroke.Color = st end
                else
                    G.Services.TweenService:Create(themeBtn, G.Math.tw(0.35), {BackgroundColor3 = bg, TextColor3 = txt}):Play()
                    if themeBtnStroke then
                        G.Services.TweenService:Create(themeBtnStroke, G.Math.tw(0.35), {Color = st}):Play()
                    end
                end
            end
            S.styleThemeButton(true)

            themeBtn.MouseButton1Click:Connect(function()
                if S.setTheme then
                    S.setTheme((states.theme == "halloween") and "normal" or "halloween")
                    saveAutoRestoreSession()
                end
            end)

            local changelogBtn = create("TextButton", {
                Size = G.Math.ud2(0.98, 0, 0, 34),
                BackgroundColor3 = HW.PANEL,
                Text = getText("btnViewChangelog"),
                TextColor3 = HW.ORANGE_SOFT,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                Parent = parent,
                ZIndex = 7
            }, {cCorner(8), cStroke(HW.STROKE, 1)})

            changelogBtn.MouseButton1Click:Connect(function()
                if S.ShowChangelogModal then
                    S.ShowChangelogModal()
                end
            end)

            S.keybindBtn = create("TextButton", {
                Size = G.Math.ud2(0.98, 0, 0, 36),
                BackgroundColor3 = HW.PANEL,
                Text = getText("menuKeyBtn") .. "[" .. tostring(states.menuKey) .. "]",
                TextColor3 = HW.TEXT,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                Parent = parent,
                ZIndex = 7
            }, {cCorner(8), cStroke(HW.STROKE, 1)})

            S.keybindBtn.MouseButton1Click:Connect(function()
                if Cfg.isListening then return end
                Cfg.isListening = true
                S.keybindBtn.Text = getText("pressAnyKey")
                S.keybindBtn.TextColor3 = HW.ORANGE

                local bindConn
                bindConn = G.Services.UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode and input.KeyCode ~= Enum.KeyCode.Unknown then
                        states.menuKey = input.KeyCode.Name
                        S.keybindBtn.Text = getText("menuKeyBtn") .. "[" .. tostring(states.menuKey) .. "]"
                        S.keybindBtn.TextColor3 = HW.TEXT
                        Cfg.isListening = false
                        saveAutoRestoreSession()
                        bindConn:Disconnect()
                    end
                end)
            end)

            S.createDivider(parent, "FREE KEYBINDS MANAGER")

            local allAvailableFeatures = {
                {"positionSpoof", "Anti Rush-like (Spoof)"},
                {"autoRooms", "Auto Rooms (A-1000)"},
                {"a60Alert", "A-60 Alert"},
                {"a120Alert", "A-120 Alert"},
                {"thirdPerson", "Third Person View"},
                {"antiSeekFlood", "Anti Seek Flood (Dam 200)"},
                {"statOxygen", "Oxygen Level HUD"},
                {"gpsPath", "GPS Guide Path"},
                {"bridgePatch", "Bridge Patcher"},
                {"statBackdoorTimer", "Backdoor Timer HUD"},
                {"statHonchoTimer", "Honcho Door Timer HUD"},
                {"antiMonument", "Anti Monument (Freeze)"},
                {"speedEnabled", "Speedhack"},
                {"jumpEnabled", "Jump Power"},
                {"noclip", "NoClip (Toggle)"},
                {"noclipPhase", "NoClip Phase (Hold)"},
                {"noclipUp", "NoClip Fly (Up)"},
                {"noclipDown", "NoClip Fly (Down)"},
                {"autoPadlock", "Auto Padlock (Room 50)"},
                {"autoHide", "Auto Hide"},
                {"fullbright", "Fullbright"},
                {"autoLoot", "Auto Loot"},
                {"autoInteract", "Auto Interact"},
                {"instantPrompt", "Instant Prompt"},
                {"reachEnabled", "Extended Reach"},
                {"antiEyes", "Anti Eyes"},
                {"antiLookman", "Anti Lookman"},
                {"antiDread", "Anti Dread"},
                {"antiHalt", "Anti Halt"},
                {"antiA90", "Anti Ransom"},
                {"antiScribbles", "Anti Scribbles"},
                {"antiNoise", "Anti Noise"},
                {"autoTellerTicket", "Auto Teller Ticket"},
                {"espDoors", "Door ESP"},
                {"itemsEsp", "Items ESP"},
                {"monsterEsp", "Monster ESP"},
                {"louieEsp", "Louie ESP"},
                {"honchoBoxEsp", "Honcho Storage & Deposit ESP"},
                {"playerEsp", "Player ESP"},
                {"tracerEsp", "Tracers ESP"},
                {"watermark", "Watermark"},
                {"chairManipulation", "Chair Manipulation"},
                {"resizerActive", "Universal Resizer"}
            }

            local keybindSearchBox = create("TextBox", {
                Size = G.Math.ud2(0.98, 0, 0, 30),
                BackgroundColor3 = HW.PANEL,
                PlaceholderText = "Search feature to bind...",
                Text = "",
                TextColor3 = HW.TEXT,
                PlaceholderColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                Parent = parent,
                ZIndex = 7
            }, {cCorner(6), cStroke(HW.STROKE, 1)})

            local keybindListContainer = create("Frame", {
                Size = G.Math.ud2(0.98, 0, 0, 120),
                BackgroundColor3 = HW.BG,
                Parent = parent,
                ZIndex = 7
            }, {
                cCorner(8),
                cStroke(HW.STROKE, 1)
            })

            local keybindScroll = create("ScrollingFrame", {
                Size = G.Math.ud2(1, -8, 1, -8),
                Position = G.Math.ud2(0, 4, 0, 4),
                BackgroundTransparency = 1,
                CanvasSize = G.Math.ud2(0, 0, 0, 0),
                ScrollBarThickness = 3,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Parent = keybindListContainer,
                ZIndex = 8
            }, {
                create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 4)})
            })

            local function populateKeybindRows(filter)
                filter = string.lower(filter or "")
                for _, obj in ipairs(keybindScroll:GetChildren()) do
                    if obj:IsA("Frame") then obj:Destroy() end
                end

                for _, item in ipairs(allAvailableFeatures) do
                    local featKey, featName = item[1], item[2]
                    local translatedName = getText(featKey) or featName
                    if filter == "" or string.find(string.lower(translatedName), filter) or string.find(string.lower(featName), filter) then
                        local kRow = create("Frame", {
                            Size = G.Math.ud2(1, 0, 0, 28),
                            BackgroundColor3 = G.Math.rgb(25, 25, 32),
                            Parent = keybindScroll,
                            ZIndex = 9
                        }, {cCorner(6)})

                        create("TextLabel", {
                            Size = G.Math.ud2(0.65, -8, 1, 0),
                            Position = G.Math.ud2(0, 8, 0, 0),
                            BackgroundTransparency = 1,
                            Text = translatedName,
                            TextColor3 = G.Math.rgb(220, 220, 235),
                            Font = Enum.Font.GothamBold,
                            TextSize = 10,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = kRow,
                            ZIndex = 10
                        })

                        local curBind = customKeybinds[featKey] or "None"
                        local bBtn = create("TextButton", {
                            Size = G.Math.ud2(0.32, -4, 0, 22),
                            Position = G.Math.ud2(0.68, 0, 0.5, -11),
                            BackgroundColor3 = (curBind ~= "None") and G.Math.rgb(45, 45, 58) or G.Math.rgb(30, 30, 38),
                            Text = "[" .. curBind .. "]",
                            TextColor3 = (curBind ~= "None") and G.Math.rgb(255, 255, 255) or G.Math.rgb(140, 140, 150),
                            Font = Enum.Font.GothamBold,
                            TextSize = 10,
                            Parent = kRow,
                            ZIndex = 10
                        }, {cCorner(4)})

                        bBtn.MouseButton1Click:Connect(function()
                            if Cfg.isKeybindListening then return end
                            Cfg.isKeybindListening = true
                            bBtn.Text = getText("pressAnyKey")
                            bBtn.TextColor3 = G.Math.rgb(255, 255, 100)

                            local conn
                            conn = G.Services.UserInputService.InputBegan:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode and input.KeyCode ~= Enum.KeyCode.Unknown then
                                    local kName = input.KeyCode.Name
                                    if kName == "Escape" or kName == "Backspace" then
                                        customKeybinds[featKey] = nil
                                        bBtn.Text = "[None]"
                                        bBtn.TextColor3 = G.Math.rgb(140, 140, 150)
                                        bBtn.BackgroundColor3 = G.Math.rgb(30, 30, 38)
                                    else
                                        customKeybinds[featKey] = kName
                                        bBtn.Text = "[" .. kName .. "]"
                                        bBtn.TextColor3 = G.Math.rgb(255, 255, 255)
                                        bBtn.BackgroundColor3 = G.Math.rgb(45, 45, 58)
                                    end
                                    saveCustomKeybinds()
                                    Cfg.isKeybindListening = false
                                    conn:Disconnect()
                                end
                            end)
                        end)
                    end
                end
            end

            populateKeybindRows("")
            keybindSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
                populateKeybindRows(keybindSearchBox.Text)
            end)

            S.createDivider(parent, "ESP COLOR PICKER (RGB WHEEL)")

            local selectedCategory = "door"
            local currentHue = 0.55
            local currentSat = 0.8
            local currentVal = 1.0

            local colorPickerFrame = create("Frame", {
                Name = "ColorPickerMainFrame",
                Size = G.Math.ud2(0.98, 0, 0, 175),
                BackgroundColor3 = HW.BG,
                Parent = parent,
                ZIndex = 7
            }, {
                cCorner(8),
                cStroke(HW.STROKE, 1)
            })

            local catScroll = create("ScrollingFrame", {
                Name = "CategoryScroll",
                Size = G.Math.ud2(0, 130, 1, -12),
                Position = G.Math.ud2(0, 6, 0, 6),
                BackgroundTransparency = 1,
                CanvasSize = G.Math.ud2(0, 0, 0, 0),
                ScrollBarThickness = 2,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Parent = colorPickerFrame,
                ZIndex = 8
            }, {
                create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 3)})
            })

            local espCategories = {
                {"door", "Doors"},
                {"key", "Keys"},
                {"chest", "Chests"},
                {"item", "Items"},
                {"monster", "Monsters"},
                {"wardrobe", "Wardrobes"},
                {"player", "Players"}
            }

            local catButtons = {}
            local previewBox, valSliderFill, wheelIndicator

            local function updateColorForCurrentCategory(h, s, v)
                currentHue = h or currentHue
                currentSat = s or currentSat
                currentVal = v or currentVal

                local mainC = Color3.fromHSV(currentHue, currentSat, currentVal)
                local darkC = Color3.fromHSV(currentHue, currentSat, math.max(0, currentVal * 0.65))

                HIGHLIGHT_COLORS[selectedCategory] = {mainC, darkC}
                if previewBox then previewBox.BackgroundColor3 = mainC end
                saveCustomColors()
                S.refreshEsp()
            end

            for _, cData in ipairs(espCategories) do
                local cKey, cName = cData[1], cData[2]
                local isSel = (cKey == selectedCategory)
                local btn = create("TextButton", {
                    Name = "CatBtn_" .. cKey,
                    Size = G.Math.ud2(1, 0, 0, 22),
                    BackgroundColor3 = isSel and HW.TINT or HW.PANEL,
                    Text = " " .. cName,
                    TextColor3 = isSel and HW.ORANGE_SOFT or HW.TEXT_DIM,
                    Font = Enum.Font.GothamBold,
                    TextSize = 9,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = catScroll,
                    ZIndex = 9
                }, {cCorner(4)})
                catButtons[cKey] = btn

                btn.MouseButton1Click:Connect(function()
                    selectedCategory = cKey
                    for k, b in pairs(catButtons) do
                        local sel = (k == selectedCategory)
                        b.BackgroundColor3 = sel and HW.TINT or HW.PANEL
                        b.TextColor3 = sel and HW.ORANGE_SOFT or HW.TEXT_DIM
                    end
                    local curCol = (HIGHLIGHT_COLORS[selectedCategory] and HIGHLIGHT_COLORS[selectedCategory][1]) or G.Math.rgb(255, 255, 255)
                    local h, s, v = Color3.toHSV(curCol)
                    currentHue, currentSat, currentVal = h, s, v
                    if previewBox then previewBox.BackgroundColor3 = curCol end
                    if valSliderFill then valSliderFill.Size = G.Math.ud2(1, 0, currentVal, 0) end
                end)
            end

            local rightWheelContainer = create("Frame", {
                Name = "RightWheelContainer",
                Size = G.Math.ud2(1, -144, 1, -12),
                Position = G.Math.ud2(0, 140, 0, 6),
                BackgroundTransparency = 1,
                Parent = colorPickerFrame,
                ZIndex = 8
            })

            local wheelImage = create("ImageButton", {
                Name = "WheelButton",
                Size = G.Math.ud2(0, 95, 0, 95),
                Position = G.Math.ud2(0, 0, 0, 0),
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                Parent = rightWheelContainer,
                ZIndex = 9
            })

            create("ImageLabel", {
                Name = "WheelTexture",
                Size = G.Math.ud2(1, 0, 1, 0),
                Position = G.Math.ud2(0, 0, 0, 0),
                BackgroundTransparency = 1,
                Image = "rbxassetid://7017517837",
                Rotation = 180,
                Parent = wheelImage,
                ZIndex = 10
            }, {
                create("UICorner", {CornerRadius = G.Math.ud(1, 0)})
            })

            wheelIndicator = create("Frame", {
                Name = "WheelIndicator",
                Size = G.Math.ud2(0, 10, 0, 10),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = G.Math.ud2(0.5, 0, 0.5, 0),
                BackgroundColor3 = G.Math.rgb(255, 255, 255),
                Parent = wheelImage,
                ZIndex = 12
            }, {cCorner(5), cStroke(G.Math.rgb(0, 0, 0), 1.5)})

            local valSliderTrack = create("TextButton", {
                Name = "BrightnessTrack",
                Size = G.Math.ud2(0, 12, 0, 95),
                Position = G.Math.ud2(0, 102, 0, 0),
                BackgroundColor3 = G.Math.rgb(12, 12, 16),
                AutoButtonColor = false,
                Text = "",
                Parent = rightWheelContainer,
                ZIndex = 9
            }, {cCorner(6), cStroke(G.Math.rgb(55, 55, 65), 1)})

            valSliderFill = create("Frame", {
                Name = "BrightnessFill",
                Size = G.Math.ud2(1, 0, 1, 0),
                Position = G.Math.ud2(0, 0, 0, 0),
                BackgroundColor3 = G.Math.rgb(240, 240, 250),
                Parent = valSliderTrack,
                ZIndex = 10
            }, {cCorner(6)})

            previewBox = create("Frame", {
                Name = "ColorPreview",
                Size = G.Math.ud2(0, 28, 0, 28),
                Position = G.Math.ud2(0, 122, 0, 0),
                BackgroundColor3 = (HIGHLIGHT_COLORS[selectedCategory] and HIGHLIGHT_COLORS[selectedCategory][1]) or G.Math.rgb(150, 200, 255),
                Parent = rightWheelContainer,
                ZIndex = 9
            }, {cCorner(6), cStroke(G.Math.rgb(70, 70, 85), 1.5)})

            local quickPresetsHolder = create("Frame", {
                Name = "QuickPresets",
                Size = G.Math.ud2(1, 0, 0, 24),
                Position = G.Math.ud2(0, 0, 0, 102),
                BackgroundTransparency = 1,
                Parent = rightWheelContainer,
                ZIndex = 9
            }, {
                create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = G.Math.ud(0, 5), VerticalAlignment = Enum.VerticalAlignment.Center})
            })

            local quickColors = {
                G.Math.rgb(255, 40, 40), G.Math.rgb(40, 255, 80), G.Math.rgb(50, 150, 255), G.Math.rgb(255, 220, 30),
                G.Math.rgb(255, 120, 0), G.Math.rgb(210, 40, 255), G.Math.rgb(0, 255, 255), G.Math.rgb(255, 255, 255)
            }

            for _, qc in ipairs(quickColors) do
                local qb = create("TextButton", {
                    Size = G.Math.ud2(0, 16, 0, 16),
                    BackgroundColor3 = qc,
                    Text = "",
                    AutoButtonColor = false,
                    Parent = quickPresetsHolder,
                    ZIndex = 10
                }, {cCorner(8), cStroke(G.Math.rgb(40, 40, 50), 1)})

                qb.MouseButton1Click:Connect(function()
                    local h, s, v = Color3.toHSV(qc)
                    currentHue, currentSat, currentVal = h, s, v
                    if valSliderFill then valSliderFill.Size = G.Math.ud2(1, 0, currentVal, 0) end
                    updateColorForCurrentCategory(h, s, v)
                end)
            end

            local wheelDragging = false
            local function processWheelInput(inputPos)
                local center = wheelImage.AbsolutePosition + (wheelImage.AbsoluteSize * 0.5)
                local offset = Vector2.new(inputPos.X - center.X, inputPos.Y - center.Y)
                local radius = wheelImage.AbsoluteSize.X * 0.5
                local dist = offset.Magnitude

                local sat = G.Math.clamp(dist / radius, 0, 1)
                local angle = (G.Math.atan2(offset.Y, offset.X) - G.Math.rad(90)) % (2 * G.Math.pi)
                local hue = angle / (2 * G.Math.pi)

                local indX = G.Math.clamp(0.5 + (offset.X / wheelImage.AbsoluteSize.X), 0.05, 0.95)
                local indY = G.Math.clamp(0.5 + (offset.Y / wheelImage.AbsoluteSize.Y), 0.05, 0.95)
                wheelIndicator.Position = G.Math.ud2(indX, 0, indY, 0)

                updateColorForCurrentCategory(hue, sat, currentVal)
            end

            wheelImage.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    wheelDragging = true
                    processWheelInput(inp.Position)
                end
            end)

            local valDragging = false
            valSliderTrack.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    valDragging = true
                    local pct = G.Math.clamp((inp.Position.Y - valSliderTrack.AbsolutePosition.Y) / valSliderTrack.AbsoluteSize.Y, 0, 1)
                    currentVal = 1 - pct
                    valSliderFill.Size = G.Math.ud2(1, 0, currentVal, 0)
                    updateColorForCurrentCategory(currentHue, currentSat, currentVal)
                end
            end)

            G.Services.UserInputService.InputChanged:Connect(function(inp)
                if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                    if wheelDragging then
                        processWheelInput(inp.Position)
                    elseif valDragging then
                        local pct = G.Math.clamp((inp.Position.Y - valSliderTrack.AbsolutePosition.Y) / valSliderTrack.AbsoluteSize.Y, 0, 1)
                        currentVal = 1 - pct
                        valSliderFill.Size = G.Math.ud2(1, 0, currentVal, 0)
                        updateColorForCurrentCategory(currentHue, currentSat, currentVal)
                    end
                end
            end)

            G.Services.UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    wheelDragging = false
                    valDragging = false
                end
            end)

            S.createDivider(parent, "PROFILE MANAGER")

            Cfg.box = create("TextBox", {
                Size = G.Math.ud2(0.98, 0, 0, 36),
                BackgroundColor3 = HW.PANEL,
                Text = "Default",
                PlaceholderText = "Enter Config Name...",
                TextColor3 = HW.TEXT,
                PlaceholderColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                Parent = parent,
                ZIndex = 7
            }, {cCorner(8), cStroke(HW.STROKE)})

            Cfg.listFrame = create("ScrollingFrame", {
                Size = G.Math.ud2(0.98, 0, 0, 85),
                BackgroundColor3 = HW.BG,
                CanvasSize = G.Math.ud2(0, 0, 0, 0),
                ScrollBarThickness = 3,
                Parent = parent,
                ZIndex = 7
            }, {
                cCorner(8),
                cStroke(HW.STROKE),
                create("UIListLayout", {Padding = G.Math.ud(0, 4), SortOrder = Enum.SortOrder.Name}),
                create("UIPadding", {PaddingLeft = G.Math.ud(0, 4), PaddingRight = G.Math.ud(0, 4), PaddingTop = G.Math.ud(0, 4)})
            })

            Cfg.layout = create("Frame", {
                Name = "ConfigLayout",
                Size = G.Math.ud2(0.98, 0, 0, 32),
                BackgroundTransparency = 1,
                Parent = parent
            }, {
                create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = G.Math.ud(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center})
            })

            Cfg.shareLayout = create("Frame", {
                Name = "ConfigShareLayout",
                Size = G.Math.ud2(0.98, 0, 0, 32),
                BackgroundTransparency = 1,
                Parent = parent
            }, {
                create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = G.Math.ud(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center})
            })

            Cfg.refresh = function()
                for _, item in ipairs(Cfg.listFrame:GetChildren()) do 
                    if item:IsA("TextButton") then item:Destroy() end 
                end
                local configs = {}
                if listfiles and isfolder and isfolder(Cfg.folder) then
                    local ok, files = pcall(listfiles, Cfg.folder)
                    if ok and type(files) == "table" then
                        for _, file in ipairs(files) do
                            local normalized = tostring(file):gsub("\\", "/")
                            local name = normalized:match("([^/]+)%.json$") or normalized:match("([^/]+)$")
                            if name then configs[#configs + 1] = (name:gsub("%.json$", "")) end
                        end
                    end
                end
                if not table.find(configs, "Default") then configs[#configs + 1] = "Default" end

                for _, name in ipairs(configs) do
                    local isSelected = (name == Cfg.box.Text)
                    local btn = create("TextButton", {
                        Size = G.Math.ud2(1, 0, 0, 24),
                        BackgroundColor3 = isSelected and HW.TINT or HW.PANEL,
                        Text = "  " .. name,
                        TextColor3 = isSelected and HW.ORANGE_SOFT or HW.TEXT,
                        Font = Enum.Font.GothamBold,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = Cfg.listFrame,
                        ZIndex = 8
                    }, {cCorner(4)})
                    btn.MouseButton1Click:Connect(function() 
                        Cfg.box.Text = name 
                        Cfg.refresh() 
                    end)
                end
                Cfg.listFrame.CanvasSize = G.Math.ud2(0, 0, 0, #configs * 28 + 6)
            end

            Cfg.apply = function(data)
                if not data or type(data) ~= "table" then return end

                for k, v in pairs(data) do
                    if states[k] ~= nil then
                        if type(v) == "table" and type(states[k]) == "table" then
                            for subK, subV in pairs(v) do
                                states[k][subK] = subV
                            end
                        else
                            states[k] = v
                        end

                        -- Обновляем визуал интерфейса без повторных вызовов тяжелых функций
                        if S.UI_STORAGE[k] and type(S.UI_STORAGE[k]) == "table" then
                            for _, ui in ipairs(S.UI_STORAGE[k]) do
                                if type(ui) == "table" then
                                    if ui.type == "toggle" then
                                        if ui.update then ui.update(v) end
                                    elseif ui.type == "slider" and ui.apply then
                                        ui.apply(v, true)
                                    elseif ui.type == "dropdown" and type(v) == "table" then
                                        if ui.items then
                                            for _, itemRecord in ipairs(ui.items) do
                                                if v[itemRecord.key] ~= nil then
                                                    itemRecord.update(v[itemRecord.key])
                                                end
                                            end
                                        end
                                        if ui.updateBadge then ui.updateBadge() end
                                    end
                                end
                            end
                        end
                    end
                end

                -- Единая централизованная активация всех функций
                if S.UI_STORAGE and S.UI_STORAGE.syncAll then
                    S.UI_STORAGE.syncAll()
                end
            end
            S.applyConfigData = Cfg.apply

            local function mkBtn(name, key, row, width, cb)
                local b = create("TextButton", {
                    Name = name,
                    Size = G.Math.ud2(width, 0, 1, 0),
                    BackgroundColor3 = HW.PANEL_2,
                    Text = getText(key),
                    TextColor3 = HW.TEXT,
                    Font = Enum.Font.GothamBold,
                    TextSize = 11,
                    Parent = row,
                    ZIndex = 7
                }, {cCorner(6), cStroke(HW.STROKE, 1)})
                b.MouseButton1Click:Connect(cb)
                Cfg.buttons[key] = b
                return b
            end

            mkBtn("SaveBtn", "btnSave", Cfg.layout, 0.31, function()
                if not writefile then return showNotification("Save unsupported by executor", "Error") end
                writefile(Cfg.folder .. "/" .. Cfg.box.Text .. ".json", G.Services.HttpService:JSONEncode(states))
                showNotification(getText("msgSaved") .. Cfg.box.Text, "Success")
                Cfg.refresh()
            end)

            mkBtn("LoadBtn", "btnLoad", Cfg.layout, 0.31, function()
                if not readfile or not isfile then 
                    return showNotification("File system not supported", "Error") 
                end

                local confName = tostring(Cfg.box.Text or ""):gsub("^%s*(.-)%s*$", "%1")
                if confName == "" then confName = "Default" end
                confName = confName:gsub("%.json$", "")

                local filePath = Cfg.folder .. "/" .. confName .. ".json"

                if isfile(filePath) then
                    local ok, data = pcall(function() 
                        return G.Services.HttpService:JSONDecode(readfile(filePath)) 
                    end)
                    if ok and type(data) == "table" then
                        -- Очищаем кэш комнат перед применением, чтобы все ESP пересканировались
                        if S.clearRoomCaches then S.clearRoomCaches() end
                        Cfg.apply(data)
                        showNotification(getText("msgLoaded") .. confName, "Success")
                        Cfg.refresh()
                    else
                        showNotification("Failed to parse config file!", "Error")
                    end
                else
                    showNotification("Config not found: " .. confName, "Warning")
                end
            end)

            mkBtn("DelBtn", "btnDel", Cfg.layout, 0.31, function()
                if not delfile then return end
                local filePath = Cfg.folder .. "/" .. Cfg.box.Text .. ".json"
                if isfile and isfile(filePath) then
                    delfile(filePath)
                    Cfg.box.Text = "Default"
                    Cfg.refresh()
                    showNotification(getText("msgDeleted") .. Cfg.box.Text, "Info")
                end
            end)

            mkBtn("ExportBtn", "btnExport", Cfg.shareLayout, 0.47, function()
                if not setclipboard then return showNotification("Clipboard not supported", "Error") end
                pcall(setclipboard, G.Services.HttpService:JSONEncode(states))
                showNotification(getText("msgExported"), "Success")
            end)

            mkBtn("ImportBtn", "btnImport", Cfg.shareLayout, 0.47, function()
                local clip = (getclipboard and pcall(getclipboard) and getclipboard()) or ""
                if clip ~= "" then
                    local ok, data = pcall(function() return G.Services.HttpService:JSONDecode(clip) end)
                    if ok and type(data) == "table" then
                        Cfg.apply(data)
                        showNotification(getText("msgImported"), "Success")
                    else
                        showNotification(getText("msgInvalidData"), "Error")
                    end
                end
            end)

            langBtn.MouseButton1Click:Connect(function()
                states.language = (states.language == "English") and "Russian" or "English"
                saveLanguage()
                langBtn.Text = getText("langBtn")
                changelogBtn.Text = getText("btnViewChangelog")
                if S.SearchBox then S.SearchBox.PlaceholderText = getText("searchPlaceholder") end
                if S.keybindBtn and S.keybindBtn.Parent then
                    S.keybindBtn.Text = getText("menuKeyBtn") .. "[" .. tostring(states.menuKey) .. "]"
                end
                if S.ModalCard then
                    S.ModalCard.Title.Text = getText("modalCloseTitle")
                    S.ModalCard.Desc.Text = getText("modalCloseDesc")
                end
                if S.modalBtnCancel then S.modalBtnCancel.Text = getText("modalBtnCancel") end
                if S.modalBtnConfirm then S.modalBtnConfirm.Text = getText("modalBtnConfirm") end

                for _, tab in ipairs(S.TabBtns) do tab.instance.Text = getText(tab.key) end
                for k, arr in pairs(S.UI_STORAGE) do
                    if type(arr) == "table" then
                        local txt = getText(k)
                        for _, ui in ipairs(arr) do
                            if type(ui) == "table" then
                                if ui.type == "dropdown" then
                                    if ui.titleLabel then ui.titleLabel.Text = txt end
                                    if ui.btnAll then ui.btnAll.Text = getText("dropSelectAll") end
                                    if ui.btnClear then ui.btnClear.Text = getText("dropClearAll") end
                                    if ui.items then
                                        for _, it in ipairs(ui.items) do
                                            if it.label then 
                                                it.label.Text = getText("mOpt_" .. it.key) or getText(it.key) 
                                            end
                                        end
                                    end
                                elseif ui.label then 
                                    ui.label.Text = txt 
                                end
                            end
                        end
                    end
                end
                for _, obj in ipairs(S.localizedLabels) do
                    if obj.instance and obj.instance.Parent then obj.instance.Text = getText(obj.key) end
                end
                for k, b in pairs(Cfg.buttons) do b.Text = getText(k) end
                populateKeybindRows(keybindSearchBox.Text)
                S.refreshEsp()
                Cfg.refresh()
                if S.RenderChangelogContent then S.RenderChangelogContent() end
                if S.FunModule and S.FunModule.onLanguageChanged then
                    S.FunModule.onLanguageChanged()
                end
            end)

            Cfg.refresh()
        end

        local pageEsp = S.createPage("Esp", "Tab_Esp")
        local pageAlerts = S.createPage("Alerts", "Tab_Alerts")
        local pageAnti = S.createPage("Anti", "Tab_Anti")
        local pageMisc = S.createPage("Misc", "Tab_Misc")

        local function LoadFunModuleExternal()
            if S.FunModuleLoaded then return end
            S.FunModuleLoaded = true

            if not FUN_TAB_URL or FUN_TAB_URL == "" then
                local fallbackFun = S.createPage("Fun", "Tab_Fun")
                S.createDivider(fallbackFun, "GIST URL NOT SET")
                return
            end

            local rawCode = nil
            pcall(function()
                if game.HttpGet then
                    rawCode = game:HttpGet(FUN_TAB_URL)
                end
            end)

            if not rawCode then
                pcall(function()
                    local req = (syn and syn.request) or request or http_request or (http and http.request)
                    if req then
                        local r = req({Url = FUN_TAB_URL, Method = "GET"})
                        if type(r) == "table" and r.Body and r.Body ~= "" then
                            rawCode = r.Body
                        end
                    end
                end)
            end

            if rawCode and rawCode ~= "" then
                if rawCode:find("DoorsUniverseId") or rawCode:find("LoadMainScript") then
                    warn("[HubHubHub]: FUN_TAB_URL contains Main Script instead of FunModule! Aborted to prevent loop.")
                    local fallbackFun = S.createPage("Fun", "Tab_Fun")
                    S.createDivider(fallbackFun, "ERROR: GIST CONTAINS MAIN SCRIPT")
                    return
                end

                local fn, err = loadstring(rawCode)
                if fn then
                    local success, modInit = pcall(fn)
                    if success and type(modInit) == "function" then
                        local apiTable = {
                            player = player,
                            Camera = Camera,
                            isTouchDevice = isTouchDevice,
                            create = create,
                            cCorner = cCorner,
                            cStroke = cStroke,
                            makeDraggable = makeDraggable,
                            showNotification = showNotification,
                            getText = getText,
                            saveAutoRestoreSession = saveAutoRestoreSession
                        }
                        S.FunModule = modInit(S, G, states, apiTable)
                        -- [ФИКС]: Моментально включаем функции вкладки FUN после скачивания с гиста
                        if S.FunModule and S.FunModule.syncAll then
                            task.defer(function()
                                S.FunModule.syncAll()
                            end)
                        end
                    else
                        warn("[HubHubHub FunModule Exec Error]:", modInit)
                    end
                else
                    warn("[HubHubHub FunModule Compile Error]:", err)
                end
            else
                local fallbackFun = S.createPage("Fun", "Tab_Fun")
                S.createDivider(fallbackFun, "FAILED TO FETCH FUN GIST")
            end
        end

        -- ====================================================================
        --                  STATS & TIMERS HUD
        -- ====================================================================
        S.StatsHUD = create("Frame", {
            Name = "HubStatsHUD",
            Size = G.Math.ud2(0, isTouchDevice and 165 or 185, 0, 0),
            Position = G.Math.ud2(0, 15, 0.4, 0),
            BackgroundColor3 = HW.BG,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false,
            Parent = S.ScreenGui,
            ZIndex = 30
        }, {
            cCorner(10),
            cStroke(HW.STROKE, 1.2),
            create("UIPadding", {PaddingTop = G.Math.ud(0, 8), PaddingBottom = G.Math.ud(0, 8), PaddingLeft = G.Math.ud(0, 10), PaddingRight = G.Math.ud(0, 10)}),
            create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 4)})
        })
        makeDraggable(S.StatsHUD)

        local function createStatLabel(name, order)
            return create("TextLabel", {
                Name = name,
                Size = G.Math.ud2(1, 0, 0, 18),
                BackgroundTransparency = 1,
                Text = "",
                TextColor3 = G.Math.rgb(255, 255, 255),
                Font = Enum.Font.GothamBold,
                TextSize = isTouchDevice and 10 or 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = false,
                LayoutOrder = order,
                Parent = S.StatsHUD,
                ZIndex = 31
            })
        end

        local statOxygenLabel = createStatLabel("OxygenLabel", 1)
        local statBackdoorLabel = createStatLabel("BackdoorLabel", 2)
        local statHonchoLabel = createStatLabel("HonchoLabel", 3)

        S.updateStatsHUDVisibility = function()
            local anyActive = states.statOxygen or states.statBackdoorTimer or states.statHonchoTimer
            S.StatsHUD.Visible = anyActive
            statOxygenLabel.Visible = states.statOxygen
            statBackdoorLabel.Visible = states.statBackdoorTimer
            statHonchoLabel.Visible = states.statHonchoTimer
        end

        local function getBackdoorTimerString()
            local fr = G.Services.ReplicatedStorage:FindFirstChild("FloorReplicated")
            local dt = fr and fr:FindFirstChild("DigitalTimer")
            if dt and dt:IsA("IntValue") and dt.Value > 0 then
                local totalSec = math.max(0, dt.Value)
                local mins = math.floor(totalSec / 60)
                local secs = totalSec % 60
                return string.format("%02d:%02d", mins, secs)
            end

            local cr = G.Services.Workspace:FindFirstChild("CurrentRooms")
            if cr then
                local curRoom = S.CachedCurrentRoom or 0
                for r = curRoom - 1, curRoom + 2 do
                    local room = cr:FindFirstChild(tostring(r))
                    if room then
                        local door = room:FindFirstChild("Door")
                        local doorPlate = door and door:FindFirstChild("BackdoorDisplayPlate", true)
                        local doorTxt = doorPlate and doorPlate:FindFirstChild("Text", true)
                        if doorTxt and doorTxt:IsA("TextLabel") and doorTxt.Text ~= "" and doorTxt.Text:find(":") then
                            return doorTxt.Text
                        end

                        local lever = room:FindFirstChild("TimerLever", true)
                        local leverPlate = lever and lever:FindFirstChild("DisplayTimer", true)
                        local leverTxt = leverPlate and leverPlate:FindFirstChild("Text", true)
                        if leverTxt and leverTxt:IsA("TextLabel") and leverTxt.Text ~= "" and leverTxt.Text:find(":") then
                            return leverTxt.Text
                        end
                    end
                end
            end

            local gd = G.Services.ReplicatedStorage:FindFirstChild("GameData")
            local gt = gd and gd:FindFirstChild("GameTimer")
            local lm = G.Services.ReplicatedStorage:FindFirstChild("LiveModifiers")
            local hasBackdoorMod = (lm and lm:FindFirstChild("BackdoorHaste")) or (gd and gd:FindFirstChild("Floor") and tostring(gd.Floor.Value):lower():find("backdoor"))

            if gt and gt:IsA("ValueBase") and tonumber(gt.Value) ~= nil and (gt.Value > 0 or hasBackdoorMod) then
                local totalSec = math.max(0, math.floor(gt.Value))
                local mins = math.floor(totalSec / 60)
                local secs = totalSec % 60
                return string.format("%02d:%02d", mins, secs)
            end

            return "N/A"
        end

        local function getHonchoTimerData()
            local trk = S.HonchoTracker
            if not trk then return nil, "none" end

            if trk.stageState == "Office" then
                return nil, "office", 1, 4, 0, trk.isStarlight
            end

            if trk.stageState == "Victory" then
                return 0, "victory", trk.stage, trk.maxStages, trk.hitCount, trk.isStarlight
            end

            if trk.stageState == "Cleared" then
                return 0, "cleared", trk.stage, trk.maxStages, trk.hitCount, trk.isStarlight
            end

            if trk.stageState == "Breached" then
                return 0, "breached", trk.stage, trk.maxStages, trk.hitCount, trk.isStarlight
            end

            if trk.stageState == "WaitingTerminal" then
                return 0, "waiting_terminal", trk.stage, trk.maxStages, trk.hitCount, trk.isStarlight
            end

            if trk.stageState == "Active" and trk.stageStartTime > 0 then
                local maxDur = trk.isStarlight and trk.starlightDuration or trk.normalDuration
                local elapsed = tick() - trk.stageStartTime
                local remaining = math.max(0, math.floor(maxDur - elapsed))

                if remaining <= 0 then
                    if trk.remainingBoxes > 0 then
                        trk.stageState = "Breached"
                        return 0, "breached", trk.stage, trk.maxStages, trk.hitCount, trk.isStarlight
                    end
                end

                return remaining, "seconds", trk.stage, trk.maxStages, trk.hitCount, trk.isStarlight
            end

            return nil, "none"
        end

        task.spawn(function()
            while S.Runtime.running do
                task.wait(isTouchDevice and 0.25 or 0.2)

                if states.statOxygen or states.statBackdoorTimer or states.statHonchoTimer then
                    local char = player.Character

                    if states.statOxygen then
                        local ox = nil
                        if char then ox = char:GetAttribute("Oxygen") end
                        if ox == nil then ox = player:GetAttribute("Oxygen") end
                        
                        if ox ~= nil then
                            local oxNum = math.clamp(math.floor(tonumber(ox) or 0), 0, 100)
                            statOxygenLabel.Text = string.format("🫁 Oxygen: %d%%", oxNum)
                        else
                            statOxygenLabel.Text = "🫁 Oxygen: 100%"
                        end
                        statOxygenLabel.TextColor3 = G.Math.rgb(255, 255, 255)
                    end

                    if states.statBackdoorTimer then
                        local timeStr = getBackdoorTimerString()
                        statBackdoorLabel.Text = "⏳ Backdoor: " .. timeStr
                        statBackdoorLabel.TextColor3 = G.Math.rgb(255, 255, 255)
                    end

                    if states.statHonchoTimer then
                        local val, kind, curStage, maxStages, hits, isStar = getHonchoTimerData()
                        local starTag = isStar and "★ " or ""
                        local stageTag = string.format("[%d/%d]", curStage or 1, maxStages or 4)

                        if kind == "seconds" then
                            local mins = math.floor(val / 60)
                            local secs = val % 60
                            local timeStr = string.format("%02d:%02d", mins, secs)
                            local trk = S.HonchoTracker
                            local boxTag = (trk and trk.totalBoxes and trk.totalBoxes > 0) and string.format(" | 📦%d/%d", trk.correctBoxes or 0, trk.totalBoxes) or ""

                            if hits and hits > 0 then
                                statHonchoLabel.Text = string.format("🚪 %sHoncho %s: %s (%ds | 💥%d%s)", starTag, stageTag, timeStr, val, hits, boxTag)
                            else
                                statHonchoLabel.Text = string.format("🚪 %sHoncho %s: %s (%ds%s)", starTag, stageTag, timeStr, val, boxTag)
                            end
                            statHonchoLabel.TextColor3 = (val <= 20) and G.Math.rgb(255, 60, 60) or G.Math.rgb(255, 255, 255)

                        elseif kind == "waiting_terminal" then
                            statHonchoLabel.Text = string.format("🚪 %sHoncho %s: Pull Terminal! 🛑", starTag, stageTag)
                            statHonchoLabel.TextColor3 = G.Math.rgb(255, 215, 0)

                        elseif kind == "cleared" then
                            statHonchoLabel.Text = string.format("🚪 Honcho %s: CLEARED! Run! 🏃", stageTag)
                            statHonchoLabel.TextColor3 = G.Math.rgb(80, 255, 120)

                        elseif kind == "breached" then
                            statHonchoLabel.Text = string.format("🚪 Honcho %s: BREACHED! ⚠️", stageTag)
                            statHonchoLabel.TextColor3 = G.Math.rgb(255, 45, 45)

                        elseif kind == "victory" then
                            statHonchoLabel.Text = "🚪 Honcho: ALL SECTORS CLEARED! (4/4) ✅"
                            statHonchoLabel.TextColor3 = G.Math.rgb(75, 255, 140)

                        elseif kind == "office" then
                            statHonchoLabel.Text = "🚪 Honcho: Ready (Executive Office)"
                            statHonchoLabel.TextColor3 = G.Math.rgb(200, 200, 210)

                        else
                            statHonchoLabel.Text = "🚪 Honcho: N/A"
                            statHonchoLabel.TextColor3 = G.Math.rgb(150, 150, 160)
                        end
                    end
                end
            end
        end)

        task.wait()

        BuildEspPage(pageEsp)
        BuildAlertsPage(pageAlerts)
        BuildAntiPage(pageAnti)
        BuildMiscPage(pageMisc)

        task.spawn(LoadFunModuleExternal)

        task.wait()

        local pageSettings = S.createPage("Settings", "Tab_Settings")

        S.UI_STORAGE.buildSettings(pageSettings)

        -- ====================================================================
        --             ПЕРЕКЛЮЧЕНИЕ ТЕМЫ ХАБА (плавная смена цветов)
        -- ====================================================================
        S.themeEntries = {}

        local function themeColorKey(c)
            return string.format("%d_%d_%d",
                math.floor(c.R * 255 + 0.5),
                math.floor(c.G * 255 + 0.5),
                math.floor(c.B * 255 + 0.5))
        end

        -- Собираем все элементы, окрашенные в цвета текущей палитры,
        -- чтобы потом уметь плавно перекрашивать их в другую тему
        local function buildThemeRegistry()
            S.themeEntries = {}
            local lookup = {}
            for role, col in pairs(HW) do
                if typeof(col) == "Color3" then
                    lookup[themeColorKey(col)] = role
                end
            end

            local function add(obj, prop)
                local ok, val = pcall(function() return obj[prop] end)
                if ok and typeof(val) == "Color3" then
                    local role = lookup[themeColorKey(val)]
                    if role then
                        table.insert(S.themeEntries, {obj = obj, prop = prop, role = role})
                    end
                end
            end

            for _, inst in ipairs(S.ScreenGui:GetDescendants()) do
                if inst:IsA("GuiObject") then
                    add(inst, "BackgroundColor3")
                    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                        add(inst, "TextColor3")
                    end
                    if inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
                        add(inst, "ImageColor3")
                    end
                elseif inst:IsA("UIStroke") then
                    add(inst, "Color")
                end
            end
        end

        buildThemeRegistry()

        -- Виден ли элемент на экране (учитывая скрытые страницы/табы)
        local function themeIsOnScreen(obj)
            local o = obj
            local guard = 0
            while o and o ~= S.ScreenGui and guard < 12 do
                if o:IsA("GuiObject") and not o.Visible then return false end
                o = o.Parent
                guard = guard + 1
            end
            return true
        end

        local themeAnimToken = 0

        S.setTheme = function(name, instant)
            name = (name == "halloween") and "halloween" or "normal"
            states.theme = name
            applyPalette(name)

            -- Уведомления берут цвета из палитры
            NOTIFY_COLORS.Info = HW.ORANGE_SOFT
            NOTIFY_COLORS.Success = HW.ORANGE
            NOTIFY_COLORS.Warning = HW.PURPLE
            NOTIFY_COLORS.Background = HW.BG
            NOTIFY_COLORS.Stroke = HW.STROKE

            themeAnimToken = themeAnimToken + 1
            local token = themeAnimToken

            local animated, deferred = {}, {}

            for _, e in ipairs(S.themeEntries) do
                local obj = e.obj
                if obj and obj.Parent then
                    local target = HW[e.role]
                    if target then
                        local cur = obj[e.prop]
                        if typeof(cur) ~= "Color3" or cur ~= target then
                            if instant then
                                pcall(function() obj[e.prop] = target end)
                            elseif themeIsOnScreen(obj) then
                                table.insert(animated, {obj = obj, prop = e.prop, from = cur, to = target})
                            else
                                table.insert(deferred, {obj = obj, prop = e.prop, to = target})
                            end
                        end
                    end
                end
            end

            -- Плавная смена: один общий цикл на кадр вместо сотен твинов
            -- (именно они давали микро-фризы при переключении)
            if #animated > 0 then
                local duration = 0.3
                local startedAt = os.clock()
                local conn
                conn = G.Services.RunService.RenderStepped:Connect(function()
                    if token ~= themeAnimToken then
                        conn:Disconnect()
                        return
                    end
                    local a = math.clamp((os.clock() - startedAt) / duration, 0, 1)
                    local k = 1 - (1 - a) * (1 - a) * (1 - a)
                    for _, e in ipairs(animated) do
                        local obj = e.obj
                        if obj and obj.Parent and typeof(e.from) == "Color3" then
                            obj[e.prop] = e.from:Lerp(e.to, k)
                        end
                    end
                    if a >= 1 then conn:Disconnect() end
                end)
            end

            -- Скрытые страницы перекрашиваем после анимации, аккуратными пачками,
            -- чтобы не было рывка
            if #deferred > 0 then
                task.delay(instant and 0 or 0.3, function()
                    if token ~= themeAnimToken then return end
                    task.spawn(function()
                        for i, e in ipairs(deferred) do
                            local obj = e.obj
                            if obj and obj.Parent then
                                pcall(function() obj[e.prop] = e.to end)
                            end
                            if i % 80 == 0 then task.wait() end
                        end
                    end)
                end)
            end

            if S.MainFrame then
                local grad = S.MainFrame:FindFirstChildOfClass("UIGradient")
                if grad then
                    if instant then
                        grad.Color = ColorSequence.new(HW.BG, HW.BG_BOTTOM)
                    else
                        task.delay(0.3, function()
                            if grad and grad.Parent then
                                grad.Color = ColorSequence.new(HW.BG, HW.BG_BOTTOM)
                            end
                        end)
                    end
                end
                local topBar = S.MainFrame:FindFirstChild("TopBar")
                local title = topBar and topBar:FindFirstChild("HubTitle")
                if title then
                    title.Text = tostring(THEME_EMOJI) .. "HUBHUBHUB"
                end
            end

            if S.styleThemeButton then
                S.styleThemeButton(instant)
            end
        end

        if pageEsp then
            pageEsp.Visible = true
        end

        if S.TabBtns[1] and S.TabBtns[1].instance then
            S.currentActiveTabBtn = S.TabBtns[1].instance
            G.Services.TweenService:Create(S.TabBtns[1].instance, G.Math.tw(0.2), {
                TextColor3 = HW.ORANGE, 
                BackgroundColor3 = HW.PANEL_2, 
                BackgroundTransparency = 0
            }):Play()
        end

        -- ====================================================================
        --             РЕФЛОУ МАКЕТА И АНИМАЦИЯ МЕНЮ
        -- ====================================================================
        local currentLayoutMode = nil
        S.updateResponsiveLayout = function(force)
            if not S.MainFrame then return end
            local curWidth = S.MainFrame.AbsoluteSize.X
            local newMode = (curWidth >= 760 and "MaxWide") or (curWidth >= 660 and "Wide") or "Compact"
            if not force and newMode == currentLayoutMode then return end
            currentLayoutMode = newMode

            if S.registeredRows then
                for _, rData in ipairs(S.registeredRows) do
                    if rData.frame then
                        updateRowChildren(rData.frame, rData.height)
                    end
                end
            end

            if S.SearchBox and S.SearchBox.Text ~= "" and S.applySearchFilter then
                S.applySearchFilter(S.SearchBox.Text)
            end
        end

        S.Runtime.connections[#S.Runtime.connections + 1] = S.MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            S.updateResponsiveLayout(false)
        end)

        S.updateResponsiveLayout(true)

        S.UI_STORAGE.guiOpen = true
        S.UI_STORAGE.anim = function(open)
            S.UI_STORAGE.guiOpen = open
            if open then
                S.MiniButton.Visible = false
                S.MainFrame.Visible = true
                setSmartFade(S.MainFrame, false)
                S.MainScale.Scale = 0.88
                G.Services.TweenService:Create(S.MainScale, G.Math.tw(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Scale = 1}):Play()
            else
                S.showCloseConfirmation(false)
                local t = G.Services.TweenService:Create(S.MainScale, G.Math.tw(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0.85})
                setSmartFade(S.MainFrame, true)
                t:Play()
                t.Completed:Connect(function()
                    if not S.UI_STORAGE.guiOpen then
                        S.MainFrame.Visible = false
                        S.MiniButton.Visible = true
                        S.MiniButton.Size = G.Math.ud2(0, 36, 0, 36)
                        G.Services.TweenService:Create(S.MiniButton, G.Math.tw(0.25, Enum.EasingStyle.Back), {Size = G.Math.ud2(0, 48, 0, 48)}):Play()
                    end
                end)
            end
        end

        S.MiniButton.MouseButton1Click:Connect(function() S.UI_STORAGE.anim(true) end)
        S.minBtn.MouseButton1Click:Connect(function() S.UI_STORAGE.anim(false) end)

        -- Обработка горячих клавиш меню и кастомных кейбиндов
        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.UserInputService.InputBegan:Connect(function(i, gp)
            if gp or not i or not i.KeyCode or i.KeyCode == Enum.KeyCode.Unknown then return end
            local pressedKey = i.KeyCode.Name

            if pressedKey == states.menuKey then
                S.UI_STORAGE.anim(not S.UI_STORAGE.guiOpen)
                return
            end

            for featureKey, boundKey in pairs(customKeybinds) do
                if boundKey and boundKey == pressedKey then
                    if featureKey == "noclipPhase" or featureKey == "noclipUp" or featureKey == "noclipDown" then
                        break
                    end

                    states[featureKey] = not states[featureKey]
                    local newState = states[featureKey]
                    local callbackExecuted = false

                    if S.UI_STORAGE[featureKey] and type(S.UI_STORAGE[featureKey]) == "table" then
                        for _, ui in ipairs(S.UI_STORAGE[featureKey]) do
                            if ui.type == "toggle" then
                                if ui.update then ui.update(newState) end
                                if ui.callback and not callbackExecuted then
                                    callbackExecuted = true
                                    pcall(ui.callback, newState)
                                end
                            end
                        end
                    end

                    if not callbackExecuted and S.UI_STORAGE and S.UI_STORAGE.syncAll then
                        pcall(S.UI_STORAGE.syncAll)
                    end

                    local featTitle = getText(featureKey) or featureKey
                    showNotification(featTitle .. ": " .. (newState and "ON" or "OFF"), "Info", nil, 1.8)
                    saveAutoRestoreSession()
                    break
                end
            end
        end)

        -- ====================================================================
        --                 ОСНОВНЫЕ ЦИКЛЫ ОБНОВЛЕНИЯ (HEARTBEAT & RENDER)
        -- ====================================================================
        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.RunService.Heartbeat:Connect(function(dt)
            if not S.Runtime.running then return end
            if states.gpsPath and S.updateGPSPath then
                S.updateGPSPath()
            end
            local now = tick()
            if states.screechRemover and (now - S.Timers.lastScreechWatchdog >= 1.0) then
                S.Timers.lastScreechWatchdog = now
                if S.cleanScreechLogic then S.cleanScreechLogic() end
            end

            local inCutsceneNow = isAnyCutscenePlaying()

            if states.speedEnabled and not inCutsceneNow then
                S.ForcePermanentSilentState()
                local char = player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local colPart = char and char:FindFirstChild("CollisionPart")
                if hum and hrp and hum.Health > 0 then
                    local moveDir = hum.MoveDirection
                    local targetVel = (moveDir.Magnitude > 0.05) 
                        and G.Math.v3(moveDir.Unit.X * states.speedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Unit.Z * states.speedValue) 
                        or G.Math.v3(0, hrp.AssemblyLinearVelocity.Y, 0)
                    hrp.AssemblyLinearVelocity = targetVel
                    if colPart then colPart.AssemblyLinearVelocity = targetVel end
                end
            end

            if states.positionSpoof then
                local char = player.Character
                if char then
                    -- Во время катсцен/анимаций возвращаем нормальный Root.C1, чтобы камера не проваливалась под пол
                    S.POSITION_SPOOF(char, not inCutsceneNow)
                end
            end

            if states.fullbright and (now - S.Timers.lastFullbrightCheck >= 0.4) then
                S.Timers.lastFullbrightCheck = now
                local lgt = G.Services.Lighting
                if lgt.FogEnd < 99999 or lgt.GlobalShadows ~= false or lgt.Ambient.R < 0.45 or lgt.ExposureCompensation ~= 0 then
                    S.applyFullbrightProperties(false)
                end
                S.suppressScreenEffects()
            end

            if now - S.Timers.lastPurge >= 2.5 then
                S.Timers.lastPurge = now
                S.updateCachedRoom()
                S.purgeOldRoomESP()
            end

            local textInterval = isTouchDevice and 0.4 or 0.22
            local textInterval = isTouchDevice and 0.4 or 0.22
            if now - S.Timers.text >= textInterval then
                S.Timers.text = now
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local myPos = hrp and hrp.Position
                local showLabels = (states.espNames ~= false)

                if myPos then
                    for obj, data in pairs(S.activeHighlights) do
                        if obj and obj.Parent then
                            local isMon = data.isMonster or isMonsterInstance(obj, data.typeName)
                            if not isMon and not S.isObjectInAllowedRooms(obj) then
                                if data.group then pcall(function() data.group:Destroy() end) end
                                if S.tracerLines and S.tracerLines[obj] then
                                    pcall(function() S.tracerLines[obj]:Remove() end)
                                    S.tracerLines[obj] = nil
                                end
                                S.activeHighlights[obj] = nil
                                objectRoomMap[obj] = nil
                            else
                                if data.billboard and data.billboard.Enabled ~= showLabels then
                                    data.billboard.Enabled = showLabels
                                end
                                if data.label and data.label.Visible ~= showLabels then
                                    data.label.Visible = showLabels
                                end

                                local objPos = (data.adorneePart and data.adorneePart:IsA("BasePart") and data.adorneePart.Parent and data.adorneePart.Position) or getPivotPos(obj)
                                if objPos then
                                    local dx, dy, dz = objPos.X - myPos.X, objPos.Y - myPos.Y, objPos.Z - myPos.Z
                                    local distSq = dx*dx + dy*dy + dz*dz

                                    if isTouchDevice and data.highlight then
                                        local shouldBeEnabled = isMon or (distSq <= 10000)
                                        if data.highlight.Enabled ~= shouldBeEnabled then
                                            data.highlight.Enabled = shouldBeEnabled
                                        end
                                    end

                                    if showLabels and (distSq < 90000 or isMon) then
                                        if states.distanceEsp then
                                            local intDist = G.Math.floor(math.sqrt(distSq))
                                            if data.lastDist ~= intDist then 
                                                data.lastDist = intDist
                                                data.label.Text = data.cachedName .. " [" .. tostring(intDist) .. "m]" 
                                            end
                                        else
                                            if data.lastDist ~= -1 then 
                                                data.lastDist = -1
                                                data.label.Text = data.cachedName 
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if data.group then pcall(function() data.group:Destroy() end) end
                            if S.tracerLines and S.tracerLines[obj] then
                                pcall(function() S.tracerLines[obj]:Remove() end)
                                S.tracerLines[obj] = nil
                            end
                            S.activeHighlights[obj] = nil
                            objectRoomMap[obj] = nil
                        end
                    end

                    if states.playerEsp then
                        for p, pData in pairs(S.activePlayerHighlights) do
                            if p and p.Parent and pData.char and pData.char.Parent and pData.root and pData.root.Parent then
                                if pData.label then
                                    pData.label.Visible = showLabels
                                    if showLabels then
                                        if states.distanceEsp then
                                            local rPos = pData.root.Position
                                            local dx, dy, dz = rPos.X - myPos.X, rPos.Y - myPos.Y, rPos.Z - myPos.Z
                                            pData.label.Text = string.format("%s [%dm]", pData.rawName, G.Math.floor(math.sqrt(dx*dx + dy*dy + dz*dz)))
                                        else
                                            pData.label.Text = pData.rawName
                                        end
                                    end
                                end
                            else
                                S.removePlayerEsp(p)
                            end
                        end
                    end

                    if states.honchoBoxEsp and S.HonchoData and S.HonchoData.trackedObjects then
                        for targetInst, data in pairs(S.HonchoData.trackedObjects) do
                            local bb = S.HonchoData.activeBillboards and S.HonchoData.activeBillboards[targetInst]
                            if bb and bb.Enabled ~= showLabels then
                                bb.Enabled = showLabels
                            end
                            if showLabels and data.Part and data.Part.Parent and data.Label and data.Label.Parent then
                                if states.distanceEsp then
                                    local dPos = data.Part.Position
                                    local dx, dy, dz = dPos.X - myPos.X, data.Part.Position.Y - myPos.Y, dPos.Z - myPos.Z
                                    local dist = G.Math.floor(math.sqrt(dx*dx + dy*dy + dz*dz))
                                    if data.lastDist ~= dist then
                                        data.lastDist = dist
                                        data.Label.Text = "[" .. data.Prefix .. ": " .. data.Code .. "] [" .. tostring(dist) .. "m]"
                                    end
                                else
                                    if data.lastDist ~= -1 then
                                        data.lastDist = -1
                                        data.Label.Text = "[" .. data.Prefix .. ": " .. data.Code .. "]"
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if states.watermark and now - S.Timers.watermark >= 1 then
                S.Timers.watermark = now
                local pingMs = getRealPing()
                if S.wmFrame and S.wmFrame:FindFirstChild("StatsTxt") then
                    S.wmFrame.StatsTxt.Text = string.format(THEME_EMOJI .. "HUBHUBHUB |  FPS: %d  |  Ping: %dms", S.Timers.currentFPS, pingMs)
                end
            end

            if S.FunModule and S.FunModule.onHeartbeat then
                S.FunModule.onHeartbeat()
            end
        end)

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.RunService.RenderStepped:Connect(function(dt)
            if not S.Runtime.running then return end
            
            S.Timers.frameCount = S.Timers.frameCount + 1
            S.Timers.frameTime = S.Timers.frameTime + dt
            if S.Timers.frameTime >= 1.0 then
                S.Timers.currentFPS = G.Math.clamp(G.Math.floor(S.Timers.frameCount / S.Timers.frameTime), 1, 999)
                S.Timers.frameCount = 0
                S.Timers.frameTime = 0
            end

            local cam = G.Services.Workspace.CurrentCamera or Camera
            if states.fovValue ~= 70 and cam and not isAnyCutscenePlaying() then
                cam.FieldOfView = states.fovValue
            end

            if S.updateTracersFrame then S.updateTracersFrame() end
            if S.FunModule and S.FunModule.onRenderStepped then S.FunModule.onRenderStepped(dt) end
        end)

        local trackedSpawnedMonsters = setmetatable({}, {__mode = "k"})

        local function onMonsterSpawned(child)
            if not child or (not child:IsA("Model") and not child:IsA("BasePart")) then return end
            
            -- Если часть уже принадлежит обнаруженному монстру, пресекаем дублирование
            local rootTarget = child:IsA("Model") and child or child:FindFirstAncestorOfClass("Model") or child
            if trackedSpawnedMonsters[rootTarget] or trackedSpawnedMonsters[child] then return end

            local name = tostring(child.Name)
            local mConf = MONSTER_ESP_NAMES[name]
            if not mConf then
                local l = name:lower()
                if l:find("rushmoving") then mConf = MONSTER_ESP_NAMES["RushMoving"]
                elseif l:find("ambushmoving") then mConf = MONSTER_ESP_NAMES["AmbushMoving"]
                elseif l:find("backdoorrush") then mConf = MONSTER_ESP_NAMES["BackdoorRush"]
                elseif l:find("a60") or l:find("a-60") then mConf = MONSTER_ESP_NAMES["A60"]
                elseif l:find("a120") or l:find("a-120") then mConf = MONSTER_ESP_NAMES["A120"]
                elseif l:find("a160") or l:find("a-160") then mConf = MONSTER_ESP_NAMES["A160"]
                elseif l:find("frozenambush") then mConf = MONSTER_ESP_NAMES["FrozenAmbush"]
                elseif l:find("bash") then mConf = MONSTER_ESP_NAMES["BashMoving"]
                elseif l:find("bush") then mConf = MONSTER_ESP_NAMES["BushMoving"]
                elseif l:find("scribble") then mConf = MONSTER_ESP_NAMES["ScribblesMoving"]
                elseif l:find("eyes") then mConf = MONSTER_ESP_NAMES["Eyes"]
                elseif l:find("lookman") then mConf = MONSTER_ESP_NAMES["Lookman"]
                elseif l:find("halt") or l:find("shade") then mConf = MONSTER_ESP_NAMES["Shade"]
                elseif l:find("screech") then mConf = MONSTER_ESP_NAMES["Screech"]
                elseif l:find("figure") then mConf = MONSTER_ESP_NAMES["FigureRig"]
                elseif l:find("grumble") or l:find("grumbo") then mConf = MONSTER_ESP_NAMES["Grumbo"]
                elseif l:find("groundskeeper") then mConf = MONSTER_ESP_NAMES["Groundskeeper"]
                elseif l:find("bramble") then mConf = MONSTER_ESP_NAMES["LiveEntityBramble"]
                elseif name == "MonumentEntity" then mConf = MONSTER_ESP_NAMES["MonumentEntity"]
                elseif l:find("mandrake") then mConf = MONSTER_ESP_NAMES["MandrakeLive"]
                elseif l:find("seek") then mConf = MONSTER_ESP_NAMES["SeekMoving"]
                elseif l:find("creak") then mConf = MONSTER_ESP_NAMES["Creak"]
                end
            end

            if mConf then
                S.triggerMonsterAlert(name, rootTarget)
                local allowThisMonster = (states.monsterEsp and isMonsterAllowed(mConf.key))
                    or (mConf.key == "figure" and states.figureEsp)
                    or (mConf.key == "groundskeeper" and states.groundskeeperEsp)
                    or (mConf.key == "grumble" and states.grumbleEsp)
                    or (mConf.key == "bramble" and states.brambleEsp)
                    or (mConf.key == "monument" and states.monumentEsp)
                    or (mConf.key == "mandrake" and states.mandrakeEsp)

                if allowThisMonster then
                    S.applyHighlight(rootTarget, mConf.col, mConf.key, nil, mConf.isRushLike)
                    if S.activeHighlights[rootTarget] then
                        trackedSpawnedMonsters[rootTarget] = true
                        trackedSpawnedMonsters[child] = true
                    end
                end
                return
            end

            S.checkObject(child)
        end

        S.Runtime.connections[#S.Runtime.connections + 1] = G.Services.Workspace.ChildAdded:Connect(onMonsterSpawned)
        local liveEntitiesFolder = G.Services.Workspace:FindFirstChild("LiveEntities")
        if liveEntitiesFolder then
            S.Runtime.connections[#S.Runtime.connections + 1] = liveEntitiesFolder.ChildAdded:Connect(onMonsterSpawned)
            for _, child in ipairs(liveEntitiesFolder:GetChildren()) do
                onMonsterSpawned(child)
            end
        end
        for _, child in ipairs(G.Services.Workspace:GetChildren()) do
            onMonsterSpawned(child)
        end

        -- ====================================================================
        --         НАДЁЖНОЕ АВТОВОССТАНОВЛЕНИЕ СЕССИИ (БЕЗ КОНФЛИКТА С НАЖАТИЯМИ)
        -- ====================================================================
        task.spawn(function()
            local sessionPath = KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.SESSION_RESTORE_FILE
            if not isfile or not readfile or not isfile(sessionPath) then return end

            -- Сначала синхронизируем UI и функции сразу после загрузки меню
            if S.UI_STORAGE and S.UI_STORAGE.syncAll then
                pcall(S.UI_STORAGE.syncAll)
            end

            local char = player.Character or player.CharacterAdded:Wait()
            char:WaitForChild("HumanoidRootPart", 5)
            task.wait(0.25)

            -- Повторно синхронизируем текущие актуальные states (не перезаписывая их старым кэшем)
            if S.UI_STORAGE and S.UI_STORAGE.syncAll then
                pcall(S.UI_STORAGE.syncAll)
            end
            showNotification(getText("msgRestored"), "Success")
        end)

        -- ====================================================================
        --                  МОДАЛЬНОЕ ОКНО ЧЕНДЖЛОГА
        -- ====================================================================
        S.CachedChangelogData = nil
        S.ChangelogUI = {
            Overlay = nil, Card = nil, Title = nil,
            VersionBadge = nil, ListScroll = nil,
            ActionBtn = nil, ActionBtnText = nil
        }

        local function getLastSeenVersion()
            if not readfile or not isfile then return nil end
            local path = KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.VERSION_FILE
            local saved = nil
            pcall(function()
                if isfile(path) then saved = tostring(readfile(path)):gsub("%s+", "") end
            end)
            return saved
        end

        local function saveLastSeenVersion(ver)
            if not writefile then return end
            pcall(function()
                if makefolder and isfolder and not isfolder(KEY_CONFIG.FOLDER) then makefolder(KEY_CONFIG.FOLDER) end
                writefile(KEY_CONFIG.FOLDER .. "/" .. KEY_CONFIG.VERSION_FILE, tostring(ver))
            end)
        end

        local function buildChangelogModal()
            if S.ChangelogUI.Overlay then return end

            local cam = G.Services.Workspace.CurrentCamera or Camera
            local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
            local isSmall = vp.X < 700 or isTouchDevice
            local cardW = isSmall and G.Math.clamp(G.Math.floor(vp.X * 0.85), 290, 380) or 420
            local cardH = isSmall and G.Math.clamp(G.Math.floor(vp.Y * 0.70), 270, 360) or 370

            local overlay = create("TextButton", {
                Name = "ChangelogOverlay",
                Size = G.Math.ud2(1, 0, 1, 0),
                Position = G.Math.ud2(0, 0, 0, 0),
                BackgroundColor3 = G.Math.rgb(0, 0, 0),
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                Text = "",
                Visible = false,
                ZIndex = 60,
                Parent = S.ScreenGui
            })
            S.ChangelogUI.Overlay = overlay

            local card = create("Frame", {
                Name = "ChangelogCard",
                Size = G.Math.ud2(0, cardW, 0, cardH),
                Position = G.Math.ud2(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = HW.BG,
                ZIndex = 61,
                ClipsDescendants = true,
                Parent = overlay
            }, {
                cCorner(12),
                cStroke(HW.STROKE, 1.5)
            })
            S.ChangelogUI.Card = card
            makeDraggable(card)

            local topBar = create("Frame", {
                Size = G.Math.ud2(1, 0, 0, 42),
                BackgroundTransparency = 1,
                Parent = card,
                ZIndex = 62
            })

            S.ChangelogUI.Title = create("TextLabel", {
                Size = G.Math.ud2(0.65, 0, 1, 0),
                Position = G.Math.ud2(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = "CHANGELOG",
                TextColor3 = HW.ORANGE_SOFT,
                Font = Enum.Font.GothamBlack,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = topBar,
                ZIndex = 63
            })

            S.ChangelogUI.VersionBadge = create("TextLabel", {
                Size = G.Math.ud2(0, 65, 0, 20),
                Position = G.Math.ud2(1, -115, 0.5, -10),
                BackgroundColor3 = HW.PANEL_2,
                Text = "v1.0.0",
                TextColor3 = HW.ORANGE_SOFT,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                Parent = topBar,
                ZIndex = 63
            }, { cCorner(6), cStroke(HW.STROKE, 1) })

            local closeBtn = create("TextButton", {
                Size = G.Math.ud2(0, 26, 0, 26),
                Position = G.Math.ud2(1, -38, 0.5, -13),
                BackgroundColor3 = HW.PANEL_2,
                Text = "X",
                TextColor3 = HW.TEXT_DIM,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                AutoButtonColor = false,
                Parent = topBar,
                ZIndex = 63
            }, { cCorner(6), cStroke(HW.STROKE, 1) })

            local scroll = create("ScrollingFrame", {
                Size = G.Math.ud2(1, -24, 1, -100),
                Position = G.Math.ud2(0, 12, 0, 44),
                BackgroundColor3 = HW.BG_BOTTOM,
                ScrollBarThickness = 3,
                CanvasSize = G.Math.ud2(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Parent = card,
                ZIndex = 62
            }, {
                cCorner(8),
                cStroke(G.Math.rgb(40, 40, 50), 1),
                create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = G.Math.ud(0, 6)}),
                create("UIPadding", {PaddingTop = G.Math.ud(0, 8), PaddingBottom = G.Math.ud(0, 8), PaddingLeft = G.Math.ud(0, 8), PaddingRight = G.Math.ud(0, 8)})
            })
            S.ChangelogUI.ListScroll = scroll

            local bottomRow = create("Frame", {
                Size = G.Math.ud2(1, -24, 0, 36),
                Position = G.Math.ud2(0, 12, 1, -48),
                BackgroundTransparency = 1,
                Parent = card,
                ZIndex = 62
            })

            local actionBtn = create("TextButton", {
                Size = G.Math.ud2(1, 0, 1, 0),
                BackgroundColor3 = G.Math.rgb(32, 32, 42),
                AutoButtonColor = false,
                Text = "",
                Parent = bottomRow,
                ZIndex = 63
            }, { cCorner(8), cStroke(G.Math.rgb(60, 60, 75), 1.2) })
            S.ChangelogUI.ActionBtn = actionBtn

            S.ChangelogUI.ActionBtnText = create("TextLabel", {
                Size = G.Math.ud2(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "OK",
                TextColor3 = G.Math.rgb(255, 255, 255),
                Font = Enum.Font.GothamBlack,
                TextSize = 12,
                Parent = actionBtn,
                ZIndex = 64
            })

            local function hideModal()
                local tw = G.Services.TweenService:Create(overlay, G.Math.tw(0.18), {BackgroundTransparency = 1})
                G.Services.TweenService:Create(card, G.Math.tw(0.18), {Size = G.Math.ud2(0, cardW * 0.85, 0, cardH * 0.85)}):Play()
                tw:Play()
                tw.Completed:Connect(function() overlay.Visible = false end)
            end

            closeBtn.MouseButton1Click:Connect(hideModal)
            actionBtn.MouseButton1Click:Connect(hideModal)
        end

        S.RenderChangelogContent = function()
            if not S.CachedChangelogData or not S.ChangelogUI.Card then return end

            local data = S.CachedChangelogData
            local curLang = (states.language == "Russian") and "Russian" or "English"
            local langData = data[curLang] or data["English"] or {}

            if S.ChangelogUI.VersionBadge then
                S.ChangelogUI.VersionBadge.Text = tostring(data.version or "v1.0")
            end
            if S.ChangelogUI.Title then
                S.ChangelogUI.Title.Text = tostring(langData.title or ((curLang == "Russian") and "ЧТО НОВОГО" or "WHAT'S NEW"))
            end
            if S.ChangelogUI.ActionBtnText then
                S.ChangelogUI.ActionBtnText.Text = tostring(langData.button or ((curLang == "Russian") and "Понятно!" or "Got it!"))
            end

            if S.ChangelogUI.ListScroll then
                for _, child in ipairs(S.ChangelogUI.ListScroll:GetChildren()) do
                    if child:IsA("Frame") or child:IsA("TextLabel") then child:Destroy() end
                end

                local changes = langData.changes or {}
                for i = 1, #changes do
                    create("Frame", {
                        Size = G.Math.ud2(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = HW.PANEL,
                        Parent = S.ChangelogUI.ListScroll,
                        ZIndex = 63
                    }, {
                        cCorner(6),
                        create("UIPadding", {PaddingTop = G.Math.ud(0, 6), PaddingBottom = G.Math.ud(0, 6), PaddingLeft = G.Math.ud(0, 8), PaddingRight = G.Math.ud(0, 8)}),
                        create("TextLabel", {
                            Size = G.Math.ud2(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundTransparency = 1,
                            Text = tostring(changes[i]),
                            TextColor3 = HW.TEXT,
                            Font = Enum.Font.GothamMedium,
                            TextSize = 11,
                            TextWrapped = true,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 64
                        })
                    })
                end
            end
        end

        S.ShowChangelogModal = function()
            buildChangelogModal()
            S.RenderChangelogContent()

            S.ChangelogUI.Overlay.Visible = true
            S.ChangelogUI.Overlay.BackgroundTransparency = 1

            local cam = G.Services.Workspace.CurrentCamera or Camera
            local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
            local isSmall = vp.X < 700 or isTouchDevice
            local cardW = isSmall and G.Math.clamp(G.Math.floor(vp.X * 0.85), 290, 380) or 420
            local cardH = isSmall and G.Math.clamp(G.Math.floor(vp.Y * 0.70), 270, 360) or 370

            S.ChangelogUI.Card.Size = G.Math.ud2(0, cardW * 0.8, 0, cardH * 0.8)
            G.Services.TweenService:Create(S.ChangelogUI.Overlay, G.Math.tw(0.25), {BackgroundTransparency = 0.5}):Play()
            G.Services.TweenService:Create(S.ChangelogUI.Card, G.Math.tw(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = G.Math.ud2(0, cardW, 0, cardH)}):Play()
        end

        task.spawn(function()
            local rawJson = nil
            local antiCacheChangelog = CHANGELOG_URL .. "?t=" .. tostring(tick()) .. "_" .. tostring(math.random(100, 999))
            pcall(function()
                if game.HttpGet then rawJson = game:HttpGet(antiCacheChangelog) end
            end)
            if not rawJson then
                local req = (syn and syn.request) or request or http_request or (http and http.request)
                if req then
                    pcall(function()
                        local r = req({Url = antiCacheChangelog, Method = "GET", Headers = {["Cache-Control"] = "no-cache"}})
                        if type(r) == "table" and r.Body and r.Body ~= "" then rawJson = r.Body end
                    end)
                end
            end

            if rawJson and rawJson ~= "" then
                local ok, parsed = pcall(function() return G.Services.HttpService:JSONDecode(rawJson) end)
                if ok and type(parsed) == "table" then
                    S.CachedChangelogData = parsed
                    local currentVersion = tostring(parsed.version or "v1.0.0"):gsub("%s+", "")
                    local lastSeenVersion = getLastSeenVersion() or getgenv()._HUB_LAST_SEEN_VERSION

                    if lastSeenVersion ~= currentVersion then
                        task.wait(1.0)
                        S.ShowChangelogModal()
                        saveLastSeenVersion(currentVersion)
                        getgenv()._HUB_LAST_SEEN_VERSION = currentVersion
                    end
                end
            end
        end)

        S.scanRooms()
        S_CONTEXT = S
        
        -- ====================================================================
        --                  ФУНКЦИЯ ВЫГРУЗКИ СКРИПТА (UNLOAD)
        -- ====================================================================
        getgenv()._HUBHUBHUB_ACTIVE = {
            unload = function()
                pcall(function()
                    S.Runtime.running = false

                    pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_ThirdPersonHook") end)
                    pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_StopCamProbe") end)
                    pcall(function() G.Services.RunService:UnbindFromRenderStep("DOORS_NoCamShake") end)
                    states.autoRooms = false
                    if S.Runtime.autoRoomsThread then task.cancel(S.Runtime.autoRoomsThread) end
                    if S.RestoreCharacterTransparency then S.RestoreCharacterTransparency(player.Character) end
                    if S.RestoreCharacterNormalState then pcall(S.RestoreCharacterNormalState, player.Character) end

                    local cam = G.Services.Workspace.CurrentCamera or Camera
                    if cam then
                        local baseRig = cam:FindFirstChild("BaseRig")
                        if baseRig then
                            for _, part in ipairs(baseRig:GetDescendants()) do
                                if part:IsA("BasePart") or part:IsA("Decal") then
                                    pcall(function() part.LocalTransparencyModifier = 0 end)
                                end
                            end
                        end
                    end

                    if getgenv()._HUBHUBHUB_RESTORE_NC then
                        getgenv()._HUBHUBHUB_RESTORE_NC()
                    end

                    S.ScreenGui:Destroy()
                    if NotificationGui then NotificationGui:Destroy() end
                    for _, conn in ipairs(S.Runtime.connections) do if conn.Connected then conn:Disconnect() end end
                    table.clear(S.Runtime.connections)
                end)
            end
        }

        print("HubHubHub Loaded Successfully (Modern Monochrome Edition)!") 
        showNotification(string.format(getText("tipToggle"), states.menuKey), "Info")
        task.spawn(function()
            local execName = ""
            pcall(function()
                if typeof(identifyexecutor) == "function" then
                    execName = identifyexecutor()
                elseif typeof(getexecutorname) == "function" then
                    execName = getexecutorname()
                end
            end)

            execName = tostring(execName):lower()

            if execName:find("xeno") then
                task.wait(1.2)
                showNotification("bro your executor is shit", "error", "About your executor", 4.5)
                task.wait(1.8)
                showNotification("go get better executor like real or at least solara", "Error", "About your executor", 5.5)
            end
        end)
    end

    local ok, loadErr = pcall(LoadMainScript)
    if not ok then
        warn("[HubHubHub Load Error]: " .. tostring(loadErr))
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "HubHubHub Error",
                Text = "Error: " .. tostring(loadErr):sub(1, 80),
                Duration = 10
            })
        end)
    end
