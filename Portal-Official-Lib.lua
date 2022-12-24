--[[
  // Portal UI Library
  // Created by SupLua#0945
  
  // Created on Mobile
]]

local PortalMain = {}
local Tween = game:GetService("TweenService")
local UserInput = game:GetService("UserInputService")

for i,v in pairs(game.CoreGui:GetChildren()) do
  if v.Name == "PortalUI" then
    v:Destroy()
  end
end

local PortalUI = Instance.new("ScreenGui")
PortalUI.Name = "PortalUI"
PortalUI.Parent = game.CoreGui

function PortalMain:Dragging(p_frame, p_parent)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil
	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		p_parent.Position = pos
	end
	p_frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = p_parent.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	p_frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)
	UserInput.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

function PortalMain:Notification(Option) 
    local Title = Option.Title or "Title"
    local Text = Option.Text or "Description"
    local Duration = Option.Duration or 10
    local Theme = Option.Theme or "PortalTheme"
    
    if Theme == "RedTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(255,0,0)
    elseif Theme == "GreenTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(0,255,0)
    elseif Theme == "BlueTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(0,0,255)
    elseif Theme == "PurpleTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(255,0,255)
    elseif Theme == "YellowTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(255,255,0)
    elseif Theme == "CyanTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(0,255,255)
    elseif Theme == "PortalTheme" then
      getgenv().ThemeNotification = Color3.fromRGB(130,0,200)
    end

    for i,v in pairs(game.CoreGui:GetChildren()) do
      if v.Name == "PortalNotify" then
        v:Destroy()
      end
    end

    local PortalNotify = Instance.new("ScreenGui")
    local NotificationFrame = Instance.new("Frame")
    local NotificationTitle = Instance.new("TextLabel")
    local NotificationDesc = Instance.new("TextLabel") 

    PortalNotify.Name = "PortalNotify"
    PortalNotify.Parent = game.CoreGui
    
    NotificationFrame.Parent = PortalNotify
    NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    NotificationFrame.BackgroundTransparency = 1
    NotificationFrame.Position = UDim2.new(1, -25, 1, -25)
    NotificationFrame.AnchorPoint = Vector2.new(1, 1)
    NotificationFrame.Size = UDim2.new(0,280,0,100)
    NotificationFrame.AutomaticSize = Enum.AutomaticSize.Y
    NotificationFrame.Active = true
    NotificationFrame.BorderSizePixel = 2
    NotificationFrame.BorderColor3 = getgenv().ThemeNotification

    NotificationTitle.Parent = NotificationFrame
    NotificationTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    NotificationTitle.BorderSizePixel = 0
    NotificationTitle.BackgroundTransparency = 1
    NotificationTitle.TextTransparency = 1
    NotificationTitle.Position = UDim2.new(0,10.0,0,0)
    NotificationTitle.Size = UDim2.new(0.5,0,0.2)
    NotificationTitle.Font = Enum.Font.SourceSansBold
    NotificationTitle.Text = Title
    NotificationTitle.TextColor3 = Color3.fromRGB(255,255,255)
    NotificationTitle.TextScaled = true
    NotificationTitle.TextSize = 8
    NotificationTitle.TextWrapped = true
    NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left

    NotificationDesc.Parent = NotificationFrame
    NotificationDesc.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    NotificationDesc.BorderSizePixel = 0
    NotificationDesc.BackgroundTransparency = 1
    NotificationDesc.TextTransparency = 1
    NotificationDesc.Position = UDim2.new(0.04,0,0.2,0)
    NotificationDesc.Size = UDim2.new(0,260,0,50)
    NotificationDesc.Font = Enum.Font.SourceSansBold
    NotificationDesc.Text = Text
    NotificationDesc.TextColor3 = Color3.fromRGB(255,255,255)
    NotificationDesc.TextSize = 16
    NotificationDesc.TextWrapped = true
    NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
    
    Tween:Create(NotificationFrame, TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play() 
    Tween:Create(NotificationTitle, TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play() 
    Tween:Create(NotificationDesc, TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play() 
    wait(Duration)
    Tween:Create(NotificationFrame, TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play() 
    Tween:Create(NotificationTitle, TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play() 
    Tween:Create(NotificationDesc, TweenInfo.new(.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play() 
    wait(.7)
    PortalNotify:Destroy()
end

function PortalMain:Window(Option)
    local Title = Option.Name or "Portal UI"
    local Desc = Option.Desc or "V1"
    local ThemeUI = Option.Theme or "PortalTheme"

    if ThemeUI == "RedTheme" then
      getgenv().ThemeUI = Color3.fromRGB(255,0,0)
    elseif ThemeUI == "GreenTheme" then
      getgenv().ThemeUI = Color3.fromRGB(0,255,0)
    elseif ThemeUI == "BlueTheme" then
      getgenv().ThemeUI = Color3.fromRGB(0,0,255)
    elseif ThemeUI == "PurpleTheme" then
      getgenv().ThemeUI = Color3.fromRGB(255,0,255)
    elseif ThemeUI == "YellowTheme" then
      getgenv().ThemeUI = Color3.fromRGB(255,255,0)
    elseif ThemeUI == "CyanTheme" then
      getgenv().ThemeUI = Color3.fromRGB(0,255,255)
    elseif ThemeUI == "PortalTheme" then
      getgenv().ThemeUI = Color3.fromRGB(130,0,200)
    end

	local MainFrame = Instance.new("Frame")
	local CategoryFrame = Instance.new("Frame")
	local CategoryFrameLayout = Instance.new("UIListLayout")
	local FrameTitle = Instance.new("TextLabel")
    local Category = Instance.new("ScrollingFrame")
    local CategoryPadding = Instance.new("UIPadding")
    local CategoryLayout = Instance.new("UIGridLayout")
    local CloseToggle = Instance.new("TextButton")
    local OpenToggle = Instance.new("TextButton")

	MainFrame.Parent = PortalUI
	MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	MainFrame.Position = UDim2.new(0.5, 0, 0.8, 0)
	MainFrame.Size = UDim2.new(0, 297, 0, 295)
    MainFrame.BorderColor3 = getgenv().ThemeUI
    MainFrame.BorderSizePixel = 2
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.9)
    MainFrame.AutomaticSize = Enum.AutomaticSize.Y
    MainFrame.Visible = true

	CategoryFrame.Parent = MainFrame
	CategoryFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	CategoryFrame.BorderSizePixel = 0
	CategoryFrame.Position = UDim2.new(0.0624024495, 0, 0.145615742, 0)
	CategoryFrame.Size = UDim2.new(0, 257, 0, 230)

	CategoryFrameLayout.Parent = CategoryFrame
	CategoryFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	CategoryFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
	CategoryFrameLayout.Padding = UDim.new(0, 10)
	
    Category.Name = "Category"
    Category.Parent = CategoryFrame
    Category.Active = true
    Category.BackgroundColor3 = Color3.new(1, 1, 1)
    Category.BackgroundTransparency = 1
    Category.BorderSizePixel = 0
    Category.Size = UDim2.new(0, 257, 0, 230)
    Category.ScrollBarThickness = 2

    CategoryPadding.Parent = Category
    CategoryPadding.PaddingLeft = UDim.new(0, 15)
    CategoryPadding.PaddingTop = UDim.new(0, 10)
 
    CategoryLayout.Parent = Category
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.CellSize = UDim2.new(0, 227, 0, 35)

	FrameTitle.Parent = MainFrame
	FrameTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FrameTitle.BackgroundTransparency = 1.000
	FrameTitle.LayoutOrder = 5
	FrameTitle.Position = UDim2.new(0.04, 0, 0, 0)
	FrameTitle.Size = UDim2.new(0, 274, 0, 40)
	FrameTitle.ZIndex = 2
	FrameTitle.Font = Enum.Font.GothamBold
	FrameTitle.Text = Title.." | "..Desc
	FrameTitle.TextColor3 = Color3.fromRGB(232, 232, 232)
	FrameTitle.TextSize = 20.000
	FrameTitle.TextWrapped = true
    FrameTitle.TextXAlignment = Enum.TextXAlignment.Left
	PortalMain:Dragging(MainFrame, MainFrame)
    
    CloseToggle.Name = "CloseToggle"
    CloseToggle.Parent = PortalUI
    CloseToggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    CloseToggle.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
    CloseToggle.Size = UDim2.new(0, 50, 0, 50)
    CloseToggle.Font = Enum.Font.Code
    CloseToggle.Text = "-"
    CloseToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseToggle.TextScaled = true
    CloseToggle.BorderSizePixel = 2
    CloseToggle.BorderColor3 = getgenv().ThemeUI
    CloseToggle.MouseButton1Down:connect(function()
        MainFrame.Visible = false
        CloseToggle.Visible = false
        OpenToggle.Visible = true
    end)
    
    OpenToggle.Name = "OpenToggle"
    OpenToggle.Parent = PortalUI
    OpenToggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    OpenToggle.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
    OpenToggle.Size = UDim2.new(0, 50, 0, 50)
    OpenToggle.Font = Enum.Font.Code
    OpenToggle.Text = "+"
    OpenToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenToggle.TextScaled = true
    OpenToggle.Visible = false
    OpenToggle.BorderSizePixel = 2
    OpenToggle.BorderColor3 = getgenv().ThemeUI
    OpenToggle.MouseButton1Down:connect(function()
        MainFrame.Visible = true
        CloseToggle.Visible = true
        OpenToggle.Visible = false
    end)
    
	local Portal = {}
	
	function Portal:Button(Name, Call)
		local Buttons = Instance.new("TextButton")
		
		Buttons.Parent = Category
		Buttons.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		Buttons.Size = UDim2.new(0, 200, 0, 50)
		Buttons.Font = Enum.Font.SourceSansBold
		Buttons.Text = Name
		Buttons.TextColor3 = Color3.fromRGB(225, 225, 225)
		Buttons.BorderColor3 = Color3.fromRGB(225, 225, 225)
		Buttons.BorderSizePixel = 1
		Buttons.TextSize = 17.000
		Buttons.TextWrapped = true
        Buttons.AutoButtonColor = false
        Buttons.MouseEnter:Connect(function()
            Tween:Create(Buttons, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = getgenv().ThemeUI}):Play() 
            Buttons.TextSize = 14.000
        end)
        
        Buttons.MouseLeave:Connect(function()
            Tween:Create(Buttons, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(225,225,225)}):Play() 
            Buttons.TextSize = 17.000
        end)
        
		Buttons.MouseButton1Click:Connect(function()
			pcall(Call)
		end)
		Category.CanvasSize = UDim2.new(0,0,0,CategoryLayout.AbsoluteContentSize.Y)
	end

    function Portal:Toggle(Name, Call)
        local StateValue = false
        local CheckBox = Instance.new("TextButton")
		
		CheckBox.Parent = Category
		CheckBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		CheckBox.Size = UDim2.new(0, 200, 0, 50)
		CheckBox.Font = Enum.Font.SourceSansBold
		CheckBox.Text = Name
		CheckBox.TextColor3 = Color3.fromRGB(225, 225, 225)
		CheckBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
		CheckBox.BorderSizePixel = 1
		CheckBox.TextSize = 17.000
		CheckBox.TextWrapped = true
        CheckBox.AutoButtonColor = false
        CheckBox.MouseButton1Click:Connect(function()
            if StateValue == false then
                Tween:Create(CheckBox, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = getgenv().ThemeUI}):Play() 
            else
                Tween:Create(CheckBox, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(255, 0, 0)}):Play() 
            end
            StateValue = not StateValue
			pcall(Call, StateValue)
	    end)
	Category.CanvasSize = UDim2.new(0,0,0,CategoryLayout.AbsoluteContentSize.Y)
	end
    
    function Portal:Box(Name, Call)
		local TextBoxs = Instance.new("TextBox")
		
		TextBoxs.Parent = Category
		TextBoxs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		TextBoxs.Size = UDim2.new(0, 200, 0, 50)
		TextBoxs.Font = Enum.Font.SourceSansBold
		TextBoxs.Text = Name
		TextBoxs.TextColor3 = Color3.fromRGB(225, 225, 225)
		TextBoxs.BorderColor3 = Color3.fromRGB(225,225,225)
		TextBoxs.BorderSizePixel = 1
		TextBoxs.TextSize = 17.000
		TextBoxs.TextWrapped = true
        TextBoxs.Focused:Connect(function()
            Tween:Create(TextBoxs, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = getgenv().ThemeUI}):Play() 
        end)
        
		TextBoxs.FocusLost:Connect(function()
		    Tween:Create(TextBoxs, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = Color3.fromRGB(225, 225, 225)}):Play() 
			pcall(Call, TextBoxs.Text)
		end)
		Category.CanvasSize = UDim2.new(0,0,0,CategoryLayout.AbsoluteContentSize.Y)
	end

    function Portal:Init()
        local InitParent = Instance.new("TextLabel")
        
        InitParent.Parent = Category
		InitParent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InitParent.Size = UDim2.new(0, 200, 0, 20)
		InitParent.Font = Enum.Font.SourceSansBold
		InitParent.Text = ""
		InitParent.TextColor3 = Color3.fromRGB(255, 255, 255)
		InitParent.TextSize = 1
        InitParent.BackgroundTransparency = 1
        Category.CanvasSize = UDim2.new(0,0,0,CategoryLayout.AbsoluteContentSize.Y)
    end
	return Portal
end
return PortalMain
