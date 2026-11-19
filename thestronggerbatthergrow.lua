do
if not MV_OBFUSCATED then
    MV_OMIT = function(fn) return fn end
    MV_CFF = function(fn) return fn end
end

TweenService = game:GetService("TweenService")
CoreGui = game:GetService("CoreGui")

function applyVexonStyle(obj, isMain)
    obj.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    local corner = Instance.new("UICorner", obj)
    corner.CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", obj)
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(170, 0, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local glowGradient = Instance.new("UIGradient", stroke)
    glowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
    }
    
    if isMain then
        stroke.Transparency = 0.1
    else
        stroke.Transparency = 0.4
    end
end

function checkExecutorSupport()
    local executorName = (_G.VexonHub and _G.VexonHub.SystemInfo and _G.VexonHub.SystemInfo.Executor) or "Unknown"
    local executorScore = (_G.VexonHub and _G.VexonHub.ExecutorScore) or { unc = 0, sunc = 0, total = 0, supported = false }
    totalSupport = executorScore.total
    isSupported = executorScore.supported
    unc_support = executorScore.unc
    sunc_support = executorScore.sunc
    return {
        supported = isSupported,
        unc = unc_support,
        sunc = sunc_support
    }
end

function StartNormalVersion()



repeat task.wait() until game:IsLoaded();


workspace:SetAttribute("VIPServer", true)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/WindUI"))()
        

WindUI:AddTheme({ Name = "Dark",     Accent = "#18181b", Dialog = "#18181b", Outline = "#FFFFFF", Text = "#FFFFFF", Placeholder = "#999999", Background = "#0e0e10", Button = "#52525b", Icon = "#a1a1aa",})
WindUI:AddTheme({ Name = "Light",    Accent = "#f4f4f5", Dialog = "#f4f4f5", Outline = "#000000", Text = "#000000", Placeholder = "#666666", Background = "#ffffff", Button = "#e4e4e7", Icon = "#52525b",})
WindUI:AddTheme({ Name = "Gray",     Accent = "#374151", Dialog = "#374151", Outline = "#d1d5db", Text = "#f9fafb", Placeholder = "#9ca3af", Background = "#1f2937", Button = "#4b5563", Icon = "#d1d5db",})
WindUI:AddTheme({ Name = "Blue",     Accent = "#1e40af", Dialog = "#1e3a8a", Outline = "#93c5fd", Text = "#f0f9ff", Placeholder = "#60a5fa", Background = "#1e293b", Button = "#3b82f6", Icon = "#93c5fd",})
WindUI:AddTheme({ Name = "Green",    Accent = "#059669", Dialog = "#047857", Outline = "#6ee7b7", Text = "#ecfdf5", Placeholder = "#34d399", Background = "#064e3b", Button = "#10b981", Icon = "#6ee7b7",})
WindUI:AddTheme({ Name = "Purple",   Accent = "#a855f7", Dialog = "#1e1b4b", Outline = "#4c1d95", Text = "#f5f3ff", Placeholder = "#7c3aed", Background = "#0f172a", Button = "#6d28d9", Icon = "#d8b4fe",})
WindUI:AddTheme({ Name = "Premium",  Accent = "#a41be9", Dialog = "#6bff30", Outline = "#ecbf0a", Text = "#ffffff", Placeholder = "#30ff6a", Background = "#0a0a0a", Button = "#a20feb", Icon = "#30ff6a",})
WindUI:AddTheme({ Name = "Sunset",   Accent = "#ff6b35", Dialog = "#f7931e", Outline = "#ffa630", Text = "#ffffff", Placeholder = "#ffb84d", Background = "#1a0f0a", Button = "#ff8c42", Icon = "#ffa630",})
WindUI:AddTheme({ Name = "Cyberpunk",Accent = "#00ff88", Dialog = "#1a1a2e", Outline = "#ff006e", Text = "#00ff88", Placeholder = "#00d4ff", Background = "#0f0f1e", Button = "#ff006e", Icon = "#00d4ff",})
WindUI:AddTheme({ Name = "Retro",    Accent = "#ff1654", Dialog = "#2a2a3e", Outline = "#ffd60a", Text = "#fffacd", Placeholder = "#ffa500", Background = "#1a1a2e", Button = "#ff006e", Icon = "#ffd60a",})
WindUI:AddTheme({ Name = "Ocean",    Accent = "#0369a1", Dialog = "#082f49", Outline = "#7dd3fc", Text = "#e0f2fe", Placeholder = "#38bdf8", Background = "#0c2d42", Button = "#0284c7", Icon = "#38bdf8",})
WindUI:AddTheme({ Name = "Forest",   Accent = "#15803d", Dialog = "#1b4332", Outline = "#84cc16", Text = "#f0fdf4", Placeholder = "#4ade80", Background = "#0b3d1f", Button = "#22c55e", Icon = "#84cc16",})
WindUI:AddTheme({ Name = "Desert",   Accent = "#d97706", Dialog = "#78350f", Outline = "#fcd34d", Text = "#fffbeb", Placeholder = "#fbbf24", Background = "#451a03", Button = "#f59e0b", Icon = "#fcd34d",})
WindUI:AddTheme({ Name = "Candy",    Accent = "#ec4899", Dialog = "#831843", Outline = "#f472b6", Text = "#fce7f3", Placeholder = "#f472b6", Background = "#500724", Button = "#db2777", Icon = "#fbcfe8",})
WindUI:AddTheme({ Name = "Gold",     Accent = "#ca8a04", Dialog = "#422006", Outline = "#fde047", Text = "#fefce8", Placeholder = "#facc15", Background = "#1c1502", Button = "#eab308", Icon = "#fde047",})
WindUI:AddTheme({ Name = "Coffee",   Accent = "#78350f", Dialog = "#2c1810", Outline = "#d97706", Text = "#fef3c7", Placeholder = "#b45309", Background = "#1c1006", Button = "#92400e", Icon = "#d97706",})
WindUI:AddTheme({ Name = "Neon",     Accent = "#d946ef", Dialog = "#1a0a1f", Outline = "#f0abfc", Text = "#fdf4ff", Placeholder = "#e879f9", Background = "#0d0410", Button = "#c026d3", Icon = "#f0abfc",})
WindUI:AddTheme({ Name = "Rose",     Accent = "#e11d48", Dialog = "#881337", Outline = "#fb7185", Text = "#fff1f2", Placeholder = "#fda4af", Background = "#4c0519", Button = "#e11d48", Icon = "#fb7185",})
WindUI:AddTheme({ Name = "Rainbow",  Accent = "#ff0080", Dialog = "#1a0033", Outline = "#00f0ff", Text = "#ffffff", Placeholder = "#ffea00", Background = "#0d001a", Button = "#8000ff", Icon = "#39ff14",})

WindUI:SetNotificationLower(true)


HttpService = game:GetService("HttpService")
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")
Workspace = game:GetService("Workspace")
Camera = Workspace.CurrentCamera
StarterGui = game:GetService("StarterGui")
plr = LocalPlayer
character = plr.Character or plr.CharacterAdded:Wait()
humanoid = character:WaitForChild("Humanoid")
humanoidRootPart = character:WaitForChild("HumanoidRootPart")


PremiumStatus = (_G.VexonHub and _G.VexonHub.Whitelist and _G.VexonHub.Whitelist.status) or false
LockedStatus = not PremiumStatus

print("[VexonHub Debug] _G.VexonHub:", _G.VexonHub)
print("[VexonHub Debug] _G.VexonHub.Whitelist:", _G.VexonHub and _G.VexonHub.Whitelist)
print("[VexonHub Debug] _G.VexonHub.Whitelist.status:", _G.VexonHub and _G.VexonHub.Whitelist and _G.VexonHub.Whitelist.status)
print("[VexonHub Debug] PremiumStatus:", PremiumStatus)
print("[VexonHub Debug] LockedStatus:", LockedStatus)

if PremiumStatus then
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Premium Verified",
            Text = "Welcome back! All features unlocked.",
            Icon = "http://www.roblox.com/asset/?id=84519376661277",
            Duration = 3
        })
    end)
else
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Normal User",
            Text = "Premium features locked. Upgrade to unlock all features.",
            Icon = "http://www.roblox.com/asset/?id=84519376661277",
            Duration = 3
        })
    end)
end

themes = {"Purple", "Dark", "Light", "Gray", "Blue", "Green", "Premium", "Sunset", "Cyberpunk", "Retro", "Ocean", "Forest", "Desert", "Candy", "Gold", "Coffee", "Neon", "Rose", "Rainbow"}
currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end
function LoadVexonHub()
success, err = pcall(function()
    Window = WindUI:CreateWindow({
        Title = "VexonHub",
        Icon = "rbxassetid://84519376661277", 
        Author = "The Strongest Battle Grounds",
        Folder = "vexonhub",
        Size = UDim2.fromOffset(600, 380),
        Transparent = getgenv().TransparencyEnabled,
        Theme = PremiumStatus and "Premium" or "Purple",
        Background = "rbxassetid://121001800448860",
        Resizable = true,
        NewElements = true,
        CornerRadius = UDim.new(0, 0),
        SideBarWidth = 210,
        BackgroundImageTransparency = 0.9,
        HideSearchBar = false,
        ScrollBarEnabled = true,
        User = {
            Enabled = true,
            Anonymous = false,
            Callback = function()
               if Anonymous == false then
	               Anonymous = true
	               Window.User:SetAnonymous(true)
               else
	               Anonymous = false
	               Window.User:SetAnonymous(false)
               end
            end,
        },
        
        Watermark = {
	        Enabled = true,
	        Text = "Made by MsVexon and Renji",
	        Position = "bottom-right",
	        Opacity = 0.5,
	        Size = 14
	    },
    })
end)
if not success then
    warn("Failed to create window:", err)
end

if not Window then
    game.StarterGui:SetCore("SendNotification", {
        Title = "VexonHub Error",
        Text = "Failed to create window interface",
        Duration = 10
    })
    return
end


if PremiumStatus then
    Window:Tag({
        Title = "Premium",
        Icon = "crown",
        Color = Color3.fromHex("#f3eb05"),
        Radius = 4,
    })
else
    Window:Tag({
        Title = "Free",
        Icon = "users",
        Color = Color3.fromHex("#6b7280"),
        Radius = 4,
    })
end

pcall(function()
    Window:CreateTopbarButton("TransparencyToggle", "eye", function()
        if getgenv().TransparencyEnabled then
            getgenv().TransparencyEnabled = false
            pcall(function() Window:ToggleTransparency(false) end)
            
            WindUI:Notify({
                Title = "Transparency", 
                Content = "Transparency disabled",
                Duration = 3,
                Icon = "eye"
            })
            print("Transparency = false")
        else
            getgenv().TransparencyEnabled = true
            pcall(function() Window:ToggleTransparency(true) end)
            
            WindUI:Notify({
                Title = "Transparency",
                Content = "Transparency enabled", 
                Duration = 3,
                Icon = "eye-off"
            })
            print(" Transparency = true")
        end
    end, 990)
end)

Window:EditOpenButton({
    Title = "VexonHub",
    OnlyMobile = false,
    Scale = 0.9,
	CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(64, 00, 64), Color3.fromRGB(128, 0, 255)),
    Draggable = true,
    Position = UDim2.new(0, 120, 0, 120),
    Enabled = true,
    OnlyMobile = false,
})







Tabs = {}

local tabList = {
    { key = "Main",     title = "Main",          icon = "house",              desc = "All Main Features",                    func = MainTab        },
    { key = "Misc",     title = "Misc",          icon = "sparkles",           desc = "Scripts for easy to use it",           func = MiscTab        },
    { key = "Bring",    title = "Bring",         icon = "arrow-down-to-line", desc = "By thatonedudetsts",                   func = BringTab       },
    { key = "Attach",   title = "Attach",        icon = "paperclip",          desc = "By TheBiggestRteHater",                func = AttachTab      },
    { key = "Fight",    title = "Fighting",      icon = "sword",              desc = "Many Things for fighting and farms",   func = FightTab       },
    { key = "Farm",     title = "Farming",       icon = "bot",                desc = "Auto farm kill etc.",                  func = FarmTab        },
    { key = "Dodge",    title = "Auto Dodge",    icon = "eye",                desc = "Made By Abdul",                        func = DodgeTab       },
    { key = "Tech",     title = "Tech",          icon = "wrench",             desc = "Skill Issue",                          func = TechTab        },
    { key = "Lag",      title = "Lag-Ping",      icon = "leaf",               desc = "Use for less lag",                     func = LagTab         },
    { key = "Anim",     title = "Animations",    icon = "package",            desc = "Play/Stop animations",                 func = AnimationTab   },
    { key = "Disguise", title = "Disguise",      icon = "hat-glasses",        desc = "Change your character on client side", func = DisguiseTab    },
    { key = "Place",    title = "Teleport",      icon = "map",                desc = "Teleport to places",                   func = TeleportTab    },
    { key = "ESP",      title = "ESP",           icon = "atom",               desc = "ESP players",                          func = EspTab         },
    { key = "Moveset",  title = "Moveset",       icon = "star",               desc = "Character Movesets",                   func = MovesetTab     },
    { key = "Fling",    title = "Fling",         icon = "user",               desc = "Fling Players. Buggy",                 func = FlingTab       },
    { key = "AntiBan",  title = "Anti Ban",      icon = "shield",             desc = "Made By Abdul",                        func = AntiBanTab     },
    { key = "Tools",    title = "Tools",         icon = "pencil",             desc = "Many costum tools",                    func = ToolsTab       },
    { key = "Block",    title = "Defence",       icon = "shield",             desc = "Made By Abdul",                        func = BlockTab       },
    { key = "Emote",    title = "Limited Emote", icon = "party-popper",       desc = "You can buy limited emotes with this", func = EmoteTab       },
    { key = "Prem",     title = "Premium",       icon = "crown",              desc = "Information of Premium",               func = PremiumTab     },
}


local loadedTabsMap = {}
local loadButtons = {}

Window:SideBarButton({
    Title = "Load All Tabs",
    Variant = "Secondary",
    Callback = function()
        local loadedCount = 0

        for _, tabData in ipairs(tabList) do
            if not loadedTabsMap[tabData.key] then
                loadedTabsMap[tabData.key] = true
                loadedCount = loadedCount + 1

                local btn = loadButtons[tabData.key]
                if btn then
                    btn:Destroy()
                end

                task.spawn(tabData.func)
            end
        end

        if loadedCount == 0 then
            WindUI:Notify({
                Title = "Error",
                Content = "All tabs are already loaded.",
                Icon = "x",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Tabs Loaded",
                Content = loadedCount .. " new tabs loaded successfully.",
                Icon = "check",
                Duration = 3
            })
        end
    end
})



Tabs.Info = Window:Tab({ Title = "Information", Icon = "badge-info", Desc = "Information of VexonHub" })
Tabs.UI = Window:Tab({ Title = "UI", Icon = "layout-template", Desc = "UI of VexonHub" })
Tabs.Config = Window:Tab({ Title = "Config", Icon = "file-cog", Desc = "Save your config and reuse it later" })



Window:SelectTab(1)
InfoTab()
UiTab()
ConfigTab()


Window:Divider()

local loadedTabsMap = {}

for _, tabData in ipairs(tabList) do
    Tabs[tabData.key] = Window:Tab({ 
        Title = tabData.title, 
        Icon = tabData.icon, 
        Desc = tabData.desc,
        ShowTabTitle = true,
        Border = true
    })

    local loadBtn
    loadBtn = Tabs[tabData.key]:Button({
        Title = "CLICK ME TO LOAD " .. string.upper(tabData.title),
        Icon = "play",
        Justify = "Center",
        Callback = function()
            if loadedTabsMap[tabData.key] then
                return
            end

            loadedTabsMap[tabData.key] = true

            if loadBtn then
                loadBtn:Destroy()
            end

            task.spawn(tabData.func)
        end
    })

    loadButtons[tabData.key] = loadBtn
end







end






task.spawn(function()
	function createCirclePart(radius, thickness, position, transparency)
	    local part = Instance.new("Part")
	    part.Shape = Enum.PartType.Cylinder
	    part.Size = Vector3.new(thickness, radius * 2, radius * 2)
	    part.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))
	    part.Anchored = true
	    part.Transparency = transparency
	    part.CanCollide = true
	    part.CastShadow = false
	    part.Color = Color3.new(0, 0, 0)
	    part.Parent = game.Workspace
	    return part
	end
	
	createCirclePart(100000, 0.5, Vector3.new(0, -500, 0), 0.5)
	createCirclePart(150, 0.5, Vector3.new(-68, 0, 20354), 0.5)
	createCirclePart(25, 1, Vector3.new(150, 500, 30), 0.5)
	createCirclePart(40, 0.5, Vector3.new(150, 700, 30), 0.5)
	createCirclePart(25, 1, Vector3.new(0, -2, 0), 0.5)
	createCirclePart(100000, 1, Vector3.new(30000000, 29999995, 30000000), 1)
	createCirclePart(50, 1, Vector3.new(1063, 129, 23006), 0.5)
	createCirclePart(25, 1, Vector3.new(0 ,900000000000 ,0), 0)
	createCirclePart(7, 0.5, Vector3.new(1000, -500, 1000), 0.7)
	createCirclePart(25, 1, Vector3.new(38.473, 87795.758, 32.568), 0.5)
end)






-- ================ INFO0 TAB0 ================ --
function InfoTab()
    task.spawn(function()
        local httpService = game:GetService("HttpService")
        local executorDatabase = {
            volt = {name = "Volt", image = "rbxassetid://94281500370891"},
            seliware = {name = "Seliware", image = "rbxassetid://90446163651777"},
            xeno = {name = "Xeno", image = "rbxassetid://116478595452390"},
            solara = {name = "Solara", image = "rbxassetid://137236509333725"},
            volcano = {name = "Volcano", image = "rbxassetid://110816441537122"},
            potassium = {name = "Potassium", image = "rbxassetid://131063900553703"},
            wave = {name = "Wave", image = "rbxassetid://75669327330829"},
            cryptic = {name = "Cryptic", image = "rbxassetid://123321823959680"},
            bunni = {name = "Bunni", image = "rbxassetid://81202073828926"},
            velocity = {name = "Velocity", image = "rbxassetid://118392657071548"},
            sirhurt = {name = "Sirhurt", image = "rbxassetid://93977798822781"},
            delta = {name = "Delta", image = "rbxassetid://119096676513948"},
            vega = {name = "Vega X", image = "rbxassetid://110437194711626"},
            codex = {name = "Codex", image = "rbxassetid://72922437112238"},
            arceux = {name = "Arceus X", image = "rbxassetid://109544343258817"},
            arceus = {name = "Arceus X", image = "rbxassetid://109544343258817"},
        }
        local inviteCode = "vexonhub"
        local discordApiUrl = "https://discord.com/api/v10/invites/" .. inviteCode .. "?with_counts=true&with_expiration=true"
        local webhookUrl = "https://discord.com/api/webhooks/1484751913235775519/W4B2-ACuEuNh2btxHl3MXd7hYwIb3CJunl6vmzkbCrRsEPPb9i5KnxnLKNST2GCUxSxX"
        local feedbackState = {
            type = "Feedback",
            message = "",
        }

        local function makeGradientText(text, startColor, endColor)
            local result = ""
            local length = #text
            for index = 1, length do
                local progress = (index - 1) / math.max(length - 1, 1)
                local red = math.floor((startColor.R + (endColor.R - startColor.R) * progress) * 255)
                local green = math.floor((startColor.G + (endColor.G - startColor.G) * progress) * 255)
                local blue = math.floor((startColor.B + (endColor.B - startColor.B) * progress) * 255)
                local char = text:sub(index, index)
                result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', red, green, blue, char)
            end
            return result
        end

        local function checkExecutorSupport()
            local executorName = (identifyexecutor and identifyexecutor()) or "Unknown"
            local uncFunctionNames = {
                "readfile", "writefile", "appendfile", "isfile", "isfolder", "makefolder",
                "delfolder", "delfile", "listfiles", "loadstring", "getscriptbytecode",
                "getscripthash", "getnamecallmethod", "getcallingscript", "checkcaller",
                "hookfunction", "hookmetamethod", "newcclosure", "gethiddenproperty",
                "sethiddenproperty", "gethui", "getconnections", "Drawing", "cleardrawcache",
                "setclipboard", "request", "http_request", "getloadedmodules", "getcustomasset",
                "fireclickdetector", "firetouchinterest", "fireproximityprompt",
            }
            local sUncFunctionNames = {
                "getgenv", "getrenv", "getsenv", "getrawmetatable", "setreadonly", "isreadonly",
                "islclosure", "iscclosure", "isexecutorclosure", "checkcaller", "cloneref",
                "compareinstances", "hookmetamethod", "getnamecallmethod", "hookfunction",
                "newcclosure", "getconnections", "firesignal", "getcallbackvalue", "getproperties",
                "gethiddenproperty", "sethiddenproperty", "gethui", "getinstances", "getnilinstances",
                "getscripts", "getrunningscripts", "getloadedmodules", "getconstants", "getconstant",
                "setconstant", "getupvalues", "getupvalue", "setupvalue", "getprotos",
                "debug.getupvalues", "debug.setupvalue",
            }

            local uncSupportedCount = 0
            for _, name in ipairs(uncFunctionNames) do
                if (getgenv and getgenv()[name]) or (type(_G) == "table" and _G[name]) then
                    uncSupportedCount = uncSupportedCount + 1
                end
            end
            local uncSupportPercent = math.floor((uncSupportedCount / #uncFunctionNames) * 100)

            local sUncSupportedCount = 0
            for _, name in ipairs(sUncFunctionNames) do
                local found = false
                if (getgenv and getgenv()[name]) or (type(_G) == "table" and _G[name]) then
                    found = true
                elseif name:match("^debug%.") then
                    local debugFunc = name:gsub("^debug%.", "")
                    if debug and debug[debugFunc] then found = true end
                end
                if found then sUncSupportedCount = sUncSupportedCount + 1 end
            end
            local sUncSupportPercent = math.floor((sUncSupportedCount / #sUncFunctionNames) * 100)

            local detectedName = executorName:lower()
            local matchedData = nil
            for key, data in pairs(executorDatabase) do
                if detectedName:match(key) then
                    matchedData = data
                    break
                end
            end

            local overallSupportPercent = (uncSupportPercent + sUncSupportPercent) / 2
            local imageId = matchedData and matchedData.image or "info"
            local titleText, descriptionText, isSupported
            local displayName = matchedData and matchedData.name or executorName

            if overallSupportPercent >= 90 then
                isSupported = true
                titleText = displayName .. ' is <font color="#00FF00">supported</font> by VexonHub'
                descriptionText = "Your executor is strong enough to handle this script"
            else
                isSupported = false
                titleText = displayName .. ' is <font color="#FF0000">NOT fully supported</font> by VexonHub'
                descriptionText = "Your executor may not support all features (UNC: " .. uncSupportPercent .. "% | SUNC: " .. sUncSupportPercent .. "%)"
            end

            return {
                image = imageId,
                title = titleText,
                desc = descriptionText,
                supported = isSupported,
            }
        end

        local executorInfo = checkExecutorSupport()
        local coloredDescription = executorInfo.supported and ('<font color="#7CFF7C">' .. executorInfo.desc .. '</font>') or ('<font color="#FF5C5C">' .. executorInfo.desc .. '</font>')


        Tabs.Info:Paragraph({
            Title = executorInfo.title,
            Desc = coloredDescription,
            Image = executorInfo.image,
            ImageSize = 40,
        })

        local discordResponse, discordError = nil, nil
        xpcall(function()
            discordResponse = httpService:JSONDecode(request({
                Url = discordApiUrl,
                Method = "GET",
                Headers = { Accept = "application/json" },
            }).Body)
        end, function(err)
            warn("Error fetching Discord info: " .. tostring(err))
            discordError = tostring(err)
        end)

        if discordResponse and discordResponse.guild then
            local paragraphConfig = {
                Title = discordResponse.guild.name,
                Desc = ' <font color="#52525b">\u{2022}</font> Member Count: ' .. tostring(discordResponse.approximate_member_count) .. '\n <font color="#16a34a">\u{2022}</font> Online Count: ' .. tostring(discordResponse.approximate_presence_count),
                Image = "",
                ImageSize = 0,
                Buttons = {{
                    Icon = "link",
                    Title = "Copy Discord Invite",
                    Color = Color3.fromHex("#B22222"),
                    Callback = function()
                        pcall(function() setclipboard("https://discord.gg/" .. inviteCode) end)
                    end,
                }},
            }
            if discordResponse.guild.banner then
                paragraphConfig.Thumbnail = "https://cdn.discordapp.com/banners/" .. discordResponse.guild.id .. "/" .. discordResponse.guild.banner .. ".png?size=256"
                paragraphConfig.ThumbnailSize = 120
            end
            Tabs.Info:Paragraph(paragraphConfig)
        else
            Tabs.Info:Paragraph({
                Title = "Error fetching Discord server info",
                Desc = discordError or "Unknown error occurred",
                Image = "triangle-alert",
                ImageSize = 26,
                Color = "Red",
            })
        end

    end)
end





function UiTab()
    task.spawn(function()
	    local WindowKeybindSec = Tabs.UI:Section({Opened = true, Box = true, BoxBorder = true, Title = "Window", Icon = "app-window"})
		
		local UserInputService = game:GetService("UserInputService")
		local currentToggleKey = Enum.KeyCode.RightShift -- Varsayılan tuşumuz
		
		UserInputService.InputBegan:Connect(function(input)
		    if input.KeyCode == currentToggleKey then
		        if UserInputService:GetFocusedTextBox() == nil then
		            Window:Toggle()
		        end
		    end
		end)
		
		local menuKeybind = WindowKeybindSec:Keybind({
		    Title = "Select Menu Toggle Key",
		    Desc = "Click here and press a key, then click Apply",
		    Value = "RightShift",
		    CanChange = true,
		    Callback = function(keyName)
		    end
		})
		
		WindowKeybindSec:Button({
		    Title = "Apply Toggle Key",
		    Icon = "check",
		    Justify = "Center",
		    Callback = function()
		        local newKeyString = menuKeybind.Value
		        
		        local success, keyEnum = pcall(function()
		            return Enum.KeyCode[newKeyString]
		        end)
		
		        if success and keyEnum then
		            currentToggleKey = keyEnum -- Yeni tuşu sisteme kaydediyoruz
		            WindUI:Notify({
		                Title = "Keybind Applied",
		                Content = "Menu toggle key is now: " .. newKeyString,
		                Icon = "keyboard",
		                Duration = 3
		            })
		        else
		            WindUI:Notify({
		                Title = "Error",
		                Content = "Invalid key selected!",
		                Icon = "x",
		                Duration = 3
		            })
		        end
		    end
		})

    
	    local UiThemeSec = Tabs.UI:Section({Opened = true, Box = true, BoxBorder = true, Title = "Theme", Icon = "paintbrush"})
	    
		local selectedTheme = themes[1]
		
		SelectUiTheme = UiThemeSec:Dropdown({
		    Title = "Select Theme",
		    Desc = "Choose a UI theme from the list",
		    Values = themes,
		    Value = selectedTheme,
		    Callback = function(value)
		        selectedTheme = value
		    end
		})
		
		UiThemeSec:Button({
		    Title = "Apply Selected Theme",
		    Icon = "palette",
		    Justify = "Center",
		    Callback = function()
		        WindUI:SetTheme(selectedTheme)
		        
		        WindUI:Notify({
		            Title = "Theme Changed",
		            Content = "Switched to " .. selectedTheme .. " theme!",
		            Duration = 2,
		            Icon = "palette"
		        })
		    end
		})
		
		UiThemeSec:Button({
		    Title = "Apply Random Theme",
		    Icon = "shuffle",
		    Justify = "Center",
		    Callback = function()
		        local randomIndex = math.random(1, #themes)
		        local randomTheme = themes[randomIndex]
		        
		        selectedTheme = randomTheme
		        SelectUiTheme:Select(randomTheme)
		        WindUI:SetTheme(randomTheme)
		        
		        WindUI:Notify({
		            Title = "Random Theme Applied",
		            Content = "Switched to " .. randomTheme .. " theme!",
		            Duration = 2,
		            Icon = "palette"
		        })
		    end
		})
		
		UiThemeSec:Divider()
		
		
		

		local customThemeName = "Custom Theme"
		
		local themeColors = {
		    Accent = Color3.fromRGB(0, 0, 0),
		    Dialog = Color3.fromRGB(0, 0, 0),
		    Outline = Color3.fromRGB(0, 0, 0),
		    Text = Color3.fromRGB(0, 0, 0),
		    Placeholder = Color3.fromRGB(0, 0, 0),
		    Background = Color3.fromRGB(0, 0, 0),
		    Button = Color3.fromRGB(0, 0, 0),
		    Icon = Color3.fromRGB(0, 0, 0)
		}
		
		local function colorToHex(c)
		    return string.format("#%02X%02X%02X", math.round(c.R * 255), math.round(c.G * 255), math.round(c.B * 255))
		end
		
		UiThemeSec:Input({
		    Title = "Theme Name",
		    Placeholder = "Type theme name...",
		    Value = customThemeName,
		    Callback = function(text)
		        customThemeName = text
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Accent Color",
		    Default = themeColors.Accent,
		    Callback = function(color)
		        themeColors.Accent = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Dialog Color",
		    Default = themeColors.Dialog,
		    Callback = function(color)
		        themeColors.Dialog = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Outline Color",
		    Default = themeColors.Outline,
		    Callback = function(color)
		        themeColors.Outline = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Text Color",
		    Default = themeColors.Text,
		    Callback = function(color)
		        themeColors.Text = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Placeholder Color",
		    Default = themeColors.Placeholder,
		    Callback = function(color)
		        themeColors.Placeholder = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Background Color",
		    Default = themeColors.Background,
		    Callback = function(color)
		        themeColors.Background = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Button Color",
		    Default = themeColors.Button,
		    Callback = function(color)
		        themeColors.Button = color
		    end
		})
		
		UiThemeSec:Colorpicker({
		    Title = "Icon Color",
		    Default = themeColors.Icon,
		    Callback = function(color)
		        themeColors.Icon = color
		    end
		})
		
		UiThemeSec:Button({
		    Title = "Apply Custom Theme",
		    Icon = "check",
		    Callback = function()
		        WindUI:AddTheme({
		            Name = customThemeName,
		            Accent = colorToHex(themeColors.Accent),
		            Dialog = colorToHex(themeColors.Dialog),
		            Outline = colorToHex(themeColors.Outline),
		            Text = colorToHex(themeColors.Text),
		            Placeholder = colorToHex(themeColors.Placeholder),
		            Background = colorToHex(themeColors.Background),
		            Button = colorToHex(themeColors.Button),
		            Icon = colorToHex(themeColors.Icon)
		        })
		        
		        WindUI:SetTheme(customThemeName)
		        
		        WindUI:Notify({
		            Title = "Theme Applied",
		            Content = "Custom theme activated.",
		            Icon = "palette",
		            Duration = 3
		        })
		    end
		})
	end)
end







-- ================ MAIN0 TAB0 ================ --
function MainTab()
    task.spawn(function()
	    do
	        local Players = game:GetService("Players")
	        local RunService = game:GetService("RunService")
	        local VirtualInputManager = game:GetService("VirtualInputManager")
	        local UserInputService = game:GetService("UserInputService")
	        local ReplicatedStorage = game:GetService("ReplicatedStorage")
	        local PhysicsService = game:GetService("PhysicsService")
	        local Debris = game:GetService("Debris")
	        local TeleportService = game:GetService("TeleportService")
	        local StarterGui = game:GetService("StarterGui")
	        local Workspace = game.Workspace
	        local LocalPlayer = Players.LocalPlayer
	
	        local teleportPosition = Vector3.new(150, -495, 30)
	        local autoVoidEnabled = false
	        local isAnimationPlaying = false
	        local tpBackEnabled = false
	        local autoWhirlwindEnabled = false
	        local autoWallComboEnabled = false
	        local antiInvisibilityEnabled = false
	        local espDeathCounterEnabled = false
	        local espUltBarEnabled = false
	        local espEveryoneEnabled = false
	        local speedEnabled = false
	        local fakeDownslamEnabled = false
	        local speedValue = 9
	        local jumpValue = 200
	        local wallComboConnection = nil
	        local animConnection = nil
	        local antiAfkConnection = nil
	        local originalCFrame = nil
	        local flaggedAntiInvisibility = {}
	        local espObjects = {}
	        local whirlwindDunkAnimationId = "rbxassetid://12296113986"
	
	        local Connections = {}
	        local CharacterConnections = {}
	        local Settings = {}
        end

        local antiInvisibilityAnimIds = {
            ["136370737633649"] = true,
            ["18182425133"] = true,
            ["18236605028"] = true,
        }

        local roastMessages = {
            "Pathetic", "Nice try, loser", "Git gud", "You're a noob", "Did you even try?",
            "Keep dying, it's amusing", "Too easy", "Better luck next time", "That was embarrassing",
            "You're just feeding my kills", "Can't handle the pressure?", "You call that playing?",
            "LOL, what a scrub", "Go cry to your mommy", "Just uninstall.", "I'm not even trying.",
            "Get rekt, scrub", "You're a joke", "Just stop trying.", "Noob alert", "Stay in the kiddie pool",
            "Did someone forget their skills?", "Do you need a tutorial?", "You make this too easy.",
            "You're not even worth my time.", "I've seen toddlers play better.", "You're a respawn machine",
            "You're like a training dummy.", "Did you pay to be this bad?", "Even the NPCs play better than you.",
            "You must be allergic to victory.", "Your gameplay is a tutorial on how not to play.",
            "I bet you're proud of that death streak.", "You're the MVP of feeding kills.",
            "You're like a pinata... full of free kills.", "You're like a legend... in dying.",
            "Do you think dying is a tactic?", "What The Sigma.", "Ez Kill LOL", "hehe cry more",
        }

        local upperVariantEnabled = false
        local autoUppercutEnabled = false
        local flySpeed = 50
        local flying = false
        local flyCharacterAddedConnection = nil

        local teleportDownDistance = 20
        local teleportUpDistance = 20
        local teleportForwardDistance = 20
        local teleportBackDistance = 20
        local teleportLeftDistance = 20
        local teleportRightDistance = 20

        local onAnimationPlayedAutoVoid = function() end

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local function updateCharacter(newChar)
            character = newChar
            humanoid = character:WaitForChild("Humanoid")
            animator = humanoid:FindFirstChildOfClass("Animator")
            if animator then
                animator.AnimationPlayed:Connect(onAnimationPlayedAutoVoid)
            end
        end

        LocalPlayer.CharacterAdded:Connect(updateCharacter)

        workspace.FallenPartsDestroyHeight = -math.huge

        pcall(function()
            PhysicsService:CreateCollisionGroup(CollisionGroupName)
            PhysicsService:CollisionGroupSetCollidable(CollisionGroupName, "Default", false)
        end)



        local OPsection = Tabs.Main:Section({Opened = true, Box = true, BoxBorder = true, Title = "Main", Icon = "eye"})

        OPsection:Button({
            Title = "VexonHub Mini",
            Desc = "First version of the VexonHub but rly usefull",
            Locked = false,
            Callback = function()
                loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/187a02764b1ad1a4"))()
            end,
        })

        local heartBeatConnection = nil
        OPsection:Toggle({
            Title = "Semi Godmode",
            Flag = "tsbsemigodmode",
            Desc = "Makes you little bit in underground so others cant hit you with mini moves like M1",
            Value = false,
            Callback = function(state)
                if state then
                    if heartBeatConnection then heartBeatConnection:Disconnect() end
                    heartBeatConnection = RunService.Heartbeat:Connect(MV_CFF(function() 

                        if humanoidRootPart and humanoidRootPart.Parent then
                            local currentCFrame = humanoidRootPart.CFrame
                            humanoidRootPart.CFrame = currentCFrame * CFrame.new(0, -5, 0)
                            RunService.RenderStepped:Wait()
                            humanoidRootPart.CFrame = currentCFrame
                            wait(0.1)
                        end
                    end))
                else
                    if heartBeatConnection then
                        heartBeatConnection:Disconnect()
                        heartBeatConnection = nil
                    end
                end
            end,
        })

        OPsection:Toggle({
            Title = "No Dash Cool Down",
            Flag = "tsbnodashcd",
            Value = false,
            Callback = function(state)
                workspace:SetAttribute("EffectAffects", state and 1 or 0)
                workspace:SetAttribute("NoDashCooldown", state)
            end,
        })

        OPsection:Divider()

        local PlayersService = Players
        local RunServiceGame = RunService
        local LocalPlayerGame = LocalPlayer
        local invisAnimId = "rbxassetid://71181015443030"
        local invisTimePosition = 13.45
        local invisSpeed = 0
        local invisTrack = nil
        local isInvisOn = false
        local currentCharacterInvis = nil
        local currentHumanoidInvis = nil
        local currentAnimatorInvis = nil
        local invisHeartbeatConnection = nil
        local invisRenderSteppedConnection = nil


        local r6BodyParts = {
            ["Head"] = true,
            ["Torso"] = true,
            ["Left Arm"] = true,
            ["Right Arm"] = true,
            ["Left Leg"] = true,
            ["Right Leg"] = true,
        }

        local function setBodyTransparency(transparency)
            if not currentCharacterInvis then return end
            for _, part in ipairs(currentCharacterInvis:GetChildren()) do
                if part:IsA("BasePart") and r6BodyParts[part.Name] then
                    part.Transparency = transparency
                end
            end
        end

        local function stopInvisLoops()
            if invisHeartbeatConnection then invisHeartbeatConnection:Disconnect() invisHeartbeatConnection = nil end
            if invisRenderSteppedConnection then invisRenderSteppedConnection:Disconnect() invisRenderSteppedConnection = nil end
            if invisTrack then invisTrack:Stop() invisTrack = nil end
        end

        local function startInvisibility()
            stopInvisLoops()
            if not currentCharacterInvis or not currentAnimatorInvis then return end
            invisHeartbeatConnection = RunServiceGame.Heartbeat:Connect(MV_CFF(function() 

                if isInvisOn then
                    if not (invisTrack and invisTrack.IsPlaying) then
                        local anim = Instance.new("Animation")
                        anim.AnimationId = invisAnimId
                        local success, track = pcall(function() return currentAnimatorInvis:LoadAnimation(anim) end)
                        if success then
                            invisTrack = track
                            invisTrack:Play()
                            invisTrack.TimePosition = invisTimePosition
                            invisTrack:AdjustSpeed(invisSpeed)
                        end
                    end
                end
            end))
            invisRenderSteppedConnection = RunServiceGame.RenderStepped:Connect(MV_CFF(function() 

                if isInvisOn and invisTrack and invisTrack.IsPlaying then
                    invisTrack:Stop()
                    invisTrack = nil
                end
            end))
            setBodyTransparency(0.5)
        end

        local function onCharacterAddedInvis(newChar)
            currentCharacterInvis = newChar
            currentHumanoidInvis = currentCharacterInvis:WaitForChild("Humanoid")
            currentAnimatorInvis = currentHumanoidInvis:WaitForChild("Animator")
            if isInvisOn then
                task.wait(0.5)
                startInvisibility()
            end
        end

        LocalPlayerGame.CharacterAdded:Connect(onCharacterAddedInvis)

        local mainInvisEnabled = false
        local extraInvisEnabled = false

        local function updateExtraInvisibility()
            if Connections[60] then
                Connections[60]:Disconnect()
                Connections[60] = nil
            end
            if CharacterConnections[60] then
                CharacterConnections[60]:Disconnect()
                CharacterConnections[60] = nil
            end
            local characterNow = LocalPlayer.Character
            local charHumanoid = characterNow and characterNow:FindFirstChild("Humanoid")
            if mainInvisEnabled and extraInvisEnabled then
                Connections[60] = RunService.Heartbeat:Connect(MV_CFF(function() 

                    if not FluInvis then
                        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            local origCFrame = rootPart.CFrame
                            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(180))
                            RunService.RenderStepped:Wait()
                            rootPart.CFrame = origCFrame
                        end
                    end
                end))
                CharacterConnections[60] = RunService.PostSimulation:Connect(MV_CFF(function() 

                    if not (FluInvis or FluHideInvis) then
                        local currentHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                        if currentHumanoid then
                            currentHumanoid.CameraOffset = Vector3.new(0, -3.3, 0)
                        end
                    end
                end))
            else
                if charHumanoid then
                    charHumanoid.CameraOffset = Vector3.new(0, 0, 0)
                end
            end
        end

        OPsection:Toggle({
            Title = "Invisibility",
            Desc = "It elevates the character slightly and prevents others from seeing it. If you want to become completely invisible, it is recommended to use the toggle at the bottom.",
            Flag = "tsbmaininvis",
            Value = false,
            Callback = function(state)
                isInvisOn = state
                mainInvisEnabled = state
                if isInvisOn then
                    currentCharacterInvis = LocalPlayerGame.Character
                    if currentCharacterInvis then
                        currentHumanoidInvis = currentCharacterInvis:FindFirstChild("Humanoid")
                        currentAnimatorInvis = currentHumanoidInvis and currentHumanoidInvis:FindFirstChildOfClass("Animator")
                        startInvisibility()
                    end
                else
                    stopInvisLoops()
                    setBodyTransparency(0)
                end
                updateExtraInvisibility()
            end,
        })

        OPsection:Toggle({
            Title = "Invisibility Character Hide",
            Desc = "Hides your character in groud with making your character upside down",
            Flag = "tsbmainextrainvis",
            Value = false,
            Callback = function(state)
                extraInvisEnabled = state
                updateExtraInvisibility()
            end,
        })

	
        local MovementSection = Tabs.Main:Section({Opened = true, Box = true, BoxBorder = true, Title = "Movement", Icon = "settings"})

        local function toggleWalkSpeed(state)
            speedEnabled = state
            getgenv().WalkspeedBypass = speedEnabled
            if state then
                task.spawn(function()
                    while getgenv().WalkspeedBypass and character and character.Parent do
                        local hum = character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.MoveDirection.Magnitude > 0 then
                            character:TranslateBy(hum.MoveDirection * speedValue * RunService.Heartbeat:Wait() * 7)
                        else
                            task.wait()
                        end
                    end
		end)
	end
end

        MovementSection:Toggle({
            Title = "Speed (Keybind On/Off)",
            Flag = "tsbmainspeedtoggle",
            Value = false,
            Callback = toggleWalkSpeed,
        })

        MovementSection:Slider({
            Title = "Speed Boost Value",
            Flag = "tsbmainspeedslider",
            Value = { Min = 1, Max = 100, Default = 9 },
            Callback = function(value) speedValue = value end,
        })

        local speedKeybind = Enum.KeyCode.V
        MovementSection:Keybind({
            Title = "Speed Boost Keybind",
            Desc = "Press to set your Speed Boost key",
            Flag = "tsbmainspeedkeybind",
            Value = "V",
            Callback = function(v)
                local ok, result = pcall(function() return Enum.KeyCode[v] end)
                if ok and result then
                    speedKeybind = result
                end
            end,
        })

        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            if input.KeyCode == speedKeybind and not gameProcessedEvent then
                toggleWalkSpeed(not speedEnabled)
            end
        end)

        MovementSection:Toggle({
            Title = "Jump",
            Flag = "tsbmainjumptoggle",
            Value = false,
            Callback = function(state)
                getgenv().JumpPowerBypass = state
                if state then
                    task.spawn(function()
                        while getgenv().JumpPowerBypass do
                            if humanoid and humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                                humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, jumpValue, 0)
                            end
                            task.wait()
                        end
                    end)
                end
            end,
        })

        MovementSection:Slider({
            Title = "Jump Boost Value",
            Flag = "tsbmainjumpslider",
            Value = { Min = 1, Max = 1000, Default = 200 },
            Callback = function(num) jumpValue = num end,
        })

        MovementSection:Toggle({
            Title = "No Stun Cframe Walk",
            Flag = "tsbnostuncframewalk",
            Value = false,
            Callback = function(Value)
                getgenv().AutoNoSlow = Value
                task.spawn(function()
                    local connection
                    connection = RunService.RenderStepped:Connect(MV_CFF(function() 

                        if getgenv().AutoNoSlow == true then
                            pcall(function()
                                LocalPlayer.Character.Humanoid.WalkSpeed = 25
                            end)
                        else
                            connection:Disconnect()
                        end
                    end))
                end)
            end,
        })

        local antiMovementSettings = {
            ["Anti-Stun"] = true,
            ["Anti-Ragdoll"] = true,
            ["Always Rotate"] = true,
        }

        MovementSection:Dropdown({
            Title = "Select Movement Modifications",
            Flag = "tsbmovementmoddropdown",
            Desc = "Choose which modification features to enable",
            Values = {"Anti-Stun", "Anti-Ragdoll", "Always Rotate"},
            Value = {"Anti-Stun", "Anti-Ragdoll", "Always Rotate"},
            Multi = true,
            Callback = function(selectedValues)
                antiMovementSettings = {
                    ["Anti-Stun"] = false,
                    ["Anti-Ragdoll"] = false,
                    ["Always Rotate"] = false,
                }
                for _, value in pairs(selectedValues) do
                    antiMovementSettings[value] = true
                end
            end,
        })

        MovementSection:Toggle({
            Title = "Enable Movement Modifications",
            Flag = "tsbmovementmodtoggle",
            Value = false,
            Callback = function(state)
                if Connections[9] then
                    Connections[9]:Disconnect()
                end
                if CharacterConnections[9] then
                    CharacterConnections[9]:Disconnect()
                end
                if state then
                    local function setupAntiStun()
                        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        if not char:FindFirstChildOfClass("Humanoid") then
                            char:WaitForChild("Humanoid")
                        end
                        for _, child in pairs(char:GetChildren()) do
                            if child:IsA("Accessory") and not (child:FindFirstChild("Handle") or string.match(child.Name, "^#")) then
                                if child.Name ~= "Ragdoll" and child.Name ~= "NoRotate" and antiMovementSettings["Anti-Stun"] then
                                    Debris:AddItem(child, 0)
                                end
                                if child.Name == "Ragdoll" and antiMovementSettings["Anti-Ragdoll"] then
                                    Debris:AddItem(child, 0)
                                end
                                if child.Name == "NoRotate" and antiMovementSettings["Always Rotate"] then
                                    Debris:AddItem(child, 0)
                                end
                            end
                        end
                        Connections[9] = char.ChildAdded:Connect(function(child)
                            if child:IsA("Accessory") and not (child:FindFirstChild("Handle") or string.match(child.Name, "^#")) then
                                if child.Name ~= "Ragdoll" and child.Name ~= "NoRotate" and child.Name ~= "BeingGrabbed" and child.Name ~= "RootAnchor" and antiMovementSettings["Anti-Stun"] then
                                    Debris:AddItem(child, 0)
                                end
                                if child.Name == "Ragdoll" and antiMovementSettings["Anti-Ragdoll"] then
                                    Debris:AddItem(child, 0)
                                end
                                if child.Name == "NoRotate" and antiMovementSettings["Always Rotate"] then
                                    Debris:AddItem(child, 0)
                                end
                            end
                        end)
                    end
                    setupAntiStun()
                    CharacterConnections[9] = LocalPlayer.CharacterAdded:Connect(setupAntiStun)
                end
            end,
        })

        local CharacterSection = Tabs.Main:Section({Opened = true, Box = true, BoxBorder = true, Title = "Character", Icon = "box"})

        CharacterSection:Toggle({
            Title = "Auto upper variants",
            Desc = "Automatically makes the upper variants of the moves like Uppercut or Atomic samurai third move..",
            Value = false,
            Callback = function(state)
                upperVariantEnabled = state
                if state then
                    task.spawn(function()
                        while upperVariantEnabled do
                            LocalPlayer.Character:WaitForChild("Communicate"):FireServer({Goal = "KeyPress", Key = Enum.KeyCode.Space})
                            task.wait()
                        end
                    end)
                end
            end,
        })

        CharacterSection:Toggle({
            Title = "Auto Uppercut",
            Value = false,
            Callback = function(state)
                autoUppercutEnabled = state
                if state then
                    task.spawn(function()
                        while autoUppercutEnabled do
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("M1ing") then
                                char:WaitForChild("Communicate"):FireServer({Goal = "KeyPress", Key = Enum.KeyCode.Space})
                            end
                            task.wait(0.02)
                        end
                    end)
                end
            end,
        })

        CharacterSection:Toggle({
            Title = "Fake Downslam",
            Flag = "tsbfakedownslam",
            Value = false,
            Callback = function(state)
                fakeDownslamEnabled = state
            end,
        })

        local function onStateChangedDownslam(oldState, newState)
            if fakeDownslamEnabled and newState == Enum.HumanoidStateType.Jumping then
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://10470104242"
                if humanoid then
                    local animationTrack = humanoid:LoadAnimation(animation)
                    task.wait(0.3)
                    animationTrack:Play()
                end
            end
        end

        humanoid.StateChanged:Connect(onStateChangedDownslam)

        CharacterSection:Toggle({
            Title = "Auto Safe Zone",
            Flag = "tsbautosafezone",
            Value = false,
            Callback = function(state)
                getgenv().AutoReturnSafeZone = state
                if state then
                    local teleported = false
                    task.spawn(function()
                        while getgenv().AutoReturnSafeZone do
                            if humanoid and humanoid.Health < 45 and not teleported then
                                humanoidRootPart.CFrame = CFrame.new(150, 705, 30)
                                teleported = true
                            elseif humanoid and humanoid.Health == 50 and teleported then
                                teleported = false
                            end
                            task.wait(0.15)
                        end
                    end)
                end
            end,
        })

        local fluDashAuraEnabled = false
        CharacterSection:Toggle({
            Title = "Spawn Fe Stones",
            Flag = "tsbspawnfestones",
            Value = false,
            Callback = function(enabled)
                fluDashAuraEnabled = enabled
                if enabled then
                    while fluDashAuraEnabled do
                        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        char.Communicate:FireServer(unpack({{Dash = Enum.KeyCode.S, Key = Enum.KeyCode.Q, Goal = "KeyPress"}}))
                        stopAnimations("10479335397")
                        for _, child in pairs(char:GetChildren()) do
                            if child:IsA("Accessory") and (not child:FindFirstChild("Handle") and child.Name == "Freeze") then
                                Debris:AddItem(child, 0)
                            end
                        end
                        task.wait(0.05)
                    end
                end
            end,
        })

        CharacterSection:Toggle({
            Title = "Roast Dead Players",
            Flag = "tsbroastdeadplayers",
            Value = false,
            Callback = function(state)
                getgenv().AutoMocking = state
                if state then
                    task.spawn(function()
                        while getgenv().AutoMocking do
                            local root = character and character:FindFirstChild("HumanoidRootPart")
                            if root then
                                local nearestDist, nearestPlr = 65, nil
                                for _, v in ipairs(workspace.Live:GetChildren()) do
                                    local h, hrp = v:FindFirstChildOfClass("Humanoid"), v:FindFirstChild("HumanoidRootPart")
                                    if h and hrp and v ~= character and h.Health == 0 then
                                        local dist = (root.Position - hrp.Position).magnitude
                                        if dist < nearestDist then
                                            nearestDist = dist
                                            nearestPlr = hrp
                                        end
                                    end
                                end
                                if nearestPlr then
                                    local msg = roastMessages[math.random(#roastMessages)]
                                    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
                                end
                            end
                            task.wait(2.85)
                        end
                    end)
                end
            end,
        })

        CharacterSection:Toggle({
            Title = "Bang Dummy :>",
            Flag = "tsbgrapedummy",
            Value = false,
            Callback = function(Value)
                getgenv().AutoFuckingGoku = Value
                task.spawn(function()
                    if getgenv().AutoFuckingGoku == true then
                        local fuckAnim = Instance.new("Animation")
                        fuckAnim.AnimationId = "rbxassetid://148840371"
                        local k = LocalPlayer.Character.Humanoid:LoadAnimation(fuckAnim)
                        k:Play()
                        k:AdjustSpeed(6)
                    else
                        for _, v in ipairs((LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or LocalPlayer.Character:FindFirstChildOfClass("AnimationController")):GetPlayingAnimationTracks()) do
                            v:Stop()
                        end
                    end
                end)
                task.spawn(function()
                    if getgenv().AutoFuckingGoku == true then
                        local sound1 = Instance.new("Sound")
                        sound1.Name = "Sound"
                        sound1.SoundId = "http://www.roblox.com/asset/?id=8448213216"
                        sound1.Volume = 10
                        sound1.Looped = false
                        sound1.Archivable = false
                        sound1.Parent = workspace
                        sound1:Play()
                        local sound2 = Instance.new("Sound")
                        sound2.Name = "Sound"
                        sound2.SoundId = "http://www.roblox.com/asset/?id=9114758204"
                        sound2.Volume = 10
                        sound2.Looped = true
                        sound2.Archivable = false
                        sound2.Parent = workspace
                        sound2:Play()
                    else
                        for _, v in ipairs(workspace:children()) do
                            if v:isA("Sound") then
                                v:Destroy()
                            end
                        end
                    end
                end)
                task.spawn(function()
                    while getgenv().AutoFuckingGoku == true do
                        task.spawn(function()
                            pcall(function()
                                local dummy = workspace.Live["Weakest Dummy"]
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(dummy.HumanoidRootPart.Position - dummy.HumanoidRootPart.CFrame.LookVector * 1, dummy.HumanoidRootPart.Position)
		end)
		end)
	end
end)
            end,
        })

        CharacterSection:Toggle({
            Title = "Upside Down",
            Flag = "tsbupsidedown",
            Desc = "Other players will see you upside down",
            Default = false,
            Callback = function(enabled)
                if Connections[6] then
                    Connections[6]:Disconnect()
                end
                if CharacterConnections[6] then
                    CharacterConnections[6]:Disconnect()
                end
                if enabled then
                    Connections[6] = RunService.Heartbeat:Connect(MV_CFF(function() 

                        if not FluInvis then
                            local rootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                            local origCFrame = rootPart.CFrame
                            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(180))
                            RunService.RenderStepped:Wait()
                            rootPart.CFrame = origCFrame
                        end
                    end))
                    CharacterConnections[6] = RunService.PostSimulation:Connect(MV_CFF(function() 

                        if not (FluInvis or FluHideInvis) then
                            humanoid.CameraOffset = Vector3.new(0, -3.3, 0)
                        end
                    end))
                end
            end,
        })
        
        local VFXSection = Tabs.Main:Section({
		        Title = "VFX Changer",
		        Box = true,
		        BoxBorder = true,
		        Opened = true,
		    })
		    
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local GarouColor = Color3.fromRGB(128, 0, 200)
		
		getgenv().VFXEnabled = false
		
		local function applyColor(instance)
		    if instance:IsA("ParticleEmitter") or instance:IsA("Trail") or instance:IsA("Beam") then
		        instance.Color = ColorSequence.new(GarouColor)
		    end
		end
		
		local function processCharacter(char)
		    for _, descendant in ipairs(char:GetDescendants()) do
		        if getgenv().VFXEnabled then
		            applyColor(descendant)
		        end
		    end
		
		    char.DescendantAdded:Connect(function(descendant)
		        if getgenv().VFXEnabled then
		            applyColor(descendant)
		        end
		    end)
		end
		
		processCharacter(Character)
		
		LocalPlayer.CharacterAdded:Connect(function(newCharacter)
		    Character = newCharacter
		    if getgenv().VFXEnabled then
		        processCharacter(newCharacter)
		    end
		end)
		
		VFXSection:Colorpicker({
		    Title = "VFX Color picker",
		    Default = GarouColor,
		    Transparency = 0,
		    Locked = false,
		    Callback = function(color)
		        GarouColor = color
		        if getgenv().VFXEnabled then
		            processCharacter(Character)
		        end
		    end
		})
		
	    VFXSection:Toggle({
		    Title = "Change The Selected VFX Color",
		    Value = false,
		    Callback = function(state)
		        getgenv().VFXEnabled = state
		        if state then
		            processCharacter(Character)
		        end
		    end
		})
		
        local FlySection = Tabs.Main:Section({Opened = true, Box = true, BoxBorder = true, Title = 'Fly', Icon = 'utensils'})

        local PlayerModule = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
        local Controls = PlayerModule:GetControls()
        local flyLoadedAnims = {}
        local flyActiveAnimTrack = nil

        local function playFlyAnimation(hum, id, timePos, speed)
            if not hum then return end
            local animator = hum:FindFirstChildOfClass("Animator")
            if not animator then return end
            local animId = 'rbxassetid://' .. id
            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId ~= animId then
                    track:Stop(0)
                end
            end
            if flyActiveAnimTrack and flyActiveAnimTrack.Animation.AnimationId == animId then
                return
            end
            if not flyLoadedAnims[animId] then
                local Anim = Instance.new('Animation')
                Anim.AnimationId = animId
                flyLoadedAnims[animId] = animator:LoadAnimation(Anim)
            end
            flyActiveAnimTrack = flyLoadedAnims[animId]
            flyActiveAnimTrack:Play(0.1)
            flyActiveAnimTrack.TimePosition = timePos
            flyActiveAnimTrack:AdjustSpeed(speed)
        end

        local function stopFlyAnim(char, hum)
            if flyActiveAnimTrack then
                flyActiveAnimTrack:Stop(0.1)
                flyActiveAnimTrack = nil
            end
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        track:Stop(0.1)
                    end
                end
            end
            if char and char:FindFirstChild("Animate") then
                char.Animate.Disabled = false
            end
        end

        local function startFly(char)
            local torso = char:FindFirstChild('Torso')
            local hum = char:FindFirstChildOfClass('Humanoid')
            if not torso or not hum then return end
            flyLoadedAnims = {}
            flyActiveAnimTrack = nil
            if char:FindFirstChild("Animate") then
                char.Animate.Disabled = true
            end
            local animator = hum:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    track:Stop(0)
                end
            end
            for _, v in pairs(torso:GetChildren()) do
                if v.Name == 'GeminiFlyMover' then
                    v:Destroy()
                end
            end
            local bg = Instance.new('BodyGyro', torso)
            bg.Name = 'GeminiFlyMover'
            bg.P = 20000
            bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.CFrame = torso.CFrame
            local bv = Instance.new('BodyVelocity', torso)
            bv.Name = 'GeminiFlyMover'
            bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not flying or not char.Parent or hum:GetState() == Enum.HumanoidStateType.Dead then
                    connection:Disconnect()
                    pcall(function()
                        bg:Destroy()
                        bv:Destroy()
                        hum.PlatformStand = false
                        stopFlyAnim(char, hum)
                    end)
                    return
                end
                hum.PlatformStand = true
                local cam = workspace.CurrentCamera
                local moveVector = Controls:GetMoveVector()
                local moveDirection = (cam.CFrame.RightVector * moveVector.X + cam.CFrame.LookVector * -moveVector.Z)
                if moveDirection.Magnitude > 0 then
                    bv.Velocity = moveDirection.Unit * flySpeed
                else
                    bv.Velocity = Vector3.new(0, 0.1, 0)
                end
                local targetPitch = math.rad(-20) * -moveVector.Z
                local targetRoll = math.rad(15) * -moveVector.X
                local targetCFrame = cam.CFrame * CFrame.Angles(targetPitch, 0, targetRoll)
                bg.CFrame = bg.CFrame:Lerp(targetCFrame, 0.1)
                if moveVector.Magnitude > 0.1 then
                    if moveVector.Z < -0.1 then
                        playFlyAnimation(hum, 17124063826, 4.65, 0)
                    elseif moveVector.Z > 0.1 then
                        playFlyAnimation(hum, 17124067635, 4.11, 0)
                    elseif moveVector.X < -0.1 then
                        playFlyAnimation(hum, 17124105294, 3.55, 0)
                    elseif moveVector.X > 0.1 then
                        playFlyAnimation(hum, 17124112547, 4.81, 0)
                    end
                else
                    playFlyAnimation(hum, 17124061663, 4, 0)
                end
            end)
        end

        FlySection:Input({
            Title = 'Fly Speed',
            Placeholder = tostring(flySpeed),
            Flag = "flingflyspeedanim",
            Callback = function(text)
                local newSpeed = tonumber(text)
                if newSpeed and newSpeed > 0 then
                    flySpeed = newSpeed
                    pcall(function()
                        StarterGui:SetCore('SendNotification', {Title = 'VexonFly', Text = 'Speed set to: ' .. flySpeed, Duration = 2})
                    end)
                end
            end,
        })

        local FlyToggle = FlySection:Toggle({
            Title = 'Fly',
            Value = flying,
            Callback = function(toggleState)
                flying = toggleState
                if flying then
                    if LocalPlayer.Character then task.spawn(startFly, LocalPlayer.Character) end
                    flyCharacterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(char)
                        task.wait(0.5)
                        if flying then task.spawn(startFly, char) end
                    end)
                else
                    if flyCharacterAddedConnection then flyCharacterAddedConnection:Disconnect() end
                    if LocalPlayer.Character then
                        local char = LocalPlayer.Character
                        local torso = char:FindFirstChild("Torso")
                        if torso then
                            for _, v in pairs(torso:GetChildren()) do
                                if v.Name == 'GeminiFlyMover' then v:Destroy() end
                            end
                        end
                        stopFlyAnim(char, char:FindFirstChildOfClass('Humanoid'))
                    end
                end
            end,
        })

        local toggledFly = false
        FlySection:Keybind({
            Title = "Fly Keybind",
            Desc = "Keybind toggle",
            Flag = "flingflykeybind",
            Value = "",
            Callback = function()
                toggledFly = not toggledFly
                FlyToggle:Set(toggledFly)
            end,
        })

        local playerGui = LocalPlayer:WaitForChild("PlayerGui")

        local function createTeleportUI(name, buttonText)
            local mobileGui = Instance.new("ScreenGui")
            mobileGui.Name = "TeleportMobileUI" .. name
            mobileGui.ResetOnSpawn = false
            mobileGui.Enabled = false
            mobileGui.Parent = playerGui
            local btn = Instance.new("TextButton")
            btn.Name = "Teleport" .. name .. "Mobile"
            btn.Size = UDim2.new(0, 140, 0, 45)
            btn.Position = UDim2.new(0, 50, 0, 140)
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 16
            btn.Text = buttonText
            btn.Parent = mobileGui
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 12)
            corner.Parent = btn
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(200, 200, 200)
            stroke.Thickness = 1
            stroke.Transparency = 0.5
            stroke.Parent = btn
            local handle = Instance.new("TextButton")
            handle.Name = "DragHandle"
            handle.Size = UDim2.new(0, 30, 1, 0)
            handle.Position = UDim2.new(0, 0, 0, 0)
            handle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            handle.TextColor3 = Color3.fromRGB(200, 200, 200)
            handle.Font = Enum.Font.GothamBold
            handle.TextSize = 16
            handle.Text = "#"
            handle.ZIndex = 2
            handle.Parent = btn
            local handleCorner = Instance.new("UICorner")
            handleCorner.CornerRadius = UDim.new(0, 12)
            handleCorner.Parent = handle
            local dragging = false
            local dragStart = nil
            local startPos = nil
            local function updateInput(input)
                if not dragging then return end
                local delta = input.Position - dragStart
                btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
            handle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = btn.Position
                    local conn
                    conn = input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                            conn:Disconnect()
                        end
                    end)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateInput(input)
                end
            end)
            return mobileGui
        end

        local downGui = createTeleportUI("Down", "TP Down")
        local upGui = createTeleportUI("Up", "TP Up")
        local forwardGui = createTeleportUI("Forward", "TP Forward")
        local backGui = createTeleportUI("Back", "TP Back")
        local leftGui = createTeleportUI("Left", "TP Left")
        local rightGui = createTeleportUI("Right", "TP Right")

        local function teleportPlayer(direction, distance)
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            if direction == "down" then
                root.CFrame = root.CFrame + Vector3.new(0, -distance, 0)
            elseif direction == "up" then
                root.CFrame = root.CFrame + Vector3.new(0, distance, 0)
            elseif direction == "forward" then
                root.CFrame = root.CFrame + root.CFrame.LookVector * distance
            elseif direction == "back" then
                root.CFrame = root.CFrame - root.CFrame.LookVector * distance
            elseif direction == "left" then
                root.CFrame = root.CFrame - root.CFrame.RightVector * distance
            elseif direction == "right" then
                root.CFrame = root.CFrame + root.CFrame.RightVector * distance
            end
        end

        local multiSection = Tabs.Main:MultiSection({
            Title = "Teleports",
            Desc = "Up, Down, Left, Right, Forward, Back with UI + Keybinds",
            Icon = "rows-3",
            Opened = true,
            Box = true,
            BoxBorder = true,
        })

        local function createDirectionTab(direction, icon)
            local directionTab = multiSection:Tab({Title = direction:gsub("^%l", string.upper), Icon = icon})
            local distanceVar = teleportDownDistance
            if direction == "up" then distanceVar = teleportUpDistance
            elseif direction == "forward" then distanceVar = teleportForwardDistance
            elseif direction == "back" then distanceVar = teleportBackDistance
            elseif direction == "left" then distanceVar = teleportLeftDistance
            elseif direction == "right" then distanceVar = teleportRightDistance
            end

            directionTab:Button({
                Title = "Teleport " .. direction:gsub("^%l", string.upper),
                Locked = false,
                Callback = function()
                    teleportPlayer(direction, distanceVar)
                end,
            })

            directionTab:Slider({
                Title = "Teleport " .. direction:gsub("^%l", string.upper) .. " Distance",
                Flag = 'flingmaindistance' .. direction,
                Step = 1,
                Value = { Min = 1, Max = 100, Default = 20 },
                Callback = function(value)
                    if direction == "down" then teleportDownDistance = value
                    elseif direction == "up" then teleportUpDistance = value
                    elseif direction == "forward" then teleportForwardDistance = value
                    elseif direction == "back" then teleportBackDistance = value
                    elseif direction == "left" then teleportLeftDistance = value
                    elseif direction == "right" then teleportRightDistance = value
                    end
                end,
            })

            directionTab:Toggle({
                Title = "Teleport UI",
                Flag = 'flingmainteleportui' .. direction,
                Value = false,
                Callback = function(state)
                    if direction == "down" then downGui.Enabled = state
                    elseif direction == "up" then upGui.Enabled = state
                    elseif direction == "forward" then forwardGui.Enabled = state
                    elseif direction == "back" then backGui.Enabled = state
                    elseif direction == "left" then leftGui.Enabled = state
                    elseif direction == "right" then rightGui.Enabled = state
                    end
                end,
            })

            directionTab:Keybind({
                Title = "Teleport Keybind",
                Flag = 'flingmainkeybind' .. direction,
                Value = "",
                Callback = function(v)
                    teleportPlayer(direction, distanceVar)
                end,
            })
        end

        createDirectionTab("down", "arrow-down")
        createDirectionTab("up", "arrow-up")
        createDirectionTab("forward", "arrow-right")
        createDirectionTab("back", "arrow-left")
        createDirectionTab("left", "arrow-left")
        createDirectionTab("right", "arrow-right")

        downGui:WaitForChild("TeleportDownMobile").Activated:Connect(function() teleportPlayer("down", teleportDownDistance) end)
        upGui:WaitForChild("TeleportUpMobile").Activated:Connect(function() teleportPlayer("up", teleportUpDistance) end)
        forwardGui:WaitForChild("TeleportForwardMobile").Activated:Connect(function() teleportPlayer("forward", teleportForwardDistance) end)
        backGui:WaitForChild("TeleportBackMobile").Activated:Connect(function() teleportPlayer("back", teleportBackDistance) end)
        leftGui:WaitForChild("TeleportLeftMobile").Activated:Connect(function() teleportPlayer("left", teleportLeftDistance) end)
        rightGui:WaitForChild("TeleportRightMobile").Activated:Connect(function() teleportPlayer("right", teleportRightDistance) end)
    end)
end














-- ================ MISC0 TAB0 ================ --
function MiscTab()
	task.spawn(function()
		UniScriptSection = Tabs.Misc:Section({Opened = true, Box = true, BoxBorder = true, Title = "Universal Scripts", Icon = "flame" })
		
		UniScriptSection:Button({
		    Title = "Inf Yield",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
		end
		})
		UniScriptSection:Button({
		    Title = "Dex Explorer",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Classic-Dex-Explorer-21009"))()
		end
		})
		UniScriptSection:Button({
		    Title = "Remote Spy",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
		end
		})
		UniScriptSection:Button({
		    Title = "Keyboard",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
		end
		})
		UniScriptSection:Button({
		    Title = "Anim Logger",
		    Locked = false,
		    Callback = function()
		
		loadstring(game:HttpGet("https://pastefy.app/juBGMpCZ/raw"))()
		end
		})
		UniScriptSection:Button({
		    Title = "f3x",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/f3x.lua"))()
		end
		})
		UniScriptSection:Button({
		    Title = "Fly V3",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/xuSMWfDu"))()
		end
		})
		UniScriptSection:Button({
		    Title = "VFX Logger",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/2uXfJqdU"))()
		end
		})
		
		
		
		
		
		
		
		
		MscPlrSection = Tabs.Misc:Section({Opened = true, Box = true, BoxBorder = true, Title = "Player", Icon = "star" })
		
		MscPlrSection:Button({
		    Title = "ServerHop",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/uTXUoORd/raw"))()
		end
		})
		MscPlrSection:Button({
		    Title = "Rejoin",
		    Locked = false,
		    Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId)
		end
		})
		MscPlrSection:Button({
		    Title = "Reset",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/YPv8xrYN/raw"))()
		end
		})
		MscPlrSection:Button({
		    Title = "Fixcam V1",
		    Locked = false,
		    Callback = function()
		Camera.CameraType = Enum.CameraType.Custom
		player.CameraMode = Enum.CameraMode.Classic
		end
		})
		MscPlrSection:Button({
		    Title = "Fixcam V2",
		    Locked = false,
		    Callback = function()
		        success4, err4 = pcall(function()
		            loadstring(game:HttpGet("https://pastefy.app/IrvnCaF2/raw"))()
		        end)
		        if not success4 then
		            warn("Failed to load Fixcam V2:", err4)
		        end
		    end
		})
		
		RandomSection = Tabs.Misc:Section({Opened = true, Box = true, BoxBorder = true, Title = "Random", Icon = "utensils" })
		
		RandomSection:Button({
		    Title = "Buy limited Emotes",
		    Desc = "(You can buy limited emotes that have been removed from the game with robux idrl is this patched or not)",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/UiPAjkB4/raw"))()
		end
		})
		
		RandomSection:Button({
		    Title = "Strange Character Mod",
		    Desc = "(WallCombo Everywhere + Ragdoll Hit + NoVelocity Dash + Upsitedown)",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/dwPwscTr/raw"))()
		end
		})
		
		RandomSection:Button({
		    Title = "Strange Attacks",
		    Desc = "(All moves fall from above)",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/jP73sWh8/raw"))()
		end
		})
		
		RandomSection:Button({
		    Title = "Baldy Dummy",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/b1matovZ/raw"))()
		end
		})
		
		RandomSection:Button({
		    Title = "Crazy Spin",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/BFB6IlAQ/raw"))()
		end
		})
		
		RandomSection:Button({
		    Title = "Crazy Dance",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/I5eLfnge/raw"))()
		end
		})
	end)
end














-- ================ DODGE0 TAB0 ================ --
function DodgeTab()
	task.spawn(function()
	
	
	
	
		local Players        = game:GetService("Players")
		local RunService     = game:GetService("RunService")
		local LocalPlayer    = Players.LocalPlayer
		local character, humanoid, humanoidRootPart, animator
		local isHandlingDetectedAnimation = false
		local function refreshChar(newChar)
		    local c = newChar or LocalPlayer.Character
		    if not c or not c.Parent then return end
		    local h = c:FindFirstChildOfClass("Humanoid")
		    local r = c:FindFirstChild("HumanoidRootPart")
		    if not h or not r then return end
		    character        = c
		    humanoid         = h
		    humanoidRootPart = r
		    animator         = h:FindFirstChildOfClass("Animator") or Instance.new("Animator", h)
		end
		
		refreshChar()
		LocalPlayer.CharacterAdded:Connect(function(c)
		    task.wait(0.5)
		    refreshChar(c)
		
		    isHandlingDetectedAnimation = false
		end)
		
		local function isPlayerUlted()
		    if not character then return false end
		
		    local attr = character:GetAttribute("Ulted") or character:GetAttribute("IsUlted") or character:GetAttribute("UltActive")
		    if attr then return true end
		    if character:FindFirstChild("UltEffect") or character:FindFirstChild("UltAura") then return true end
		    return false
		end
		
		local function getCharacterType()
		    if not character then return "All" end
		
		    local attr = character:GetAttribute("CharType") or character:GetAttribute("SkinType")
		    if attr then return tostring(attr) end
		
		    local head = character:FindFirstChild("Head")
		    if head and head:IsA("BasePart") then
		        local c3 = head.Color
		
		        if c3.R > 0.4 and c3.B > 0.4 and c3.G < 0.3 then return "Purple" end
		    end
		    return "All"
		end
		
		local DODGE_SAFE_POS       = Vector3.new(150, 700, 30)
		local DODGE_MIN_DURATION   = 0.55
		local DODGE_RETURN_RADIUS  = 18
		local DODGE_TIMEOUT        = 4
		
		local perAnimCooldown = {}
		
		local function anyEnemiesNearby(radius)
		    if not humanoidRootPart then return false end
		    local myPos = humanoidRootPart.Position
		    for _, p in ipairs(Players:GetPlayers()) do
		        if p ~= LocalPlayer and p.Character then
		            local r = p.Character:FindFirstChild("HumanoidRootPart")
		            if r and (r.Position - myPos).Magnitude <= radius then
		                return true
		            end
		        end
		    end
		
		    local live = workspace:FindFirstChild("Live")
		    if live then
		        for _, m in ipairs(live:GetChildren()) do
		            if m:IsA("Model") and m ~= character then
		                local r = m:FindFirstChild("HumanoidRootPart")
		                local h = m:FindFirstChildOfClass("Humanoid")
		                if r and h and h.Health > 0 and (r.Position - myPos).Magnitude <= radius then
		                    return true
		                end
		            end
		        end
		    end
		    return false
		end
		
		local function handleDodge()
		    if isHandlingDetectedAnimation then return end
		    if not character or not humanoidRootPart then return end
		
		    isHandlingDetectedAnimation = true
		
		    local originalCF   = humanoidRootPart.CFrame
		    local startTime    = tick()
		    local conn
		
		    pcall(function() humanoidRootPart.CFrame = CFrame.new(DODGE_SAFE_POS) end)
		
		    conn = RunService.Heartbeat:Connect(function()
		        local elapsed = tick() - startTime
		        local timeoutHit = elapsed >= DODGE_TIMEOUT
		
		        if elapsed >= DODGE_MIN_DURATION then
		
		            if not anyEnemiesNearby(DODGE_RETURN_RADIUS) or timeoutHit then
		                pcall(function()
		                    if character and character.Parent and humanoidRootPart and humanoidRootPart.Parent then
		                        humanoidRootPart.CFrame = originalCF
		                    end
		                end)
		                isHandlingDetectedAnimation = false
		                conn:Disconnect()
		            end
		        end
		    end)
		end
		
		local DetectedAnimations = {
		
		    ["17275150809"]      = { Name="Tatsu Grab",           Enabled=true,  Cooldown=0.8, Radius=40,  CharReq="All",    UltReq="Both" },
		    ["18897119503"]      = { Name="Earth Strike",         Enabled=true,  Cooldown=0.8, Radius=80,  CharReq="Purple",  UltReq="On"   },
		    ["17141153099"]      = { Name="Stoic Bomb",           Enabled=true,  Cooldown=1.0, Radius=130, CharReq="All",    UltReq="Both" },
		    ["18462894593"]      = { Name="Five Seasons",         Enabled=true,  Cooldown=1.2, Radius=500, CharReq="All",    UltReq="Both" },
		    ["17420452843"]      = { Name="Dropkick",             Enabled=true,  Cooldown=0.8, Radius=100, CharReq="All",    UltReq="Both" },
		    ["17325254223"]      = { Name="Collateral Ruin",      Enabled=true,  Cooldown=0.8, Radius=35,  CharReq="All",    UltReq="Both" },
		    ["75547590335774"]   = { Name="Judgement Chain",      Enabled=true,  Cooldown=0.8, Radius=25,  CharReq="All",    UltReq="Both" },
		
		    ["14719290328"]      = { Name="Table Flip",           Enabled=true,  Cooldown=1.0, Radius=350, CharReq="Bald",   UltReq="Both", AngleCheck=50 },
		    ["14701242661"]      = { Name="FixCam",               Enabled=true,  Cooldown=0.8, Radius=350, CharReq="All",    UltReq="On",   AngleCheck=50 },
		
		    ["13630786846"]      = { Name="Garou Run",            Enabled=false, Cooldown=0.5, Radius=35,  CharReq="All",    UltReq="Both" },
		    ["13813099821"]      = { Name="Garou Run Finisher",   Enabled=false, Cooldown=0.6, Radius=50,  CharReq="All",    UltReq="Both" },
		    ["12463072679"]      = { Name="Garou Stomp",          Enabled=false, Cooldown=0.5, Radius=20,  CharReq="All",    UltReq="Both" },
		    ["12467789963"]      = { Name="Garou Stomp Slam",     Enabled=false, Cooldown=0.8, Radius=100, CharReq="All",    UltReq="Both" },
		    ["14057231976"]      = { Name="Garou Water Slaps",    Enabled=false, Cooldown=0.4, Radius=10,  CharReq="All",    UltReq="Both" },
		    ["12460977270"]      = { Name="Garou Punches",        Enabled=false, Cooldown=0.4, Radius=10,  CharReq="All",    UltReq="Both" },
		
		    ["14900168720"]      = { Name="Death Hit Drag",       Enabled=false, Cooldown=0.5, Radius=20,  CharReq="All",    UltReq="Both" },
		    ["15134211820"]      = { Name="Death Blow Slam",      Enabled=false, Cooldown=0.8, Radius=100, CharReq="All",    UltReq="Both" },
		    ["15128849047"]      = { Name="Death Blow Counter",   Enabled=false, Cooldown=0.8, Radius=100, CharReq="All",    UltReq="Both" },
		
		    ["75502010126640"]   = { Name="The Kick",             Enabled=false, Cooldown=0.8, Radius=100, CharReq="Purple", UltReq="Both" },
		    ["106755459092436"]  = { Name="The Kick Startup",     Enabled=false, Cooldown=0.5, Radius=60,  CharReq="Purple", UltReq="Both" },
		    ["95575238948327"]   = { Name="The Kick Run",         Enabled=false, Cooldown=0.6, Radius=120, CharReq="Purple", UltReq="Both" },
		
		    ["113166426814229"]  = { Name="Robot Bomb",           Enabled=false, Cooldown=0.8, Radius=10,  CharReq="All",    UltReq="Both" },
		    ["77509627104305"]   = { Name="Robot Heavy Grab",     Enabled=false, Cooldown=0.5, Radius=8,   CharReq="All",    UltReq="Both" },
		    ["94395585475029"]   = { Name="Robot Grab",           Enabled=false, Cooldown=0.4, Radius=6,   CharReq="All",    UltReq="Both" },
		
		    ["16597912086"]      = { Name="Tatsu Explode",        Enabled=false, Cooldown=0.5, Radius=10,  CharReq="All",    UltReq="Both" },
		    ["129651400898906"]  = { Name="WallCast",             Enabled=false, Cooldown=0.6, Radius=50,  CharReq="Purple", UltReq="Both" },
		    ["18896229321"]      = { Name="TWINFANGS",            Enabled=false, Cooldown=0.5, Radius=10,  CharReq="Purple", UltReq="Both" },
		    ["112620365240235"]  = { Name="Freezing Path",        Enabled=false, Cooldown=0.5, Radius=10,  CharReq="All",    UltReq="Both" },
		    ["16945573694"]      = { Name="Ravage Miss",          Enabled=false, Cooldown=0.5, Radius=10,  CharReq="All",    UltReq="Both" },
		}
		
		local DetectedAnimList = {}
		for id, cfg in pairs(DetectedAnimations) do
		    table.insert(DetectedAnimList, { Id=id, Cfg=cfg })
		end
		table.sort(DetectedAnimList, function(a,b) return a.Cfg.Name < b.Cfg.Name end)
		
		local AnimLookup = {}
		for id, cfg in pairs(DetectedAnimations) do
		    AnimLookup[id] = cfg
		end
		
		local DetectedAnimsEnabled = true
		local detectionConn        = nil
		
		local function startDetectionLoop()
		    if detectionConn then detectionConn:Disconnect() detectionConn = nil end
		
		    detectionConn = RunService.Heartbeat:Connect(function()
		        if not DetectedAnimsEnabled then return end
		        if not humanoidRootPart or not character or not character.Parent then return end
		
		        local myPos    = humanoidRootPart.Position
		        local myUlted  = isPlayerUlted()
		        local myType   = getCharacterType()
		        local now      = tick()
		
		        for _, otherPlayer in ipairs(Players:GetPlayers()) do
		            if otherPlayer == LocalPlayer then  end
		
		            local otherChar = otherPlayer.Character
		            if not otherChar then end
		
		            local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
		            if not otherRoot then end
		
		            local dist = (otherRoot.Position - myPos).Magnitude
		
		            local otherHum = otherChar:FindFirstChildOfClass("Humanoid")
		            if not otherHum or otherHum.Health <= 0 then end
		
		            local otherAnim = otherHum:FindFirstChildOfClass("Animator")
		            if not otherAnim then end
		
		            local ok, tracks = pcall(function() return otherAnim:GetPlayingAnimationTracks() end)
		            if not ok or not tracks then end
		
		            for _, track in ipairs(tracks) do
		                local rawId = tostring(track.Animation and track.Animation.AnimationId or "")
		                local numId = rawId:match("%d+")
		                if not numId then end
		
		                local cfg = AnimLookup[numId]
		                if not cfg or not cfg.Enabled then end
		
		                if dist > cfg.Radius then end
		
		                local lastTrig = perAnimCooldown[numId] or 0
		                if now - lastTrig < (cfg.Cooldown or 0.8) then end
		
		                local ur = cfg.UltReq or "Both"
		                if ur == "On"  and not myUlted then end
		                if ur == "Off" and myUlted      then end
		
		                local cr = cfg.CharReq or "All"
		                if cr ~= "All" and myType ~= "All" and cr ~= myType then end
		
		                if cfg.AngleCheck then
		                    local look       = otherRoot.CFrame.LookVector
		                    local toMe       = (myPos - otherRoot.Position).Unit
		                    local angle      = math.deg(math.acos(math.clamp(look:Dot(toMe), -1, 1)))
		                    if angle > cfg.AngleCheck then end
		                end
		
		                perAnimCooldown[numId] = now
		                task.spawn(handleDodge)
		                break
		            end
		        end
		    end)
		end
		
		local AutoDodgePlayers = false
		local autoDodgeConn    = nil
		
		local AttackIDs = {
		    ["16431491215"]=true, ["16597912086"]=true, ["17464644182"]=true, ["17860467628"]=true,
		    ["14004235777"]=true, ["14003607057"]=true, ["14046756619"]=true, ["14299135500"]=true,
		    ["14351441234"]=true, ["14719290328"]=true, ["14701242661"]=true,
		    ["12272894215"]=true, ["12273188754"]=true, ["12296882427"]=true, ["12307656616"]=true,
		    ["13630786846"]=true, ["12460977270"]=true, ["14057231976"]=true,
		    ["72451715583225"]=true, ["135104210400610"]=true, ["102989537449083"]=true,
		    ["82365328621192"]=true, ["131820095363270"]=true, ["109617620932970"]=true,
		    ["135289891173395"]=true, ["125955606488863"]=true, ["85025226664507"]=true,
		    ["10468665991"]=true, ["10466974800"]=true, ["10471336737"]=true, ["12510170988"]=true,
		    ["17799224866"]=true, ["17838006839"]=true, ["17838619895"]=true, ["17857788598"]=true,
		    ["18464362124"]=true, ["18179181663"]=true, ["18896229321"]=true, ["18897119503"]=true,
		    ["80903587710309"]=true, ["77509627104305"]=true, ["114095570398448"]=true,
		    ["13376869471"]=true, ["13294790250"]=true, ["13632347366"]=true, ["13881335713"]=true,
		    ["12534735382"]=true, ["12502664044"]=true, ["12509505723"]=true, ["12684390285"]=true,
		    ["14721837245"]=true, ["13083332742"]=true, ["13146710762"]=true,
		    ["15290930205"]=true, ["15145462680"]=true, ["15295895753"]=true, ["111986840437684"]=true,
		    ["15295336270"]=true, ["16062410809"]=true, ["15676072469"]=true, ["15520132233"]=true,
		    ["13380255751"]=true, ["10479335397"]=true,
		    ["130924083726156"]=true, ["121535378064818"]=true, ["124962465789551"]=true,
		    ["100687456175134"]=true, ["118270485922095"]=true,
		
		    ["13294471966"]=true, ["13295936866"]=true, ["13378708199"]=true,
		}
		
		local DODGE_RADIUS    = 25
		local DODGE_SIDE_DIST = 6
		
		local function startAutoDodgePlayers()
		    if autoDodgeConn then autoDodgeConn:Disconnect() autoDodgeConn = nil end
		    if not AutoDodgePlayers then return end
		
		    autoDodgeConn = RunService.Heartbeat:Connect(function()
		        if not AutoDodgePlayers then return end
		        if not humanoidRootPart or not character or not character.Parent then return end
		
		        local myPos   = humanoidRootPart.Position
		        local myRight = humanoidRootPart.CFrame.RightVector
		
		        for _, p in ipairs(Players:GetPlayers()) do
		            if p == LocalPlayer then end
		            local c = p.Character
		            if not c then end
		            local er = c:FindFirstChild("HumanoidRootPart")
		            local eh = c:FindFirstChildOfClass("Humanoid")
		            if not er or not eh or eh.Health <= 0 then end
		
		            if (er.Position - myPos).Magnitude > DODGE_RADIUS then end
		
		            local ea = eh:FindFirstChildOfClass("Animator")
		            if not ea then end
		            local ok, tracks = pcall(function() return ea:GetPlayingAnimationTracks() end)
		            if not ok or not tracks then end
		
		            local attacking = false
		            for _, t in ipairs(tracks) do
		                local id = tostring(t.Animation and t.Animation.AnimationId or ""):match("%d+")
		                if id and AttackIDs[id] then attacking = true break end
		            end
		
		            if attacking or c:FindFirstChild("M1ing") then
		
		                local offset = myPos - er.Position
		                local side = offset.Magnitude > 1e-6 and offset.Unit or humanoidRootPart.CFrame.RightVector
		                local step = side * DODGE_SIDE_DIST
		                pcall(function()
		                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + step
		                end)
		                break
		            end
		        end
		    end)
		end
		
		local SettingsSection = Tabs.Dodge:Section({ Opened=true, Box=true, BoxBorder=true, Title=" Settings" })
		
		SettingsSection:Toggle({
		    Title    = "Auto Dodge",
		    Desc     = "Automatically teleports you to safety when a nearby player starts an attack",
		    Default  = DetectedAnimsEnabled,
		    Flag     = "dodge_enabled",
		    Callback = function(v)
		        DetectedAnimsEnabled = v
		        if v then
		            startDetectionLoop()
		            WindUI:Notify({ Title="Auto Dodge", Content="Auto dodge is now running", Duration=2, Icon="eye" })
		        else
		            if detectionConn then detectionConn:Disconnect() detectionConn = nil end
		            WindUI:Notify({ Title="Auto Dodge", Content="Auto dodge has been turned off", Duration=2, Icon="eye-off" })
		        end
		    end,
		})
		
		SettingsSection:Toggle({
		    Title    = "Dodge Nearby Players",
		    Desc     = "Steps out of the way when someone close to you is throwing a hit",
		    Default  = false,
		    Flag     = "dodge_players",
		    Callback = function(v)
		        AutoDodgePlayers = v
		        startAutoDodgePlayers()
		    end,
		})
		
		SettingsSection:Slider({
		    Title    = "Stay Away Duration (s)",
		    Desc     = "How many seconds to remain at the safe spot before coming back",
		    Default  = 55,
		    Min      = 20, Max = 200, Rounding = 0,
		    Flag     = "dodge_min_dur",
		    Callback = function(v) DODGE_MIN_DURATION = v / 100 end,
		})
		
		SettingsSection:Slider({
		    Title    = "Safe Return Distance (studs)",
		    Desc     = "Wait to return if any enemy is still this close to you",
		    Default  = 18,
		    Min      = 5, Max = 60, Rounding = 0,
		    Flag     = "dodge_return_radius",
		    Callback = function(v) DODGE_RETURN_RADIUS = v end,
		})
		
		SettingsSection:Slider({
		    Title    = "Max Dodge Time (s)",
		    Desc     = "Come back after this many seconds even if enemies are still nearby",
		    Default  = 4,
		    Min      = 2, Max = 10, Rounding = 0,
		    Flag     = "dodge_timeout",
		    Callback = function(v) DODGE_TIMEOUT = v end,
		})
		
		SettingsSection:Button({
		    Title    = "Turn On All Moves",
		    Icon     = "check",
		    Callback = function()
		        for _, it in ipairs(DetectedAnimList) do it.Cfg.Enabled = true end
		        WindUI:Notify({ Title="Dodge", Content="All attack animations are now being tracked", Duration=2, Icon="check" })
		    end,
		})
		SettingsSection:Button({
		    Title    = "Turn Off All Moves",
		    Icon     = "x",
		    Callback = function()
		        for _, it in ipairs(DetectedAnimList) do it.Cfg.Enabled = false end
		        WindUI:Notify({ Title="Dodge", Content="All attack animations have been turned off", Duration=2, Icon="x" })
		    end,
		})
		
		local AnimListSection = Tabs.Dodge:Section({ Opened=false, Box=true, BoxBorder=true, Title="Dodge List" })
		
		for _, it in ipairs(DetectedAnimList) do
		    AnimListSection:Toggle({
		        Title    = it.Cfg.Name .. "  [r=" .. it.Cfg.Radius .. "]",
		        Desc     = "ID: " .. it.Id .. " | Req: " .. it.Cfg.CharReq .. " / Ult:" .. it.Cfg.UltReq,
		        Default  = it.Cfg.Enabled,
		        Callback = function(v) it.Cfg.Enabled = v end,
		    })
		end
				
		startDetectionLoop()
	end)
end















-- ================ TECH0 TAB0 ================ --
function TechTab()
	task.spawn(function()
		TechScriptsSection = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true,Title = "Tech Scripts", Icon = "box"})
		
		TechScriptsSection:Button({Title = "M1 Reset Script", Locked = false, Callback = function()
		    getgenv().keybinds = {m1reset = Enum.KeyCode.R, emotedash = Enum.KeyCode.T, rotation = Enum.KeyCode.H}
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Slaphello/M1-Reset-And-Emote-Dash-TSB-OLD-/refs/heads/main/M1R%26ED%20TSB"))()
		end})
		
		TechScriptsSection:Button({Title = "Auto Kyoto Script", Locked = false, Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/Auto%20kyoto%20ma%20hoa"))()
		end})
		
		TechScriptsSection:Button({Title = "Loop Dash Script", Locked = false, Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/Loop%20Dash%20Rework%20Script%20Real"))()
		end})
		
		TechScriptsSection:Button({Title = "Oreo Dash Script", Locked = false, Callback = function()
		    loadstring("loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/Oreo%20Tech%20Script\"))()")()
		end})
		
		TechScriptsSection:Button({Title = "Tornado Dash Script", Locked = false, Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/Idk%20lolololol"))()
		end})
		
		TechScriptsSection:Button({Title = "Supa Dash Script", Locked = false, Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/Supa%20tech%20script"))()
		end})
		
		TechScriptsSection:Button({Title = "BackDash Script (MOBILE)", Locked = false, Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/BackDash%20Tech"))()
		end})
		
		TechScriptsSection:Button({Title = "Backdash Script (PC)", Locked = false, Callback = function()
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kietba/Kietba/refs/heads/main/BackDash%20For%20Pc"))()
		end})
		
		
		
		
		
		Players = game:GetService("Players")
		VirtualInputManager = game:GetService("VirtualInputManager")
		UIS = game:GetService("UserInputService")
		RunService = game:GetService("RunService")
		player = Players.LocalPlayer
		
		selectedNumber = 1
		isSpaceEnabled = false
		
		toolGroups = {
			{ "Flowing Water", "Lethal Whirlwind Stream", "Hunter's Grasp", "Prey's Peril" },
			{ "Doom Dive", "Crowd Buster", "Hammer Heel", "Binding Cloth" },
			{ "Machine Gun Blows", "Ignition Burst", "Blitz Shot", "Jet Dive" },
			{ "Flash Strike", "Whirlwind Kick", "Scatter", "Explosive Shuriken" },
			{ "Homerun", "Beatdown", "Grand Slam", "Foul Ball" },
			{ "Quick Slice", "Atmos Cleave", "Pinpoint Cut", "Split Second Counter" },
			{ "Crushing Pull", "Windstorm Fury", "Stone Coffin", "Expulsive Push" },
			{ "Bullet Barrage", "Vanishing Kick", "Whirlwind Drop", "Head First" },
			{ "Normal Punch", "Consecutive Punches", "Shove", "Uppercut" }
		}
		
		mobileGui = Instance.new("ScreenGui")
		mobileGui.Name = "BackDashMobileUI"
		mobileGui.ResetOnSpawn = false
		mobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
		parentGui = (player and player:FindFirstChild("PlayerGui")) or game:GetService("CoreGui")
		pcall(function() mobileGui.Parent = parentGui end)
		
		function triggerRemote(tool)
			args = {
				[1] = {
					["Tool"] = tool,
					["Goal"] = "Console Move"
				}
			}
			remote = player.Character and player.Character:FindFirstChild("Communicate")
			if remote then
				remote:FireServer(unpack(args))
			end
		end
		
		function doBackDash()
			if isSpaceEnabled then
				VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
				task.wait(0.05)
				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
			end
		
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
		
			task.spawn(function()
				VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
				task.wait(0.05)
				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
			end)
		
			task.spawn(function()
				backpack = player:FindFirstChild("Backpack")
				if not backpack then return end
		
				for _, group in ipairs(toolGroups) do
					toolName = group[selectedNumber]
					tool = backpack:FindFirstChild(toolName)
					if tool then
						triggerRemote(tool)
						break
					end
				end
			end)
		
			task.delay(0.1, function()
				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
			end)
		end
		
		function createBackDashButton()
			local btn = Instance.new("TextButton")
		    btn.Name = "BackDashMobile"
		    btn.Size = UDim2.new(0, 140, 0, 45)
		    btn.Position = UDim2.new(0, 50, 0, 140)
		    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		    btn.Font = Enum.Font.GothamBold
		    btn.TextSize = 16
		    btn.Text = "  Back Dash"
		    btn.Parent = mobileGui
		
		    corner = Instance.new("UICorner")
		    corner.CornerRadius = UDim.new(0, 12)
		    corner.Parent = btn
		
		    stroke = Instance.new("UIStroke")
		    stroke.Color = Color3.fromRGB(200, 200, 200)
		    stroke.Thickness = 1
		    stroke.Transparency = 0.5
		    stroke.Parent = btn
		
		    handle = Instance.new("TextButton")
		    handle.Name = "DragHandle"
		    handle.Size = UDim2.new(0, 30, 1, 0)
		    handle.Position = UDim2.new(0, 0, 0, 0)
		    handle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		    handle.TextColor3 = Color3.fromRGB(200, 200, 200)
		    handle.Font = Enum.Font.GothamBold
		    handle.TextSize = 16
		    handle.Text = "#"
		    handle.ZIndex = 2
		    handle.Parent = btn
		
		    handleCorner = Instance.new("UICorner")
		    handleCorner.CornerRadius = UDim.new(0, 12)
		    handleCorner.Parent = handle
		
		    btn.MouseButton1Click:Connect(doBackDash)
		
		    handle.MouseButton1Click:Connect(function()
		    end)
		
		    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
		
		    handle.InputBegan:Connect(function(input)
		        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		            dragging = true
		            dragStart = input.Position
		            startPos = Vector2.new(btn.Position.X.Offset, btn.Position.Y.Offset)
		            input.Changed:Connect(function()
		                if input.UserInputState == Enum.UserInputState.End then
		                    dragging = false
		                end
		            end)
		        end
		    end)
		
		    handle.InputChanged:Connect(function(input)
		        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		            dragInput = input
		        end
		    end)
		
		    RunService.RenderStepped:Connect(MV_CFF(function() 

		        if dragging and dragInput and dragStart and startPos then
		            local delta = dragInput.Position - dragStart
		            btn.Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
		        end
		    end))
		
		    return btn
		end
		
		BackDashSection = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true, 
		    Title = "Back Dash Macro",
		    Icon = "box" 
		    
		})
		
		BackDashSection:Dropdown({
		    Title = "Select Skill Slot",
		    Flag = "tsbbackdashslotdropdown",
		    Desc = "Choose which skill slot to use for Back Dash",
		    Values = {"1", "2", "3", "4"},
		    Value = "1",
		    Callback = function(value)
		        selectedNumber = tonumber(value)
		    end
		})
		
		BackDashSection:Toggle({
		    Title = "Auto Jump",
		    Flag = "tsbbackdashautojump",
		    Desc = "Automatically jump before dashing",
		    Value = false,
		    Callback = function(state)
		        isSpaceEnabled = state
		    end
		})
		
		backDashMobileBtnInstance = nil
		
		BackDashSection:Toggle({
		    Title = "Show Mobile UI",
		    Flag = "tsbbackdashuitoggle",
		    Desc = "Spawns a draggable Back Dash button on your screen",
		    Value = false,
		    Callback = function(state)
		        if state then
		            if not backDashMobileBtnInstance then
		                backDashMobileBtnInstance = createBackDashButton()
		            end
		        else
		            if backDashMobileBtnInstance then
		                backDashMobileBtnInstance:Destroy()
		                backDashMobileBtnInstance = nil
		            end
		        end
		    end
		})
		
		BackDashKey = nil
		
		BackDashSection:Keybind({
		    Title = "Back Dash Keybind",
		    Flag = "tsbbackdashkeybind",
		    Desc = "Press to use Back Dash macro",
		    Value = "0",
		    Callback = function(v)
		        pcall(function()
		            BackDashKey = Enum.KeyCode[v]
		        end)
		    end
		})
		
		UIS.InputBegan:Connect(function(input, gpe)
		    if gpe or UIS:GetFocusedTextBox() then return end
		    if input.UserInputType == Enum.UserInputType.Keyboard and BackDashKey then
		        if input.KeyCode == BackDashKey then
		            pcall(doBackDash)
		        end
		    end
		end)
		
		
		
		
		
		Players = game:GetService("Players")
		Plr = Players.LocalPlayer
		UIS = game:GetService("UserInputService")
		TweenService = game:GetService("TweenService")
		RunService = game:GetService("RunService")
		Workspace = game:GetService("Workspace")
		
		VIM = nil
		pcall(function() VIM = game:GetService("VirtualInputManager") end)
		VIM = VIM or rawget(_G, "VirtualInputManager") or (rawget(_G, "syn") and rawget(_G, "syn").virtual_input) or rawget(_G, "virtualinputmanager")
		
		camera = Workspace.CurrentCamera
		isPerformingAction = false
		animCache = {}
		
		TechStates = {
		    M1Enabled = false,
		    EmoteEnabled = false,
		    M1Key = Enum.KeyCode.G,
		    EmoteKey = Enum.KeyCode.T
		}
		
		mobileGui = Instance.new("ScreenGui")
		mobileGui.Name = "TechMobileUI"
		mobileGui.ResetOnSpawn = false
		mobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
		
		parentGui = (Plr and Plr:FindFirstChild("PlayerGui")) or game:GetService("CoreGui")
		pcall(function() mobileGui.Parent = parentGui end)
		
		function createDraggableButton(name, text, position, callback)
		    local btn = Instance.new("TextButton")
		    btn.Name = name
		    btn.Size = UDim2.new(0, 140, 0, 45)
		    btn.Position = position
		    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		    btn.Font = Enum.Font.GothamBold
		    btn.TextSize = 16
		    btn.Text = "  " .. text
		    btn.Parent = mobileGui
		
		    local corner = Instance.new("UICorner")
		    corner.CornerRadius = UDim.new(0, 12)
		    corner.Parent = btn
		
		    local stroke = Instance.new("UIStroke")
		    stroke.Color = Color3.fromRGB(200, 200, 200)
		    stroke.Thickness = 1
		    stroke.Transparency = 0.5
		    stroke.Parent = btn
		
		    local handle = Instance.new("TextButton")
		    handle.Name = "DragHandle"
		    handle.Size = UDim2.new(0, 30, 1, 0)
		    handle.Position = UDim2.new(0, 0, 0, 0)
		    handle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		    handle.TextColor3 = Color3.fromRGB(200, 200, 200)
		    handle.Font = Enum.Font.GothamBold
		    handle.TextSize = 16
		    handle.Text = "#"
		    handle.ZIndex = 2
		    handle.Parent = btn
		
		    local handleCorner = Instance.new("UICorner")
		    handleCorner.CornerRadius = UDim.new(0, 12)
		    handleCorner.Parent = handle
		
		    btn.MouseButton1Click:Connect(callback)
		    handle.MouseButton1Click:Connect(function() end)
		
		    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
		
		    handle.InputBegan:Connect(function(input)
		        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		            dragging = true
		            dragStart = input.Position
		            startPos = Vector2.new(btn.Position.X.Offset, btn.Position.Y.Offset)
		            input.Changed:Connect(function()
		                if input.UserInputState == Enum.UserInputState.End then
		                    dragging = false
		                end
		            end)
		        end
		    end)
		
		    handle.InputChanged:Connect(function(input)
		        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		            dragInput = input
		        end
		    end)
		
		    RunService.RenderStepped:Connect(MV_CFF(function() 

		        if dragging and dragInput and dragStart and startPos then
		            local delta = dragInput.Position - dragStart
		            local newPos = startPos + Vector2.new(delta.X, delta.Y)
		            btn.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
		        end
		    end))
		
		    return btn
		end
		
		function getCharacter()
		    char = Plr and Plr.Character
		    humanoid = char and char:FindFirstChildOfClass("Humanoid")
		    return char, humanoid
		end
		
		function Stopallanimation()
		    local _, humanoid = getCharacter()
		    if humanoid then
		        local animator = humanoid:FindFirstChildOfClass("Animator")
		        if animator then
		            local success, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
		            if success and tracks then
		                for _, track in ipairs(tracks) do
		                    pcall(function() track:Stop() end)
		                end
		            end
		        end
		    end
		end
		
		function playAnimation(animationId)
		    local _, humanoid = getCharacter()
		    if not humanoid then return end
		    local animator = humanoid:FindFirstChildOfClass("Animator")
		    if not animator then
		        animator = Instance.new("Animator")
		        animator.Parent = humanoid
		    end
		    local animation = animCache[animationId]
		    if not animation then
		        animation = Instance.new("Animation")
		        animation.AnimationId = "rbxassetid://" .. tostring(animationId)
		        animCache[animationId] = animation
		    end
		    local ok, animTrack = pcall(function() return animator:LoadAnimation(animation) end)
		    if not ok or not animTrack then return end
		    animTrack.Priority = Enum.AnimationPriority.Action
		    animTrack:Play()
		    pcall(function() animTrack:AdjustSpeed(1.2) end)
		    return animTrack
		end
		
		function rotateCharacter(degrees)
		    if isPerformingAction then return end
		    isPerformingAction = true
		    local character, _ = getCharacter()
		    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		    if rootPart then
		        pcall(function()
		            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(degrees), 0)
		            camPos = camera and camera.CFrame.Position or rootPart.Position + Vector3.new(0, 5, 0)
		            camY = camPos.Y
		            distanceVec = camPos - rootPart.Position
		            flatVec = Vector3.new(distanceVec.X, 0, distanceVec.Z)
		            rotatedVec = CFrame.fromAxisAngle(Vector3.yAxis, math.rad(degrees)) * flatVec
		            newCamPos = rootPart.Position + rotatedVec
		            if camera and camera:IsA("Camera") then
		                camera.CFrame = CFrame.lookAt(Vector3.new(newCamPos.X, camY, newCamPos.Z), rootPart.Position)
		            end
		        end)
		    end
		    isPerformingAction = false
		end
		
		function sideDash(direction, distance, duration)
		    if isPerformingAction then return end
		    isPerformingAction = true
		    local character, _ = getCharacter()
		    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		    if rootPart then
		        local tween = TweenService:Create(
		            rootPart,
		            TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		            {CFrame = rootPart.CFrame * CFrame.new(direction * distance, 0, 0)}
		        )
		        pcall(function() tween:Play() end)
		        if tween then pcall(function() tween.Completed:Wait() end) end
		        pcall(function() tween:Destroy() end)
		    end
		    isPerformingAction = false
		end
		
		function impulseDash(direction, distance, height, power, duration)
		    if isPerformingAction then return end
		    isPerformingAction = true
		    local character, _ = getCharacter()
		    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		    if rootPart then
		        local force = Instance.new("BodyVelocity")
		        local vec = (rootPart.CFrame.RightVector * direction * distance + Vector3.new(0, height, 0))
		        if vec.Magnitude == 0 then vec = Vector3.new(0, 1, 0) end
		        force.Velocity = vec.Unit * power
		        force.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		        force.Parent = rootPart
		        task.delay(duration, function() pcall(function() force:Destroy() end) end)
		    end
		    isPerformingAction = false
		end
		
		function doM1Reset()
		    if not TechStates.M1Enabled then return end
		    Stopallanimation()
		    pcall(function() playAnimation(10480793962) end)
		    pcall(function() sideDash(1, 26, 0.22) end)
		    pcall(function() rotateCharacter(70) end)
		    task.wait(0.003)
		    pcall(function()
		        if VIM and type(VIM.SendKeyEvent) == "function" then
		            VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
		            VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
		        end
		    end)
		end
		
		function doEmoteDash()
		    if not TechStates.EmoteEnabled then return end
		    Stopallanimation()
		    pcall(function() playAnimation(10480793962) end)
		    pcall(function() rotateCharacter(90) end)
		    pcall(function() impulseDash(1, 38, 8, 95, 0.27) end)
		end
		
		
		M1Reset = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true, Title = "M1 Reset Macro", Icon = "box" })
		m1MobileBtnInstance = nil
		
		M1Reset:Toggle({
		    Title = "M1 Reset",
		    Flag = "tsbm1resettoggle",
		    Desc = "Toggle Of All M1 Reset",
		    Value = false,
		    Callback = function(state)
		        TechStates.M1Enabled = state
		    end
		})
		
		M1Reset:Toggle({
		    Title = "M1 Reset Mobile UI",
		    Flag = "tsbm1resetmobileui",
		    Desc = "Opens Mobile UI to Easy to use M1 Reset",
		    Value = false,
		    Callback = function(state)
		        if state then
		            if not m1MobileBtnInstance then
		                m1MobileBtnInstance = createDraggableButton("M1Btn", "M1 Reset", UDim2.new(0, 50, 0, 200), function()
		                    pcall(doM1Reset)
		                end)
		            end
		        else
		            if m1MobileBtnInstance then
		                m1MobileBtnInstance:Destroy()
		                m1MobileBtnInstance = nil
		            end
		        end
		    end
		})
		
		M1Reset:Keybind({
		    Title = "Keybind",
		    Flag = "tsbm1resetkeybind",
		    Desc = "Keybind to Use M1 Reset Tech",
		    Value = "",
		    Callback = function(v)
		        pcall(function()
		            TechStates.M1Key = Enum.KeyCode[v]
		        end)
		    end
		})
		
		
		EmoteDash = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true, Title = "Emote Dash Macro", Icon = "box"  })
		emoteMobileBtnInstance = nil
		
		EmoteDash:Toggle({
		    Title = "Emote Dash",
		    Flag = "tsbemotedashtoggle",
		    Desc = "Toggle Of All Emote Dash",
		    Value = false,
		    Callback = function(state)
		        TechStates.EmoteEnabled = state
		    end
		})
		
		EmoteDash:Toggle({
		    Title = "Emote Dash Mobile UI",
		    Flag = "tsbemotedashuitoggle",
		    Desc = "Opens Mobile UI to Easy to use Emote Dash",
		    Value = false,
		    Callback = function(state)
		        if state then
		            if not emoteMobileBtnInstance then
		                emoteMobileBtnInstance = createDraggableButton("EmoteBtn", "Emote Dash", UDim2.new(0, 50, 0, 260), function()
		                    pcall(doEmoteDash)
		                end)
		            end
		        else
		            if emoteMobileBtnInstance then
		                emoteMobileBtnInstance:Destroy()
		                emoteMobileBtnInstance = nil
		            end
		        end
		    end
		})
		
		EmoteDash:Keybind({
		    Title = "Keybind",
		    Flag = "tsbemotedashkeybind",
		    Desc = "Keybind to Use Emote Dash Tech",
		    Value = "",
		    Callback = function(v)
		        pcall(function()
		            TechStates.EmoteKey = Enum.KeyCode[v]
		        end)
		    end
		})
		
		UIS.InputBegan:Connect(function(input, gpe)
		    if gpe or UIS:GetFocusedTextBox() then return end
		    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		
		    if input.KeyCode == TechStates.M1Key then
		        pcall(doM1Reset)
		    elseif input.KeyCode == TechStates.EmoteKey then
		        pcall(doEmoteDash)
		    end
		end)
		
		
		
		
		
		
		
		
		TwistedAnimIds = {
		    "rbxassetid://15162694192",
		    "rbxassetid://14136436157",
		    "rbxassetid://16552234590",
		    "rbxassetid://13295936866",
		    "rbxassetid://13378708199",
		    "rbxassetid://10469643643",
		    "rbxassetid://17889290569",
		    "rbxassetid://17325537719",
		    "rbxassetid://13294471966"
		}
		
		TwistedEnabled = false
		TwistedMode = "Normal"
		PingOffset = 0
		LethalTime = 1.65
		extraAnimId = "rbxassetid://12273188754"
		extraAnimToggleState = false
		
		twistedConnections = {}
		
		function isInTable(tbl, value)
		    for _, v in ipairs(tbl) do
		        if v == value then return true end
		    end
		    return false
		end
		
		
		task.wait(0.5)
		function addExtraAnim()
		    if not isInTable(TwistedAnimIds, extraAnimId) then
		        table.insert(TwistedAnimIds, extraAnimId)
		    end
		end
		
		function removeExtraAnim()
		    for i, id in ipairs(TwistedAnimIds) do
		        if id == extraAnimId then
		            table.remove(TwistedAnimIds, i)
		            break
		        end
		    end
		end
		
		function DisconnectTwisted()
		    for _, conn in ipairs(twistedConnections) do
		        conn:Disconnect()
		    end
		    twistedConnections = {}
		end
		
		function MoveForward()
		    local rootPart = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("HumanoidRootPart")
		    if rootPart then
		        rootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, 3)
		    end
		end
		
		function SendDash()
		    local args = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress"}}
		    local char = LocalPlayerGame.Character
		    if char and char:FindFirstChild("Communicate") then
		        char.Communicate:FireServer(unpack(args))
		    end
		end
		
		function SetupNormalTwisted()
		    local humanoid = (LocalPlayerGame.Character or LocalPlayerGame.CharacterAdded:Wait()):WaitForChild("Humanoid")
		    local conn = humanoid.AnimationPlayed:Connect(function(track)
		        if track.Animation and isInTable(TwistedAnimIds, track.Animation.AnimationId) and TwistedEnabled then
		
		            local delayTime = 0.23 + PingOffset
		            if track.Animation.AnimationId == extraAnimId then
		                delayTime = LethalTime + PingOffset
		            end
		            task.delay(delayTime, function()
		                MoveForward()
		                SendDash()
		            end)
		        end
		    end)
		    table.insert(twistedConnections, conn)
		end
		
		function PerformInstantTwisted()
		    args = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress"}}
		    char = LocalPlayerGame.Character
		    if char and char:FindFirstChild("Communicate") then
		        char.Communicate:FireServer(unpack(args))
		    end
		    
		    Camera = workspace.CurrentCamera
		    currentCFrame = Camera.CFrame
		    rotatedCFrame = currentCFrame * CFrame.Angles(40, math.rad(-90), 180)
		    Camera.CameraType = Enum.CameraType.Scriptable
		    
		    local tween1 = game:GetService("TweenService"):Create(Camera, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {CFrame = rotatedCFrame})
		    tween1:Play()
		    tween1.Completed:Wait()
		    wait(0.00001)
		    
		    local tween2 = game:GetService("TweenService"):Create(Camera, TweenInfo.new(0.001, Enum.EasingStyle.Sine), {CFrame = currentCFrame})
		    tween2:Play()
		    tween2.Completed:Wait()
		    wait(0.1)
		    
		    local tween3 = game:GetService("TweenService"):Create(Camera, TweenInfo.new(0.0001, Enum.EasingStyle.Sine), {CFrame = currentCFrame * CFrame.Angles(math.rad(-6), math.rad(20), 0)})
		    tween3:Play()
		    tween3.Completed:Wait()
		    
		    Camera.CameraType = Enum.CameraType.Custom
		end
		
		function SetupInstantTwisted()
		    local humanoid = (LocalPlayerGame.Character or LocalPlayerGame.CharacterAdded:Wait()):WaitForChild("Humanoid")
		    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid.ChildAdded:Wait(function(c) return c:IsA("Animator") end)
		    
		    local conn = animator.AnimationPlayed:Connect(function(track)
		        if track.Animation and isInTable(TwistedAnimIds, track.Animation.AnimationId) and TwistedEnabled then
		            local rootPart = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("HumanoidRootPart")
		            if rootPart then
		                local backVector = rootPart.CFrame.LookVector * -1
		                rootPart.CFrame = rootPart.CFrame + (backVector * 1)
		            end
		            
		 
		            local delayTime = 0.25 + PingOffset
		            if track.Animation.AnimationId == extraAnimId then
		                delayTime = LethalTime + PingOffset
		            end
		            
		            task.delay(delayTime, function()
		                PerformInstantTwisted()
		            end)
		        end
		    end)
		    table.insert(twistedConnections, conn)
		end
		
		function UpdateTwistedTech()
		    DisconnectTwisted()
		    if not TwistedEnabled then return end
		    
		    if TwistedMode == "Normal" then
		        SetupNormalTwisted()
		    elseif TwistedMode == "Instant" then
		        SetupInstantTwisted()
		    end
		    
		    charConn = LocalPlayerGame.CharacterAdded:Connect(function()
		        task.wait(1)
		        UpdateTwistedTech()
		    end)
		    table.insert(twistedConnections, charConn)
		end
		
		twistedSection = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true,
		    Title = "Twisted Tech",
		    Icon = "box"
		})
		twistedSection:Toggle({
		    Title = "Twisted Tech",
		    Flag = "tsbtwistedtoggle",
		    Value = false,
		    Callback = function(state)
		        TwistedEnabled = state
		        UpdateTwistedTech()
		    end
		})
		
		twistedSection:Dropdown({
		    Title = "Mode",
		    Flag = "tsbtwistedmode",
		    Desc = "Choose between Normal and Instant",
		    Values = {"Normal", "Instant"},
		    Value = "Normal",
		    Multi = false,
		    Callback = function(value)
		        TwistedMode = value
		        if TwistedEnabled then
		            UpdateTwistedTech()
		        end
		    end
		})
		
		twistedSection:Slider({
		    Title = "Ping Compensation",
		    Flag = "tsbtwistedping",
		    Desc = "Additional delay in seconds to account for lag",
		    Value = { Min = 0, Max = 0.5, Default = 0 },
		    Step = 0.1,
		    Callback = function(value)
		        PingOffset = value
		    end
		})
		
		twistedSection:Toggle({
		    Title = "Garou Lethal Whirlwind Twisted",
		    Flag = "tsbtwistedgaroutoggle",
		    Value = false,
		    Callback = function(state)
		        extraAnimToggleState = state
		        if state then
		            addExtraAnim()
		        else
		            removeExtraAnim()
		        end
		    end
		})
		
		twistedSection:Slider({
		    Title = "Lethal Whirlwind Delay",
		    Flag = "tsblethaldelayslider",
		    Desc = "Additional delay in seconds to account for Lethal Whirlwind Twisted",
		    Value = { Min = 1, Max = 2, Default = 1.65 },
		    Step = 0.01,
		    Callback = function(value)
		        LethalTime = value
		    end
		})
		
		
		
		
		
		LocalPlayerGame = game.Players.LocalPlayer
		
		SupaEnabled = false
		SelectedAbilities = {"Stream", "Uppercut"}
		IsExecuting = false
		AnimConnection = nil
		CharConnection = nil
		
		DashDelay = 0.3
		TurnDelay = 0.26
		StreamPreDelay = 2.0
		
		AbilityIds = {
		    Stream   = "rbxassetid://12296113986",
		    Uppercut = "rbxassetid://10503381238"
		}
		
		function DoJump()
		    local humanoid = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("Humanoid")
		    if humanoid then humanoid.Jump = true end
		end
		
		function DoStopJump()
		    local humanoid = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("Humanoid")
		    if humanoid then humanoid.Jump = false end
		end
		
		function DoTurn()
		    local rootPart = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("HumanoidRootPart")
		    if rootPart then
		        local cf = rootPart.CFrame
		        rootPart.CFrame = CFrame.lookAt(cf.Position, cf.Position + (-cf.LookVector))
		        Camera = workspace.CurrentCamera
		        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, Camera.CFrame.Position + (-cf.LookVector))
		    end
		end
		
		function DoDash()
		    local communicate = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("Communicate")
		    if communicate then
		        communicate:FireServer({Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress"})
		    end
		end
		
		function RunSupa()
		    DoJump()
		    task.delay(DashDelay, function()
		        DoDash()
		        task.delay(TurnDelay, function()
		            DoTurn()
		            DoStopJump()
		            IsExecuting = false
		        end)
		    end)
		end
		
		function ExecuteSupa(triggeredAbility)
		    if IsExecuting then return end
		    IsExecuting = true
		
		    if triggeredAbility == "Stream" then
		        task.delay(StreamPreDelay, function()
		            RunSupa()
		        end)
		    else
		        RunSupa()
		    end
		end
		
		function SetupAnimationListener()
		    if AnimConnection then
		        AnimConnection:Disconnect()
		        AnimConnection = nil
		    end
		    if not SupaEnabled then return end
		    local humanoid = LocalPlayerGame.Character and LocalPlayerGame.Character:FindFirstChild("Humanoid")
		    if not humanoid then return end
		
		    AnimConnection = humanoid.AnimationPlayed:Connect(function(track)
		        if not track.Animation or IsExecuting then return end
		        local animId = track.Animation.AnimationId
		        for _, abilityName in ipairs(SelectedAbilities) do
		            if AbilityIds[abilityName] == animId then
		                ExecuteSupa(abilityName)
		                break
		            end
		        end
		    end)
		end
		
		function OnCharacterAdded()
		    LocalPlayerGame.Character:WaitForChild("Humanoid")
		    SetupAnimationListener()
		end
		
		SupaTech = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true,
		    Title = "Supa Tech",
		    Icon = "box"
		})
		
		SupaTech:Toggle({
		    Title = "Enable Auto Supa",
		    Flag = "tsbautosupatoggle",
		    Value = false,
		    Callback = function(state)
		        SupaEnabled = state
		        if state then
		            SetupAnimationListener()
		            if not CharConnection then
		                CharConnection = LocalPlayerGame.CharacterAdded:Connect(OnCharacterAdded)
		            end
		        else
		            if AnimConnection then AnimConnection:Disconnect(); AnimConnection = nil end
		            if CharConnection then CharConnection:Disconnect(); CharConnection = nil end
		            IsExecuting = false
		        end
		    end
		})
		
		SupaTech:Dropdown({
		    Title = "Select Abilities",
		    Flag = "tsbsupadropdown",
		    Values = {"Stream", "Uppercut"},
		    Value = {"Stream", "Uppercut"},
		    Multi = true,
		    Callback = function(selectedValues)
		        SelectedAbilities = selectedValues
		        if SupaEnabled then SetupAnimationListener() end
		    end
		})
		
		SupaTech:Slider({
		    Title = "Dash Delay",
		    Flag = "tsbsupadashdelay",
		    Value = { Min = 0, Max = 2, Default = 0.3 },
		    Step = 0.05,
		    Callback = function(num) DashDelay = num end
		})
		
		SupaTech:Slider({
		    Title = "Turn Delay",
		    Flag = "tsbsupaturndeley",
		    Value = { Min = 0, Max = 2, Default = 0.26 },
		    Step = 0.05,
		    Callback = function(num) TurnDelay = num end
		})
		
		SupaTech:Slider({
		    Title = "Stream Pre Delay",
		    Flag = "tsbstreamdeley",
		    Value = { Min = 0, Max = 5, Default = 2.0 },
		    Step = 0.1,
		    Callback = function(num) StreamPreDelay = num end
		})
		
		SupaTech:Keybind({
		    Title = "Supa Keybind",
		    Flag = "tsbsupakeybind",
		    Value = "",
		    Callback = function(key, down)
		        if down and SupaEnabled and not IsExecuting then
		            local ability = SelectedAbilities[1] or "Uppercut"
		            ExecuteSupa(ability)
		        end
		    end
		})
		
		
		
		
		DownSlam = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true,Title = "True Downslam Tech", Icon = "box"})
		
		steps = 10
		duration = 0.1
		TrueDownslamConnection = nil
		
		DownSlam:Toggle({
		    Title = "True DownSlam",
		    Flag = "tsbtruedownslamtoggle",
		    Desc = "Dont hold M1 click slowly",
		    Value = false,
		    Callback = function(state)
		        PlayersService = game:GetService("Players")
		        RunServiceLocal = game:GetService("RunService")
		        WorkspaceLocal = game:GetService("Workspace")
		        LocalPlayerLocal = PlayersService.LocalPlayer
		        CameraLocal = WorkspaceLocal.CurrentCamera
		        
		        DownslamAnims = {
		            ["rbxassetid://13532600125"] = true,
		            ["rbxassetid://10469630950"] = true,
		            ["rbxassetid://13296577783"] = true,
		            ["rbxassetid://13370310513"] = true,
		            ["rbxassetid://15240216931"] = true,
		            ["rbxassetid://16515520431"] = true,
		            ["rbxassetid://17889461810"] = true
		        }
		        
		        DownslamHitAnims = {
		            ["rbxassetid://13532604085"] = true,
		            ["rbxassetid://10469639222"] = true,
		            ["rbxassetid://13295919399"] = true,
		            ["rbxassetid://13378751717"] = true,
		            ["rbxassetid://15240176873"] = true,
		            ["rbxassetid://16515448089"] = true,
		            ["rbxassetid://17889471098"] = true
		        }
		        
		        AnimCooldowns = {}
		        CharacterLocal = nil
		        
		        function GetCharacter()
		            char = LocalPlayerLocal.Character or LocalPlayerLocal.CharacterAdded:Wait()
		            hum = char:WaitForChild("Humanoid")
		            char.PrimaryPart = char:WaitForChild("HumanoidRootPart")
		            return char, hum
		        end
		        
		        function PerformTrueDownslam()
		            if CharacterLocal and CharacterLocal.PrimaryPart then
		                camSubject = CameraLocal.CameraSubject
		                CameraLocal.CameraSubject = nil
		                
		                currentPivot = CharacterLocal:GetPivot()
		                targetPivot = currentPivot + Vector3.new(0, 7, 0)
		                
		                for i = 1, steps do
		                    CharacterLocal:PivotTo(currentPivot:Lerp(targetPivot, i / steps))
		                    task.wait(duration / steps)
		                end
		                
		                CameraLocal.CameraSubject = camSubject
		            end
		        end
		        
		        if state then
		            if TrueDownslamConnection then
		                TrueDownslamConnection:Disconnect()
		            end
		            
		            char, hum = GetCharacter()
		            CharacterLocal = char
		            
		            TrueDownslamConnection = RunServiceLocal.RenderStepped:Connect(MV_CFF(function() 

		                if LocalPlayerLocal.Character ~= CharacterLocal then
		                    char, hum = GetCharacter()
		                    CharacterLocal = char
		                end
		                
		                for _, track in pairs(hum:GetPlayingAnimationTracks()) do
		                    animId = tostring(track.Animation.AnimationId)
		                    currentTime = tick()
		                    
		                    if DownslamAnims[animId] and (not AnimCooldowns[animId] or currentTime - AnimCooldowns[animId] > 0.5) then
		                        AnimCooldowns[animId] = currentTime
		                        task.delay(0.15, PerformTrueDownslam)
		                    elseif DownslamHitAnims[animId] and (not AnimCooldowns[animId] or currentTime - AnimCooldowns[animId] > 0.5) then
		                        AnimCooldowns[animId] = currentTime
		                        task.delay(0.15, function()
		                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
		                        end)
		                    end
		                end
		            end))
		        elseif TrueDownslamConnection then
		            TrueDownslamConnection:Disconnect()
		            TrueDownslamConnection = nil
		        end
		    end
		})
		
		DownSlam:Slider({
		    Title = "Speed of Tween",
		    Flag = "tsbdropdownspeedoftween",
		    Value = { Min = 1, Max = 20, Default = 10 },
		    Callback = function(num)
		    steps = num
		end
		})
		
		DownSlam:Slider({
		    Title = "Duration of Tween",
		    Flag = "tsbdropdowndurationoftween",
		    Value = { Min = 0, Max = 1, Default = 0.1 },
		    Step = 0.05,
		    Callback = function(num)
		    duration = num
		end
		})
		
		
		
		
		
		Grasp = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true,Title = "Grasp Techs", Icon = "box"})
		
		
		FlowingTeleportDistance = 24
		FlowingTeleportDelay = 1.8
		FlowingGraspAnimId = "rbxassetid://12273188754"
		FlowingGraspConnection = nil
		FlowingGraspEnabled = false
		
		Grasp:Toggle({
		    Title = "Flowing + Grasp",
		    Flag = "tsbflowinggrasptoggle",
		    Value = false,
		    Callback = function(state)
		        FlowingGraspEnabled = state
		        if FlowingGraspConnection then
		            FlowingGraspConnection:Disconnect()
		            FlowingGraspConnection = nil
		        end
		        
		        if FlowingGraspEnabled then
		            isAnimating = false
		            hasFired = false
		            
		            FlowingGraspConnection = game:GetService("RunService").RenderStepped:Connect(MV_CFF(function() 

		                char = LocalPlayerGame.Character
		                if not char then return end
		                
		                humanoid = char:FindFirstChild("Humanoid")
		                rootPart = char:FindFirstChild("HumanoidRootPart")
		                if not (humanoid and rootPart) then return end
		                
		                foundAnim = false
		                for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		                    if track.Animation and track.Animation.AnimationId == FlowingGraspAnimId then
		                        foundAnim = true
		                        break
		                    end
		                end
		                
		                if foundAnim and not (isAnimating or hasFired) then
		                    isAnimating = true
		                    hasFired = true
		                    
		                    task.delay(FlowingTeleportDelay, function()
		                        targetCFrame = rootPart.CFrame + rootPart.CFrame.LookVector * 24
		                        tween = TweenService:Create(rootPart, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = targetCFrame})
		                        tween:Play()
		                        tween.Completed:Wait()
		                        
		                        graspTool = LocalPlayerGame.Backpack:FindFirstChild("Hunter's Grasp")
		                        communicate = char:FindFirstChild("Communicate")
		                        if graspTool and communicate then
		                            communicate:FireServer(unpack({{Tool = graspTool, Goal = "Console Move"}}))
		                        end
		                        
		                        isAnimating = false
		                    end)
		                elseif not foundAnim then
		                    hasFired = false
		                end
		            end))
		        end
		    end
		})
		
		
		Grasp:Slider({
		    Title = "Teleport Delay Of Flowing + Grasp",
		    Flag = "tsbflowinggraspteleportdeley",
		    Value = { Min = 0, Max = 5, Default = 1.8 },
		    Step = 0.1,
		    Callback = function(num)
		    FlowingTeleportDelay = num
		end
		})
		
		Grasp:Slider({
		    Title = "Teleport Distance Of Flowing + Grasp",
		    Flag = "tsbflowinggraspdistance",
		    Value = { Min = 0, Max = 50, Default = 24 },
		    Step = 1,
		    Callback = function(num)
		    FlowingTeleportDistance = num
		end
		})
		
		Grasp:Divider()
		
		
		UpperGraspDelay = 0.18
		UpperGraspUpwards = 8
		UpperGraspAnimId = "rbxassetid://10503381238"
		UpperGraspOffset = Vector3.new(0, UpperGraspUpwards, 0)
		UpperGraspEnabled = false
		UpperGraspConnection = nil
		
		Grasp:Toggle({
		    Title = "Upper + Grasp",
		    Flag = "tsbuppergrasptoggle",
		    Value = false,
		    Callback = function(state)
		        UpperGraspEnabled = state
		        if UpperGraspConnection then
		            UpperGraspConnection:Disconnect()
		            UpperGraspConnection = nil
		        end
		        
		        if UpperGraspEnabled then
		            isAnimating = false
		            hasFired = false
		            onCooldown = false
		            
		            UpperGraspConnection = game:GetService("RunService").RenderStepped:Connect(MV_CFF(function() 

		                char = LocalPlayerGame.Character
		                rootPart = char and char:FindFirstChild("HumanoidRootPart")
		                humanoid = char and char:FindFirstChild("Humanoid")
		                
		                if not (char and rootPart and humanoid) then return end
		                
		                foundAnim = false
		                for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		                    if track.Animation and track.Animation.AnimationId == UpperGraspAnimId then
		                        foundAnim = true
		                        break
		                    end
		                end
		                
		                if foundAnim and not (isAnimating or hasFired or onCooldown) then
		                    isAnimating = true
		                    hasFired = true
		                    onCooldown = true
		                    
		                    task.delay(UpperGraspDelay, function()
		                        closestTorso = nil
		                        closestDist = 7
		                        liveFolder = workspace:FindFirstChild("Live")
		                        
		                        if liveFolder then
		                            for _, model in ipairs(liveFolder:GetChildren()) do
		                                if model:IsA("Model") and model ~= char then
		                                    torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
		                                    if torso then
		                                        dist = (rootPart.Position - torso.Position).Magnitude
		                                        if dist <= closestDist then
		                                            closestDist = dist
		                                            closestTorso = torso
		                                        end
		                                    end
		                                end
		                            end
		                        end
		                        
		                        if closestTorso then
		                            targetPos = closestTorso.Position + UpperGraspOffset
		                            tween = TweenService:Create(rootPart, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {CFrame = 
		                            CFrame.new(targetPos)})
		                            tween:Play()
		                            tween.Completed:Wait()
		                        end
		                        
		                        graspTool = LocalPlayerGame.Backpack:FindFirstChild("Hunter's Grasp")
		                        communicate = char:FindFirstChild("Communicate")
		                        if graspTool and communicate then
		                            communicate:FireServer(unpack({{Tool = graspTool, Goal = "Console Move"}}))
		                        end
		                        
		                        isAnimating = false
		                        task.delay(15, function()
		                            onCooldown = false
		                        end)
		                    end)
		                elseif not foundAnim then
		                    hasFired = false
		                end
		            end))
		        end
		    end
		})
		
		
		Grasp:Slider({
		    Title = "Teleport Delay Of Uppercut + Grasp",
		    Flag = "tsbuppercutgraspteleportdeley",
		    Value = { Min = 0, Max = 5, Default = 1.8 },
		    Step = 0.01,
		    Callback = function(num)
		    UpperGraspDelay = num
		end
		})
		
		Grasp:Slider({
		    Title = "Teleport Upwards Distance Of Uppercut + Grasp",
		    Flag = "tsbuppercutgraspteleportdistance",
		    Value = { Min = 0, Max = 15, Default = 8 },
		    Step = 1,
		    Callback = function(num)
		    UpperGraspUpwards = num
		end
		})
		
		
		
		
		
		
		
		
		
		
		gojo = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true,Title = "Zenci Tech", Icon = "box"})
		
		UpperDashPitch = 0
		UpperDashTpStartDelay = 0.18 
		UpperDashDashDelay = 0.5
		UpperDashUpwards = 8
		UpperDashTpDuration = 1.0
		UpperDashAnimId = "rbxassetid://10503381238"
		UpperDashEnabled = false
		UpperDashConnection = nil
		
		gojo:Toggle({
		    Title = "Upper + Dash",
		    Flag = "tsbupperdashtoggle",
		    Value = false,
		    Callback = function(state)
		        UpperDashEnabled = state
		        if UpperDashConnection then
		            UpperDashConnection:Disconnect()
		            UpperDashConnection = nil
		        end
		        
		        if UpperDashEnabled then
		            isAnimating = false
		            hasFired = false
		            onCooldown = false
		            
		            UpperDashConnection = game:GetService("RunService").RenderStepped:Connect(MV_CFF(function() 

		                char = LocalPlayerGame.Character
		                rootPart = char and char:FindFirstChild("HumanoidRootPart")
		                humanoid = char and char:FindFirstChild("Humanoid")
		                
		                if not (char and rootPart and humanoid) then return end
		                
		                foundAnim = false
		                for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		                    if track.Animation and track.Animation.AnimationId == UpperDashAnimId then
		                        foundAnim = true
		                        break
		                    end
		                end
		                
		                if foundAnim and not (isAnimating or hasFired or onCooldown) then
		                    isAnimating = true
		                    hasFired = true
		                    onCooldown = true
		                    
		                    local originalCFrame = rootPart.CFrame
		
		                    task.delay(UpperDashDashDelay, function()
		                        args = {{Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress"}}
		                        local dashChar = LocalPlayerGame.Character
		                        if dashChar and dashChar:FindFirstChild("Communicate") then
		                            dashChar.Communicate:FireServer(unpack(args))
		                        end
		                    end)
		
		                    task.delay(UpperDashTpStartDelay, function()
		                        closestTorso = nil
		                        closestDist = 7
		                        liveFolder = workspace:FindFirstChild("Live")
		                        
		                        if liveFolder then
		                            for _, model in ipairs(liveFolder:GetChildren()) do
		                                if model:IsA("Model") and model ~= char then
		                                    torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
		                                    if torso then
		                                        dist = (originalCFrame.Position - torso.Position).Magnitude
		                                        if dist <= closestDist then
		                                            closestDist = dist
		                                            closestTorso = torso
		                                        end
		                                    end
		                                end
		                            end
		                        end
		                        
		                        if closestTorso then
		                            local startTime = tick()
		                            
		                            while tick() - startTime <= UpperDashTpDuration do
		                                if not closestTorso or not closestTorso.Parent then break end
		                                
		                                targetPos = closestTorso.Position + Vector3.new(0, UpperDashUpwards, 0)
		                                local targetCFrame = CFrame.new(targetPos) * CFrame.Angles(math.rad(UpperDashPitch), 0, 0)
		                                
		                                if rootPart then
		                                    rootPart.CFrame = targetCFrame
		                                end
		                                task.wait() 
		                            end
		                        end
		
		                        if rootPart then
		                            rootPart.CFrame = originalCFrame
		                        end
		                        
		                        isAnimating = false
		                        task.delay(15, function()
		                            onCooldown = false
		                        end)
		                    end)
		                    
		                elseif not foundAnim then
		                    hasFired = false
		                end
		            end))
		        end
		    end
		})
		
		gojo:Slider({
		    Title = "Teleport Start Delay",
		    Flag = "tsbuppercutdashtpstartdelay",
		    Value = { Min = 0, Max = 5, Default = 0.18 },
		    Step = 0.01,
		    Callback = function(num)
		        UpperDashTpStartDelay = num
		    end
		})
		
		gojo:Slider({
		    Title = "Dash Delay",
		    Flag = "tsbuppercutdashdashdelay",
		    Value = { Min = 0, Max = 5, Default = 0.5 },
		    Step = 0.01,
		    Callback = function(num)
		        UpperDashDashDelay = num
		    end
		})
		
		gojo:Slider({
		    Title = "Teleport Upwards Distance",
		    Flag = "tsbuppercutdashteleportdistance",
		    Value = { Min = -15, Max = 15, Default = 8 },
		    Step = 1,
		    Callback = function(num)
		        UpperDashUpwards = num
		    end
		})
		
		gojo:Slider({
		    Title = "Teleport Duration (Seconds)",
		    Flag = "tsbuppercutdashtpduration",
		    Value = { Min = 0, Max = 3, Default = 1.0 },
		    Step = 0.1,
		    Callback = function(num)
		        UpperDashTpDuration = num
		    end
		})
		
		gojo:Slider({
		    Title = "Look Angle (Up/Down)",
		    Flag = "tsbupperdashpitchanglegojo",
		    Value = { Min = -90, Max = 90, Default = 0 },
		    Step = 1,
		    Callback = function(num)
		        UpperDashPitch = num
		    end
		})
		
		
		
		
		
		
		
		
		do
		    VIM_HD      = game:GetService("VirtualInputManager")
		    TS_HD       = game:GetService("TweenService")
		
		    HD_Enabled    = false
		    HD_Locked     = nil
		    HD_LockKey    = Enum.KeyCode.K
		    HD_DashKey    = Enum.KeyCode.C
		    HD_Side       = "Left"
		    HD_MaxDist    = 50
		    HD_Offset     = 4
		    HD_Hold       = 0.18
		    HD_TweenTime  = 0.18
		    HD_M1Delay    = 0.12
		    HD_AnimSpeed  = 1.0
		    HD_QDelay     = 0.05
		    HD_QHold      = 0.06
		    HD_Busy       = false
		    HD_Highlight  = nil
		    HD_AnimCache  = {}
		
		    local function HD_getRoot(model)
		        if not model then return nil end
		        return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
		    end
		
		    local function HD_isAlive(model)
		        if not model or not model.Parent then return false end
		        local h = model:FindFirstChildOfClass("Humanoid")
		        return h and h.Health > 0
		    end
		
		    local function HD_clearHL()
		        if HD_Highlight then HD_Highlight:Destroy(); HD_Highlight = nil end
		    end
		
		    local function HD_applyHL(model)
		        HD_clearHL()
		        if not model then return end
		        local ok, hl = pcall(Instance.new, "Highlight")
		        if ok and hl then
		            hl.FillColor           = Color3.fromRGB(140, 60, 255)
		            hl.OutlineColor        = Color3.fromRGB(200, 120, 255)
		            hl.FillTransparency    = 0.7
		            hl.OutlineTransparency = 0.2
		            hl.Adornee             = model
		            hl.Parent              = CoreGui
		            HD_Highlight           = hl
		        else
		            local sel               = Instance.new("SelectionBox")
		            sel.Color3              = Color3.fromRGB(160, 60, 255)
		            sel.LineThickness       = 0.04
		            sel.SurfaceTransparency = 0.9
		            sel.SurfaceColor3       = Color3.fromRGB(140, 0, 255)
		            sel.Adornee             = model
		            sel.Parent              = CoreGui
		            HD_Highlight            = sel
		        end
		    end
		
		    local function HD_lock()
		        local char   = LocalPlayer.Character
		        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
		        if not myRoot then return end
		        local live = workspace:FindFirstChild("Live")
		        if not live then return end
		        local best, bestDist = nil, HD_MaxDist
		        for _, model in ipairs(live:GetChildren()) do
		            if model.Name ~= LocalPlayer.Name and model:IsA("Model") then
		                local hum  = model:FindFirstChildOfClass("Humanoid")
		                local root = HD_getRoot(model)
		                if hum and hum.Health > 0 and root then
		                    local d = (myRoot.Position - root.Position).Magnitude
		                    if d < bestDist then bestDist = d; best = model end
		                end
		            end
		        end
		        if best then
		            HD_Locked = best
		            HD_applyHL(best)
		            WindUI:Notify({ Title = "Hook Dash", Content = "Locked: " .. best.Name, Duration = 1.5, Icon = "crosshair" })
		        else
		            HD_Locked = nil
		            HD_clearHL()
		            WindUI:Notify({ Title = "Hook Dash", Content = "No target within " .. HD_MaxDist .. " studs", Duration = 1.5, Icon = "x-circle" })
		        end
		    end
		
		    local function HD_playAnim()
		        local char = LocalPlayer.Character
		        if not char then return end
		        local hum  = char:FindFirstChildOfClass("Humanoid")
		        if not hum then return end
		        local animator = hum:FindFirstChildOfClass("Animator")
		        if not animator then
		            animator = Instance.new("Animator")
		            animator.Parent = hum
		        end
		        local animId = 10480793962
		        local anim = HD_AnimCache[animId]
		        if not anim then
		            anim = Instance.new("Animation")
		            anim.AnimationId = "rbxassetid://" .. animId
		            HD_AnimCache[animId] = anim
		        end
		        local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
		        if not ok or not track then return end
		        track.Priority = Enum.AnimationPriority.Action
		        track:Play()
		        pcall(function() track:AdjustSpeed(HD_AnimSpeed) end)
		    end
		
		    local function HD_fireDash(side)
		        local moveKey = (side == "Left") and Enum.KeyCode.A or Enum.KeyCode.D
		        task.spawn(HD_playAnim)
		        VIM_HD:SendKeyEvent(true, moveKey, false, game)
		        task.delay(HD_QDelay, function()
		            VIM_HD:SendKeyEvent(true,  Enum.KeyCode.Q, false, game)
		            task.wait(HD_QHold)
		            VIM_HD:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
		        end)
		        task.delay(HD_Hold, function()
		            VIM_HD:SendKeyEvent(false, moveKey, false, game)
		        end)
		    end
		
		    local function HD_do()
		        if HD_Busy then return end
		        local char   = LocalPlayer.Character
		        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
		        if not myRoot then return end
		        if not HD_Locked or not HD_isAlive(HD_Locked) then
		            HD_lock()
		            if not HD_Locked then return end
		        end
		        local enemyRoot = HD_getRoot(HD_Locked)
		        if not enemyRoot then return end
		        if (myRoot.Position - enemyRoot.Position).Magnitude > HD_MaxDist then
		            WindUI:Notify({ Title = "Hook Dash", Content = "Too far — get closer", Duration = 1.5, Icon = "alert-circle" })
		            return
		        end
		        HD_Busy = true
		
		        local dir = Vector3.new(
		            enemyRoot.Position.X - myRoot.Position.X, 0,
		            enemyRoot.Position.Z - myRoot.Position.Z)
		        if dir.Magnitude > 0.1 then
		            myRoot.CFrame = CFrame.lookAt(myRoot.Position, myRoot.Position + dir)
		        end
		
		        HD_fireDash(HD_Side)
		        task.wait(HD_Hold + 0.12)
		
		        enemyRoot = HD_getRoot(HD_Locked)
		        if not enemyRoot then HD_Busy = false; return end
		
		        local eCF       = enemyRoot.CFrame
		        local behindPos = eCF.Position + (eCF.LookVector * -HD_Offset)
		        local lookTarget = Vector3.new(eCF.Position.X, behindPos.Y, eCF.Position.Z)
		        local finalCF    = CFrame.lookAt(behindPos, lookTarget)
		        local tween = TS_HD:Create(myRoot,
		            TweenInfo.new(HD_TweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		            { CFrame = finalCF })
		        tween:Play()
		        tween.Completed:Wait()
		
		        enemyRoot = HD_getRoot(HD_Locked)
		        if enemyRoot then
		            local myPos    = myRoot.Position
		            local enemyPos = Vector3.new(enemyRoot.Position.X, myPos.Y, enemyRoot.Position.Z)
		            if (myPos - enemyPos).Magnitude > 0.1 then
		                myRoot.CFrame = CFrame.lookAt(myPos, enemyPos)
		            end
		        end
		
		        enemyRoot = HD_getRoot(HD_Locked)
		        if enemyRoot then
		            local camera = workspace.CurrentCamera
		            if camera then
		                local myPos    = myRoot.Position
		                local enemyPos = enemyRoot.Position
		                local backDir  = (myPos - enemyPos).Unit
		                local camPos   = myPos + backDir * 6 + Vector3.new(0, 2, 0)
		                local camTarget = Vector3.new(enemyPos.X, myPos.Y + 1.5, enemyPos.Z)
		                camera.CFrame = CFrame.lookAt(camPos, camTarget)
		            end
		        end
		
		        task.wait(HD_M1Delay)
		        task.spawn(function()
		            local c = LocalPlayer.Character
		            local communicate = c and c:FindFirstChild("Communicate")
		            if not communicate then return end
		            pcall(function() communicate:FireServer(unpack({{Goal = "LeftClick", Mobile = true}})) end)
		            task.wait(0.1)
		            pcall(function() communicate:FireServer(unpack({{Goal = "LeftClickRelease", Mobile = true}})) end)
		        end)
		
		        HD_Busy = false
		    end
		
		    game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
		        if gpe or game:GetService("UserInputService"):GetFocusedTextBox() then return end
		        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		        if not HD_Enabled then return end
		        if input.KeyCode == HD_LockKey then HD_lock()
		        elseif input.KeyCode == HD_DashKey then task.spawn(HD_do) end
		    end)
		
		    game:GetService("RunService").Heartbeat:Connect(MV_CFF(function() 

		        if HD_Locked and not HD_isAlive(HD_Locked) then
		            HD_Locked = nil; HD_clearHL()
		        end
		    end))
		    
		
		    HookDashMultiSection = Tabs.Tech:MultiSection({
	            Title = "Hook Dash",
	            Icon = "fishing-hook",
	            Opened = true,
	            Box = true,
	            BoxBorder = true,
	        })
		
		    local SecHD_Controls = HookDashMultiSection:Section({Opened = true, Box = true, BoxBorder = true, Title = "Controls", Icon = "zap" })
		
		    SecHD_Controls:Toggle({
		        Title    = "Enable Hook Dash",
		        Desc     = "Enables K / C keybinds only — on-screen buttons work WITHOUT this",
		        Value    = false,
		        Callback = function(v)
		            HD_Enabled = v
		            if not v then HD_Locked = nil; HD_clearHL() end
		        end,
		    })
		
		    SecHD_Controls:Keybind({
		        Title    = "Lock Key",
		        Desc     = "Lock onto nearest enemy in workspace.Live",
		        Value    = "K",
		        Callback = function(v) pcall(function() HD_LockKey = Enum.KeyCode[v] end) end,
		    })
		
		    SecHD_Controls:Keybind({
		        Title    = "Dash Key",
		        Desc     = "Execute the hook dash",
		        Value    = "C",
		        Callback = function(v) pcall(function() HD_DashKey = Enum.KeyCode[v] end) end,
		    })
		
		    SecHD_Controls:Dropdown({
		        Title    = "Dash Direction",
		        Desc     = "Left = A+Q  |  Right = D+Q",
		        Values   = { "Left", "Right" },
		        Value    = "Left",
		        Callback = function(v) HD_Side = v end,
		    })
		
		    SecHD_Controls:Button({
		        Title    = "Lock Now",
		        Icon     = "crosshair",
		        Justify  = "Center",
		        Callback = function() HD_lock() end,
		    })
		
		    SecHD_Controls:Button({
		        Title    = "Dash Now",
		        Icon     = "zap",
		        Justify  = "Center",
		        Callback = function() task.spawn(HD_do) end,
		    })
		
		    local SecHD_Tuning = HookDashMultiSection:Section({Opened = true, Box = true, BoxBorder = true, Title = "Targeting", Icon = "settings" })
		
		    SecHD_Tuning:Slider({
		        Title    = "Lock Range (studs)",
		        Desc     = "Max distance to lock a target",
		        Step     = 1,
		        Value    = { Min = 10, Max = 150, Default = 50 },
		        Callback = function(v) HD_MaxDist = v end,
		    })
		
		    SecHD_Tuning:Slider({
		        Title    = "Behind Offset (studs)",
		        Desc     = "How far behind the enemy you land",
		        Step     = 1,
		        Value    = { Min = 1, Max = 12, Default = 4 },
		        Callback = function(v) HD_Offset = v end,
		    })
		
		    local SecHD_Timing = HookDashMultiSection:Section({Opened = true, Box = true, BoxBorder = true, Title = "Timing (Legit)", Icon = "timer" })
		
		    SecHD_Timing:Slider({
		        Title    = "Hold Duration (ms)",
		        Desc     = "How long A or D is held — lower = faster dash",
		        Step     = 5,
		        Value    = { Min = 60, Max = 300, Default = 180 },
		        Callback = function(v) HD_Hold = v / 1000 end,
		    })
		
		    SecHD_Timing:Slider({
		        Title    = "Q Tap Delay (ms)",
		        Desc     = "Delay before Q is pressed after movement key",
		        Step     = 5,
		        Value    = { Min = 20, Max = 150, Default = 50 },
		        Callback = function(v) HD_QDelay = v / 1000 end,
		    })
		
		    SecHD_Timing:Slider({
		        Title    = "Q Hold Duration (ms)",
		        Desc     = "How long Q is held during the dash input",
		        Step     = 5,
		        Value    = { Min = 20, Max = 150, Default = 60 },
		        Callback = function(v) HD_QHold = v / 1000 end,
		    })
		
		    SecHD_Timing:Slider({
		        Title    = "Tween Speed (ms)",
		        Desc     = "How fast you slide behind the enemy after dash",
		        Step     = 10,
		        Value    = { Min = 50, Max = 500, Default = 180 },
		        Callback = function(v) HD_TweenTime = v / 1000 end,
		    })
		
		    SecHD_Timing:Slider({
		        Title    = "M1 Fire Delay (ms)",
		        Desc     = "Delay before M1 hits after landing behind enemy",
		        Step     = 5,
		        Value    = { Min = 0, Max = 300, Default = 120 },
		        Callback = function(v) HD_M1Delay = v / 1000 end,
		    })
		
		    SecHD_Timing:Slider({
		        Title    = "Dash Anim Speed",
		        Desc     = "Playback speed of the side dash animation",
		        Step     = 0.1,
		        Value    = { Min = 0.5, Max = 2.0, Default = 1.0 },
		        Callback = function(v) HD_AnimSpeed = v end,
		    })
		
		    local HD_lockMobileGui = nil
		    local HD_dashMobileGui = nil
		
		    local function HD_makeMobileButton(guiName, label, accentColor, startX, startY, onPress)
		        local gui              = Instance.new("ScreenGui")
		        gui.Name               = guiName
		        gui.ResetOnSpawn       = false
		        gui.ZIndexBehavior     = Enum.ZIndexBehavior.Global
		        gui.DisplayOrder       = 9999
		        gui.IgnoreGuiInset     = true
		        gui.Parent             = LocalPlayer:WaitForChild("PlayerGui")
		
		        local frame            = Instance.new("Frame")
		        frame.Size             = UDim2.new(0, 120, 0, 54)
		        frame.Position         = UDim2.new(0, startX, 0, startY)
		        frame.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
		        frame.BorderSizePixel  = 0
		        frame.Active           = true
		        frame.Parent           = gui
		        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
		
		        local stroke           = Instance.new("UIStroke")
		        stroke.Color           = accentColor
		        stroke.Thickness       = 1.4
		        stroke.Transparency    = 0.3
		        stroke.Parent          = frame
		
		        local bar              = Instance.new("Frame")
		        bar.Size               = UDim2.new(0, 3, 0, 28)
		        bar.Position           = UDim2.new(0, 8, 0.5, -14)
		        bar.BackgroundColor3   = accentColor
		        bar.BorderSizePixel    = 0
		        bar.Parent             = frame
		        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
		
		        local lbl              = Instance.new("TextLabel")
		        lbl.Size               = UDim2.new(1, -26, 1, 0)
		        lbl.Position           = UDim2.new(0, 22, 0, 0)
		        lbl.BackgroundTransparency = 1
		        lbl.Text               = label
		        lbl.TextColor3         = Color3.fromRGB(230, 230, 240)
		        lbl.Font               = Enum.Font.GothamBold
		        lbl.TextSize           = 13
		        lbl.TextXAlignment     = Enum.TextXAlignment.Left
		        lbl.Parent             = frame
		
		        local hitBtn           = Instance.new("TextButton")
		        hitBtn.Size            = UDim2.new(1, 0, 1, 0)
		        hitBtn.BackgroundTransparency = 1
		        hitBtn.Text            = ""
		        hitBtn.ZIndex          = 3
		        hitBtn.AutoButtonColor = false
		        hitBtn.Parent          = frame
		
		        local pressedColor = Color3.new(accentColor.R * 0.25, accentColor.G * 0.25, accentColor.B * 0.25)
		        local normalColor  = Color3.fromRGB(10, 10, 16)
		
		        hitBtn.InputBegan:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.MouseButton1
		            or input.UserInputType == Enum.UserInputType.Touch then
		                TS_HD:Create(frame,
		                    TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		                    { BackgroundColor3 = pressedColor }
		                ):Play()
		                stroke.Transparency = 0.0
		            end
		        end)
		
		        hitBtn.InputEnded:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.MouseButton1
		            or input.UserInputType == Enum.UserInputType.Touch then
		                TS_HD:Create(frame,
		                    TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		                    { BackgroundColor3 = normalColor }
		                ):Play()
		                stroke.Transparency = 0.3
		                task.spawn(onPress)
		            end
		        end)
		
		        local dragging, dragStart, startPos2 = false, nil, nil
		        frame.InputBegan:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.MouseButton1
		            or input.UserInputType == Enum.UserInputType.Touch then
		                dragging  = true
		                dragStart = input.Position
		                startPos2 = Vector2.new(frame.Position.X.Offset, frame.Position.Y.Offset)
		                input.Changed:Connect(function()
		                    if input.UserInputState == Enum.UserInputState.End then
		                        dragging = false
		                    end
		                end)
		            end
		        end)
		        frame.InputChanged:Connect(function(input)
		            if not dragging then return end
		            if input.UserInputType == Enum.UserInputType.MouseMovement
		            or input.UserInputType == Enum.UserInputType.Touch then
		                local delta = input.Position - dragStart
		                frame.Position = UDim2.new(0, startPos2.X + delta.X, 0, startPos2.Y + delta.Y)
		            end
		        end)
		
		        return gui
		    end
		
		    local HD_lockPCGui     = nil
		    local HD_dashPCGui     = nil
		
		    local function HD_destroyMobileUI()
		        if HD_lockMobileGui then HD_lockMobileGui:Destroy(); HD_lockMobileGui = nil end
		        if HD_dashMobileGui then HD_dashMobileGui:Destroy(); HD_dashMobileGui = nil end
		    end
		
		    local function HD_destroyPCUI()
		        if HD_lockPCGui then HD_lockPCGui:Destroy(); HD_lockPCGui = nil end
		        if HD_dashPCGui then HD_dashPCGui:Destroy(); HD_dashPCGui = nil end
		    end
		
		    local function HD_createMobileUI()
		        HD_destroyMobileUI()
		        HD_lockMobileGui = HD_makeMobileButton("HD_LockGui_M", "Lock Target", Color3.fromHex("#7c3aed"), 20,  80, function() HD_lock() end)
		        HD_dashMobileGui = HD_makeMobileButton("HD_DashGui_M", "Hook Dash",  Color3.fromHex("#be123c"), 155, 80, function() task.spawn(HD_do) end)
		    end
		
		    local function HD_createPCUI()
		        HD_destroyPCUI()
		        HD_lockPCGui = HD_makeMobileButton("HD_LockGui_PC", "Lock Target", Color3.fromHex("#7c3aed"), 20,  500, function() HD_lock() end)
		        HD_dashPCGui = HD_makeMobileButton("HD_DashGui_PC", "Hook Dash",  Color3.fromHex("#be123c"), 155, 500, function() task.spawn(HD_do) end)
		    end
		
		    local SecHD_Mobile = Tabs.Tech:Section({Opened = true, Box = true, BoxBorder = true, Title = "Hook Dash — On-Screen Buttons", Icon = "smartphone" })
		
		    SecHD_Mobile:Toggle({
		        Title    = "Show Mobile Buttons",
		        Desc     = "Buttons appear near the TOP of screen — for mobile players",
		        Value    = false,
		        Callback = function(v)
		            if v then HD_createMobileUI() else HD_destroyMobileUI() end
		        end,
		    })
		
		    SecHD_Mobile:Toggle({
		        Title    = "Show PC Buttons",
		        Desc     = "Buttons appear near the BOTTOM of screen — for PC players",
		        Value    = false,
		        Callback = function(v)
		            if v then HD_createPCUI() else HD_destroyPCUI() end
		        end,
		    })
		
		end
	end)
end















-- ================ LAG0 TAB0 ================ --
function LagTab()
    task.spawn(function()
        do
	        local lighting = game:GetService("Lighting")
	        local settingsService = game:GetService("Settings")
	        local starterGui = game:GetService("StarterGui")
	        local runService = game:GetService("RunService")
	        local thrownFolder = workspace:WaitForChild("Thrown")
	        local mapFolder = workspace:FindFirstChild("Map")
	
	        local thrownChildAddedConnection = nil
	        local debrisDescendantAddedConnection = nil
	        local cleanupHeartbeatConnection = nil
	        local hiddenPartsCache = {}
        end

        local function toggleMapPartVisibility(partName, shouldBeVisible)
            if not mapFolder then return end
            local part = mapFolder:FindFirstChild(partName)
            if shouldBeVisible then
                if not part and hiddenPartsCache[partName] then
                    hiddenPartsCache[partName].Parent = mapFolder
                    hiddenPartsCache[partName] = nil
                end
            else
                if part then
                    hiddenPartsCache[partName] = part
                    part.Parent = nil
                end
            end
        end

        local optimizeSection = Tabs.Lag:Section({
            Opened = true, Box = true, BoxBorder = true,
            Title = "Performance Optimizations", Icon = "zap"
        })

        optimizeSection:Button({
            Title = "Optimize Game Performance",
            Callback = function()
                lighting.GlobalShadows = false
                lighting.FogEnd = 9e9
                lighting.Brightness = 0

                settingsService.Rendering.QualityLevel = "Level01"

                local terrain = workspace.Terrain
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 0

                local optimizedCount = 0
                for _, descendant in ipairs(workspace:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        if descendant:IsA("MeshPart") then
                            descendant.Material = "Plastic"
                            descendant.Reflectance = 0
                            optimizedCount = optimizedCount + 1
                        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                            descendant.Transparency = 1
                            optimizedCount = optimizedCount + 1
                        end
                    elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Lifetime = NumberRange.new(0)
                        optimizedCount = optimizedCount + 1
                    elseif descendant:IsA("Fire") or descendant:IsA("SpotLight") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
                        descendant.Enabled = false
                        optimizedCount = optimizedCount + 1
                    end
                end

                starterGui:SetCore("SendNotification", {
                    Title = "Performance Optimized",
                    Text = string.format("Optimized %d objects", optimizedCount),
                    Duration = 3
                })
            end
        })

        optimizeSection:Toggle({
            Title = "Remove Debris & Thrown",
            Flag = "tsbremovedebris",
            Value = false,
            Callback = function(state)
                if state then
                    thrownChildAddedConnection = thrownFolder.ChildAdded:Connect(function(obj)
                        obj.Parent = nil
                    end)

                    debrisDescendantAddedConnection = workspace.DescendantAdded:Connect(function(obj)
                        if obj:IsA("BasePart") and obj.Name:lower():match("^debris") then
                            obj.Parent = nil
                        end
                    end)

                    cleanupHeartbeatConnection = runService.Heartbeat:Connect(MV_CFF(function() 

                        if #thrownFolder:GetChildren() > 0 then
                            thrownFolder:ClearAllChildren()
                        end
                    end))
                else
                    if thrownChildAddedConnection then
                        thrownChildAddedConnection:Disconnect()
                        thrownChildAddedConnection = nil
                    end
                    if debrisDescendantAddedConnection then
                        debrisDescendantAddedConnection:Disconnect()
                        debrisDescendantAddedConnection = nil
                    end
                    if cleanupHeartbeatConnection then
                        cleanupHeartbeatConnection:Disconnect()
                        cleanupHeartbeatConnection = nil
                    end
                end
            end
        })

        local mapFolder = workspace:FindFirstChild("Map")
		local function toggleMapPartVisibility(name, state)
		    if not mapFolder then return end
		    
		    for _, obj in ipairs(mapFolder:GetDescendants()) do
		        if obj.Name == name and (obj:IsA("BasePart") or obj:IsA("Decal")) then
		            obj.Transparency = state and 0 or 1
		            if obj:IsA("BasePart") then
		                obj.CanCollide = state
		            end
		        end
		    end
		end
		
		local hidePartsSection = Tabs.Lag:Section({
		    Opened = true, 
		    Box = true, 
		    BoxBorder = true,
		    Title = "Hide Parts", 
		    Icon = "package"
		})
		
		if mapFolder then
		    hidePartsSection:Toggle({
		        Title = "Trees",
		        Flag = "tsbtreesremove",
		        Value = true,
		        Callback = function(state)
		            toggleMapPartVisibility("Trees", state)
		        end
		    })
		
		    hidePartsSection:Toggle({
		        Title = "Walls",
		        Flag = "tsbwallsremove",
		        Value = true,
		        Callback = function(state)
		            toggleMapPartVisibility("Walls", state)
		        end
		    })
		
		    hidePartsSection:Toggle({
		        Title = "Grass",
		        Flag = "tsbgrassremove",
		        Value = true,
		        Callback = function(state)
		            toggleMapPartVisibility("Grass", state)
		            toggleMapPartVisibility("GrassBottom", state)
		        end
		    })
		
		    hidePartsSection:Toggle({
		        Title = "Benches",
		        Flag = "tsbbenchesremove",
		        Value = true,
		        Callback = function(state)
		            toggleMapPartVisibility("Benches", state)
		        end
		    })
		
		    task.spawn(function()
		        toggleMapPartVisibility("Trees", false)
		        toggleMapPartVisibility("Walls", false)
		        toggleMapPartVisibility("Grass", false)
		        toggleMapPartVisibility("GrassBottom", false)
		        toggleMapPartVisibility("Benches", false)
		    end)
		end
    end)
end















-- ================ ANIMATION0 TAB0 ================ --
function AnimationTab()
	task.spawn(function()
		local playersService = game:GetService("Players")
		local localPlayer = playersService.LocalPlayer
		local starterGui = game:GetService("StarterGui")

		local animationSettings = {
			noAnim = {
				enabled = false,
				connection = nil,
				deathConnection = nil,
				ignoreAnimationId = "136370737633649"
			},
			logger = {
				enabled = false,
				loggedAnims = {},
				dropdownList = {},
				selectedAnimId = nil,
				dropdownObj = nil
			}
		}

		local function stopAllAnimationsOnCharacter()
			local char = localPlayer.Character
			if not char then return end
			local humanoid = char:FindFirstChild("Humanoid")
			if not humanoid then return end
			for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
				track:Stop()
			end
		end

		local playStopSection = Tabs.Anim:Section({Opened = true, Box = true, BoxBorder = true, Title = "Play/Stop", Icon = "eye"})

		local function setupNoAnimationControl()
			local char = localPlayer.Character
			if not char then return end
			local humanoid = char:FindFirstChild("Humanoid")
			if not humanoid then
				humanoid = char:WaitForChild("Humanoid")
			end

			if animationSettings.noAnim.connection then
				animationSettings.noAnim.connection:Disconnect()
			end
			if animationSettings.noAnim.deathConnection then
				animationSettings.noAnim.deathConnection:Disconnect()
			end

			local function onAnimationPlayed(track)
				local animId = track.Animation and track.Animation.AnimationId:match("%d+")
				if animId and animId ~= animationSettings.noAnim.ignoreAnimationId then
					track:Stop()
				end
			end

			animationSettings.noAnim.connection = humanoid.AnimationPlayed:Connect(onAnimationPlayed)
			animationSettings.noAnim.deathConnection = humanoid.Died:Connect(function()
				setupNoAnimationControl()
			end)
		end

		playStopSection:Toggle({
			Title = "No Animation",
			Flag = "tsbnoanimtoggle",
			Value = false,
			Callback = function(state)
				animationSettings.noAnim.enabled = state
				if state then
					setupNoAnimationControl()
				else
					if animationSettings.noAnim.connection then
						animationSettings.noAnim.connection:Disconnect()
						animationSettings.noAnim.connection = nil
					end
					if animationSettings.noAnim.deathConnection then
						animationSettings.noAnim.deathConnection:Disconnect()
						animationSettings.noAnim.deathConnection = nil
					end
				end
			end
		})


		local loggerSection = Tabs.Anim:Section({Opened = true, Box = true, BoxBorder = true, Title = "Animation Logger", Icon = "scroll-text"})

		local function updateLoggerDropdown()
			local options = #animationSettings.logger.dropdownList > 0 and animationSettings.logger.dropdownList or {"No Animation Logged Yet.."}
			animationSettings.logger.dropdownObj:Refresh(options)
		end

		local function onAnimationLogged(track)
			if not animationSettings.logger.enabled then return end
			local anim = track.Animation
			if not anim then return end
			local animId = anim.AnimationId:match("%d+")
			if not animId then return end

			if not animationSettings.logger.loggedAnims[animId] then
				animationSettings.logger.loggedAnims[animId] = true
				local animName = (anim.Name == "Animation" or anim.Name == "") and "Anim" or anim.Name
				local formatted = animName .. " | ID: " .. animId
				table.insert(animationSettings.logger.dropdownList, formatted)
				updateLoggerDropdown()
			end
		end

		local function setupCharacterAnimationListener(char)
			if not char then return end
			local humanoid = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid", 10)
			if not humanoid then return end
			humanoid.AnimationPlayed:Connect(onAnimationLogged)
		end

		if localPlayer.Character then
			setupCharacterAnimationListener(localPlayer.Character)
		end
		localPlayer.CharacterAdded:Connect(setupCharacterAnimationListener)

		loggerSection:Toggle({
			Title = "Enable Animation Logger",
			Flag = "tsbanimloggertoggle",
			Desc = "Turn this on to start detecting animations.",
			Value = false,
			Callback = function(state)
				animationSettings.logger.enabled = state
				if state then
					WindUI:Notify({Title = "Logger", Content = "Logging Started", Duration = 1})
				else
					WindUI:Notify({Title = "Logger", Content = "Logging Paused", Duration = 1})
				end
			end
		})

		animationSettings.logger.dropdownObj = loggerSection:Dropdown({
			Title = "Logged Animations",
			Desc = "List of animations played on your character",
			Value = "No Animation Logged Yet..",
			Options = {"Nothing to see..."},
			Callback = function(val)
				local id = val:match("ID: (%d+)")
				if id then
					animationSettings.logger.selectedAnimId = id
				end
			end
		})

		loggerSection:Button({
			Title = "Copy Selected ID",
			Desc = "Copies the ID of the selected animation.",
			Callback = function()
				local selId = animationSettings.logger.selectedAnimId
				if selId then
					setclipboard(tostring(selId))
					WindUI:Notify({Title = "Copied", Content = "ID: " .. selId, Duration = 2})
				else
					WindUI:Notify({Title = "Animation Logger", Content = "Select an animation from the list please..", Duration = 2})
				end
			end
		})

		loggerSection:Button({
			Title = "Play Selected ID",
			Desc = "Plays the selected animation on your character.",
			Callback = function()
				local selId = animationSettings.logger.selectedAnimId
				if selId then
					local char = localPlayer.Character
					if char and char:FindFirstChild("Humanoid") then
						local anim = Instance.new("Animation")
						anim.AnimationId = "rbxassetid://" .. selId
						local track = char.Humanoid:LoadAnimation(anim)
						track:Play()
						WindUI:Notify({Title = "Animation Logger", Content = "Playing Animation..", Duration = 2})
					end
				else
					WindUI:Notify({Title = "Animation Logger", Content = "Select an animation from the list please..", Duration = 2})
				end
			end
		})

		loggerSection:Button({
			Title = "Stop All Animations",
			Desc = "Stops all playing animations.",
			Callback = function()
				stopAllAnimationsOnCharacter()
				WindUI:Notify({Title = "Animation Logger", Content = "All Animations Stopped", Duration = 2})
			end
		})

		loggerSection:Button({
			Title = "Clear List",
			Desc = "Removes all logged animations.",
			Callback = function()
				animationSettings.logger.loggedAnims = {}
				animationSettings.logger.dropdownList = {}
				animationSettings.logger.selectedAnimId = nil
				updateLoggerDropdown()
				animationSettings.logger.dropdownObj:SetValue("No Animation Logged Yet..")
				WindUI:Notify({Title = "Cleared", Content = "List has been reset.", Duration = 2})
			end
		})

		CharAnimsSec = Tabs.Anim:Section({Opened = true, Box = true, BoxBorder = true, Title = "Characters", Icon = "user"})

		local characterAnimations = {
			{ "Saitama", "Saitama Animations", "https://pastefy.app/MSphhjVN/raw" },
			{ "Garou", "Garou Animations", "https://pastefy.app/1w9avWlH/raw" },
			{ "Genos", "Genos Animations", "https://pastefy.app/MA2R0RGL/raw" },
			{ "Sonic", "Sonic Animations", "https://pastefy.app/wAnBZuuG/raw" },
			{ "MetalBat", "MetalBat Animations", "https://pastefy.app/N2pa00Ze/raw" },
			{ "Atomic Samurai", "Atomic Samurai Animations", "https://pastefy.app/wB3HaA45/raw" },
			{ "Tatsumaki", "Tatsumaki Animations", "https://pastefy.app/U1j3SLwL/raw" },
			{ "Suiryu", "Suiryu Animations", "https://pastefy.app/YgSfUw3l/raw" },
			{ "Child Emperor", "Child Emperor Animations", "https://pastefy.app/p1whAqk6/raw" },
			{ "Fracture Boss", "Fracture Boss Animations", "https://pastefy.app/DN4SW5Q1/raw" },
			{ "Gojo", "Gojo Animations", "https://pastefy.app/T96X6meh/raw" },
			{ "Dummy", "Dummy Animations", "https://pastefy.app/tZCD17IH/raw" },
			{ "KJ", "KJ Animations", "https://pastefy.app/2syR66Gd/raw" },
		}

		for _, animData in ipairs(characterAnimations) do
			CharAnimsSec:Button({
				Title = animData[2],
				Locked = false,
				Callback = function()
					loadstring(game:HttpGet(animData[3]))()
				end
			})
		end
	end)
end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
-- ================ DISGUISE0 TAB0 ================ --
function DisguiseTab()
	task.spawn(function()
		local playersService = game:GetService("Players")
		local localPlayer = playersService.LocalPlayer

		local disguiseConfig = {
			meshList = {},
		}

		local function clearCharacterVisuals(character)
			if not character then return end
			local head = character:FindFirstChild("Head")
			local torso = character:FindFirstChild("Torso")

			for _, mesh in pairs(disguiseConfig.meshList) do
				if mesh and mesh.Parent then
					pcall(function() mesh:Destroy() end)
				end
			end
			disguiseConfig.meshList = {}

			local removableClasses = {"Accessory", "Shirt", "Pants", "CharacterMesh", "BodyColors", "ShirtGraphic"}
			for _, child in pairs(character:GetChildren()) do
				for _, className in pairs(removableClasses) do
					if child:IsA(className) then
						child:Destroy()
						break
					end
				end
			end

			if head then
				for _, child in pairs(head:GetChildren()) do
					if child:IsA("SpecialMesh") or child:IsA("Decal") or child:IsA("MeshPart") then
						child:Destroy()
					end
				end
			end

			if torso then
				for _, child in pairs(torso:GetChildren()) do
					if child:IsA("SpecialMesh") or child:IsA("MeshPart") then
						child:Destroy()
					end
				end
			end
		end

		local function applyAppearanceToCharacter(character, appearance)
			if not character or not appearance then return end
			local head = character:FindFirstChild("Head")
			local torso = character:FindFirstChild("Torso")

			for _, item in pairs(appearance:GetChildren()) do
				if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("BodyColors") or item:IsA("ShirtGraphic") then
					local clone = item:Clone()
					clone.Parent = character

				elseif item:IsA("Accessory") then
					local clone = item:Clone()
					clone.Name = "#ACCESSORY_" .. clone.Name
					clone.Parent = character

				elseif item:IsA("SpecialMesh") then
					local clone = item:Clone()
					if item.MeshType then clone.MeshType = item.MeshType end
					if item.Scale then clone.Scale = item.Scale end
					if item.MeshId then clone.MeshId = item.MeshId end
					if item.TextureId then clone.TextureId = item.TextureId end
					if item.VertexColor then clone.VertexColor = item.VertexColor end
					table.insert(disguiseConfig.meshList, clone)
					local target = (item.Parent and item.Parent.Name == "Torso") and torso or head
					if target then
						clone.Parent = target
					end

				elseif item.Name == "R6" then
					for _, childMesh in pairs(item:GetChildren()) do
						if childMesh:IsA("CharacterMesh") then
							local clone = childMesh:Clone()
							clone.Parent = character
						end
					end

				elseif item.Name == "face" and item:IsA("Decal") then
					local clone = item:Clone()
					clone.Parent = head

				elseif item:IsA("MeshPart") then
					local clone = item:Clone()
					clone.CanCollide = false
					clone.Anchored = false
					local lowerName = item.Name:lower()
					if lowerName:find("head") then
						clone.Parent = head
					elseif lowerName:find("torso") or lowerName:find("upper") or lowerName:find("lower") then
						clone.Parent = torso or character
					else
						clone.Parent = character
					end
					table.insert(disguiseConfig.meshList, clone)
				end
			end

			if head then
				if not head:FindFirstChild("face") then
					local faceDecal = Instance.new("Decal")
					faceDecal.Name = "face"
					faceDecal.Face = Enum.NormalId.Front
					faceDecal.Texture = "rbxasset://textures/face.png"
					faceDecal.Parent = head
				end

				if not head:FindFirstChildOfClass("SpecialMesh") then
					local headMesh = Instance.new("SpecialMesh")
					headMesh.MeshType = Enum.MeshType.Head
					headMesh.Scale = Vector3.new(1.25, 1.25, 1.25)
					headMesh.Parent = head
					table.insert(disguiseConfig.meshList, headMesh)
				end
			end
		end

		local function applyDisguise(userId)
			local character = localPlayer.Character
			if not character then return end

			clearCharacterVisuals(character)

			local success, appearance = pcall(function()
				return playersService:GetCharacterAppearanceAsync(userId)
			end)
			if success and appearance then
				applyAppearanceToCharacter(character, appearance)
			end

			local parent = character.Parent
			character.Parent = nil
			character.Parent = parent
		end

		local function clearDisguise()
			local character = localPlayer.Character
			if not character then return end

			clearCharacterVisuals(character)

			local success, selfAppearance = pcall(function()
				return playersService:GetCharacterAppearanceAsync(localPlayer.UserId)
			end)
			if success and selfAppearance then
				applyAppearanceToCharacter(character, selfAppearance)
			end

			local parent = character.Parent
			character.Parent = nil
			character.Parent = parent
		end

		local manualSection = Tabs.Disguise:Section({Opened = true, Box = true, BoxBorder = true, Title = "Manual Input"})

		manualSection:Input({
			Title = "User ID",
			Desc = "Enter Roblox User ID to Disguise",
			Placeholder = "e.g. 1467551683",
			Callback = function(text)
				local userId = tonumber(text)
				if userId then
					applyDisguise(userId)
					WindUI:Notify({
						Title = "Disguise Applied",
						Content = "User ID: " .. userId,
						Duration = 2,
						Icon = "check"
					})
				else
				end
			end
		})

		manualSection:Input({
			Title = "Username",
			Desc = "Enter Roblox Username to Disguise",
			Placeholder = "e.g. builderman",
			Callback = function(username)
				if username == "" then return end
				local success, userId = pcall(function()
					return playersService:GetUserIdFromNameAsync(username)
				end)
				if success and userId then
					applyDisguise(userId)
					WindUI:Notify({
						Title = "Disguise Applied",
						Content = "Target: " .. username .. " (ID: " .. userId .. ")",
						Duration = 2,
						Icon = "check"
					})
				else
					WindUI:Notify({
						Title = "Error",
						Content = "User not found or API error",
						Duration = 2,
						Icon = "alert-triangle"
					})
				end
			end
		})

		manualSection:Button({
			Title = "Random Server Player",
			Desc = "Disguise as a random player in this server",
			Callback = function()
				local playersList = playersService:GetPlayers()
				local availablePlayers = {}
				for _, player in ipairs(playersList) do
					if player ~= localPlayer then
						table.insert(availablePlayers, player)
					end
				end
				if #availablePlayers > 0 then
					local randomPlayer = availablePlayers[math.random(1, #availablePlayers)]
					applyDisguise(randomPlayer.UserId)
					WindUI:Notify({
						Title = "Random Disguise",
						Content = "Now disguised as: " .. randomPlayer.Name,
						Duration = 3,
						Icon = "user"
					})
				else
					WindUI:Notify({
						Title = "Error",
						Content = "No other players found in server",
						Duration = 3,
						Icon = "alert-circle"
					})
				end
			end
		})

		local quickSection = Tabs.Disguise:Section({Opened = true, Box = true, BoxBorder = true, Title = "Quick Selection"})

		local quickDisguiseList = {
			{ name = "Manjiro", userId = 1467551683, description = "Apply Manjiro's Avatar" },
			{ name = "TY01", userId = 4856428538, description = "Apply TY01's Avatar" },
			{ name = "Legendbro Best Frendo", userId = 2733484517, description = "Apply Legendbro's Avatar" },
			{ name = "Burakbabapiro", userId = 2059090606, description = "Apply Burakbabapiro's Avatar" },
			{ name = "Unknown Guy", userId = 9099919347, description = "Apply Unknown Guy's Avatar" },
			{ name = "FINNERIX", userId = 5595931595, description = "Apply FINNERIX's Avatar" },
			{ name = "Unknown Femboy", userId = 2643325532, description = "Apply Unknown Femboy's Avatar" },
			{ name = "Mafia", userId = 2554825563, description = "Apply Mafia's Avatar" },
			{ name = "THE KING", userId = 636351295, description = "Apply THE KING's Avatar" },
			{ name = "My Best Femboy", userId = 3992039715, description = "Apply My Best Femboy's Avatar" },
			{ name = "Vexon", userId = 1154980186, description = "Apply Vexon's Avatar" },
			{ name = "Renji", userId = 2670616781, description = "Apply Renji's Avatar" },
			{ name = "Roblox", userId = 1, description = "Apply Roblox's Avatar" },
			{ name = "Builderman", userId = 156, description = "Apply Builderman's Avatar" },
			{ name = "omar_tacoss", userId = 1624603249, description = "Apply omar_tacoss's Avatar" },
			{ name = "xlvkxlvk", userId = 3927219833, description = "Apply xlvkxlvk's Avatar" },
		}

		for _, entry in ipairs(quickDisguiseList) do
			quickSection:Button({
				Title = entry.name,
				Desc = entry.description,
				Callback = function()
					applyDisguise(entry.userId)
				end
			})
		end

		quickSection:Divider()

		quickSection:Button({
			Title = "Clear Disguise",
			Desc = "Restore your original avatar",
			Callback = function()
				clearDisguise()
				WindUI:Notify({
					Title = "Disguise Cleared",
					Content = "Your avatar restored",
					Duration = 2,
					Icon = "trash-2"
				})
			end
		})
	end)
end















-- ================ BRING0 TAB0 ================ --
function BringTab()
	task.spawn(function()
	
	
	
		local Players = game:GetService("Players")
		local PhysicsService = game:GetService("PhysicsService")
		local RunService = game:GetService("RunService")
		local LocalPlayer = Players.LocalPlayer
		
		local teleportPosition = Vector3.new(150, -495, 30)
		local autoVoidEnabled = false
		local isAnimationPlaying = false
		local tpBackEnabled = false
		local ghostModeEnabled = false
		local savedCFrame = nil
		local originalCameraCFrame = nil
		local originalCameraType = nil
		
		local cameraLockConnection = nil
		local heartbeatConnection = nil
		local animationConnection = nil
		local diedConnection = nil
		
		local CollisionGroupName = "NoCollision"
		local tpMode = "Single TP"
		
		local customAnimations = {
		    {id = "140164642047188", name = "Saitama Serious Uppercut",          teleportDelay = 0,   returnDelay = 9},
		    {id = "12273188754",     name = "Garou Flowing Water",               teleportDelay = 0,   returnDelay = 1.7},
		    {id = "12296113986",     name = "Garou Lethal Whirlwind Stream",     teleportDelay = 0,   returnDelay = 1.7},
		    {id = "13813099821",     name = "Garou ult move 4",                  teleportDelay = 0,   returnDelay = 3},
		    {id = "14057231976",     name = "Garou ult move 3",                  teleportDelay = 0.7, returnDelay = 1},
		    {id = "93546004428904",  name = "Garou ult move 4 Variant",          teleportDelay = 0,   returnDelay = 5},
		    {id = "95034083206292",  name = "Monster Garou Binding Cloth",       teleportDelay = 0,   returnDelay = 2.2},
		    {id = "94638356008696",  name = "Monster Garou Crowd Buster",        teleportDelay = 0,   returnDelay = 3},
		    {id = "115484690572880", name = "Monster Garou Hammer Heel Variant", teleportDelay = 1,   returnDelay = 2},
		    {id = "13633468484",     name = "Sonic ult move 1",                  teleportDelay = 0,   returnDelay = 6},
		    {id = "14705929107",     name = "Metalbat Foul Ball",                teleportDelay = 0,   returnDelay = 2.4},
		    {id = "14004235777",     name = "Metalbat Homerun",                  teleportDelay = 0.5, returnDelay = 1.5},
		    {id = "14046756619",     name = "Metalbat Beatdown",                 teleportDelay = 1,   returnDelay = 3},
		    {id = "14920779925",     name = "Metalbat ult move 3",               teleportDelay = 0,   returnDelay = 4.4},
		    {id = "15145462680",     name = "Atomic Samurai Atmos Cleave",       teleportDelay = 1.4, returnDelay = 1},
		    {id = "15295895753",     name = "Atomic Samurai Pinpoint Cut",       teleportDelay = 0.5, returnDelay = 1.3},
		    {id = "16062712948",     name = "Atomic Samurai ult move 3",         teleportDelay = 0,   returnDelay = 7},
		    {id = "16139108718",     name = "Tatsumaki Crushing Pull",           teleportDelay = 0,   returnDelay = 1},
		    {id = "17278415853",     name = "Tatsumaki ult move 3",              teleportDelay = 2,   returnDelay = 11},
		    {id = "17889080495",     name = "Tatsumaki ult move 4",              teleportDelay = 0,   returnDelay = 2.3},
		    {id = "16734584478",     name = "Tatsumaki ult",                     teleportDelay = 2,   returnDelay = 5.5},
		    {id = "17799224866",     name = "Suiryu Bullet Barrage",             teleportDelay = 2,   returnDelay = 1.2},
		    {id = "18182425133",     name = "Suiryu Head First",                 teleportDelay = 0,   returnDelay = 4},
		    {id = "18896229321",     name = "Suiryu ult move 2",                 teleportDelay = 4,   returnDelay = 3},
		    {id = "98542310119798",  name = "Child emperor Trinity Tear",        teleportDelay = 0,   returnDelay = 2},
		    {id = "16945550029",     name = "KJ Ravage",                         teleportDelay = 0,   returnDelay = 3.3},
		}
		
		local animationNames = {}
		local enabledAnimations = {}
		local animationsDict = {}
		
		for _, anim in ipairs(customAnimations) do
		    table.insert(animationNames, anim.name)
		    enabledAnimations[anim.name] = true
		    animationsDict[anim.id] = anim
		end
		
		local function isCharacterValid()
		    local char = LocalPlayer.Character
		    if not char or not char:IsDescendantOf(workspace) then return false end
		    
		    local hum = char:FindFirstChildOfClass("Humanoid")
		    local hrp = char:FindFirstChild("HumanoidRootPart")
		    
		    if not hum or hum.Health <= 0 or not hrp then return false end
		    return true, char, hum, hrp
		end
		
		local function isTargetAnimation(animationId)
		    local rawId = string.match(animationId, "%d+") 
		    if not rawId then return false, nil end
		    
		    local anim = animationsDict[rawId]
		    if anim and enabledAnimations[anim.name] then
		        return true, anim
		    end
		    return false, nil
		end
		
		local function stopHeartbeat()
		    if heartbeatConnection then
		        heartbeatConnection:Disconnect()
		        heartbeatConnection = nil
		    end
		end
		
		local function unlockCamera()
		    if cameraLockConnection then
		        cameraLockConnection:Disconnect()
		        cameraLockConnection = nil
		    end
		    local camera = workspace.CurrentCamera
		    if camera then
		        if camera.CameraType == Enum.CameraType.Scriptable then
		            camera.CameraType = originalCameraType or Enum.CameraType.Custom
		        end
		    end
		    originalCameraType = nil
		    originalCameraCFrame = nil
		end
		
		local function lockCamera()
		    if not ghostModeEnabled then return end
		    local camera = workspace.CurrentCamera
		    if not camera then return end
		    
		    originalCameraCFrame = camera.CFrame
		    if camera.CameraType ~= Enum.CameraType.Scriptable then
		        originalCameraType = camera.CameraType
		    end
		    camera.CameraType = Enum.CameraType.Scriptable
		
		    if cameraLockConnection then
		        cameraLockConnection:Disconnect()
		    end
		
		    cameraLockConnection = RunService.RenderStepped:Connect(function()
		        if camera and originalCameraCFrame and ghostModeEnabled and isCharacterValid() then
		            camera.CFrame = originalCameraCFrame
		        else
		            unlockCamera()
		        end
		    end)
		end
		
		local function doTeleport(animData)
		    local valid, char, hum, hrp = isCharacterValid()
		    if not valid then return end
		    
		    isAnimationPlaying = true
		    savedCFrame = hrp.CFrame
		
		    task.delay(animData.teleportDelay, function()
		        local stillValid, _, _, currentHrp = isCharacterValid()
		        if not autoVoidEnabled or not stillValid then
		            isAnimationPlaying = false
		            return
		        end
		
		        lockCamera()
		
		        if tpMode == "Loop TP" then
		            stopHeartbeat() 
		            heartbeatConnection = RunService.Heartbeat:Connect(function()
		                local loopValid, _, _, loopHrp = isCharacterValid()
		                if autoVoidEnabled and loopValid then
		                    loopHrp.CFrame = CFrame.new(teleportPosition)
		                else
		                    stopHeartbeat()
		                end
		            end)
		        else
		            currentHrp.CFrame = CFrame.new(teleportPosition)
		        end
		
		        task.delay(animData.returnDelay, function()
		            stopHeartbeat()
		
		            local returnValid, _, _, returnHrp = isCharacterValid()
		            if tpBackEnabled and savedCFrame and returnValid then
		                returnHrp.CFrame = savedCFrame
		            end
		
		            unlockCamera()
		            isAnimationPlaying = false
		            savedCFrame = nil
		        end)
		    end)
		end
		
		local function onAnimationPlayedAutoVoid(track)
		    if not autoVoidEnabled or isAnimationPlaying then return end
		    local isTarget, animData = isTargetAnimation(track.Animation.AnimationId)
		    if not isTarget or not animData then return end
		
		    doTeleport(animData)
		end
		
		local function cleanupCurrentCharacter()
		    stopHeartbeat()
		    unlockCamera()
		    
		    if animationConnection then
		        animationConnection:Disconnect()
		        animationConnection = nil
		    end
		    if diedConnection then
		        diedConnection:Disconnect()
		        diedConnection = nil
		    end
		    
		    isAnimationPlaying = false
		end
		
		local function updateCharacter(newChar)
		    cleanupCurrentCharacter()
		    
		    local humanoid = newChar:WaitForChild("Humanoid", 10)
		    if not humanoid then return end
		    
		    local animator = humanoid:WaitForChild("Animator", 10) or Instance.new("Animator", humanoid)
		    
		    diedConnection = humanoid.Died:Connect(function()
		        cleanupCurrentCharacter()
		    end)
		    
		    if animator then
		        animationConnection = animator.AnimationPlayed:Connect(onAnimationPlayedAutoVoid)
		    end
		
		    savedCFrame = nil
		end
		
		if LocalPlayer.Character then
		    task.spawn(updateCharacter, LocalPlayer.Character)
		end
		LocalPlayer.CharacterAdded:Connect(updateCharacter)
		
		workspace.FallenPartsDestroyHeight = -math.huge
		
		pcall(function()
		    PhysicsService:CreateCollisionGroup(CollisionGroupName)
		    PhysicsService:CollisionGroupSetCollidable(CollisionGroupName, "Default", false)
		end)
		
		local AutoVoidSection = Tabs.Bring:Section({Opened = true, Box = true, BoxBorder = true, Title = "Auto Move Bring", Icon = "star"})
		
		AutoVoidSection:Dropdown({
		    Title = "Select Place to Bring",
		    Values = {"Map", "Pixel", "Void", "Darkness", "Mountain", "Counter", "Atomic Base", "Atomic Base Up", "Atomic Slash", "Prison"},
		    Value = "Void",
		    SearchBarEnabled = true,
		    Multi = false,
		    Callback = function(selectedValue)
		        local placePositions = {
		            Map = Vector3.new(150, 505, 30),
		            Pixel = Vector3.new(30000000, 30000000, 30000000),
		            Void = Vector3.new(150, -495, 30),
		            Darkness = Vector3.new(0, 900000000002, 0),
		            Mountain = Vector3.new(155.577392578125, 628.742431640625, -447.93841552734375),
		            Counter = Vector3.new(-68, 29, 20346),
		            ["Atomic Base"] = Vector3.new(1063, 30, 23006),
		            ["Atomic Base Up"] = Vector3.new(1063, 405, 23006),
		            ["Atomic Slash"] = Vector3.new(1063, 131, 23006),
		            Prison = Vector3.new(438, 439, -376),
		        }
		        teleportPosition = placePositions[selectedValue]
		    end,
		})
		
		AutoVoidSection:Dropdown({
		    Title = "Active Moves",
		    Values = animationNames,
		    Value = animationNames,
		    SearchBarEnabled = true,
		    Multi = true,
		    Callback = function(selected)
		        for name, _ in pairs(enabledAnimations) do
		            enabledAnimations[name] = false
		        end
		        if typeof(selected) == "table" then
		            for _, name in ipairs(selected) do
		                enabledAnimations[name] = true
		            end
		        end
		    end,
		})
		
		AutoVoidSection:Dropdown({
		    Title = "TP Mode",
		    Values = {"Single TP", "Loop TP"},
		    Value = "Single TP",
		    Multi = false,
		    Callback = function(selectedValue)
		        tpMode = selectedValue
		    end,
		})
		
		AutoVoidSection:Toggle({
		    Title = "Auto Bring",
		    Flag = "tsbautovoid",
		    Value = false,
		    Callback = function(state)
		        autoVoidEnabled = state
		        if not state then
		            stopHeartbeat()
		            unlockCamera()
		        end
		    end,
		})
		
		AutoVoidSection:Toggle({
		    Title = "Auto Tp Back",
		    Flag = "tsbautovoidtpback",
		    Value = false,
		    Callback = function(state)
		        tpBackEnabled = state
		    end,
		})
		
		AutoVoidSection:Toggle({
		    Title = "Freeze Camera",
		    Flag = "tsbghostmode",
		    Value = false,
		    Callback = function(state)
		        ghostModeEnabled = state
		        if not state then
		            unlockCamera()
		        end
		    end,
		})
		
		local TeleportGroup = AutoVoidSection:Group({})
		
		TeleportGroup:Button({
		    Title = "Tp To Place",
		    Icon = "map-pin",
		    Callback = function()
		        local valid, _, _, hrp = isCharacterValid()
		        if not valid then return end
		        savedCFrame = hrp.CFrame
		        hrp.CFrame = CFrame.new(teleportPosition)
		    end,
		})
		
		TeleportGroup:Button({
		    Title = "Tp Back",
		    Icon = "undo-2",
		    Callback = function()
		        local valid, _, _, hrp = isCharacterValid()
		        if savedCFrame and valid then
		            hrp.CFrame = savedCFrame
		            savedCFrame = nil
		        end
		    end,
		})
	
	
	
		vexon_cloneref = cloneref or function(obj) return obj end
		vexon_services = setmetatable({}, {
		    __index = function(_, serviceName)
		        return vexon_cloneref(game:GetService(serviceName))
		    end,
		})
		
		vexon_players = vexon_services.Players
		vexon_runService = vexon_services.RunService
		vexon_localPlayer = vexon_players.LocalPlayer
		vexon_renderStepped = vexon_runService.RenderStepped
		vexon_heartbeat = vexon_runService.Heartbeat
		
		local vexon_charStates = {
		    ['Doing Wall Combo Anywhere'] = false,
		    Invisibility = false,
		}
		
		local vexon_teleportCFrames = {
		    ['Atomic Slash'] = CFrame.new(1064, 131, 23007) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    Arena = CFrame.new(-130, 440, -373) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    Baseplate = CFrame.new(1073, 407, 22984) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Below Baseplate'] = CFrame.new(1073, 20, 22984) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    Jail = CFrame.new(440, 440, -395) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Jail But Smaller'] = CFrame.new(20, 439, -460) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Bigger Jail'] = CFrame.new(290, 440, 465) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Even Bigger Jail'] = CFrame.new(378, 439, 457) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Dark Domain'] = CFrame.new(-80, 84, 20395) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Death Counter'] = CFrame.new(-66, 29, 20383) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    Middle = CFrame.new(155, 441, 45) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Mountain 1'] = CFrame.new(306, 671, 411) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Mountain 2'] = CFrame.new(-1, 653, -354) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    ['Mountain Edge'] = CFrame.new(-297, 594, -336) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		    Void = CFrame.new(169, 218, 102) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(90), 0, 0),
		}
		
		local vexon_sortedNames = {}
		for name in pairs(vexon_teleportCFrames) do
		    table.insert(vexon_sortedNames, name)
		end
		table.sort(vexon_sortedNames)
		
		local function vexon_getChar(player)
		    return player and player.Character
		end
		
		local function vexon_getRoot(character)
		    return character and character:FindFirstChild('HumanoidRootPart') or nil
		end
		
		local function vexon_getHum(character)
		    return character and character:FindFirstChild('Humanoid') or nil
		end
		
		local function vexon_heartbeatTp(targetCframe)
		    local char = vexon_getChar(vexon_localPlayer)
		    local root = vexon_getRoot(char)
		    if char and root then
		        task.spawn(function()
		            vexon_renderStepped:Once(function()
		                root.Velocity = Vector3.new()
		                vexon_heartbeat:Wait()
		                root.Velocity = Vector3.new()
		            end)
		        end)
		        vexon_heartbeat:Once(function()
		            root.CFrame = targetCframe
		        end)
		    end
		end
		
		local function vexon_communicate(data)
		    local char = vexon_getChar(vexon_localPlayer)
		    local comms = char and char:WaitForChild('Communicate', 1)
		    if comms then
		        comms:FireServer(data)
		    end
		end
		
		
		vexon_heartbeat:Connect(MV_CFF(function() 

		    char = vexon_getChar(vexon_localPlayer)
		    root = vexon_getRoot(char)
		    hum = vexon_getHum(char)
		
		    if char and root and hum and hum.Health > 0 then
		        originalCF = root.CFrame
		        originalVel = root.Velocity
		        desyncCF = nil
		
		        if getgenv().vexonWallDesync then
		            desyncCF = getgenv().vexonWallDesync.CFrame
		        end
		
		        if desyncCF then
		            root.CFrame = desyncCF
		            vexon_renderStepped:Wait()
		            root.CFrame = originalCF
		            root.Velocity = originalVel
		        end
		    end
		end))
		
		local WallComboToggles = {
		    Anywhere = {Value = false},
		    Auto = {Value = false},
		    Bring = {Value = false},
		    TPBack = {Value = false}
		}
		
		local WallComboOptions = {
		    Area = {Value = "Death Counter"}
		}
		
		WallComboMods = Tabs.Bring:Section({Opened = true, Box = true, BoxBorder = true, Title = "Wall Combo", Icon = "brick-wall" })
		
		WallComboMods:Toggle({
		    Title = "Wall Combo Everywhere",
		    Value = false,
		    Flag = "vexon_wall_everywhere",
		    Callback = function(state) WallComboToggles.Anywhere.Value = state end
		})
		
		WallComboMods:Toggle({
		    Title = "Auto Wall Combo",
		    Flag = "vexon_wall_auto",
		    Value = false,
		    Callback = function(state) WallComboToggles.Auto.Value = state end
		})
		
		WallComboMods:Toggle({
		    Title = "Bring Wall Combo",
		    Value = false,
		    Callback = function(state) WallComboToggles.Bring.Value = state end
		})
		
		WallComboMods:Toggle({
		    Title = "Tp Back Old Pos",
		    Flag = "vexon_wall_tpback",
		    Value = false,
		    Callback = function(state) WallComboToggles.TPBack.Value = state end
		})
		
		WallComboMods:Dropdown({
		    Title = "Bring Place",
		    Flag = "vexon_wall_place",
		    Values = vexon_sortedNames,
		    Value = "Death Counter",
		    Callback = function(value) WallComboOptions.Area.Value = value end
		})
		
		local function vexon_initHooks(character)
		    character.AttributeChanged:Connect(function(attribute)
		        if attribute == 'Combo' and character:GetAttribute('Combo') == 5 and vexon_getRoot(character) then
		            if WallComboToggles.Anywhere.Value then
		                if WallComboToggles.Bring.Value then
		                    vexon_charStates['Doing Wall Combo Anywhere'] = true
		                    local start = tick()
		                    
		                    repeat
		                        getgenv().vexonWallDesync = {
		                            CFrame = vexon_getRoot(character).CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		                        }
		                        task.wait()
		                    until tick() >= start + 0.225
		
		                    local oldCF = vexon_getRoot(character).CFrame
		                    getgenv().vexonWallDesync = {
		                        CFrame = vexon_teleportCFrames[WallComboOptions.Area.Value],
		                    }
		                    
		                    task.wait(0.2)
		                    vexon_communicate({Goal = 'Wall Combo'})
		                    getgenv().vexonWallDesync = nil
		                    vexon_charStates['Doing Wall Combo Anywhere'] = false
		                    
		                    task.wait(0.5)
		                    if character:FindFirstChild('ForceField') and WallComboToggles.TPBack.Value then
		                        vexon_heartbeatTp(oldCF)
		                    end
		                else
		                    vexon_charStates['Doing Wall Combo Anywhere'] = true
		                    local start = tick()
		                    repeat
		                        getgenv().vexonWallDesync = {
		                            CFrame = vexon_getRoot(character).CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
		                        }
		                        task.wait()
		                    until tick() >= start + 0.6
		                    getgenv().vexonWallDesync = nil
		                    vexon_charStates['Doing Wall Combo Anywhere'] = false
		                end
		            end
		        end
		    end)
		
		    character.DescendantAdded:Connect(function(desc)
		        if desc:IsA('ObjectValue') and desc.Name:lower() == 'wallcombo' then
		            local start = tick()
		            while true do
		                if WallComboToggles.Auto.Value then
		                    vexon_communicate({Goal = 'Wall Combo'})
		                end
		                task.wait()
		                if desc.Parent ~= character or tick() >= start + (desc:GetAttribute('DeleteMe') or 0.6) then
		                    break
		                end
		            end
		        end
		    end)
		end
		
		if vexon_localPlayer.Character then vexon_initHooks(vexon_localPlayer.Character) end
		vexon_localPlayer.CharacterAdded:Connect(vexon_initHooks)
		
		
		
		
		
		
		
		
		
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")
local LocalPlayer = Players.LocalPlayer

SelectedTarget = nil
BodyPosition = nil
NoclipConnection = nil
Blacklist = {}
CollisionGroupName = "PlayerNoclip"
SelectedLocation = "Atomic Slash" 
IsFollowing = false
IsBringing = false
IsInCombo = false
HeightOffset = 7
PredictionTime = 0.15
SmartTargetEnabled = false
ReturnToOldPosition = false
OldPositionCFrame = nil
UseAttachTeleport = false



Locations = {
	["Current Location"] = nil,
    ["Atomic Slash"] = CFrame.new(1064, 131, 23007) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Arena"] = CFrame.new(-130, 440, -373) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Baseplate"] = CFrame.new(1073, 406, 22984) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Below Baseplate"] = CFrame.new(1073, 20, 22984) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Jail"] = CFrame.new(440, 440, -395) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Jail But Smaller"] = CFrame.new(20, 439, -460) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Bigger Jail"] = CFrame.new(290, 440, 465) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Even Bigger Jail"] = CFrame.new(378, 439, 457) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Dark Domain"] = CFrame.new(-80, 84, 20395) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Death Counter"] = CFrame.new(-66, 29, 20383) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Middle"] = CFrame.new(155, 441, 45) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Mountain 1"] = CFrame.new(306, 671, 411) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Mountain 2"] = CFrame.new(-1, 653, -354) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Mountain Edge"] = CFrame.new(-297, 594, -336) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ["Void"] = CFrame.new(169, 218, 102) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(90), 0, 0)
}




LocationNames = {}
for name, _ in pairs(Locations) do
    table.insert(LocationNames, name)
end
table.sort(LocationNames)

pcall(function()
    PhysicsService:CreateCollisionGroup(CollisionGroupName)
    PhysicsService:CollisionGroupSetCollidable(CollisionGroupName, "Default", false)
end)


local function performAttachTeleport(desiredCFrame, targetPlayer)
    if not desiredCFrame then return end
    
    local Character = LocalPlayer.Character
    if not Character then return end
    
    local RootPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso")
    if not RootPart or not RootPart.Parent then return end
    
    if UseAttachTeleport then
        local yOffset = AttachModeEnabled and 1.5 or 3.5
        local adjustedCFrame = desiredCFrame * CFrame.new(0, yOffset, 0)
        
        RootPart.CFrame = adjustedCFrame
        pcall(function() Character:SetPrimaryPartCFrame(adjustedCFrame) end)
        
        local repPart = nil
        if targetPlayer and targetPlayer.Character then
            repPart = targetPlayer.Character:FindFirstChild("Head") or targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        end
        
        if repPart and repPart.Parent then
            pcall(function() 
                sethiddenproperty(RootPart, "PhysicsRepRootPart", repPart) 
            end)
        end
    else
        RootPart.CFrame = desiredCFrame
    end
end


local function BringRandomPlayer()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    
    if not root then return end

    local targets = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
            
            if distance > 15 and p.Name ~= LastBroughtPlayer then
                table.insert(targets, p)
            end
        end
    end

    if #targets == 0 then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
                if distance > 15 then
                    table.insert(targets, p)
                end
            end
        end
    end

    if #targets > 0 then
        local randomTarget = targets[math.random(1, #targets)]
        LastBroughtPlayer = randomTarget.Name
        SelectedTarget = randomTarget.Name
        BringPlayer(SelectedTarget)
    end
end






function SetNoclip(Enabled)
    local Character = LocalPlayer.Character
    if Character and Character.PrimaryPart then
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
        local GroupName = Enabled and CollisionGroupName or "Default"
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CollisionGroup = GroupName
            end
        end
        if Enabled then
            NoclipConnection = RunService.Stepped:Connect(MV_CFF(function() 

                if Character then
                    for _, Part in ipairs(Character:GetDescendants()) do
                        if Part:IsA("BasePart") then
                            Part.CanCollide = false
                        end
                    end
                end
            end))
            if BodyPosition then
                BodyPosition:Destroy()
            end
            BodyPosition = Instance.new("BodyPosition")
            BodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyPosition.P = 50000
            BodyPosition.D = 1200
            BodyPosition.Parent = Character.PrimaryPart
        elseif BodyPosition then
            BodyPosition:Destroy()
            BodyPosition = nil
        end
    end
end

function BringPlayer(TargetName)
    local TargetPlayer = Players:FindFirstChild(TargetName)
    if TargetPlayer and TargetPlayer ~= LocalPlayer and TargetPlayer.Character then
        task.spawn(function()
            local Character = LocalPlayer.Character
            if Character and Character.PrimaryPart and TargetPlayer.Character then
                local Communicate = Character:FindFirstChild("Communicate")
                
                if Communicate and Communicate:IsA("RemoteEvent") then
                    IsBringing = true
                    
                    if ReturnToOldPosition then
                        OldPositionCFrame = Character.PrimaryPart.CFrame
                    end
                    
                    local CurrentLocationCFrame = nil
                    if SelectedLocation == "Current Location" then
                        CurrentLocationCFrame = Character.PrimaryPart.CFrame
                    end
                    
                    HeightOffset = 15
                    SetNoclip(true)

                    local Args = {
                        Click = {[1] = {["Goal"] = "LeftClick", ["Mobile"] = true}},
                        Jump = {[1] = {["Goal"] = "Record Jump"}},
                        Release = {[1] = {["Goal"] = "LeftClickRelease", ["Mobile"] = true}},
                        WallCombo = {[1] = {["Goal"] = "Wall Combo", ["Mobile"] = true}}
                    }

                    Communicate:FireServer(unpack(Args.Click))
                    task.wait(0.8) 
                    Communicate:FireServer(unpack(Args.Jump))
                    task.wait(0.36)
                    HeightOffset = 6
                    task.wait(0.15)
                    HeightOffset = 1
                    IsInCombo = true
                    task.wait(0.35)
                    Communicate:FireServer(unpack(Args.Release))
                    
                    IsBringing = false
                    IsInCombo = false
                    if not IsFollowing then
                        SetNoclip(false)
                    end
                    
                    local RootPart = Character.PrimaryPart
                    
                    local TargetCFrame
                    if SelectedLocation == "Current Location" and CurrentLocationCFrame then
                        TargetCFrame = CurrentLocationCFrame
                    else
                        TargetCFrame = Locations[SelectedLocation]
                    end
                    
                    if RootPart and TargetCFrame then
                        performAttachTeleport(TargetCFrame, TargetPlayer)
                    end

                    
                    task.wait(0.1)
                    for _ = 1, 6 do
                        Communicate:FireServer(unpack(Args.WallCombo))
                        task.wait(0.03)
                    end
                    
                    if ReturnToOldPosition and OldPositionCFrame then
                        task.wait(0.5)
                        performAttachTeleport(OldPositionCFrame, nil)
                        OldPositionCFrame = nil
                    end

                    
                    task.wait(0.5)
                end
            end
        end)
    end
end







BringSetting = Tabs.Bring:Section({Opened = true, Box = true, BoxBorder = true, Title = "Bring Settings", Icon = "settings" })


BringSetting:Toggle({
    Title = "Attach Teleport Mode",
    Desc = "Zero ping teleport method that attaches your character directly to the target. Highly effective for bringing if the target moving, its makes bring rate almost %100. Requires a high level executor like Delta. Xeno is not supported.",
    Default = false,
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Callback = function(Value)
        UseAttachTeleport = Value
    end
})


task.spawn(function()
    TargetDropdown = BringSetting:Dropdown({
        Title = "Pick a Target",
        Desc = "Select Target to bring To Spot",
        Locked = LockedStatus,
        Value = "Select a player",
        LockedTitle = "Premium",
        SpecialType = "Player",
        ExcludeLocalPlayer = true,
        SearchBarEnabled = true,
        Callback = function(selectedValue)
            SelectedTarget = selectedValue
        end
    })
end)

BringSetting:Dropdown({
    Title = "Bring Spot",
    Flag = "tsbbringspotpremium",
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Desc = "Select location to bring target",
    Values = LocationNames,
    Value = "Atomic Slash",
    Multi = false,
    Callback = function(selectedValue)
        SelectedLocation = selectedValue
    end
})

BringSetting:Divider()

BringSetting:Button({
    Title = "Bring",
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Callback = function()
        BringPlayer(SelectedTarget)
    end
})

BringSetting:Slider({
    Title = "Prediction",
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Step = 0.01,
    Value = { Min = 0, Max = 1, Default = 0.23 },
    Callback = function(num)
        PredictionTime = num
    end
})

BringSetting:Toggle({
    Title = "Return to Old Position",
    Desc = "Teleport back after bring finishes",
    Default = false,
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Callback = function(Value)
        ReturnToOldPosition = Value
    end
})


BringSetting:Divider()

BringSetting:Toggle({
    Title = "Loop Bring Random Player",
    Default = false,
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Callback = function(Value)
        LoopBringEnabled = Value
        
        if LoopBringEnabled then
            task.spawn(function()
                while LoopBringEnabled do
                    if not IsBringing and not IsInCombo then
                        BringRandomPlayer()
                        task.wait(2.5)
                    else
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
})


BringSetting:Button({
    Title = "Bring Random Player",
    Locked = LockedStatus,
    LockedTitle = "Premium",
    Callback = function()
        if not IsBringing and not IsInCombo then
            BringRandomPlayer()
        end
    end
})


heartbeatConnection = RunService.Heartbeat:Connect(MV_CFF(function() 

    local Character = LocalPlayer.Character
    if Character then
        local RootPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso")
        if RootPart then
            if (IsFollowing or IsBringing) and SelectedTarget then
                local TargetPlayer = Players:FindFirstChild(SelectedTarget)
                if not (TargetPlayer and TargetPlayer.Character) then
                    return
                end
                local TargetRoot = TargetPlayer.Character.PrimaryPart
                if not TargetRoot then
                    return
                end
                local PredictedPos
                if UseAttachTeleport then
                    PredictedPos = TargetRoot.Position
                else
                    PredictedPos = TargetRoot.Position + Vector3.new(TargetRoot.AssemblyLinearVelocity.X, 0, TargetRoot.AssemblyLinearVelocity.Z) * PredictionTime
                end
                local TargetPos
                if IsInCombo then
                    TargetPos = PredictedPos - Vector3.new(0, 1, 0)
                    performAttachTeleport(CFrame.new(TargetPos, TargetPos - Vector3.new(0, 1, 0)), TargetPlayer)
                else
                    TargetPos = PredictedPos - Vector3.new(0, HeightOffset, 0)
                    performAttachTeleport(CFrame.new(TargetPos, PredictedPos), TargetPlayer)
                end
                if BodyPosition then
                    BodyPosition.Position = TargetPos
                end
            end
        end
    end
end))







	end)
end















-- ================ ATTACH0 TAB0 ================ --
function AttachTab()
	task.spawn(function()
		AttachSec = Tabs.Attach:Section({Opened = true, Box = true, BoxBorder = true, Title = "Attach", Icon = "paperclip" })
		AttachSec:Paragraph({
		    Title = "Note:", 
		    Desc = "its like a loop tp but with no cooldown rly op. Only works for rly good executors like delta if you use executors that not support cloneref will probably just crash. Xeno not Supported!",
		    Image = "rbxassetid://84519376661277",
		    ImageSize = 30,
		    Thumbnail = "",
		    ThumbnailSize = 0,
		    Locked = false,
		})
		
		
		function GetService(ServiceName) 
		    return cloneref and cloneref(game:GetService(ServiceName)) or game:GetService(ServiceName) 
		end
		
		Players = GetService("Players")
		RunService = GetService("RunService")
		
		LocalPlayer = Players.LocalPlayer
		Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		RootPart = Character:WaitForChild("HumanoidRootPart")
		
		TargetPlayer = nil
		IsEnabled = false
		Offset = Vector3.new(0, 0, 0)
		RotOffset = Vector3.new(0, 0, 0)
		HeartbeatConnection = nil
		
		OffsetCFrame = CFrame.new(0, 0, 0)
		
		
		function UpdateOffset()
		    OffsetCFrame = CFrame.new(Offset.X, Offset.Y, Offset.Z) * CFrame.Angles(math.rad(RotOffset.X), math.rad(RotOffset.Y), math.rad(RotOffset.Z))
		end
		
		function FindPlayer(Name)
		    Name = Name:lower():gsub("%s", "")
		    for _, Player in next, Players:GetPlayers() do
		        if Player ~= LocalPlayer and (Player.Name:lower():match(Name) or Player.DisplayName:lower():match("^" .. Name)) then 
		            return Player 
		        end
		    end
		    return nil
		end
		
		TargetRoot = nil
		TargetHead = nil
		LastHead = nil
		PreSimConnection = nil
		RenderConnection = nil
		TargetCharConn = nil
		
		function CacheTarget()
		    local char = TargetPlayer and TargetPlayer.Character
		    TargetRoot = char and char:FindFirstChild("HumanoidRootPart")
		    TargetHead = char and char:FindFirstChild("Head")
		    LastHead = nil
		end
		
		function UpdateLoop()
		    if not IsEnabled or not RootPart or not TargetRoot or not TargetRoot.Parent then
		        return
		    end
		    
		    RootPart.CFrame = TargetRoot.CFrame * OffsetCFrame
		    RootPart.AssemblyLinearVelocity = TargetRoot.AssemblyLinearVelocity
		    
		    if TargetHead and TargetHead ~= LastHead then
		        LastHead = TargetHead
		        pcall(sethiddenproperty, RootPart, "RootRef", TargetHead)
		    end
		end
		
		LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
		    Character = NewCharacter
		    RootPart = NewCharacter:WaitForChild("HumanoidRootPart")
		    LastHead = nil
		end)
		
		AttachSec:Input({
		    Title = "Target Name",
		    Placeholder = "Player Name...",
		    Callback = function(Text)
		        TargetPlayer = FindPlayer(Text) 
		        if TargetCharConn then TargetCharConn:Disconnect() TargetCharConn = nil end
		        CacheTarget()
		        if TargetPlayer then
		            TargetCharConn = TargetPlayer.CharacterAdded:Connect(function()
		                task.wait(0.1)
		                CacheTarget()
		            end)
		        end
		        if TargetPlayer then 
		            game.StarterGui:SetCore("SendNotification", {
		                Title = "VexonHub",
		                Text = "Target Found: " .. TargetPlayer.DisplayName,
		                Icon = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. TargetPlayer.UserId .. "&width=420&height=420&format=png",
		                Duration = 3
		            })
		        end 
		    end
		})
		
		AttachSec:Toggle({
		    Title = "Active Attach",
		    Value = false,
		    Callback = function(Value)
		        IsEnabled = Value
		        
		        if IsEnabled then
		            CacheTarget()
		            if not RenderConnection then
		                RenderConnection = RunService.RenderStepped:Connect(UpdateLoop)
		            end
		            if not PreSimConnection then
		                PreSimConnection = RunService.PreSimulation:Connect(UpdateLoop)
		            end
		            if not HeartbeatConnection then
		                HeartbeatConnection = RunService.Heartbeat:Connect(UpdateLoop)
		            end
		        else
		            if HeartbeatConnection then
		                HeartbeatConnection:Disconnect()
		                HeartbeatConnection = nil
		            end
		            if PreSimConnection then
		                PreSimConnection:Disconnect()
		                PreSimConnection = nil
		            end
		            if RenderConnection then
		                RenderConnection:Disconnect()
		                RenderConnection = nil
		            end
		            LastHead = nil
		            pcall(function() sethiddenproperty(RootPart, "RootRef", nil) end)
		        end
		    end
		})
		
		
		PossisionSettingSec = Tabs.Attach:Section({Opened = true, Box = true, BoxBorder = true, Title = "Position Settings", Icon = "user-cog" })
		
		PossisionSettingSec:Slider({
		    Title = "Offset X (Left/Right)",
		    Flag = "tsbattachoffsetx",
		    Value = { Min = -20, Max = 20, Default = 0 },
		    Callback = function(Value) Offset = Vector3.new(Value, Offset.Y, Offset.Z) UpdateOffset() end
		})
		
		PossisionSettingSec:Slider({
		    Title = "Offset Y (Height)",
		    Flag = "tsbattachoffsety",
		    Value = { Min = -20, Max = 20, Default = 0 },
		    Callback = function(Value) Offset = Vector3.new(Offset.X, Value, Offset.Z) UpdateOffset() end
		})
		
		PossisionSettingSec:Slider({
		    Title = "Offset Z (Forward/Back)",
		    Flag = "tsbattachoffsetz",
		    Value = { Min = -20, Max = 20, Default = 0 }, 
		    Callback = function(Value) Offset = Vector3.new(Offset.X, Offset.Y, Value) UpdateOffset() end
		})
		
		RatationSettingsSec = Tabs.Attach:Section({Opened = true, Box = true, BoxBorder = true, Title = "Rotation Settings", Icon = "user-cog" })
		
		RatationSettingsSec:Slider({
		    Title = "Rotation X (Pitch)",
		    Flag = "tsbattachrotationx",
		    Value = { Min = -180, Max = 180, Default = 0 },
		    Callback = function(Value) RotOffset = Vector3.new(Value, RotOffset.Y, RotOffset.Z) UpdateOffset() end
		})
		
		RatationSettingsSec:Slider({
		    Title = "Rotation Y (Yaw)",
		    Flag = "tsbattachrotationy",
		    Value = { Min = -180, Max = 180, Default = 0 },
		    Callback = function(Value) RotOffset = Vector3.new(RotOffset.X, Value, RotOffset.Z) UpdateOffset() end
		})
		
		RatationSettingsSec:Slider({
		    Title = "Rotation Z (Roll)",
		    Flag = "tsbattachrotationz",
		    Value = { Min = -180, Max = 180, Default = 0 }, 
		    Callback = function(Value) RotOffset = Vector3.new(RotOffset.X, RotOffset.Y, Value) UpdateOffset() end
		})
	end)
end

-- ================ FLING0 TAB0 ================ --
function FlingTab()
	task.spawn(function()
		StarterGui = game:GetService("StarterGui")
		PlayersService = game:GetService("Players")
		RunService = game:GetService("RunService")
		PathfindingService = game:GetService("PathfindingService")
		UserInputService = game:GetService("UserInputService")
		TweenService = game:GetService("TweenService")
		
		localPlayer = PlayersService.LocalPlayer
		camera = workspace.CurrentCamera
		originalCameraSubject = camera.CameraSubject
		
		local FlingData = {
		    OldPos = nil,
		    FPDH = workspace.FallenPartsDestroyHeight or -500
		}
		
		USE_ATTACH_TELEPORT = false
		PREDICTION_INTENSITY = 1.25
		orbitSpeed = 8
		orbitDistance = 10
		bangSpeed = 5
		tweenSpeed = 10
		
		local loopFlags = {
		    teleport = false,
		    fling = false,
		    view = false,
		    aimLockCam = false,
		    aimLockChar = false,
		    orbit = false,
		    notifyOnDeath = false,
		    bang = false,
		    faceBang = false,
		    walkTo = false,
		    smartWalk = false,
		    tweenPlayer = false,
		    headSit = false,
		    backpack = false,
		    carpet = false
		}
		
		espEnabled = false
		espBillboard = nil
		connections = {}
		flingConnections = {}
		
		localCache = { Character = nil, Root = nil, Head = nil, Humanoid = nil }
		targetCache = { Character = nil, Root = nil, Head = nil, Humanoid = nil }
		selectedPlayerObject = nil
		
		selectorTool = nil
		toolEquipped = false
		toolToggleEnabled = false
		TOOL_NAME = "Select Player Tool"
		
		walkPath = nil
		walkIndex = 1
		lastTargetPos = Vector3.new()
		pathCalcDebounce = 0
		
		orbitAngle = 0
		bangTime = 0
		flingTimer = 0
		headSitSaved = nil
		backpackSaved = nil
		isFlinging = false
		
		currentTween = nil
		antiGravityVelocity = nil
		
		OrbitPlayerToggle = nil
		LoopFlingToggle = nil
		LoopViewToggle = nil
		AimLockCameraToggle = nil
		AimLockCharactherToggle = nil
		PlayerBangBang = nil
		FaceBangBang = nil
		WalkToPlayerToggle = nil
		TweenPlayerToggle = nil
		HeadSitPlayerToggle = nil
		BackpackPlayerToggle = nil
		CarpetPlayerToggle = nil
		EspPlayerToggle = nil
		
		local function sendNotification(title, text, icon, duration)
		    StarterGui:SetCore("SendNotification", {
		        Title = title or "VexonHub",
		        Text = text,
		        Icon = icon or "rbxassetid://84519376661277",
		        Duration = duration or 5
		    })
		end
		
		local function clearConnections(connTable)
		    for k, v in pairs(connTable) do
		        if typeof(v) == "RBXScriptConnection" and v.Connected then
		            v:Disconnect()
		        end
		    end
		    table.clear(connTable)
		end
		
		local function updateCache(cache, char)
		    cache.Character = char
		    if char then
		        cache.Root = char:WaitForChild("HumanoidRootPart", 5)
		        cache.Head = char:WaitForChild("Head", 5)
		        cache.Humanoid = char:WaitForChild("Humanoid", 5)
		    else
		        cache.Root = nil
		        cache.Head = nil
		        cache.Humanoid = nil
		    end
		end
		
		local function createSelectedEsp()
		    if espBillboard then
		        espBillboard:Destroy()
		        espBillboard = nil
		    end
		    if not targetCache.Head or not selectedPlayerObject then return end
		    espBillboard = Instance.new("BillboardGui")
		    espBillboard.Name = "ESP_Billboard"
		    espBillboard.Size = UDim2.new(0, 200, 0, 50)
		    espBillboard.Adornee = targetCache.Head
		    espBillboard.AlwaysOnTop = true
		    
		    local frame = Instance.new("Frame")
		    frame.Size = UDim2.new(1, 0, 1, 0)
		    frame.BackgroundColor3 = Color3.new(0.8, 0, 0)
		    frame.BackgroundTransparency = 0.6
		    frame.Parent = espBillboard
		    
		    local corner = Instance.new("UICorner")
		    corner.CornerRadius = UDim.new(0, 8)
		    corner.Parent = frame
		    
		    local textLabel = Instance.new("TextLabel")
		    textLabel.Size = UDim2.new(1, 0, 1, 0)
		    textLabel.BackgroundTransparency = 1
		    textLabel.TextColor3 = Color3.new(1, 1, 1)
		    textLabel.Text = selectedPlayerObject.DisplayName
		    textLabel.Font = Enum.Font.SourceSansBold
		    textLabel.TextSize = 16
		    textLabel.Parent = frame
		    
		    espBillboard.Parent = localPlayer.PlayerGui
		end
		
		local function removeSelectedEsp()
		    if espBillboard then
		        espBillboard:Destroy()
		        espBillboard = nil
		    end
		end
		
		local function manageDeathNotification()
		    if connections.targetDeath then 
		        connections.targetDeath:Disconnect() 
		        connections.targetDeath = nil 
		    end
		    if loopFlags.notifyOnDeath and targetCache.Humanoid and selectedPlayerObject then
		        connections.targetDeath = targetCache.Humanoid.Died:Connect(function()
		            sendNotification("VexonHub", selectedPlayerObject.DisplayName .. " Died")
		        end)
		    end
		end
		
		local function updateSelectedPlayer(playerName)
		    clearConnections(connections)
		    removeSelectedEsp()
		    selectedPlayerObject = nil
		    updateCache(targetCache, nil)
		    
		    if not playerName or playerName == "" then
		        sendNotification("VexonHub", "No One Selected")
		        return
		    end
		    
		    local lowerPlayerName = string.lower(playerName)
		    for _, player in ipairs(PlayersService:GetPlayers()) do
		        if string.find(string.lower(player.Name), lowerPlayerName, 1, true) or string.find(string.lower(player.DisplayName), lowerPlayerName, 1, true) then
		            selectedPlayerObject = player
		            break
		        end
		    end
		    
		    if selectedPlayerObject then
		        sendNotification("VexonHub", "Selected: " .. selectedPlayerObject.DisplayName, "https://www.roblox.com/headshot-thumbnail/image?userId=" .. selectedPlayerObject.UserId .. "&width=420&height=420&format=png", 10)
		        
		        connections.targetAdded = selectedPlayerObject.CharacterAdded:Connect(function(char)
		            task.spawn(function()
		                updateCache(targetCache, char)
		                manageDeathNotification()
		                if espEnabled then createSelectedEsp() end
		            end)
		        end)
		        
		        connections.targetRemoving = selectedPlayerObject.CharacterRemoving:Connect(function()
		            updateCache(targetCache, nil)
		            removeSelectedEsp()
		        end)
		        
		        if selectedPlayerObject.Character then
		            task.spawn(function()
		                updateCache(targetCache, selectedPlayerObject.Character)
		                manageDeathNotification()
		                if espEnabled then createSelectedEsp() end
		            end)
		        end
		    else
		        sendNotification("VexonHub", "Player Not Found...")
		    end
		end
		
		local function performAttachTeleport(desiredCFrame, targetPart)
		    if not desiredCFrame then return end
		    
		    local localChar = localPlayer.Character
		    if not localChar then return end
		    
		    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
		    if not localRoot or not localRoot.Parent then return end
		    
		    if USE_ATTACH_TELEPORT then
		        local adjustedCFrame = desiredCFrame * CFrame.new(0, 1.5, 0)
		        
		        localRoot.CFrame = adjustedCFrame
		        pcall(function() localChar:SetPrimaryPartCFrame(adjustedCFrame) end)
		        
		        local repPart = targetPart
		        if targetCache.Head and targetCache.Head.Parent then
		            repPart = targetCache.Head
		        end
		        
		        if repPart and repPart.Parent then
		            pcall(function() 
		                sethiddenproperty(localRoot, "PhysicsRepRootPart", repPart) 
		            end)
		        end
		    else
		        localRoot.CFrame = desiredCFrame
		    end
		end
		
		
		local function miniFling()
		    if not localCache.Root or not localCache.Humanoid or not targetCache.Character or isFlinging then return end
		    
		    local tRoot = targetCache.Root
		    local tHead = targetCache.Head
		    local targetPart = tHead or tRoot
		    if not targetPart then return end
		    
		    isFlinging = true
		    
		    if localCache.Root.Velocity.Magnitude < 50 then
		        FlingData.OldPos = localCache.Root.CFrame
		    end
		    
		    local cameraTarget = targetCache.Humanoid or tHead
		    if cameraTarget then
		        camera.CameraSubject = cameraTarget
		    end
		    
		    workspace.FallenPartsDestroyHeight = 0/0
		    
		    local bodyVelocity = Instance.new("BodyVelocity")
		    bodyVelocity.Name = "EpixVel"
		    bodyVelocity.Parent = localCache.Root
		    bodyVelocity.Velocity = Vector3.new(9e8, 9e8, 9e8)
		    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		    
		    localCache.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		    
		    local startTime = tick()
		    local angle = 0
		    
		    flingConnections.flingLoop = RunService.Heartbeat:Connect(function(dt)
		        if not targetPart or not targetPart.Parent or targetPart.Velocity.Magnitude > 500 or (targetCache.Humanoid and targetCache.Humanoid.Sit) or localCache.Humanoid.Health <= 0 or tick() > startTime + 2 then
		            clearConnections(flingConnections)
		            bodyVelocity:Destroy()
		            localCache.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		            camera.CameraSubject = localCache.Humanoid
		            
		            task.delay(0.1, function()
		                local returnPos = FlingData.OldPos and FlingData.OldPos * CFrame.new(0, 0.5, 0) or localCache.Root.CFrame
		                local retryCount = 0
		                local restoreConn
		                restoreConn = RunService.Heartbeat:Connect(function()
		                    if not localCache.Root then 
		                        restoreConn:Disconnect() 
		                        return 
		                    end
		                    localCache.Root.CFrame = returnPos
		                    localCache.Character:SetPrimaryPartCFrame(returnPos)
		                    localCache.Humanoid:ChangeState("GettingUp")
		                    
		                    for _, part in ipairs(localCache.Character:GetChildren()) do
		                        if part:IsA("BasePart") then
		                            part.Velocity = Vector3.new()
		                            part.RotVelocity = Vector3.new()
		                        end
		                    end
		                    
		                    retryCount = retryCount + 1
		                    if (localCache.Root.Position - returnPos.Position).Magnitude < 25 or retryCount > 50 then
		                        restoreConn:Disconnect()
		                        workspace.FallenPartsDestroyHeight = FlingData.FPDH
		                        isFlinging = false
		                    end
		                end)
		            end)
		            return
		        end
		        
		        angle = angle + (8000 * dt)
		        local offset = USE_ATTACH_TELEPORT and CFrame.new(0, 0.8 * math.sin(tick()*10), 0) or CFrame.new(0, 1.5 * math.sin(tick()*10), 0)
		        local rotation = USE_ATTACH_TELEPORT and CFrame.Angles(math.rad(angle), math.rad(angle * 0.7), 0) or CFrame.Angles(math.rad(angle), 0, 0)
		        
		        if not USE_ATTACH_TELEPORT and targetPart.Velocity.Magnitude < 50 and targetCache.Humanoid then
		            offset = offset + targetCache.Humanoid.MoveDirection * (targetPart.Velocity.Magnitude / PREDICTION_INTENSITY)
		        end
		        
		        local finalCFrame = CFrame.new(targetPart.Position) * offset * rotation
		        localCache.Root.CFrame = finalCFrame
		        localCache.Character:SetPrimaryPartCFrame(finalCFrame)
		        localCache.Root.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
		        localCache.Root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
		        
		        if USE_ATTACH_TELEPORT then
		            pcall(function() sethiddenproperty(localCache.Root, "PhysicsRepRootPart", targetPart) end)
		        end
		    end)
		end
		
		local function removeSelectorTool()
		    toolEquipped = false
		    if selectorTool then
		        selectorTool:Destroy()
		        selectorTool = nil
		    end
		    local bTool = localPlayer.Backpack:FindFirstChild(TOOL_NAME)
		    if bTool then bTool:Destroy() end
		    local cTool = localPlayer.Character and localPlayer.Character:FindFirstChild(TOOL_NAME)
		    if cTool then cTool:Destroy() end
		end
		
		local function giveSelectorTool()
		    if not toolToggleEnabled then return end
		    local existingInBackpack = localPlayer.Backpack:FindFirstChild(TOOL_NAME)
		    local existingInChar = localPlayer.Character and localPlayer.Character:FindFirstChild(TOOL_NAME)
		    if existingInBackpack or existingInChar then return end
		    
		    selectorTool = Instance.new("Tool")
		    selectorTool.Name = TOOL_NAME
		    selectorTool.RequiresHandle = false
		    selectorTool.Parent = localPlayer.Backpack
		    
		    connections.toolEquipped = selectorTool.Equipped:Connect(function()
		        toolEquipped = true
		        sendNotification("VexonHub", "Tool Equipped. Tap/Click a player to select.", nil, 3)
		    end)
		    
		    connections.toolUnequipped = selectorTool.Unequipped:Connect(function()
		        toolEquipped = false
		    end)
		end
		
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
		    if gameProcessed or not toolToggleEnabled or not toolEquipped then return end
		    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		        local target = nil
		        if input.UserInputType == Enum.UserInputType.MouseButton1 then
		            target = localPlayer:GetMouse().Target
		        else
		            local touchRay = camera:ViewportPointToRay(input.Position.X, input.Position.Y)
		            local raycastResult = workspace:Raycast(touchRay.Origin, touchRay.Direction * 1000)
		            if raycastResult then target = raycastResult.Instance end
		        end
		        
		        if target then
		            local character = target:FindFirstAncestorOfClass("Model")
		            if character then
		                local clickedPlayer = PlayersService:GetPlayerFromCharacter(character)
		                if clickedPlayer and clickedPlayer ~= localPlayer then
		                    if playerDropdown then
		                        playerDropdown:Select(clickedPlayer.Name)
		                    end
		                elseif clickedPlayer == localPlayer then
		                    sendNotification("VexonHub", "You cannot select yourself!", nil, 3)
		                end
		            end
		        end
		    end
		end)
		
		local function centralizedGameLoop(dt)
		    if not localCache.Root or not localCache.Humanoid then return end
		    
		    if loopFlags.aimLockCam and targetCache.Head then
		        camera.CFrame = CFrame.new(camera.CFrame.Position, targetCache.Head.Position)
		    end
		    
		    local tRoot = targetCache.Root
		    local tHead = targetCache.Head
		    local tPart = tRoot or tHead
		    if not tPart then return end
		    
		    if loopFlags.view and targetCache.Humanoid then
		        if camera.CameraSubject ~= targetCache.Humanoid then
		            camera.CameraSubject = targetCache.Humanoid
		        end
		    end
		    
		    if loopFlags.teleport then
		        performAttachTeleport(tPart.CFrame, tPart)
		    elseif loopFlags.orbit then
		        orbitAngle = (orbitAngle + orbitSpeed * dt * 50) % 360
		        local orbitCFrame = CFrame.new(tPart.Position) * CFrame.Angles(0, math.rad(orbitAngle), 0) * CFrame.new(orbitDistance, 0, 0)
		        local lookCFrame = CFrame.new(orbitCFrame.Position, tPart.Position)
		        performAttachTeleport(lookCFrame, tPart)
		    elseif loopFlags.aimLockChar then
		        local aimCFrame = CFrame.new(localCache.Root.Position, tPart.Position)
		        performAttachTeleport(aimCFrame, tPart)
		    elseif loopFlags.bang then
		        bangTime = bangTime + dt
		        local thrust = math.sin(bangTime * bangSpeed * 10) * 1.8
		        local finalCFrame = tPart.CFrame * CFrame.new(0, 0, 3.5 + thrust)
		        performAttachTeleport(finalCFrame, tPart)
		    elseif loopFlags.faceBang and tHead then
		        bangTime = bangTime + dt
		        local thrust = math.sin(bangTime * bangSpeed * 10) * 1.8
		        local finalCFrame = tHead.CFrame * CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, 1, 2.5 + thrust)
		        performAttachTeleport(finalCFrame, tHead)
		    elseif loopFlags.tweenPlayer then
		        if currentTween then
		            currentTween:Cancel()
		            currentTween = nil
		        end
		        local distance = (localCache.Root.Position - tPart.Position).Magnitude
		        if distance > 0.5 then
		            local duration = distance / tweenSpeed
		            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		            currentTween = TweenService:Create(localCache.Root, tweenInfo, {CFrame = tPart.CFrame})
		            currentTween:Play()
		        end
		    elseif loopFlags.headSit and tHead then
		        local sitCFrame = tHead.CFrame * CFrame.new(0, 3, 0)
		        performAttachTeleport(sitCFrame, tHead)
		    elseif loopFlags.backpack then
		        local backpackCFrame = tPart.CFrame * CFrame.new(0, 0, 1) * CFrame.Angles(0, math.rad(180), 0)
		        performAttachTeleport(backpackCFrame, tPart)
		    elseif loopFlags.carpet then
		        local carpetCFrame = tPart.CFrame * CFrame.new(0, -3.6, 0) * CFrame.Angles(math.rad(90), 0, 0)
		        performAttachTeleport(carpetCFrame, tPart)
		    end
		    
		    if loopFlags.walkTo then
		        if loopFlags.smartWalk then
		            pathCalcDebounce = pathCalcDebounce + dt
		            if (tPart.Position - lastTargetPos).Magnitude > 5 and pathCalcDebounce > 0.5 then
		                pathCalcDebounce = 0
		                lastTargetPos = tPart.Position
		                task.spawn(function()
		                    local path = PathfindingService:CreatePath({AgentRadius = 2, AgentHeight = 5, AgentCanJump = true, WaypointSpacing = 4})
		                    path:ComputeAsync(localCache.Root.Position, tPart.Position)
		                    if path.Status == Enum.PathStatus.Success then
		                        walkPath = path:GetWaypoints()
		                        walkIndex = 2
		                    end
		                end)
		            end
		            if walkPath and walkPath[walkIndex] then
		                local targetPoint = walkPath[walkIndex].Position
		                local dist = (localCache.Root.Position * Vector3.new(1,0,1) - targetPoint * Vector3.new(1,0,1)).Magnitude
		                if dist < 3 then
		                    walkIndex = walkIndex + 1
		                end
		                localCache.Humanoid:MoveTo(targetPoint)
		            end
		        else
		            localCache.Humanoid:MoveTo(tPart.Position)
		        end
		    end
		    
		    if loopFlags.fling then
		        flingTimer = flingTimer + dt
		        if flingTimer > 0.5 and not isFlinging then
		            flingTimer = 0
		            miniFling()
		        end
		    end
		end
		
		RunService.Heartbeat:Connect(centralizedGameLoop)
		
		local function stopAllLoops()
		    for k, _ in pairs(loopFlags) do loopFlags[k] = false end
		    espEnabled = false
		    camera.CameraSubject = localCache.Humanoid or originalCameraSubject
		    removeSelectedEsp()
		    if currentTween then
		        currentTween:Cancel()
		        currentTween = nil
		    end
		    if antiGravityVelocity then
		        antiGravityVelocity:Destroy()
		        antiGravityVelocity = nil
		    end
		    if localCache.Character then
		        for _, part in ipairs(localCache.Character:GetDescendants()) do
		            if part:IsA("BasePart") then
		                part.CanCollide = true
		            end
		        end
		    end
		    if localCache.Humanoid then
		        localCache.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		    end
		    if headSitSaved then
		        performAttachTeleport(headSitSaved)
		        if localCache.Humanoid then localCache.Humanoid.Sit = false end
		        headSitSaved = nil
		    end
		    if backpackSaved then
		        performAttachTeleport(backpackSaved)
		        if localCache.Humanoid then localCache.Humanoid.Sit = false end
		        backpackSaved = nil
		    end
		end
		
		local function onLocalCharacterAdded(char)
		    task.spawn(function()
		        updateCache(localCache, char)
		        if localCache.Root then
		            FlingData.OldPos = localCache.Root.CFrame
		        end
		        if localCache.Humanoid then
		            camera.CameraSubject = localCache.Humanoid
		        end
		        if toolToggleEnabled then
		            task.delay(1, giveSelectorTool)
		        end
		    end)
		end
		
		localPlayer.CharacterAdded:Connect(onLocalCharacterAdded)
		localPlayer.CharacterRemoving:Connect(function()
		    loopFlags.teleport = false
		    loopFlags.fling = false
		    loopFlags.orbit = false
		    loopFlags.aimLockChar = false
		    updateCache(localCache, nil)
		end)
		
		if localPlayer.Character then
		    onLocalCharacterAdded(localPlayer.Character)
		end
		
		PlayersService.PlayerRemoving:Connect(function(player)
		    if selectedPlayerObject and player == selectedPlayerObject then
		        sendNotification("VexonHub", player.DisplayName .. " left the game")
		        stopAllLoops()
		        if LoopViewToggle then LoopViewToggle:Set(false) end
		        if LoopFlingToggle then LoopFlingToggle:Set(false) end
		        if AimLockCameraToggle then AimLockCameraToggle:Set(false) end
		        if FaceBangBang then FaceBangBang:Set(false) end
		        if AimLockCharactherToggle then AimLockCharactherToggle:Set(false) end
		        if EspPlayerToggle then EspPlayerToggle:Set(false) end
		        if CarpetPlayerToggle then CarpetPlayerToggle:Set(false) end
		        if TweenPlayerToggle then TweenPlayerToggle:Set(false) end
		        if HeadSitPlayerToggle then HeadSitPlayerToggle:Set(false) end
		        if BackpackPlayerToggle then BackpackPlayerToggle:Set(false) end
		        if OrbitPlayerToggle then OrbitPlayerToggle:Set(false) end
		        if PlayerBangBang then PlayerBangBang:Set(false) end
		        if WalkToPlayerToggle then WalkToPlayerToggle:Set(false) end
		        updateSelectedPlayer(nil)
		    end
		end)
		
		local FlingSelect = Tabs.Fling:Section({Opened = true, Box = true, BoxBorder = true, Title = "Player Selection", Icon = "eye" })
		
		FlingSelect:Paragraph({
		    Title = "Note:", 
		    Desc = "its a method to make your Teleports 0 ping basically no cooldown rly op 100% flings the guy if the player dont use some type of anti fling. Only works for good executors like delta if you use executors that not support it will probably just crash. Xeno not Supported!!",
		    Image = "rbxassetid://84519376661277",
		    ImageSize = 25,
		    Thumbnail = "",
		    ThumbnailSize = 0,
		    Locked = false,
		})
		
		playerDropdown = FlingSelect:Dropdown({
		    Title = "Select Player",
		    SpecialType = "Player",
		    ExcludeLocalPlayer = true,
		    SearchBarEnabled = true,
		    Callback = function(selected)
		        local name = typeof(selected) == "table" and selected.Title or tostring(selected)
		        updateSelectedPlayer(name)
		    end
		})
		
		FlingSelect:Toggle({
		    Title = "Attach Mode",
		    Desc = "its a method to make your Teleports 0 ping basically no cooldown.",
		    Value = false,
		    Callback = function(state) 
		        USE_ATTACH_TELEPORT = state
		    end
		})
		
		FlingSelect:Toggle({
		    Title = "Player Selector Tool",
		    Desc = "Adds a tool to your inventory to select players by clicking/tapping them.",
		    Value = false,
		    Callback = function(state)
		        toolToggleEnabled = state
		        if state then
		            giveSelectorTool()
		        else
		            removeSelectorTool()
		        end
		    end
		})
		
		FlingSelect:Slider({
		    Title = "Prediction Intensity",
		    Desc = "Prediction for the fling to work better and more change to fling people",
		    Step = 0.1,
		    Value = {
		        Min = 0,
		        Max = 5,
		        Default = 1.2,
		    },
		    Flag = 'flingflingpredictionfling',
		    Callback = function(value)
		        PREDICTION_INTENSITY = value
		    end
		})
		
		local FlingOther = Tabs.Fling:Section({Opened = true, Box = true, BoxBorder = true, Title = "Player Actions" })
		
		FlingOther:Button({
		    Title = "Teleport to Player",
		    Callback = function()
		        if not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            return
		        end
		        local tRoot = targetCache.Root
		        local tHead = targetCache.Head
		        local targetPart = tHead or tRoot    
		        if not targetPart then
		            sendNotification("VexonHub", "Could not find character to teleport.")
		            return
		        end
		        performAttachTeleport(targetPart.CFrame, targetPart)
		    end
		})
		
		FlingOther:Toggle({
		    Title = "Loop Teleport",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.teleport = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.teleport = false
		        end
		    end
		})
		
		FlingOther:Button({
		    Title = "Fix fling teleport bug",
		    Callback = function()
		        if localCache.Root then
		            if FlingData.OldPos then
		                FlingData.OldPos = localCache.Root.CFrame
		                sendNotification("VexonHub", "Teleport bug fixed!")
		            else
		                sendNotification("VexonHub", "Didn't find any teleport bug?")
		            end
		        end
		    end
		})
		
		FlingOther:Divider()
		
		FlingOther:Slider({
		    Title = "Orbit Speed",
		    Desc = "Speed of the orbit around the selected player",
		    Step = 1,
		    Value = {
		        Min = 1,
		        Max = 30,
		        Default = 8,
		    },
		    Flag = 'flingorbitspeed',
		    Callback = function(value)
		        orbitSpeed = value
		    end
		})
		
		FlingOther:Slider({
		    Title = "Orbit Distance",
		    Desc = "Distance from the selected player in orbit",
		    Step = 1,
		    Flag = 'flingorbitdistance',
		    Value = {
		        Min = 5,
		        Max = 30,
		        Default = 10,
		    },
		    Callback = function(value)
		        orbitDistance = value
		    end
		})
		
		OrbitPlayerToggle = FlingOther:Toggle({
		    Title = "Orbit Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.orbit = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.orbit = false
		        end
		    end
		})
		
		FlingOther:Divider()
		
		FlingOther:Button({
		    Title = "Fling Player",
		    Callback = function()
		        if not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            return
		        end
		        miniFling()
		    end
		})
		
		LoopFlingToggle = FlingOther:Toggle({
		    Title = "Loop Fling",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.fling = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.fling = false
		        end
		    end
		})
		
		FlingOther:Divider()
		
		FlingOther:Button({
		    Title = "View Player (5 sec)",
		    Callback = function()
		        if not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            return
		        end
		        if targetCache.Humanoid then
		            camera.CameraSubject = targetCache.Humanoid
		            task.delay(5, function()
		                if camera.CameraSubject == targetCache.Humanoid then
		                    camera.CameraSubject = localCache.Humanoid or originalCameraSubject
		                end
		            end)
		        else
		            sendNotification("VexonHub", "Could not find the player's character to view.")
		        end
		    end
		})
		
		LoopViewToggle = FlingOther:Toggle({
		    Title = "Loop View",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.view = toggleState
		        if not toggleState then
		            camera.CameraSubject = localCache.Humanoid or originalCameraSubject
		            return
		        end
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.view = false
		            camera.CameraSubject = localCache.Humanoid or originalCameraSubject
		        end
		    end
		})
		
		FlingOther:Divider()
		
		AimLockCameraToggle = FlingOther:Toggle({
		    Title = "AimLock (Camera)",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.aimLockCam = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.aimLockCam = false
		        end
		    end
		})
		
		AimLockCharactherToggle = FlingOther:Toggle({
		    Title = "AimLock (Character)",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.aimLockChar = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.aimLockChar = false
		        end
		    end
		})
		
		FlingOther:Divider()
		
		PlayerBangBang = FlingOther:Toggle({
		    Title = "Bang Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.bang = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.bang = false
		        end
		    end
		})
		
		FaceBangBang = FlingOther:Toggle({
		    Title = "Face Bang Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.faceBang = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.faceBang = false
		        end
		    end
		})
		
		FlingOther:Slider({
		    Title = "Bang Speed",
		    Desc = "Speed of the thrusting motion",
		    Flag = 'flingbangspeed',
		    Step = 0.1,
		    Value = {
		        Min = 1,
		        Max = 20,
		        Default = 5,
		    },
		    Callback = function(value)
		        bangSpeed = value
		    end
		})
		
		FlingOther:Divider()
		
		WalkToPlayerToggle = FlingOther:Toggle({
		    Title = "Walk to Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.walkTo = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.walkTo = false
		        end
		    end
		})
		
		FlingOther:Toggle({
		    Title = "Smart Walk Mode",
		    Flag = 'flingsmartwalkmode',
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.smartWalk = toggleState
		    end
		})
		
		FlingOther:Divider()
		
		TweenPlayerToggle = FlingOther:Toggle({
		    Title = "Tween Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.tweenPlayer = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.tweenPlayer = false
		            return
		        end
		        if toggleState then
		            if localCache.Character then
		                for _, part in ipairs(localCache.Character:GetDescendants()) do
		                    if part:IsA("BasePart") then
		                        part.CanCollide = false
		                    end
		                end
		            end
		            if localCache.Root and not antiGravityVelocity then
		                antiGravityVelocity = Instance.new("BodyVelocity")
		                antiGravityVelocity.Name = "AntiGravity"
		                antiGravityVelocity.MaxForce = Vector3.new(0, math.huge, 0)
		                antiGravityVelocity.Velocity = Vector3.new(0, 0, 0)
		                antiGravityVelocity.Parent = localCache.Root
		            end
		            if localCache.Humanoid then
		                localCache.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		            end
		        else
		            if currentTween then
		                currentTween:Cancel()
		                currentTween = nil
		            end
		            if antiGravityVelocity then
		                antiGravityVelocity:Destroy()
		                antiGravityVelocity = nil
		            end
		            if localCache.Character then
		                for _, part in ipairs(localCache.Character:GetDescendants()) do
		                    if part:IsA("BasePart") then
		                        part.CanCollide = true
		                    end
		                end
		            end
		            if localCache.Humanoid then
		                localCache.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		            end
		        end
		    end
		})
		
		FlingOther:Slider({
		    Title = "Tween Speed",
		    Step = 1,
		    Flag = 'flingtweenspeed',
		    Value = {
		        Min = 1,
		        Max = 1000,
		        Default = 50,
		    },
		    Callback = function(value)
		        tweenSpeed = value
		    end
		})
		
		FlingOther:Button({
		    Title = "Stop Tween",
		    Callback = function()
		        if currentTween then
		            currentTween:Cancel()
		            currentTween = nil
		        end
		        sendNotification("VexonHub", "Tween stopped!")
		    end
		})
		
		FlingOther:Divider()
		
		HeadSitPlayerToggle = FlingOther:Toggle({
		    Title = "Head Sit Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.headSit = toggleState
		        if not toggleState and headSitSaved then
		            if localCache.Humanoid then localCache.Humanoid.Sit = false end
		            performAttachTeleport(headSitSaved)
		            headSitSaved = nil
		            return
		        end
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.headSit = false
		            return
		        end
		        if toggleState and localCache.Root then
		            headSitSaved = localCache.Root.CFrame
		            if localCache.Humanoid then localCache.Humanoid.Sit = true end
		        end
		    end
		})
		
		BackpackPlayerToggle = FlingOther:Toggle({
		    Title = "Backpack Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.backpack = toggleState
		        if not toggleState and backpackSaved then
		            if localCache.Humanoid then localCache.Humanoid.Sit = false end
		            performAttachTeleport(backpackSaved)
		            backpackSaved = nil
		            return
		        end
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.backpack = false
		            return
		        end
		        if toggleState and localCache.Root then
		            backpackSaved = localCache.Root.CFrame
		            if localCache.Humanoid then localCache.Humanoid.Sit = true end
		        end
		    end
		})
		
		CarpetPlayerToggle = FlingOther:Toggle({
		    Title = "Carpet Player",
		    Value = false,
		    Callback = function(toggleState)
		        loopFlags.carpet = toggleState
		        if toggleState and not selectedPlayerObject then
		            sendNotification("VexonHub", "No One Selected")
		            loopFlags.carpet = false
		        end
		    end
		})
		
		FlingOther:Divider()
		
		EspPlayerToggle = FlingOther:Toggle({
		    Title = "ESP",
		    Value = espEnabled,
		    Callback = function(toggleState)
		        espEnabled = toggleState
		        if espEnabled then
		            createSelectedEsp()
		        else
		            removeSelectedEsp()
		        end
		    end
		})
		
		FlingOther:Toggle({
		    Title = "Notify On Death",
		    Flag = 'flingnotifyondeath',
		    Value = false,
		    Callback = function(toggle)
		        loopFlags.notifyOnDeath = toggle
		        manageDeathNotification()
		    end
		})
		
		FlingOther:Button({
		    Title = "Stop All Loops",
		    Callback = function()
		        stopAllLoops()
		        if LoopViewToggle then LoopViewToggle:Set(false) end
		        if LoopFlingToggle then LoopFlingToggle:Set(false) end
		        if AimLockCameraToggle then AimLockCameraToggle:Set(false) end
		        if FaceBangBang then FaceBangBang:Set(false) end
		        if AimLockCharactherToggle then AimLockCharactherToggle:Set(false) end
		        if EspPlayerToggle then EspPlayerToggle:Set(false) end
		        if CarpetPlayerToggle then CarpetPlayerToggle:Set(false) end
		        if TweenPlayerToggle then TweenPlayerToggle:Set(false) end
		        if HeadSitPlayerToggle then HeadSitPlayerToggle:Set(false) end
		        if BackpackPlayerToggle then BackpackPlayerToggle:Set(false) end
		        if OrbitPlayerToggle then OrbitPlayerToggle:Set(false) end
		        if PlayerBangBang then PlayerBangBang:Set(false) end
		        if WalkToPlayerToggle then WalkToPlayerToggle:Set(false) end
		    end
		})
		
		
		
		
		FlingBlah = Tabs.Fling:Section({
		    Opened = true,
		    Box = true,
		    BoxBorder = true,
		    Title = "Fling",
		    Icon = "utensils"
		})
		
		local flingAuraEnabled = false
		local clickFlingEnabled = false
		local flingAllEnabled = false
		local touchFlingEnabled = false
		local customTouchFlingEnabled = false
		local antiFlingEnabled = false
		local flingPower = 100
		local auraConnections = {}
		
		local function cleanupAuraConnections()
		    for _, conn in pairs(auraConnections) do
		        if conn and conn.Connected then
		            conn:Disconnect()
		        end
		    end
		    table.clear(auraConnections)
		end
		
		local function flingSpecificPlayer(targetPlayer)
		    if not targetPlayer or targetPlayer == localPlayer or not targetPlayer.Character then
		        return
		    end
		    local char = targetPlayer.Character
		    local backupSelected = selectedPlayerObject
		    local backupCache = {
		        Character = targetCache.Character,
		        Root = targetCache.Root,
		        Head = targetCache.Head,
		        Humanoid = targetCache.Humanoid
		    }
		    selectedPlayerObject = targetPlayer
		    updateCache(targetCache, char)
		    miniFling()
		    task.spawn(function()
		        local startTime = tick()
		        while isFlinging and (tick() - startTime < 5) do
		            task.wait(0.2)
		        end
		        selectedPlayerObject = backupSelected
		        updateCache(targetCache, backupCache.Character)
		    end)
		end
		
		local function startFlingAura()
		    cleanupAuraConnections()
		    table.insert(auraConnections, RunService.Heartbeat:Connect(function()
		        if not flingAuraEnabled or not localCache.Root then
		            return
		        end
		        for _, plr in ipairs(PlayersService:GetPlayers()) do
		            if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		                local myPos = localCache.Root.Position
		                local tgtPos = plr.Character.HumanoidRootPart.Position
		                if (myPos - tgtPos).Magnitude <= 10 then
		                    flingSpecificPlayer(plr)
		                    task.wait(1)
		                    break
		                end
		            end
		        end
		    end))
		end
		
		local function startFlingAll()
		    cleanupAuraConnections()
		    table.insert(auraConnections, RunService.Heartbeat:Connect(function()
		        if not flingAllEnabled then
		            return
		        end
		        for _, plr in ipairs(PlayersService:GetPlayers()) do
		            if plr ~= localPlayer and plr.Character then
		                flingSpecificPlayer(plr)
		                task.wait(0.5)
		            end
		        end
		    end))
		end
		
		local hiddenfling = false
		local detection
		if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		    hiddenfling = false
		else
		    hiddenfling = false
		    detection = Instance.new("Decal")
		    detection.Name = "juisdfj0i32i0eidsuf0iok"
		    detection.Parent = game:GetService("ReplicatedStorage")
		end
		
		local function hiddenFlingLoop()
		    local hrp, c, vel, movel = nil, nil, nil, 0.1
		    while hiddenfling do
		        RunService.Heartbeat:Wait()
		        local lp = PlayersService.LocalPlayer
		        while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
		            RunService.Heartbeat:Wait()
		            c = lp.Character
		            hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
		        end
		        if hiddenfling then
		            vel = hrp.Velocity
		            hrp.Velocity = vel * 9e7 + Vector3.new(0, 9e7, 0)
		            RunService.RenderStepped:Wait()
		            if c and c.Parent and hrp and hrp.Parent then
		                hrp.Velocity = vel
		            end
		            RunService.Stepped:Wait()
		            if c and c.Parent and hrp and hrp.Parent then
		                hrp.Velocity = vel + Vector3.new(0, movel, 0)
		                movel = movel * -1
		            end
		        end
		    end
		end
		
		local function customHiddenFlingLoop()
		    local hrp, c, vel, movel = nil, nil, nil, 0.1
		    while hiddenfling do
		        RunService.Heartbeat:Wait()
		        local lp = PlayersService.LocalPlayer
		        while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
		            RunService.Heartbeat:Wait()
		            c = lp.Character
		            hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
		        end
		        if hiddenfling then
		            vel = hrp.Velocity
		            hrp.Velocity = vel * flingPower + Vector3.new(0, 100, 0)
		            RunService.RenderStepped:Wait()
		            if c and c.Parent and hrp and hrp.Parent then
		                hrp.Velocity = vel
		            end
		            RunService.Stepped:Wait()
		            if c and c.Parent and hrp and hrp.Parent then
		                hrp.Velocity = vel + Vector3.new(0, movel, 0)
		                movel = movel * -1
		            end
		        end
		    end
		end
		
		local antiflingConnections = {}
		
		local function NoCollision(PLR)
		    if antiFlingEnabled and PLR.Character then
		        for _, x in pairs(PLR.Character:GetDescendants()) do
		            if x:IsA("BasePart") and x.CanCollide then
		                x.CanCollide = false
		            end
		        end
		    end
		end
		
		local function RestoreCollision()
		    for _, v in pairs(PlayersService:GetPlayers()) do
		        if v ~= localPlayer and v.Character then
		            for _, x in pairs(v.Character:GetDescendants()) do
		                if x:IsA("BasePart") then
		                    x.CanCollide = true
		                end
		            end
		        end
		    end
		end
		
		local function EnableAntiFling()
		    for _, v in pairs(PlayersService:GetPlayers()) do
		        if v ~= localPlayer then
		            local connection = RunService.Stepped:Connect(function()
		                NoCollision(v)
		            end)
		            table.insert(antiflingConnections, connection)
		        end
		    end
		    PlayersService.PlayerAdded:Connect(function(player)
		        if player ~= localPlayer then
		            local connection = RunService.Stepped:Connect(function()
		                NoCollision(player)
		            end)
		            table.insert(antiflingConnections, connection)
		        end
		    end)
		end
		
		local function DisableAntiFling()
		    for _, connection in pairs(antiflingConnections) do
		        if connection.Connected then
		            connection:Disconnect()
		        end
		    end
		    table.clear(antiflingConnections)
		    RestoreCollision()
		end
		
		local function getPlayerFromTarget(target)
		    if target and target.Parent and target.Parent:IsA("Model") then
		        return PlayersService:GetPlayerFromCharacter(target.Parent)
		    end
		end
		
		local mouse = localPlayer:GetMouse()
		
		FlingBlah:Toggle({
		    Title = "Fling Aura",
		    Value = false,
		    Callback = function(toggleState)
		        flingAuraEnabled = toggleState
		        if toggleState then
		            startFlingAura()
		        else
		            cleanupAuraConnections()
		        end
		    end
		})
		
		FlingBlah:Toggle({
		    Title = "Click Fling",
		    Value = false,
		    Callback = function(toggleState)
		        clickFlingEnabled = toggleState
		    end
		})
		
		mouse.Button1Down:Connect(function()
		    if not clickFlingEnabled then
		        return
		    end
		    local targetPlayer = getPlayerFromTarget(mouse.Target)
		    if targetPlayer and targetPlayer ~= localPlayer then
		        flingSpecificPlayer(targetPlayer)
		    end
		end)
		
		UserInputService.TouchTap:Connect(function(touchPositions, gameProcessed)
		    if not clickFlingEnabled or gameProcessed then
		        return
		    end
		    local touchPosition = touchPositions[1]
		    local rayOrigin = camera.CFrame.Position
		    local rayDirection = (camera:ViewportPointToRay(touchPosition.X, touchPosition.Y)).Direction * 500
		    local raycastParams = RaycastParams.new()
		    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
		    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		    local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
		    local targetPlayer = getPlayerFromTarget(result and result.Instance)
		    if targetPlayer and targetPlayer ~= localPlayer then
		        flingSpecificPlayer(targetPlayer)
		    end
		end)
		
		FlingBlah:Toggle({
		    Title = "Fling All (Buggy?)",
		    Value = false,
		    Callback = function(toggleState)
		        flingAllEnabled = toggleState
		        if toggleState then
		            startFlingAll()
		        else
		            cleanupAuraConnections()
		        end
		    end
		})
		
		FlingBlah:Toggle({
		    Title = "Touch Fling",
		    Value = false,
		    Callback = function(toggleState)
		        touchFlingEnabled = toggleState
		        hiddenfling = toggleState
		        if toggleState then
		            coroutine.wrap(hiddenFlingLoop)()
		        end
		    end
		})
		FlingBlah:Divider()
		FlingBlah:Toggle({
		    Title = "Costum Touch Fling Power",
		    Value = false,
		    Callback = function(toggleState)
		        customTouchFlingEnabled = toggleState
		        hiddenfling = toggleState
		        if toggleState then
		            coroutine.wrap(customHiddenFlingLoop)()
		        end
		    end
		})
		
		FlingBlah:Input({
		    Title = "Fling Power Value",
		    Value = "100",
		    Type = "Input",
		    Flag = 'flingpowervalue',
		    Placeholder = "Enter fling power...",
		    Callback = function(num)
		        flingPower = tonumber(num) or 100
		    end
		})
		
		FlingBlah:Toggle({
		    Title = "Anti Fling",
		    Flag = 'flingantifling',
		    Value = false,
		    Callback = function(toggleState)
		        antiFlingEnabled = toggleState
		        if toggleState then
		            EnableAntiFling()
		        else
		            DisableAntiFling()
		        end
		    end
		})
	end)
end














-- ================ TELEPORT0 TAB0 ================ --
function TeleportTab()
	task.spawn(function()
		TPThings = Tabs.Place:Section({Opened = true, Box = true, BoxBorder = true, Title = "TP Stuff", Icon = "eye" })
		
		TPThings:Button({
		    Title = "Teleport Panel",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/uiTL0dfO/raw"))()
		end
		})
		
		
		TPThings:Button({
		    Title = "TP Frozen Lock",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/yxXqDjA2/raw"))()
		end
		})
		
		TPThings:Button({
		    Title = "TP Dummy",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/oJwPZY4a/raw"))()
		end
		})
		
		TPPlaces = Tabs.Place:Section({Opened = true, Box = true, BoxBorder = true, Title = "Teleport Places", Icon = "map" })
		
		places = {
		    { "Middle Of Map", 139, 440, 32 },
		    { "Prison", 438, 439, -376 },
		    { "Montain", 155, 628, -447 },
		    { "Door 1", 17, 440, -301 },
		    { "Door 2", 290, 440, 361 },
		    { "Corner 1", 29, 442, 488 },
		    { "Corner 2", -261, 442, -248 },
		    { "Corner 3", 263, 442, -456 },
		    { "Corner 4", 566, 442, 274 },
		    { "Counter", -68, 29, 20346 },
		    { "Counter Up", -78, 84, 20354 },
		    { "Atomic Base", 1063, 30, 23006 },
		    { "Atomic Base Up", 1063, 405, 23006 },
		    { "Atomic Slash", 1063, 131, 23006 },
		    { "Atomic Slash Up", 1063, 190, 23006 },
		    { "Little SafeZone", 150, 505, 30 },
		    { "Big SafeZone", 150, 705, 30 },
		    { "Void", 150, -495, 30 },
		    { "Darkness", 0, 900000000005, 0 },
		    { "Smoke", 0, -1, 0 },
		    { "Pixel", 30000000, 30000000, 30000000 },
			{ "Secret Board", 38.473, 87796.758, 32.568 }
		}
		
		for _, place in ipairs(places) do
		    TPPlaces:Button({
		        Title = place[1],
		        Locked = false,
		        Callback = function()
		            local plr = game.Players.LocalPlayer
		            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		                plr.Character.HumanoidRootPart.CFrame = CFrame.new(place[2], place[3], place[4])
		            end
		        end
		    })
		end
	end)
end

















-- ================ ESP0 TAB0 ================ --
function EspTab()
	task.spawn(function()
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local StarterGui = game:GetService("StarterGui")
		local Workspace = game:GetService("Workspace")
		local TextService = game:GetService("TextService")
		local LocalPlayer = Players.LocalPlayer
		
		local hasDrawing = Drawing ~= nil
		
		local ESP = {
		    Enabled = false,
		    HumanoidRootPart = true,
		    Highlight = true,
		    Tracker = true,
		    KillStreak = true,
		    Ping = true,
		    UltBar = true,
		    Name = true,
		    Health = true,
		    TotalKills = true,
		    TeamCheck = false,
		    OnlySelectedESP = false,
		    SelectedPlayers = {},
		    ESPColor = Color3.fromRGB(255, 70, 70),
		    HighlightColor = Color3.fromRGB(255, 70, 70),
		    ESPTransparency = 0.3,
		    HighlightTransparency = 0,
		    MaxDistance = 500,
		    InfiniteDistance = false,
		    Device = true,
		    DeathCounter = false,
		    Distance = true
		}
		
		local ESP_TABLE = {}
		local activeConnections = {}
		local playerCharConns = {}
		local pendingEsp = {}
		local deathCounterObjects = {}
		local deathCounterActive = false
		local mainRenderConnection = nil
		local localHRP = nil
		local selectedDropdown = nil
		local localPlayerDiedConn = nil
		
		local function safeDestroy(obj)
		    if not obj then return end
		    pcall(function()
		        if typeof(obj) == "Instance" then
		            obj:Destroy()
		        end
		    end)
		end
		
		local function safeRemoveDrawing(drawingObj)
		    if not drawingObj then return end
		    pcall(function()
		        drawingObj.Visible = false
		        if drawingObj.Remove then
		            drawingObj:Remove()
		        end
		    end)
		end
		
		local function isPlayerInList(list, name)
		    if type(list) ~= "table" then return false end
		    for k, v in pairs(list) do
		        if v == name or (type(v) == "boolean" and k == name and v == true) then
		            return true
		        end
		    end
		    return false
		end
		
		local function setupLocalPlayerCharacter(character)
		    if not character then return end
		    local hrp = character:WaitForChild("HumanoidRootPart", 5)
		    local humanoid = character:WaitForChild("Humanoid", 5)
		    if hrp then
		        localHRP = hrp
		    end
		    if humanoid then
		        if localPlayerDiedConn then
		            pcall(function() localPlayerDiedConn:Disconnect() end)
		            for i, conn in ipairs(activeConnections) do
		                if conn == localPlayerDiedConn then
		                    table.remove(activeConnections, i)
		                    break
		                end
		            end
		        end
		        localPlayerDiedConn = humanoid.Died:Connect(function()
		            localHRP = nil
		        end)
		        table.insert(activeConnections, localPlayerDiedConn)
		    end
		end
		
		local function disconnectPlayerCharConn(player)
		    local conn = playerCharConns[player]
		    if conn then
		        pcall(function() conn:Disconnect() end)
		        playerCharConns[player] = nil
		    end
		end
		
		local function cleanupPending(player)
		    if pendingEsp[player] then
		        pcall(function() pendingEsp[player]:Disconnect() end)
		        pendingEsp[player] = nil
		    end
		end
		
		local function removeEsp(player)
		    local data = ESP_TABLE[player]
		    if not data then return end
		    ESP_TABLE[player] = nil
		
		    pcall(function()
		        safeDestroy(data.Highlight)
		        safeDestroy(data.HRPBox)
		        safeDestroy(data.Billboard)
		        safeRemoveDrawing(data.TracerLine)
		    end)
		    pcall(function() data.DiedConn:Disconnect() end)
		    pcall(function() data.DestroyingConn:Disconnect() end)
		    pcall(function() data.MaxHealthConn:Disconnect() end)
		
		    cleanupPending(player)
		end
		
		local function cleanupAllEsp()
		    for player, data in pairs(ESP_TABLE) do
		        if data then
		            pcall(function()
		                safeDestroy(data.Highlight)
		                safeDestroy(data.HRPBox)
		                safeDestroy(data.Billboard)
		                safeRemoveDrawing(data.TracerLine)
		            end)
		            pcall(function() data.DiedConn:Disconnect() end)
		            pcall(function() data.DestroyingConn:Disconnect() end)
		            pcall(function() data.MaxHealthConn:Disconnect() end)
		        end
		    end
		    ESP_TABLE = {}
		
		    for player, conn in pairs(playerCharConns) do
		        pcall(function() conn:Disconnect() end)
		    end
		    playerCharConns = {}
		
		    for player, conn in pairs(pendingEsp) do
		        pcall(function() conn:Disconnect() end)
		    end
		    pendingEsp = {}
		end
		
		local function cleanupDeathCounter()
		    for player, obj in pairs(deathCounterObjects) do
		        safeDestroy(obj)
		    end
		    deathCounterObjects = {}
		end
		
		local function createEsp(player)
		    if player == LocalPlayer then return end
		    if not ESP.Enabled then return end
		
		    removeEsp(player)
		
		    local character = player.Character
		    if not character then return end
		
		    local humanoid = character:FindFirstChildOfClass("Humanoid")
		    local hrp = character:FindFirstChild("HumanoidRootPart")
		    if not humanoid or not hrp then return end
		
		    local head = character:FindFirstChild("Head")
		
		    local hrpBox = Instance.new("SelectionBox")
		    hrpBox.Name = "HRP_ESP"
		    hrpBox.Adornee = hrp
		    hrpBox.LineThickness = 0.05
		    hrpBox.Color3 = ESP.ESPColor
		    hrpBox.SurfaceTransparency = 1
		    hrpBox.Parent = hrp
		
		    local highlight = Instance.new("Highlight")
		    highlight.Name = "CharHighlight"
		    highlight.FillTransparency = ESP.ESPTransparency
		    highlight.OutlineTransparency = ESP.HighlightTransparency
		    highlight.OutlineColor = ESP.HighlightColor
		    highlight.FillColor = ESP.HighlightColor
		    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		    highlight.Parent = character
		
		    local billboard = Instance.new("BillboardGui")
		    billboard.Name = "ESP_Billboard"
		    billboard.Adornee = head or hrp
		    billboard.AlwaysOnTop = true
		    billboard.MaxDistance = math.huge
		    billboard.ClipsDescendants = true
		    billboard.Parent = head or hrp
		
		    local container = Instance.new("Frame")
		    container.Name = "Container"
		    container.Size = UDim2.new(1, 0, 1, 0)
		    container.BackgroundTransparency = 0.25
		    container.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
		    container.BorderSizePixel = 2
		    container.BorderColor3 = ESP.ESPColor
		    container.Parent = billboard
		
		    local corner = Instance.new("UICorner")
		    corner.CornerRadius = UDim.new(0, 3)
		    corner.Parent = container
		
		    local nameLabel = Instance.new("TextLabel")
		    nameLabel.Name = "NameLabel"
		    nameLabel.Size = UDim2.new(1, -4, 0, 12)
		    nameLabel.Position = UDim2.new(0, 2, 0, 2)
		    nameLabel.BackgroundTransparency = 1
		    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		    nameLabel.TextStrokeTransparency = 0.2
		    nameLabel.Font = Enum.Font.GothamBold
		    nameLabel.TextSize = 10
		    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
		    nameLabel.TextYAlignment = Enum.TextYAlignment.Center
		    nameLabel.Text = ""
		    nameLabel.Parent = container
		
		    local infoLabel = Instance.new("TextLabel")
		    infoLabel.Name = "InfoLabel"
		    infoLabel.Size = UDim2.new(1, -4, 0, 10)
		    infoLabel.Position = UDim2.new(0, 2, 0, 15)
		    infoLabel.BackgroundTransparency = 1
		    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		    infoLabel.TextStrokeTransparency = 0.2
		    infoLabel.Font = Enum.Font.GothamBold
		    infoLabel.TextSize = 8
		    infoLabel.TextXAlignment = Enum.TextXAlignment.Center
		    infoLabel.TextYAlignment = Enum.TextYAlignment.Center
		    infoLabel.Text = ""
		    infoLabel.Parent = container
		
		    local healthContainer = Instance.new("Frame")
		    healthContainer.Name = "HealthContainer"
		    healthContainer.Size = UDim2.new(0.47, 0, 0, 8)
		    healthContainer.Position = UDim2.new(0.02, 0, 0, 27)
		    healthContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
		    healthContainer.BorderSizePixel = 1
		    healthContainer.BorderColor3 = Color3.new(0.2, 0.2, 0.25)
		    healthContainer.Parent = container
		
		    local healthBar = Instance.new("Frame")
		    healthBar.Name = "HealthBar"
		    healthBar.Size = UDim2.new(1, 0, 1, 0)
		    healthBar.BackgroundColor3 = Color3.fromRGB(30, 200, 80)
		    healthBar.BorderSizePixel = 0
		    healthBar.Parent = healthContainer
		
		    local ultContainer = Instance.new("Frame")
		    ultContainer.Name = "UltContainer"
		    ultContainer.Size = UDim2.new(0.47, 0, 0, 8)
		    ultContainer.Position = UDim2.new(0.51, 0, 0, 27)
		    ultContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
		    ultContainer.BorderSizePixel = 1
		    ultContainer.BorderColor3 = Color3.new(0.2, 0.2, 0.25)
		    ultContainer.Parent = container
		
		    local ultBar = Instance.new("Frame")
		    ultBar.Name = "UltBar"
		    ultBar.Size = UDim2.new(1, 0, 1, 0)
		    ultBar.BackgroundColor3 = Color3.fromRGB(255, 180, 20)
		    ultBar.BorderSizePixel = 0
		    ultBar.Parent = ultContainer
		
		    local tracerLine = nil
		    if hasDrawing then
		        tracerLine = Drawing.new("Line")
		        tracerLine.Visible = false
		        tracerLine.Thickness = 1.5
		        tracerLine.Color = ESP.ESPColor
		        tracerLine.Transparency = 1
		    end
		
		    local cache = {
		        lastNameText = "",
		        lastInfoText = "",
		        lastHealthPercent = -1,
		        lastUltPercent = -1,
		        lastHealthColor = nil,
		        lastScale = 0,
		        lastLayoutHash = -1,
		        lastHRPColor = nil,
		        lastHighlightColor = nil,
		        lastFillTrans = -1,
		        lastOutlineTrans = -1,
		        lastHeadPos = nil,
		        lastBillboardEnabled = nil,
		        lastHighlightEnabled = nil,
		        lastHRPBoxVisible = nil,
		        lastStudsOffset = nil,
		        lastDynamicMinW = -1,
		        maxHealth = humanoid.MaxHealth
		    }
		
		    local diedConn = humanoid.Died:Connect(function()
		        removeEsp(player)
		    end)
		
		    local destroyingConn = character.Destroying:Connect(function()
		        removeEsp(player)
		    end)
		
		    local maxHealthConn = humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
		        cache.maxHealth = humanoid.MaxHealth
		    end)
		
		    ESP_TABLE[player] = {
		        Player = player,
		        Character = character,
		        Humanoid = humanoid,
		        HRP = hrp,
		        Head = head,
		        Highlight = highlight,
		        HRPBox = hrpBox,
		        Billboard = billboard,
		        Container = container,
		        NameLabel = nameLabel,
		        InfoLabel = infoLabel,
		        HealthContainer = healthContainer,
		        HealthBar = healthBar,
		        UltContainer = ultContainer,
		        UltBar = ultBar,
		        TracerLine = tracerLine,
		        Cache = cache,
		        DiedConn = diedConn,
		        DestroyingConn = destroyingConn,
		        MaxHealthConn = maxHealthConn,
		    }
		end
		
		local function setupCharacterEsp(player, character)
		    if player == LocalPlayer then return end
		    if not ESP.Enabled then return end
		
		    cleanupPending(player)
		
		    local neededCount = 2
		    local foundCount = 0
		
		    if character:FindFirstChild("HumanoidRootPart") then foundCount = foundCount + 1 end
		    if character:FindFirstChildOfClass("Humanoid") then foundCount = foundCount + 1 end
		
		    if foundCount >= neededCount and ESP.Enabled and player.Parent then
		        pcall(function() createEsp(player) end)
		        return
		    end
		
		    local conn
		    conn = character.ChildAdded:Connect(function(child)
		        if not ESP.Enabled then
		            conn:Disconnect()
		            pendingEsp[player] = nil
		            return
		        end
		        if child.Name == "HumanoidRootPart" or child:IsA("Humanoid") then
		            foundCount = foundCount + 1
		            if foundCount >= neededCount then
		                conn:Disconnect()
		                pendingEsp[player] = nil
		                if ESP.Enabled and player.Parent then
		                    pcall(function() createEsp(player) end)
		                end
		            end
		        end
		    end)
		    pendingEsp[player] = conn
		
		    task.defer(function()
		        if not ESP.Enabled then return end
		        if not ESP_TABLE[player] and player.Parent and player.Character == character then
		            if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChildOfClass("Humanoid") then
		                pcall(function() createEsp(player) end)
		            end
		        end
		    end)
		end
		
		local function updateEsp(player, data)
		    if not ESP.Enabled then return end
		    if not player.Parent then
		        removeEsp(player)
		        return
		    end
		
		    local character = data.Character
		    if not character or not character.Parent then
		        if data.TracerLine then data.TracerLine.Visible = false end
		        removeEsp(player)
		        return
		    end
		
		    local humanoid = data.Humanoid
		    local hrp = data.HRP
		    if not humanoid or not humanoid.Parent or humanoid.Health <= 0 then
		        if data.TracerLine then data.TracerLine.Visible = false end
		        removeEsp(player)
		        return
		    end
		
		    local isSelected = isPlayerInList(ESP.SelectedPlayers, player.Name)
		    if ESP.OnlySelectedESP and not isSelected then
		        if data.TracerLine then data.TracerLine.Visible = false end
		        if data.Billboard then data.Billboard.Enabled = false end
		        if data.Highlight then data.Highlight.Enabled = false end
		        if data.HRPBox then data.HRPBox.Visible = false end
		        return
		    end
		
		    if not localHRP or not localHRP.Parent then
		        if data.TracerLine then data.TracerLine.Visible = false end
		        return
		    end
		
		    local camera = Workspace.CurrentCamera
		    if not camera or not camera.Parent then
		        if data.TracerLine then data.TracerLine.Visible = false end
		        return
		    end
		
		    local distance = (localHRP.Position - hrp.Position).Magnitude
		
		    local isEnemy = true
		    if ESP.TeamCheck then
		        local myTeam = LocalPlayer.Team
		        local theirTeam = player.Team
		        if myTeam and theirTeam then
		            isEnemy = myTeam ~= theirTeam
		        end
		    end
		
		    local shouldShow = isEnemy and (ESP.InfiniteDistance or distance <= ESP.MaxDistance)
		
		    if not shouldShow then
		        if data.Billboard and data.Billboard.Enabled then data.Billboard.Enabled = false end
		        if data.Highlight and data.Highlight.Enabled then data.Highlight.Enabled = false end
		        if data.HRPBox and data.HRPBox.Visible then data.HRPBox.Visible = false end
		        if data.TracerLine then data.TracerLine.Visible = false end
		        return
		    end
		
		    if ESP.Highlight and shouldShow then
		        if not data.Highlight or not data.Highlight.Parent then
		            pcall(function()
		                if data.Highlight then
		                    data.Highlight:Destroy()
		                end
		            end)
		            local newHighlight = Instance.new("Highlight")
		            newHighlight.Name = "CharHighlight"
		            newHighlight.FillTransparency = ESP.ESPTransparency
		            newHighlight.OutlineTransparency = ESP.HighlightTransparency
		            newHighlight.OutlineColor = ESP.HighlightColor
		            newHighlight.FillColor = ESP.HighlightColor
		            newHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		            newHighlight.Parent = character
		            data.Highlight = newHighlight
		            data.Cache.lastHighlightColor = nil
		            data.Cache.lastFillTrans = -1
		            data.Cache.lastOutlineTrans = -1
		            data.Cache.lastHighlightEnabled = nil
		        end
		    end
		
		    if ESP.Tracker and data.TracerLine then
		        local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
		        if onScreen then
		            data.TracerLine.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
		            data.TracerLine.To = Vector2.new(screenPos.X, screenPos.Y)
		            data.TracerLine.Color = ESP.ESPColor
		            data.TracerLine.Visible = true
		        else
		            data.TracerLine.Visible = false
		        end
		    elseif data.TracerLine then
		        data.TracerLine.Visible = false
		    end
		
		    local currentHead = character:FindFirstChild("Head")
		    if currentHead then
		        if data.Cache.lastHeadPos ~= currentHead then
		            data.Billboard.Adornee = currentHead
		            data.Head = currentHead
		            data.Cache.lastHeadPos = currentHead
		        end
		        if data.Cache.lastStudsOffset ~= Vector3.new(0, 2.5, 0) then
		            data.Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
		            data.Cache.lastStudsOffset = Vector3.new(0, 2.5, 0)
		        end
		    else
		        if data.Cache.lastHeadPos ~= nil then
		            data.Billboard.Adornee = hrp
		            data.Head = nil
		            data.Cache.lastHeadPos = nil
		        end
		        if data.Cache.lastStudsOffset ~= Vector3.new(0, 4, 0) then
		            data.Billboard.StudsOffset = Vector3.new(0, 4, 0)
		            data.Cache.lastStudsOffset = Vector3.new(0, 4, 0)
		        end
		    end
		
		    local nameStr = ""
		    if ESP.Name then
		        nameStr = (player.DisplayName or player.Name) .. " (" .. player.Name .. ")"
		    end
		
		    local infoParts = {}
		    if ESP.Distance then
		        table.insert(infoParts, math.floor(distance) .. "m")
		    end
		    if ESP.Ping then
		        local ping = player:GetAttribute("Ping")
		        if ping ~= nil then
		            table.insert(infoParts, math.floor(tonumber(ping) or 0) .. "ms")
		        end
		    end
		    if ESP.KillStreak then
		        local streak = 0
		        pcall(function()
		            local live = Workspace:FindFirstChild("Live")
		            if live then
		                local model = live:FindFirstChild(player.Name)
		                if model then streak = model:GetAttribute("CurrentStreak") or 0 end
		            end
		        end)
		        if streak > 0 then
		            table.insert(infoParts, streak .. " strk")
		        end
		    end
		    if ESP.Device then
		        local device = "PC"
		        pcall(function()
		            if player:GetAttribute("Mobile") then device = "Mobile"
		            elseif player:GetAttribute("Xbox") then device = "Xbox"
		            elseif player:GetAttribute("VR") then device = "VR"
		            elseif player:GetAttribute("Console") then device = "Console" end
		        end)
		        table.insert(infoParts, device)
		    end
		    if ESP.TotalKills then
		        local leaderstats = player:FindFirstChild("leaderstats")
		        if leaderstats then
		            local tk = leaderstats:FindFirstChild("Total Kills")
		            if tk then
		                table.insert(infoParts, tk.Value .. " Kills")
		            end
		        end
		    end
		    local infoStr = table.concat(infoParts, " | ")
		
		    if ESP.Name and data.NameLabel and data.Cache.lastNameText ~= nameStr then
		        data.NameLabel.Text = nameStr
		        data.Cache.lastNameText = nameStr
		    end
		    if data.InfoLabel and data.Cache.lastInfoText ~= infoStr then
		        data.InfoLabel.Text = infoStr
		        data.Cache.lastInfoText = infoStr
		    end
		
		    local nameW = 0
		    local infoW = 0
		    if ESP.Name and nameStr ~= "" then
		        local size = Vector2.new(0, 10)
		        nameW = TextService:GetTextSize(nameStr, 10, Enum.Font.GothamBold, size).X
		    end
		    if infoStr ~= "" then
		        infoW = TextService:GetTextSize(infoStr, 8, Enum.Font.GothamBold, Vector2.new(0, 8)).X
		    end
		    local textWidth = math.max(nameW, infoW)
		    local dynamicMinW = math.max(60, math.ceil(textWidth * 0.55))
		
		    local hash = 0
		    if ESP.Name then hash = hash + 1 end
		    if ESP.Distance then hash = hash + 2 end
		    if ESP.Ping then hash = hash + 4 end
		    if ESP.KillStreak then hash = hash + 8 end
		    if ESP.Health then hash = hash + 16 end
		    if ESP.UltBar then hash = hash + 32 end
		    if ESP.TotalKills then hash = hash + 64 end
		    if ESP.Device then hash = hash + 128 end
		
		    local bbEnabled = hash > 0
		    if data.Cache.lastBillboardEnabled ~= bbEnabled then
		        data.Billboard.Enabled = bbEnabled
		        data.Cache.lastBillboardEnabled = bbEnabled
		    end
		    if data.Cache.lastHighlightEnabled ~= ESP.Highlight then
		        data.Highlight.Enabled = ESP.Highlight
		        data.Cache.lastHighlightEnabled = ESP.Highlight
		    end
		    if data.Cache.lastHRPBoxVisible ~= ESP.HumanoidRootPart then
		        data.HRPBox.Visible = ESP.HumanoidRootPart
		        data.Cache.lastHRPBoxVisible = ESP.HumanoidRootPart
		    end
		
		    local scale = math.clamp(1 - (distance / 2000), 0.4, 1)
		
		    if hash ~= data.Cache.lastLayoutHash or math.abs(scale - data.Cache.lastScale) >= 0.01 or dynamicMinW ~= data.Cache.lastDynamicMinW then
		        data.Cache.lastLayoutHash = hash
		        data.Cache.lastScale = scale
		        data.Cache.lastDynamicMinW = dynamicMinW
		
		        local pad = 2
		        local rowH = 12
		        local barH = 8
		        local gap = 1
		        local hasInfo = ESP.Distance or ESP.Ping or ESP.KillStreak or ESP.TotalKills or ESP.Device
		        local hasBars = ESP.Health or ESP.UltBar
		        local hasName = ESP.Name
		
		        local totalH = pad
		        if hasName then totalH = totalH + rowH + gap end
		        if hasInfo then totalH = totalH + 10 + gap end
		        if hasBars then totalH = totalH + barH + gap end
		        totalH = totalH + pad
		
		        local minW = dynamicMinW
		        if hasBars then minW = math.max(minW, 80) end
		
		        local baseW = minW
		        local baseH = math.max(totalH, 20)
		
		        data.Billboard.Size = UDim2.new(0, math.floor(baseW * scale), 0, math.floor(baseH * scale))
		
		        local y = pad
		
		        if hasName then
		            data.NameLabel.Visible = true
		            data.NameLabel.Size = UDim2.new(1, -pad*2, 0, math.floor(rowH * scale))
		            data.NameLabel.Position = UDim2.new(0, pad, 0, y)
		            data.NameLabel.TextSize = math.max(7, math.floor(10 * scale))
		            y = y + math.floor(rowH * scale) + gap
		        else
		            data.NameLabel.Visible = false
		        end
		
		        if hasInfo then
		            data.InfoLabel.Visible = true
		            data.InfoLabel.Size = UDim2.new(1, -pad*2, 0, math.floor(10 * scale))
		            data.InfoLabel.Position = UDim2.new(0, pad, 0, y)
		            data.InfoLabel.TextSize = math.max(7, math.floor(8 * scale))
		            y = y + math.floor(10 * scale) + gap
		        else
		            data.InfoLabel.Visible = false
		        end
		
		        if hasBars then
		            local barScaleH = math.max(4, math.floor(barH * scale))
		            local bothBars = ESP.Health and ESP.UltBar
		            if ESP.Health then
		                data.HealthContainer.Visible = true
		                data.HealthContainer.Size = UDim2.new(bothBars and 0.47 or 0.96, 0, 0, barScaleH)
		                data.HealthContainer.Position = UDim2.new(0.02, 0, 0, y)
		            else
		                data.HealthContainer.Visible = false
		            end
		            if ESP.UltBar then
		                data.UltContainer.Visible = true
		                data.UltContainer.Size = UDim2.new(bothBars and 0.47 or 0.96, 0, 0, barScaleH)
		                data.UltContainer.Position = UDim2.new(bothBars and 0.51 or 0.02, 0, 0, y)
		            else
		                data.UltContainer.Visible = false
		            end
		        else
		            data.HealthContainer.Visible = false
		            data.UltContainer.Visible = false
		        end
		    end
		
		    if data.Cache.lastHRPColor ~= ESP.ESPColor then
		        if data.HRPBox then
		            data.HRPBox.Color3 = ESP.ESPColor
		        end
		        if data.Container then
		            data.Container.BorderColor3 = ESP.ESPColor
		        end
		        data.Cache.lastHRPColor = ESP.ESPColor
		    end
		
		    if data.Highlight and data.Cache.lastHighlightColor ~= ESP.HighlightColor then
		        data.Highlight.OutlineColor = ESP.HighlightColor
		        data.Highlight.FillColor = ESP.HighlightColor
		        data.Cache.lastHighlightColor = ESP.HighlightColor
		    end
		
		    if data.Highlight and data.Cache.lastFillTrans ~= ESP.ESPTransparency then
		        data.Highlight.FillTransparency = ESP.ESPTransparency
		        data.Cache.lastFillTrans = ESP.ESPTransparency
		    end
		
		    if data.Highlight and data.Cache.lastOutlineTrans ~= ESP.HighlightTransparency then
		        data.Highlight.OutlineTransparency = ESP.HighlightTransparency
		        data.Cache.lastOutlineTrans = ESP.HighlightTransparency
		    end
		
		    if ESP.Health and humanoid.Health > 0 and data.HealthBar then
		        local hp = humanoid.Health
		        local max = data.Cache.maxHealth
		        local pct = math.clamp(hp / max, 0, 1)
		        if math.abs(data.Cache.lastHealthPercent - pct) > 0.001 then
		            data.HealthBar.Size = UDim2.new(pct, 0, 1, 0)
		            data.Cache.lastHealthPercent = pct
		        end
		        local hpColor = Color3.fromHSV(pct * 0.33, 1, 1)
		        if data.Cache.lastHealthColor ~= hpColor then
		            data.HealthBar.BackgroundColor3 = hpColor
		            data.Cache.lastHealthColor = hpColor
		        end
		    end
		
		    if ESP.UltBar and data.UltBar then
		        local ultVal = player:GetAttribute("Ultimate")
		        if ultVal ~= nil then
		            local pct = math.clamp(tonumber(ultVal) / 100, 0, 1)
		            if math.abs(data.Cache.lastUltPercent - pct) > 0.001 then
		                data.UltBar.Size = UDim2.new(pct, 0, 1, 0)
		                data.Cache.lastUltPercent = pct
		            end
		        end
		    end
		end
		
		local function startMainRenderLoop()
		    if mainRenderConnection then return end
		    mainRenderConnection = RunService.RenderStepped:Connect(function()
		        if not ESP.Enabled then return end
		        for player, data in pairs(ESP_TABLE) do
		            if data and player.Parent then
		                pcall(function()
		                    updateEsp(player, data)
		                end)
		            end
		        end
		    end)
		    table.insert(activeConnections, mainRenderConnection)
		end
		
		local function stopMainRenderLoop()
		    if mainRenderConnection then
		        pcall(function() mainRenderConnection:Disconnect() end)
		        mainRenderConnection = nil
		    end
		end
		
		local function checkDeathCounterPlayers()
		    for player, data in pairs(ESP_TABLE) do
		        if data then
		            local character = data.Character
		            if not character or not character.Parent then
		                local obj = deathCounterObjects[player]
		                if obj then
		                    safeDestroy(obj)
		                    deathCounterObjects[player] = nil
		                end
		            else
		                local existing = deathCounterObjects[player]
		                if existing and (not existing.Parent or not existing.Adornee or not existing.Adornee.Parent) then
		                    safeDestroy(existing)
		                    deathCounterObjects[player] = nil
		                    existing = nil
		                end
		
		                if character:FindFirstChild("Counter") then
		                    local head = character:FindFirstChild("Head")
		                    if not existing and head then
		                        local billboard = Instance.new("BillboardGui")
		                        billboard.Name = "DeathCounterESP"
		                        billboard.Size = UDim2.new(6, 0, 6, 0)
		                        billboard.Adornee = head
		                        billboard.AlwaysOnTop = true
		                        billboard.StudsOffset = Vector3.new(0, 3.5, 0)
		                        billboard.Parent = head
		
		                        local skullLabel = Instance.new("TextLabel")
		                        skullLabel.Name = "SkullLabel"
		                        skullLabel.Size = UDim2.new(1, 0, 1, 0)
		                        skullLabel.BackgroundTransparency = 1
		                        skullLabel.Text = "\240\159\146\128"
		                        skullLabel.TextScaled = true
		                        skullLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		                        skullLabel.Font = Enum.Font.FredokaOne
		                        skullLabel.Parent = billboard
		
		                        deathCounterObjects[player] = billboard
		                    elseif existing and head and existing.Adornee ~= head then
		                        existing.Adornee = head
		                        existing.Parent = head
		                    end
		                elseif existing then
		                    safeDestroy(existing)
		                    deathCounterObjects[player] = nil
		                end
		            end
		        end
		    end
		end
		
		local function deathCounterLoop()
		    deathCounterActive = true
		    while deathCounterActive and ESP.Enabled and ESP.DeathCounter do
		        checkDeathCounterPlayers()
		        task.wait(1)
		    end
		    deathCounterActive = false
		end
		
		local function startDeathCounterLoop()
		    if deathCounterActive then return end
		    task.spawn(deathCounterLoop)
		end
		
		local function stopDeathCounterLoop()
		    deathCounterActive = false
		    cleanupDeathCounter()
		end
		
		local function onPlayerCharacterAdded(player)
		    if player == LocalPlayer then return end
		    if not ESP.Enabled then return end
		    disconnectPlayerCharConn(player)
		
		    local charConn = player.CharacterAdded:Connect(function(character)
		        if not ESP.Enabled then return end
		        removeEsp(player)
		        setupCharacterEsp(player, character)
		    end)
		    playerCharConns[player] = charConn
		end
		
		local function onPlayerAdded(player)
		    if player == LocalPlayer then return end
		    if not ESP.Enabled then return end
		    if player.Character then
		        setupCharacterEsp(player, player.Character)
		    end
		    onPlayerCharacterAdded(player)
		end
		
		local function onPlayerRemoving(player)
		    removeEsp(player)
		    if deathCounterObjects[player] then
		        safeDestroy(deathCounterObjects[player])
		        deathCounterObjects[player] = nil
		    end
		    disconnectPlayerCharConn(player)
		
		    if selectedDropdown and selectedDropdown.Set then
		        local newList = {}
		        for _, name in ipairs(ESP.SelectedPlayers) do
		            if name ~= player.Name then
		                table.insert(newList, name)
		            end
		        end
		        for k, v in pairs(ESP.SelectedPlayers) do
		            if type(v) == "boolean" and v == true and k ~= player.Name and not table.find(newList, k) then
		                table.insert(newList, k)
		            end
		        end
		        selectedDropdown:Set(newList)
		    end
		end
		
		local function enableEspSystem()
		    if ESP.Enabled then return end
		    ESP.Enabled = true
		
		    if LocalPlayer.Character then
		        setupLocalPlayerCharacter(LocalPlayer.Character)
		    end
		    local charAddedConn = LocalPlayer.CharacterAdded:Connect(setupLocalPlayerCharacter)
		    table.insert(activeConnections, charAddedConn)
		
		    table.insert(activeConnections, Players.PlayerAdded:Connect(onPlayerAdded))
		    table.insert(activeConnections, Players.PlayerRemoving:Connect(onPlayerRemoving))
		
		    table.insert(activeConnections, LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
		        if not LocalPlayer.Parent then
		            disableEspSystem()
		        end
		    end))
		
		    for _, plr in ipairs(Players:GetPlayers()) do
		        if plr ~= LocalPlayer then
		            if plr.Character then
		                setupCharacterEsp(plr, plr.Character)
		            end
		            onPlayerCharacterAdded(plr)
		        end
		    end
		
		    startMainRenderLoop()
		    if ESP.DeathCounter then
		        startDeathCounterLoop()
		    end
		end
		
		local function disableEspSystem()
		    ESP.Enabled = false
		    stopMainRenderLoop()
		    cleanupAllEsp()
		    cleanupDeathCounter()
		
		    for _, conn in ipairs(activeConnections) do
		        pcall(function() conn:Disconnect() end)
		    end
		    activeConnections = {}
		
		    for player, conn in pairs(playerCharConns) do
		        pcall(function() conn:Disconnect() end)
		    end
		    playerCharConns = {}
		
		    for player, conn in pairs(pendingEsp) do
		        pcall(function() conn:Disconnect() end)
		    end
		    pendingEsp = {}
		
		    stopDeathCounterLoop()
		    localHRP = nil
		
		    if localPlayerDiedConn then
		        pcall(function() localPlayerDiedConn:Disconnect() end)
		        localPlayerDiedConn = nil
		    end
		end
		
		if not hasDrawing then
		    pcall(function()
		        StarterGui:SetCore("SendNotification", {
		            Title = "VexonHub",
		            Text = "Drawing API not supported on this executor. Tracer lines will be disabled.",
		            Duration = 8
		        })
		    end)
		end
		
		local espSection = Tabs.ESP:Section({ Title = "ESPs", Desc = "Toggle ESP features", Icon = "eye", Opened = true, Box = true, BoxBorder = true })
		
		espSection:Toggle({
		    Title = "Enable ESP",
		    Type = "Toggle",
		    Value = false,
		    Callback = function(state)
		        if state then
		            enableEspSystem()
		        else
		            disableEspSystem()
		        end
		    end
		})
		
		espSection:Divider({})
		
		espSection:Toggle({Title = "HumanoidRootPart", Type = "Checkbox", Value = true, Callback = function(state) ESP.HumanoidRootPart = state end})
		espSection:Toggle({Title = "Highlight", Type = "Checkbox", Value = true, Callback = function(state) ESP.Highlight = state end})
		espSection:Toggle({Title = "Tracker (Tracer Line)", Type = "Checkbox", Value = true, Callback = function(state) ESP.Tracker = state end})
		espSection:Toggle({Title = "Kill Streak", Type = "Checkbox", Value = true, Callback = function(state) ESP.KillStreak = state end})
		espSection:Toggle({Title = "Kills", Type = "Checkbox", Value = true, Callback = function(state) ESP.TotalKills = state end})
		espSection:Toggle({Title = "Ping", Type = "Checkbox", Value = true, Callback = function(state) ESP.Ping = state end})
		espSection:Toggle({Title = "Ult Bar", Type = "Checkbox", Value = true, Callback = function(state) ESP.UltBar = state end})
		espSection:Toggle({Title = "Name", Type = "Checkbox", Value = true, Callback = function(state) ESP.Name = state end})
		espSection:Toggle({Title = "Health", Type = "Checkbox", Value = true, Callback = function(state) ESP.Health = state end})
		espSection:Toggle({Title = "Device", Type = "Checkbox", Value = true, Callback = function(state) ESP.Device = state end})
		espSection:Toggle({Title = "Team Check", Type = "Checkbox", Value = false, Callback = function(state) ESP.TeamCheck = state end})
		espSection:Toggle({Title = "Distance", Type = "Checkbox", Value = true, Callback = function(state) ESP.Distance = state end})
		espSection:Toggle({
		    Title = "Death Counter ESP",
		    Type = "Toggle",
		    Value = false,
		    Callback = function(state)
		        ESP.DeathCounter = state
		        if state and ESP.Enabled then
		            startDeathCounterLoop()
		        elseif not state then
		            stopDeathCounterLoop()
		            cleanupDeathCounter()
		        end
		    end
		})
		
		local SettingsSection = Tabs.ESP:Section({ Title = "Esp settings", Desc = "Manage selected players", Icon = "filter", Opened = true, Box = true, BoxBorder = true })
		
		SettingsSection:Colorpicker({Title = "ESP Color", Default = Color3.fromRGB(255, 70, 70), Transparency = 0, Callback = function(color) ESP.ESPColor = color end})
		SettingsSection:Colorpicker({Title = "Highlight Color", Default = Color3.fromRGB(255, 70, 70), Transparency = 0, Callback = function(color) ESP.HighlightColor = color end})
		SettingsSection:Slider({Title = "ESP Transparency", Value = {Min = 0, Max = 100, Default = 30}, Step = 5, IsTooltip = true, Callback = function(value) ESP.ESPTransparency = value / 100 end})
		SettingsSection:Slider({Title = "Highlight Transparency", Value = {Min = 0, Max = 100, Default = 0}, Step = 5, IsTooltip = true, Callback = function(value) ESP.HighlightTransparency = value / 100 end})
		SettingsSection:Slider({Title = "Max Distance", Value = {Min = 50, Max = 1000, Default = 500}, Step = 50, IsTooltip = true, Callback = function(value) ESP.MaxDistance = value end})
		SettingsSection:Toggle({Title = "Infinite Distance", Type = "Toggle", Value = false, Icon = "infinity", Callback = function(state) ESP.InfiniteDistance = state end})
		
		SettingsSection:Divider({})
		
		SettingsSection:Toggle({
		   Title = "Selected Players Only",
		   Value = false,
		   Flag = "only_selected_esp",
		   Callback = function(value)
		       ESP.OnlySelectedESP = value
		   end
		})
		
		selectedDropdown = SettingsSection:Dropdown({
		   Title = "Selected ESP Targets",
		   Flag = "selected_targets",
		   Multi = true,
		   Values = {},
		   Value = {},
		   Callback = function(value)
		       ESP.SelectedPlayers = value
		   end
		})
		
		SettingsSection:Button({
		   Title = "Refresh Player List",
		   Icon = "refresh-cw",
		   Callback = function()
		       local all = {}
		       for _, p in ipairs(Players:GetPlayers()) do
		           if p ~= LocalPlayer then
		               table.insert(all, p.Name)
		           end
		       end
		       if selectedDropdown and selectedDropdown.Refresh then
		           selectedDropdown:Refresh(all)
		       end
		   end
		})
	end)
end
















-- ================ MOVESET0 TAB0 ================ --
function MovesetTab()
	task.spawn(function()
		CharMoveSets = Tabs.Moveset:Section({Opened = true, Box = true, BoxBorder = true, Title = "Characther Movesets", Icon = "box" })
		
		CharMoveSets:Button({
		    Title = "The Garbage Ghost (Universal)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/TheGarbageGhost"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Trash-Can Man (Universal)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man",true))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "StarGlicher (Universal)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/SG_DEMO.lua"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "JK (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-JK-Moveset-24889"))()
		    end
		})
		CharMoveSets:Button({
		    Title = "Kenjihin (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Tp%20exploit%20saitama%20to%20jun"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Gojo 1 (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nova2ezz/jjs-gojo-/refs/heads/main/SaitamaToGojoV3_SOURCE-obfuscated_2.txt"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Gojo 2 (Saitama)",
		    Locked = false,
		    Callback = function()
		        getgenv().morph = true
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Gojo 3 (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://pastebin.com/raw/3Cz8kF8M",true))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Mahito (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/dendendenver1/mahitotsbthing/refs/heads/main/main.lua"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Yuji/Sukuna (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://pastebin.com/raw/1yaXL0rA"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Ichigo Kurosaki (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/grest0n/CustomMovesets/refs/heads/main/Ichigo%20Kurosaki"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "JJS Gojo (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://gist.githubusercontent.com/JcBoomin/a63e9ac3e90cef03ecf37e997fd21632/raw/98b567b81f61bb30042e0078b78f3fb24685fb8d/Gojo",true))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Hakari (Saitama)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/dendendenver1/HakariTSB/refs/heads/main/HakariTSB.lua"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Arcaura (Garou)",
		    Locked = false,
		    Callback = function()
		        getgenv().OptimizeUltimate = false
		        getgenv().ReduceUltFlash = true
		        getgenv().Move1Insta = false
		        getgenv().LowQualityMode = true
		        getgenv().BetaConsole = true
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/ARCAURA.lua"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "KJ (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/KJ-The-Strongest-Battlegrounds-Garou-to-kj-27085"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Chainsaw Man (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://gist.githubusercontent.com/GoldenHeads2/0fd8d36993c850f3fac89e5adf793076/raw/ab4f5a42bd0b2e24a32a46301d533ea849ca771c/gistfile1.txt"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Okarun (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-Garou-to-OKARUN-24065"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Sukuna (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-Garou-to-Sukuna-24081"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Gojo (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://pastebin.com/raw/3Cz8kF8M",true))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Cyber Psycho (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://pastebin.com/raw/7V1mUBtQ"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Suriyu (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/he-Strongest-Battlegrounds-Garou-to-Suiryu-script-18098"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Goku V2 (Garou)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-Goku-Moveset-V2-17977"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Minos Prime (Garou)",
		    Locked = false,
		    Callback = function()
		        _G.SkipIntro = true
		        _G.Night = false
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/S1gmaGuy/MinosPrimeFixed/refs/heads/main/ThefixIsSoSigma"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Toji (Atomic Samurai)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-Toji-moveset-for-Atomic-Samurai-22498"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Toji 2 (Atomic Samurai)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://paste.ee/r/0uIxM"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Sukuna (Atomic Samurai)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://pastebin.com/raw/gUrBYsGK"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Toji (Sonic)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-Toji-moveset-21449"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "Voltra (Sonic)",
		    Locked = false,
		    Callback = function()
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/VOLTA.lua"))()
		    end
		})
		
		CharMoveSets:Button({
		    Title = "APOPHENIA (Metal Bat)",
		    Locked = false,
		    Callback = function()
		        getgenv().Music = false
		        getgenv().AttackQuality = 'High'
		        getgenv().ConstantSpeed = false
		        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/main/APOPHENIA.lua"))()
		    end
		})
	end)
end















-- ================ ANTIBAN0 TAB0 ================ --
function AntiBanTab()
	task.spawn(function()
		Vars = {
		    AnticheatConn = nil
		}
		
		Options = {
		    AvoidBanMethod = { Value = "Kick" },
		    RejoinDelay = { Value = "3" }
		}
		
		function Rejoin(delayTime)
		    task.wait(delayTime or 3)
		    if #Players:GetPlayers() <= 1 then
		        Players.LocalPlayer:Kick("Rejoining...")
		        task.wait()
		        TeleportService:Teleport(game.PlaceId, LocalPlayer)
		    else
		        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		    end
		end
		
		function HandleSafetyAction(reason)
		    Notify("Anticheat Flagged", reason)
		    local method = Options.AvoidBanMethod.Value
		    
		    if method == "Auto Leave" or method == "Kick" then
		        LocalPlayer:Kick("[Anticheat] Safety Kick: " .. reason)
		    elseif method == "Auto Rejoin" then
		        Rejoin(tonumber(Options.RejoinDelay.Value))
		    elseif method == "Warn" then
		        warn("[Anticheat] Flagged: " .. reason)
		    end
		end
		
		AntibanSex = Tabs.AntiBan:Section({Opened = true, Box = true, BoxBorder = true, Title = "Antiban ", Icon = "shield-alert" })
		
		AntibanSex:Dropdown({
		    Title = "Safety Action ",
		    Flag = "tsbsafelyactionantiban",
		    Values = {"None", "Warn", "Auto Leave", "Auto Rejoin", "Kick"},
		    Value = "Kick",
		    Locked = LockedStatus,
		    LockedTitle = "Premium",
		    Callback = function(val)
		        Options.AvoidBanMethod.Value = val
		    end
		})
		
		
		AntibanSex:Input({
		    Title = "Rejoin Delay ",
		    Flag = "tsbrejoindaleyantiban",
		    Locked = LockedStatus,
		    LockedTitle = "Premium",
		    Value = "3",
		    Numeric = true,
		    Finished = true,
		    Callback = function(val)
		        Options.RejoinDelay.Value = val
		    end
		})
		
		
		AntibanSex:Toggle({
		    Title = "Enable Antiban Detector ",
		    Flag = "tsbantibanmaintoggle",
		    Locked = LockedStatus,
		    LockedTitle = "Premium",
		    Value = false,
		    Callback = function(value)
		        if value then
		            if not Vars.AnticheatConn then
		                local rep = ReplicatedStorage:FindFirstChild("Replication")
		                if rep then
		                    Vars.AnticheatConn = rep.OnClientEvent:Connect(function(...)
		                        local args = {...}
		                        local data = args[1]
		                        
		                        if type(data) == "table" then
		                            local effect = rawget(data, "Effect")
		                            if effect and tostring(effect):lower() == "hicheck" then
		                                HandleSafetyAction("A1 (Report/HiCheck)")
		                            end
		                        end
		                    end)
		                else
		                end
		            end
		        else
		            if Vars.AnticheatConn then
		                Vars.AnticheatConn:Disconnect()
		                Vars.AnticheatConn = nil
		            end
		        end
		    end
		})
		
		
		
		Antistaff = Tabs.AntiBan:Section({Opened = true, Box = true, BoxBorder = true, Title = "Anti Staff", Icon = "shield" })
		
		Players = game:GetService("Players")
		ReplicatedStorage = game:GetService("ReplicatedStorage")
		LocalPlayer = Players.LocalPlayer
		
		TargetGroupId = 12013007
		BlacklistedUserIds = {
		    422755031,198131804,681405668,3414432341,339633571,430966809,2039323684,
		    117723419,1015595932,263944298,112905203,2284964418,1266437961,3120648134,
		    1148139861,1633233654,3350014406,971193650,661273560,66105529,77342385,
		    167343092,2055306963,141984224,438917845,1391134999,1796550069,255671730,
		    3162123826,1059541187,1259898795,31070091,1041867508,994994173,1446694201,
		    77525605,1001242712,2533866869,4983064295
		}
		
		activeChecks = {
		    Moderators = true,
		    Contributor = true,
		    Developer = true,
		    Owner = true,
		    Other= true
		}
		
		isEnabled = false
		connection = nil
		
		function KickForStaffPresence(reason)
		    LocalPlayer:Kick("Staff: " .. reason)
		end
		
		function CheckPlayer(targetPlayer)
		    if targetPlayer == LocalPlayer or not isEnabled then return end
		
		    task.spawn(function()
		        if targetPlayer:IsInGroup(TargetGroupId) then
		            role = targetPlayer:GetRoleInGroup(TargetGroupId)
		            if activeChecks["Moderators"] and role:find("Moderator") then KickForStaffPresence("Mod") end
		            if activeChecks["Contributor"] and role:find("Contributor") then KickForStaffPresence("Contrib") end
		            if activeChecks["Developer"] and role:find("Developer") then KickForStaffPresence("Dev") end
		            if activeChecks["Owner"] and role:find("Owner") then KickForStaffPresence("Owner") end
		        end
		
		        if activeChecks["Others..."] then
		            for _, userId in ipairs(BlacklistedUserIds) do
		                if targetPlayer.UserId == userId then KickForStaffPresence("ID " .. userId) end
		                if targetPlayer:IsFriendsWith(userId) then KickForStaffPresence("Friend " .. userId) end
		            end
		        end
		    end)
		end
		
		
		Antistaff:Dropdown({
		    Title = "Target Roles",
		    Flag = "tsbtargetrolesantistaff",
		    Multi = true,
		    Values = {"Moderators", "Contributor", "Developer", "Owner", "Other"},
		    Options = {"Moderators", "Contributor", "Developer", "Owner", "Other"},
		    Callback = function(selected)
		        for k in pairs(activeChecks) do
		            activeChecks[k] = false
		        end
		        for _, option in ipairs(selected) do
		            activeChecks[option] = true
		        end
		    end
		})
		
		Antistaff:Toggle({
		    Title = "Enable Detection",
		    Flag = "tsbantistaffmaintoggle",
		    Value = false,
		    Callback = function(state)
		        isEnabled = state
		        if isEnabled then
		            for _, player in ipairs(Players:GetPlayers()) do
		                CheckPlayer(player)
		            end
		            connection = Players.PlayerAdded:Connect(CheckPlayer)
		        else
		            if connection then
		                connection:Disconnect()
		                connection = nil
		            end
		        end
		    end
		})
		
		if ReplicatedStorage:FindFirstChild("Replication") then
		    ReplicatedStorage.Replication.OnClientEvent:Connect(function(data)
		        if isEnabled and data and data.Effect and data.Effect:lower() == "hicheck" then
		            LocalPlayer:Kick("A1 detected")
		        end
		    end)
		end
	end)
end











-- ================ TOOLS0 TAB0 ================ --
function ToolsTab()
	task.spawn(function()
		ToolsSec = Tabs.Tools:Section({Opened = true, Box = true, BoxBorder = true, Title = "Tools", Icon = "eye" })
		
		local location = nil
		function createTeleportTool(toolName, teleportPosition)
		
		    local originalPosition = nil
		    local tool = Instance.new("Tool")
		    tool.Name = toolName
		    tool.RequiresHandle = false
		    tool.Parent = plr.Backpack
		    tool.Equipped:Connect(function()
		        originalPosition = plr.Character.HumanoidRootPart.Position
		        plr.Character:SetPrimaryPartCFrame(CFrame.new(teleportPosition))
		    end)
		    tool.Unequipped:Connect(function()
		        if originalPosition then
		            plr.Character:SetPrimaryPartCFrame(CFrame.new(originalPosition))
		        end
		    end)
		end
		
		local locations = {
		        Map = {name = "Map Tool", position = Vector3.new(150, 440, 30)},
		        SafeZone1 = {name = "SafeZone1 Tool", position = Vector3.new(150, 505, 30)},
		        SafeZone2 = {name = "SafeZone2 Tool", position = Vector3.new(150, 705, 30)},
		        Pixel = {name = "Pixel Tool", position = Vector3.new(30000000, 30000000, 30000000)},
		        Void = {name = "Void Tool", position = Vector3.new(150, -495, 30)},
		        DarkNess = {name = "DarkNess Tool", position = Vector3.new(0 ,900000000002 ,0)},
		        Montain = {name = "Mountain Tool", position = Vector3.new(155.577, 628.742, -447.938)},
		        Counter = {name = "Counter Tool", position = Vector3.new(-68, 29, 20346)},
		        ["Counter Up"] = {name = "CounterUp Tool", position = Vector3.new(-68, 84, 20354)},
		        ["Atomic Base"] = {name = "AtomicBase Tool", position = Vector3.new(1063, 30, 23006)},
		        ["Atomic Base Up"] = {name = "AtomicBaseUp Tool", position = Vector3.new(1063, 405, 23006)},
		        ["Atomic Slash"] = {name = "AtomicSlash Tool", position = Vector3.new(1063, 131, 23006)},
		        Prison = {name = "Prison Tool", position = Vector3.new(438, 439, -376)},
		    }
		
		ToolsSec:Dropdown({
		    Title = "Place Tools",
		    Desc = "What Place Tool Do You Want?",
		    Values = {"Map", "SafeZone1", "SafeZone2", "Pixel", "Void", "DarkNess", "Montain", "Counter", "Counter Up", "Atomic Base", "Atomic Base Up", "Atomic Slash", "Prison"},
		    Multi = false,
		    AllowNone = false,
		    Callback = function(selectedText)
		    location = locations[selectedText]
		end
		})
		
		ToolsSec:Button({
		    Title = "Get Tool",
		    Locked = false,
		    Callback = function()
			if location then
		        createTeleportTool(location.name, location.position)
		    end
		end
		})
		
		ToolsSec:Divider()
		
		ToolsSec:Button({
		    Title = "TrashCan Tool",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/ffnvee4X/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "Fake 20-20-20 Dropkick",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/Ja7L18CD/raw"))()
		end
		})
		
		ToolsSec:Button({
		    Title = "Super Dash",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/6oteIFSE/raw"))()
		end
		})
		
		ToolsSec:Button({
		    Title = "Dodge",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/XB1ykQuc/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "TP Tool (Anim)",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/yEwya3MR/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "TP Tool (Normal)",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/ZLpXLAeF/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "Run Tool",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/6DahLoA3/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "Super Run Tool",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/uN8jb9GF/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "Jerk Of Tool",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/LcC6ZrhN/raw"))()
		end
		})
		ToolsSec:Button({
		    Title = "Invis Block Tool (Buggy)",
		    Locked = false,
		    Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/sl5RToWq/raw"))()
		end
		})
	end)
end














-- ================ Block0 TAB0 ================ --
function BlockTab()
	task.spawn(function()
		if getgenv().AutoBlockCounterBestLoaded then return end
		getgenv().AutoBlockCounterBestLoaded = true
		
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local UserInputService = game:GetService("UserInputService")
		local VirtualInputManager = game:GetService("VirtualInputManager")
		local Replicated = game:GetService("ReplicatedStorage")
		
		local player = Players.LocalPlayer
		if not player then return end
		
		getgenv().AutoBlocking = getgenv().AutoBlocking or false
		getgenv().AutoCounter = getgenv().AutoCounter or false
		getgenv().AutoBlockDist = getgenv().AutoBlockDist or "19.5"
		getgenv().AutoCounterDist = getgenv().AutoCounterDist or "19.5"
		getgenv().UseDeathMoves = getgenv().UseDeathMoves ~= nil and getgenv().UseDeathMoves or true
		getgenv().SoundParry = getgenv().SoundParry ~= nil and getgenv().SoundParry or true
		getgenv().AimbotWhileBlocking = getgenv().AimbotWhileBlocking ~= nil and getgenv().AimbotWhileBlocking or true
		getgenv().AutoM1AfterBlock = getgenv().AutoM1AfterBlock or false
		getgenv().M1Interval = getgenv().M1Interval or 0.2
		getgenv().M1Count = getgenv().M1Count or 1
		getgenv().BlockReleaseDelay = getgenv().BlockReleaseDelay or 0.6
		getgenv().FollowSpeed = getgenv().FollowSpeed or 700
		getgenv().FollowBehind = getgenv().FollowBehind or 4.4
		getgenv().FollowAnimInterval = getgenv().FollowAnimInterval or 0.2
		getgenv().BatterUltSafeState = getgenv().BatterUltSafeState or {}
		getgenv().ScriptHoldingF = false
		
		_G.CounterData = {
			["130924083726156"] = { Name = "Front Dash", Delay = 0.2, Dist = 10, Angle = 70, PosPredict = 0.14 },
			["121535378064818"] = { Name = "Grave Maker", Dist = 12, NoDir = true, Predict = 0.15, Duration = 0.9 },
			["124962465789551"] = { Name = "Blast Maker", Dist = 40, Angle = 35, Predict = 0.1, Delay = 0.25, IgnoreAfter = 0.8 },
			["100687456175134"] = { Name = "Point Blank", Dist = 15, Angle = 45, Predict = 0.1, Delay = 0.35, IgnoreAfter = 0.7 },
			["118270485922095"] = { Name = "Crossfire", Dist = 18, Angle = 45, Predict = 0.15, Delay = 0.35, IgnoreAfter = 1.1 },
			["16431491215"] = { Name = "Stone Coffin", Special = "StoneCoffin", NoDir = true },
			["16597912086"] = { Name = "Explosive Push", Dist = 15, NoDir = true, IgnoreAfter = 0.55 },
			["17464644182"] = { Name = "Psychic Ricochet", Dist = 20, Angle = 45, Duration = .6 },
			["17860467628"] = { Name = "Sky Snatcher", Delay = .6, Dist = 16, NoDir = true, Predict = 0.15, IgnoreAfter = 2.4 },
			["14004235777"] = { Name = "Homerun Swing", Dist = 8, Duration = 1.2 },
			["14003607057"] = { Name = "Homerun Slam", Delay = 0.5, Predict = 0.15, IgnoreAfter = .9, Dist = 12 },
			["14046756619"] = { Name = "Beatdown", Dist = 11, Duration = 0.7, NoDir = true, Predict = 0.15 },
			["14299135500"] = { Name = "Grand Slam", Dist = 10, PosPredict = 0.25, NoDir = true, Delay = 0.35 },
			["14351441234"] = { Name = "Foul Ball", Delay = 0.2, Duration = 0.8, NoDir = true, Predict = .1 },
			["14719290328"] = { Name = "Savage Tornado", Dist = 40, NoDir = true, Predict = 0.2, Duration = 3.65 },
			["14701242661"] = { Name = "Brutal Beatdown", Delay = 1.5, Dist = 13, Duration = 8.0, NoDir = true, Predict = 0.19 },
			["12272894215"] = { Name = "Flowing Water", Duration = 0.5, Dist = 10 },
			["12273188754"] = { Name = "Flowing Water Punches", Duration = 1.7, Dist = 8, Predict = 0.25 },
			["12296882427"] = { Name = "Lethal Whirlwind Stream", Duration = 0.5 },
			["12307656616"] = { Name = "Hunters Grasp", Dist = 6, Angle = 30, Duration = .25 },
			["13630786846"] = { Name = "Crushed Rock Run", Dist = 16, Predict = 0.2, Duration = 1 },
			["12460977270"] = { Name = "Water Stream Cutting Fist", Duration = 1.6 },
			["14057231976"] = { Name = "Rock Splitting Fist", Duration = 1.45 },
			["72451715583225"] = { Name = "Crushed Rock Grab", Predict = 0.2, Duration = 0.75 },
			["135104210400610"] = { Name = "Crushed Rock Slide", PosPredict = 0.15, Duration = .75, Dist = 11 },
			["102989537449083"] = { Name = "Doom Dive", RaycastType = "ForwardDown", Dist = 10 },
			["82365328621192"] = { Name = "Doom Dive Alt", RaycastType = "ForwardDown", Dist = 10 },
			["131820095363270"] = { Name = "Crowd Buster", Dist = 10, NoDir = true, Predict = 0.15, Duration = 1.6 },
			["109617620932970"] = { Name = "Hammer Heel", Duration = .6, Dist = 8 },
			["135289891173395"] = { Name = "Hammer Heel Variant", Dist = 13, Duration = 0.85, Predict = .5 },
			["125955606488863"] = { Name = "Binding Cloth", Dist = 9, Delay = .2, IgnoreAfter = 0.7 },
			["85025226664507"] = { Name = "Hunters Mark", Dist = 15, Predict = 0.2, Delay = 0.6, IgnoreAfter = 1.3 },
			["10468665991"] = { Name = "Normal Punch", Dist = 70, Angle = 20, Delay = .3, IgnoreAfter = .5 },
			["10466974800"] = { Name = "Consecutive Punches", Dist = 11, IgnoreAfter = 1.4 },
			["10471336737"] = { Name = "Shove", IgnoreAfter = .5 },
			["12510170988"] = { Name = "Uppercut", Delay = .1, IgnoreAfter = 0.45 },
			["17799224866"] = { Name = "Bullet Barrage", IgnoreAfter = 2, Dist = 11, Angle = 50 },
			["17838006839"] = { Name = "Vanishing Kick", Delay = 0.4, IgnoreAfter = .95, Dist = 11, Angle = 45, Predict = 0.15 },
			["17838619895"] = { Name = "Vanishing Kick Slam", Dist = 10, NoDir = true, IgnoreAfter = 1, Predict = .05 },
			["17857788598"] = { Name = "Whirlwind Drop", RaycastType = "DownOnly", Dist = 20 },
			["18464362124"] = { Name = "Whirlwind Finisher", Dist = 20, NoDir = true, IgnoreAfter = 2.7 },
			["18179181663"] = { Name = "Head First", IgnoreAfter = .5, Dist = 10, Angle = 60 },
			["18896229321"] = { Name = "Twin Fangs", Dist = 15, Predict = 0.1, IgnoreAfter = 3.3, Angle = 45 },
			["18897119503"] = { Name = "Earth Splitting", Dist = 70, Angle = 20 },
			["80903587710309"] = { Name = "Trinity Tear Air", RaycastType = "DownOnly", Dist = 15 },
			["77509627104305"] = { Name = "Trinity Tear", Special = "BoxCheck", OffsetZ = 26, Width = 8, NoFace = true, Predict = 0.1 },
			["114095570398448"] = { Name = "Plasma Cannon", Special = "BoxCheck", OffsetZ = 100, Width = 6, NoFace = true },
			["13376869471"] = { Name = "Flash Strike", Delay = 0.2, IgnoreAfter = 0.7, Dist = 57, Angle = 20 },
			["13294790250"] = { Name = "Whirlwind Kick", Special = "SonicKick", IgnoreAfter = 0.8 },
			["13632347366"] = { Name = "Twinblade Rush", Dist = 25, PosPredict = 0.15, Angle = 50 },
			["13881335713"] = { Name = "FourFold Strike", Dist = 50, Angle = 35 },
			["12534735382"] = { Name = "Machine Gun Blows", Dist = 11, IgnoreAfter = 1.8, Angle = 50 },
			["12502664044"] = { Name = "Ignition Burst Opener", Dist = 15, Special = "BehindCheck", IgnoreAfter = .3 },
			["12509505723"] = { Name = "Ignition Burst Blast", Dist = 40, Angle = 35, Predict = 0.1, Delay = 0.3, IgnoreAfter = 0.7 },
			["12684390285"] = { Name = "Jet Dive", RaycastType = "ForwardDown", Delay = 1.268, Dist = 22 },
			["14721837245"] = { Name = "Thunder Kick", Special = "ThunderKick", Predict = 0.17, Delay = .4 },
			["13083332742"] = { Name = "Flamewave Cannon", Special = "GenosFlamewave", Width = 9, CloseDist = 25, NoFace = true, IgnoreAfter = 2 },
			["13146710762"] = { Name = "Incinerate", Special = "GenosIncinerate", CloseDist = 30, IgnoreAfter = 1.5 },
			["15290930205"] = { Name = "Quick Slice", Special = "QuickSlice", Delay = 0.45, NoFace = true },
			["15145462680"] = { Name = "Atmos Cleave", Dist = 12, Angle = 60 },
			["15295895753"] = { Name = "Pinpoint Cut", Delay = 0.4, Dist = 14, Angle = 45, Predict = 0.1, IgnoreAfter = 0.7 },
			["111986840437684"] = { Name = "Flame M1", Dist = 40, Angle = 40, IgnoreAfter = 0.45 },
			["15295336270"] = { Name = "Pinpoint Cut Air", RaycastType = "ForwardDown", Delay = 0.48, Dist = 14 },
			["16062410809"] = { Name = "Sunrise", Dist = 15, Delay = 0.7, Predict = 0.1, Angle = 50 },
			["15676072469"] = { Name = "Solar Cleave", Special = "SolarCleave", NoFace = true },
			["15520132233"] = { Name = "Sunset", Dist = 22, Duration = 3.5, Predict = 0.15 },
			["13380255751"] = { Name = "Sword Dash", Delay = 0.24, Dist = 9, Angle = 70, PosPredict = 0.14 },
			["10479335397"] = { Name = "Normal Dash", Delay = 0.24, Dist = 9, Angle = 70, PosPredict = 0.14 },
		}
		
		_G.BlockData = {
			["130924083726156"] = { Name = "Front Dash", Delay = 0.2, Dist = 11, NoDir = true, Predict = 0.14 },
			["121535378064818"] = { Name = "Grave Maker", Dist = 12, NoDir = true, Predict = 0.15, Duration = 0.9 },
			["124962465789551"] = { Name = "Blast Maker", Dist = 40, Angle = 35, Predict = 0.1, Delay = 0.35, IgnoreAfter = 0.8 },
			["100687456175134"] = { Name = "Point Blank", Dist = 15, Angle = 45, Predict = 0.1, Delay = 0.35, IgnoreAfter = 0.7 },
			["118270485922095"] = { Name = "Crossfire", Dist = 18, Angle = 45, Predict = 0.15, Delay = 0.35, IgnoreAfter = 1.1 },
			["16431491215"] = { Name = "Stone Coffin", Special = "StoneCoffin", NoDir = true },
			["14046756619"] = { Name = "Beatdown", Dist = 11, Duration = 0.7, NoDir = true, Predict = 0.15 },
			["12272894215"] = { Name = "Flowing Water", Duration = 0.5, Dist = 10, NoDir = true },
			["12273188754"] = { Name = "Flowing Water Punches", Duration = 1.7, Dist = 10, Predict = 0.15, Angle = 120 },
			["12296882427"] = { Name = "Lethal Whirlwind Stream", Duration = 0.5, Dist = 9, NoDir = true },
			["131820095363270"] = { Name = "Crowd Buster", Dist = 12, NoDir = true, Angle = 90, Predict = 0.2, Duration = 1.6 },
			["125955606488863"] = { Name = "Binding Cloth", Dist = 9, Delay = .3, IgnoreAfter = 0.7 },
			["10468665991"] = { Name = "Normal Punch", Dist = 70, Angle = 20, Delay = .4, IgnoreAfter = .7 },
			["10466974800"] = { Name = "Consecutive Punches", Dist = 11, IgnoreAfter = 1.4 },
			["17799224866"] = { Name = "Bullet Barrage", IgnoreAfter = 2, Dist = 11, Angle = 50 },
			["17838006839"] = { Name = "Vanishing Kick", Delay = 0.4, IgnoreAfter = .95, Dist = 11, Angle = 45, Predict = 0.15 },
			["17857788598"] = { Name = "Whirlwind Drop", RaycastType = "DownOnly", Dist = 20 },
			["18179181663"] = { Name = "Head First", IgnoreAfter = .5, Dist = 10, Angle = 60 },
			["77509627104305"] = { Name = "Trinity Tear", Special = "BoxCheck", OffsetZ = 22, Width = 8, NoFace = true, Predict = 0.15 },
			["13376869471"] = { Name = "Flash Strike", IgnoreAfter = 0.7, Dist = 57, Angle = 20 },
			["13294790250"] = { Name = "Whirlwind Kick", Special = "SonicKick", IgnoreAfter = 0.4 },
			["12534735382"] = { Name = "Machine Gun Blows", Dist = 11, IgnoreAfter = 1.8, Angle = 50 },
			["12502664044"] = { Name = "Ignition Burst Opener", Dist = 15, Special = "BehindCheck", IgnoreAfter = .3 },
			["12509505723"] = { Name = "Ignition Burst Blast", Dist = 40, Angle = 35, Predict = 0.1, Delay = 0.5, IgnoreAfter = 0.7 },
			["12684390285"] = { Name = "Jet Dive", RaycastType = "ForwardDown", Delay = 1.2, Dist = 22, NoDir = true },
			["15290930205"] = { Name = "Quick Slice", Special = "QuickSlice", Delay = 0.4, NoFace = true },
			["15295895753"] = { Name = "Pinpoint Cut", Delay = 0.4, Dist = 14, Angle = 45, Predict = 0.1, IgnoreAfter = 0.7 },
			["111986840437684"] = { Name = "Flame M1", Dist = 40, Angle = 40, IgnoreAfter = 0.45 },
			["15295336270"] = { Name = "Pinpoint Cut Air", RaycastType = "ForwardDown", Delay = 0.45, Dist = 14 },
			["13380255751"] = { Name = "Sword Dash", Delay = 0.2, Dist = 11, NoDir = true, Predict = 0.14 },
			["10479335397"] = { Name = "Normal Dash", Delay = 0.2, Dist = 11, NoDir = true, Predict = 0.14 },
		}
		
		local ToolWhitelists = {
			["Split Second Counter"] = {
				["Front Dash"]=true,["Grave Maker"]=true,["Blast Maker"]=true,["Point Blank"]=true,["Crossfire"]=true,
				["Sword Dash"]=true,["Normal Dash"]=true,["Plasma Cannon"]=true,["Trinity Tear"]=true,["Trinity Tear Air"]=true,
				["Flowing Water"]=true,["Flowing Water Punches"]=true,["Lethal Whirlwind Stream"]=true,["Hunters Grasp"]=true,
				["Crushed Rock Run"]=true,["Water Stream Cutting Fist"]=true,["Rock Splitting Fist"]=true,["Crushed Rock Grab"]=true,
				["Crushed Rock Slide"]=true,["Doom Dive"]=true,["Doom Dive Alt"]=true,["Crowd Buster"]=true,["Hammer Heel"]=true,
				["Hammer Heel Variant"]=true,["Binding Cloth"]=true,["Hunters Mark"]=true,["Homerun Swing"]=true,["Homerun Slam"]=true,
				["Beatdown"]=true,["Grand Slam"]=true,["Foul Ball"]=true,["Bullet Barrage"]=true,["Vanishing Kick"]=true,
				["Vanishing Kick Slam"]=true,["Whirlwind Drop"]=true,["Whirlwind Finisher"]=true,["Head First"]=true,
				["Twin Fangs"]=true,["Earth Splitting"]=true,["Stone Coffin"]=true,["Explosive Push"]=true,["Machine Gun Blows"]=true,
				["Ignition Burst Opener"]=true,["Ignition Burst Blast"]=true,["Jet Dive"]=true,["Thunder Kick"]=true,
				["Flame M1"]=true,["Quick Slice"]=true,["Atmos Cleave"]=true,["Pinpoint Cut"]=true,["Pinpoint Cut Air"]=true,
				["Sunrise"]=true,["Normal Punch"]=true,["Consecutive Punches"]=true,["Shove"]=true,["Uppercut"]=true,
				["Flash Strike"]=true,["Whirlwind Kick"]=true,
			},
			["Prey's Peril"] = {
				["Front Dash"]=true,["Grave Maker"]=true,["Blast Maker"]=true,["Point Blank"]=true,["Crossfire"]=true,
				["Sword Dash"]=true,["Normal Dash"]=true,["Plasma Cannon"]=true,["Trinity Tear"]=true,["Trinity Tear Air"]=true,
				["Flowing Water"]=true,["Flowing Water Punches"]=true,["Lethal Whirlwind Stream"]=true,["Hunters Grasp"]=true,
				["Crushed Rock Run"]=true,["Water Stream Cutting Fist"]=true,["Rock Splitting Fist"]=true,["Crushed Rock Grab"]=true,
				["Crushed Rock Slide"]=true,["Doom Dive"]=true,["Doom Dive Alt"]=true,["Crowd Buster"]=true,["Hammer Heel"]=true,
				["Hammer Heel Variant"]=true,["Binding Cloth"]=true,["Hunters Mark"]=true,["Homerun Swing"]=true,["Homerun Slam"]=true,
				["Beatdown"]=true,["Grand Slam"]=true,["Foul Ball"]=true,["Foul Ball Projectile"]=true,["Bullet Barrage"]=true,
				["Vanishing Kick"]=true,["Vanishing Kick Slam"]=true,["Whirlwind Drop"]=true,["Whirlwind Finisher"]=true,
				["Head First"]=true,["Twin Fangs"]=true,["Earth Splitting"]=true,["Stone Coffin"]=true,["Explosive Push"]=true,
				["Machine Gun Blows"]=true,["Ignition Burst Opener"]=true,["Ignition Burst Blast"]=true,["Jet Dive"]=true,
				["Thunder Kick"]=true,["Flame M1"]=true,["Quick Slice"]=true,["Atmos Cleave"]=true,["Pinpoint Cut"]=true,
				["Pinpoint Cut Air"]=true,["Sunrise"]=true,["Normal Punch"]=true,["Consecutive Punches"]=true,["Shove"]=true,
				["Uppercut"]=true,["Flash Strike"]=true,["Whirlwind Kick"]=true,
			},
			["Death Counter"] = {
				["Front Dash"]=true,["Grave Maker"]=true,["Blast Maker"]=true,["Point Blank"]=true,["Crossfire"]=true,
				["Sword Dash"]=true,["Normal Dash"]=true,["Stone Coffin"]=true,["Explosive Push"]=true,["Psychic Ricochet"]=true,
				["Sky Snatcher"]=true,["Homerun Swing"]=true,["Homerun Slam"]=true,["Beatdown"]=true,["Grand Slam"]=true,
				["Foul Ball"]=true,["Savage Tornado"]=true,["Brutal Beatdown"]=true,["Flowing Water"]=true,
				["Flowing Water Punches"]=true,["Lethal Whirlwind Stream"]=true,["Hunters Grasp"]=true,["Crushed Rock Run"]=true,
				["Water Stream Cutting Fist"]=true,["Rock Splitting Fist"]=true,["Crushed Rock Grab"]=true,["Crushed Rock Slide"]=true,
				["Doom Dive"]=true,["Doom Dive Alt"]=true,["Crowd Buster"]=true,["Hammer Heel"]=true,["Hammer Heel Variant"]=true,
				["Binding Cloth"]=true,["Hunters Mark"]=true,["Normal Punch"]=true,["Consecutive Punches"]=true,["Shove"]=true,
				["Uppercut"]=true,["Bullet Barrage"]=true,["Vanishing Kick"]=true,["Vanishing Kick Slam"]=true,
				["Whirlwind Drop"]=true,["Whirlwind Finisher"]=true,["Head First"]=true,["Twin Fangs"]=true,["Earth Splitting"]=true,
				["Trinity Tear Air"]=true,["Trinity Tear"]=true,["Plasma Cannon"]=true,["Flash Strike"]=true,["Whirlwind Kick"]=true,
				["Twinblade Rush"]=true,["FourFold Strike"]=true,["Machine Gun Blows"]=true,["Ignition Burst Opener"]=true,
				["Ignition Burst Blast"]=true,["Jet Dive"]=true,["Thunder Kick"]=true,["Flamewave Cannon"]=true,["Incinerate"]=true,
				["Quick Slice"]=true,["Atmos Cleave"]=true,["Pinpoint Cut"]=true,["Flame M1"]=true,["Pinpoint Cut Air"]=true,
				["Sunrise"]=true,["Solar Cleave"]=true,["Sunset"]=true,
			},
			["Death Blow"] = {
				["Front Dash"]=true,["Grave Maker"]=true,["Blast Maker"]=true,["Point Blank"]=true,["Crossfire"]=true,
				["Sword Dash"]=true,["Normal Dash"]=true,["Stone Coffin"]=true,["Explosive Push"]=true,["Psychic Ricochet"]=true,
				["Sky Snatcher"]=true,["Homerun Swing"]=true,["Homerun Slam"]=true,["Beatdown"]=true,["Grand Slam"]=true,
				["Foul Ball"]=true,["Savage Tornado"]=true,["Brutal Beatdown"]=true,["Flowing Water"]=true,
				["Flowing Water Punches"]=true,["Lethal Whirlwind Stream"]=true,["Hunters Grasp"]=true,["Crushed Rock Run"]=true,
				["Water Stream Cutting Fist"]=true,["Rock Splitting Fist"]=true,["Crushed Rock Grab"]=true,["Crushed Rock Slide"]=true,
				["Doom Dive"]=true,["Doom Dive Alt"]=true,["Crowd Buster"]=true,["Hammer Heel"]=true,["Hammer Heel Variant"]=true,
				["Binding Cloth"]=true,["Hunters Mark"]=true,["Normal Punch"]=true,["Consecutive Punches"]=true,["Shove"]=true,
				["Uppercut"]=true,["Bullet Barrage"]=true,["Vanishing Kick"]=true,["Vanishing Kick Slam"]=true,
				["Whirlwind Drop"]=true,["Whirlwind Finisher"]=true,["Head First"]=true,["Twin Fangs"]=true,["Earth Splitting"]=true,
				["Trinity Tear Air"]=true,["Trinity Tear"]=true,["Plasma Cannon"]=true,["Flash Strike"]=true,["Whirlwind Kick"]=true,
				["Twinblade Rush"]=true,["FourFold Strike"]=true,["Machine Gun Blows"]=true,["Ignition Burst Opener"]=true,
				["Ignition Burst Blast"]=true,["Jet Dive"]=true,["Thunder Kick"]=true,["Flamewave Cannon"]=true,["Incinerate"]=true,
				["Quick Slice"]=true,["Atmos Cleave"]=true,["Pinpoint Cut"]=true,["Flame M1"]=true,["Pinpoint Cut Air"]=true,
				["Sunrise"]=true,["Solar Cleave"]=true,["Sunset"]=true,
			},
		}
		
		local COS = {}
		for _, deg in ipairs({10,20,25,30,35,40,45,50,60,70,90,120}) do
			COS[deg] = math.cos(math.rad(deg))
		end
		
		local _pingSamples = {}
		local _smoothPing = 0.08
		task.spawn(function()
			while true do
				local ok, pingVal = pcall(function()
					return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
				end)
				if ok and pingVal and pingVal > 0 then
					_pingSamples[#_pingSamples + 1] = pingVal / 1000
					if #_pingSamples > 8 then table.remove(_pingSamples, 1) end
					local sum = 0
					for _, v in ipairs(_pingSamples) do
						sum = sum + v
					end
					_smoothPing = math.clamp(sum / #_pingSamples, 0.01, 0.35)
				end
				task.wait(0.5)
			end
		end)
		
		local ActiveM1s = {}
		local Live = workspace:FindFirstChild("Live")
		local function MonitorM1(c)
			if not c or c.Name == player.Name then return end
			c.ChildAdded:Connect(function(x) if x.Name == "M1ing" then ActiveM1s[c] = true end end)
			c.ChildRemoved:Connect(function(x) if x.Name == "M1ing" then ActiveM1s[c] = nil end end)
			if c:FindFirstChild("M1ing") then ActiveM1s[c] = true end
			c.AncestryChanged:Connect(function(_, p) if not p then ActiveM1s[c] = nil end end)
		end
		if Live then
			Live.ChildAdded:Connect(MonitorM1)
			for _, c in pairs(Live:GetChildren()) do MonitorM1(c) end
		end
		
		local scatterActive = setmetatable({}, { __mode = "k" })
		local scatterData = setmetatable({}, { __mode = "k" })
		
		local function setupNinjaTracker(char)
			if not char then return end
			if char:GetAttribute("Character") == "Ninja" then
				local function checkKatana()
					if char:FindFirstChild("HasKatana") then
						scatterActive[char] = true
						scatterData[char] = { boxSize = Vector3.new(26, 14, 46), predict = 0.04, startTime = math.huge }
					else
						scatterActive[char] = nil
						scatterData[char] = nil
					end
				end
				char.ChildAdded:Connect(checkKatana)
				char.ChildRemoved:Connect(checkKatana)
				checkKatana()
			end
		end
		
		local function setupBatterTracker(char)
			if not char then return end
			getgenv().BatterUltSafeState[char] = true
			char:GetAttributeChangedSignal("Ulted"):Connect(function()
				if char:GetAttribute("Ulted") and char:GetAttribute("Character") == "Batter" then
					getgenv().BatterUltSafeState[char] = false
				else
					getgenv().BatterUltSafeState[char] = true
				end
			end)
			char.ChildAdded:Connect(function(child)
				if child.Name == "DeathBlowCounter" then getgenv().BatterUltSafeState[char] = false end
			end)
			char.ChildRemoved:Connect(function(child)
				if child.Name == "DeathBlowCounter" then getgenv().BatterUltSafeState[char] = true end
			end)
			if char:GetAttribute("Ulted") and char:GetAttribute("Character") == "Batter" then
				getgenv().BatterUltSafeState[char] = false
			end
		end
		
		if Live then
			for _, child in ipairs(Live:GetChildren()) do
				setupBatterTracker(child)
				setupNinjaTracker(child)
			end
			Live.ChildAdded:Connect(function(child)
				setupBatterTracker(child)
				setupNinjaTracker(child)
			end)
		end
		
		local function animDigits(idStr)
			return tostring(idStr or ""):match("(%d+)")
		end
		
		local function isFacing(originPart, targetPos, cosThreshold)
			local dir = targetPos - originPart.Position
			local m = dir.Magnitude
			if m <= 1e-6 then return true end
			return originPart.CFrame.LookVector:Dot(dir / m) >= cosThreshold
		end
		
		local function boxCheck(enemyRoot, myPos, depth, width, height)
			local rel = enemyRoot.CFrame:PointToObjectSpace(myPos)
			if rel.Z > 0 then return false end
			if rel.Z < -depth then return false end
			if math.abs(rel.X) > width then return false end
			if height and math.abs(rel.Y) > height then return false end
			return true
		end
		
		local function isSelfSoundPlaying(soundId)
			local char = player.Character
			if not char then return false end
			local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
			if not torso then return false end
			for _, s in ipairs(torso:GetChildren()) do
				if s:IsA("Sound") and s.IsPlaying and s.SoundId == soundId then return true end
			end
			return false
		end
		
		local EnemyMotionTrack = setmetatable({}, { __mode = "k" })
		local RaycastTrack = setmetatable({}, { __mode = "k" })
		
		local _mapWhitelistCache = nil
		local _mapWhitelistDirty = true
		local _mapRayParams = RaycastParams.new()
		_mapRayParams.FilterType = Enum.RaycastFilterType.Include
		
		local function _buildMapWhitelist()
			local whitelist = {}
			local map = workspace:FindFirstChild("Map")
			if map then
				for _, name in ipairs({"Walls","Stuff","GrassTop","GrassBottom","Floor/Roads","MainPart"}) do
					local t = map:FindFirstChild(name)
					if t then whitelist[#whitelist+1] = t end
				end
			end
			_mapWhitelistCache = whitelist
			_mapRayParams.FilterDescendantsInstances = whitelist
			_mapWhitelistDirty = false
		end
		
		local function EnsureMapWhitelistFresh()
			if _mapWhitelistDirty or not _mapWhitelistCache then _buildMapWhitelist() end
		end
		
		do
			local function markDirty() _mapWhitelistDirty = true end
			local map = workspace:FindFirstChild("Map")
			if map then
				map.AncestryChanged:Connect(markDirty)
				map.ChildAdded:Connect(markDirty)
				map.ChildRemoved:Connect(markDirty)
			end
			workspace.ChildAdded:Connect(function(c) if c.Name == "Map" then markDirty() end end)
			workspace.ChildRemoved:Connect(function(c) if c.Name == "Map" then markDirty() end end)
		end
		
		local function CastRay(origin, direction)
			if direction.Magnitude < 1e-6 then return nil end
			EnsureMapWhitelistFresh()
			local hit = workspace:Raycast(origin, direction.Unit * 1000, _mapRayParams)
			if not hit then return nil end
			local finalPos = hit.Position
			if math.abs(hit.Normal.Y) < 0.5 then
				local floorOrigin = hit.Position + (hit.Normal * 1.5)
				local floorHit = workspace:Raycast(floorOrigin, Vector3.new(0, -100, 0), _mapRayParams)
				if floorHit then finalPos = floorHit.Position end
			end
			return finalPos
		end
		
		local function GetRaycastImpact(enemyRoot, animId, data)
			if not RaycastTrack[enemyRoot] then
				RaycastTrack[enemyRoot] = { StartCF = enemyRoot.CFrame, LastCF = enemyRoot.CFrame, PredictedPos = nil, AnimId = animId }
			end
			local t = RaycastTrack[enemyRoot]
			if t.AnimId ~= animId then
				RaycastTrack[enemyRoot] = { StartCF = enemyRoot.CFrame, LastCF = enemyRoot.CFrame, PredictedPos = nil, AnimId = animId }
				t = RaycastTrack[enemyRoot]
			end
			local currentPos = enemyRoot.Position
			if t.PredictedPos then
				if (currentPos - t.PredictedPos).Magnitude < 10 then t.PredictedPos = nil return nil end
				return t.PredictedPos
			end
			local triggered = false
			local rayDir = nil
			local relPos = t.StartCF:PointToObjectSpace(currentPos)
			local delta = currentPos - t.StartCF.Position
			if data.Name == "Doom Dive" or data.Name == "Doom Dive Alt" then
				local frameDrop = t.LastCF.Position.Y - currentPos.Y
				local totalDrop = t.StartCF.Position.Y - currentPos.Y
				if (frameDrop > 0.4 or totalDrop > 2.5) and delta.Magnitude > 0.05 then
					rayDir = (currentPos - t.LastCF.Position).Unit
					triggered = true
				end
			elseif data.RaycastType == "DownOnly" then
				if relPos.Y < -2 then rayDir = Vector3.new(0, -1, 0) triggered = true end
			elseif data.RaycastType == "ForwardDown" then
				if relPos.Z < -3 and relPos.Y < -0.5 and delta.Magnitude > 0.05 then
					rayDir = delta.Unit
					triggered = true
				end
			end
			t.LastCF = enemyRoot.CFrame
			if triggered and rayDir then
				local landPos = CastRay(currentPos, rayDir)
				if not landPos and data.Name:find("Doom Dive") then
					landPos = CastRay(currentPos, Vector3.new(0, -1, 0))
				end
				if landPos then t.PredictedPos = landPos return landPos end
			end
			return nil
		end
		
		local function findToolForMove(moveName)
			local backpack = player.Backpack
			local char = player.Character
			local allTools = {}
			if backpack then for _, t in ipairs(backpack:GetChildren()) do if t:IsA("Tool") then allTools[#allTools+1] = t end end end
			if char then for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") then allTools[#allTools+1] = t end end end
			for _, tool in ipairs(allTools) do
				local wl = ToolWhitelists[tool.Name]
				if wl and wl[moveName] then return tool.Name end
			end
			return nil
		end
		
		local function getMyHead()
			local char = player.Character
			return char and char:FindFirstChild("Head")
		end
		
		local function enemyM1ingNearby(maxDist)
			local myHead = getMyHead()
			if not myHead then return nil, nil end
			local myPos = myHead.Position
			local maxDist2 = maxDist * maxDist
			local ping = _smoothPing
			local bestChar, bestD2 = nil, math.huge
			for char, _ in pairs(ActiveM1s) do
				if char and char.Parent then
					if not char:FindFirstChild("M1ing") then ActiveM1s[char] = nil  end
					local head = char:FindFirstChild("Head")
					local root = char:FindFirstChild("HumanoidRootPart")
					if head and root then
						local enemyVel = root.AssemblyLinearVelocity or Vector3.zero
						local vm = enemyVel.Magnitude
						if vm > 200 then enemyVel = enemyVel * (200 / vm) end
						local predictedHeadPos = head.Position + (enemyVel * ping)
						local distVec = predictedHeadPos - myPos
						local d2 = distVec.X*distVec.X + distVec.Y*distVec.Y + distVec.Z*distVec.Z
						local qualifies = false
						if d2 <= 49 then
							qualifies = true
						elseif d2 <= maxDist2 then
							if d2 > 0.01 then
								local dot = root.CFrame.LookVector:Dot(-distVec.Unit)
								if dot > 0.422 then qualifies = true end
							else
								qualifies = true
							end
						end
						if qualifies and d2 < bestD2 then
							bestChar = char
							bestD2 = d2
						end
					end
				else ActiveM1s[char] = nil end
			end
			return bestChar, bestD2 ~= math.huge and bestD2 or nil
		end
		
		local function tposWindowOk(track, data)
			local speed = 1
			pcall(function() speed = math.max(track.Speed, 0.01) end)
			local tp = track.TimePosition * speed
			if data.Delay and tp < data.Delay then return false end
			if data.Duration and tp > data.Duration then return false end
			if data.IgnoreAfter and tp > data.IgnoreAfter then return false end
			return true
		end
		
		local function shouldCounter(enemyModel, track, myRoot, dataOverride, animIdOverride, allowNoTool, forcedToolName)
			local enemyRoot = enemyModel and enemyModel:FindFirstChild("HumanoidRootPart")
			if not enemyRoot then return false end
			local animId = animIdOverride or animDigits(track.Animation and track.Animation.AnimationId)
			local data = dataOverride or (animId and _G.CounterData[animId]) or nil
			if not data then return false end
			local toolName = forcedToolName or findToolForMove(data.Name)
			if forcedToolName and not allowNoTool then
				local wl = ToolWhitelists[forcedToolName]
				if wl and not wl[data.Name] then return false end
			end
			if not toolName and not allowNoTool then return false end
			local speed = 1
			pcall(function() speed = math.max(track.Speed, 0.01) end)
			local timePos = track.TimePosition * speed
			if data.Duration and timePos > data.Duration then return false end
			if data.Delay and timePos < data.Delay then return false end
			if data.IgnoreAfter and timePos > data.IgnoreAfter then return false end
			local enemyVel
			if data.PosPredict then
				local currentPos = enemyRoot.Position
				local currentTime = tick()
				local trackData = EnemyMotionTrack[enemyRoot]
				if not trackData then
					EnemyMotionTrack[enemyRoot] = { LastPos = currentPos, LastTime = currentTime }
					enemyVel = enemyRoot.AssemblyLinearVelocity or Vector3.zero
				else
					local dt = currentTime - trackData.LastTime
					if dt > 0 then
						enemyVel = (currentPos - trackData.LastPos) / dt
					else
						enemyVel = enemyRoot.AssemblyLinearVelocity or Vector3.zero
					end
					trackData.LastPos = currentPos
					trackData.LastTime = currentTime
				end
			else
				enemyVel = enemyRoot.AssemblyLinearVelocity or Vector3.zero
			end
			local pTime = data.PosPredict or data.Predict or 0
			local predictedEnemyPos = enemyRoot.Position + enemyVel * pTime
			local dist = (predictedEnemyPos - myRoot.Position).Magnitude
			if data.RaycastType then
				local impactPos = GetRaycastImpact(enemyRoot, animId, data)
				if impactPos then
					if (impactPos - myRoot.Position).Magnitude <= data.Dist then return true end
				end
				if dist <= (data.Dist or 20) then return true end
				return false
			end
			if data.Special == "StoneCoffin" then
				local forward = enemyRoot.CFrame.LookVector
				local origin = enemyRoot.Position + forward * 19.5 + Vector3.new(0, 20, 0)
				local rayParams = RaycastParams.new()
				rayParams.FilterType = Enum.RaycastFilterType.Exclude
				rayParams.FilterDescendantsInstances = { player.Character, enemyModel }
				local hit = workspace:Raycast(origin, Vector3.new(0, -1000, 0), rayParams)
				if not hit then return false end
				return (hit.Position - myRoot.Position).Magnitude <= 10.5
			end
			if data.Special == "BoxCheck" then
				local predPos = enemyRoot.Position + ((enemyRoot.AssemblyLinearVelocity or Vector3.zero) * (data.Predict or 0))
				local predCFrame = CFrame.new(predPos) * enemyRoot.CFrame.Rotation
				local rel = predCFrame:PointToObjectSpace(myRoot.Position)
				if rel.Z >= 0 then return false end
				if rel.Z < -data.OffsetZ then return false end
				if math.abs(rel.X) > data.Width then return false end
				if math.abs(rel.Y) > (data.Height or 20) then return false end
				return true
			end
			if data.Special == "SonicKick" then
				if timePos < 0.1 then
					if dist > 45 then return false end
					return isFacing(enemyRoot, myRoot.Position, COS[20])
				else
					local req = tonumber(getgenv().AutoCounterDist) or 20
					return dist <= req
				end
			end
			if data.Special == "BehindCheck" then
				local dirToMe = myRoot.Position - enemyRoot.Position
				local m = dirToMe.Magnitude
				if m <= 1e-6 then return true end
				if (dirToMe / m):Dot(enemyRoot.CFrame.LookVector) > math.cos(math.rad(135)) then return false end
				return dist <= (data.Dist or 15)
			end
			if data.Special == "ThunderKick" then
				if timePos >= 0.5 and timePos <= 0.8 then return dist <= 12 end
				if timePos >= 1.5 then
					if toolName == "Death Counter" then return dist <= 60 else return dist <= 30 end
				end
				return false
			end
			if data.Special == "GenosFlamewave" then
				local depth = (toolName == "Death Counter") and 1000 or (data.CloseDist or 25)
				return boxCheck(enemyRoot, myRoot.Position, depth, data.Width or 6, 10)
			end
			if data.Special == "GenosIncinerate" then
				if dist <= (data.CloseDist or 30) then return true end
				if toolName == "Death Blow" then return dist <= 30 and isFacing(enemyRoot, myRoot.Position, COS[40]) end
				if toolName == "Death Counter" then return dist <= 600 and isFacing(enemyRoot, myRoot.Position, COS[35]) end
				return false
			end
			if data.Special == "SolarCleave" then
				return boxCheck(enemyRoot, myRoot.Position, 140, 15, 10)
			end
			if data.Special == "QuickSlice" then
				local center = (enemyRoot.CFrame * CFrame.new(0, 0, -19)).Position
				return (center - myRoot.Position).Magnitude <= 22
			end
			local reqDist = data.Dist or (tonumber(getgenv().AutoCounterDist) or 20)
			if dist > reqDist then return false end
			if not data.NoDir and not data.NoFace then
				local angle = data.Angle or 90
				local cosT = COS[angle] or math.cos(math.rad(angle))
				if not isFacing(enemyRoot, myRoot.Position, cosT) then return false end
			end
			return true
		end
		
		local function shouldBlock(enemyModel, track, myRoot)
			local animId = animDigits(track.Animation and track.Animation.AnimationId)
			local data = animId and _G.BlockData[animId] or nil
			if not data then return false end
			return shouldCounter(enemyModel, track, myRoot, data, animId, true, nil)
		end
		
		local fHeld = false
		
		local function fireF(isDown)
			getgenv().ScriptHoldingF = isDown
			local char = player.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				if hum then hum.AutoRotate = not isDown end
				local comm = char:FindFirstChild("Communicate")
				if comm then
					comm:FireServer({ Goal = isDown and "KeyPress" or "KeyRelease", Key = Enum.KeyCode.F })
				end
			end
		end
		
		local function getHotbarFrame()
			local pg = player:FindFirstChild("PlayerGui")
			local hotbar = pg and pg:FindFirstChild("Hotbar")
			local backpack = hotbar and hotbar:FindFirstChild("Backpack")
			return backpack and backpack:FindFirstChild("Hotbar")
		end
		
		local function isHotbarToolReady(toolName)
			local hotbar = getHotbarFrame()
			if not hotbar then return false end
			for i = 1, 4 do
				local slot = hotbar:FindFirstChild(tostring(i))
				local base = slot and slot:FindFirstChild("Base")
				if base then
					local toolLabel = base:FindFirstChild("ToolName")
					if toolLabel and toolLabel.Text == toolName then
						return base:FindFirstChild("Cooldown") == nil
					end
				end
			end
			return false
		end
		
		local function equipBestCounterTool(whitelist)
			local char = player.Character
			local backpack = player.Backpack
			if not (char and backpack) then return end
			local items = { "Death Blow", "Death Counter", "Split Second Counter", "Prey's Peril" }
			for _, itemName in ipairs(items) do
				if (not whitelist) or whitelist[itemName] then
					local tool = backpack:FindFirstChild(itemName)
					if tool and tool:IsA("Tool") then
						tool.Parent = char
						task.defer(function()
							if tool and tool.Parent == char and backpack then
								tool.Parent = backpack
							end
						end)
						Replicated.Replication:FireServer({ Name = tool.Name, Effect = "Cooldown" })
						break
					end
				end
			end
		end
		
		local function performCounter(toolName)
			if not toolName then return false end
			local hotbar = getHotbarFrame()
			if not hotbar then return false end
			local found = false
			for i = 1, 4 do
				local slot = hotbar:FindFirstChild(tostring(i))
				local base = slot and slot:FindFirstChild("Base")
				if base then
					local toolLabel = base:FindFirstChild("ToolName")
					if toolLabel and toolLabel.Text == toolName then
						if base:FindFirstChild("Cooldown") == nil then found = true end
						break
					end
				end
			end
			if not found then return false end
			local backpack = player.Backpack
			local char = player.Character
			local tool = (char and char:FindFirstChild(toolName)) or (backpack and backpack:FindFirstChild(toolName))
			if not tool then return false end
			if fHeld then fHeld = false fireF(false) end
			equipBestCounterTool({ [toolName] = true })
			return true
		end
		
		local function desiredToolFromSelf()
			local c = player.Character
			if not c then return nil end
			local charType = c:GetAttribute("Character")
			local ulted = c:GetAttribute("Ulted") == true
			if charType == "Bald" and ulted then
				if not getgenv().UseDeathMoves then return nil end
				return "Death Counter"
			end
			if charType == "Batter" and ulted then
				if not getgenv().UseDeathMoves then return nil end
				return "Death Blow"
			end
			if charType == "Blade" and not ulted then return "Split Second Counter" end
			if charType == "Hunter" and not ulted then return "Prey's Peril" end
			return nil
		end
		
		local ActiveCounterPacks = setmetatable({}, { __mode = "k" })
		local ActiveBlockPacks = setmetatable({}, { __mode = "k" })
		local AnimWatch = {}
		
		local function trackIsPlayingSafe(track)
			local ok, v = pcall(function() return track.IsPlaying end)
			return ok and v or false
		end
		
		local function updateRaycastEveryFrame(info, track, myRoot)
			local impactPos = GetRaycastImpact(info.EnemyRoot, info.AnimId, info.Data)
			info.LastImpactPos = impactPos
			if not impactPos then return false end
			if not tposWindowOk(track, info.Data) then return false end
			local req = info.Data.Dist or (tonumber(getgenv().AutoCounterDist) or 20)
			return (impactPos - myRoot.Position).Magnitude <= req
		end
		
		local ActiveCounterTracksCount = 0
		local CounterLoopConnection = nil
		local UpdateCounterLoopState
		
		local function disconnectPack(pack)
			if not pack then return end
			local old = pack.activeTracks
			if old then
				for _, info in pairs(old) do
					if info then
						info.isActionActive = false
						if info.EnemyRoot then RaycastTrack[info.EnemyRoot] = nil EnemyMotionTrack[info.EnemyRoot] = nil end
						if info.__counted then info.__counted = nil if UpdateCounterLoopState then UpdateCounterLoopState(-1) end end
					end
				end
				pack.activeTracks = nil
			end
			local oldB = pack.blockTracks
			if oldB then
				for _, info in pairs(oldB) do
					if info then
						info.isActionActive = false
						if info.EnemyRoot then RaycastTrack[info.EnemyRoot] = nil end
					end
				end
				pack.blockTracks = nil
			end
			for k, c in pairs(pack) do if typeof(c) == "RBXScriptConnection" then c:Disconnect() end pack[k] = nil end
		end
		
		local function onEnemyTrackStarted(plr, eChar, eHum, track)
			local animId = animDigits(track.Animation and track.Animation.AnimationId)
			local pack = AnimWatch[plr]
			if not pack then return end
			local cData = _G.CounterData[animId] or nil
			local bData = _G.BlockData[animId] or nil
			if not cData and not bData then return end
			local enemyRoot = eChar and eChar:FindFirstChild("HumanoidRootPart")
			if not enemyRoot then return end
			pack.activeTracks = pack.activeTracks or {}
			pack.blockTracks = pack.blockTracks or {}
			if cData then
				pack.activeTracks[track] = pack.activeTracks[track] or {
					isActionActive = true, Fired = false, Char = eChar, EnemyRoot = enemyRoot,
					AnimId = animId, Data = cData, LastImpactPos = nil
				}
				ActiveCounterPacks[plr] = true
				pack.activeTracks[track].isActionActive = true
				if not pack.activeTracks[track].__counted then
					pack.activeTracks[track].__counted = true
					if UpdateCounterLoopState then UpdateCounterLoopState(1) end
				end
			end
			if bData then
				pack.blockTracks[track] = pack.blockTracks[track] or {
					isActionActive = true, Char = eChar, EnemyRoot = enemyRoot, AnimId = animId, Data = bData
				}
				ActiveBlockPacks[plr] = true
				pack.blockTracks[track].isActionActive = true
			end
			track.Stopped:Connect(function()
				local p2 = AnimWatch[plr]
				if not p2 then return end
				if p2.activeTracks then
					local info = p2.activeTracks[track]
					if info then
						info.isActionActive = false
						if info.EnemyRoot then RaycastTrack[info.EnemyRoot] = nil EnemyMotionTrack[info.EnemyRoot] = nil end
						if info.__counted then info.__counted = nil UpdateCounterLoopState(-1) end
						p2.activeTracks[track] = nil
					end
					if next(p2.activeTracks) == nil then ActiveCounterPacks[plr] = nil end
				end
				if p2.blockTracks then
					local binfo = p2.blockTracks[track]
					if binfo then
						binfo.isActionActive = false
						if binfo.EnemyRoot then RaycastTrack[binfo.EnemyRoot] = nil end
						p2.blockTracks[track] = nil
					end
					if next(p2.blockTracks) == nil then ActiveBlockPacks[plr] = nil end
				end
			end)
		end
		
		local ParrySounds = {
			["12244488517"]=true,["2232392291"]=true,["4306994267"]=true,["4306994923"]=true,
			["4306994664"]=true,["4306995205"]=true,["13391515385"]=true,["13391515477"]=true,
			["13391515421"]=true,["13391515338"]=true,
		}
		local SoundParryBlockOverrideUntil = 0
		local _parrySoundWasPlaying = setmetatable({}, { __mode = "k" })
		local _parrySoundConns = setmetatable({}, { __mode = "k" })
		local _parryHRPChildConn = nil
		
		local function _soundParryShouldCancel(hrp)
			local liveFolder = workspace:FindFirstChild("Live")
			if not liveFolder then return false end
			for _, enemy in ipairs(liveFolder:GetChildren()) do
				if enemy.Name ~= player.Name then
					local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
					if enemyRoot then
						local dist = (enemyRoot.Position - hrp.Position).Magnitude
						if dist <= 12 and enemy:FindFirstChild("Counter") then return true end
						if dist < 10 then
							local isUlted = enemy:GetAttribute("Ulted")
							local charType = enemy:GetAttribute("Character")
							if isUlted and charType == "Batter" then
								if getgenv().BatterUltSafeState[enemy] == false then return true end
							end
							if isUlted and charType == "Bald" then return true end
						end
					end
				end
			end
			return false
		end
		
		local function _tapM1()
			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
				task.wait()
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
			end)
		end
		
		local function _handleParrySoundStart(sound)
			if not getgenv().SoundParry then return end
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end
			if _soundParryShouldCancel(hrp) then return end
			local m1Held = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
			if not m1Held then
				SoundParryBlockOverrideUntil = tick() + 0.02
				if fHeld then fHeld = false fireF(false) end
				_tapM1()
			end
		end
		
		local function _detachParryListeners()
			if _parryHRPChildConn then _parryHRPChildConn:Disconnect() _parryHRPChildConn = nil end
			for s, c in pairs(_parrySoundConns) do if c then c:Disconnect() end _parrySoundConns[s] = nil _parrySoundWasPlaying[s] = nil end
		end
		
		local function _attachSound(sound)
			if _parrySoundConns[sound] then return end
			_parrySoundWasPlaying[sound] = sound.IsPlaying
			if sound.IsPlaying then _handleParrySoundStart(sound) end
			_parrySoundConns[sound] = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
				local was = _parrySoundWasPlaying[sound]
				local nowPlaying = sound.IsPlaying
				_parrySoundWasPlaying[sound] = nowPlaying
				if nowPlaying and not was then _handleParrySoundStart(sound) end
			end)
		end
		
		local function _bindParryToChar(char)
			_detachParryListeners()
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then
				local tmp
				tmp = char.ChildAdded:Connect(function(ch)
					if ch.Name == "HumanoidRootPart" then tmp:Disconnect() _bindParryToChar(char) end
				end)
				return
			end
			for _, child in ipairs(hrp:GetChildren()) do
				if child:IsA("Sound") then
					local cleanId = child.SoundId and child.SoundId:match("%d+")
					if cleanId and ParrySounds[cleanId] then _attachSound(child) end
				end
			end
			_parryHRPChildConn = hrp.ChildAdded:Connect(function(ch)
				if ch:IsA("Sound") then
					local cleanId = ch.SoundId and ch.SoundId:match("%d+")
					if cleanId and ParrySounds[cleanId] then _attachSound(ch) end
				end
			end)
		end
		
		_bindParryToChar(player.Character)
		player.CharacterAdded:Connect(_bindParryToChar)
		
		local doBlock = false
		local blockTarget = nil
		local scriptedBlockActive = false
		local m1SequenceActive = false
		local m1Cancel = false
		local blockReleasePending = false
		
		local function startM1Sequence(count, interval)
			if m1SequenceActive then return end
			m1SequenceActive = true
			m1Cancel = false
			local conn
			conn = UserInputService.InputBegan:Connect(function(input, gp)
				if gp then return end
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					m1Cancel = true
					conn:Disconnect()
				end
			end)
			task.spawn(function()
				for i = 1, count do
					if m1Cancel then break end
					_tapM1()
					if i < count then task.wait(interval) end
				end
				m1SequenceActive = false
				if conn then conn:Disconnect() end
			end)
		end
		
		local function CounterLoopAction()
			local myChar = player.Character
			if not myChar then return end
			local myRoot = myChar:FindFirstChild("HumanoidRootPart")
			if not myRoot then return end
			doBlock = false
			blockTarget = nil
			local autoBlock = getgenv().AutoBlocking
			local autoCounter = getgenv().AutoCounter
			if not (autoBlock or autoCounter) then
				if fHeld then fHeld = false fireF(false) end
				scriptedBlockActive = false
				return
			end
			local didCounter = false
			local now = tick()
			local counterDst = tonumber(getgenv().AutoCounterDist) or 7.5
			local blockDst = tonumber(getgenv().AutoBlockDist) or 9
			local scanDst = counterDst > blockDst and counterDst or blockDst
			local m1Enemy, m1d2 = enemyM1ingNearby(scanDst)
			local counterDst2 = counterDst * counterDst
			local blockDst2 = blockDst * blockDst
			local desiredTool = nil
			local canCounterNow = false
			if autoCounter then
				desiredTool = desiredToolFromSelf()
				canCounterNow = desiredTool and isHotbarToolReady(desiredTool) or false
			end
			if autoCounter and canCounterNow then
				if desiredTool == "Death Counter" or desiredTool == "Death Blow" then
					if isSelfSoundPlaying("rbxassetid://16139753098") or isSelfSoundPlaying("rbxassetid://17294130580") then
						if performCounter(desiredTool) then didCounter = true end
					end
				end
				if not didCounter then
					for plr in pairs(ActiveCounterPacks) do
						local pack = AnimWatch[plr]
						local active = pack and pack.activeTracks
						if active then
							for track, info in pairs(active) do
								if info and info.isActionActive and not info.Fired then
									if not trackIsPlayingSafe(track) then
										if info.EnemyRoot then RaycastTrack[info.EnemyRoot] = nil EnemyMotionTrack[info.EnemyRoot] = nil end
										if info.__counted then info.__counted = nil if UpdateCounterLoopState then UpdateCounterLoopState(-1) end end
										active[track] = nil
										if next(active) == nil then ActiveCounterPacks[plr] = nil end
									else
										local moveData = info.Data
										local wl = ToolWhitelists[desiredTool]
										local okToFire = false
										if (not wl) or wl[moveData.Name] then
											if moveData.RaycastType then
												okToFire = updateRaycastEveryFrame(info, track, myRoot)
											else
												okToFire = shouldCounter(info.Char, track, myRoot, info.Data, info.AnimId, false, desiredTool)
											end
										end
										if okToFire and not info.Fired then
											if performCounter(desiredTool) then
												info.Fired = true
												didCounter = true
												break
											end
										end
									end
								end
							end
						end
						if didCounter then break end
					end
				end
				if not didCounter then
					for char, active in pairs(scatterActive) do
						if active and char.Parent and char:FindFirstChild("HumanoidRootPart") then
							local enemyRoot = char.HumanoidRootPart
							local sData = scatterData[char]
							if sData then
								if now - sData.startTime > 3 then
									scatterActive[char] = nil scatterData[char] = nil
								else
									local enemyVel = enemyRoot.AssemblyLinearVelocity or Vector3.zero
									local predPos = enemyRoot.Position + (enemyVel * sData.predict)
									local boxCFrame = CFrame.new(predPos) * enemyRoot.CFrame.Rotation
									local rel = boxCFrame:PointToObjectSpace(myRoot.Position)
									local bs = sData.boxSize
									local depthBehind = bs.Z * 0.2
									local depthFront = -(bs.Z * 0.8)
									local okToFire = (math.abs(rel.X) <= (bs.X * 0.5))
										and (math.abs(rel.Y) <= (bs.Y * 0.5))
										and (rel.Z <= depthBehind and rel.Z >= depthFront)
									if okToFire then
										if performCounter(desiredTool) then
											scatterActive[char] = nil scatterData[char] = nil
											didCounter = true break
										else
											doBlock = true
											getgenv().AutoBlockTarget = Players:GetPlayerFromCharacter(char)
										end
									end
								end
							end
						else
							scatterActive[char] = nil scatterData[char] = nil
						end
					end
				end
				if not didCounter then
					if m1Enemy and m1d2 and m1d2 <= counterDst2 then
						if performCounter(desiredTool) then didCounter = true end
					end
				end
			end
			if autoBlock and not didCounter then
				local m1Held = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
				local manualF = UserInputService:IsKeyDown(Enum.KeyCode.F)
				local preBlock = doBlock
				local preBlockTarget = getgenv().AutoBlockTarget
				local bestBlockPlr = nil
				local bestBlockD2 = math.huge
				local soundParryLock = getgenv().SoundParry and tick() < SoundParryBlockOverrideUntil
				if m1Enemy and m1d2 and m1d2 <= blockDst2 then
					bestBlockPlr = Players:GetPlayerFromCharacter(m1Enemy)
					bestBlockD2 = m1d2
				end
				if not soundParryLock and not preBlock then
					for plr in pairs(ActiveBlockPacks) do
						local pack = AnimWatch[plr]
						local bt = pack and pack.blockTracks
						if not bt then
							ActiveBlockPacks[plr] = nil
						else
							for track, info in pairs(bt) do
								if info and info.isActionActive then
									if not trackIsPlayingSafe(track) then
										if info.EnemyRoot then RaycastTrack[info.EnemyRoot] = nil end
										bt[track] = nil
										if next(bt) == nil then ActiveBlockPacks[plr] = nil end
									else
										if shouldCounter(info.Char, track, myRoot, info.Data, info.AnimId, true, nil) then
											local enemyRoot = info.EnemyRoot
											local delta = enemyRoot and (enemyRoot.Position - myRoot.Position) or nil
											local d2 = delta and (delta.X * delta.X + delta.Y * delta.Y + delta.Z * delta.Z) or math.huge
											if d2 < bestBlockD2 then
												bestBlockD2 = d2
												bestBlockPlr = plr
											end
										end
									end
								end
							end
						end
					end
				end
				if soundParryLock then
					doBlock = false
					blockTarget = nil
				elseif preBlock then
					doBlock = true
					blockTarget = blockTarget or preBlockTarget
				else
					doBlock = bestBlockPlr ~= nil
					blockTarget = bestBlockPlr
				end
				if manualF or m1Held then doBlock = false blockTarget = nil end
				if doBlock then
					if not fHeld then fHeld = true if not manualF then fireF(true) end end
					scriptedBlockActive = not manualF
					getgenv().AutoBlockTarget = blockTarget
					blockReleasePending = false  -- cancel any pending release if we re-entered block
				else
					if fHeld and scriptedBlockActive then
						if not blockReleasePending then
							blockReleasePending = true
							local releaseDelay = tonumber(getgenv().BlockReleaseDelay) or 0.35
							task.delay(releaseDelay, function()
								if not blockReleasePending then return end  -- cancelled
								blockReleasePending = false
								if fHeld and scriptedBlockActive then
									if getgenv().AutoM1AfterBlock and not m1SequenceActive then
										local count = tonumber(getgenv().M1Count) or 1
										local interval = tonumber(getgenv().M1Interval) or 0.2
										startM1Sequence(count, interval)
									end
									fHeld = false
									local mf = UserInputService:IsKeyDown(Enum.KeyCode.F)
									if not mf then fireF(false) else getgenv().ScriptHoldingF = false end
									scriptedBlockActive = false
									getgenv().AutoBlockTarget = nil
								end
							end)
						end
						-- keep holding the block while the delay counts down
					elseif fHeld then
						fHeld = false
						if not manualF then fireF(false) else getgenv().ScriptHoldingF = false end
						scriptedBlockActive = false
						getgenv().AutoBlockTarget = nil
					else
						scriptedBlockActive = false
						getgenv().AutoBlockTarget = nil
					end
				end
				if getgenv().ScriptHoldingF and not doBlock and not manualF then fireF(false) end
			end
			if fHeld and getgenv().AimbotWhileBlocking and blockTarget and blockTarget.Character then
				local targetChar = blockTarget.Character
				local targetPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Head")
				if targetPart then
					local targetPos = targetPart.Position + ((targetPart.AssemblyLinearVelocity or Vector3.zero) * _smoothPing)
					local lookAt = CFrame.lookAt(myRoot.Position, Vector3.new(targetPos.X, myRoot.Position.Y, targetPos.Z))
					myRoot.CFrame = lookAt
				end
			end
		end
		
		UpdateCounterLoopState = function(change)
			if change then ActiveCounterTracksCount = math.max(0, ActiveCounterTracksCount + change) end
			local shouldRun = (ActiveCounterTracksCount > 0) or getgenv().AutoBlocking or getgenv().AutoCounter
			if shouldRun then
				if not CounterLoopConnection then
					CounterLoopConnection = RunService.RenderStepped:Connect(CounterLoopAction)
				end
			else
				if CounterLoopConnection then
					CounterLoopConnection:Disconnect()
					CounterLoopConnection = nil
				end
			end
		end
		
		local function bindPlayer(plr)
			if plr == player then return end
			if AnimWatch[plr] then disconnectPack(AnimWatch[plr]) end
			ActiveCounterPacks[plr] = nil
			ActiveBlockPacks[plr] = nil
			AnimWatch[plr] = { activeTracks = {}, blockTracks = {} }
			local function bindCharacter(char)
				local pack = AnimWatch[plr]
				if not pack then return end
				if pack.humConn then pack.humConn:Disconnect() pack.humConn = nil end
				if pack.animConn then pack.animConn:Disconnect() pack.animConn = nil end
				do
					local old = pack.activeTracks
					if old then
						for track, info in pairs(old) do
							if info then
								info.isActionActive = false
								if info.EnemyRoot then RaycastTrack[info.EnemyRoot] = nil EnemyMotionTrack[info.EnemyRoot] = nil end
								if info.__counted then info.__counted = nil if UpdateCounterLoopState then UpdateCounterLoopState(-1) end end
							end
						end
					end
				end
				pack.activeTracks = {}
				pack.blockTracks = {}
				if not char then return end
				local hum = char:FindFirstChildOfClass("Humanoid")
				if not hum then
					pack.humConn = char.ChildAdded:Connect(function(ch)
						if ch:IsA("Humanoid") then
							if pack.humConn then pack.humConn:Disconnect() pack.humConn = nil end
							bindCharacter(char)
						end
					end)
					return
				end
				local animator = hum:FindFirstChildOfClass("Animator")
				if not animator then
					pack.humConn = hum.ChildAdded:Connect(function(ch)
						if ch:IsA("Animator") then
							if pack.humConn then pack.humConn:Disconnect() pack.humConn = nil end
							bindCharacter(char)
						end
					end)
					return
				end
				pack.animConn = animator.AnimationPlayed:Connect(function(track)
					onEnemyTrackStarted(plr, char, hum, track)
				end)
			end
			bindCharacter(plr.Character)
			AnimWatch[plr].charConn = plr.CharacterAdded:Connect(bindCharacter)
		end
		
		for _, plr in ipairs(Players:GetPlayers()) do bindPlayer(plr) end
		Players.PlayerAdded:Connect(bindPlayer)
		Players.PlayerRemoving:Connect(function(plr)
			local pack = AnimWatch[plr]
			if pack then disconnectPack(pack) AnimWatch[plr] = nil ActiveCounterPacks[plr] = nil ActiveBlockPacks[plr] = nil end
		end)
		
		getgenv().SetAutoBlock = function(v)
			getgenv().AutoBlocking = v
			if not v then fireF(false) end
			UpdateCounterLoopState(0)
		end
		
		getgenv().SetAutoCounter = function(v)
			getgenv().AutoCounter = v
			UpdateCounterLoopState(0)
		end
		
		getgenv().SetAutoBlockDist = function(v) getgenv().AutoBlockDist = tostring(v) end
		getgenv().SetAutoCounterDist = function(v) getgenv().AutoCounterDist = tostring(v) end
		getgenv().SetUseDeathMoves = function(v) getgenv().UseDeathMoves = v end
		getgenv().SetAimbotWhileBlocking = function(v) getgenv().AimbotWhileBlocking = v end
		getgenv().SetAutoM1AfterBlock = function(v) getgenv().AutoM1AfterBlock = v end
		getgenv().SetSoundParry = function(v) getgenv().SoundParry = v end
		getgenv().SetM1Interval = function(v) getgenv().M1Interval = v end
		getgenv().SetM1Count = function(v) getgenv().M1Count = v end
		getgenv().SetBlockReleaseDelay = function(v) getgenv().BlockReleaseDelay = v end
		
		if Tabs and Tabs.Block then
			AutoBlockSec = Tabs.Block:Section({Opened = true, Box = true, BoxBorder = true, Title = "Auto Block & Counter", Icon = "shield" })
			AutoBlockSec:Toggle({
				Title = "Auto Block",
				Flag = "abc_best_block",
				Value = getgenv().AutoBlocking,
				Callback = function(v) getgenv().AutoBlocking = v UpdateCounterLoopState(0) end
			})
			AutoBlockSec:Toggle({
				Title = "Auto Counter",
				Flag = "abc_best_counter",
				Value = getgenv().AutoCounter,
				Callback = function(v) getgenv().AutoCounter = v UpdateCounterLoopState(0) end
			})
			AutoBlockSec:Toggle({
				Title = "Face Threat",
				Flag = "abc_best_face",
				Value = getgenv().AimbotWhileBlocking,
				Callback = function(v) getgenv().AimbotWhileBlocking = v end
			})
			AutoBlockSec:Toggle({
				Title = "Sound Parry",
				Flag = "abc_best_sound",
				Value = getgenv().SoundParry,
				Callback = function(v) getgenv().SoundParry = v end
			})
			AutoBlockSec:Toggle({
				Title = "Use Death Moves",
				Flag = "abc_best_death",
				Value = getgenv().UseDeathMoves,
				Callback = function(v) getgenv().UseDeathMoves = v end
			})
			AutoBlockSec:Slider({
				Title = "Block Distance",
				Flag = "abc_best_blockdist",
				Min = 5,
				Max = 50,
				Default = tonumber(getgenv().AutoBlockDist) or 19.5,
				Decimals = 1,
				Callback = function(v) getgenv().AutoBlockDist = tostring(v) UpdateCounterLoopState(0) end
			})
			AutoBlockSec:Slider({
				Title = "Counter Distance",
				Flag = "abc_best_counterdist",
				Min = 5,
				Max = 50,
				Default = tonumber(getgenv().AutoCounterDist) or 19.5,
				Decimals = 1,
				Callback = function(v) getgenv().AutoCounterDist = tostring(v) UpdateCounterLoopState(0) end
			})
			AutoBlockSec:Slider({
				Title = "Block Release Delay",
				Flag = "abc_best_blockrelease",
				Min = 0,
				Max = 1,
				Default = tonumber(getgenv().BlockReleaseDelay) or 0.6,
				Decimals = 2,
				Callback = function(v) getgenv().BlockReleaseDelay = v end
			})
		end
	end)
end













-- ================ EMOTE0 TAB0 ================ --
function EmoteTab()
	task.spawn(function()
		LimitedEmotesSec = Tabs.Emote:Section({Opened = true, Box = true, BoxBorder = true, Title = "Buy Limited Emotes", Icon = "star" })
		
		MarketplaceService = game:GetService("MarketplaceService")
		ReplicatedStorage = game:GetService("ReplicatedStorage")
		Players = game:GetService("Players")
		LocalPlayer = Players.LocalPlayer
		
		
		local success_info, Info = pcall(function()
		    return require(ReplicatedStorage:WaitForChild("Info"))
		end)
		
		if not success_info or not Info or not Info.Limited then
		    return
		end
		
		local productNameToIdMap = {}
		for _, itemInfo in pairs(Info.Limited) do
		    productNameToIdMap[itemInfo.Name] = itemInfo.ID
		end
		
		local success_products, developerProducts = pcall(function()
		    return MarketplaceService:GetDeveloperProductsAsync():GetCurrentPage()
		end)
		
		if success_products and developerProducts then
		    for _, product in ipairs(developerProducts) do
		        if productNameToIdMap[product.Name] then
		            
		            local NewButton = LimitedEmotesSec:Button({
		                Title = product.Name .. " (" .. product.PriceInRobux .. " R$)",
		                Callback = function()
		                    local giftData = {
		                        {
		                            Goal = "Gift Gamepass",
		                            GiftData = {
		                                Receiver = LocalPlayer.UserId, 
		                                Gamepass = product.ProductId
		                            }
		                        }
		                    }
		
		                    local character = LocalPlayer.Character
		                    local communicate = character and character:FindFirstChild("Communicate")
		                    
		                    if communicate then
		                        communicate:FireServer(unpack(giftData))
		                    else
		                    end
		                end
		            })
		
		            local targetUI = NewButton.Element or NewButton.Instance
		
		            if targetUI and product.IconImageAssetId then
		                local Icon = Instance.new("ImageLabel")
		                Icon.Name = "RightSideIcon"
		                Icon.Parent = targetUI
		               
		                Icon.Size = UDim2.new(0, 26, 0, 26) 
		                Icon.AnchorPoint = Vector2.new(1, 0.5) 
		                Icon.Position = UDim2.new(1, -10, 0.5, 0)
		                Icon.BackgroundTransparency = 1
		                Icon.Image = "rbxassetid://" .. tostring(product.IconImageAssetId)
		                Icon.ZIndex = targetUI.ZIndex + 1 
		                
		                local UICorner = Instance.new("UICorner")
		                UICorner.CornerRadius = UDim.new(0, 4)
		                UICorner.Parent = Icon
		            end
		        end
		    end
		end
		
		
		
		
		
		
		CSLimitedEmotesex = Tabs.Emote:Section({Opened = true, Box = true, BoxBorder = true, Title = "Client Side Limited Emotes", Icon = "star" })
		
		Players = game:GetService("Players")
		TweenService = game:GetService("TweenService")
		ReplicatedStorage = game:GetService("ReplicatedStorage")
		CollectionService = game:GetService("CollectionService")
		Debris = game:GetService("Debris")
		LocalPlayer = Players.LocalPlayer
		local function PlayEmote(cfg)
		    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		    local humanoid = character:WaitForChild("Humanoid")
		    local anim = Instance.new("Animation")
		    anim.AnimationId = cfg.animId:find("rbxassetid://") and cfg.animId
		                       or ("rbxassetid://" .. cfg.animId)
		    humanoid:LoadAnimation(anim):Play()
		    for _, s in ipairs(cfg.sounds or {}) do
		        task.delay(s.Delay or 0, function()
		            local sound = Instance.new("Sound")
		            sound.SoundId = s.SoundId
		            sound.Volume = s.Volume or 1
		            sound.Looped = s.Looped or false
		            sound.Parent = character:FindFirstChild("Torso")
		                          or character:FindFirstChild("HumanoidRootPart")
		                          or workspace
		            sound:Play()
		        end)
		    end
		    task.delay(0.1, function()
		        local bind
		        if cfg.useFolderBind then
		            bind = Instance.new("Folder")
		            bind.Name = cfg.accName or "PrideBind"
		        else
		            bind = Instance.new("Accessory")
		            bind.Name = cfg.accName or ("#EmoteHolder_" .. math.random(1, 100000))
		        end
		        bind:SetAttribute("EmoteProperty", true)
		        bind.Parent = character
		        if cfg.useCollection then
		            CollectionService:AddTag(bind, "emoteendstuff" .. character.Name)
		        end
		        require(ReplicatedStorage.Emotes.VFX):MainFunction({
		            Character = character,
		            vfxName = cfg.vfxName,
		            SpecificModule = ReplicatedStorage.Emotes.VFX,
		            AnimSent = tonumber(cfg.animId:match("%d+")),
		            RealBind = bind,
		            NoInsertion = cfg.noInsertion or nil,
		            Colour = cfg.colour or nil,
		            CanRotate = cfg.canRotate or nil,
		        })
		        if cfg.auraSetup and cfg.postDelay then
		            task.delay(cfg.postDelay, function()
		                if bind and bind.Parent then
		                    cfg.auraSetup(character, bind)
		                end
		            end)
		        end
		    end)
		end
		local EmoteList = {
		    {
		        Title = "Final Stand",
		        animId = "rbxassetid://113876851900426",
		        vfxName = "Final Stand",
		        postDelay = 9,
		        auraSetup = function(character)
		            if not workspace:FindFirstChild("Live") then return end
		            if not workspace.Live:FindFirstChild(character.Name) then return end
		            local sounds = {
		                { SoundId = "rbxassetid://112446641141594", Volume = 1 },
		                { SoundId = "rbxassetid://98080224862986", Volume = 0.3 },
		            }
		            for _, info in ipairs(sounds) do
		                local s = Instance.new("Sound")
		                s.SoundId = info.SoundId
		                s.Volume = info.Volume
		                s.Looped = true
		                s.Parent = character:FindFirstChild("Torso")
		                          or character:FindFirstChild("HumanoidRootPart")
		                s:Play()
		                task.delay(60, function()
		                    TweenService:Create(s, TweenInfo.new(0.5), { Volume = 0 }):Play()
		                    task.delay(0.75, function() if s then s:Destroy() end end)
		                end)
		            end
		            local auraClone = ReplicatedStorage.Emotes.VFX.VfxMods.FS.vfx.Aura:Clone()
		            for _, part in ipairs(auraClone:GetChildren()) do
		                local target = (part.Name == "HumanoidRootPart")
		                    and (character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart"))
		                    or character:FindFirstChild(part.Name)
		                if target then
		                    for _, fx in ipairs(part:GetChildren()) do
		                        if fx:IsA("ParticleEmitter") then fx.LockedToPart = true end
		                        fx:SetAttribute("LimitedAura", true)
		                        fx.Parent = target
		                        task.delay(60, function()
		                            if fx:IsA("ParticleEmitter") then fx.Enabled = false
		                            else
		                                for _, sub in ipairs(fx:GetChildren()) do
		                                    if sub:IsA("ParticleEmitter") then sub.Enabled = false end
		                                end
		                            end
		                        end)
		                        task.delay(65, function() if fx then fx:Destroy() end end)
		                    end
		                end
		            end
		            auraClone:Destroy()
		        end,
		    },
		    {
		        Title = "Inner Rage",
		        animId = "rbxassetid://96993907314948",
		        vfxName = "Energy Explosion",
		        useCollection = true,
		        noInsertion = true,
		        colour = Color3.fromRGB(
		            math.random(0,255), math.random(0,255), math.random(0,255)
		        ),
		        _useDirectCallback = true,
		    },
		    {
		        Title = "Shadow Eruption",
		        animId = "rbxassetid://121032789756540",
		        vfxName = "Shadow Eruption",
		        sounds = {
		            { SoundId = "rbxassetid://117425361961655", Volume = 0, Delay = 0 },
		        },
		        postDelay = 8.1,
		        auraSetup = function(character)
		            if not workspace:FindFirstChild("Live") then return end
		            if not workspace.Live:FindFirstChild(character.Name) then return end
		            auraSource = ReplicatedStorage:WaitForChild("Emotes"):WaitForChild("AuraNew")
		            auraFolder = Instance.new("Folder")
		            auraFolder.Name = "AuraHolder"
		            auraFolder.Parent = character
		            for _, part in ipairs(auraSource:GetChildren()) do
		                local charPart = character:FindFirstChild(part.Name)
		                if charPart then
		                    clone = part:Clone()
		                    clone.Parent = auraFolder
		                    clone:SetAttribute("LimitedAura", true)
		                    task.delay(65, function() if clone then clone:Destroy() end end)
		                    for _, fx in ipairs(clone:GetDescendants()) do
		                        if fx:IsA("Trail") or fx:IsA("Beam") or fx:IsA("ParticleEmitter") then
		                            fx.Enabled = true
		                            task.delay(60, function() if fx then fx.Enabled = false end end)
		                        end
		                    end
		                end
		            end
		            local loopSound = Instance.new("Sound")
		            loopSound.SoundId = "rbxassetid://128082194939921"
		            loopSound.Looped = true
		            loopSound.Volume = 1
		            loopSound.Parent = character:FindFirstChild("Torso")
		                             or character:FindFirstChild("HumanoidRootPart")
		            loopSound:Play()
		            Debris:AddItem(loopSound, 80)
		            task.delay(60, function()
		                TweenService:Create(loopSound, TweenInfo.new(1), { Volume = 0 }):Play()
		                Debris:AddItem(loopSound, 1.2)
		                for _, v in ipairs(character:GetDescendants()) do
		                    if v:GetAttribute("aura") and
		                       (v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail")) then
		                        v.Enabled = false
		                        Debris:AddItem(v, 5)
		                    end
		                end
		            end)
		        end,
		    },
		    {
		        Title = "Divine Form",
		        animId = "rbxassetid://116187503451999",
		        vfxName = "Divine Form",
		        postDelay = 7,
		        auraSetup = function(character)
		            if not workspace:FindFirstChild("Live") then return end
		            if not workspace.Live:FindFirstChild(character.Name) then return end
		            function applyAura(char, duration)
		                auraSource = ReplicatedStorage.Emotes.VFX.VfxMods.Evolved.vfx.Folder
		                folder = Instance.new("Folder")
		                folder.Name = "AuraHolder"
		                folder:SetAttribute("DivineForm", true)
		                folder:SetAttribute("LimAura", true)
		                folder:SetAttribute("EmoteEffect", true)
		                folder.Parent = char
		                for _, obj in ipairs(auraSource:GetChildren()) do
		                    if obj:IsA("BasePart") then
		                        bodyPart = char:FindFirstChild(obj.Name)
		                        if bodyPart then
		                            clone = obj:Clone()
		                            clone.Transparency = 1
		                            clone.Massless = true
		                            clone.Name = tostring(math.random(1, 1000))
		                            clone:SetAttribute("LimAura", true)
		                            clone.Parent = folder
		                            local weld = Instance.new("Weld")
		                            weld.Part0 = bodyPart
		                            weld.Part1 = clone
		                            weld.Parent = clone
		                            for _, fx in ipairs(clone:GetDescendants()) do
		                                if fx:IsA("ParticleEmitter") or fx:IsA("Beam") then
		                                    fx:SetAttribute("LimitedAura", true)
		                                    task.delay(duration, function() if fx then fx:Destroy() end end)
		                                    task.delay(duration - 2, function() if fx then fx.Enabled = false end end)
		                                end
		                            end
		                            task.delay(duration, function() if clone and clone.Parent then clone:Destroy() end end)
		                        end
		                    end
		                end
		            end
		            applyAura(character, 4)
		            task.spawn(function()
		                task.wait(0.14)
		                applyAura(character, 244)
		            end)
		        end,
		    },
		    {
		        Title = "The Strongest",
		        animId = "rbxassetid://86505219150915",
		        vfxName = "Boss Raid",
		        useFolderBind = true,
		        accName = "PrideBind",
		        sounds = {
		            { SoundId = "rbxassetid://117787451950766", Volume = 2, Delay = 0 },
		            { SoundId = "rbxassetid://97998065677521", Volume = 1.85, Delay = 0.01 },
		            { SoundId = "rbxassetid://99535007576182", Volume = 2, Delay = 2.29, Looped = true },
		        },
		    },
		    {
		        Title = "Boundless Rage",
		        animId = "rbxassetid://107649573628906",
		        vfxName = "Boundless Rage",
		        postDelay = 4,
		        auraSetup = function(character)
		            auraTemplate = ReplicatedStorage.Emotes.VFX.VfxMods.Boundless.vfx.AuraChar:Clone()
		            Debris:AddItem(auraTemplate, 5)
		            noRot = character:FindFirstChild("NoRotate")
		            if noRot then noRot:Destroy() end
		            sound = Instance.new("Sound")
		            sound.SoundId = "rbxassetid://81055990581650"
		            sound.Looped = true
		            sound.Volume = 1
		            sound.Name = "CrushEmoteAmbience"
		            sound.Parent = character:FindFirstChild("HumanoidRootPart")
		                          or character:FindFirstChild("Torso")
		                          or character
		            sound:Play()
		            for _, part in ipairs(auraTemplate:GetChildren()) do
		                if part:IsA("BasePart") then
		                    charPart = character:FindFirstChild(part.Name)
		                    if charPart then
		                        for _, obj in ipairs(part:GetChildren()) do
		                            if obj:IsA("Attachment") or obj:IsA("ParticleEmitter") then
		                                clone = obj:Clone()
		                                clone:SetAttribute("LimitedAura", true)
		                                clone.Parent = charPart
		                                task.delay(60, function()
		                                    TweenService:Create(sound, TweenInfo.new(0.5), { Volume = 0 }):Play()
		                                    task.delay(0.75, function()
		                                        if sound and sound.Parent then sound:Destroy() end
		                                    end)
		                                    if clone:IsA("ParticleEmitter") then
		                                        clone.Enabled = false
		                                    else
		                                        for _, fx in ipairs(clone:GetChildren()) do
		                                            if fx:IsA("ParticleEmitter") or fx:IsA("Beam") then
		                                                fx.Enabled = false
		                                            end
		                                        end
		                                    end
		                                end)
		                                task.delay(65, function()
		                                    if clone and clone.Parent then clone:Destroy() end
		                                end)
		                            end
		                        end
		                    end
		                end
		            end
		            auraTemplate:Destroy()
		        end,
		    },
		    {
		        Title = "The Fallen",
		        animId = "rbxassetid://133818134745501",
		        vfxName = "Pride",
		        canRotate = true,
		        accName = "DismantleEffect",
		        sounds = {
		            { SoundId = "rbxassetid://93369149563360", Volume = 2, Delay = 0.1 },
		        },
		    },
		    {
		        Title = "True Aura",
		        animId = "rbxassetid://103668868712897",
		        vfxName = "True Aura",
		        useCollection = true,
		        sounds = {
		            { SoundId = "rbxassetid://83049960731792", Volume = 3, Delay = 0.1 },
		        },
		    },
		}
		function InnerRageCallback()
		    character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		    humanoid = character:WaitForChild("Humanoid")
		    baseColor = Color3.fromRGB(
		        math.random(100,255), math.random(50,150), math.random(50,150)
		    )
		    randColor = Color3.fromRGB(
		        math.random(0,255), math.random(0,255), math.random(0,255)
		    )
		    local trackAnim = Instance.new("Animation")
		    trackAnim.AnimationId = "rbxassetid://96993907314948"
		    local track = humanoid:LoadAnimation(trackAnim)
		    track:Play()
		    track.Stopped:Connect(function()
		        local loopAnim = Instance.new("Animation")
		        loopAnim.AnimationId = "rbxassetid://127234845846317"
		        humanoid:LoadAnimation(loopAnim):Play()
		    end)
		    acc = Instance.new("Accessory")
		    acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
		    acc.Parent = character
		    CollectionService:AddTag(acc, "emoteendstuff" .. character.Name)
		    require(ReplicatedStorage.Emotes.VFX):MainFunction({
		        Character = character,
		        vfxName = "Energy Explosion",
		        AnimSent = 96993907314948,
		        RealBind = acc,
		        NoInsertion = true,
		        Colour = randColor,
		    })
		    fxList = {}
		    task.delay(1.3, function()
		        if not acc.Parent then return end
		        hairHandles = {}
		        for _, child in ipairs(character.FakeHead:GetChildren()) do
		            if child:IsA("Accessory") and child:FindFirstChild("Handle")
		               and child.Handle:FindFirstChild("HairAttachment") then
		                handle = child.Handle
		                table.insert(hairHandles, handle)
		                for _, mesh in ipairs(handle:GetChildren()) do
		                    if mesh:IsA("SpecialMesh") then
		                        mesh:SetAttribute("basetext", mesh.TextureId)
		                    end
		                end
		            end
		        end
		        for _, hair in ipairs(hairHandles) do
		            clone = hair:Clone()
		            weld = Instance.new("Weld")
		            weld.Part0 = clone
		            weld.Part1 = hair
		            weld.Parent = clone
		            clone.Parent = workspace.Thrown
		            hair.Transparency = 1
		            TweenService:Create(hair, TweenInfo.new(0.25), { Transparency = 0 }):Play()
		            mesh = hair:FindFirstChildOfClass("SpecialMesh")
		            if mesh then
		                mesh.TextureId = ""
		                glow = ReplicatedStorage.Resources.DeathEffect.Template:Clone()
		                glow.Color3 = Color3.new(baseColor.R*5, baseColor.G*5, baseColor.B*5)
		                glow.Parent = clone
		            end
		        end
		        auraHolder = Instance.new("Folder")
		        auraHolder.Name = "AuraHolder"
		        auraHolder:SetAttribute("LimAura", true)
		        auraHolder:SetAttribute("EmoteEffect", true)
		        auraHolder.Parent = character
		        task.delay(203, function() if auraHolder then auraHolder:Destroy() end end)
		        for _, obj in ipairs(ReplicatedStorage.Emotes.AuraReal:GetChildren()) do
		            clone = obj:Clone()
		            clone:SetAttribute("LimAura", true)
		            if clone:IsA("Attachment") then
		                clone.Parent = character.PrimaryPart
		            else
		                weld = Instance.new("Weld")
		                weld.Part0 = character.PrimaryPart
		                weld.Part1 = clone
		                weld.Parent = clone
		            end
		            for _, fx in ipairs(clone:GetDescendants()) do
		                if fx:IsA("ParticleEmitter") or fx:IsA("PointLight") then
		                    fx.Enabled = false
		                    fx:SetAttribute("LimitedAura", true)
		                    fx:SetAttribute("InnerRageAura", true)
		                    if fx:IsA("ParticleEmitter") then fx.Color = ColorSequence.new(baseColor) end
		                    if fx:IsA("PointLight") then fx.Color = baseColor; fx.Brightness = 1.3 end
		                    table.insert(fxList, fx)
		                end
		            end
		            task.delay(203, function() if clone then clone:Destroy() end end)
		        end
		    end)
		    task.delay(5.3, function()
		        if not acc.Parent then return end
		        for _, fx in ipairs(fxList) do fx.Enabled = true end
		        task.wait(0.05)
		        for _, t in ipairs(humanoid:GetPlayingAnimationTracks()) do
		            if t.Animation.AnimationId == "rbxassetid://127234845846317" then
		                t:Stop()
		                finalAnim = Instance.new("Animation")
		                finalAnim.AnimationId = "rbxassetid://117177504280717"
		                humanoid:LoadAnimation(finalAnim):Play()
		            end
		        end
		    end)
		end
		for _, emote in ipairs(EmoteList) do
		    CSLimitedEmotesex:Button({
		        Title = emote.Title,
		        Icon = "mouse-pointer-click",
		        IconAlign = "Right",
		        Locked = false,
		        LockedTitle = "Locked",
		        Justify = "Between",
		        Callback = emote._useDirectCallback
		            and InnerRageCallback
		            or function() PlayEmote(emote) end,
		    })
		end
		
	end)
end





-- ================ PREMIUM0 TAB0 ================ --
function PremiumTab()
	task.spawn(function()
		local AboutPremSec = Tabs.Prem:Section({Opened = true, Box = true, BoxBorder = true, Title = "About Premium", Icon = "star"})
		AboutPremSec:Paragraph({
		    Title = "Premium Features Include:",
		    Desc = "• Keyless Script\n• All Premium Features\n• Premium Special Discord Role\n• Able to make up to 3 Premium Roblox Acc and change accounts later from the website",
		    Image = "bot",
		    ImageSize = 30
		})
		
		AboutPremSec:Paragraph({
		    Title = "How To Buy Premium:",
		    Desc = "You can buy from the Discord server of the VexonHub With 500 robux",
		    Image = "bot",
		    ImageSize = 30
		})
		
		local PremCmds = Tabs.Prem:Section({Opened = true, Box = true, BoxBorder = true, Title = "Autos", Icon = "star"})
		PremCmds:Paragraph({
		    Title = "Commands Of Premium:",
		    Desc = "YOU CAN USE THIS COMMANDS TO FREE USERS IF YOU HAS PREMIUM",
			Image = "bot",
		    ImageSize = 30
		})
		
		
		
		local RunService = game:GetService("RunService")

		local espEnabled = false
		local espBoxes   = {}
		
		local function removeESP(plr)
		    if espBoxes[plr] then
		        if espBoxes[plr].conn then espBoxes[plr].conn:Disconnect() end
		        if espBoxes[plr].billboard and espBoxes[plr].billboard.Parent then
		            espBoxes[plr].billboard:Destroy()
		        end
		        espBoxes[plr] = nil
		    end
		end
		
		local vexonUsers = {}
		vexonUsers[LocalPlayer] = true
		
		task.spawn(function()
		    local usernames = loadWhitelist()
		    for _, plr in ipairs(Players:GetPlayers()) do
		        if usernames[string.lower(plr.Name)] then
		            vexonUsers[plr] = true
		        end
		    end
		end)
		
		local PING_ANIM_ID = "16719053698"
		
		local function sendPing()
		    local char = LocalPlayer.Character
		    if not char then return end
		    local hum = char:FindFirstChild("Humanoid")
		    if not hum then return end
		    local animator = hum:FindFirstChildOfClass("Animator")
		    if not animator then return end
		    local anim = Instance.new("Animation")
		    anim.AnimationId = "rbxassetid://" .. PING_ANIM_ID
		    local track = animator:LoadAnimation(anim)
		    track:Play()
		    task.delay(0.2, function() track:Stop(); anim:Destroy() end)
		end
		
		local function setupHandshake(plr)
		    if plr == LocalPlayer then return end
		    local function connectAnim(char)
		        local hum = char:WaitForChild("Humanoid", 5)
		        if not hum then return end
		        local animator = hum:WaitForChild("Animator", 5)
		        if not animator then return end
		        animator.AnimationPlayed:Connect(function(track)
		            if not track or not track.Animation then return end
		            local id = tostring(track.Animation.AnimationId):match("%d+")
		            if id == PING_ANIM_ID then
		                vexonUsers[plr] = true
		                removeESP(plr)
		            end
		        end)
		    end
		    plr.CharacterAdded:Connect(function(char) task.spawn(connectAnim, char) end)
		    if plr.Character then task.spawn(connectAnim, plr.Character) end
		end
		
		local function createESP(plr)
		    if plr == LocalPlayer then return end
		    if isPlayerWhitelisted(plr) then return end
		    if espBoxes[plr] then return end
		
		    local billboard = Instance.new("BillboardGui")
		    billboard.Name = "VexonESP"
		    billboard.AlwaysOnTop = true
		    billboard.Size = UDim2.new(0, 130, 0, 44)
		    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
		    billboard.ResetOnSpawn = false
		
		    local nameLabel = Instance.new("TextLabel", billboard)
		    nameLabel.Size = UDim2.new(1, 0, 0.55, 0)
		    nameLabel.BackgroundTransparency = 1
		    nameLabel.Text = plr.Name
		    nameLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
		    nameLabel.TextStrokeTransparency = 0.4
		    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		    nameLabel.Font = Enum.Font.GothamBold
		    nameLabel.TextSize = 14
		    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
		
		    local distLabel = Instance.new("TextLabel", billboard)
		    distLabel.Size = UDim2.new(1, 0, 0.45, 0)
		    distLabel.Position = UDim2.new(0, 0, 0.55, 0)
		    distLabel.BackgroundTransparency = 1
		    distLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
		    distLabel.TextStrokeTransparency = 0.4
		    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		    distLabel.Font = Enum.Font.Gotham
		    distLabel.TextSize = 12
		    distLabel.TextXAlignment = Enum.TextXAlignment.Center
		
		    local conn = RunService.RenderStepped:Connect(function()
		        if not plr.Character then distLabel.Text = "? studs"; return end
		        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
		        if not hrp then distLabel.Text = "? studs"; return end
		        billboard.Adornee = hrp
		        if billboard.Parent ~= hrp then billboard.Parent = hrp end
		        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		            local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
		            distLabel.Text = dist .. " studs"
		        end
		
		        local hum = plr.Character:FindFirstChild("Humanoid")
		        if hum then
		            local hp = math.floor(hum.Health)
		            local maxhp = math.floor(hum.MaxHealth)
		            nameLabel.Text = plr.Name .. " [" .. hp .. "/" .. maxhp .. "]"
		        else
		            nameLabel.Text = plr.Name
		        end
		    end)
		
		    espBoxes[plr] = {billboard = billboard, conn = conn}
		end
		
		local function refreshAllESP()
		    for plr, _ in pairs(espBoxes) do removeESP(plr) end
		    if not espEnabled then return end
		    for _, plr in ipairs(Players:GetPlayers()) do
		        createESP(plr)
		    end
		end
		
		local function PlayAndStop(animID)
		    local char = LocalPlayer.Character
		    if not char then return end
		    local Humanoid = char:FindFirstChild("Humanoid")
		    if not Humanoid then return end
		    local Animator = Humanoid:FindFirstChildOfClass("Animator")
		    if not Animator then return end
		    local anim = Instance.new("Animation")
		    anim.AnimationId = "rbxassetid://" .. animID
		    local track = Animator:LoadAnimation(anim)
		    track:Play()
		    task.delay(0, function()
		        track:Stop()
		        anim:Destroy()
		    end)
		end
		
		for _, plr in ipairs(Players:GetPlayers()) do
		    setupHandshake(plr)
		    plr.CharacterAdded:Connect(function() task.wait(1); if espEnabled then createESP(plr) end end)
		    if plr.Character and espEnabled then createESP(plr) end
		end
		
		Players.PlayerAdded:Connect(function(plr)
		    if isPlayerWhitelisted(plr) then
		        vexonUsers[plr] = true
		    end
		    setupHandshake(plr)
		    plr.CharacterAdded:Connect(function() task.wait(1); if espEnabled then createESP(plr) end end)
		    task.spawn(function() task.wait(1); sendPing() end)
		end)
		
		Players.PlayerRemoving:Connect(function(plr)
		    vexonUsers[plr] = nil
		    removeESP(plr)
		end)
		
		LocalPlayer.CharacterAdded:Connect(function()
		    task.wait(2); sendPing()
		end)
		if LocalPlayer.Character then task.spawn(function() task.wait(2); sendPing() end) end
		
		PremCmds:Toggle({
		    Title = "ESP VH Users",
		    Desc = "Shows name, HP and distance on free VexonHub players",
		    Default = false,
		    Callback = function(state)
		        espEnabled = state
		        if state then
		            refreshAllESP()
		            WindUI:Notify({Title="ESP",Content="ESP enabled on free users",Duration=2,Icon="eye"})
		        else
		            for plr, _ in pairs(espBoxes) do removeESP(plr) end
		            WindUI:Notify({Title="ESP",Content="ESP disabled",Duration=2,Icon="eye-off"})
		        end
		    end
		})
		
		PremCmds:Button({Title="Kick",           Desc="Kicks the target",                 Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16725337143") end})
		PremCmds:Button({Title="Kill",           Desc="Kills the target",                 Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16719220174") end})
		PremCmds:Button({Title="Bring",          Desc="Brings target to you",             Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16725350277") end})
		PremCmds:Button({Title="Black Screen",   Desc="Black screen for 10s",             Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16719226293") end})
		PremCmds:Button({Title="Unblack",        Desc="Removes black screen",             Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16719205513") end})
		PremCmds:Button({Title="Freeze",         Desc="Freezes target for 10 seconds",    Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16719183472") end})
		PremCmds:Button({Title="Jumpscare",      Desc="Jumpscares the target",            Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16725167915") end})
		PremCmds:Button({Title="Sound Spam",     Desc="Ear grape for 10 seconds",         Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16725121777") end})
		PremCmds:Button({Title="Launch",         Desc="Flings target into the sky",       Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16719149848") end})
		PremCmds:Button({Title="Spin",           Desc="Spins target camera for 10s",      Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("16719107050") end})
		PremCmds:Button({Title="Flip",           Desc="Flips character upside down 10s",  Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("17086298638") end})
		PremCmds:Button({Title="Slow Mo",        Desc="Sets walkspeed to 2 for 10s",      Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("13874287198") end})
		PremCmds:Button({Title="Ragdoll",        Desc="Forces ragdoll for 5s",            Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("17086423985") end})
		PremCmds:Button({Title="No Jump",        Desc="Disables jump for 10s",            Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("17097068597") end})
		PremCmds:Button({Title="Disco",          Desc="Flashes random colors for 10s",    Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("15099756132") end})
		PremCmds:Button({Title="Giant",          Desc="Makes character huge for 10s",     Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("17097745294") end})
		PremCmds:Button({Title="Tiny",           Desc="Shrinks character for 10s",        Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("17086333563") end})
		PremCmds:Button({Title="Invert Screen",  Desc="Inverts screen colors for 10s",    Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("35654637")    end})
		PremCmds:Button({Title="Zoom In",        Desc="Locks camera zoomed in for 10s",   Locked = LockedStatus, LockedTitle = "Premium", Callback=function() PlayAndStop("17086054994") end})
	end)
end














 
-- ================ LITE0 TAB0 ================ --
-- ================ CONFIG0 TAB0 ================ --










-- ================ CONFIG0 TAB0 ================ --
function ConfigTab()
	task.spawn(function()
		local ConfigSec = Tabs.Config:Section({Opened = true, Box = true, BoxBorder = true, Title = "Config", Icon = "star"})
		ConfigManager = Window.ConfigManager
		
		configName = ""
		
		ConfigSec:Input({
		    Title = "Config Name",
		    Value = configName,
		    Type = "Input",
		    Placeholder = "Enter name...",
		    Callback = function(input) 
		        configName = input
		    end
		})
		ConfigSec:Button({
		    Title = "Create",
		    Icon = "",
		    Justify = "Center",
		    Callback = function()
		        ConfigManager:CreateConfig(configName):Save()
		    end
		})
		
		ConfigSec:Space()
		
		
		ConfigList = ConfigSec:Dropdown({
		    Title = "Config List",
		    Values = ConfigManager:AllConfigs(),
		    Value = nil,
		    AllowNone = true,
		    Callback = function(option)
		        Window.CurrentConfig = ConfigManager:Config(option)
		    end
		})
		ConfigSec:Button({
		    Title = "Refresh Config List",
		    Icon = "",
		    Justify = "Center",
		    Callback = function()
		        ConfigList:Refresh(ConfigManager:AllConfigs())
		    end
		})
		ConfigSec:Button({
		    Title = "Load",
		    Icon = "",
		    Justify = "Center",
		    Callback = function()
		        Window.CurrentConfig:Load()
		    end
		})
		ConfigSec:Button({
		    Title = "Save",
		    Icon = "",
		    Justify = "Center",
		    Callback = function()
		        Window.CurrentConfig:Save()
		    end
		})
		ConfigSec:Button({
		    Title = "Delete",
		    Icon = "",
		    Justify = "Center",
		    Callback = function()
		        Window.CurrentConfig:Delete()
		    end
		})	
	end)
end

LoadVexonHub()

end

end

executorResult = checkExecutorSupport()
StartNormalVersion()
