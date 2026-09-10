-- Load Orion Library (Giao diện Menu)
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- Tạo cửa sổ Menu chính (Tên menu hiển thị trong game)
local Window = OrionLib:MakeWindow({
    Name = "datdaykits Hub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "RobloxScriptConfig"
})

-- Biến kiểm tra trạng thái Bật/Tắt của chức năng
getgenv().AutoSteal = false
getgenv().TweenSpeed = 50 -- Tốc độ di chuyển mặc định

-- PHẦN 1: Hàm dịch chuyển nhân vật đến chỗ trứng (An toàn hơn)
local function startTweenSteal()
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Bạn hãy sửa chữ "Eggs" thành tên thư mục chứa trứng chính xác của game bạn chơi
    local EggFolder = workspace:FindFirstChild("Eggs") or workspace 

    task.spawn(function()
        while getgenv().AutoSteal do
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            
            if HumanoidRootPart and EggFolder then
                -- Tìm quả trứng gần nhất hoặc quả trứng đầu tiên trong thư mục
                for _, egg in pairs(EggFolder:GetChildren()) do
                    if getgenv().AutoSteal == false then break end
                    
                    -- Kiểm tra xem vật phẩm có phải là trứng hoặc có vùng chạm (TouchInterest) không
                    if egg:IsA("BasePart") or (egg:IsA("Model") and egg.PrimaryPart) then
                        local targetCFrame = egg:IsA("BasePart") and egg.CFrame or egg.PrimaryPart.CFrame
                        local distance = (HumanoidRootPart.Position - targetCFrame.Position).Magnitude
                        local duration = distance / getgenv().TweenSpeed
                        
                        -- Tạo hiệu ứng di chuyển mượt mà (Tween) để tránh bị hệ thống quét hack bay màu
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
                        tween:Play()
                        tween.Completed:Wait()
                        task.wait(0.2) -- Nghỉ một chút sau khi nhặt xong 1 quả
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

-- PHẦN 2: Tạo các mục hiển thị trên Menu giao diện
local MainTab = Window:MakeTab({
    Name = "Main Hack",
    Icon = "rbxassetid://4483345998",
    Premium = false
})

-- Nút bật/tắt (Toggle) Auto Steal Eggs
MainTab:AddToggle({
    Name = "Auto Collect Eggs (Tween)",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSteal = Value
        if Value then
            startTweenSteal()
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Auto Steal has been ACTIVATED!",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Auto Steal has been DISABLED.",
                Time = 3
            })
        end
    end    
})

-- Thanh trượt (Slider) điều chỉnh tốc độ di chuyển
MainTab:AddSlider({
    Name = "Tween Speed",
    Min = 10,
    Max = 150,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 5,
    ValueName = "Speed",
    Callback = function(Value)
        getgenv().TweenSpeed = Value
    end    
})

-- Khởi tạo Menu thành công
OrionLib:Init()
