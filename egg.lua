local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()
local Window = OrionLib:MakeWindow({Name = "datdaykits Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "RobloxScriptConfig"})
getgenv().AutoSteal = false
getgenv().TweenSpeed = 50
local function startTweenSteal()
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local EggFolder = workspace:FindFirstChild("Eggs") or workspace 
    task.spawn(function()
        while getgenv().AutoSteal do
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart and EggFolder then
                for _, egg in pairs(EggFolder:GetChildren()) do
                    if getgenv().AutoSteal == false then break end
                    if egg:IsA("BasePart") or (egg:IsA("Model") and egg.PrimaryPart) then
                        local targetCFrame = egg:IsA("BasePart") and egg.CFrame or egg.PrimaryPart.CFrame
                        local distance = (HumanoidRootPart.Position - targetCFrame.Position).Magnitude
                        local duration = distance / getgenv().TweenSpeed
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
                        tween:Play()
                        tween.Completed:Wait()
                        task.wait(0.2)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end
local MainTab = Window:MakeTab({Name = "Main Hack", Icon = "rbxassetid://4483345998", Premium = false})
MainTab:AddToggle({
    Name = "Auto Collect Eggs (Tween)",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSteal = Value
        if Value then startTweenSteal() end
    end    
})
MainTab:AddSlider({
    Name = "Tween Speed",
    Min = 10, Max = 150, Default = 50, Color = Color3.fromRGB(255,255,255), Increment = 5, ValueName = "Speed",
    Callback = function(Value) getgenv().TweenSpeed = Value end    
})
OrionLib:Init()
