local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local guiService = game:GetService("GuiService")
local coreGui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")
local virtualInputManager = game:GetService("VirtualInputManager")

local function makeTextLabel()
  local function makeTextLabel2()
    local v1 = {}
    v1.ironiteion = Instance.new("ScreenGui")
    v1.ironiteion.Name = "Patch Hub"
    v1.ironiteion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v1.mainFrame = Instance.new("CanvasGroup")
    v1.mainFrame.Name = "MainFrame"
    v1.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.mainFrame.BackgroundColor3 = Color3.fromRGB(19, 20, 25)
    v1.mainFrame.ClipsDescendants = true
    v1.mainFrame.Position = UDim2.fromScale(0.5, 0.5)
    v1.mainFrame.Size = UDim2.fromOffset(695, 489)
    v1.uICorner = Instance.new("UICorner")
    v1.uICorner.Name = "UICorner"
    v1.uICorner.CornerRadius = UDim.new(0, 11)
    v1.uICorner.Parent = v1.mainFrame
    v1.header = Instance.new("Frame")
    v1.header.Name = "Header"
    v1.header.AnchorPoint = Vector2.new(0.5, 0)
    v1.header.BackgroundTransparency = 1
    v1.header.Position = UDim2.fromScale(0.5, 0)
    v1.header.Size = UDim2.fromOffset(695, 37)
    v1.liner = Instance.new("Frame")
    v1.liner.Name = "Liner"
    v1.liner.AnchorPoint = Vector2.new(0, 1)
    v1.liner.BackgroundColor3 = Color3.fromRGB(31, 31, 45)
    v1.liner.BorderColor3 = Color3.new()
    v1.liner.BorderSizePixel = 0
    v1.liner.Position = UDim2.fromScale(0, 1)
    v1.liner.Size = UDim2.new(1, 1, 0, 2)
    v1.liner.Parent = v1.header
    v1.libaryIcon = Instance.new("ImageLabel")
    v1.libaryIcon.Name = "LibaryIcon"
    v1.libaryIcon.AnchorPoint = Vector2.new(0, 0.5)
    v1.libaryIcon.BackgroundTransparency = 1
    v1.libaryIcon.Image = "rbxassetid://108488788823423"
    v1.libaryIcon.Position = UDim2.new(0, 12, 0.5, 0)
    v1.libaryIcon.ScaleType = Enum.ScaleType.Fit
    v1.libaryIcon.Size = UDim2.fromOffset(15, 15)
    v1.libaryName = Instance.new("TextLabel")
    v1.libaryName.Name = "Libary_Name"
    v1.libaryName.AnchorPoint = Vector2.new(0, 0.5)
    v1.libaryName.AutomaticSize = Enum.AutomaticSize.XY
    v1.libaryName.BackgroundTransparency = 1

    v1.libaryName.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.libaryName.Position = UDim2.new(0, 32, 0.5, 0)
    v1.libaryName.RichText = true
    v1.libaryName.Size = UDim2.fromOffset(1, 1)
    v1.libaryName.Text = "Patch Hub"
    v1.libaryName.TextColor3 = Color3.new(1, 1, 1)
    v1.libaryName.TextSize = 14
    v1.libaryName.Parent = v1.libaryIcon
    v1.libaryIcon.Parent = v1.header
    v1.lastUpdated = Instance.new("TextLabel")
    v1.lastUpdated.Name = "Last_Updated"
    v1.lastUpdated.AnchorPoint = Vector2.new(1, 0.5)
    v1.lastUpdated.AutomaticSize = Enum.AutomaticSize.XY
    v1.lastUpdated.BackgroundTransparency = 1
    v1.lastUpdated.FontFace = Font.new("rbxassetid://12187365364")
    v1.lastUpdated.Position = UDim2.new(1, -12, 0.5, 0)
    v1.lastUpdated.RichText = true
    v1.lastUpdated.Size = UDim2.fromOffset(1, 1)
    v1.lastUpdated.Text = "UI Library"
    v1.lastUpdated.TextColor3 = Color3.new(1, 1, 1)
    v1.lastUpdated.TextSize = 12
    v1.icon = Instance.new("ImageLabel")
    v1.icon.Name = "Icon"
    v1.icon.AnchorPoint = Vector2.new(0, 0.5)
    v1.icon.BackgroundTransparency = 1
    v1.icon.Image = "rbxassetid://84304363968016"
    v1.icon.Position = UDim2.new(0, -22, 0.5, 0)
    v1.icon.Size = UDim2.fromOffset(15, 15)
    v1.icon.Parent = v1.lastUpdated
    v1.lastUpdated.Parent = v1.header
    v1.header.Parent = v1.mainFrame
    v1.sidebar = Instance.new("Frame")
    v1.sidebar.Name = "Sidebar"
    v1.sidebar.AnchorPoint = Vector2.new(0, 1)
    v1.sidebar.BackgroundTransparency = 1
    v1.sidebar.Position = UDim2.fromScale(0, 1)
    v1.sidebar.Size = UDim2.fromOffset(75, 453)
    v1.liner1 = Instance.new("Frame")
    v1.liner1.Name = "Liner"
    v1.liner1.AnchorPoint = Vector2.new(1, 0.5)
    v1.liner1.BackgroundColor3 = Color3.fromRGB(31, 31, 45)
    v1.liner1.BorderColor3 = Color3.new()
    v1.liner1.BorderSizePixel = 0
    v1.liner1.Position = UDim2.fromScale(1, 0.5)
    v1.liner1.Size = UDim2.new(0, 2, 1, 0)
    v1.liner1.Parent = v1.sidebar
    v1.holder = Instance.new("Frame")
    v1.holder.Name = "Holder"
    v1.holder.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.holder.BackgroundTransparency = 1
    v1.holder.Position = UDim2.fromScale(0.5, 0.5)
    v1.holder.Size = UDim2.fromOffset(75, 453)
    v1.tab = Instance.new("Frame")
    v1.tab.Name = "Tab"
    v1.tab.BackgroundColor3 = Color3.fromRGB(247, 247, 247)
    v1.tab.BackgroundTransparency = 0.9
    v1.tab.ClipsDescendants = true
    v1.tab.Size = UDim2.fromOffset(55, 60)
    v1.uICorner1 = Instance.new("UICorner")
    v1.uICorner1.Name = "UICorner"
    v1.uICorner1.CornerRadius = UDim.new(0, 5)
    v1.uICorner1.Parent = v1.tab
    v1.frame = Instance.new("Frame")
    v1.frame.Name = "Frame"
    v1.frame.AnchorPoint = Vector2.new(0.5, 1)
    v1.frame.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.frame.Position = UDim2.new(0.5, 0, 1, 3)
    v1.frame.Size = UDim2.fromOffset(25, 6)
    v1.uICorner2 = Instance.new("UICorner")
    v1.uICorner2.Name = "UICorner"
    v1.uICorner2.CornerRadius = UDim.new(0, 12)
    v1.uICorner2.Parent = v1.frame
    v1.uIGradient = Instance.new("UIGradient")
    v1.uIGradient.Name = "UIGradient"

    v1.uIGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient.Parent = v1.frame
    v1.frame.Parent = v1.tab
    v1.icon1 = Instance.new("ImageLabel")
    v1.icon1.Name = "Icon"
    v1.icon1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.icon1.BackgroundTransparency = 1
    v1.icon1.Image = "rbxassetid://80869096876893"
    v1.icon1.Position = UDim2.new(0.5, 0, 0.5, -8)
    v1.icon1.Size = UDim2.fromOffset(24, 22)
    v1.textLabel = Instance.new("TextLabel")
    v1.textLabel.Name = "TextLabel"
    v1.textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.textLabel.AutomaticSize = Enum.AutomaticSize.XY
    v1.textLabel.BackgroundTransparency = 1

    v1.textLabel.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal
    )

    v1.textLabel.Position = UDim2.new(0.5, 0, 0.5, 20)
    v1.textLabel.Size = UDim2.new(1, 1, 1, 1)
    v1.textLabel.Text = "Main"
    v1.textLabel.TextColor3 = Color3.new(1, 1, 1)
    v1.textLabel.TextSize = 12
    v1.textLabel.Parent = v1.icon1
    v1.icon1.Parent = v1.tab
    v1.uIGradient1 = Instance.new("UIGradient")
    v1.uIGradient1.Name = "UIGradient"

    v1.uIGradient1.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient1.Parent = v1.tab
    v1.tab.Parent = v1.holder
    v1.uIListLayout = Instance.new("UIListLayout")
    v1.uIListLayout.Name = "UIListLayout"
    v1.uIListLayout.Padding = UDim.new(0, 5)
    v1.uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    v1.uIListLayout.Parent = v1.holder
    v1.uIPadding = Instance.new("UIPadding")
    v1.uIPadding.Name = "UIPadding"
    v1.uIPadding.PaddingLeft = UDim.new(0, 9)
    v1.uIPadding.PaddingTop = UDim.new(0, 10)
    v1.uIPadding.Parent = v1.holder
    v1.divider = Instance.new("Frame")
    v1.divider.Name = "Divider"
    v1.divider.BackgroundTransparency = 1
    v1.divider.ClipsDescendants = true
    v1.divider.Position = UDim2.fromScale(0, 0.988713)
    v1.divider.Size = UDim2.fromOffset(55, 5)
    v1.uICorner3 = Instance.new("UICorner")
    v1.uICorner3.Name = "UICorner"
    v1.uICorner3.CornerRadius = UDim.new(0, 5)
    v1.uICorner3.Parent = v1.divider
    v1.divider.Parent = v1.holder
    v1.tab1 = Instance.new("Frame")
    v1.tab1.Name = "Tab"
    v1.tab1.BackgroundTransparency = 1
    v1.tab1.ClipsDescendants = true
    v1.tab1.Size = UDim2.fromOffset(55, 60)
    v1.uICorner4 = Instance.new("UICorner")
    v1.uICorner4.Name = "UICorner"
    v1.uICorner4.CornerRadius = UDim.new(0, 5)
    v1.uICorner4.Parent = v1.tab1
    v1.icon2 = Instance.new("ImageLabel")
    v1.icon2.Name = "Icon"
    v1.icon2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.icon2.BackgroundTransparency = 1
    v1.icon2.Image = "rbxassetid://88848642017283"
    v1.icon2.ImageColor3 = Color3.fromRGB(69, 71, 90)
    v1.icon2.Position = UDim2.new(0.5, 0, 0.5, -8)
    v1.icon2.Size = UDim2.fromOffset(24, 22)
    v1.textLabel1 = Instance.new("TextLabel")
    v1.textLabel1.Name = "TextLabel"
    v1.textLabel1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.textLabel1.AutomaticSize = Enum.AutomaticSize.XY
    v1.textLabel1.BackgroundTransparency = 1

    v1.textLabel1.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal
    )

    v1.textLabel1.Position = UDim2.new(0.5, 0, 0.5, 20)
    v1.textLabel1.Size = UDim2.new(1, 1, 1, 1)
    v1.textLabel1.Text = "Visuals"
    v1.textLabel1.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.textLabel1.TextSize = 12
    v1.textLabel1.Parent = v1.icon2
    v1.icon2.Parent = v1.tab1
    v1.tab1.Parent = v1.holder
    v1.divider1 = Instance.new("Frame")
    v1.divider1.Name = "Divider"
    v1.divider1.BackgroundTransparency = 1
    v1.divider1.ClipsDescendants = true
    v1.divider1.Position = UDim2.fromScale(0, 0.988713)
    v1.divider1.Size = UDim2.fromOffset(55, 5)
    v1.uICorner5 = Instance.new("UICorner")
    v1.uICorner5.Name = "UICorner"
    v1.uICorner5.CornerRadius = UDim.new(0, 5)
    v1.uICorner5.Parent = v1.divider1
    v1.frame1 = Instance.new("Frame")
    v1.frame1.Name = "Frame"
    v1.frame1.AnchorPoint = Vector2.new(0.5, 1)
    v1.frame1.BackgroundColor3 = Color3.fromRGB(31, 31, 45)
    v1.frame1.Position = UDim2.new(0.5, 0, 1, 3)
    v1.frame1.Size = UDim2.fromOffset(25, 6)
    v1.uICorner6 = Instance.new("UICorner")
    v1.uICorner6.Name = "UICorner"
    v1.uICorner6.CornerRadius = UDim.new(0, 12)
    v1.uICorner6.Parent = v1.frame1
    v1.frame1.Parent = v1.divider1
    v1.divider1.Parent = v1.holder
    v1.tab2 = Instance.new("Frame")
    v1.tab2.Name = "Tab"
    v1.tab2.BackgroundTransparency = 1
    v1.tab2.ClipsDescendants = true
    v1.tab2.Size = UDim2.fromOffset(55, 60)
    v1.uICorner7 = Instance.new("UICorner")
    v1.uICorner7.Name = "UICorner"
    v1.uICorner7.CornerRadius = UDim.new(0, 5)
    v1.uICorner7.Parent = v1.tab2
    v1.icon3 = Instance.new("ImageLabel")
    v1.icon3.Name = "Icon"
    v1.icon3.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.icon3.BackgroundTransparency = 1
    v1.icon3.Image = "rbxassetid://83371760923777"
    v1.icon3.ImageColor3 = Color3.fromRGB(69, 71, 90)
    v1.icon3.Position = UDim2.new(0.5, 0, 0.5, -8)
    v1.icon3.Size = UDim2.fromOffset(24, 22)
    v1.textLabel2 = Instance.new("TextLabel")
    v1.textLabel2.Name = "TextLabel"
    v1.textLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.textLabel2.AutomaticSize = Enum.AutomaticSize.XY
    v1.textLabel2.BackgroundTransparency = 1

    v1.textLabel2.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal
    )

    v1.textLabel2.Position = UDim2.new(0.5, 0, 0.5, 20)
    v1.textLabel2.Size = UDim2.new(1, 1, 1, 1)
    v1.textLabel2.Text = "Rage"
    v1.textLabel2.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.textLabel2.TextSize = 12
    v1.textLabel2.Parent = v1.icon3
    v1.icon3.Parent = v1.tab2
    v1.tab2.Parent = v1.holder
    v1.divider2 = Instance.new("Frame")
    v1.divider2.Name = "Divider"
    v1.divider2.BackgroundTransparency = 1
    v1.divider2.ClipsDescendants = true
    v1.divider2.Position = UDim2.fromScale(0, 0.988713)
    v1.divider2.Size = UDim2.fromOffset(55, 5)
    v1.uICorner8 = Instance.new("UICorner")
    v1.uICorner8.Name = "UICorner"
    v1.uICorner8.CornerRadius = UDim.new(0, 5)
    v1.uICorner8.Parent = v1.divider2
    v1.frame2 = Instance.new("Frame")
    v1.frame2.Name = "Frame"
    v1.frame2.AnchorPoint = Vector2.new(0.5, 1)
    v1.frame2.BackgroundColor3 = Color3.fromRGB(31, 31, 45)
    v1.frame2.Position = UDim2.new(0.5, 0, 1, 3)
    v1.frame2.Size = UDim2.fromOffset(25, 6)
    v1.uICorner9 = Instance.new("UICorner")
    v1.uICorner9.Name = "UICorner"
    v1.uICorner9.CornerRadius = UDim.new(0, 12)
    v1.uICorner9.Parent = v1.frame2
    v1.frame2.Parent = v1.divider2
    v1.divider2.Parent = v1.holder
    v1.tab3 = Instance.new("Frame")
    v1.tab3.Name = "Tab"
    v1.tab3.BackgroundTransparency = 1
    v1.tab3.ClipsDescendants = true
    v1.tab3.Size = UDim2.fromOffset(55, 60)
    v1.uICorner10 = Instance.new("UICorner")
    v1.uICorner10.Name = "UICorner"
    v1.uICorner10.CornerRadius = UDim.new(0, 5)
    v1.uICorner10.Parent = v1.tab3
    v1.icon4 = Instance.new("ImageLabel")
    v1.icon4.Name = "Icon"
    v1.icon4.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.icon4.BackgroundTransparency = 1
    v1.icon4.Image = "rbxassetid://107815780127396"
    v1.icon4.ImageColor3 = Color3.fromRGB(69, 71, 90)
    v1.icon4.Position = UDim2.new(0.5, 0, 0.5, -8)
    v1.icon4.Size = UDim2.fromOffset(24, 22)
    v1.textLabel3 = Instance.new("TextLabel")
    v1.textLabel3.Name = "TextLabel"
    v1.textLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.textLabel3.AutomaticSize = Enum.AutomaticSize.XY
    v1.textLabel3.BackgroundTransparency = 1

    v1.textLabel3.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal
    )

    v1.textLabel3.Position = UDim2.new(0.5, 0, 0.5, 20)
    v1.textLabel3.Size = UDim2.new(1, 1, 1, 1)
    v1.textLabel3.Text = "World"
    v1.textLabel3.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.textLabel3.TextSize = 12
    v1.textLabel3.Parent = v1.icon4
    v1.icon4.Parent = v1.tab3
    v1.tab3.Parent = v1.holder
    v1.divider3 = Instance.new("Frame")
    v1.divider3.Name = "Divider"
    v1.divider3.BackgroundTransparency = 1
    v1.divider3.ClipsDescendants = true
    v1.divider3.Position = UDim2.fromScale(0, 0.988713)
    v1.divider3.Size = UDim2.fromOffset(55, 5)
    v1.uICorner11 = Instance.new("UICorner")
    v1.uICorner11.Name = "UICorner"
    v1.uICorner11.CornerRadius = UDim.new(0, 5)
    v1.uICorner11.Parent = v1.divider3
    v1.frame3 = Instance.new("Frame")
    v1.frame3.Name = "Frame"
    v1.frame3.AnchorPoint = Vector2.new(0.5, 1)
    v1.frame3.BackgroundColor3 = Color3.fromRGB(31, 31, 45)
    v1.frame3.Position = UDim2.new(0.5, 0, 1, 3)
    v1.frame3.Size = UDim2.fromOffset(25, 6)
    v1.uICorner12 = Instance.new("UICorner")
    v1.uICorner12.Name = "UICorner"
    v1.uICorner12.CornerRadius = UDim.new(0, 12)
    v1.uICorner12.Parent = v1.frame3
    v1.frame3.Parent = v1.divider3
    v1.divider3.Parent = v1.holder
    v1.tab4 = Instance.new("Frame")
    v1.tab4.Name = "Tab"
    v1.tab4.BackgroundTransparency = 1
    v1.tab4.ClipsDescendants = true
    v1.tab4.Size = UDim2.fromOffset(55, 60)
    v1.uICorner13 = Instance.new("UICorner")
    v1.uICorner13.Name = "UICorner"
    v1.uICorner13.CornerRadius = UDim.new(0, 5)
    v1.uICorner13.Parent = v1.tab4
    v1.icon5 = Instance.new("ImageLabel")
    v1.icon5.Name = "Icon"
    v1.icon5.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.icon5.BackgroundTransparency = 1
    v1.icon5.Image = "rbxassetid://93827853548653"
    v1.icon5.ImageColor3 = Color3.fromRGB(69, 71, 90)
    v1.icon5.Position = UDim2.new(0.5, 0, 0.5, -8)
    v1.icon5.Size = UDim2.fromOffset(24, 22)
    v1.textLabel4 = Instance.new("TextLabel")
    v1.textLabel4.Name = "TextLabel"
    v1.textLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.textLabel4.AutomaticSize = Enum.AutomaticSize.XY
    v1.textLabel4.BackgroundTransparency = 1

    v1.textLabel4.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal
    )

    v1.textLabel4.Position = UDim2.new(0.5, 0, 0.5, 20)
    v1.textLabel4.Size = UDim2.new(1, 1, 1, 1)
    v1.textLabel4.Text = "Exploits"
    v1.textLabel4.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.textLabel4.TextSize = 12
    v1.textLabel4.Parent = v1.icon5
    v1.icon5.Parent = v1.tab4
    v1.tab4.Parent = v1.holder
    v1.divider4 = Instance.new("Frame")
    v1.divider4.Name = "Divider"
    v1.divider4.BackgroundTransparency = 1
    v1.divider4.ClipsDescendants = true
    v1.divider4.Position = UDim2.fromScale(0, 0.988713)
    v1.divider4.Size = UDim2.fromOffset(55, 5)
    v1.uICorner14 = Instance.new("UICorner")
    v1.uICorner14.Name = "UICorner"
    v1.uICorner14.CornerRadius = UDim.new(0, 5)
    v1.uICorner14.Parent = v1.divider4
    v1.frame4 = Instance.new("Frame")
    v1.frame4.Name = "Frame"
    v1.frame4.AnchorPoint = Vector2.new(0.5, 1)
    v1.frame4.BackgroundColor3 = Color3.fromRGB(31, 31, 45)
    v1.frame4.Position = UDim2.new(0.5, 0, 1, 3)
    v1.frame4.Size = UDim2.fromOffset(25, 6)
    v1.uICorner15 = Instance.new("UICorner")
    v1.uICorner15.Name = "UICorner"
    v1.uICorner15.CornerRadius = UDim.new(0, 12)
    v1.uICorner15.Parent = v1.frame4
    v1.frame4.Parent = v1.divider4
    v1.divider4.Parent = v1.holder
    v1.tab5 = Instance.new("Frame")
    v1.tab5.Name = "Tab"
    v1.tab5.BackgroundTransparency = 1
    v1.tab5.ClipsDescendants = true
    v1.tab5.Size = UDim2.fromOffset(55, 60)
    v1.uICorner16 = Instance.new("UICorner")
    v1.uICorner16.Name = "UICorner"
    v1.uICorner16.CornerRadius = UDim.new(0, 5)
    v1.uICorner16.Parent = v1.tab5
    v1.icon6 = Instance.new("ImageLabel")
    v1.icon6.Name = "Icon"
    v1.icon6.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.icon6.BackgroundTransparency = 1
    v1.icon6.Image = "rbxassetid://128822529527725"
    v1.icon6.ImageColor3 = Color3.fromRGB(69, 71, 90)
    v1.icon6.Position = UDim2.new(0.5, 0, 0.5, -8)
    v1.icon6.Size = UDim2.fromOffset(24, 22)
    v1.textLabel5 = Instance.new("TextLabel")
    v1.textLabel5.Name = "TextLabel"
    v1.textLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.textLabel5.AutomaticSize = Enum.AutomaticSize.XY
    v1.textLabel5.BackgroundTransparency = 1

    v1.textLabel5.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal
    )

    v1.textLabel5.Position = UDim2.new(0.5, 0, 0.5, 20)
    v1.textLabel5.Size = UDim2.new(1, 1, 1, 1)
    v1.textLabel5.Text = "Settings"
    v1.textLabel5.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.textLabel5.TextSize = 12
    v1.textLabel5.Parent = v1.icon6
    v1.icon6.Parent = v1.tab5
    v1.tab5.Parent = v1.holder
    v1.holder.Parent = v1.sidebar
    v1.sidebar.Parent = v1.mainFrame
    v1.subHeader = Instance.new("Frame")
    v1.subHeader.Name = "Sub-Header"
    v1.subHeader.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.subHeader.BackgroundTransparency = 1
    v1.subHeader.Position = UDim2.fromScale(0.554676, 0.127812)
    v1.subHeader.Size = UDim2.fromOffset(621, 51)
    v1.subTab = Instance.new("Frame")
    v1.subTab.Name = "SubTab"
    v1.subTab.AutomaticSize = Enum.AutomaticSize.X
    v1.subTab.BackgroundTransparency = 1
    v1.subTab.Position = UDim2.fromScale(0, 0.0392157)
    v1.subTab.Size = UDim2.fromOffset(80, 49)
    v1.tabName = Instance.new("TextLabel")
    v1.tabName.Name = "TabName"
    v1.tabName.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.tabName.AutomaticSize = Enum.AutomaticSize.XY
    v1.tabName.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.tabName.BackgroundTransparency = 0.8

    v1.tabName.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.tabName.Position = UDim2.new(0.5, 0, 0.5, -3)
    v1.tabName.Size = UDim2.fromOffset(1, 1)
    v1.tabName.Text = "ActiveSubTab1"
    v1.tabName.TextColor3 = Color3.fromRGB(254, 254, 254)
    v1.tabName.TextSize = 13
    v1.uIPadding1 = Instance.new("UIPadding")
    v1.uIPadding1.Name = "UIPadding"
    v1.uIPadding1.PaddingBottom = UDim.new(0, 10)
    v1.uIPadding1.PaddingLeft = UDim.new(0, 8)
    v1.uIPadding1.PaddingRight = UDim.new(0, 8)
    v1.uIPadding1.PaddingTop = UDim.new(0, 10)
    v1.uIPadding1.Parent = v1.tabName
    v1.uICorner17 = Instance.new("UICorner")
    v1.uICorner17.Name = "UICorner"
    v1.uICorner17.CornerRadius = UDim.new(0, 4)
    v1.uICorner17.Parent = v1.tabName
    v1.uIGradient2 = Instance.new("UIGradient")
    v1.uIGradient2.Name = "UIGradient"

    v1.uIGradient2.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient2.Parent = v1.tabName
    v1.tabName.Parent = v1.subTab
    v1.holder1 = Instance.new("Frame")
    v1.holder1.Name = "Holder"
    v1.holder1.AnchorPoint = Vector2.new(0.5, 1)
    v1.holder1.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.holder1.Position = UDim2.new(0.5, 0, 1, 2)
    v1.holder1.Size = UDim2.fromOffset(34, 6)
    v1.uICorner18 = Instance.new("UICorner")
    v1.uICorner18.Name = "UICorner"
    v1.uICorner18.CornerRadius = UDim.new(0, 12)
    v1.uICorner18.Parent = v1.holder1
    v1.uIGradient3 = Instance.new("UIGradient")
    v1.uIGradient3.Name = "UIGradient"

    v1.uIGradient3.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient3.Parent = v1.holder1
    v1.holder1.Parent = v1.subTab
    v1.subTab.Parent = v1.subHeader
    v1.uIListLayout1 = Instance.new("UIListLayout")
    v1.uIListLayout1.Name = "UIListLayout"
    v1.uIListLayout1.FillDirection = Enum.FillDirection.Horizontal
    v1.uIListLayout1.Padding = UDim.new(0, 8)
    v1.uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
    v1.uIListLayout1.Parent = v1.subHeader
    v1.uIPadding2 = Instance.new("UIPadding")
    v1.uIPadding2.Name = "UIPadding"
    v1.uIPadding2.PaddingLeft = UDim.new(0, 25)
    v1.uIPadding2.PaddingTop = UDim.new(0, 4)
    v1.uIPadding2.Parent = v1.subHeader
    v1.subTab1 = Instance.new("Frame")
    v1.subTab1.Name = "SubTab"
    v1.subTab1.AutomaticSize = Enum.AutomaticSize.X
    v1.subTab1.BackgroundTransparency = 1
    v1.subTab1.Position = UDim2.fromScale(0, 0.0392157)
    v1.subTab1.Size = UDim2.fromOffset(80, 49)
    v1.tabName1 = Instance.new("TextLabel")
    v1.tabName1.Name = "TabName"
    v1.tabName1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.tabName1.AutomaticSize = Enum.AutomaticSize.XY
    v1.tabName1.BackgroundTransparency = 1
    v1.tabName1.FontFace = Font.new("rbxassetid://12187365364")
    v1.tabName1.Position = UDim2.new(0.5, 0, 0.5, -3)
    v1.tabName1.Size = UDim2.fromOffset(1, 1)
    v1.tabName1.Text = "SubTab2"
    v1.tabName1.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.tabName1.TextSize = 13
    v1.tabName1.TextTransparency = 0.15
    v1.uICorner19 = Instance.new("UICorner")
    v1.uICorner19.Name = "UICorner"
    v1.uICorner19.CornerRadius = UDim.new(0, 4)
    v1.uICorner19.Parent = v1.tabName1
    v1.uIPadding3 = Instance.new("UIPadding")
    v1.uIPadding3.Name = "UIPadding"
    v1.uIPadding3.PaddingBottom = UDim.new(0, 10)
    v1.uIPadding3.PaddingLeft = UDim.new(0, 8)
    v1.uIPadding3.PaddingRight = UDim.new(0, 8)
    v1.uIPadding3.PaddingTop = UDim.new(0, 10)
    v1.uIPadding3.Parent = v1.tabName1
    v1.tabName1.Parent = v1.subTab1
    v1.subTab1.Parent = v1.subHeader
    v1.subTab2 = Instance.new("Frame")
    v1.subTab2.Name = "SubTab"
    v1.subTab2.AutomaticSize = Enum.AutomaticSize.X
    v1.subTab2.BackgroundTransparency = 1
    v1.subTab2.Position = UDim2.fromScale(0, 0.0392157)
    v1.subTab2.Size = UDim2.fromOffset(80, 49)
    v1.tabName2 = Instance.new("TextLabel")
    v1.tabName2.Name = "TabName"
    v1.tabName2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.tabName2.AutomaticSize = Enum.AutomaticSize.XY
    v1.tabName2.BackgroundTransparency = 1
    v1.tabName2.FontFace = Font.new("rbxassetid://12187365364")
    v1.tabName2.Position = UDim2.new(0.5, 0, 0.5, -3)
    v1.tabName2.Size = UDim2.fromOffset(1, 1)
    v1.tabName2.Text = "SubTab2"
    v1.tabName2.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.tabName2.TextSize = 13
    v1.tabName2.TextTransparency = 0.15
    v1.uICorner20 = Instance.new("UICorner")
    v1.uICorner20.Name = "UICorner"
    v1.uICorner20.CornerRadius = UDim.new(0, 4)
    v1.uICorner20.Parent = v1.tabName2
    v1.uIPadding4 = Instance.new("UIPadding")
    v1.uIPadding4.Name = "UIPadding"
    v1.uIPadding4.PaddingBottom = UDim.new(0, 10)
    v1.uIPadding4.PaddingLeft = UDim.new(0, 8)
    v1.uIPadding4.PaddingRight = UDim.new(0, 8)
    v1.uIPadding4.PaddingTop = UDim.new(0, 10)
    v1.uIPadding4.Parent = v1.tabName2
    v1.tabName2.Parent = v1.subTab2
    v1.subTab2.Parent = v1.subHeader
    v1.subTab3 = Instance.new("Frame")
    v1.subTab3.Name = "SubTab"
    v1.subTab3.AutomaticSize = Enum.AutomaticSize.X
    v1.subTab3.BackgroundTransparency = 1
    v1.subTab3.Position = UDim2.fromScale(0, 0.0392157)
    v1.subTab3.Size = UDim2.fromOffset(80, 49)
    v1.tabName3 = Instance.new("TextLabel")
    v1.tabName3.Name = "TabName"
    v1.tabName3.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.tabName3.AutomaticSize = Enum.AutomaticSize.XY
    v1.tabName3.BackgroundTransparency = 1
    v1.tabName3.FontFace = Font.new("rbxassetid://12187365364")
    v1.tabName3.Position = UDim2.new(0.5, 0, 0.5, -3)
    v1.tabName3.Size = UDim2.fromOffset(1, 1)
    v1.tabName3.Text = "SubTab2"
    v1.tabName3.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.tabName3.TextSize = 13
    v1.tabName3.TextTransparency = 0.15
    v1.uICorner21 = Instance.new("UICorner")
    v1.uICorner21.Name = "UICorner"
    v1.uICorner21.CornerRadius = UDim.new(0, 4)
    v1.uICorner21.Parent = v1.tabName3
    v1.uIPadding5 = Instance.new("UIPadding")
    v1.uIPadding5.Name = "UIPadding"
    v1.uIPadding5.PaddingBottom = UDim.new(0, 10)
    v1.uIPadding5.PaddingLeft = UDim.new(0, 8)
    v1.uIPadding5.PaddingRight = UDim.new(0, 8)
    v1.uIPadding5.PaddingTop = UDim.new(0, 10)
    v1.uIPadding5.Parent = v1.tabName3
    v1.tabName3.Parent = v1.subTab3
    v1.subTab3.Parent = v1.subHeader
    v1.subTab4 = Instance.new("Frame")
    v1.subTab4.Name = "SubTab"
    v1.subTab4.AutomaticSize = Enum.AutomaticSize.X
    v1.subTab4.BackgroundTransparency = 1
    v1.subTab4.Position = UDim2.fromScale(0, 0.0392157)
    v1.subTab4.Size = UDim2.fromOffset(80, 49)
    v1.tabName4 = Instance.new("TextLabel")
    v1.tabName4.Name = "TabName"
    v1.tabName4.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.tabName4.AutomaticSize = Enum.AutomaticSize.XY
    v1.tabName4.BackgroundTransparency = 1
    v1.tabName4.FontFace = Font.new("rbxassetid://12187365364")
    v1.tabName4.Position = UDim2.new(0.5, 0, 0.5, -3)
    v1.tabName4.Size = UDim2.fromOffset(1, 1)
    v1.tabName4.Text = "SubTab2"
    v1.tabName4.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.tabName4.TextSize = 13
    v1.tabName4.TextTransparency = 0.15
    v1.uICorner22 = Instance.new("UICorner")
    v1.uICorner22.Name = "UICorner"
    v1.uICorner22.CornerRadius = UDim.new(0, 4)
    v1.uICorner22.Parent = v1.tabName4
    v1.uIPadding6 = Instance.new("UIPadding")
    v1.uIPadding6.Name = "UIPadding"
    v1.uIPadding6.PaddingBottom = UDim.new(0, 10)
    v1.uIPadding6.PaddingLeft = UDim.new(0, 8)
    v1.uIPadding6.PaddingRight = UDim.new(0, 8)
    v1.uIPadding6.PaddingTop = UDim.new(0, 10)
    v1.uIPadding6.Parent = v1.tabName4
    v1.tabName4.Parent = v1.subTab4
    v1.subTab4.Parent = v1.subHeader
    v1.subTab5 = Instance.new("Frame")
    v1.subTab5.Name = "SubTab"
    v1.subTab5.AutomaticSize = Enum.AutomaticSize.X
    v1.subTab5.BackgroundTransparency = 1
    v1.subTab5.Position = UDim2.fromScale(0, 0.0392157)
    v1.subTab5.Size = UDim2.fromOffset(80, 49)
    v1.tabName5 = Instance.new("TextLabel")
    v1.tabName5.Name = "TabName"
    v1.tabName5.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.tabName5.AutomaticSize = Enum.AutomaticSize.XY
    v1.tabName5.BackgroundTransparency = 1
    v1.tabName5.FontFace = Font.new("rbxassetid://12187365364")
    v1.tabName5.Position = UDim2.new(0.5, 0, 0.5, -3)
    v1.tabName5.Size = UDim2.fromOffset(1, 1)
    v1.tabName5.Text = "SubTab2"
    v1.tabName5.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.tabName5.TextSize = 13
    v1.tabName5.TextTransparency = 0.15
    v1.uICorner23 = Instance.new("UICorner")
    v1.uICorner23.Name = "UICorner"
    v1.uICorner23.CornerRadius = UDim.new(0, 4)
    v1.uICorner23.Parent = v1.tabName5
    v1.uIPadding7 = Instance.new("UIPadding")
    v1.uIPadding7.Name = "UIPadding"
    v1.uIPadding7.PaddingBottom = UDim.new(0, 10)
    v1.uIPadding7.PaddingLeft = UDim.new(0, 8)
    v1.uIPadding7.PaddingRight = UDim.new(0, 8)
    v1.uIPadding7.PaddingTop = UDim.new(0, 10)
    v1.uIPadding7.Parent = v1.tabName5
    v1.tabName5.Parent = v1.subTab5
    v1.subTab5.Parent = v1.subHeader
    v1.subHeader.Parent = v1.mainFrame
    v1.page = Instance.new("Frame")
    v1.page.Name = "Page"
    v1.page.AnchorPoint = Vector2.new(1, 1)
    v1.page.BackgroundColor3 = Color3.fromRGB(16, 17, 21)
    v1.page.ClipsDescendants = true
    v1.page.Position = UDim2.fromScale(1, 1)
    v1.page.Size = UDim2.fromOffset(620, 401)
    v1.uICorner24 = Instance.new("UICorner")
    v1.uICorner24.Name = "UICorner"
    v1.uICorner24.CornerRadius = UDim.new(0, 11)
    v1.uICorner24.Parent = v1.page
    v1.container = Instance.new("ScrollingFrame")
    v1.container.Name = "Container"
    v1.container.Active = true
    v1.container.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.container.BackgroundTransparency = 1
    v1.container.Position = UDim2.fromScale(0.5, 0.5)
    v1.container.ScrollBarImageColor3 = Color3.new()
    v1.container.ScrollBarThickness = 1
    v1.container.Size = UDim2.fromOffset(620, 401)
    v1.sectionLeft = Instance.new("Frame")
    v1.sectionLeft.Name = "Section_Left"
    v1.sectionLeft.AutomaticSize = Enum.AutomaticSize.Y
    v1.sectionLeft.BackgroundColor3 = Color3.fromRGB(17, 18, 22)
    v1.sectionLeft.ClipsDescendants = true
    v1.sectionLeft.Size = UDim2.fromOffset(281, 60)
    v1.header1 = Instance.new("Frame")
    v1.header1.Name = "Header"
    v1.header1.AnchorPoint = Vector2.new(0.5, 0)
    v1.header1.BackgroundColor3 = Color3.fromRGB(19, 20, 25)
    v1.header1.Position = UDim2.fromScale(0.501786, 0)
    v1.header1.Size = UDim2.fromOffset(281, 30)
    v1.holder2 = Instance.new("Frame")
    v1.holder2.Name = "Holder"
    v1.holder2.AnchorPoint = Vector2.new(0.5, 0)
    v1.holder2.AutomaticSize = Enum.AutomaticSize.XY
    v1.holder2.BackgroundTransparency = 1
    v1.holder2.Position = UDim2.fromScale(0.5, 1)
    v1.holder2.Size = UDim2.fromOffset(1, 1)
    v1.uIListLayout2 = Instance.new("UIListLayout")
    v1.uIListLayout2.Name = "UIListLayout"
    v1.uIListLayout2.Padding = UDim.new(0, 4)
    v1.uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    v1.uIListLayout2.Parent = v1.holder2
    v1.uIPadding8 = Instance.new("UIPadding")
    v1.uIPadding8.Name = "UIPadding"
    v1.uIPadding8.PaddingBottom = UDim.new(0, 45)
    v1.uIPadding8.PaddingTop = UDim.new(0, 5)
    v1.uIPadding8.Parent = v1.holder2
    v1.toggleComponent = Instance.new("Frame")
    v1.toggleComponent.Name = "Toggle_Component"
    v1.toggleComponent.AnchorPoint = Vector2.new(0.5, 0)
    v1.toggleComponent.BackgroundTransparency = 1
    v1.toggleComponent.Position = UDim2.fromScale(0.5, 0)
    v1.toggleComponent.Size = UDim2.fromOffset(312, 30)
    v1.toggleName = Instance.new("TextLabel")
    v1.toggleName.Name = "Toggle_Name"
    v1.toggleName.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName.BackgroundTransparency = 1
    v1.toggleName.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName.Position = UDim2.new(0, 48, 0.5, 0)
    v1.toggleName.Size = UDim2.fromOffset(1, 1)
    v1.toggleName.Text = "Example Toggle"
    v1.toggleName.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.toggleName.TextSize = 12
    v1.toggleName.Parent = v1.toggleComponent
    v1.toggle = Instance.new("Frame")
    v1.toggle.Name = "Toggle"
    v1.toggle.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggle.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.toggle.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggle.Size = UDim2.fromOffset(14, 14)
    v1.uIStroke = Instance.new("UIStroke")
    v1.uIStroke.Name = "UIStroke"
    v1.uIStroke.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke.Parent = v1.toggle
    v1.uICorner25 = Instance.new("UICorner")
    v1.uICorner25.Name = "UICorner"
    v1.uICorner25.CornerRadius = UDim.new(0, 3)
    v1.uICorner25.Parent = v1.toggle
    v1.toggle.Parent = v1.toggleComponent
    v1.toggleComponent.Parent = v1.holder2
    v1.toggleComponent1 = Instance.new("Frame")
    v1.toggleComponent1.Name = "Toggle_Component"
    v1.toggleComponent1.AnchorPoint = Vector2.new(0.5, 0)
    v1.toggleComponent1.BackgroundTransparency = 1
    v1.toggleComponent1.Position = UDim2.fromScale(0.5, 0)
    v1.toggleComponent1.Size = UDim2.fromOffset(312, 30)
    v1.toggleName1 = Instance.new("TextLabel")
    v1.toggleName1.Name = "Toggle_Name"
    v1.toggleName1.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName1.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName1.BackgroundTransparency = 1
    v1.toggleName1.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName1.Position = UDim2.new(0, 48, 0.5, 0)
    v1.toggleName1.Size = UDim2.fromOffset(1, 1)
    v1.toggleName1.Text = "Example Toggle"
    v1.toggleName1.TextColor3 = Color3.new(1, 1, 1)
    v1.toggleName1.TextSize = 12
    v1.toggleName1.Parent = v1.toggleComponent1
    v1.toggle1 = Instance.new("Frame")
    v1.toggle1.Name = "Toggle"
    v1.toggle1.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggle1.BackgroundColor3 = Color3.fromRGB(231, 231, 231)
    v1.toggle1.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggle1.Size = UDim2.fromOffset(14, 14)
    v1.checkIcon = Instance.new("ImageLabel")
    v1.checkIcon.Name = "Check_Icon"
    v1.checkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.checkIcon.BackgroundTransparency = 1
    v1.checkIcon.Image = "rbxassetid://83899464799881"
    v1.checkIcon.Position = UDim2.fromScale(0.5, 0.5)
    v1.checkIcon.Size = UDim2.fromOffset(8, 7)
    v1.checkIcon.Parent = v1.toggle1
    v1.uICorner26 = Instance.new("UICorner")
    v1.uICorner26.Name = "UICorner"
    v1.uICorner26.CornerRadius = UDim.new(0, 3)
    v1.uICorner26.Parent = v1.toggle1
    v1.uIGradient4 = Instance.new("UIGradient")
    v1.uIGradient4.Name = "UIGradient"

    v1.uIGradient4.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient4.Parent = v1.toggle1
    v1.toggle1.Parent = v1.toggleComponent1
    v1.colorFrame = Instance.new("Frame")
    v1.colorFrame.Name = "ColorFrame"
    v1.colorFrame.AnchorPoint = Vector2.new(1, 0.5)
    v1.colorFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.colorFrame.Position = UDim2.fromScale(0.915, 0.5)
    v1.colorFrame.Size = UDim2.fromOffset(15, 15)
    v1.uICorner27 = Instance.new("UICorner")
    v1.uICorner27.Name = "UICorner"
    v1.uICorner27.CornerRadius = UDim.new(1, 0)
    v1.uICorner27.Parent = v1.colorFrame
    v1.colorFrame.Parent = v1.toggleComponent1
    v1.toggleComponent1.Parent = v1.holder2
    v1.sliderComponent = Instance.new("Frame")
    v1.sliderComponent.Name = "Slider_Component"
    v1.sliderComponent.Active = true
    v1.sliderComponent.AnchorPoint = Vector2.new(0.5, 0)
    v1.sliderComponent.BackgroundTransparency = 1
    v1.sliderComponent.Position = UDim2.fromScale(0.5, 0.762195)
    v1.sliderComponent.Size = UDim2.fromOffset(312, 40)
    v1.value = Instance.new("TextLabel")
    v1.value.Name = "Value"
    v1.value.AnchorPoint = Vector2.new(1, 0.5)
    v1.value.AutomaticSize = Enum.AutomaticSize.XY
    v1.value.BackgroundTransparency = 1
    v1.value.FontFace = Font.new("rbxassetid://12187365364")
    v1.value.Position = UDim2.new(1, -22, 0.5, -8)
    v1.value.Size = UDim2.fromOffset(1, 1)
    v1.value.Text = "100"
    v1.value.TextColor3 = Color3.new(1, 1, 1)
    v1.value.TextSize = 14
    v1.value.Parent = v1.sliderComponent
    v1.sliderText = Instance.new("TextLabel")
    v1.sliderText.Name = "Slider_Text"
    v1.sliderText.AnchorPoint = Vector2.new(0, 0.5)
    v1.sliderText.AutomaticSize = Enum.AutomaticSize.XY
    v1.sliderText.BackgroundTransparency = 1
    v1.sliderText.FontFace = Font.new("rbxassetid://12187365364")
    v1.sliderText.Position = UDim2.new(0, 23, 0.5, -8)
    v1.sliderText.Size = UDim2.fromOffset(1, 1)
    v1.sliderText.Text = "Example Slider"
    v1.sliderText.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.sliderText.TextSize = 14
    v1.sliderText.Parent = v1.sliderComponent
    v1.progressBG = Instance.new("Frame")
    v1.progressBG.Name = "Progress_BG"
    v1.progressBG.AnchorPoint = Vector2.new(0, 0.5)
    v1.progressBG.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.progressBG.Position = UDim2.new(0.0128205, 19, 0.53125, 13)
    v1.progressBG.Size = UDim2.fromOffset(266, 4)
    v1.progress = Instance.new("Frame")
    v1.progress.Name = "Progress"
    v1.progress.AnchorPoint = Vector2.new(0, 0.5)
    v1.progress.BackgroundColor3 = Color3.fromRGB(232, 232, 232)
    v1.progress.Position = UDim2.fromScale(0, 0.5)
    v1.progress.Size = UDim2.fromOffset(171, 7)
    v1.pointer = Instance.new("Frame")
    v1.pointer.Name = "Pointer"
    v1.pointer.AnchorPoint = Vector2.new(1, 0.5)
    v1.pointer.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.pointer.Position = UDim2.fromScale(1, 0.5)
    v1.pointer.Size = UDim2.fromOffset(6, 6)
    v1.uICorner28 = Instance.new("UICorner")
    v1.uICorner28.Name = "UICorner"
    v1.uICorner28.Parent = v1.pointer
    v1.design = Instance.new("Frame")
    v1.design.Name = "Design"
    v1.design.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.design.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.design.BackgroundTransparency = 0.5
    v1.design.Position = UDim2.fromScale(0.5, 0.5)
    v1.design.Size = UDim2.fromOffset(14, 14)
    v1.uICorner29 = Instance.new("UICorner")
    v1.uICorner29.Name = "UICorner"
    v1.uICorner29.Parent = v1.design
    v1.design.Parent = v1.pointer
    v1.pointer.Parent = v1.progress
    v1.uICorner30 = Instance.new("UICorner")
    v1.uICorner30.Name = "UICorner"
    v1.uICorner30.Parent = v1.progress
    v1.uIGradient5 = Instance.new("UIGradient")
    v1.uIGradient5.Name = "UIGradient"

    v1.uIGradient5.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient5.Parent = v1.progress
    v1.progress.Parent = v1.progressBG
    v1.uIStroke1 = Instance.new("UIStroke")
    v1.uIStroke1.Name = "UIStroke"
    v1.uIStroke1.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke1.Parent = v1.progressBG
    v1.uICorner31 = Instance.new("UICorner")
    v1.uICorner31.Name = "UICorner"
    v1.uICorner31.Parent = v1.progressBG
    v1.progressBG.Parent = v1.sliderComponent
    v1.sliderComponent.Parent = v1.holder2
    v1.keybindComponent = Instance.new("Frame")
    v1.keybindComponent.Name = "Keybind_Component"
    v1.keybindComponent.AnchorPoint = Vector2.new(0.5, 0)
    v1.keybindComponent.BackgroundTransparency = 1
    v1.keybindComponent.Position = UDim2.fromScale(0.5, 0.71885)
    v1.keybindComponent.Size = UDim2.fromOffset(312, 50)
    v1.toggleName2 = Instance.new("TextLabel")
    v1.toggleName2.Name = "Toggle_Name"
    v1.toggleName2.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName2.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName2.BackgroundTransparency = 1
    v1.toggleName2.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName2.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggleName2.Size = UDim2.fromOffset(1, 1)
    v1.toggleName2.Text = "Example Keybind"
    v1.toggleName2.TextColor3 = Color3.new(1, 1, 1)
    v1.toggleName2.TextSize = 12
    v1.toggleName2.Parent = v1.keybindComponent
    v1.holder3 = Instance.new("Frame")
    v1.holder3.Name = "Holder"
    v1.holder3.AnchorPoint = Vector2.new(1, 0.5)
    v1.holder3.AutomaticSize = Enum.AutomaticSize.XY
    v1.holder3.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.holder3.ClipsDescendants = true
    v1.holder3.Position = UDim2.new(1, -23, 0.5, 0)
    v1.holder3.Size = UDim2.fromOffset(16, 16)
    v1.value1 = Instance.new("TextLabel")
    v1.value1.Name = "Value"
    v1.value1.AnchorPoint = Vector2.new(0, 0.5)
    v1.value1.AutomaticSize = Enum.AutomaticSize.XY
    v1.value1.BackgroundTransparency = 1

    v1.value1.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal
    )

    v1.value1.Position = UDim2.new(0, 19, 0.5, 0)
    v1.value1.Size = UDim2.fromOffset(1, 1)
    v1.value1.Text = "NONE"
    v1.value1.TextColor3 = Color3.new(1, 1, 1)
    v1.value1.TextSize = 10
    v1.uIPadding9 = Instance.new("UIPadding")
    v1.uIPadding9.Name = "UIPadding"
    v1.uIPadding9.PaddingBottom = UDim.new(0, 4)
    v1.uIPadding9.PaddingLeft = UDim.new(0, 4)
    v1.uIPadding9.PaddingRight = UDim.new(0, 10)
    v1.uIPadding9.PaddingTop = UDim.new(0, 6)
    v1.uIPadding9.Parent = v1.value1
    v1.line = Instance.new("Frame")
    v1.line.Name = "Line"
    v1.line.AnchorPoint = Vector2.new(1, 0.5)
    v1.line.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line.Position = UDim2.new(1, 13, 0.5, 0)
    v1.line.Size = UDim2.fromOffset(6, 13)
    v1.uICorner32 = Instance.new("UICorner")
    v1.uICorner32.Name = "UICorner"
    v1.uICorner32.CornerRadius = UDim.new(0, 30)
    v1.uICorner32.Parent = v1.line
    v1.line1 = Instance.new("Frame")
    v1.line1.Name = "Line"
    v1.line1.AnchorPoint = Vector2.new(1, 0.5)
    v1.line1.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line1.Position = UDim2.new(1, 13, 0.5, 0)
    v1.line1.Size = UDim2.fromOffset(6, 13)
    v1.uICorner33 = Instance.new("UICorner")
    v1.uICorner33.Name = "UICorner"
    v1.uICorner33.CornerRadius = UDim.new(0, 30)
    v1.uICorner33.Parent = v1.line1
    v1.line1.Parent = v1.line
    v1.line.Parent = v1.value1
    v1.value1.Parent = v1.holder3
    v1.iconHolder = Instance.new("Frame")
    v1.iconHolder.Name = "Icon_Holder"
    v1.iconHolder.BackgroundTransparency = 1
    v1.iconHolder.Position = UDim2.fromScale(0.04, -0.327869)
    v1.iconHolder.Size = UDim2.fromOffset(22, 22)
    v1.imageLabel = Instance.new("ImageLabel")
    v1.imageLabel.Name = "ImageLabel"
    v1.imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.imageLabel.BackgroundTransparency = 1
    v1.imageLabel.Image = "rbxassetid://127406982390736"
    v1.imageLabel.ImageColor3 = Color3.fromRGB(254, 254, 254)
    v1.imageLabel.Position = UDim2.fromScale(0.5, 0.5)
    v1.imageLabel.ScaleType = Enum.ScaleType.Fit
    v1.imageLabel.Size = UDim2.fromOffset(15, 15)
    v1.uIGradient6 = Instance.new("UIGradient")
    v1.uIGradient6.Name = "UIGradient"

    v1.uIGradient6.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient6.Parent = v1.imageLabel
    v1.imageLabel.Parent = v1.iconHolder
    v1.iconHolder.Parent = v1.holder3
    v1.uIStroke2 = Instance.new("UIStroke")
    v1.uIStroke2.Name = "UIStroke"
    v1.uIStroke2.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke2.Parent = v1.holder3
    v1.uIListLayout3 = Instance.new("UIListLayout")
    v1.uIListLayout3.Name = "UIListLayout"
    v1.uIListLayout3.FillDirection = Enum.FillDirection.Horizontal
    v1.uIListLayout3.Parent = v1.holder3
    v1.uICorner34 = Instance.new("UICorner")
    v1.uICorner34.Name = "UICorner"
    v1.uICorner34.CornerRadius = UDim.new(0, 3)
    v1.uICorner34.Parent = v1.holder3
    v1.holder3.Parent = v1.keybindComponent
    v1.keybindComponent.Parent = v1.holder2
    v1.toggleComponent2 = Instance.new("Frame")
    v1.toggleComponent2.Name = "Toggle_Component"
    v1.toggleComponent2.AnchorPoint = Vector2.new(0.5, 0)
    v1.toggleComponent2.BackgroundTransparency = 1
    v1.toggleComponent2.Position = UDim2.fromScale(0.5, 0)
    v1.toggleComponent2.Size = UDim2.fromOffset(312, 30)
    v1.toggleName3 = Instance.new("TextLabel")
    v1.toggleName3.Name = "Toggle_Name"
    v1.toggleName3.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName3.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName3.BackgroundTransparency = 1
    v1.toggleName3.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName3.Position = UDim2.new(0, 48, 0.5, 0)
    v1.toggleName3.Size = UDim2.fromOffset(1, 1)
    v1.toggleName3.Text = "Example Toggle"
    v1.toggleName3.TextColor3 = Color3.new(1, 1, 1)
    v1.toggleName3.TextSize = 12
    v1.toggleName3.Parent = v1.toggleComponent2
    v1.toggle2 = Instance.new("Frame")
    v1.toggle2.Name = "Toggle"
    v1.toggle2.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggle2.BackgroundColor3 = Color3.fromRGB(231, 231, 231)
    v1.toggle2.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggle2.Size = UDim2.fromOffset(14, 14)
    v1.checkIcon1 = Instance.new("ImageLabel")
    v1.checkIcon1.Name = "Check_Icon"
    v1.checkIcon1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.checkIcon1.BackgroundTransparency = 1
    v1.checkIcon1.Image = "rbxassetid://83899464799881"
    v1.checkIcon1.Position = UDim2.fromScale(0.5, 0.5)
    v1.checkIcon1.Size = UDim2.fromOffset(8, 7)
    v1.checkIcon1.Parent = v1.toggle2
    v1.uICorner35 = Instance.new("UICorner")
    v1.uICorner35.Name = "UICorner"
    v1.uICorner35.CornerRadius = UDim.new(0, 3)
    v1.uICorner35.Parent = v1.toggle2
    v1.uIGradient7 = Instance.new("UIGradient")
    v1.uIGradient7.Name = "UIGradient"

    v1.uIGradient7.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient7.Parent = v1.toggle2
    v1.toggle2.Parent = v1.toggleComponent2
    v1.toggleComponent2.Parent = v1.holder2
    v1.dropdownComponent = Instance.new("Frame")
    v1.dropdownComponent.Name = "Dropdown_Component"
    v1.dropdownComponent.AnchorPoint = Vector2.new(0.5, 0)
    v1.dropdownComponent.BackgroundTransparency = 1
    v1.dropdownComponent.Position = UDim2.fromScale(0.5, 0.762332)
    v1.dropdownComponent.Size = UDim2.fromOffset(312, 55)
    v1.dropdownName = Instance.new("TextLabel")
    v1.dropdownName.Name = "Dropdown_Name"
    v1.dropdownName.AutomaticSize = Enum.AutomaticSize.XY
    v1.dropdownName.BackgroundTransparency = 1
    v1.dropdownName.FontFace = Font.new("rbxassetid://12187365364")
    v1.dropdownName.Position = UDim2.fromOffset(25, 12)
    v1.dropdownName.Size = UDim2.fromOffset(1, 1)
    v1.dropdownName.Text = "Example Dropdown"
    v1.dropdownName.TextColor3 = Color3.fromRGB(204, 204, 209)
    v1.dropdownName.TextSize = 12
    v1.dropdownName.Parent = v1.dropdownComponent
    v1.holder4 = Instance.new("Frame")
    v1.holder4.Name = "Holder"
    v1.holder4.AnchorPoint = Vector2.new(0.5, 1)
    v1.holder4.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.holder4.ClipsDescendants = true
    v1.holder4.Position = UDim2.fromScale(0.503205, 1)
    v1.holder4.Size = UDim2.fromOffset(264, 22)
    v1.uIStroke3 = Instance.new("UIStroke")
    v1.uIStroke3.Name = "UIStroke"
    v1.uIStroke3.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke3.Parent = v1.holder4
    v1.uICorner36 = Instance.new("UICorner")
    v1.uICorner36.Name = "UICorner"
    v1.uICorner36.CornerRadius = UDim.new(0, 2)
    v1.uICorner36.Parent = v1.holder4
    v1.options = Instance.new("TextLabel")
    v1.options.Name = "Options"
    v1.options.AnchorPoint = Vector2.new(0, 0.5)
    v1.options.AutomaticSize = Enum.AutomaticSize.XY
    v1.options.BackgroundTransparency = 1

    v1.options.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.options.Position = UDim2.fromScale(0.025, 0.5)
    v1.options.Size = UDim2.fromOffset(1, 1)
    v1.options.Text = "Option 1, Option 2 , Option 3"
    v1.options.TextColor3 = Color3.fromRGB(254, 254, 254)
    v1.options.TextSize = 13
    v1.uIGradient8 = Instance.new("UIGradient")
    v1.uIGradient8.Name = "UIGradient"

    v1.uIGradient8.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient8.Parent = v1.options
    v1.options.Parent = v1.holder4
    v1.line2 = Instance.new("Frame")
    v1.line2.Name = "Line"
    v1.line2.AnchorPoint = Vector2.new(1, 0.5)
    v1.line2.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line2.Position = UDim2.new(1, 4, 0.5, 0)
    v1.line2.Size = UDim2.fromOffset(6, 13)
    v1.uICorner37 = Instance.new("UICorner")
    v1.uICorner37.Name = "UICorner"
    v1.uICorner37.CornerRadius = UDim.new(0, 30)
    v1.uICorner37.Parent = v1.line2
    v1.uIGradient9 = Instance.new("UIGradient")
    v1.uIGradient9.Name = "UIGradient"

    v1.uIGradient9.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient9.Parent = v1.line2
    v1.line2.Parent = v1.holder4
    v1.line3 = Instance.new("Frame")
    v1.line3.Name = "Line"
    v1.line3.AnchorPoint = Vector2.new(0, 0.5)
    v1.line3.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line3.Position = UDim2.new(0, -4, 0.5, 0)
    v1.line3.Size = UDim2.fromOffset(6, 13)
    v1.uICorner38 = Instance.new("UICorner")
    v1.uICorner38.Name = "UICorner"
    v1.uICorner38.CornerRadius = UDim.new(0, 30)
    v1.uICorner38.Parent = v1.line3
    v1.uIGradient10 = Instance.new("UIGradient")
    v1.uIGradient10.Name = "UIGradient"

    v1.uIGradient10.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient10.Parent = v1.line3
    v1.line3.Parent = v1.holder4
    v1.holder4.Parent = v1.dropdownComponent
    v1.dropdownComponent.Parent = v1.holder2
    v1.buttonComponent = Instance.new("Frame")
    v1.buttonComponent.Name = "Button_Component"
    v1.buttonComponent.AnchorPoint = Vector2.new(0.5, 0)
    v1.buttonComponent.BackgroundTransparency = 1
    v1.buttonComponent.Position = UDim2.fromScale(0.5, 0.848214)
    v1.buttonComponent.Size = UDim2.fromOffset(312, 40)
    v1.button = Instance.new("Frame")
    v1.button.Name = "Button"
    v1.button.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.button.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.button.Position = UDim2.fromScale(0.5, 0.5)
    v1.button.Size = UDim2.fromOffset(251, 30)
    v1.uICorner39 = Instance.new("UICorner")
    v1.uICorner39.Name = "UICorner"
    v1.uICorner39.CornerRadius = UDim.new(0, 3)
    v1.uICorner39.Parent = v1.button
    v1.buttonText = Instance.new("TextLabel")
    v1.buttonText.Name = "Button_Text"
    v1.buttonText.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.buttonText.AutomaticSize = Enum.AutomaticSize.XY
    v1.buttonText.BackgroundTransparency = 1

    v1.buttonText.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.buttonText.Position = UDim2.fromScale(0.5, 0.5)
    v1.buttonText.Size = UDim2.fromOffset(1, 1)
    v1.buttonText.Text = "Example Button"
    v1.buttonText.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.buttonText.TextSize = 13
    v1.buttonText.Parent = v1.button
    v1.uIStroke4 = Instance.new("UIStroke")
    v1.uIStroke4.Name = "UIStroke"
    v1.uIStroke4.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke4.Parent = v1.button
    v1.button.Parent = v1.buttonComponent
    v1.buttonComponent.Parent = v1.holder2
    v1.buttonComponent1 = Instance.new("Frame")
    v1.buttonComponent1.Name = "Button_Component"
    v1.buttonComponent1.AnchorPoint = Vector2.new(0.5, 0)
    v1.buttonComponent1.BackgroundTransparency = 1
    v1.buttonComponent1.Position = UDim2.fromScale(0.5, 0.848214)
    v1.buttonComponent1.Size = UDim2.fromOffset(312, 43)
    v1.button1 = Instance.new("Frame")
    v1.button1.Name = "Button"
    v1.button1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.button1.BackgroundColor3 = Color3.fromRGB(230, 255, 2)
    v1.button1.BackgroundTransparency = 0.95
    v1.button1.Position = UDim2.fromScale(0.5, 0.5)
    v1.button1.Size = UDim2.fromOffset(251, 30)
    v1.uICorner40 = Instance.new("UICorner")
    v1.uICorner40.Name = "UICorner"
    v1.uICorner40.CornerRadius = UDim.new(0, 3)
    v1.uICorner40.Parent = v1.button1
    v1.buttonText1 = Instance.new("TextLabel")
    v1.buttonText1.Name = "Button_Text"
    v1.buttonText1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.buttonText1.AutomaticSize = Enum.AutomaticSize.XY
    v1.buttonText1.BackgroundTransparency = 1

    v1.buttonText1.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.buttonText1.Position = UDim2.fromScale(0.5, 0.5)
    v1.buttonText1.Size = UDim2.fromOffset(1, 1)
    v1.buttonText1.Text = "Custom Color Button"
    v1.buttonText1.TextColor3 = Color3.fromRGB(230, 255, 2)
    v1.buttonText1.TextSize = 13
    v1.buttonText1.Parent = v1.button1
    v1.uIStroke5 = Instance.new("UIStroke")
    v1.uIStroke5.Name = "UIStroke"
    v1.uIStroke5.Color = Color3.fromRGB(230, 255, 2)
    v1.uIStroke5.Transparency = 0.5
    v1.uIStroke5.Parent = v1.button1
    v1.button1.Parent = v1.buttonComponent1
    v1.buttonComponent1.Parent = v1.holder2
    v1.holder2.Parent = v1.header1
    v1.uICorner41 = Instance.new("UICorner")
    v1.uICorner41.Name = "UICorner"
    v1.uICorner41.CornerRadius = UDim.new(0, 6)
    v1.uICorner41.Parent = v1.header1
    v1.liner2 = Instance.new("Frame")
    v1.liner2.Name = "Liner"
    v1.liner2.AnchorPoint = Vector2.new(0.5, 1)
    v1.liner2.BackgroundColor3 = Color3.fromRGB(26, 26, 37)
    v1.liner2.BorderColor3 = Color3.new()
    v1.liner2.BorderSizePixel = 0
    v1.liner2.Position = UDim2.fromScale(0.5, 1)
    v1.liner2.Size = UDim2.new(1, 1, 0, 1)
    v1.liner2.Parent = v1.header1
    v1.headerHolder = Instance.new("Frame")
    v1.headerHolder.Name = "Header_Holder"
    v1.headerHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.headerHolder.BackgroundTransparency = 1
    v1.headerHolder.ClipsDescendants = true
    v1.headerHolder.Position = UDim2.fromScale(0.5, 0.5)
    v1.headerHolder.Size = UDim2.fromOffset(281, 30)
    v1.sectionName = Instance.new("TextLabel")
    v1.sectionName.Name = "Section_Name"
    v1.sectionName.AnchorPoint = Vector2.new(0, 0.5)
    v1.sectionName.AutomaticSize = Enum.AutomaticSize.XY
    v1.sectionName.BackgroundTransparency = 1
    v1.sectionName.FontFace = Font.new("rbxassetid://12187365364")
    v1.sectionName.Position = UDim2.new(0, 35, 0.5, 0)
    v1.sectionName.Size = UDim2.fromOffset(1, 1)
    v1.sectionName.Text = "Exploits Tab"
    v1.sectionName.TextColor3 = Color3.new(1, 1, 1)
    v1.sectionName.TextSize = 12
    v1.sectionName.Parent = v1.headerHolder
    v1.imageLabel1 = Instance.new("ImageLabel")
    v1.imageLabel1.Name = "ImageLabel"
    v1.imageLabel1.AnchorPoint = Vector2.new(0, 0.5)
    v1.imageLabel1.BackgroundTransparency = 1
    v1.imageLabel1.Image = "rbxassetid://83273732891006"
    v1.imageLabel1.Position = UDim2.new(0, 12, 0.5, 0)
    v1.imageLabel1.Size = UDim2.fromOffset(15, 15)
    v1.imageLabel1.Parent = v1.headerHolder
    v1.toggle3 = Instance.new("Frame")
    v1.toggle3.Name = "Toggle"
    v1.toggle3.AnchorPoint = Vector2.new(1, 0.5)
    v1.toggle3.BackgroundColor3 = Color3.fromRGB(231, 231, 231)
    v1.toggle3.Position = UDim2.new(1, -12, 0.5, 0)
    v1.toggle3.Size = UDim2.fromOffset(16, 16)
    v1.checkIcon2 = Instance.new("ImageLabel")
    v1.checkIcon2.Name = "Check_Icon"
    v1.checkIcon2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.checkIcon2.BackgroundTransparency = 1
    v1.checkIcon2.Image = "rbxassetid://83899464799881"
    v1.checkIcon2.Position = UDim2.fromScale(0.5, 0.5)
    v1.checkIcon2.Size = UDim2.fromOffset(8, 7)
    v1.checkIcon2.Parent = v1.toggle3
    v1.uICorner42 = Instance.new("UICorner")
    v1.uICorner42.Name = "UICorner"
    v1.uICorner42.CornerRadius = UDim.new(0, 3)
    v1.uICorner42.Parent = v1.toggle3
    v1.uIGradient11 = Instance.new("UIGradient")
    v1.uIGradient11.Name = "UIGradient"

    v1.uIGradient11.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient11.Parent = v1.toggle3
    v1.toggle3.Parent = v1.headerHolder
    v1.line4 = Instance.new("Frame")
    v1.line4.Name = "Line"
    v1.line4.AnchorPoint = Vector2.new(0, 0.5)
    v1.line4.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line4.Position = UDim2.new(0, -3, 0.5, 0)
    v1.line4.Size = UDim2.fromOffset(6, 20)
    v1.uICorner43 = Instance.new("UICorner")
    v1.uICorner43.Name = "UICorner"
    v1.uICorner43.CornerRadius = UDim.new(0, 30)
    v1.uICorner43.Parent = v1.line4
    v1.uIGradient12 = Instance.new("UIGradient")
    v1.uIGradient12.Name = "UIGradient"

    v1.uIGradient12.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient12.Parent = v1.line4
    v1.line4.Parent = v1.headerHolder
    v1.headerHolder.Parent = v1.header1
    v1.header1.Parent = v1.sectionLeft
    v1.uICorner44 = Instance.new("UICorner")
    v1.uICorner44.Name = "UICorner"
    v1.uICorner44.CornerRadius = UDim.new(0, 6)
    v1.uICorner44.Parent = v1.sectionLeft
    v1.sectionLeft.Parent = v1.container
    v1.uIListLayout4 = Instance.new("UIListLayout")
    v1.uIListLayout4.Name = "UIListLayout"
    v1.uIListLayout4.FillDirection = Enum.FillDirection.Horizontal
    v1.uIListLayout4.Padding = UDim.new(0, 20)
    v1.uIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
    v1.uIListLayout4.Parent = v1.container
    v1.uIPadding10 = Instance.new("UIPadding")
    v1.uIPadding10.Name = "UIPadding"
    v1.uIPadding10.PaddingLeft = UDim.new(0, 12)
    v1.uIPadding10.PaddingTop = UDim.new(0, 12)
    v1.uIPadding10.Parent = v1.container
    v1.sectionRight = Instance.new("Frame")
    v1.sectionRight.Name = "Section_Right"
    v1.sectionRight.AutomaticSize = Enum.AutomaticSize.Y
    v1.sectionRight.BackgroundColor3 = Color3.fromRGB(17, 18, 22)
    v1.sectionRight.ClipsDescendants = true
    v1.sectionRight.Size = UDim2.fromOffset(281, 60)
    v1.header2 = Instance.new("Frame")
    v1.header2.Name = "Header"
    v1.header2.AnchorPoint = Vector2.new(0.5, 0)
    v1.header2.BackgroundColor3 = Color3.fromRGB(19, 20, 25)
    v1.header2.Position = UDim2.fromScale(0.501786, 0)
    v1.header2.Size = UDim2.fromOffset(281, 30)
    v1.holder5 = Instance.new("Frame")
    v1.holder5.Name = "Holder"
    v1.holder5.AnchorPoint = Vector2.new(0.5, 0)
    v1.holder5.AutomaticSize = Enum.AutomaticSize.XY
    v1.holder5.BackgroundTransparency = 1
    v1.holder5.Position = UDim2.fromScale(0.5, 1)
    v1.holder5.Size = UDim2.fromOffset(1, 1)
    v1.uIListLayout5 = Instance.new("UIListLayout")
    v1.uIListLayout5.Name = "UIListLayout"
    v1.uIListLayout5.Padding = UDim.new(0, 4)
    v1.uIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
    v1.uIListLayout5.Parent = v1.holder5
    v1.uIPadding11 = Instance.new("UIPadding")
    v1.uIPadding11.Name = "UIPadding"
    v1.uIPadding11.PaddingBottom = UDim.new(0, 45)
    v1.uIPadding11.PaddingTop = UDim.new(0, 5)
    v1.uIPadding11.Parent = v1.holder5
    v1.toggleComponent3 = Instance.new("Frame")
    v1.toggleComponent3.Name = "Toggle_Component"
    v1.toggleComponent3.AnchorPoint = Vector2.new(0.5, 0)
    v1.toggleComponent3.BackgroundTransparency = 1
    v1.toggleComponent3.Position = UDim2.fromScale(0.5, 0)
    v1.toggleComponent3.Size = UDim2.fromOffset(312, 30)
    v1.toggleName4 = Instance.new("TextLabel")
    v1.toggleName4.Name = "Toggle_Name"
    v1.toggleName4.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName4.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName4.BackgroundTransparency = 1
    v1.toggleName4.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName4.Position = UDim2.new(0, 48, 0.5, 0)
    v1.toggleName4.Size = UDim2.fromOffset(1, 1)
    v1.toggleName4.Text = "Example Toggle"
    v1.toggleName4.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.toggleName4.TextSize = 12
    v1.toggleName4.Parent = v1.toggleComponent3
    v1.toggle4 = Instance.new("Frame")
    v1.toggle4.Name = "Toggle"
    v1.toggle4.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggle4.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.toggle4.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggle4.Size = UDim2.fromOffset(14, 14)
    v1.uIStroke6 = Instance.new("UIStroke")
    v1.uIStroke6.Name = "UIStroke"
    v1.uIStroke6.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke6.Parent = v1.toggle4
    v1.uICorner45 = Instance.new("UICorner")
    v1.uICorner45.Name = "UICorner"
    v1.uICorner45.CornerRadius = UDim.new(0, 3)
    v1.uICorner45.Parent = v1.toggle4
    v1.toggle4.Parent = v1.toggleComponent3
    v1.toggleComponent3.Parent = v1.holder5
    v1.toggleComponent4 = Instance.new("Frame")
    v1.toggleComponent4.Name = "Toggle_Component"
    v1.toggleComponent4.AnchorPoint = Vector2.new(0.5, 0)
    v1.toggleComponent4.BackgroundTransparency = 1
    v1.toggleComponent4.Position = UDim2.fromScale(0.5, 0)
    v1.toggleComponent4.Size = UDim2.fromOffset(312, 30)
    v1.toggleName5 = Instance.new("TextLabel")
    v1.toggleName5.Name = "Toggle_Name"
    v1.toggleName5.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName5.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName5.BackgroundTransparency = 1
    v1.toggleName5.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName5.Position = UDim2.new(0, 48, 0.5, 0)
    v1.toggleName5.Size = UDim2.fromOffset(1, 1)
    v1.toggleName5.Text = "Example Toggle"
    v1.toggleName5.TextColor3 = Color3.new(1, 1, 1)
    v1.toggleName5.TextSize = 12
    v1.toggleName5.Parent = v1.toggleComponent4
    v1.toggle5 = Instance.new("Frame")
    v1.toggle5.Name = "Toggle"
    v1.toggle5.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggle5.BackgroundColor3 = Color3.fromRGB(231, 231, 231)
    v1.toggle5.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggle5.Size = UDim2.fromOffset(14, 14)
    v1.checkIcon3 = Instance.new("ImageLabel")
    v1.checkIcon3.Name = "Check_Icon"
    v1.checkIcon3.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.checkIcon3.BackgroundTransparency = 1
    v1.checkIcon3.Image = "rbxassetid://83899464799881"
    v1.checkIcon3.Position = UDim2.fromScale(0.5, 0.5)
    v1.checkIcon3.Size = UDim2.fromOffset(8, 7)
    v1.checkIcon3.Parent = v1.toggle5
    v1.uICorner46 = Instance.new("UICorner")
    v1.uICorner46.Name = "UICorner"
    v1.uICorner46.CornerRadius = UDim.new(0, 3)
    v1.uICorner46.Parent = v1.toggle5
    v1.uIGradient13 = Instance.new("UIGradient")
    v1.uIGradient13.Name = "UIGradient"

    v1.uIGradient13.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient13.Parent = v1.toggle5
    v1.toggle5.Parent = v1.toggleComponent4
    v1.colorFrame1 = Instance.new("Frame")
    v1.colorFrame1.Name = "ColorFrame"
    v1.colorFrame1.AnchorPoint = Vector2.new(1, 0.5)
    v1.colorFrame1.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.colorFrame1.Position = UDim2.new(1, -23, 0.5, 0)
    v1.colorFrame1.Size = UDim2.fromOffset(24, 13)
    v1.uICorner47 = Instance.new("UICorner")
    v1.uICorner47.Name = "UICorner"
    v1.uICorner47.CornerRadius = UDim.new(0, 4)
    v1.uICorner47.Parent = v1.colorFrame1
    v1.shadow = Instance.new("Frame")
    v1.shadow.Name = "Shadow"
    v1.shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.shadow.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.shadow.Position = UDim2.fromScale(0.5, 0.5)
    v1.shadow.Size = UDim2.fromOffset(24, 13)
    v1.uICorner48 = Instance.new("UICorner")
    v1.uICorner48.Name = "UICorner"
    v1.uICorner48.CornerRadius = UDim.new(0, 4)
    v1.uICorner48.Parent = v1.shadow
    v1.uIGradient14 = Instance.new("UIGradient")
    v1.uIGradient14.Name = "UIGradient"

    v1.uIGradient14.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.new()), ColorSequenceKeypoint.new(1, Color3.new()),
    })

    v1.uIGradient14.Rotation = 90

    v1.uIGradient14.Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.450125, 0.75),
      NumberSequenceKeypoint.new(0.695761, 1), NumberSequenceKeypoint.new(0.987531, 0.99375),
      NumberSequenceKeypoint.new(1, 1),
    })

    v1.uIGradient14.Parent = v1.shadow
    v1.shadow.Parent = v1.colorFrame1
    v1.colorFrame1.Parent = v1.toggleComponent4
    v1.toggleComponent4.Parent = v1.holder5
    v1.toggleComponent5 = Instance.new("Frame")
    v1.toggleComponent5.Name = "Toggle_Component"
    v1.toggleComponent5.AnchorPoint = Vector2.new(0.5, 0)
    v1.toggleComponent5.BackgroundTransparency = 1
    v1.toggleComponent5.Position = UDim2.fromScale(0.5, 0)
    v1.toggleComponent5.Size = UDim2.fromOffset(312, 30)
    v1.toggleName6 = Instance.new("TextLabel")
    v1.toggleName6.Name = "Toggle_Name"
    v1.toggleName6.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName6.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName6.BackgroundTransparency = 1
    v1.toggleName6.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName6.Position = UDim2.new(0, 48, 0.5, 0)
    v1.toggleName6.Size = UDim2.fromOffset(1, 1)
    v1.toggleName6.Text = "Example Toggle"
    v1.toggleName6.TextColor3 = Color3.new(1, 1, 1)
    v1.toggleName6.TextSize = 12
    v1.toggleName6.Parent = v1.toggleComponent5
    v1.toggle6 = Instance.new("Frame")
    v1.toggle6.Name = "Toggle"
    v1.toggle6.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggle6.BackgroundColor3 = Color3.fromRGB(231, 231, 231)
    v1.toggle6.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggle6.Size = UDim2.fromOffset(14, 14)
    v1.checkIcon4 = Instance.new("ImageLabel")
    v1.checkIcon4.Name = "Check_Icon"
    v1.checkIcon4.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.checkIcon4.BackgroundTransparency = 1
    v1.checkIcon4.Image = "rbxassetid://83899464799881"
    v1.checkIcon4.Position = UDim2.fromScale(0.5, 0.5)
    v1.checkIcon4.Size = UDim2.fromOffset(8, 7)
    v1.checkIcon4.Parent = v1.toggle6
    v1.uICorner49 = Instance.new("UICorner")
    v1.uICorner49.Name = "UICorner"
    v1.uICorner49.CornerRadius = UDim.new(0, 3)
    v1.uICorner49.Parent = v1.toggle6
    v1.uIGradient15 = Instance.new("UIGradient")
    v1.uIGradient15.Name = "UIGradient"

    v1.uIGradient15.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient15.Parent = v1.toggle6
    v1.toggle6.Parent = v1.toggleComponent5
    v1.toggleComponent5.Parent = v1.holder5
    v1.sliderComponent1 = Instance.new("Frame")
    v1.sliderComponent1.Name = "Slider_Component"
    v1.sliderComponent1.Active = true
    v1.sliderComponent1.AnchorPoint = Vector2.new(0.5, 0)
    v1.sliderComponent1.BackgroundTransparency = 1
    v1.sliderComponent1.Position = UDim2.fromScale(0.5, 0.762195)
    v1.sliderComponent1.Size = UDim2.fromOffset(312, 40)
    v1.value2 = Instance.new("TextLabel")
    v1.value2.Name = "Value"
    v1.value2.AnchorPoint = Vector2.new(1, 0.5)
    v1.value2.AutomaticSize = Enum.AutomaticSize.XY
    v1.value2.BackgroundTransparency = 1
    v1.value2.FontFace = Font.new("rbxassetid://12187365364")
    v1.value2.Position = UDim2.new(1, -22, 0.5, -8)
    v1.value2.Size = UDim2.fromOffset(1, 1)
    v1.value2.Text = "100"
    v1.value2.TextColor3 = Color3.new(1, 1, 1)
    v1.value2.TextSize = 14
    v1.value2.Parent = v1.sliderComponent1
    v1.sliderText1 = Instance.new("TextLabel")
    v1.sliderText1.Name = "Slider_Text"
    v1.sliderText1.AnchorPoint = Vector2.new(0, 0.5)
    v1.sliderText1.AutomaticSize = Enum.AutomaticSize.XY
    v1.sliderText1.BackgroundTransparency = 1
    v1.sliderText1.FontFace = Font.new("rbxassetid://12187365364")
    v1.sliderText1.Position = UDim2.new(0, 23, 0.5, -8)
    v1.sliderText1.Size = UDim2.fromOffset(1, 1)
    v1.sliderText1.Text = "Example Slider"
    v1.sliderText1.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.sliderText1.TextSize = 14
    v1.sliderText1.Parent = v1.sliderComponent1
    v1.progressBG1 = Instance.new("Frame")
    v1.progressBG1.Name = "Progress_BG"
    v1.progressBG1.AnchorPoint = Vector2.new(0, 0.5)
    v1.progressBG1.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.progressBG1.Position = UDim2.new(0.0128205, 19, 0.53125, 13)
    v1.progressBG1.Size = UDim2.fromOffset(266, 4)
    v1.progress1 = Instance.new("Frame")
    v1.progress1.Name = "Progress"
    v1.progress1.AnchorPoint = Vector2.new(0, 0.5)
    v1.progress1.BackgroundColor3 = Color3.fromRGB(232, 232, 232)
    v1.progress1.Position = UDim2.fromScale(0, 0.5)
    v1.progress1.Size = UDim2.fromOffset(171, 7)
    v1.uICorner50 = Instance.new("UICorner")
    v1.uICorner50.Name = "UICorner"
    v1.uICorner50.Parent = v1.progress1
    v1.uIGradient16 = Instance.new("UIGradient")
    v1.uIGradient16.Name = "UIGradient"

    v1.uIGradient16.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient16.Parent = v1.progress1
    v1.pointer1 = Instance.new("Frame")
    v1.pointer1.Name = "Pointer"
    v1.pointer1.AnchorPoint = Vector2.new(1, 0.5)
    v1.pointer1.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.pointer1.Position = UDim2.fromScale(1, 0.5)
    v1.pointer1.Size = UDim2.fromOffset(6, 6)
    v1.uICorner51 = Instance.new("UICorner")
    v1.uICorner51.Name = "UICorner"
    v1.uICorner51.Parent = v1.pointer1
    v1.design1 = Instance.new("Frame")
    v1.design1.Name = "Design"
    v1.design1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.design1.BackgroundColor3 = Color3.new(1, 1, 1)
    v1.design1.BackgroundTransparency = 0.5
    v1.design1.Position = UDim2.fromScale(0.5, 0.5)
    v1.design1.Size = UDim2.fromOffset(14, 14)
    v1.uICorner52 = Instance.new("UICorner")
    v1.uICorner52.Name = "UICorner"
    v1.uICorner52.Parent = v1.design1
    v1.design1.Parent = v1.pointer1
    v1.pointer1.Parent = v1.progress1
    v1.progress1.Parent = v1.progressBG1
    v1.uIStroke7 = Instance.new("UIStroke")
    v1.uIStroke7.Name = "UIStroke"
    v1.uIStroke7.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke7.Parent = v1.progressBG1
    v1.uICorner53 = Instance.new("UICorner")
    v1.uICorner53.Name = "UICorner"
    v1.uICorner53.Parent = v1.progressBG1
    v1.progressBG1.Parent = v1.sliderComponent1
    v1.sliderComponent1.Parent = v1.holder5
    v1.keybindComponent1 = Instance.new("Frame")
    v1.keybindComponent1.Name = "Keybind_Component"
    v1.keybindComponent1.AnchorPoint = Vector2.new(0.5, 0)
    v1.keybindComponent1.BackgroundTransparency = 1
    v1.keybindComponent1.Position = UDim2.fromScale(0.5, 0.71885)
    v1.keybindComponent1.Size = UDim2.fromOffset(312, 50)
    v1.toggleName7 = Instance.new("TextLabel")
    v1.toggleName7.Name = "Toggle_Name"
    v1.toggleName7.AnchorPoint = Vector2.new(0, 0.5)
    v1.toggleName7.AutomaticSize = Enum.AutomaticSize.XY
    v1.toggleName7.BackgroundTransparency = 1
    v1.toggleName7.FontFace = Font.new("rbxassetid://12187365364")
    v1.toggleName7.Position = UDim2.new(0, 25, 0.5, 0)
    v1.toggleName7.Size = UDim2.fromOffset(1, 1)
    v1.toggleName7.Text = "Example Keybind"
    v1.toggleName7.TextColor3 = Color3.new(1, 1, 1)
    v1.toggleName7.TextSize = 12
    v1.toggleName7.Parent = v1.keybindComponent1
    v1.holder6 = Instance.new("Frame")
    v1.holder6.Name = "Holder"
    v1.holder6.AnchorPoint = Vector2.new(1, 0.5)
    v1.holder6.AutomaticSize = Enum.AutomaticSize.XY
    v1.holder6.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.holder6.ClipsDescendants = true
    v1.holder6.Position = UDim2.new(1, -23, 0.5, 0)
    v1.holder6.Size = UDim2.fromOffset(16, 16)
    v1.value3 = Instance.new("TextLabel")
    v1.value3.Name = "Value"
    v1.value3.AnchorPoint = Vector2.new(0, 0.5)
    v1.value3.AutomaticSize = Enum.AutomaticSize.XY
    v1.value3.BackgroundTransparency = 1

    v1.value3.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal
    )

    v1.value3.Position = UDim2.new(0, 19, 0.5, 0)
    v1.value3.Size = UDim2.fromOffset(1, 1)
    v1.value3.Text = "NONE"
    v1.value3.TextColor3 = Color3.new(1, 1, 1)
    v1.value3.TextSize = 10
    v1.uIPadding12 = Instance.new("UIPadding")
    v1.uIPadding12.Name = "UIPadding"
    v1.uIPadding12.PaddingBottom = UDim.new(0, 4)
    v1.uIPadding12.PaddingLeft = UDim.new(0, 4)
    v1.uIPadding12.PaddingRight = UDim.new(0, 10)
    v1.uIPadding12.PaddingTop = UDim.new(0, 6)
    v1.uIPadding12.Parent = v1.value3
    v1.line5 = Instance.new("Frame")
    v1.line5.Name = "Line"
    v1.line5.AnchorPoint = Vector2.new(1, 0.5)
    v1.line5.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line5.Position = UDim2.new(1, 13, 0.5, 0)
    v1.line5.Size = UDim2.fromOffset(6, 13)
    v1.uICorner54 = Instance.new("UICorner")
    v1.uICorner54.Name = "UICorner"
    v1.uICorner54.CornerRadius = UDim.new(0, 30)
    v1.uICorner54.Parent = v1.line5
    v1.line6 = Instance.new("Frame")
    v1.line6.Name = "Line"
    v1.line6.AnchorPoint = Vector2.new(1, 0.5)
    v1.line6.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line6.Position = UDim2.new(1, 13, 0.5, 0)
    v1.line6.Size = UDim2.fromOffset(6, 13)
    v1.uICorner55 = Instance.new("UICorner")
    v1.uICorner55.Name = "UICorner"
    v1.uICorner55.CornerRadius = UDim.new(0, 30)
    v1.uICorner55.Parent = v1.line6
    v1.line6.Parent = v1.line5
    v1.line5.Parent = v1.value3
    v1.value3.Parent = v1.holder6
    v1.iconHolder1 = Instance.new("Frame")
    v1.iconHolder1.Name = "Icon_Holder"
    v1.iconHolder1.BackgroundTransparency = 1
    v1.iconHolder1.Position = UDim2.fromScale(0.04, -0.327869)
    v1.iconHolder1.Size = UDim2.fromOffset(22, 22)
    v1.imageLabel2 = Instance.new("ImageLabel")
    v1.imageLabel2.Name = "ImageLabel"
    v1.imageLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.imageLabel2.BackgroundTransparency = 1
    v1.imageLabel2.Image = "rbxassetid://127406982390736"
    v1.imageLabel2.ImageColor3 = Color3.fromRGB(254, 254, 254)
    v1.imageLabel2.Position = UDim2.fromScale(0.5, 0.5)
    v1.imageLabel2.ScaleType = Enum.ScaleType.Fit
    v1.imageLabel2.Size = UDim2.fromOffset(15, 15)
    v1.uIGradient17 = Instance.new("UIGradient")
    v1.uIGradient17.Name = "UIGradient"

    v1.uIGradient17.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient17.Parent = v1.imageLabel2
    v1.imageLabel2.Parent = v1.iconHolder1
    v1.iconHolder1.Parent = v1.holder6
    v1.uIStroke8 = Instance.new("UIStroke")
    v1.uIStroke8.Name = "UIStroke"
    v1.uIStroke8.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke8.Parent = v1.holder6
    v1.uIListLayout6 = Instance.new("UIListLayout")
    v1.uIListLayout6.Name = "UIListLayout"
    v1.uIListLayout6.FillDirection = Enum.FillDirection.Horizontal
    v1.uIListLayout6.Parent = v1.holder6
    v1.uICorner56 = Instance.new("UICorner")
    v1.uICorner56.Name = "UICorner"
    v1.uICorner56.CornerRadius = UDim.new(0, 3)
    v1.uICorner56.Parent = v1.holder6
    v1.holder6.Parent = v1.keybindComponent1
    v1.keybindComponent1.Parent = v1.holder5
    v1.dropdownComponent1 = Instance.new("Frame")
    v1.dropdownComponent1.Name = "Dropdown_Component"
    v1.dropdownComponent1.AnchorPoint = Vector2.new(0.5, 0)
    v1.dropdownComponent1.BackgroundTransparency = 1
    v1.dropdownComponent1.Position = UDim2.fromScale(0.5, 0.762332)
    v1.dropdownComponent1.Size = UDim2.fromOffset(312, 55)
    v1.dropdownName1 = Instance.new("TextLabel")
    v1.dropdownName1.Name = "Dropdown_Name"
    v1.dropdownName1.AutomaticSize = Enum.AutomaticSize.XY
    v1.dropdownName1.BackgroundTransparency = 1
    v1.dropdownName1.FontFace = Font.new("rbxassetid://12187365364")
    v1.dropdownName1.Position = UDim2.fromOffset(25, 12)
    v1.dropdownName1.Size = UDim2.fromOffset(1, 1)
    v1.dropdownName1.Text = "Example Dropdown"
    v1.dropdownName1.TextColor3 = Color3.fromRGB(204, 204, 209)
    v1.dropdownName1.TextSize = 12
    v1.dropdownName1.Parent = v1.dropdownComponent1
    v1.holder7 = Instance.new("Frame")
    v1.holder7.Name = "Holder"
    v1.holder7.AnchorPoint = Vector2.new(0.5, 1)
    v1.holder7.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.holder7.ClipsDescendants = true
    v1.holder7.Position = UDim2.fromScale(0.503205, 1)
    v1.holder7.Size = UDim2.fromOffset(264, 22)
    v1.uIStroke9 = Instance.new("UIStroke")
    v1.uIStroke9.Name = "UIStroke"
    v1.uIStroke9.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke9.Parent = v1.holder7
    v1.uICorner57 = Instance.new("UICorner")
    v1.uICorner57.Name = "UICorner"
    v1.uICorner57.CornerRadius = UDim.new(0, 2)
    v1.uICorner57.Parent = v1.holder7
    v1.line7 = Instance.new("Frame")
    v1.line7.Name = "Line"
    v1.line7.AnchorPoint = Vector2.new(1, 0.5)
    v1.line7.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line7.Position = UDim2.new(1, 4, 0.5, 0)
    v1.line7.Size = UDim2.fromOffset(6, 13)
    v1.uICorner58 = Instance.new("UICorner")
    v1.uICorner58.Name = "UICorner"
    v1.uICorner58.CornerRadius = UDim.new(0, 30)
    v1.uICorner58.Parent = v1.line7
    v1.uIGradient18 = Instance.new("UIGradient")
    v1.uIGradient18.Name = "UIGradient"

    v1.uIGradient18.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient18.Parent = v1.line7
    v1.line7.Parent = v1.holder7
    v1.line8 = Instance.new("Frame")
    v1.line8.Name = "Line"
    v1.line8.AnchorPoint = Vector2.new(0, 0.5)
    v1.line8.BackgroundColor3 = Color3.fromRGB(254, 254, 254)
    v1.line8.Position = UDim2.new(0, -4, 0.5, 0)
    v1.line8.Size = UDim2.fromOffset(6, 13)
    v1.uICorner59 = Instance.new("UICorner")
    v1.uICorner59.Name = "UICorner"
    v1.uICorner59.CornerRadius = UDim.new(0, 30)
    v1.uICorner59.Parent = v1.line8
    v1.uIGradient19 = Instance.new("UIGradient")
    v1.uIGradient19.Name = "UIGradient"

    v1.uIGradient19.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient19.Parent = v1.line8
    v1.line8.Parent = v1.holder7
    v1.options1 = Instance.new("TextLabel")
    v1.options1.Name = "Options"
    v1.options1.AnchorPoint = Vector2.new(0, 0.5)
    v1.options1.AutomaticSize = Enum.AutomaticSize.XY
    v1.options1.BackgroundTransparency = 1

    v1.options1.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.options1.Position = UDim2.fromScale(0.025, 0.5)
    v1.options1.Size = UDim2.fromOffset(1, 1)
    v1.options1.Text = "Option 1, Option 2 , Option 3"
    v1.options1.TextColor3 = Color3.fromRGB(254, 254, 254)
    v1.options1.TextSize = 13
    v1.uIGradient20 = Instance.new("UIGradient")
    v1.uIGradient20.Name = "UIGradient"

    v1.uIGradient20.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 254, 254)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 147, 147)),
    })

    v1.uIGradient20.Parent = v1.options1
    v1.options1.Parent = v1.holder7
    v1.holder7.Parent = v1.dropdownComponent1
    v1.dropdownComponent1.Parent = v1.holder5
    v1.buttonComponent2 = Instance.new("Frame")
    v1.buttonComponent2.Name = "Button_Component"
    v1.buttonComponent2.AnchorPoint = Vector2.new(0.5, 0)
    v1.buttonComponent2.BackgroundTransparency = 1
    v1.buttonComponent2.Position = UDim2.fromScale(0.5, 0.848214)
    v1.buttonComponent2.Size = UDim2.fromOffset(312, 40)
    v1.button2 = Instance.new("Frame")
    v1.button2.Name = "Button"
    v1.button2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.button2.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.button2.Position = UDim2.fromScale(0.5, 0.5)
    v1.button2.Size = UDim2.fromOffset(251, 30)
    v1.uICorner60 = Instance.new("UICorner")
    v1.uICorner60.Name = "UICorner"
    v1.uICorner60.CornerRadius = UDim.new(0, 3)
    v1.uICorner60.Parent = v1.button2
    v1.buttonText2 = Instance.new("TextLabel")
    v1.buttonText2.Name = "Button_Text"
    v1.buttonText2.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.buttonText2.AutomaticSize = Enum.AutomaticSize.XY
    v1.buttonText2.BackgroundTransparency = 1

    v1.buttonText2.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.buttonText2.Position = UDim2.fromScale(0.5, 0.5)
    v1.buttonText2.Size = UDim2.fromOffset(1, 1)
    v1.buttonText2.Text = "Example Button"
    v1.buttonText2.TextColor3 = Color3.fromRGB(69, 71, 90)
    v1.buttonText2.TextSize = 13
    v1.buttonText2.Parent = v1.button2
    v1.uIStroke10 = Instance.new("UIStroke")
    v1.uIStroke10.Name = "UIStroke"
    v1.uIStroke10.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke10.Parent = v1.button2
    v1.button2.Parent = v1.buttonComponent2
    v1.buttonComponent2.Parent = v1.holder5
    v1.buttonComponent3 = Instance.new("Frame")
    v1.buttonComponent3.Name = "Button_Component"
    v1.buttonComponent3.AnchorPoint = Vector2.new(0.5, 0)
    v1.buttonComponent3.BackgroundTransparency = 1
    v1.buttonComponent3.Position = UDim2.fromScale(0.5, 0.848214)
    v1.buttonComponent3.Size = UDim2.fromOffset(312, 43)
    v1.button3 = Instance.new("Frame")
    v1.button3.Name = "Button"
    v1.button3.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.button3.BackgroundColor3 = Color3.fromRGB(230, 255, 2)
    v1.button3.BackgroundTransparency = 0.95
    v1.button3.Position = UDim2.fromScale(0.5, 0.5)
    v1.button3.Size = UDim2.fromOffset(251, 30)
    v1.uICorner61 = Instance.new("UICorner")
    v1.uICorner61.Name = "UICorner"
    v1.uICorner61.CornerRadius = UDim.new(0, 3)
    v1.uICorner61.Parent = v1.button3
    v1.buttonText3 = Instance.new("TextLabel")
    v1.buttonText3.Name = "Button_Text"
    v1.buttonText3.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.buttonText3.AutomaticSize = Enum.AutomaticSize.XY
    v1.buttonText3.BackgroundTransparency = 1

    v1.buttonText3.FontFace = Font.new(
      "rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal
    )

    v1.buttonText3.Position = UDim2.fromScale(0.5, 0.5)
    v1.buttonText3.Size = UDim2.fromOffset(1, 1)
    v1.buttonText3.Text = "Custom Color Button"
    v1.buttonText3.TextColor3 = Color3.fromRGB(230, 255, 2)
    v1.buttonText3.TextSize = 13
    v1.buttonText3.Parent = v1.button3
    v1.uIStroke11 = Instance.new("UIStroke")
    v1.uIStroke11.Name = "UIStroke"
    v1.uIStroke11.Color = Color3.fromRGB(230, 255, 2)
    v1.uIStroke11.Transparency = 0.5
    v1.uIStroke11.Parent = v1.button3
    v1.button3.Parent = v1.buttonComponent3
    v1.buttonComponent3.Parent = v1.holder5
    v1.holder5.Parent = v1.header2
    v1.uICorner62 = Instance.new("UICorner")
    v1.uICorner62.Name = "UICorner"
    v1.uICorner62.CornerRadius = UDim.new(0, 6)
    v1.uICorner62.Parent = v1.header2
    v1.liner3 = Instance.new("Frame")
    v1.liner3.Name = "Liner"
    v1.liner3.AnchorPoint = Vector2.new(0.5, 1)
    v1.liner3.BackgroundColor3 = Color3.fromRGB(26, 26, 37)
    v1.liner3.BorderColor3 = Color3.new()
    v1.liner3.BorderSizePixel = 0
    v1.liner3.Position = UDim2.fromScale(0.5, 1)
    v1.liner3.Size = UDim2.new(1, 1, 0, 1)
    v1.liner3.Parent = v1.header2
    v1.headerHolder1 = Instance.new("Frame")
    v1.headerHolder1.Name = "Header_Holder"
    v1.headerHolder1.AnchorPoint = Vector2.new(0.5, 0.5)
    v1.headerHolder1.BackgroundTransparency = 1
    v1.headerHolder1.ClipsDescendants = true
    v1.headerHolder1.Position = UDim2.fromScale(0.5, 0.5)
    v1.headerHolder1.Size = UDim2.fromOffset(281, 30)
    v1.sectionName1 = Instance.new("TextLabel")
    v1.sectionName1.Name = "Section_Name"
    v1.sectionName1.AnchorPoint = Vector2.new(0, 0.5)
    v1.sectionName1.AutomaticSize = Enum.AutomaticSize.XY
    v1.sectionName1.BackgroundTransparency = 1
    v1.sectionName1.FontFace = Font.new("rbxassetid://12187365364")
    v1.sectionName1.Position = UDim2.new(0, 35, 0.5, 0)
    v1.sectionName1.Size = UDim2.fromOffset(1, 1)
    v1.sectionName1.Text = "Rage Exploits"
    v1.sectionName1.TextColor3 = Color3.new(1, 1, 1)
    v1.sectionName1.TextSize = 12
    v1.sectionName1.Parent = v1.headerHolder1
    v1.line9 = Instance.new("Frame")
    v1.line9.Name = "Line"
    v1.line9.AnchorPoint = Vector2.new(0, 0.5)
    v1.line9.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    v1.line9.Position = UDim2.new(0, -3, 0.5, 0)
    v1.line9.Size = UDim2.fromOffset(6, 20)
    v1.uICorner63 = Instance.new("UICorner")
    v1.uICorner63.Name = "UICorner"
    v1.uICorner63.CornerRadius = UDim.new(0, 30)
    v1.uICorner63.Parent = v1.line9
    v1.line9.Parent = v1.headerHolder1
    v1.imageLabel3 = Instance.new("ImageLabel")
    v1.imageLabel3.Name = "ImageLabel"
    v1.imageLabel3.AnchorPoint = Vector2.new(0, 0.5)
    v1.imageLabel3.BackgroundTransparency = 1
    v1.imageLabel3.Image = "rbxassetid://115620161683984"
    v1.imageLabel3.Position = UDim2.new(0, 12, 0.5, 0)
    v1.imageLabel3.ScaleType = Enum.ScaleType.Fit
    v1.imageLabel3.Size = UDim2.fromOffset(15, 15)
    v1.imageLabel3.Parent = v1.headerHolder1
    v1.toggle7 = Instance.new("Frame")
    v1.toggle7.Name = "Toggle"
    v1.toggle7.AnchorPoint = Vector2.new(1, 0.5)
    v1.toggle7.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
    v1.toggle7.Position = UDim2.new(1, -12, 0.5, 0)
    v1.toggle7.Size = UDim2.fromOffset(16, 16)
    v1.uIStroke12 = Instance.new("UIStroke")
    v1.uIStroke12.Name = "UIStroke"
    v1.uIStroke12.Color = Color3.fromRGB(28, 30, 38)
    v1.uIStroke12.Parent = v1.toggle7
    v1.uICorner64 = Instance.new("UICorner")
    v1.uICorner64.Name = "UICorner"
    v1.uICorner64.CornerRadius = UDim.new(0, 3)
    v1.uICorner64.Parent = v1.toggle7
    v1.toggle7.Parent = v1.headerHolder1
    v1.headerHolder1.Parent = v1.header2
    v1.header2.Parent = v1.sectionRight
    v1.uICorner65 = Instance.new("UICorner")
    v1.uICorner65.Name = "UICorner"
    v1.uICorner65.CornerRadius = UDim.new(0, 6)
    v1.uICorner65.Parent = v1.sectionRight
    v1.sectionRight.Parent = v1.container
    v1.container.Parent = v1.page
    v1.page.Parent = v1.mainFrame
    v1.mainFrame.Parent = v1.ironiteion

    return v1
  end

  local v2 = players
  local v3 = userInputService
  local v4 = runService
  local v5 = httpService
  local v6 = tweenService
  local v7 = guiService
  local v8 = {}

  do
    local function f1()
      local v9 = getcustomasset or getsynasset

      if type(writefile) ~= "function" or type(v9) ~= "function" then
        warn("[Patch Hub] Logo requires writefile and getcustomasset support")
        return ""
      end

      local v10 = "patch_hub_logo_optimized.png"

      local ok, result = pcall(function()
        if type(isfile) ~= "function" or not isfile(v10) then
          local v11 = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAG80lEQVR42t1bC0wTdxg/kJe8WqwVFASLbIVNHNNRYOAAEyASVoOKRMGy4SgvxxBIhhuio5kxhG1si8bihkyZ0zkVgUwTStjsDK+sajJsLVPDozxSgrTQXtu7I8upcSCFPu6u1/JPvhDCtdzv973+/+/7/gBAwnJzcwPCw8NdOBxOSHZ29qbo6GhPOp0OLPvl4uICcLncKLFY3AxDsAr5f+lkshFhZWUlGyVnWS4fHx97QbvgBIIgEIIgs4tJT0/PBQaDsXJZgff09AS6urpOLQV8rvT3/3vD19d3xbIhoKamZu8LU581Vi5evFi6LMAHBQU5KRRKqSngUdFotBMsFsvL5gmo4/Oz52kf1gMY1k9Ca2vrFzYNPjg42HlmZuaRqdqfYwVPExMSaDZLQENDQ/FSGl5gBXqeu3/v/teOjo62Bz48nEXRaDRyQ2ZuSCAIAhMSEtbbHAFXr179zFhfNyQdHR3f2dvb2w74pKTEVSAIYtb+HCuYSUlJ8bMZAlpaWo5jAaxPBAKBbVgBl8ulgyD4VK/2MViCTgep2Wy2v1WDd3BwAHp6e2tNBmrk3kAkEtVbdUY4ePBgABq18Tb/OaLjcDhMqwRPo9EAqVR6xiQtm2oVCDIrkUjOo5ZmdWv//swABEZATOCNe06XmZnxulWBd3d3B0Qi0QWzTRs2jYgnT55cXrnSikoGubl5oQiCwAT6/kuZff4TycnJCbMK8L6+voBYLLmCo4kbJQ/6HjQ5OzuTT8DRo5VRphY7cHIVpKSkJIJU8B4eHsDQ4FCHRcDrkb6+vmYnJyfyCCgvL0/AmtYwClxU9HE4KeA3btwIyOUTt3E2a5NleHi4DbVEiy8ejxdPFuhXpbi4+D2Lgvf397cbHx//C1dwsPlkjY+P/xEQsN7OIuDRI+mhQ0VsgiL7LILAZhFZWlqabBECmEzmCqVS+Y/FtGwkEWNjYyI6nU58weDkyZP7zTJ3mPi0WF1dnU4o+OjobQ5yubzPZHDmFkVM/NzQ0JCIRqMRZwVNTU0fkq1lQ8Kr4u0lBDyDwXBUKBSPLAIUg2vJ5XLxmjVr8G+sXrp0iUsaSBPl7NmzmbiCDw0NdQVBUGYxM4ex/V2tVj8ODg5xwtH3b3xiES3D+H1nQ0MDFxfwYWFhbmqVepiUoAabv08AQfDx1q3vuGDX/rVr5aRGdgwu19jYWIQJ/J49eyharVZOhJ8SdS6Y317XjIaFhbmaTcCtW7eO471ZITQz6Pl8c0tzmVll9KSkJLpOBylw1Q5seVI0Gg06akMxCbyXlxcgFApPEPKyMIFpcZHnrl+/XmESAcnJyTSNRjNlTVtcLO+BxjEWi0U1Cjw6zSm8LawhorlJJhkCgaDKKAJSU1P9IAhSk/7yML6nRZ0OUsbFxdENtreFQuH3tpLnTZW2trZqtI236GKz2QwIgjTWEsHxbq5COkiVmprqu2itr7u7+wxpWodxygbw0lnhzp07p/SO2qSlpTEwDTfAOPiqBdwBgiDV+ykp6xe0t/v7+3+yilRngdgiEonOzWupFRYWbjI0x2+NQQ3D/4ezsrLefElAZ2fnD2QCmn3W9jdxYALjGeSe6O45V1fXZ3V+B5VKJbeAdmGlUimRiMWXJRLJlwqFolAul38glUo5TU1Nua2trZ/39vb+ODEx0YXAiIqwWsKL30E1qGAymc7AgcwDbxGldRiGp8Vi8S+nT5/eFRUZRUUHqdAIjN4gCQkJQY/bgLe397x4hF6eysjIcK6rq3tvbHT0G51ON0JQ6QzJzMwIB44dO5aCt89NT08/5vP5hXHx8R4bNmww6yhOpVLRXSnA4XAceDzersGBQSHOgxhIWVlZKnCk/Ahufb6pqamB+vr6rJiYGEe8x1o3b94MVFRUxMlksm68CKioqEgDcnJyWDjkaKi9vf2rLVvedsd78vTV5efnt0IqleZrtdoprCTk5eXFAiwWyxVebL7PCAKUSuVQaWnpNkve99u5cyewb9++wLGxsb8xEADFxsauAgIDA4Hh4eFmc25zjIyM/Lljxw5vskZ0IiIiPAcHBq6YQ8Do6GgHg8F4/kX5+fnRCwKMgQgrkUjQC46kzqmhcWb16tV2fX19vCUDpB4s6HzTvK2wRCL51lj2ent6TgYFBdkBVrLWrl2Ltu4KjB3W7OzsrFswY5ifn+/Q1dV13pDf/NzY+Om6deusblY5Ly8PuPn7zY8MHeju3b37a2Jiov6ZewqFYldbW8uZnJx8dQJE+/Dhw+aqqqoIq5zUnuMS6enpb8hkst9gGJ5HxOTkpJjP52dTqVR7gxVhJpNpt3v37qCSkpLtBQUFMfHx8asoFApgKysyMhLNbp65ubnvHj58eHt6evprPj4+el32Py6FGvjmbHUqAAAAAElFTkSuQmCC"

          local base64decode = crypt and crypt.base64decode
            or syn and syn.crypt and syn.crypt.base64.decode or bit32 and bit32.base64_decode
            or base64_decode

          if type(base64decode) == "function" then
            local ok2, result2 = pcall(base64decode, v11)

            if ok2 and result2 then
              writefile(v10, result2)
              return v9("patch_hub_logo_optimized.png")
            end
          end

          local v12 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
          local v13 = {}

          for i = 1, #v12 do
            v13[string.byte(v12, i)] = i - 1
          end

          local list = {}

          for j = 1, #v11, 4 do
            local v14, v15, v16, v17 = string.byte(v11, j, j + 3)

            local v18 = (v13[v14] or 0) * 262144 + (v13[v15] or 0) * 4096 + (v13[v16] or 0) * 64
              + (v13[v17] or 0)

            local rounded = math.floor(v18 / 65536)
            local v19 = math.floor(v18 / 256) % 256
            local v20 = v18 % 256

            if v16 == 61 then
              list[#list + 1] = string.char(rounded)
            elseif v17 == 61 then
              list[#list + 1] = string.char(rounded, v19)
            else
              list[#list + 1] = string.char(rounded, v19, v20)
            end
          end

          writefile(v10, table.concat(list))
        end

        return v9("patch_hub_logo_optimized.png")
      end)

      if ok and type(result) == "string" and result ~= "" then
        return result
      end

      warn("[Patch Hub] Could not load the embedded logo: " .. tostring(result))
      return ""
    end

    v8.Logo = f1()
    v8.LogoRectOffset = Vector2.new(0, 0)
    v8.LogoRectSize = Vector2.new(0, 0)
  end

  local v21 = {}
  v21.__index = v21

  local index = {}
  index.__index = index

  local index2 = {}
  index2.__index = index2

  local index3 = {}
  index3.__index = index3

  local index4 = {}
  index4.__index = index4

  local color = Color3.fromRGB(231, 231, 231)
  local color2 = Color3.fromRGB(204, 204, 209)
  local color3 = Color3.fromRGB(116, 119, 140)
  local color4 = Color3.fromRGB(24, 25, 32)
  local seen = {}
  local v22 = "PatchHubCursor_" .. tostring(v8)

  local function f2()
    v3.MouseBehavior = Enum.MouseBehavior.Default
    v3.MouseIconEnabled = true
  end

  local v23

  function v21:_syncCursor()
    local focused = not self._destroyed and self._visible and self.Gui.Enabled
      and self.UnlockCursor and not self.Mobile and self._focused and not v7.MenuIsOpen

    self._cursorButton.Modal = focused == true

    if focused and not seen[self] then
      if not next(seen) then
        v23 = { Behavior = v3.MouseBehavior, Icon = v3.MouseIconEnabled }
        v4:BindToRenderStep(v22, Enum.RenderPriority.Last.Value + 1, f2)
      end

      seen[self] = true
      f2()
    elseif not focused and seen[self] then
      seen[self] = nil

      if not next(seen) then
        v4:UnbindFromRenderStep(v22)

        if v23 then
          v3.MouseBehavior = v7.MenuIsOpen and Enum.MouseBehavior.Default or v23.Behavior
          v3.MouseIconEnabled = v7.MenuIsOpen or v23.Icon
          v23 = nil
        end
      end
    end
  end

  function v21:SetUnlockCursor(p1)
    if self._destroyed then
      return
    end

    self.UnlockCursor = p1 == true
    self:_syncCursor()
  end

  function v21:SetToggleKey(rightShift)
    rightShift = rightShift or Enum.KeyCode.RightShift

    assert(typeof(rightShift) == "EnumItem" and rightShift.EnumType == Enum.KeyCode
      and rightShift ~= Enum.KeyCode.Unknown and rightShift ~= Enum.KeyCode.Escape
      and rightShift ~= Enum.KeyCode.ButtonStart, "Choose a key other than Roblox's reserved menu key")

    self.ToggleKey = rightShift

    if self.Restore and not self.Mobile then
      self.Restore.Text = self._title .. " [" .. rightShift.Name .. "]"
    end
  end

  function v21:AddSettings(p2)
    assert(p2.Window == self, "Settings section belongs to another window")

    local addKeybind = p2:AddKeybind({
      Id = "HubToggleKey",
      Name = "Hide / show key",
      Default = self.ToggleKey,
      Changed = function(p3) self:SetToggleKey(p3) end,
    })

    local normalize = addKeybind._normalize

    function addKeybind:_normalize(p4)
      local rightShift2 = normalize(self, p4) or Enum.KeyCode.RightShift

      if rightShift2 == Enum.KeyCode.Escape or rightShift2 == Enum.KeyCode.ButtonStart then
        return self._value or Enum.KeyCode.RightShift
      end

      return rightShift2
    end

    p2:AddToggle({
      Id = "HubUnlockCursor",
      Name = "Unlock mouse while hub is open",
      Default = self.UnlockCursor,
      Callback = function(value) self:SetUnlockCursor(value) end,
    })

    return addKeybind
  end

  local function getInstance(p5, parent, p6)
    local instance = Instance.new(p5)

    for key, value2 in pairs(p6 or {}) do
      instance[key] = value2
    end

    instance.Parent = parent
    return instance
  end

  local function getConnect(p7, p8, p9)
    local connect = p8:Connect(p9)
    table.insert(p7._connections, connect)
    return connect
  end

  local function f3(popup)
    for _, value3 in ipairs(popup._connections) do
      value3:Disconnect()
    end

    table.clear(popup._connections)
  end

  local function f4(window, key2)
    local tweens = window._tweens and window._tweens[key2]

    if not tweens then
      return
    end

    window._tweens[key2] = nil

    tweens.Connection:Disconnect()
    tweens.DestroyConnection:Disconnect()
    tweens.Tween:Cancel()
  end

  local function f5(popup2)
    if not popup2._tweens then
      return
    end

    local list2 = {}

    for key3 in pairs(popup2._tweens) do
      table.insert(list2, key3)
    end

    for _, value4 in ipairs(list2) do
      f4(popup2, value4)
    end
  end

  local function f6(p10, key4, map, drag, p11)
    local window2 = p10.Window or p10
    local tweens2 = p10._tweens and p10._tweens[key4]

    if tweens2 then
      local copy = table.clone(tweens2.Goals)

      for key5, value5 in pairs(map) do
        copy[key5] = value5
      end

      map = copy
    end

    f4(p10, key4)

    if window2._destroyed or p10._destroyed then
      return
    end

    if window2.Animations == false then
      for key6, value6 in pairs(map) do
        key4[key6] = value6
      end

      if p11 then
        p11()
      end

      return
    end

    p10._tweens = p10._tweens or {}

    local create = v6:Create(key4, TweenInfo.new(
      (drag or 0.16) / window2.AnimationSpeed, Enum.EasingStyle.Quint, Enum.EasingDirection.Out
    ), map)

    local v24 = { Tween = create, Goals = map }
    p10._tweens[key4] = v24

    v24.Connection = create.Completed:Connect(function(p12)
      if p10._tweens[key4] ~= v24 then
        return
      end

      p10._tweens[key4] = nil

      v24.Connection:Disconnect()
      v24.DestroyConnection:Disconnect()

      if p12 == Enum.PlaybackState.Completed and not window2._destroyed and not p10._destroyed
        and p11 then
        p11()
      end
    end)

    v24.DestroyConnection = key4.Destroying:Connect(function() f4(p10, key4) end)

    create:Play()
  end

  local function f7(p13, ...)
    if type(p13) ~= "function" then
      return
    end

    local packed = table.pack(...)

    task.spawn(function()
      local ok3, result3 = pcall(p13, table.unpack(packed, 1, packed.n))

      if not ok3 then
        warn("[Patch Hub callback] " .. tostring(result3))
      end
    end)
  end

  local function getCopy(value7)
    return typeof(value7) == "table" and table.clone(value7) or value7
  end

  local function f8(old, value8)
    if typeof(old) ~= "table" or typeof(value8) ~= "table" then
      return old == value8
    end

    if #old ~= #value8 then
      return false
    end

    for index5, value9 in ipairs(old) do
      if value8[index5] ~= value9 then
        return false
      end
    end

    return true
  end

  local function f9(p14)
    return type(p14) == "number" and p14 == p14 and math.abs(p14) < math.huge
  end

  local function f10(p15, text, udim, udim2)
    return getInstance("TextLabel", p15, {
      BackgroundTransparency = 1,
      Text = text,
      TextColor3 = color2,
      Font = Enum.Font.Gotham,
      TextSize = 12,
      TextXAlignment = Enum.TextXAlignment.Left,
      Position = udim or UDim2.fromOffset(12, 0),
      Size = udim2 or UDim2.new(1, -24, 1, 0),
      TextTruncate = Enum.TextTruncate.AtEnd,
    })
  end

  local function f11(p16)
    return getInstance("TextButton", p16, {
      Name = "Input",
      Text = "",
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),
      ZIndex = p16.ZIndex + 2,
      AutoButtonColor = false,
    })
  end

  local function f12(restore, p17)
    getInstance("UICorner", restore, { CornerRadius = UDim.new(0, p17 or 4) })
  end

  local function f13(p18, p19)
    return getInstance("UIListLayout", p18, {
      SortOrder = Enum.SortOrder.LayoutOrder,
      Padding = UDim.new(0, p19 or 4),
    })
  end

  local function f14(instance2)
    for _, value10 in ipairs(instance2:GetChildren()) do
      if value10:IsA("GuiObject") then
        value10:Destroy()
      end
    end
  end

  local function f15(p20, color5)
    p20.AutomaticSize = Enum.AutomaticSize.None
    p20.Size = UDim2.new(1, -color5, 0, 20)
    p20.TextTruncate = Enum.TextTruncate.AtEnd
    p20.TextXAlignment = Enum.TextXAlignment.Left
  end

  local function f16(p21)
    return p21.UserInputType == Enum.UserInputType.MouseButton1
      or p21.UserInputType == Enum.UserInputType.Touch
  end

  local function f17(p22, restore2, p23, p24)
    p23 = p23 or restore2
    restore2.AutoButtonColor = false

    local instance3 = getInstance("Frame", p23, {
      Name = "InteractionGlow",
      BorderSizePixel = 0,
      BackgroundColor3 = color,
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),
      Active = false,
      ZIndex = p23.ZIndex + 1,
    })

    f12(instance3, 4)
    local flag, flag2 = false, false

    local function f18()
      local v25 = not p24 or p24()

      f6(
        p22, instance3,
        { BackgroundTransparency = v25 and (flag2 and 0.86 or flag and 0.96 or 1) or 1 }, 0.12
      )
    end

    getConnect(p22, restore2.MouseEnter, function()
      flag = true
      f18()
    end)

    getConnect(p22, restore2.MouseLeave, function()
      flag = false
      flag2 = false
      f18()
    end)

    getConnect(p22, restore2.SelectionGained, function()
      flag = true
      f18()
    end)

    getConnect(p22, restore2.SelectionLost, function()
      flag = false
      flag2 = false
      f18()
    end)

    getConnect(p22, restore2.InputBegan, function(p25)
      if f16(p25) then
        flag2 = true
        f18()
      end
    end)

    getConnect(p22, restore2.InputEnded, function(p26)
      if f16(p26) then
        flag2 = false
        f18()
      end
    end)

    getConnect(p22, restore2.Activated, function()
      if p24 and not p24() then
        return
      end

      flag2 = false
      f6(p22, instance3, { BackgroundTransparency = 0.88 }, 0.06, f18)
    end)
  end

  local function f19(p27, p28)
    local instance4 = getInstance("UIStroke", p28, {
      Color = color3,
      Transparency = 0.8,
      Thickness = 1,
    })

    getConnect(p27, p28.Focused, function()
      f6(p27, instance4, { Color = color, Transparency = 0.15 }, 0.18)
    end)

    getConnect(p27, p28.FocusLost, function()
      f6(p27, instance4, { Color = color3, Transparency = 0.8 }, 0.18)
    end)
  end

  local function f20(p29, p30, update, p31, onEnd)
    local window3 = p29.Window or p29

    getConnect(p29, p30.InputBegan, function(p32)
      if not f16(p32) or window3._destroyed or window3._drag or p31 and not p31() then
        return
      end

      window3._drag = { Input = p32, Update = update, OnEnd = onEnd }

      if p32.UserInputType == Enum.UserInputType.Touch and p29.Kind == "Slider" then
        local frame = p29.Section.Page.Frame

        window3._drag.ScrollFrame = frame
        window3._drag.WasScrolling = frame.ScrollingEnabled

        frame.ScrollingEnabled = false
      end

      update(p32.Position, true)
    end)
  end

  function v21:_endDrag()
    local drag2 = self._drag
    self._drag = nil

    if drag2 then
      if drag2.OnEnd then
        drag2.OnEnd()
      end

      if drag2.ScrollFrame then
        drag2.ScrollFrame.ScrollingEnabled = drag2.WasScrolling
      end
    end
  end

  function v21:_cancelCapture()
    if self._capture then
      local capture = self._capture
      self._capture = nil

      if not capture._destroyed then
        capture:_render()
      end
    end
  end

  function v21:_closePopup(p33)
    if self._popup then
      local popup3 = self._popup
      self._popup = nil

      if popup3.Owner then
        popup3.Owner._refresh = nil
      end

      if popup3.Owner and popup3.Owner._popupChanged then
        popup3.Owner:_popupChanged(false)
      end

      f3(popup3)
      f5(popup3)

      if p33 or self._destroyed then
        popup3.Frame:Destroy()
      else
        popup3.Frame.Active = false
        popup3.Frame.Interactable = false

        f6(self, popup3.Panel, { GroupTransparency = 1 }, 0.12)
        f6(self, popup3.Scale, { Scale = 0.96 }, 0.12)

        f6(self, popup3.Frame, { BackgroundTransparency = 1 }, 0.13, function()
          popup3.Frame:Destroy()
        end)
      end
    end

    self:_endDrag()
  end

  function v21:_openPopup(owner, p34, p35)
    self:_closePopup(true)
    self:_cancelCapture()

    local instance5 = getInstance("TextButton", self.Frame, {
      Name = "Popup",
      Text = "",
      AutoButtonColor = false,
      Size = UDim2.fromScale(1, 1),
      BackgroundColor3 = Color3.new(),
      BackgroundTransparency = 1,
      ZIndex = 50,
    })

    local instance6 = getInstance("CanvasGroup", instance5, {
      Active = true,
      GroupTransparency = 1,
      BackgroundColor3 = Color3.fromRGB(19, 20, 25),
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.fromScale(0.5, 0.5),
      Size = UDim2.fromOffset(290, p35),
      ZIndex = 51,
    })

    f12(instance6, 7)
    getInstance("UIStroke", instance6, { Color = Color3.fromRGB(50, 52, 66) })
    f10(instance6, p34, UDim2.fromOffset(12, 7), UDim2.new(1, -45, 0, 25))

    local instance7 = getInstance("TextButton", instance6, {
      Text = "X",
      Font = Enum.Font.Gotham,
      TextSize = 12,
      TextColor3 = color2,
      BackgroundTransparency = 1,
      Position = UDim2.new(1, -32, 0, 4),
      Size = UDim2.fromOffset(28, 28),
    })

    local popup4 = {
      _connections = {},
      Frame = instance5,
      Panel = instance6,
      Owner = owner,
      Window = self,
    }

    local lowest = math.min(
      1, ((self._width or 695) - 16) / 290, ((self._height or 489) - 16) / p35
    )

    popup4.Scale = getInstance("UIScale", instance6, { Scale = 0.96 * lowest })
    self._popup = popup4

    getConnect(popup4, instance5.Activated, function() self:_closePopup() end)
    getConnect(popup4, instance7.Activated, function() self:_closePopup() end)

    f17(popup4, instance7)

    f6(popup4, instance5, { BackgroundTransparency = 0.35 }, 0.2)
    f6(popup4, instance6, { GroupTransparency = 0 }, 0.2)
    f6(popup4, popup4.Scale, { Scale = lowest }, 0.24)

    return popup4
  end

  function v8:CreateWindow(text2)
    text2 = text2 or {}
    assert(v4:IsClient(), "Patch Hub must be required from a LocalScript on the client")
    local localPlayer = v2.LocalPlayer
    assert(localPlayer, "Patch Hub requires a LocalPlayer")
    local textLabel = makeTextLabel2()

    local instance8 = setmetatable({
      _connections = {},
      Tabs = {},
      Controls = {},
      Flags = {},
      _keybinds = {},
      _templates = {},
      _nextId = 0,
      _destroyed = false,
      _visible = true,
      _focused = true,
      UnlockCursor = text2.UnlockCursor ~= false,
      _title = text2.Title or "Patch Hub",
      Mobile = text2.Mobile == true or text2.Mobile == nil and v3.TouchEnabled == true,
      _width = 695,
      _height = 489,
      Animations = text2.Animations ~= false,
      AnimationSpeed = math.clamp(tonumber(text2.AnimationSpeed) or 1, 0.25, 4),
      ToggleKey = text2.ToggleKey or Enum.KeyCode.RightShift,
      Accent = text2.Accent or color,
      Gui = textLabel.ironiteion,
      Frame = textLabel.mainFrame,
      _design = textLabel,
    }, v21)

    instance8.Gui.Name = text2.Name or "Patch Hub"
    instance8.Gui.ResetOnSpawn = false
    instance8.Gui.IgnoreGuiInset = not instance8.Mobile

    instance8.Gui.ScreenInsets = instance8.Mobile and Enum.ScreenInsets.CoreUISafeInsets
      or Enum.ScreenInsets.None

    instance8.Gui.DisplayOrder = text2.DisplayOrder or 50

    local ok4, hui = pcall(gethui)

    local parent2 = text2.Parent or localPlayer:FindFirstChild("PlayerGui") or ok4 and hui
      or coreGui

    local name = text2.Name or "Patch Hub"

    pcall(function()
      local list3 = { parent2 }

      if ok4 and hui then
        table.insert(list3, hui)
      end

      pcall(function() table.insert(list3, coreGui) end)

      if localPlayer then
        local playerGui = localPlayer:FindFirstChild("PlayerGui")

        if playerGui then
          table.insert(list3, playerGui)
        end
      end

      for _, value11 in ipairs(list3) do
        if value11 then
          for _, value12 in ipairs(value11:GetChildren()) do
            if value12:IsA("ScreenGui") and value12 ~= instance8.Gui then
              local lower = value12.Name:lower()

              if lower == "patch hub" or lower == name:lower() or lower:find("patchhub")
                or value12:GetAttribute("PatchHub") then
                pcall(function() value12:Destroy() end)
              end
            end
          end
        end
      end
    end)

    pcall(function() instance8.Gui.Parent = parent2 end)

    instance8.PositionRoot = getInstance("Frame", instance8.Gui, {
      Name = "WindowPosition",
      BackgroundTransparency = 1,
      Size = UDim2.fromOffset(0, 0),
      Position = UDim2.fromScale(0.5, 0.5),
      Active = false,
    })

    instance8.Frame.Parent = instance8.PositionRoot
    instance8.Frame.Position = UDim2.fromOffset(0, 0)
    instance8.Frame.BorderSizePixel = 0

    textLabel.libaryName.RichText = false
    textLabel.libaryName.Text = text2.Title or "Patch Hub"

    local logo = text2.Logo or v8.Logo

    if logo and logo ~= "" then
      textLabel.libaryIcon.Image = logo
      textLabel.libaryIcon.ImageColor3 = Color3.new(1, 1, 1)

      local logoRectOffset = text2.LogoRectOffset or not text2.Logo and v8.LogoRectOffset
      local logoRectSize = text2.LogoRectSize or not text2.Logo and v8.LogoRectSize

      if logoRectOffset and logoRectOffset ~= Vector2.new(0, 0) then
        textLabel.libaryIcon.ImageRectOffset = logoRectOffset
      end

      if logoRectSize and logoRectSize ~= Vector2.new(0, 0) then
        textLabel.libaryIcon.ImageRectSize = logoRectSize
      end
    else
      textLabel.libaryIcon.Image = "rbxassetid://108488788823423"
      textLabel.libaryIcon.ImageColor3 = Color3.new(1, 1, 1)
    end

    textLabel.libaryName.AutomaticSize = Enum.AutomaticSize.None

    instance8.BrandRow = getInstance("Frame", textLabel.header, {
      Name = "BrandRow",
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(0, 0.5),
      Position = UDim2.new(0, 12, 0.5, 0),
      Size = UDim2.new(1, -300, 0, 24),
    })

    local v26 = f13(instance8.BrandRow, 6)
    v26.FillDirection = Enum.FillDirection.Horizontal
    v26.VerticalAlignment = Enum.VerticalAlignment.Center

    local parent3 = getInstance("Frame", instance8.BrandRow, {
      Name = "LogoSlot",
      BackgroundTransparency = 1,
      Size = UDim2.fromOffset(16, 24),
      LayoutOrder = 1,
    })

    textLabel.libaryIcon.Parent = parent3
    textLabel.libaryIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    textLabel.libaryIcon.Position = UDim2.new(0.5, 0, 0.5, 1)
    textLabel.libaryIcon.Size = UDim2.fromOffset(15, 15)
    textLabel.libaryIcon.LayoutOrder = 1
    textLabel.libaryName.Parent = instance8.BrandRow
    textLabel.libaryName.AnchorPoint = Vector2.new()
    textLabel.libaryName.Position = UDim2.new()
    textLabel.libaryName.Size = UDim2.fromOffset(76, 24)
    textLabel.libaryName.LayoutOrder = 2
    textLabel.libaryName.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.libaryName.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.libaryName.TextTruncate = Enum.TextTruncate.AtEnd

    instance8.GameLabel = f10(
      instance8.BrandRow, text2.GameName or text2.Subtitle or "UI Library", UDim2.new(),
      UDim2.new(1, -108, 0, 24)
    )

    instance8.GameLabel.Name = "GameName"
    instance8.GameLabel.LayoutOrder = 3
    instance8.GameLabel.TextColor3 = color3
    instance8.GameLabel.TextYAlignment = Enum.TextYAlignment.Center

    instance8.UpdateRow = getInstance("Frame", textLabel.header, {
      Name = "UpdateRow",
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -48, 0.5, 0),
      Size = UDim2.fromOffset(0, 24),
      AutomaticSize = Enum.AutomaticSize.X,
    })

    local v27 = f13(instance8.UpdateRow, 6)
    v27.FillDirection = Enum.FillDirection.Horizontal
    v27.VerticalAlignment = Enum.VerticalAlignment.Center

    textLabel.lastUpdated.Parent = instance8.UpdateRow
    textLabel.lastUpdated.AnchorPoint = Vector2.new()
    textLabel.lastUpdated.LayoutOrder = 2
    textLabel.lastUpdated.RichText = false
    textLabel.lastUpdated.Text = "Last updated " .. (text2.LastUpdated or "09/05/2026")
    textLabel.lastUpdated.AutomaticSize = Enum.AutomaticSize.X
    textLabel.lastUpdated.Size = UDim2.fromOffset(0, 24)
    textLabel.lastUpdated.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.lastUpdated.TextTruncate = Enum.TextTruncate.AtEnd
    textLabel.lastUpdated.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.lastUpdated.Position = UDim2.new()
    textLabel.icon.Parent = instance8.UpdateRow
    textLabel.icon.LayoutOrder = 1
    textLabel.icon.Visible = true
    textLabel.icon.AnchorPoint = Vector2.new()
    textLabel.icon.Position = UDim2.new()
    textLabel.icon.Size = UDim2.fromOffset(12, 12)

    local map2 = {
      Tab = textLabel.tab,
      SubTab = textLabel.subTab,
      Section = textLabel.sectionLeft,
      Toggle = textLabel.toggleComponent1,
      Slider = textLabel.sliderComponent,
      Keybind = textLabel.keybindComponent,
      Dropdown = textLabel.dropdownComponent,
      Button = textLabel.buttonComponent,
    }

    for key7, value13 in pairs(map2) do
      instance8._templates[key7] = value13:Clone()
    end

    f14(instance8._templates.Section.Header.Holder)
    f14(textLabel.holder)
    f14(textLabel.subHeader)

    textLabel.page:Destroy()
    textLabel.holder:Destroy()

    instance8.Sidebar = getInstance("ScrollingFrame", textLabel.sidebar, {
      Name = "Tabs",
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, -2, 1, 0),
      CanvasSize = UDim2.new(),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      ScrollBarThickness = 2,
    })

    local v28 = f13(instance8.Sidebar, 10)

    if instance8.Mobile then
      v28.FillDirection = Enum.FillDirection.Horizontal
    end

    getInstance("UIPadding", instance8.Sidebar, {
      PaddingTop = UDim.new(0, 10),
      PaddingLeft = UDim.new(0, 9),
      PaddingBottom = UDim.new(0, 10),
    })

    textLabel.subHeader:Destroy()

    instance8.SubHeader = getInstance("ScrollingFrame", instance8.Frame, {
      Name = "Sub-Header",
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Position = UDim2.fromOffset(75, 37),
      Size = UDim2.fromOffset(620, 51),
      CanvasSize = UDim2.new(),
      AutomaticCanvasSize = Enum.AutomaticSize.X,
      ScrollBarThickness = 2,
      ScrollingDirection = Enum.ScrollingDirection.X,
    })

    local v29 = f13(instance8.SubHeader, 10)
    v29.FillDirection = Enum.FillDirection.Horizontal
    v29.VerticalAlignment = Enum.VerticalAlignment.Center

    getInstance("UIPadding", instance8.SubHeader, {
      PaddingLeft = UDim.new(0, 12),
      PaddingRight = UDim.new(0, 12),
    })

    instance8.Content = getInstance("Frame", instance8.Frame, {
      Name = "Pages",
      BorderSizePixel = 0,
      BackgroundColor3 = Color3.fromRGB(16, 17, 21),
      ClipsDescendants = true,
      Position = UDim2.fromOffset(75, 88),
      Size = UDim2.fromOffset(620, 401),
    })

    instance8.Scale = getInstance("UIScale", instance8.Frame, { Scale = 1 })

    instance8._zoom = getInstance("NumberValue", instance8.Gui, {
      Name = "OpenAnimation",
      Value = 1,
    })

    instance8._baseScale = 1

    getConnect(instance8, instance8._zoom:GetPropertyChangedSignal("Value"), function()
      instance8.Scale.Scale = instance8._baseScale * instance8._zoom.Value
    end)

    instance8.Bounds = getInstance("Frame", instance8.Gui, {
      Name = "ViewportBounds",
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),
      Active = false,
      ZIndex = 0,
    })

    local function f21()
      local absoluteSize = instance8.Bounds.AbsoluteSize

      if absoluteSize.X < 1 or absoluteSize.Y < 1 then
        return
      end

      if instance8.Mobile then
        instance8._width = math.max(120, math.min(695, absoluteSize.X - 16))
        instance8._height = math.max(190, math.min(600, absoluteSize.Y - 76))
        instance8.Frame.Size = UDim2.fromOffset(instance8._width, instance8._height)

        textLabel.header.Size = UDim2.new(1, 0, 0, 48)
        textLabel.sidebar.Position = UDim2.fromOffset(0, 48)
        textLabel.sidebar.AnchorPoint = Vector2.new()
        textLabel.sidebar.Size = UDim2.new(1, 0, 0, 66)

        instance8.Sidebar.ScrollingDirection = Enum.ScrollingDirection.X
        instance8.Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.X
        instance8.SubHeader.Position = UDim2.fromOffset(0, 114)
        instance8.SubHeader.Size = UDim2.new(1, 0, 0, 48)
        instance8.Content.Position = UDim2.fromOffset(0, 162)
        instance8.Content.Size = UDim2.new(1, 0, 1, -162)

        local v30 = instance8._width < 560

        instance8.BrandRow.Position = v30 and UDim2.fromOffset(12, 14)
          or UDim2.new(0, 12, 0.5, 0)

        instance8.BrandRow.Size = UDim2.new(1, v30 and -66 or -270, 0, 24)
        instance8.UpdateRow.Size = UDim2.fromOffset(0, 20)

        textLabel.lastUpdated.Size = UDim2.fromOffset(0, 20)

        instance8.UpdateRow.Position = v30 and UDim2.new(1, -52, 0, 36)
          or UDim2.new(1, -52, 0.5, 0)

        instance8._singleColumn = instance8._width < 600

        for _, value14 in ipairs(instance8.Tabs) do
          for _, value15 in ipairs(value14.Pages) do
            value15:Resize()
          end
        end
      end

      instance8._baseScale = math.min(1, math.max(0.05, (absoluteSize.X - 16) / instance8._width), math.max(0.05, (absoluteSize.Y - (instance8.Mobile and 76 or 16))
        / instance8._height))

      instance8.Scale.Scale = instance8._baseScale * instance8._zoom.Value

      local position = instance8.PositionRoot.Position
      local v31, v32 = position.X.Scale * absoluteSize.X + position.X.Offset, position.Y.Scale * absoluteSize.Y + position.Y.Offset
      local v33, v34 = instance8._width * instance8._baseScale / 2, instance8._height * instance8._baseScale / 2
      local clamped = math.clamp(v31, v33, math.max(v33, absoluteSize.X - v33))
      local v35 = v34 + (instance8.Mobile and 60 or 0)
      local clamped2 = math.clamp(v32, v35, math.max(v35, absoluteSize.Y - v34))

      if clamped ~= v31 or clamped2 ~= v32 then
        instance8.PositionRoot.Position = UDim2.new(
          position.X.Scale, clamped - position.X.Scale * absoluteSize.X, position.Y.Scale,
          clamped2 - position.Y.Scale * absoluteSize.Y
        )
      end

      if instance8.Restore and instance8.Restore.AnchorPoint.X == 0 then
        local absoluteSize2 = instance8.Restore.AbsoluteSize
        local position2 = instance8.Restore.Position

        local clamped3 = math.clamp(
          position2.X.Offset, 4, math.max(4, absoluteSize.X - absoluteSize2.X - 4)
        )

        local clamped4 = math.clamp(
          position2.Y.Offset, 4, math.max(4, absoluteSize.Y - absoluteSize2.Y - 4)
        )

        instance8.Restore.Position = UDim2.fromOffset(clamped3, clamped4)
      end

      instance8:_closePopup(true)
    end

    getConnect(instance8, instance8.Bounds:GetPropertyChangedSignal("AbsoluteSize"), f21)
    f21()

    local instance9 = getInstance("TextButton", textLabel.header, {
      Name = "Hide",
      Text = "X",
      Font = Enum.Font.Gotham,
      TextSize = 12,
      TextColor3 = color3,
      BackgroundTransparency = 1,
      Position = UDim2.new(1, instance8.Mobile and -46 or -36, 0, 3),
      Size = UDim2.fromOffset(instance8.Mobile and 44 or 30, instance8.Mobile and 44 or 30),
      ZIndex = 5,
    })

    instance8._cursorButton = instance9
    getConnect(instance8, instance9.Activated, function() instance8:SetVisible(false) end)
    f17(instance8, instance9)

    instance8.Restore = getInstance("TextButton", instance8.Gui, {
      Name = "Restore",
      Text = text2.Title or "Patch Hub",
      Font = Enum.Font.Gotham,
      TextSize = 13,
      TextColor3 = color,
      BackgroundColor3 = color4,
      Position = UDim2.fromOffset(12, 60),
      Size = UDim2.fromOffset(205, 32),
      Visible = false,
    })

    instance8:SetToggleKey(instance8.ToggleKey)

    if instance8.Mobile then
      instance8.Restore.Name = "MobileToggle"
      instance8.Restore.AnchorPoint = Vector2.new(1, 0)
      instance8.Restore.Position = UDim2.new(1, -8, 0, 8)
      instance8.Restore.Size = UDim2.fromOffset(160, 48)
      instance8.Restore.Text = "Close " .. instance8._title
      instance8.Restore.Visible = true
      instance8.Restore.ZIndex = 100
    end

    f12(instance8.Restore, 6)
    local v36, vector, flag3 = nil, nil, false

    f20(instance8, instance8.Restore, function(p36, p37)
      if p37 then
        v36 = p36
        local absolutePosition = instance8.Restore.AbsolutePosition

        local absolutePosition2 = instance8.Bounds and instance8.Bounds.AbsolutePosition
          or Vector2.new(0, 0)

        vector = Vector2.new(
          absolutePosition.X - absolutePosition2.X, absolutePosition.Y - absolutePosition2.Y
        )

        flag3 = false
        return
      end

      local v37 = p36.X - v36.X
      local v38 = p36.Y - v36.Y

      if not flag3 and v37 * v37 + v38 * v38 < 25 then
        return
      end

      flag3 = true
      local absoluteSize3 = instance8.Bounds and instance8.Bounds.AbsoluteSize

      if not absoluteSize3 or absoluteSize3.X < 1 or absoluteSize3.Y < 1 then
        local currentCamera = workspace.CurrentCamera
        absoluteSize3 = currentCamera and currentCamera.ViewportSize or Vector2.new(800, 600)
      end

      local absoluteSize4 = instance8.Restore.AbsoluteSize

      if absoluteSize4.X < 1 or absoluteSize4.Y < 1 then
        absoluteSize4 = Vector2.new(160, 48)
      end

      local clamped5 = math.clamp(
        vector.X + v37, 4, math.max(4, absoluteSize3.X - absoluteSize4.X - 4)
      )

      local clamped6 = math.clamp(
        vector.Y + v38, 4, math.max(4, absoluteSize3.Y - absoluteSize4.Y - 4)
      )

      instance8.Restore.AnchorPoint = Vector2.new(0, 0)
      instance8.Restore.Position = UDim2.fromOffset(clamped5, clamped6)
    end, function() return not instance8._popup end, function() task.defer(function() flag3 = false end) end)

    getConnect(instance8, instance8.Restore.Activated, function()
      if flag3 then
        flag3 = false
        return
      end

      if instance8.Mobile then
        instance8:Toggle()
      else
        instance8:SetVisible(true)
      end
    end)

    f17(instance8, instance8.Restore)

    instance8.DragHandle = getInstance("TextButton", textLabel.header, {
      Name = "DragHandle",
      Text = "",
      AutoButtonColor = false,
      BackgroundTransparency = 1,
      Size = UDim2.new(1, instance8.Mobile and -48 or -40, 1, 0),
      ZIndex = 4,
    })

    local v39, position3, v40

    f20(instance8, instance8.DragHandle, function(p38, p39)
      if p39 then
        v39 = p38
        position3 = instance8.PositionRoot.Position
        v40 = false
        return
      end

-- https://leakd.fr
      local v41, v42 = p38.X - v39.X, p38.Y - v39.Y

      if not v40 and v41 * v41 + v42 * v42 < 16 then
        return
      end

      v40 = true
      local absoluteSize5 = instance8.Bounds.AbsoluteSize
      local v43, v44 = instance8._width * instance8._baseScale / 2, instance8._height * instance8._baseScale / 2
      local clamped7 = position3.X.Scale * absoluteSize5.X + position3.X.Offset + v41
      local clamped8 = position3.Y.Scale * absoluteSize5.Y + position3.Y.Offset + v42
      clamped7 = math.clamp(clamped7, v43, math.max(v43, absoluteSize5.X - v43))
      local v45 = v44 + (instance8.Mobile and 60 or 0)
      clamped8 = math.clamp(clamped8, v45, math.max(v45, absoluteSize5.Y - v44))

      instance8.PositionRoot.Position = UDim2.new(
        position3.X.Scale, clamped7 - position3.X.Scale * absoluteSize5.X, position3.Y.Scale,
        clamped8 - position3.Y.Scale * absoluteSize5.Y
      )
    end, function() return instance8._visible and not instance8._popup end)

    getConnect(instance8, v3.InputChanged, function(p40)
      local drag3 = instance8._drag

      if drag3
        and (p40 == drag3.Input
          or drag3.Input.UserInputType == Enum.UserInputType.MouseButton1
            and p40.UserInputType == Enum.UserInputType.MouseMovement) then
        drag3.Update(p40.Position, false)
      end
    end)

    getConnect(instance8, v3.InputEnded, function(p41)
      local drag4 = instance8._drag

      if drag4
        and (p41 == drag4.Input
          or p41.UserInputType == Enum.UserInputType.MouseButton1
            and drag4.Input.UserInputType == p41.UserInputType) then
        instance8:_endDrag()
      end
    end)

    getConnect(instance8, v3.WindowFocusReleased, function()
      instance8:_endDrag()
      instance8:_cancelCapture()
      instance8._focused = false
      instance8:_syncCursor()
    end)

    getConnect(instance8, v3.WindowFocused, function()
      instance8._focused = true
      instance8:_syncCursor()
    end)

    getConnect(instance8, instance8.Gui:GetPropertyChangedSignal("Enabled"), function()
      instance8:_syncCursor()
    end)

    getConnect(instance8, v7.MenuOpened, function() instance8:_syncCursor() end)
    getConnect(instance8, v7.MenuClosed, function() instance8:_syncCursor() end)

    getConnect(instance8, v3.InputBegan, function(p42, p43)
      if instance8._capture then
        if p42.UserInputType ~= Enum.UserInputType.Keyboard then
          return
        end

        local capture2 = instance8._capture
        instance8._capture = nil

        if p42.KeyCode == Enum.KeyCode.Escape then
          capture2:_render()
        elseif p42.KeyCode == Enum.KeyCode.Backspace or p42.KeyCode == Enum.KeyCode.Delete then
          capture2:Set(nil)
        else
          capture2:Set(p42.KeyCode)
        end

        return
      end

      if v3:GetFocusedTextBox() or v7.MenuIsOpen then
        return
      end

      if p42.KeyCode == instance8.ToggleKey then
        instance8:Toggle()
        return
      end

      if p43 then
        return
      end

      if instance8._popup and p42.KeyCode == Enum.KeyCode.Escape then
        instance8:_closePopup()
        return
      end

      for key8 in pairs(instance8._keybinds) do
        if key8._value == p42.KeyCode and key8:_interactive() then
          f7(key8._callback, p42.KeyCode)
        end
      end
    end)

    getConnect(instance8, instance8.Gui.Destroying, function() instance8:Destroy() end)

    instance8.Frame.GroupTransparency = 1
    instance8._zoom.Value = 0.96

    f6(instance8, instance8.Frame, { GroupTransparency = 0 }, 0.26)
    f6(instance8, instance8._zoom, { Value = 1 }, 0.3)

    instance8:_syncCursor()
    return instance8
  end

  function v21:SetVisible(p44)
    if self._destroyed then
      return
    end

    self:_closePopup(true)
    self:_cancelCapture()
    self._visible = p44 == true
    self:_syncCursor()
    self.Restore.Visible = self.Mobile or not self._visible

    if self.Mobile then
      self.Restore.Text = (self._visible and "Close " or "Open ") .. self._title
    end

    if self._visible then
      self.Frame.Visible = true
    end

    f6(self, self._zoom, { Value = self._visible and 1 or 0.96 }, 0.22)

    f6(self, self.Frame, { GroupTransparency = self._visible and 0 or 1 }, 0.2, function()
      if not self._visible then
        self.Frame.Visible = false
      end
    end)
  end

  function v21:Toggle()
    self:SetVisible(not self._visible)
  end

  function v21:Destroy()
    if self._destroyed then
      return
    end

    self._destroyed = true
    self:_syncCursor()
    self:_closePopup()
    self:_cancelCapture()

    local list4 = {}

    for _, value16 in pairs(self.Controls) do
      table.insert(list4, value16)
    end

    for _, value17 in ipairs(list4) do
      value17:Destroy()
    end

    f3(self)
    f5(self)

    for _, value18 in pairs(self._templates) do
      value18:Destroy()
    end

    pcall(function() self.Gui:Destroy() end)

    table.clear(self.Tabs)
    table.clear(self._keybinds)

    self._design = nil
  end

  function v21:CreateTab(p45)
    assert(not self._destroyed, "Window is destroyed")

    if type(p45) == "string" then
      p45 = { Name = p45 }
    end

    p45 = p45 or {}

    local clone = self._templates.Tab:Clone()
    clone.LayoutOrder = #self.Tabs + 1
    clone.Name = p45.Name or "Tab"

    if self.Mobile then
      clone.Size = UDim2.fromOffset(74, 48)
    end

    clone.Icon.TextLabel.Text = clone.Name
    clone.Icon.TextLabel.AutomaticSize = Enum.AutomaticSize.None
    clone.Icon.TextLabel.Size = UDim2.fromOffset(53, 18)
    clone.Icon.TextLabel.TextTruncate = Enum.TextTruncate.AtEnd

    if p45.Icon then
      clone.Icon.Image = tostring(p45.Icon):match("^%d+$") and "rbxassetid://" .. p45.Icon
        or p45.Icon
    end

    clone.Parent = self.Sidebar

    local v46 = setmetatable({
      Window = self,
      Frame = clone,
      Pages = {},
      Name = clone.Name,
    }, index)

    table.insert(self.Tabs, v46)
    local v47 = f11(clone)
    f17(self, v47, clone)

    getConnect(self, v47.Activated, function()
      if self._visible then
        v46:Select()
      end
    end)

    if not self.ActiveTab then
      v46:Select()
    else
      clone.BackgroundTransparency = 1
      clone.Frame.BackgroundTransparency = 1
    end

    return v46
  end

  function index:Select()
    local window4 = self.Window
    window4:_closePopup()
    window4:_cancelCapture()
    window4.ActiveTab = self

    for _, value19 in ipairs(window4.Tabs) do
      local v48 = value19 == self
      f6(window4, value19.Frame, { BackgroundTransparency = v48 and 0.9 or 1 }, 0.18)
      value19.Frame.Frame.Visible = true

      f6(
        window4, value19.Frame.Frame,
        { BackgroundTransparency = v48 and 0 or 1, Size = UDim2.fromOffset(v48 and 25 or 8, 6) },
        0.2
      )

      f6(window4, value19.Frame.Icon, { ImageColor3 = v48 and color or color3 }, 0.18)
      f6(window4, value19.Frame.Icon.TextLabel, { TextColor3 = v48 and color or color3 }, 0.18)

      for _, value20 in ipairs(value19.Pages) do
        value20.Button.Visible = v48
        value20.Frame.Visible = v48 and value20 == value19.ActivePage
      end
    end

    if self.ActivePage then
      self.ActivePage:Select()
    end

    window4.SubHeader.CanvasPosition = Vector2.new()
  end

  function index:CreateSubTab(p46)
    if type(p46) == "string" then
      p46 = { Name = p46 }
    end

    p46 = p46 or {}
    local window5 = self.Window

    local clone2 = window5._templates.SubTab:Clone()
    clone2.Name = p46.Name or "Page"
    clone2.AutomaticSize = Enum.AutomaticSize.None
    clone2.Size = UDim2.fromOffset(p46.Width or 105, window5.Mobile and 44 or 30)
    clone2.TabName.Text = clone2.Name
    clone2.TabName.AutomaticSize = Enum.AutomaticSize.None
    clone2.TabName.Size = UDim2.fromScale(1, 1)
    clone2.TabName.Position = UDim2.new()
    clone2.TabName.AnchorPoint = Vector2.new()
    clone2.TabName.TextTruncate = Enum.TextTruncate.AtEnd
    clone2.TabName.UIPadding.PaddingTop = UDim.new(0, 3)
    clone2.TabName.UIPadding.PaddingBottom = UDim.new(0, 3)
    clone2.LayoutOrder = #self.Pages + 1
    clone2.Visible = window5.ActiveTab == self
    clone2.Parent = window5.SubHeader

    local layer = getInstance("CanvasGroup", window5.Content, {
      Name = clone2.Name .. "Transition",
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),
      GroupTransparency = 0,
    })

    local instance10 = getInstance("ScrollingFrame", layer, {
      Name = clone2.Name,
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.fromScale(1, 1),
      CanvasSize = UDim2.new(),
      ScrollBarThickness = 3,
      ScrollBarImageColor3 = color3,
      Visible = false,
      ScrollingDirection = Enum.ScrollingDirection.Y,
    })

    local v49 = setmetatable({
      Window = window5,
      Tab = self,
      Button = clone2,
      Frame = instance10,
      Layer = layer,
      Sections = {},
    }, index2)

    v49.Left = getInstance("Frame", instance10, {
      Name = "Left",
      BackgroundTransparency = 1,
      Position = UDim2.fromOffset(12, 12),
      Size = UDim2.new(0.5, -22, 0, 0),
    })

    v49.Right = getInstance("Frame", instance10, {
      Name = "Right",
      BackgroundTransparency = 1,
      Position = UDim2.new(0.5, 0, 0, 12),
      Size = UDim2.new(0.5, -22, 0, 0),
    })

    local v50, v51 = f13(v49.Left, 12), f13(v49.Right, 12)

    function v49:Resize()
      local function f22(instance11)
        local total, count = 0, 0

        for _, value21 in ipairs(instance11:GetChildren()) do
          if value21:IsA("GuiObject") and value21.Visible then
            total = total + value21.Size.Y.Offset
            count = count + 1
          end
        end

        return total + math.max(0, count - 1) * 12
      end

      local v52, v53 = f22(v49.Left), f22(v49.Right)

      if window5._singleColumn then
        v49.Left.Size = UDim2.new(1, -24, 0, v52)
        v49.Right.Size = UDim2.new(1, -24, 0, v53)
        v49.Right.Position = UDim2.fromOffset(12, v52 + 24)

        instance10.CanvasSize = UDim2.fromOffset(0, v52 + v53 + 36)
      else
        v49.Left.Size = UDim2.new(0.5, -22, 0, v52)
        v49.Right.Size = UDim2.new(0.5, -22, 0, v53)
        v49.Right.Position = UDim2.new(0.5, 0, 0, 12)

        instance10.CanvasSize = UDim2.fromOffset(0, math.max(v52, v53) + 24)
      end
    end

    local function f23()
      v49:Resize()
    end

    getConnect(window5, v50:GetPropertyChangedSignal("AbsoluteContentSize"), f23)
    getConnect(window5, v51:GetPropertyChangedSignal("AbsoluteContentSize"), f23)

    table.insert(self.Pages, v49)
    v49:Resize()
    local v54 = f11(clone2)
    f17(window5, v54, clone2)

    getConnect(window5, v54.Activated, function()
      if window5._visible then
        v49:Select()
      end
    end)

    if not self.ActivePage then
      self.ActivePage = v49
    end

    if window5.ActiveTab == self then
      self.ActivePage:Select()
    end

    return v49
  end

  function index:CreateSection(p47)
    if not self.ActivePage then
      self:CreateSubTab("General")
    end

    return self.ActivePage:CreateSection(p47)
  end

  function index2:Select()
    local window6 = self.Window

    if window6.ActiveTab ~= self.Tab then
      self.Tab:Select()
    end

    window6:_closePopup()
    window6:_cancelCapture()

    self.Tab.ActivePage = self

    for _, value22 in ipairs(self.Tab.Pages) do
      local v55 = value22 == self
      value22.Frame.Visible = v55

      f6(
        window6, value22.Button.TabName,
        { BackgroundTransparency = v55 and 0.9 or 1, TextColor3 = v55 and color or color3 },
        0.18
      )

      value22.Button.Holder.Visible = true

      f6(window6, value22.Button.Holder, {
        BackgroundTransparency = v55 and 0 or 1,
        Size = UDim2.fromOffset(v55 and 34 or 10, 6),
      }, 0.2)
    end

    f4(window6, self.Layer)
    f4(window6, self.Frame)

    self.Layer.GroupTransparency = window6.Animations and 0.5 or 0
    self.Frame.Position = UDim2.fromOffset(window6.Animations and 10 or 0, 0)

    f6(window6, self.Layer, { GroupTransparency = 0 }, 0.2)
    f6(window6, self.Frame, { Position = UDim2.fromOffset(0, 0) }, 0.24)
  end

  function index2:CreateSection(p48)
    if type(p48) == "string" then
      p48 = { Name = p48 }
    end

    p48 = p48 or {}
    local window7 = self.Window

    local clone3 = window7._templates.Section:Clone()
    clone3.Name = p48.Name or "Section"
    clone3.AutomaticSize = Enum.AutomaticSize.None
    clone3.Size = UDim2.new(1, 0, 0, 45)
    clone3.BorderSizePixel = 0
    clone3.Header.Size = UDim2.new(1, 0, 0, 30)
    clone3.Header.Position = UDim2.fromScale(0.5, 0)

    local headerHolder = clone3.Header.Header_Holder
    headerHolder.Size = UDim2.new(1, 0, 0, 30)
    headerHolder.Section_Name.Text = clone3.Name

    f15(headerHolder.Section_Name, 70)

    if p48.Icon then
      headerHolder.ImageLabel.Image = tostring(p48.Icon):match("^%d+$")
          and "rbxassetid://" .. p48.Icon
        or p48.Icon
    end

    local holder = clone3.Header.Holder
    holder.AutomaticSize = Enum.AutomaticSize.None
    holder.AnchorPoint = Vector2.new()
    holder.Position = UDim2.fromOffset(0, 30)
    holder.Size = UDim2.new(1, 0, 0, 0)
    holder.Parent = clone3
    holder.UIPadding.PaddingBottom = UDim.new(0, 8)

    local v56 = setmetatable({
      Window = window7,
      Page = self,
      Frame = clone3,
      Body = holder,
      Enabled = p48.Enabled ~= false,
      Controls = {},
      _callback = p48.Callback,
    }, index3)

    clone3.LayoutOrder = #self.Sections + 1
    clone3.Parent = p48.Side == "Right" and self.Right or self.Left

    table.insert(self.Sections, v56)

    local function f24()
      local v57, count2 = 13, 0

      for _, value23 in ipairs(holder:GetChildren()) do
        if value23:IsA("GuiObject") and value23.Visible then
          v57 = v57 + value23.Size.Y.Offset
          count2 = count2 + 1
        end
      end

      v57 = v57 + math.max(0, count2 - 1) * 4
      holder.Size = UDim2.new(1, 0, 0, v57)
      clone3.Size = UDim2.new(1, 0, 0, 30 + v57)
    end

    getConnect(
      window7, holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), f24
    )

    local v58 = f11(headerHolder.Toggle)
    f17(window7, v58, headerHolder.Toggle)

    getConnect(window7, v58.Activated, function()
      if window7._visible then
        v56:SetEnabled(not v56.Enabled)
      end
    end)

    v56:SetEnabled(v56.Enabled, true)
    f24()
    return v56
  end

  function index3:SetEnabled(p49, p50)
    self.Enabled = p49 == true
    local toggle = self.Frame.Header.Header_Holder.Toggle

    f6(
      self.Window, toggle, { BackgroundColor3 = self.Enabled and self.Window.Accent or color4 },
      0.18
    )

    toggle.Check_Icon.Visible = true

    f6(self.Window, toggle.Check_Icon, {
      ImageTransparency = self.Enabled and 0 or 1,
      Size = UDim2.fromOffset(self.Enabled and 8 or 3, self.Enabled and 7 or 3),
    }, 0.16)

    f6(self.Window, self.Frame, {
      BackgroundColor3 = self.Enabled and Color3.fromRGB(17, 18, 22)
        or Color3.fromRGB(21, 22, 28),
    }, 0.2)

    for _, value24 in ipairs(self.Controls) do
      if not value24._destroyed then
        value24:_enabledVisual()
      end
    end

    if not self.Enabled then
      self.Window:_closePopup()
      self.Window:_cancelCapture()
    end

    if not p50 then
      f7(self._callback, self.Enabled)
    end
  end

  function index4:_interactive()
    return not self._destroyed and not self.Window._destroyed and self.Enabled
      and self.Section.Enabled and self.Frame.Visible and self.Window.Gui.Enabled
      and self.Window._visible and self.Section.Page.Frame.Visible and not self.Window._popup
  end

  function index4:_enabledVisual()
    if self._label then
      f6(
        self, self._label,
        { TextColor3 = self.Enabled and self.Section.Enabled and color2 or color3 }, 0.16
      )
    end
  end

  function index4:Get()
    return getCopy(self._value)
  end

  function index4:_commit(p51, p52)
    local value25 = self._value
    local v59 = f8(value25, p51)

    self._value = getCopy(p51)
    self.Window.Flags[self.Id] = getCopy(p51)
    self:_render()

    if not v59 and not p52 then
      if self.Kind == "Keybind" then
        f7(self._changed, self:Get())
      else
        f7(self._callback, self:Get())
      end
    end

    return self
  end

  function index4:Set(p53, p54)
    assert(not self._destroyed, "Control is destroyed")
    return self:_commit(self:_normalize(p53), p54)
  end

  function index4:SetEnabled(p55)
    self.Enabled = p55 == true
    self:_enabledVisual()

    if not self.Enabled then
      if self.Window._popup and self.Window._popup.Owner == self then
        self.Window:_closePopup()
      end

      if self.Window._capture == self then
        self.Window:_cancelCapture()
      end

      self.Window:_endDrag()
    end

    return self
  end

  function index4:SetVisible(p56)
    self.Frame.Visible = p56 == true

    if not self.Frame.Visible then
      if self.Window._popup and self.Window._popup.Owner == self then
        self.Window:_closePopup()
      end

      if self.Window._capture == self then
        self.Window:_cancelCapture()
      end

      self.Window:_endDrag()
    end

    return self
  end

  function index4:SetText(p57)
    self.Name = tostring(p57)

    if self._label then
      local v60 = self._label.Text ~= self.Name
      self._label.Text = self.Name

      if v60 then
        self._label.TextTransparency = self.Window.Animations and 0.4 or 0

        f6(self, self._label, {
          TextTransparency = 0,
          TextColor3 = self.Enabled and self.Section.Enabled and color2 or color3,
        }, 0.18)
      end
    end

    return self
  end

  function index4:Destroy()
    if self._destroyed then
      return
    end

    if self.Window._popup and self.Window._popup.Owner == self then
      self.Window:_closePopup()
    end

    if self.Window._capture == self then
      self.Window:_cancelCapture()
    end

    self.Window:_endDrag()
    self._destroyed = true

    f3(self)
    f5(self)

    self.Window.Controls[self.Id] = nil
    self.Window.Flags[self.Id] = nil
    self.Window._keybinds[self] = nil
    self.Frame:Destroy()
  end

  function index3:_control(key9, p58)
    p58 = p58 or {}
    local window8 = self.Window
    assert(not window8._destroyed, "Window is destroyed")
    window8._nextId = window8._nextId + 1
    local id = p58.Id or "control_" .. window8._nextId

    assert(
      type(id) == "string" and not window8.Controls[id],
      "Control Id must be a unique string: " .. tostring(id)
    )

    local instance12 = window8._templates[key9]

    local clone4 = instance12 and instance12:Clone() or getInstance("Frame", nil, {
      BackgroundTransparency = 1,
      Size = UDim2.fromOffset(281, 36),
    })

    clone4.Name = p58.Name or key9
    clone4.AnchorPoint = Vector2.new()
    clone4.Position = UDim2.new()

    clone4.Size = UDim2.new(1, 0, 0, window8.Mobile and math.max(48, clone4.Size.Y.Offset)
      or clone4.Size.Y.Offset)

    clone4.LayoutOrder = #self.Controls + 1
    clone4.Parent = self.Body

    local v61 = setmetatable({
      Window = window8,
      Section = self,
      Frame = clone4,
      Id = id,
      Kind = key9,
      Name = clone4.Name,
      Enabled = p58.Enabled ~= false,
      _connections = {},
      _callback = p58.Callback,
      _changed = p58.Changed,
      _destroyed = false,
    }, index4)

    window8.Controls[id] = v61
    table.insert(self.Controls, v61)
    return v61
  end

  function index3:AddToggle(p59)
    p59 = p59 or {}
    local control = self:_control("Toggle", p59)

    local frame2, window9 = control.Frame, self.Window
    frame2.ColorFrame:Destroy()
    frame2.Toggle.Position = UDim2.new(0, 12, 0.5, 0)
    frame2.Toggle_Name.Position = UDim2.new(0, 35, 0.5, 0)

    f15(frame2.Toggle_Name, p59.Color and 80 or 47)

    control._label = frame2.Toggle_Name
    control:SetText(control.Name)

    function control:_normalize(p60)
      assert(type(p60) == "boolean", "Toggle expects a boolean")
      return p60
    end

    function control:_render()
      f6(
        self, frame2.Toggle, { BackgroundColor3 = self._value and window9.Accent or color4 },
        0.16
      )

      frame2.Toggle.Check_Icon.Visible = true

      f6(self, frame2.Toggle.Check_Icon, {
        ImageTransparency = self._value and 0 or 1,
        Size = UDim2.fromOffset(self._value and 8 or 3, self._value and 7 or 3),
      }, 0.18)

      self:_enabledVisual()
    end

    local v62 = f11(frame2)

    if p59.Color then
      v62.Size = UDim2.new(1, -48, 1, 0)
    end

    f17(control, v62, v62, function() return control:_interactive() end)

    getConnect(control, v62.Activated, function()
      if control:_interactive() then
        control:Set(not control:Get())
      end
    end)

    control:Set(p59.Default == true, true)

    if p59.Color then
      local instance13 = getInstance("TextButton", frame2, {
        Name = "Color",
        Text = "",
        BackgroundColor3 = p59.Color,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(24, 14),
        ZIndex = 4,
      })

      f12(instance13, 3)
      f17(control, instance13, instance13, function() return control:_interactive() end)

      control._color = p59.Color

      function control.GetColor(p61)
        return p61._color
      end

      function control:SetColor(p62, p63)
        assert(typeof(p62) == "Color3", "Color must be a Color3")
        local v63 = self._color ~= p62
        self._color = p62
        f6(self, instance13, { BackgroundColor3 = p62 }, 0.12)

        if v63 and not p63 then
          f7(p59.ColorCallback, p62)
        end
      end

      getConnect(control, instance13.Activated, function()
        if control:_interactive() then
          window9:_colorPopup(control, control._color, function(p64) control:SetColor(p64) end)
        end
      end)
    end

    return control
  end

  function index3:AddSlider(text3)
    text3 = text3 or {}
    local min, max, step = text3.Min or 0, text3.Max or 100, text3.Step or 1

    assert(
      f9(min) and f9(max) and f9(step) and max > min and step > 0,
      "Slider requires finite Min < Max and Step > 0"
    )

    local control2 = self:_control("Slider", text3)

    local frame3 = control2.Frame
    frame3.Slider_Text.Position = UDim2.new(0, 12, 0.5, -8)

    f15(frame3.Slider_Text, 90)
    frame3.Value.Position = UDim2.new(1, -12, 0.5, -8)

    control2._label = frame3.Slider_Text
    control2:SetText(control2.Name)

    local progressBG = frame3.Progress_BG
    progressBG.Position = UDim2.new(0, 12, 1, -7)
    progressBG.Size = UDim2.new(1, -24, 0, 4)

    local decimals = text3.Decimals

    if decimals == nil then
      decimals = 0

      while decimals < 6
        and math.abs(step * 10 ^ decimals - math.floor(step * 10 ^ decimals + 0.5)) > 0.000001 do
        decimals = decimals + 1
      end
    end

    assert(
      f9(decimals) and decimals >= 0 and decimals <= 6 and decimals % 1 == 0,
      "Decimals must be an integer from 0 to 6"
    )

    function control2:_normalize(clamped9)
      assert(f9(clamped9), "Slider expects a finite number")
      clamped9 = math.clamp(clamped9, min, max)

      if clamped9 == max then
        return max
      end

      return math.clamp(min + math.floor((clamped9 - min) / step + 0.5) * step, min, max)
    end

    function control2:_render()
      f6(self, progressBG.Progress, {
        Size = UDim2.new((self._value - min) / (max - min), 0, 0, 7),
        BackgroundColor3 = self.Window.Accent,
      }, self.Window._drag and 0.06 or 0.2)

      frame3.Value.Text = string.format("%." .. decimals .. "f", self._value)
        .. (text3.Suffix or "")

      self:_enabledVisual()
    end

    local v64 = f11(progressBG)
    v64.Size = UDim2.new(1, 0, 0, self.Window.Mobile and 32 or 22)
    v64.Position = UDim2.fromOffset(0, self.Window.Mobile and -23 or -9)

    f17(control2, v64, v64, function() return control2:_interactive() end)

    getConnect(control2, v64.MouseEnter, function()
      if control2:_interactive() then
        f6(control2, progressBG.Progress.Pointer, { Size = UDim2.fromOffset(9, 9) }, 0.12)
      end
    end)

    getConnect(control2, v64.MouseLeave, function()
      f6(control2, progressBG.Progress.Pointer, { Size = UDim2.fromOffset(6, 6) }, 0.12)
    end)

    f20(control2, v64, function(p65)
      if not control2:_interactive() then
        return
      end

      local clamped10 = math.clamp((p65.X - progressBG.AbsolutePosition.X)
        / math.max(1, progressBG.AbsoluteSize.X), 0, 1)

      control2:Set(min + (max - min) * clamped10)
    end, function() return control2:_interactive() end)

    getConnect(control2, v64.InputBegan, function(p66)
      if not control2:_interactive() then
        return
      end

      if p66.KeyCode == Enum.KeyCode.Left then
        control2:Set(control2:Get() - step)
      elseif p66.KeyCode == Enum.KeyCode.Right then
        control2:Set(control2:Get() + step)
      end
    end)

    control2:Set(text3.Default or min, true)
    return control2
  end

  function index3:AddButton(p67)
    p67 = p67 or {}
    local control3 = self:_control("Button", p67)

    local button = control3.Frame.Button
    button.Size = UDim2.new(1, -24, 0, self.Window.Mobile and 44 or 30)

    control3._label = button.Button_Text
    control3:SetText(control3.Name)

    button.Button_Text.AutomaticSize = Enum.AutomaticSize.None
    button.Button_Text.Size = UDim2.new(1, -12, 1, 0)
    button.Button_Text.TextTruncate = Enum.TextTruncate.AtEnd

    if p67.Color then
      button.UIStroke.Color = p67.Color
      button.BackgroundColor3 = p67.Color
      button.BackgroundTransparency = 0.95
    end

    function control3:_enabledVisual()
      f6(self, self._label, {
        TextColor3 = self.Enabled and self.Section.Enabled and (p67.Color or color2) or color3,
      }, 0.16)
    end

    function control3:_render()
      self:_enabledVisual()
    end

    function control3:Press()
      if self:_interactive() then
        f7(self._callback)
      end
    end

    local v65 = f11(button)
    f17(control3, v65, button, function() return control3:_interactive() end)

    getConnect(control3, v65.Activated, function() control3:Press() end)

    getConnect(control3, v65.MouseEnter, function()
      if control3:_interactive() then
        if p67.Color then
          f6(control3, button, { BackgroundTransparency = 0.85 }, 0.16)
        else
          f6(control3, button, { BackgroundColor3 = Color3.fromRGB(33, 35, 45) }, 0.16)
        end
      end
    end)

    getConnect(control3, v65.MouseLeave, function()
      if p67.Color then
        f6(control3, button, { BackgroundTransparency = 0.95 }, 0.16)
      else
        f6(control3, button, { BackgroundColor3 = color4 }, 0.16)
      end
    end)

    control3:_render()
    return control3
  end

  function index3:AddKeybind(p68)
    p68 = p68 or {}
    local control4 = self:_control("Keybind", p68)

    local frame4 = control4.Frame
    frame4.Holder:Destroy()
    frame4.Toggle_Name.Position = UDim2.new(0, 12, 0.5, 0)

    f15(frame4.Toggle_Name, 120)

    control4._label = frame4.Toggle_Name
    control4:SetText(control4.Name)

    local instance14 = getInstance("TextButton", frame4, {
      Text = "NONE",
      BackgroundColor3 = color4,
      TextColor3 = color,
      Font = Enum.Font.GothamMedium,
      TextSize = 10,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -12, 0.5, 0),
      Size = UDim2.fromOffset(98, 24),
    })

    f12(instance14)
    f17(control4, instance14, instance14, function() return control4:_interactive() end)

    function control4:_normalize(key10)
      if key10 == nil or key10 == "NONE" or key10 == Enum.KeyCode.Unknown then
        return nil
      end

      if type(key10) == "string" then
        local ok5, result4 = pcall(function() return Enum.KeyCode[key10] end)
        assert(ok5 and result4, "Unknown key name: " .. key10)
        key10 = result4
      end

      assert(
        typeof(key10) == "EnumItem" and key10.EnumType == Enum.KeyCode,
        "Keybind expects an Enum.KeyCode or nil"
      )

      if key10 == Enum.KeyCode.Unknown then
        return nil
      end

      return key10
    end

    function control4:_render()
      instance14.Text = self._value and self._value.Name or "NONE"
      f6(self, instance14, { BackgroundColor3 = color4, TextColor3 = color }, 0.18)
      self:_enabledVisual()
    end

    getConnect(control4, instance14.Activated, function()
      if not control4:_interactive() then
        return
      end

      control4.Window:_cancelCapture()
      control4.Window._capture = control4

      instance14.Text = "Press a key..."

      f6(
        control4, instance14,
        { BackgroundColor3 = Color3.fromRGB(49, 51, 64), TextColor3 = control4.Window.Accent },
        0.18
      )
    end)

    self.Window._keybinds[control4] = true
    control4:Set(p68.Default, true)
    return control4
  end

  function index3.AddDropdown(p69, p70)
    p70 = p70 or {}
    local control5 = p69:_control("Dropdown", p70)

    local frame5 = control5.Frame
    frame5.Dropdown_Name.Position = UDim2.fromOffset(12, 2)

    f15(frame5.Dropdown_Name, 24)

    control5._label = frame5.Dropdown_Name
    control5:SetText(control5.Name)

    frame5.Holder.Size = UDim2.new(1, -24, 0, 25)
    frame5.Holder.Position = UDim2.new(0.5, 0, 1, -3)

    f15(frame5.Holder.Options, 28)
    frame5.Holder.Options.Position = UDim2.new(0, 8, 0.5, 0)

    local v66 = f10(frame5.Holder, "v", UDim2.new(1, -18, 0, 0), UDim2.fromOffset(15, 25))
    v66.TextXAlignment = Enum.TextXAlignment.Center

    function control5:_popupChanged(p71)
      f6(self, v66, { Rotation = p71 and 180 or 0 }, 0.18)
    end

    control5.Multi = p70.Multi == true
    control5.Options = {}

    local function f25(options)
      assert(type(options) == "table", "Dropdown Options must be an array of strings")
      local list5, seen2 = {}, {}

      for _, value26 in ipairs(options) do
        assert(type(value26) == "string", "Dropdown options must be strings")

        if not seen2[value26] then
          table.insert(list5, value26)
          seen2[value26] = true
        end
      end

      return list5
    end

    function control5:_normalize(list6)
      if self.Multi then
        assert(type(list6) == "table", "Multi dropdown expects an array")
        local seen3, list7 = {}, {}

        for _, value27 in ipairs(list6) do
          assert(
            table.find(self.Options, value27), "Unknown dropdown option: " .. tostring(value27)
          )

          seen3[value27] = true
        end

        for _, value28 in ipairs(self.Options) do
          if seen3[value28] then
            table.insert(list7, value28)
          end
        end

        return list7
      end

      assert(
        list6 == nil or table.find(self.Options, list6),
        "Unknown dropdown option: " .. tostring(list6)
      )

      return list6
    end

    function control5:_render()
      frame5.Holder.Options.Text = self.Multi
          and (#self._value > 0 and table.concat(self._value, ", ") or "Select...")
        or self._value
        or "Select..."

      self:_enabledVisual()

      if self._refresh then
        self._refresh()
      end
    end

    function control5.SetOptions(p72, p73, p74)
      local v67 = f25(p73)

      p72.Window:_closePopup()
      p72.Options = v67

      local get = p72:Get()

      if p72.Multi then
        local list8 = {}

        for _, value29 in ipairs(get or {}) do
          if table.find(v67, value29) then
            table.insert(list8, value29)
          end
        end

        p72:Set(list8, p74)
      else
        p72:Set(table.find(v67, get) and get or nil, p74)
      end

      return p72
    end

    control5.Options = f25(p70.Options or p70.Items or {})
    control5:Set(p70.Default or control5.Multi and {} or nil, true)

    local v68 = f11(frame5.Holder)
    f17(control5, v68, frame5.Holder, function() return control5:_interactive() end)

    getConnect(control5, v68.Activated, function()
      if not control5:_interactive() then
        return
      end

      local openPopup = control5.Window:_openPopup(control5, control5.Name, 310)
      control5:_popupChanged(true)

      local instance15 = getInstance("TextBox", openPopup.Panel, {
        PlaceholderText = "Search options...",
        Text = "",
        ClearTextOnFocus = false,
        BackgroundColor3 = color4,
        TextColor3 = color2,
        PlaceholderColor3 = color3,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        Position = UDim2.fromOffset(12, 40),
        Size = UDim2.new(1, -24, 0, 28),
      })

      f12(instance15)
      f19(openPopup, instance15)

      local instance16 = getInstance("ScrollingFrame", openPopup.Panel, {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(12, 76),
        Size = UDim2.new(1, -24, 1, -88),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
      })

      f13(instance16, 4)
      local list9 = {}

      for index6, value30 in ipairs(control5.Options) do
        local instance17 = getInstance("TextButton", instance16, {
          Text = value30,
          Font = Enum.Font.Gotham,
          TextSize = 12,
          TextColor3 = color2,
          BackgroundColor3 = color4,
          Size = UDim2.new(1, -5, 0, 28),
          LayoutOrder = index6,
          TextTruncate = Enum.TextTruncate.AtEnd,
        })

        f12(instance17)
        f17(openPopup, instance17)
        table.insert(list9, { Button = instance17, Value = value30 })

        getConnect(openPopup, instance17.Activated, function()
          if control5.Multi then
            local get2 = control5:Get()
            local position4 = table.find(get2, value30)

            if position4 then
              table.remove(get2, position4)
            else
              table.insert(get2, value30)
            end

            control5:Set(get2)
          else
            control5:Set(value30)
            control5.Window:_closePopup()
          end
        end)
      end

      local v69 = f10(instance16, "No matching options", UDim2.new(), UDim2.new(1, -5, 0, 28))
      v69.LayoutOrder = #list9 + 1

      local function f26()
        if control5.Window._popup ~= openPopup then
          return
        end

        local count3 = 0

        for _, value31 in ipairs(list9) do
          local multi = control5.Multi and table.find(control5._value, value31.Value) ~= nil
            or control5._value == value31.Value

          f6(
            openPopup, value31.Button,
            { BackgroundColor3 = multi and Color3.fromRGB(49, 51, 64) or color4 }, 0.16
          )

          value31.Button.Text = (multi and "[x] " or "[ ] ") .. value31.Value

          value31.Button.Visible = string.find(
            string.lower(value31.Value), string.lower(instance15.Text), 1, true
          ) ~= nil

          if value31.Button.Visible then
            count3 = count3 + 1
          end
        end

        v69.Visible = count3 == 0
      end

      control5._refresh = f26

      getConnect(openPopup, instance15:GetPropertyChangedSignal("Text"), f26)
      getConnect(openPopup, openPopup.Frame.Destroying, function() control5._refresh = nil end)

      f26()
    end)

    return control5
  end

  function v21:_colorPopup(p75, p76, fn)
    local openPopup2 = self:_openPopup(p75, p75.Name, 292)
    local clamped11, clamped12, brightness = p76:ToHSV()

    local instance18 = getInstance("TextButton", openPopup2.Panel, {
      Text = "",
      AutoButtonColor = false,
      BackgroundColor3 = Color3.fromHSV(clamped11, 1, 1),
      Position = UDim2.fromOffset(12, 40),
      Size = UDim2.fromOffset(232, 168),
    })

    local instance19 = getInstance("Frame", instance18, {
      BackgroundColor3 = Color3.new(1, 1, 1),
      BorderSizePixel = 0,
      Size = UDim2.fromScale(1, 1),
    })

    getInstance("UIGradient", instance19, { Transparency = NumberSequence.new(0, 1) })

    local instance20 = getInstance("Frame", instance18, {
      BackgroundColor3 = Color3.new(),
      BorderSizePixel = 0,
      Size = UDim2.fromScale(1, 1),
    })

    getInstance("UIGradient", instance20, {
      Rotation = 90,
      Transparency = NumberSequence.new(1, 0),
    })

    local instance21 = getInstance("Frame", instance18, {
      Size = UDim2.fromOffset(8, 8),
      AnchorPoint = Vector2.new(0.5, 0.5),
      BackgroundTransparency = 1,
      ZIndex = 3,
    })

    f12(instance21, 8)
    getInstance("UIStroke", instance21, { Color = color, Thickness = 2 })

    local instance22 = getInstance("TextButton", openPopup2.Panel, {
      Text = "",
      AutoButtonColor = false,
      BackgroundColor3 = Color3.new(1, 1, 1),
      Position = UDim2.fromOffset(254, 40),
      Size = UDim2.fromOffset(22, 168),
    })

    local list10 = {}

    for k = 0, 6 do
      table.insert(list10, ColorSequenceKeypoint.new(k / 6, Color3.fromHSV(k / 6, 1, 1)))
    end

    getInstance("UIGradient", instance22, { Rotation = 90, Color = ColorSequence.new(list10) })

    local instance23 = getInstance("Frame", instance22, {
      BorderSizePixel = 0,
      BackgroundColor3 = color,
      Size = UDim2.new(1, 4, 0, 3),
      AnchorPoint = Vector2.new(0, 0.5),
      ZIndex = 3,
    })

    local instance24 = getInstance("Frame", openPopup2.Panel, {
      Position = UDim2.fromOffset(12, 220),
      Size = UDim2.fromOffset(34, 28),
    })

    f12(instance24)

    local instance25 = getInstance("TextBox", openPopup2.Panel, {
      Text = "",
      ClearTextOnFocus = false,
      Font = Enum.Font.Code,
      TextSize = 14,
      TextColor3 = color2,
      BackgroundColor3 = color4,
      Position = UDim2.fromOffset(54, 220),
      Size = UDim2.fromOffset(222, 28),
    })

    f12(instance25)
    f19(openPopup2, instance25)

    f10(
      openPopup2.Panel, "Drag to pick a color, or enter #RRGGBB", UDim2.fromOffset(12, 256),
      UDim2.fromOffset(266, 24)
    )

    local function f27(p77)
      local color6 = Color3.fromHSV(clamped11, clamped12, brightness)

      f6(openPopup2, instance18, { BackgroundColor3 = Color3.fromHSV(clamped11, 1, 1) }, 0.07)

      f6(
        openPopup2, instance21, { Position = UDim2.fromScale(clamped12, 1 - brightness) }, 0.07
      )

      f6(openPopup2, instance23, { Position = UDim2.new(0, -2, clamped11, 0) }, 0.07)
      f6(openPopup2, instance24, { BackgroundColor3 = color6 }, 0.1)

      instance25.Text = "#" .. color6:ToHex()

      if p77 then
        fn(color6)
      end
    end

    f20(openPopup2, instance18, function(p78)
      clamped12 = math.clamp((p78.X - instance18.AbsolutePosition.X)
        / math.max(1, instance18.AbsoluteSize.X), 0, 1)

      brightness = 1 - math.clamp(
        (p78.Y - instance18.AbsolutePosition.Y) / math.max(1, instance18.AbsoluteSize.Y), 0, 1
      )

      f27(true)
    end)

    f20(openPopup2, instance22, function(p79)
      clamped11 = math.clamp((p79.Y - instance22.AbsolutePosition.Y)
        / math.max(1, instance22.AbsoluteSize.Y), 0, 1)

      f27(true)
    end)

    getConnect(openPopup2, instance25.FocusLost, function()
      local gsub = instance25.Text:gsub("^#", "")

      if gsub:match("^%x%x%x%x%x%x$") then
        clamped11, clamped12, brightness = Color3.fromHex(gsub):ToHSV()
        f27(true)
      else
        f27(false)
      end
    end)

    f27(false)
  end

  function index3.AddColorPicker(p80, p81)
    p81 = p81 or {}

    local control6 = p80:_control("ColorPicker", p81)

    control6._label = f10(
      control6.Frame, control6.Name, UDim2.fromOffset(12, 0), UDim2.new(1, -62, 1, 0)
    )

    local instance26 = getInstance("TextButton", control6.Frame, {
      Text = "",
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -12, 0.5, 0),
      Size = UDim2.fromOffset(30, 18),
    })

    f12(instance26, 3)
    f17(control6, instance26, instance26, function() return control6:_interactive() end)

    function control6:_normalize(p82)
      assert(typeof(p82) == "Color3", "ColorPicker expects a Color3")
      return p82
    end

    function control6:_render()
      f6(self, instance26, { BackgroundColor3 = self._value }, 0.14)
      self:_enabledVisual()
    end

    getConnect(control6, instance26.Activated, function()
      if control6:_interactive() then
        p80.Window:_colorPopup(control6, control6:Get(), function(p83) control6:Set(p83) end)
      end
    end)

    control6:Set(p81.Default or color, true)
    return control6
  end

  function index3.AddTextBox(p84, p85)
    p85 = p85 or {}

    local control7 = p84:_control("TextBox", p85)
    control7.Frame.Size = UDim2.new(1, 0, 0, 58)

    control7._label = f10(
      control7.Frame, control7.Name, UDim2.fromOffset(12, 0), UDim2.new(1, -24, 0, 22)
    )

    local instance27 = getInstance("TextBox", control7.Frame, {
      Text = "",
      PlaceholderText = p85.Placeholder or "Enter text...",
      ClearTextOnFocus = false,
      Font = Enum.Font.Gotham,
      TextSize = 12,
      TextColor3 = color2,
      PlaceholderColor3 = color3,
      BackgroundColor3 = color4,
      Position = UDim2.fromOffset(12, 25),
      Size = UDim2.new(1, -24, 0, 27),
    })

    f12(instance27)
    f19(control7, instance27)

    function control7:_normalize(part)
      assert(type(part) == "string", "TextBox expects a string")

      if p85.MaxLength then
        part = string.sub(part, 1, p85.MaxLength)
      end

      if p85.Numeric then
        assert(f9(tonumber(part)), "TextBox requires a finite number")
      end

      return part
    end

    function control7:_render()
      instance27.Text = self._value
      self:_enabledVisual()
    end

    function control7:_enabledVisual()
      index4._enabledVisual(self)
      instance27.TextEditable = self.Enabled and self.Section.Enabled
    end

    getConnect(control7, instance27.FocusLost, function()
      if not control7:_interactive() then
        control7:_render()
        return
      end

      local ok6 = pcall(function() control7:Set(instance27.Text) end)

      if not ok6 then
        control7:_render()
      end
    end)

    control7:Set(p85.Default or p85.Numeric and "0" or "", true)
    return control7
  end

  function index3:AddLabel(p86)
    if type(p86) == "string" then
      p86 = { Name = p86 }
    end

    local control8 = self:_control("Label", p86 or {})
    control8._label = f10(control8.Frame, control8.Name)

    function control8:Set(text4)
      self.Name = tostring(text4)

      if self._label then
        self._label.Text = tostring(text4)
      end
    end

    function control8:_render()
      self:_enabledVisual()
    end

    control8:_render()

    return control8
  end

  function v21.ExportConfig(p87)
    local v70 = { Version = 1, Controls = {} }

    for key11, value32 in pairs(p87.Controls) do
      if value32._normalize then
        local get3 = value32:Get()

        if value32.Kind == "ColorPicker" then
          get3 = get3:ToHex()
        elseif value32.Kind == "Keybind" then
          get3 = get3 and get3.Name or "NONE"
        end

        v70.Controls[key11] = {
          Kind = value32.Kind,
          Value = get3,
          Color = value32._color and value32._color:ToHex() or nil,
        }
      end
    end

    return v5:JSONEncode(v70)
  end

  function v21.ImportConfig(p88, p89, p90)
    local ok7, result5 = pcall(function() return v5:JSONDecode(p89) end)

    if not ok7 or type(result5) ~= "table" or result5.Version ~= 1
      or type(result5.Controls) ~= "table" then
      return false, "Invalid Patch Hub config (expected Version 1)"
    end

    local list11 = {}

    local ok8, result6 = pcall(function()
      for key12, value33 in pairs(result5.Controls) do
        local v71 = p88.Controls[key12]

        if v71 and v71._normalize then
          assert(
            type(value33) == "table" and value33.Kind == v71.Kind,
            "Config type mismatch: " .. key12
          )

          local value34 = value33.Value

          if v71.Kind == "ColorPicker" then
            assert(
              type(value34) == "string" and value34:match("^%x%x%x%x%x%x$"),
              "Invalid config color: " .. key12
            )

            value34 = Color3.fromHex(value34)
          end

          local color7

          if value33.Color and v71.SetColor then
            assert(
              type(value33.Color) == "string" and value33.Color:match("^%x%x%x%x%x%x$"),
              "Invalid toggle color: " .. key12
            )

            color7 = Color3.fromHex(value33.Color)
          end

          table.insert(list11, {
            Control = v71,
            Value = v71:_normalize(value34),
            Color = color7,
          })
        end
      end
    end)

    if not ok8 then
      return false, tostring(result6)
    end

    p88:_closePopup()
    p88:_cancelCapture()

    local list12 = {}

    for _, value35 in ipairs(list11) do
      local control9 = value35.Control
      local get4, color8 = control9:Get(), control9._color
      control9:Set(value35.Value, true)

      if value35.Color then
        control9:SetColor(value35.Color, true)
      end

      table.insert(list12, { Control = control9, Old = get4, OldColor = color8 })
    end

    if not p90 then
      for _, value36 in ipairs(list12) do
        local control10 = value36.Control

        if not f8(value36.Old, control10._value) then
          if control10.Kind == "Keybind" then
            f7(control10._changed, control10:Get())
          else
            f7(control10._callback, control10:Get())
          end
        end

        if control10.SetColor and value36.OldColor ~= control10._color then
          local color9 = control10._color
          control10._color = value36.OldColor
          control10:SetColor(color9)
        end
      end
    end

    return true
  end

  v8.Window = v21
  v8.Version = "1.1.0"

  return v8
end

local patchHub = makeTextLabel()

pcall(function()
  _G.PatchHub = patchHub
  shared.PatchHub = patchHub
end)

local v72 = players
local instance28 = replicatedStorage
local v73 = tweenService
local v74 = virtualUser
local v75 = virtualInputManager
local localPlayer2 = v72.LocalPlayer
local remotes = instance28:WaitForChild("Remotes")
local v76 = nil
pcall(function() v76 = require(instance28.Config.GameConfig) end)
local v77 = nil
pcall(function() v77 = require(instance28.Config.StandsConfig) end)
local v78 = nil
pcall(function() v78 = require(instance28.Config.FoodsConfig) end)
local v79 = nil
local v80 = nil
local v81 = nil
local v82 = nil
local v83 = nil
local v84 = nil
local v85 = nil
local v86 = nil
local v87 = nil
local v88 = nil

pcall(function()
  local controllers = localPlayer2:WaitForChild("PlayerScripts"):WaitForChild("Client"):WaitForChild("Controllers")
  v79 = require(controllers:WaitForChild("DataController"))
  v80 = require(controllers:WaitForChild("PlotController"))
  v81 = require(controllers:WaitForChild("TrainingController"))
  v82 = require(controllers:WaitForChild("ThrowController"))
  v83 = require(controllers:WaitForChild("ThrowMeter"))
  v84 = require(controllers:WaitForChild("RevealSequence"))
  v85 = require(controllers:WaitForChild("CameraRig"))
  v86 = require(controllers:WaitForChild("ClientState"))
  v87 = require(controllers:WaitForChild("HUDController"))
  v88 = require(instance28:WaitForChild("Shared"):WaitForChild("Remotes"))
end)

local v89 = {
  AutoThrow = false,
  InstantThrow = false,
  ThrowDelay = 0.5,
  AutoEquipBestOnThrow = true,
  AutoPullUp = false,
  AutoClick2x = true,
  AutoEquipBestLoop = false,
  AutoUpgradeStand = false,
  AutoUpgradeFood = false,
  TweenSpeed = 28,
  TotalThrows = 0,
  TotalBonusTaps = 0,
  LastAnimalName = "None",
  LastAnimalRarity = "None",
  CurrentStatus = "Idle",
  TrainingStatus = "Not Training",
}

local currentStatusIdle = nil
local totalThrows0 = nil
local latestCatchNone = nil
local catchRarityNone = nil
local addLabel = nil
local trainingStatusNotTraining = nil

local function f28()
  if currentStatusIdle then
    currentStatusIdle:Set("Current Status: " .. tostring(v89.CurrentStatus))
  end

  if totalThrows0 then
    totalThrows0:Set("Total Throws: " .. tostring(v89.TotalThrows))
  end

  if latestCatchNone then
    latestCatchNone:Set("Latest Catch: " .. tostring(v89.LastAnimalName))
  end

  if catchRarityNone then
    catchRarityNone:Set("Catch Rarity: " .. tostring(v89.LastAnimalRarity))
  end

  if addLabel then
    addLabel:Set("2x Minigame Claims: " .. tostring(v89.TotalBonusTaps))
  end

  if trainingStatusNotTraining then
    trainingStatusNotTraining:Set("Training Status: " .. tostring(v89.TrainingStatus))
  end
end

local function f29()
  if v82 and v82.Start and getupvalues then
    local ok9, upvalues = pcall(getupvalues, v82.Start)

    if ok9 and upvalues and upvalues[1] ~= nil then
      return upvalues[1] == true
    end
  end

  return v86 and v86.Busy == "Throw"
end

pcall(function()
  if v83 then
    v83.TestAutoTap = 0.36
    local new = v83.new

    function v83.new(...)
      local v90 = new(...)

      if v90 then
        v90.Locked = true
      end

      return v90
    end
  end
end)

pcall(function()
  local v91 = v88 or instance28:FindFirstChild("Shared") and require(instance28.Shared.Remotes)

  if v91 and v91.Invoke then
    local invoke = v91.Invoke

    function v91.Invoke(p91, ...)
      local v92 = { ... }

      if p91 == "Throw_Resolve" and v89.AutoThrow then
        v92[1] = 1
      end

      local v93 = invoke(p91, unpack(v92))

      if p91 == "Throw_Resolve" and type(v93) == "table" and v93.Ok then
        pcall(function()
          local modelName = v93.ModelName or v93.Result and v93.Result.ModelName
          local rarity = v93.Rarity or v93.Result and v93.Result.Rarity

          if modelName then
            v89.LastAnimalName = tostring(modelName)
          end

          if rarity then
            v89.LastAnimalRarity = tostring(rarity)
          end

          f28()
        end)
      end

      return v93
    end
  end
end)

pcall(function()
  if v84 and v84.Run then
    local run = v84.Run

    function v84.Run(p92)
      if v89.AutoThrow and p92 and p92.Result then
        pcall(function()
          local modelName2 = p92.Result.ModelName
          local flag4 = false
          local animals = v79 and v79:Get("Animals") or {}

          for _, value37 in pairs(animals) do
            if value37.ModelName == modelName2 then
              flag4 = true
              break
            end
          end

          if flag4 then
            p92.CanSkip = true
            p92.Owned = true
          end
        end)
      end

      return run(p92)
    end
  end
end)

pcall(function()
  if v82 and v82.Finished then
    v82.Finished:Connect(function(p93)
      if type(p93) == "table" then
        pcall(function()
          local modelName3 = p93.ModelName or p93.Result and p93.Result.ModelName
          local rarity2 = p93.Rarity or p93.Result and p93.Result.Rarity

          if modelName3 then
            v89.LastAnimalName = tostring(modelName3)
          end

          if rarity2 then
            v89.LastAnimalRarity = tostring(rarity2)
          end

          f28()
        end)
      end
    end)
  end
end)

local function f30(key13, ...)
  local v94 = v88 or instance28:FindFirstChild("Shared") and require(instance28.Shared.Remotes)

  if v94 and v94.Invoke then
    return v94.Invoke(key13, ...)
  elseif remotes and remotes:FindFirstChild(key13) then
    return remotes[key13]:InvokeServer(...)
  end

  return nil
end

local function f31()
  pcall(function()
    if v85 and v85.Release then
      v85.Release()
    end
  end)

  local currentCamera2 = workspace.CurrentCamera

  if currentCamera2 then
    currentCamera2.CameraType = Enum.CameraType.Custom
    local character = localPlayer2.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
      currentCamera2.CameraSubject = humanoid
    end
  end
end

local function f32()
  pcall(function()
    if setupvalue and v82 and v82.Start then
      setupvalue(v82.Start, 1, false)
    end
  end)

  pcall(function()
    if v88 and v88.Invoke then
      v88.Invoke("Throw_Cancel")
    elseif remotes and remotes.Throw_Cancel then
      remotes.Throw_Cancel:InvokeServer()
    end
  end)

  if v86 then
    v86.Busy = nil
  end

  f31()
  local character2 = localPlayer2.Character
  local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart then
    humanoidRootPart.Anchored = false
  end
end

local function f33()
  local throwStart = f30("Throw_Start")

  if not throwStart or not throwStart.Ok then
    return false, throwStart and throwStart.Reason or "StartFailed"
  end

  local v95 = f30("Throw_Resolve", 1)

  if not v95 or not v95.Ok then
    pcall(function() f30("Throw_Cancel") end)
    return false, v95 and v95.Reason or "ResolveFailed"
  end

  pcall(function()
    local modelName4 = v95.ModelName or v95.Result and v95.Result.ModelName
    local rarity3 = v95.Rarity or v95.Result and v95.Result.Rarity

    if modelName4 then
      v89.LastAnimalName = tostring(modelName4)
    end

    if rarity3 then
      v89.LastAnimalRarity = tostring(rarity3)
    end

    f28()
  end)

  local throwComplete = f30("Throw_Complete")

  pcall(function()
    local throwSequence = localPlayer2:FindFirstChild("PlayerGui")
      and localPlayer2.PlayerGui:FindFirstChild("ThrowSequence")

    if throwSequence then
      throwSequence:Destroy()
    end

    local findFirstChild = workspace:FindFirstChild("ThrowSequence_" .. localPlayer2.Name)

    if findFirstChild then
      findFirstChild:Destroy()
    end

    local luckyCatch = localPlayer2:FindFirstChild("PlayerGui")
      and localPlayer2.PlayerGui:FindFirstChild("LuckyCatch")

    if luckyCatch then
      luckyCatch:Destroy()
    end
  end)

  if v82 and v82.Finished then
    pcall(function() v82.Finished:Fire(v95) end)
  end

  pcall(function()
    if setupvalue and v82 and v82.Start then
      setupvalue(v82.Start, 1, false)
    end
  end)

  f31()
  local character3 = localPlayer2.Character
  local humanoidRootPart2 = character3 and character3:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart2 then
    humanoidRootPart2.Anchored = false
  end

  if v86 then
    v86.Busy = nil
  end

  return true, v95
end

local v96 = nil

local function f34()
  if v96 then
    pcall(function() v96:Cancel() end)
    v96 = nil
  end
end

local function f35(cframe, tweenSpeed)
  local character4 = localPlayer2.Character
  local humanoidRootPart3 = character4 and character4:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart3 then
    return false
  end

  if typeof(cframe) == "Vector3" then
    cframe = CFrame.new(cframe)
  end

  f34()
  local magnitude = (humanoidRootPart3.Position - cframe.Position).Magnitude

  if magnitude < 3 then
    return true
  end

  local tweenSpeed2 = tweenSpeed or v89.TweenSpeed or 28
  local clamped13 = math.clamp(magnitude / tweenSpeed2, 0.1, 15)
  local tweenInfo = TweenInfo.new(clamped13, Enum.EasingStyle.Linear)
  local create2 = v73:Create(humanoidRootPart3, tweenInfo, { CFrame = cframe })
  v96 = create2

  create2:Play()
  create2.Completed:Wait()

  v96 = nil
  return true
end

local function getCframe()
  local starterArea = workspace:FindFirstChild("StarterArea")

  if starterArea then
    return CFrame.new(
      starterArea.Position.X, starterArea.Position.Y + 1.5, starterArea.Position.Z
    )
  end

  return CFrame.new(0, 3.5, -45)
end

local function getCframe2()
  local starterArea2 = workspace:FindFirstChild("StarterArea")

  if starterArea2 then
    return CFrame.new(
      starterArea2.Position.X, starterArea2.Position.Y + 1.5,
      starterArea2.Position.Z + starterArea2.Size.Z / 2 + 5
    )
  end

  return CFrame.new(0, 3.5, -35)
end

local function getCframe3()
  local instance29 = nil

  pcall(function()
    if v81 and v81.BindSpot and getupvalues then
      instance29 = getupvalues(v81.BindSpot)[1]
    end
  end)

  if instance29 and instance29:IsA("BasePart") then
    return CFrame.new(instance29.Position + Vector3.new(0, 1.5, 0))
  end

  local localPlotProps = workspace:FindFirstChild("LocalPlotProps")

  if localPlotProps then
    local trainingArea = localPlotProps:FindFirstChild("TrainingArea")
    local trainingSpot = trainingArea and trainingArea:FindFirstChild("TrainingSpot")

    if trainingSpot and trainingSpot:IsA("BasePart") then
      return CFrame.new(trainingSpot.Position + Vector3.new(0, 1.5, 0))
    end
  end

  local v97 = nil

  if v80 and v80.GetPlotPart then
    pcall(function() v97 = v80.GetPlotPart() end)
  end

  if v97 then
    local vector2 = Vector3.new(-16, 2.5, -30.5)

    if v76 and v76.Plot and v76.Plot.TrainingSpotOffset then
      vector2 = v76.Plot.TrainingSpotOffset + Vector3.new(0, 2, 0)
    end

    return CFrame.new(v97.Position + vector2)
  end

  return CFrame.new(34, 4, -8)
end

local function getCframe4()
  local v98 = nil

  if v80 and v80.GetPlotPart then
    pcall(function() v98 = v80.GetPlotPart() end)
  end

  if v98 then
    return CFrame.new(v98.Position + Vector3.new(0, 3, 0))
  end

  return nil
end

local function f36()
  pcall(function()
    local plotEquipBest = f30("Plot_EquipBest")

    if plotEquipBest and plotEquipBest.Ok then
      local placed = plotEquipBest.Placed or 0
      local removed = plotEquipBest.Removed or 0

      if placed == 0 and removed == 0 then
        if v87 and v87.Notify then
          v87.Notify("Best animals are already equipped on your plot!", "Info")
        end
      elseif v87 and v87.Notify then
        v87.Notify(string.format("Equipped %d best animal(s) on your plot!", placed), "Success")
      end
    elseif v87 and v87.Notify then
      v87.Notify("Failed to equip animals", "Error")
    end
  end)
end

local function f37()
  pcall(function()
    local config = v77
      or instance28:FindFirstChild("Config") and require(instance28.Config.StandsConfig)

    local v99 = v79

    if not v99 then
      local controllers2 = localPlayer2:FindFirstChild("PlayerScripts")
        and localPlayer2.PlayerScripts:FindFirstChild("Client")
        and localPlayer2.PlayerScripts.Client:FindFirstChild("Controllers")

      if controllers2 and controllers2:FindFirstChild("DataController") then
        v99 = require(controllers2.DataController)
      end
    end

    if not v99 or not config then
      return
    end

    local stand = v99:Get("Stand") or 0
    local money = v99:Get("Money") or 0
    local v100 = config.Get(stand + 1)

    if v100 and v100.Price and money >= v100.Price then
      local standUpgrade = f30("Stand_Upgrade")

      if standUpgrade and standUpgrade.Ok and v87 and v87.Notify then
        v87.Notify("Upgraded pull-up stand to tier "
          .. tostring(standUpgrade.NewIndex or stand + 1), "Success")
      end
    end
  end)
end

local function f38()
  pcall(function()
    local config2 = v78
      or instance28:FindFirstChild("Config") and require(instance28.Config.FoodsConfig)

    local v101 = v79

    if not v101 then
      local controllers3 = localPlayer2:FindFirstChild("PlayerScripts")
        and localPlayer2.PlayerScripts:FindFirstChild("Client")
        and localPlayer2.PlayerScripts.Client:FindFirstChild("Controllers")

      if controllers3 and controllers3:FindFirstChild("DataController") then
        v101 = require(controllers3.DataController)
      end
    end

    if not v101 or not config2 then
      return
    end

    local money2 = v101:Get("Money") or 0
    local getFolder = v101:GetFolder()
    local ownedFoods = getFolder and getFolder:FindFirstChild("OwnedFoods")
    local equippedFood = v101:Get("EquippedFood") or 1
    local highest = equippedFood
    local count4 = config2.Count and config2.Count() or 50

    for m = 1, count4 do
      local v102 = ownedFoods and ownedFoods:FindFirstChild(tostring(m)) ~= nil

      if v102 then
        if m > highest then
          highest = m
        end
      else
        local v103 = config2.Get(m)

        if v103 and v103.Price and money2 >= v103.Price then
          local v104 = f30("Shop_Buy", m)

          if v104 and v104.Ok then
            highest = math.max(highest, m)

            if v87 and v87.Notify then
              v87.Notify("Purchased " .. tostring(v103.Name or "Food " .. m), "Success")
            end
          end
        end
      end
    end

    if highest > equippedFood then
      f30("Shop_Equip", highest)

      if v87 and v87.Notify then
        v87.Notify("Equipped Food tier " .. tostring(highest), "Success")
      end
    end
  end)
end

task.spawn(function()
  while true do
    task.wait(1)

    if v89.AutoUpgradeStand then
      f37()
    end

    if v89.AutoUpgradeFood then
      f38()
    end
  end
end)

local connect2 = nil

local function f39()
  if connect2 then
    pcall(function() connect2:Disconnect() end)
    connect2 = nil
  end

  pcall(function()
    connect2 = remotes.Training_Bonus.OnClientEvent:Connect(function(p94, p95)
      if v89.AutoClick2x then
        task.spawn(function()
          local invokeServer = remotes.Training_TapBonus:InvokeServer(p94)

          if invokeServer and invokeServer.Ok then
            v89.TotalBonusTaps = v89.TotalBonusTaps + 1
            f28()
          end
        end)
      end
    end)
  end)
end

f39()

task.spawn(function()
  while true do
    task.wait(0.15)

    if v89.AutoClick2x then
      pcall(function()
        local playerGui2 = localPlayer2:FindFirstChild("PlayerGui")

        if not playerGui2 then
          return
        end

        local findFirstChild2 = playerGui2:FindFirstChild("TapBonus", true)

        if findFirstChild2 and findFirstChild2:IsA("ImageButton") and findFirstChild2.Visible
          and findFirstChild2.Active then
          if firesignal then
            firesignal(findFirstChild2.Activated)
          end

          local v105 = findFirstChild2.AbsolutePosition + findFirstChild2.AbsoluteSize / 2
          v74:ClickButton1(v105)
        end
      end)
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(0.1)

    if v89.AutoThrow and not v89.AutoPullUp then
      if v81 and v81.IsRunning and v81.IsRunning() then
        pcall(function() v81.Stop() end)
        local now = os.clock()

        while v81.IsRunning() and os.clock() - now < 2.5 do
          task.wait(0.05)
        end
      end

      if v86 and v86.Busy == "Training" then
        pcall(function()
          if v88 and v88.Invoke then
            v88.Invoke("Training_Stop")
          elseif remotes and remotes.Training_Stop then
            remotes.Training_Stop:InvokeServer()
          end
        end)

        task.wait(0.2)
        v86.Busy = nil
      end

      if f29() then
        f32()
        task.wait(0.2)
      end

      if v89.InstantThrow then
        local cframe2 = getCframe()
        local character5 = localPlayer2.Character
        local humanoidRootPart4 = character5 and character5:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart4 and (humanoidRootPart4.Position - cframe2.Position).Magnitude > 8 then
          v89.CurrentStatus = "Moving to Throw Area..."
          f28()
          f35(cframe2, v89.TweenSpeed)
          task.wait(0.1)
        end

        if v89.AutoThrow and not v89.AutoPullUp then
          v89.CurrentStatus = "Instant Throwing..."
          f28()
          local v106, v107 = f33()

          if v106 then
            v89.TotalThrows = v89.TotalThrows + 1
            v89.CurrentStatus = "Throw Complete!"

            f28()

            if v89.AutoEquipBestOnThrow then
              task.spawn(f36)
            end

            if v89.AutoUpgradeFood then
              task.spawn(f38)
            end

            if v89.AutoUpgradeStand then
              task.spawn(f37)
            end

            task.wait(math.max(0.05, v89.ThrowDelay))
          else
            task.wait(0.2)
          end
        end
      else
        v89.CurrentStatus = "Moving to Throw Area..."
        f28()
        local cframe3 = getCframe2()
        f35(cframe3, v89.TweenSpeed)
        task.wait(0.1)

        if v89.AutoThrow and not v89.AutoPullUp then
          local cframe4 = getCframe()
          f35(cframe4, v89.TweenSpeed)
          v89.CurrentStatus = "Throwing Food..."
          f28()
          local now2 = os.clock()

          while v89.AutoThrow and not f29() and os.clock() - now2 < 1.5 do
            task.wait(0.05)
          end

          if v89.AutoThrow and not f29() then
            pcall(function()
              if v82 and v82.Start then
                task.spawn(v82.Start)
              end
            end)

            local now3 = os.clock()

            while v89.AutoThrow and not f29() and os.clock() - now3 < 1.5 do
              task.wait(0.05)
            end
          end

          if f29() then
            v89.CurrentStatus = "Food In Air (Auto-Skipping)..."
            f28()
            local now4 = os.clock()

            while v89.AutoThrow and f29() and os.clock() - now4 < 25 do
              task.wait(0.08)

              pcall(function()
                v75:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.wait(0.015)

                v75:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                v75:SendMouseButtonEvent(500, 500, 0, true, game, 1)

                task.wait(0.015)
                v75:SendMouseButtonEvent(500, 500, 0, false, game, 1)
              end)
            end

            if f29() then
              f32()
            end

            v89.TotalThrows = v89.TotalThrows + 1
            v89.CurrentStatus = "Throw Complete!"

            f28()
            f31()

            if v89.AutoEquipBestOnThrow then
              task.spawn(f36)
            end

            if v89.AutoUpgradeFood then
              task.spawn(f38)
            end

            if v89.AutoUpgradeStand then
              task.spawn(f37)
            end

            task.wait(math.max(0.1, v89.ThrowDelay))
          else
            task.wait(0.3)
          end
        end
      end
    end
  end
end)

local flag5 = false

task.spawn(function()
  while true do
    task.wait(0.2)

    if v89.AutoPullUp and not v89.AutoThrow then
      if not flag5 then
        if f29() then
          f32()
          task.wait(0.2)
        end

        flag5 = true

        v89.CurrentStatus = "Moving to Pull Up Stand..."
        v89.TrainingStatus = "Moving to Stand"

        f28()
        local cframe5 = getCframe3()
        f35(cframe5, v89.TweenSpeed)
        task.wait(0.2)
      end

      if not (v81 and v81.IsRunning and v81.IsRunning()) then
        if not (v86 and v86.Busy) then
          pcall(function()
            if v81 and v81.Start then
              task.spawn(v81.Start)
            end
          end)

          local now5 = os.clock()

          while not (v81 and v81.IsRunning and v81.IsRunning()) and os.clock() - now5 < 2 do
            task.wait(0.05)
          end
        end
      end

      if v81 and v81.IsRunning and v81.IsRunning() then
        v89.CurrentStatus = "Pull Ups Active"
        v89.TrainingStatus = "Training (Auto-Clicking 2x)"
        f28()
      end

      if v89.AutoUpgradeStand then
        f37()
      end

      task.wait(0.5)
    elseif flag5 then
      flag5 = false
      v89.TrainingStatus = "Stopping..."
      f28()

      if v81 and v81.IsRunning and v81.IsRunning() then
        pcall(function() v81.Stop() end)
        local now6 = os.clock()

        while v81.IsRunning() and os.clock() - now6 < 3 do
          task.wait(0.05)
        end
      end

      pcall(function()
        if v88 and v88.Invoke then
          v88.Invoke("Training_Stop")
        elseif remotes and remotes.Training_Stop then
          remotes.Training_Stop:InvokeServer()
        end
      end)

      task.wait(0.2)
      local cframe6 = getCframe3()
      local v108 = cframe6 * CFrame.new(0, 0, 7)
      f35(v108, v89.TweenSpeed)
      f31()
      local character6 = localPlayer2.Character
      local humanoidRootPart5 = character6 and character6:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart5 then
        humanoidRootPart5.Anchored = false
      end

      v89.TrainingStatus = "Not Training"
      v89.CurrentStatus = "Idle"

      f28()
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(10)

    if v89.AutoEquipBestLoop then
      f36()
    end
  end
end)

local v109 = getgenv and getgenv() or _G

if v109.PatchHub_ThrowFood then
  pcall(function() v109.PatchHub_ThrowFood:Destroy() end)
end

local playerGui3 = nil

pcall(function()
  if gethui then
    playerGui3 = gethui()
  end
end)

if not playerGui3 then
  pcall(function() playerGui3 = coreGui end)
end

if not playerGui3 then
  playerGui3 = localPlayer2:WaitForChild("PlayerGui")
end

local patchHubWindow = patchHub:CreateWindow({
  Name = "PatchHub_ThrowFood",
  Title = "Patch Hub",
  GameName = "Throw Food For Animals",
  LastUpdated = "11/02/2026",
  ToggleKey = Enum.KeyCode.RightShift,
  Animations = true,
  UnlockCursor = true,
  Parent = playerGui3,
  DisplayOrder = 9999,
})

v109.PatchHub_ThrowFood = patchHubWindow

if patchHubWindow and patchHubWindow.Gui then
  pcall(function()
    patchHubWindow.Gui.ResetOnSpawn = false
    patchHubWindow.Gui.DisplayOrder = 9999

    patchHubWindow.Gui:GetPropertyChangedSignal("Enabled"):Connect(function()
      if not patchHubWindow.Gui.Enabled then
        patchHubWindow.Gui.Enabled = true
      end
    end)
  end)
end

local mainTab = patchHubWindow:CreateTab({ Name = "Main", Icon = "rbxassetid://80869096876893" })
local throwingSubTab = mainTab:CreateSubTab("Throwing")

local throwAutomationSection = throwingSubTab:CreateSection({
  Name = "Throw Automation",
  Side = "Left",
})

throwAutomationSection:AddToggle({
  Id = "autoThrow",
  Name = "Auto Throw (100% Power)",
  Default = false,
  Callback = function(value38)
    v89.AutoThrow = value38

    if value38 then
      v89.AutoPullUp = false

      if v86 and v86.Busy == "Training" then
        if v81 and v81.Stop then
          pcall(function() v81.Stop() end)
        end

        pcall(function() remotes.Training_Stop:InvokeServer() end)
        task.wait(0.2)
        v86.Busy = nil
      end

      local character7 = localPlayer2.Character
      local humanoidRootPart6 = character7 and character7:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart6 then
        humanoidRootPart6.Anchored = false
      end
    else
      v89.CurrentStatus = "Idle"
      f34()
      f32()
      f28()
    end
  end,
})

throwAutomationSection:AddToggle({
  Id = "instantThrow",
  Name = "Instant Throw (Fast Server Resolve)",
  Default = false,
  Callback = function(value39) v89.InstantThrow = value39 end,
})

throwAutomationSection:AddToggle({
  Id = "autoEquipBestThrow",
  Name = "Equip Best Pets on Catch",
  Default = true,
  Callback = function(value40) v89.AutoEquipBestOnThrow = value40 end,
})

throwAutomationSection:AddSlider({
  Id = "throwDelay",
  Name = "Throw Interval Delay",
  Min = 0.05,
  Max = 3,
  Default = 0.5,
  Decimals = 2,
  Callback = function(value41) v89.ThrowDelay = value41 end,
})

throwAutomationSection:AddButton({
  Name = "Instant Throw Once",
  Callback = function()
    task.spawn(function()
      if f29() then
        f32()
        task.wait(0.1)
      end

      local v110, v111 = f33()

      if v110 then
        v89.TotalThrows = v89.TotalThrows + 1
        v89.CurrentStatus = "Throw Complete!"

        f28()

        if v89.AutoEquipBestOnThrow then
          task.spawn(f36)
        end

        if v89.AutoUpgradeFood then
          task.spawn(f38)
        end

        if v89.AutoUpgradeStand then
          task.spawn(f37)
        end
      end
    end)
  end,
})

throwAutomationSection:AddButton({
  Name = "Throw Once Now (Standard)",
  Callback = function()
    task.spawn(function()
      if v81 and v81.IsRunning and v81.IsRunning() then
        pcall(function() v81.Stop() end)
        local now7 = os.clock()

        while v81.IsRunning() and os.clock() - now7 < 2.5 do
          task.wait(0.05)
        end
      end

      if v86 and v86.Busy == "Training" then
        pcall(function()
          if v88 and v88.Invoke then
            v88.Invoke("Training_Stop")
          elseif remotes and remotes.Training_Stop then
            remotes.Training_Stop:InvokeServer()
          end
        end)

        task.wait(0.2)
        v86.Busy = nil
      end

      if f29() then
        f32()
        task.wait(0.2)
      end

      local cframe7 = getCframe2()
      f35(cframe7, v89.TweenSpeed)
      task.wait(0.1)
      local cframe8 = getCframe()
      f35(cframe8, v89.TweenSpeed)
      local now8 = os.clock()

      while not f29() and os.clock() - now8 < 1.5 do
        task.wait(0.05)
      end

      if not f29() then
        pcall(function()
          if v82 and v82.Start then
            task.spawn(v82.Start)
          end
        end)

        local now9 = os.clock()

        while not f29() and os.clock() - now9 < 1.5 do
          task.wait(0.05)
        end
      end

      if f29() then
        local now10 = os.clock()

        while f29() and os.clock() - now10 < 25 do
          task.wait(0.08)

          pcall(function()
            v75:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.015)

            v75:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            v75:SendMouseButtonEvent(500, 500, 0, true, game, 1)

            task.wait(0.015)
            v75:SendMouseButtonEvent(500, 500, 0, false, game, 1)
          end)
        end

        if f29() then
          f32()
        end

        f31()
      end
    end)
  end,
})

local throwStatisticsSection = throwingSubTab:CreateSection({
  Name = "Throw Statistics",
  Side = "Right",
})

currentStatusIdle = throwStatisticsSection:AddLabel("Current Status: Idle")
totalThrows0 = throwStatisticsSection:AddLabel("Total Throws: 0")
latestCatchNone = throwStatisticsSection:AddLabel("Latest Catch: None")
catchRarityNone = throwStatisticsSection:AddLabel("Catch Rarity: None")
local subTab = mainTab:CreateSubTab("Pull Up Bar")

local section = subTab:CreateSection({ Name = "Pull Up Automation", Side = "Left" })

section:AddToggle({
  Id = "autoPullUp",
  Name = "Auto Pull Up Bar",
  Default = false,
  Callback = function(value42)
    v89.AutoPullUp = value42

    if value42 then
      v89.AutoThrow = false

      if v86 and v86.Busy == "Throw" then
        f32()
      end
    else
      f34()

      if v81 and v81.Stop then
        pcall(function() v81.Stop() end)
      end

      pcall(function() remotes.Training_Stop:InvokeServer() end)
      task.wait(0.3)
      local cframe9 = getCframe3()
      local v112 = cframe9 * CFrame.new(0, 0, 7)
      f35(v112, v89.TweenSpeed)
      f31()
      local character8 = localPlayer2.Character
      local humanoidRootPart7 = character8 and character8:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart7 then
        humanoidRootPart7.Anchored = false
      end
    end
  end,
})

section:AddToggle({
  Id = "autoClick2x",
  Name = "Auto Click 2x Minigame",
  Default = true,
  Callback = function(value43) v89.AutoClick2x = value43 end,
})

section:AddButton({
  Name = "Start Training (Walk to Stand)",
  Callback = function()
    task.spawn(function()
      local cframe10 = getCframe3()
      f35(cframe10, v89.TweenSpeed)
      task.wait(0.2)

      if not (v81 and v81.IsRunning and v81.IsRunning()) then
        pcall(function()
          if v81 and v81.Start then
            task.spawn(v81.Start)
          end
        end)
      end
    end)
  end,
})

section:AddButton({
  Name = "Stop Training (Step Back)",
  Callback = function()
    task.spawn(function()
      if v81 and v81.IsRunning and v81.IsRunning() then
        pcall(function() v81.Stop() end)
        local now11 = os.clock()

        while v81.IsRunning() and os.clock() - now11 < 3 do
          task.wait(0.05)
        end
      end

      pcall(function()
        if v88 and v88.Invoke then
          v88.Invoke("Training_Stop")
        elseif remotes and remotes.Training_Stop then
          remotes.Training_Stop:InvokeServer()
        end
      end)

      task.wait(0.2)
      local cframe11 = getCframe3()
      local v113 = cframe11 * CFrame.new(0, 0, 7)
      f35(v113, v89.TweenSpeed)
      f31()
      local character9 = localPlayer2.Character
      local humanoidRootPart8 = character9 and character9:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart8 then
        humanoidRootPart8.Anchored = false
      end
    end)
  end,
})

local trainingStatisticsSection = subTab:CreateSection({
  Name = "Training Statistics",
  Side = "Right",
})

trainingStatusNotTraining = trainingStatisticsSection:AddLabel("Training Status: Not Training")
addLabel = trainingStatisticsSection:AddLabel("2x Minigame Claims: 0")

local plotShopTab = patchHubWindow:CreateTab({
  Name = "Plot & Shop",
  Icon = "rbxassetid://93827853548653",
})

local managementSubTab = plotShopTab:CreateSubTab("Management")

local animalsPlotSection = managementSubTab:CreateSection({
  Name = "Animals & Plot",
  Side = "Left",
})

animalsPlotSection:AddToggle({
  Id = "autoEquipBestLoop",
  Name = "Auto Equip Best Animals (10s)",
  Default = false,
  Callback = function(value44)
    v89.AutoEquipBestLoop = value44

    if value44 then
      f36()
    end
  end,
})

animalsPlotSection:AddButton({ Name = "Equip Best Animals Now", Callback = function() f36() end })

local autoUpgradesSection = managementSubTab:CreateSection({
  Name = "Auto Upgrades",
  Side = "Right",
})

autoUpgradesSection:AddToggle({
  Id = "autoUpgradeStand",
  Name = "Auto Upgrade Pull Up Stand",
  Default = false,
  Callback = function(value45)
    v89.AutoUpgradeStand = value45

    if value45 then
      f37()
    end
  end,
})

autoUpgradesSection:AddButton({
  Name = "Upgrade Stand Once Now",
  Callback = function() f37() end,
})

autoUpgradesSection:AddToggle({
  Id = "autoUpgradeFood",
  Name = "Auto Upgrade Foods",
  Default = false,
  Callback = function(value46)
    v89.AutoUpgradeFood = value46

    if value46 then
      f38()
    end
  end,
})

autoUpgradesSection:AddButton({
  Name = "Buy & Equip Highest Food Now",
  Callback = function() f38() end,
})

local waypointsTab = patchHubWindow:CreateTab({
  Name = "Waypoints",
  Icon = "rbxassetid://107815780127396",
})

local teleportsSubTab = waypointsTab:CreateSubTab("Teleports")

local plotLocationsSection = teleportsSubTab:CreateSection({
  Name = "Plot Locations",
  Side = "Left",
})

plotLocationsSection:AddButton({
  Name = "Tween to Pull Up Stand",
  Callback = function()
    local cframe12 = getCframe3()

    if cframe12 then
      f35(cframe12, v89.TweenSpeed)
    end
  end,
})

plotLocationsSection:AddButton({
  Name = "Tween to Plot Center",
  Callback = function()
    local cframe13 = getCframe4()

    if cframe13 then
      f35(cframe13, v89.TweenSpeed)
    end
  end,
})

local worldLocationsSection = teleportsSubTab:CreateSection({
  Name = "World Locations",
  Side = "Right",
})

worldLocationsSection:AddButton({
  Name = "Tween to Throw Starter Area",
  Callback = function()
    local cframe14 = getCframe()
    f35(cframe14, v89.TweenSpeed)
  end,
})

worldLocationsSection:AddSlider({
  Id = "tweenSpeed",
  Name = "Tween Speed",
  Min = 15,
  Max = 60,
  Default = 28,
  Decimals = 0,
  Callback = function(value47) v89.TweenSpeed = value47 end,
})

local settingsTab = patchHubWindow:CreateTab({
  Name = "Settings",
  Icon = "rbxassetid://128822529527725",
})

local configurationSubTab = settingsTab:CreateSubTab("Configuration")

local hubSettingsSection = configurationSubTab:CreateSection({
  Name = "Hub Settings",
  Side = "Left",
})

patchHubWindow:AddSettings(hubSettingsSection)

local unloadSection = configurationSubTab:CreateSection({ Name = "Unload", Side = "Right" })

unloadSection:AddButton({
  Name = "Unload Patch Hub",
  Callback = function()
    v89.AutoThrow = false
    v89.AutoPullUp = false
    v89.AutoClick2x = false
    v89.AutoEquipBestLoop = false
    v89.AutoUpgradeStand = false
    v89.AutoUpgradeFood = false

    f34()

    if connect2 then
      pcall(function() connect2:Disconnect() end)
      connect2 = nil
    end

    if v81 and v81.Stop then
      pcall(function() v81.Stop() end)
    end

    f31()
    patchHubWindow:Destroy()
  end,
})

return patchHubWindow
