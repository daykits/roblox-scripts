-- ========================================
-- GET KEY MENU - datkits Hub (GIAO DIỆN XANH ĐEN)
-- Key đúng: daykits-vip
-- ========================================

local SCRIPT_URL = "https://raw.githubusercontent.com/daykits/IdkQqw-Project-Open-Z-source/refs/heads/main/selec" -- 🔥 THAY LINK NÀY
local VALID_KEY = "nokey"

-- 🔥 Link lấy key (Discord, website, v.v.)
local GETKEY_URL = "https://discord.gg/RGYAuHX9j"        -- 🔥 THAY LINK NÀY
local GETKEY_TYPE = "discord"  -- "discord" hoặc "web"

local SAVE_FOLDER = "datkits_hub"
local SAVE_FILE = SAVE_FOLDER .. "/key.txt"

-- ========================================
-- 0. TẠO FOLDER SAVE
-- ========================================
if makefolder and not isfolder(SAVE_FOLDER) then
    pcall(function() makefolder(SAVE_FOLDER) end)
end

-- ========================================
-- 1. HÀM XỬ LÝ KEY
-- ========================================
local function SaveKey(key)
    if not writefile then return false end
    local ok = pcall(function() writefile(SAVE_FILE, key) end)
    return ok
end

local function LoadKey()
    if not (isfile and readfile) then return nil end
    if not isfile(SAVE_FILE) then return nil end
    local ok, data = pcall(function() return readfile(SAVE_FILE) end)
    if ok and data then return data end
    return nil
end

local function ClearKey()
    if delfile and isfile(SAVE_FILE) then
        pcall(function() delfile(SAVE_FILE) end)
    end
end

-- ========================================
-- 2. TẠO GUI
-- ========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("datkits_KeySystem") then
    CoreGui.datkits_KeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "datkits_KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 9999
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ========================================
-- 3. MAIN FRAME (XANH ĐEN)
-- ========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 18, 14) -- Đen pha xanh lá cực tối
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 128) -- Viền xanh neon
Stroke.Thickness = 2
Stroke.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 30, 20)), -- Xanh rêu đậm
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 10, 8)),  -- Đen sâu thẳm
})
Gradient.Rotation = 90
Gradient.Parent = MainFrame

-- ========================================
-- 4. TITLE / SUBTITLE
-- ========================================
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "🔑 KEY:nokey"
Title.TextColor3 = Color3.fromRGB(0, 255, 128) -- Xanh neon
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 55)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Nhập key để sử dụng script"
Subtitle.TextColor3 = Color3.fromRGB(150, 180, 160) -- Xám pha xanh nhạt
Subtitle.TextSize = 13
Subtitle.Font = Enum.Font.Gotham
Subtitle.Parent = MainFrame

-- ========================================
-- 5. INPUT BOX
-- ========================================
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(0.85, 0, 0, 45)
InputFrame.Position = UDim2.new(0.075, 0, 0, 95)
InputFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 18) -- Xanh đen nhạt hơn chút
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputFrame

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(30, 70, 45) -- Viền xanh rêu
InputStroke.Thickness = 1
InputStroke.Parent = InputFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 1, 0)
TextBox.Position = UDim2.new(0, 15, 0, 0)
TextBox.BackgroundTransparency = 1
TextBox.Text = ""
TextBox.PlaceholderText = "Nhập key tại đây..."
TextBox.PlaceholderColor3 = Color3.fromRGB(80, 120, 90)
TextBox.TextColor3 = Color3.fromRGB(0, 255, 128) -- Chữ nhập vào màu xanh neon
TextBox.TextSize = 15
TextBox.Font = Enum.Font.Gotham
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.ClearTextOnFocus = false
TextBox.Parent = InputFrame

-- ========================================
-- 6. CHECKBOX "LƯU KEY"
-- ========================================
local SaveCheckFrame = Instance.new("Frame")
SaveCheckFrame.Size = UDim2.new(0.85, 0, 0, 25)
SaveCheckFrame.Position = UDim2.new(0.075, 0, 0, 148)
SaveCheckFrame.BackgroundTransparency = 1
SaveCheckFrame.Parent = MainFrame

local SaveCheckbox = Instance.new("TextButton")
SaveCheckbox.Size = UDim2.new(0, 18, 0, 18)
SaveCheckbox.Position = UDim2.new(0, 0, 0, 3)
SaveCheckbox.BackgroundColor3 = Color3.fromRGB(15, 25, 18)
SaveCheckbox.BorderSizePixel = 0
SaveCheckbox.Text = ""
SaveCheckbox.AutoButtonColor = false
SaveCheckbox.Parent = SaveCheckFrame

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 4)
CheckCorner.Parent = SaveCheckbox

local CheckStroke = Instance.new("UIStroke")
CheckStroke.Color = Color3.fromRGB(30, 70, 45)
CheckStroke.Thickness = 1
CheckStroke.Parent = SaveCheckbox

local CheckMark = Instance.new("TextLabel")
CheckMark.Size = UDim2.new(1, 0, 1, 0)
CheckMark.BackgroundTransparency = 1
CheckMark.Text = "✓"
CheckMark.TextColor3 = Color3.fromRGB(0, 255, 128) -- Dấu tick xanh neon
CheckMark.TextSize = 16
CheckMark.Font = Enum.Font.GothamBold
CheckMark.Visible = false
CheckMark.Parent = SaveCheckbox

local SaveCheckLabel = Instance.new("TextLabel")
SaveCheckLabel.Size = UDim2.new(1, -25, 1, 0)
SaveCheckLabel.Position = UDim2.new(0, 25, 0, 0)
SaveCheckLabel.BackgroundTransparency = 1
SaveCheckLabel.Text = "Lưu key cho lần sau"
SaveCheckLabel.TextColor3 = Color3.fromRGB(150, 180, 160)
SaveCheckLabel.TextSize = 13
SaveCheckLabel.Font = Enum.Font.Gotham
SaveCheckLabel.TextXAlignment = Enum.TextXAlignment.Left
SaveCheckLabel.Parent = SaveCheckFrame

local saveKeyChecked = true

local function UpdateCheckbox()
    if saveKeyChecked then
        CheckMark.Visible = true
        CheckStroke.Color = Color3.fromRGB(0, 255, 128)
        SaveCheckbox.BackgroundColor3 = Color3.fromRGB(20, 40, 25) 
    else
        CheckMark.Visible = false
        CheckStroke.Color = Color3.fromRGB(30, 70, 45)
        SaveCheckbox.BackgroundColor3 = Color3.fromRGB(15, 25, 18)
    end
end
UpdateCheckbox()

SaveCheckbox.MouseButton1Click:Connect(function()
    saveKeyChecked = not saveKeyChecked
    UpdateCheckbox()
end)

-- ========================================
-- 7. STATUS LABEL
-- ========================================
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.85, 0, 0, 25)
StatusLabel.Position = UDim2.new(0.075, 0, 0, 180)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Parent = MainFrame

-- ========================================
-- 8. NÚT "GET KEY" + "CHECK KEY" (2 nút ngang nhau)
-- ========================================
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0.85, 0, 0, 45)
ButtonContainer.Position = UDim2.new(0.075, 0, 0, 210)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- 🔹 Nút GET KEY (bên trái, 40% chiều rộng)
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.4, -5, 1, 0)
GetKeyButton.Position = UDim2.new(0, 0, 0, 0)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(20, 80, 50)  -- Xanh lá đậm
GetKeyButton.BorderSizePixel = 0
GetKeyButton.Text = "🔗 GET KEY"
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.TextSize = 15
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.Parent = ButtonContainer

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyButton

-- 🔹 Nút CHECK KEY (bên phải, 60% chiều rộng)
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.6, -5, 1, 0)
Button.Position = UDim2.new(0.4, 5, 0, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Xanh lá sáng (Nút chính)
Button.BorderSizePixel = 0
Button.Text = "🔓 KIỂM TRA KEY"
Button.TextColor3 = Color3.fromRGB(5, 10, 8) -- Chữ màu đen để nổi bật trên nền xanh
Button.TextSize = 15
Button.Font = Enum.Font.GothamBold
Button.Parent = ButtonContainer

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = Button

-- ========================================
-- 9. NÚT XÓA KEY ĐÃ LƯU
-- ========================================
local ClearButton = Instance.new("TextButton")
ClearButton.Size = UDim2.new(0, 100, 0, 20)
ClearButton.Position = UDim2.new(1, -110, 0, 268)
ClearButton.BackgroundTransparency = 1
ClearButton.Text = "🗑 Xóa key đã lưu"
ClearButton.TextColor3 = Color3.fromRGB(120, 80, 80) -- Màu đỏ tối
ClearButton.TextSize = 11
ClearButton.Font = Enum.Font.Gotham
ClearButton.Parent = MainFrame

ClearButton.MouseButton1Click:Connect(function()
    ClearKey()
    StatusLabel.Text = "🗑 Đã xóa key đã lưu"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
end)

-- ========================================
-- 10. FOOTER
-- ========================================
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1
Footer.Text = "© datkits Hub • by datdaykits"
Footer.TextColor3 = Color3.fromRGB(50, 80, 65) -- Xám xanh
Footer.TextSize = 11
Footer.Font = Enum.Font.Gotham
Footer.Parent = MainFrame

-- ========================================
-- 11. ANIMATION
-- ========================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 320)
}):Play()

-- ========================================
-- 12. LOGIC CHÍNH
-- ========================================
local isChecking = false
local isUnlocked = false

local function ShowStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
end

local function ShakeFrame()
    local originalPos = MainFrame.Position
    for i = 1, 5 do
        MainFrame.Position = originalPos + UDim2.new(0, (i % 2 == 0 and 8 or -8), 0, 0)
        task.wait(0.03)
    end
    MainFrame.Position = originalPos
end

local function UnlockScript()
    isUnlocked = true
    ShowStatus("✅ Key hợp lệ! Đang tải script...", Color3.fromRGB(80, 255, 80))
    Button.Text = "✅ ĐANG TẢI..."
    Button.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
    Button.Active = false
    GetKeyButton.Active = false

    task.wait(0.8)

    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()

    task.wait(0.5)
    ScreenGui:Destroy()

    local success, err = pcall(function()
        local source = game:HttpGet(SCRIPT_URL)
        local func, loadErr = loadstring(source)
        if not func then
            error("Loadstring thất bại: " .. tostring(loadErr))
        end
        func()
    end)

    if not success then
        warn("[datkits Hub] Lỗi load script:", err)
        local errGui = Instance.new("ScreenGui")
        errGui.Parent = CoreGui
        local errFrame = Instance.new("Frame")
        errFrame.Size = UDim2.new(0, 400, 0, 100)
        errFrame.Position = UDim2.new(0.5, -200, 0.5, -50)
        errFrame.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
        errFrame.BorderSizePixel = 0
        errFrame.Parent = errGui
        local errCorner = Instance.new("UICorner")
        errCorner.CornerRadius = UDim.new(0, 10)
        errCorner.Parent = errFrame
        local errText = Instance.new("TextLabel")
        errText.Size = UDim2.new(1, -20, 1, -20)
        errText.Position = UDim2.new(0, 10, 0, 10)
        errText.BackgroundTransparency = 1
        errText.Text = "❌ Lỗi khi tải script:\n" .. tostring(err)
        errText.TextColor3 = Color3.fromRGB(255, 100, 100)
        errText.TextSize = 13
        errText.Font = Enum.Font.Gotham
        errText.TextWrapped = true
        errText.Parent = errFrame
        task.delay(5, function() errGui:Destroy() end)
    end
end

local function CheckKey(isAuto)
    if isChecking or isUnlocked then return end
    isChecking = true

    local inputKey = TextBox.Text

    if not isAuto then
        ShowStatus("⏳ Đang kiểm tra key...", Color3.fromRGB(255, 200, 50))
        Button.Text = "⏳ ĐANG KIỂM TRA..."
        Button.Active = false
        task.wait(0.6)
    end

    if inputKey == VALID_KEY then
        if saveKeyChecked and not isAuto then
            local saved = SaveKey(inputKey)
            if saved then
                ShowStatus("✅ Key đúng! Đã lưu key.", Color3.fromRGB(80, 255, 80))
            else
                ShowStatus("✅ Key đúng! (Không lưu được key)", Color3.fromRGB(255, 200, 100))
            end
        end
        UnlockScript()
    else
        ShowStatus("❌ Key không hợp lệ! Vui lòng thử lại.", Color3.fromRGB(255, 80, 80))
        ShakeFrame()
        Button.Text = "🔓 KIỂM TRA KEY"
        Button.Active = true
        TextBox.Text = ""
    end

    isChecking = false
end

-- ========================================
-- 13. XỬ LÝ NÚT GET KEY
-- ========================================
local function OpenGetKey()
    ShowStatus("🔗 Đang mở link lấy key...", Color3.fromRGB(0, 255, 128))

    if GETKEY_TYPE == "discord" then
        if setclipboard then
            pcall(function() setclipboard(GETKEY_URL) end)
        end

        local popupGui = Instance.new("ScreenGui")
        popupGui.Name = "datkits_GetKeyPopup"
        popupGui.ResetOnSpawn = false
        popupGui.DisplayOrder = 10000
        pcall(function() popupGui.Parent = CoreGui end)
        if not popupGui.Parent then
            popupGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end

        local PopupFrame = Instance.new("Frame")
        PopupFrame.Size = UDim2.new(0, 380, 0, 220)
        PopupFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
        PopupFrame.BackgroundColor3 = Color3.fromRGB(12, 22, 16) -- Xanh đen
        PopupFrame.BorderSizePixel = 0
        PopupFrame.Parent = popupGui

        local PopupCorner = Instance.new("UICorner")
        PopupCorner.CornerRadius = UDim.new(0, 12)
        PopupCorner.Parent = PopupFrame

        local PopupStroke = Instance.new("UIStroke")
        PopupStroke.Color = Color3.fromRGB(0, 200, 100) -- Viền xanh
        PopupStroke.Thickness = 2
        PopupStroke.Parent = PopupFrame

        local PopupTitle = Instance.new("TextLabel")
        PopupTitle.Size = UDim2.new(1, 0, 0, 40)
        PopupTitle.Position = UDim2.new(0, 0, 0, 15)
        PopupTitle.BackgroundTransparency = 1
        PopupTitle.Text = "🔗 LẤY KEY TẠI DISCORD"
        PopupTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
        PopupTitle.TextSize = 16
        PopupTitle.Font = Enum.Font.GothamBold
        PopupTitle.Parent = PopupFrame

        local PopupLink = Instance.new("TextBox")
        PopupLink.Size = UDim2.new(0.85, 0, 0, 40)
        PopupLink.Position = UDim2.new(0.075, 0, 0, 65)
        PopupLink.BackgroundColor3 = Color3.fromRGB(20, 35, 25) -- Nền xanh rêu
        PopupLink.BorderSizePixel = 0
        PopupLink.Text = GETKEY_URL
        PopupLink.TextColor3 = Color3.fromRGB(0, 255, 128) -- Chữ xanh
        PopupLink.TextSize = 12
        PopupLink.Font = Enum.Font.Gotham
        PopupLink.TextEditable = false
        PopupLink.ClearTextOnFocus = false
        PopupLink.Parent = PopupFrame

        local LinkCorner = Instance.new("UICorner")
        LinkCorner.CornerRadius = UDim.new(0, 6)
        LinkCorner.Parent = PopupLink

        local PopupInfo = Instance.new("TextLabel")
        PopupInfo.Size = UDim2.new(0.85, 0, 0, 40)
        PopupInfo.Position = UDim2.new(0.075, 0, 0, 110)
        PopupInfo.BackgroundTransparency = 1
        PopupInfo.Text = "📋 Link đã được copy vào clipboard.\nDán vào trình duyệt để lấy key!"
        PopupInfo.TextColor3 = Color3.fromRGB(150, 180, 160)
        PopupInfo.TextSize = 12
        PopupInfo.Font = Enum.Font.Gotham
        PopupInfo.TextWrapped = true
        PopupInfo.Parent = PopupFrame

        local PopupClose = Instance.new("TextButton")
        PopupClose.Size = UDim2.new(0.85, 0, 0, 35)
        PopupClose.Position = UDim2.new(0.075, 0, 0, 165)
        PopupClose.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Nút xanh
        PopupClose.BorderSizePixel = 0
        PopupClose.Text = "✓ ĐÃ HIỂU"
        PopupClose.TextColor3 = Color3.fromRGB(5, 10, 8) -- Chữ đen
        PopupClose.TextSize = 14
        PopupClose.Font = Enum.Font.GothamBold
        PopupClose.Parent = PopupFrame

        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 8)
        CloseCorner.Parent = PopupClose

        PopupClose.MouseButton1Click:Connect(function()
            popupGui:Destroy()
        end)

    elseif GETKEY_TYPE == "web" then
        if setclipboard then
            pcall(function() setclipboard(GETKEY_URL) end)
        end
        ShowStatus("🔗 Đã copy link! Dán vào trình duyệt.", Color3.fromRGB(0, 255, 128))
    end
end

-- ========================================
-- 14. SỰ KIỆN
-- ========================================
Button.MouseButton1Click:Connect(function() CheckKey(false) end)
GetKeyButton.MouseButton1Click:Connect(OpenGetKey)

TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then CheckKey(false) end
end)

-- Hover effects (Nút Check Key)
Button.MouseEnter:Connect(function()
    if not isUnlocked then
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 255, 128) -- Sáng lên khi hover
        }):Play()
    end
end)
Button.MouseLeave:Connect(function()
    if not isUnlocked then
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        }):Play()
    end
end)

-- Hover effects (Nút Get Key)
GetKeyButton.MouseEnter:Connect(function()
    if not isUnlocked then
        TweenService:Create(GetKeyButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 120, 75) -- Sáng lên khi hover
        }):Play()
    end
end)
GetKeyButton.MouseLeave:Connect(function()
    if not isUnlocked then
        TweenService:Create(GetKeyButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(20, 80, 50)
        }):Play()
    end
end)

-- ========================================
-- 15. AUTO CHECK KEY ĐÃ LƯU
-- ========================================
task.spawn(function()
    local savedKey = LoadKey()
    if savedKey and savedKey == VALID_KEY then
        ShowStatus("🔑 Đã tìm thấy key đã lưu, đang mở khóa...", Color3.fromRGB(80, 255, 80))
        TextBox.Text = savedKey
        task.wait(0.5)
        CheckKey(true)
    elseif savedKey then
        ClearKey()
        ShowStatus("⚠ Key đã lưu không còn hợp lệ. Vui lòng nhập lại.", Color3.fromRGB(255, 200, 100))
    else
        ShowStatus("💡 Nhập key hoặc nhấn GET KEY để lấy key", Color3.fromRGB(150, 180, 160))
    end
end)
