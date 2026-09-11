local KavoLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoLib.CreateLib("datdaykits Premium Hub", "DarkTheme")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Steal Eggs")

getgenv().AutoSteal = false
getgenv().TweenSpeed = 65
local LocalPlayer = game:GetService("Players").LocalPlayer

local function startEggStealer()
    local TweenService = game:GetService("TweenService")
    
    task.spawn(function()
        while getgenv().AutoSteal do
            local EggHolder = workspace:FindFirstChild("Eggs") 
                or workspace:FindFirstChild("EggFolder") 
                or workspace:FindFirstChild("SpawnedEggs")

            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

            if HumanoidRootPart and EggHolder then
                for _, egg in pairs(EggHolder:GetChildren()) do
                    if not getgenv().AutoSteal then break end

                    if egg:IsA("BasePart") or (egg:IsA("Model") and egg.PrimaryPart) then
                        local targetCFrame = egg:IsA("BasePart") and egg.CFrame or egg.PrimaryPart.CFrame
                        local distance = (HumanoidRootPart.Position - targetCFrame.Position).Magnitude

                        local tweenInfo = TweenInfo.new(distance / getgenv().TweenSpeed, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})

                        tween:Play()
                        tween.Completed:Wait()
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

MainSection:NewToggle("Auto Steal", "Tự động nhặt trứng", function(state)
    getgenv().AutoSteal = state
    if state then
        startEggStealer()
    end
end)

-- Phím tắt để Ẩn/Hiện Menu (mặc định là phím RightControl bên phải bàn phím)
MainSection:NewKeybind("g", "f", Enum.KeyCode.RightControl, function()
    KavoLib:ToggleUI()
end)
