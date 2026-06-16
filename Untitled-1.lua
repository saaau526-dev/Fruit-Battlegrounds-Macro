local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui")
Gui.Name = "MechanicalPanel"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(360, 220)
Main.Position = UDim2.new(0.5, -180, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(18, 20, 24)
Main.BorderSizePixel = 0
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 255, 255)
Stroke.Parent = Main

local Gradient = Instance.new("UIGradient")
Gradient.Rotation = 90
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25,25,30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,12))
}
Gradient.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "Fruit Battlegrounds Macro"
Title.Font = Enum.Font.Code
Title.TextColor3 = Color3.fromRGB(0,255,255)
Title.TextSize = 20
Title.Parent = Main

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1,-20,0,1)
Divider.Position = UDim2.new(0,10,0,40)
Divider.BackgroundColor3 = Color3.fromRGB(0,255,255)
Divider.BorderSizePixel = 0
Divider.Parent = Main

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,-20,0,30)
Status.Position = UDim2.new(0,10,0,50)
Status.BackgroundTransparency = 1
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Text = "STATUS : OFFLINE"
Status.Font = Enum.Font.Code
Status.TextColor3 = Color3.fromRGB(255,80,80)
Status.TextSize = 18
Status.Parent = Main

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0,150,0,40)
Toggle.Position = UDim2.new(0,15,0,95)
Toggle.Text = "ACTIVATE"
Toggle.Font = Enum.Font.Code
Toggle.TextSize = 18
Toggle.BackgroundColor3 = Color3.fromRGB(35,35,40)
Toggle.TextColor3 = Color3.fromRGB(255,255,255)
Toggle.Parent = Main

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0,4)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0,255,255)
ToggleStroke.Parent = Toggle

local SkillLabel = Instance.new("TextLabel")
SkillLabel.Size = UDim2.new(0,150,0,25)
SkillLabel.Position = UDim2.new(0,190,0,95)
SkillLabel.BackgroundTransparency = 1
SkillLabel.Text = "MAX SKILL"
SkillLabel.Font = Enum.Font.Code
SkillLabel.TextColor3 = Color3.fromRGB(200,200,200)
SkillLabel.TextSize = 16
SkillLabel.Parent = Main

local SkillBox = Instance.new("TextBox")
SkillBox.Size = UDim2.new(0,80,0,40)
SkillBox.Position = UDim2.new(0,220,0,120)
SkillBox.Text = "4"
SkillBox.Font = Enum.Font.Code
SkillBox.TextSize = 22
SkillBox.BackgroundColor3 = Color3.fromRGB(35,35,40)
SkillBox.TextColor3 = Color3.fromRGB(0,255,255)
SkillBox.Parent = Main

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0,4)
BoxCorner.Parent = SkillBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(0,255,255)
BoxStroke.Parent = SkillBox

local Enabled = false
local MaxSkill = 4
local HRPPos

Toggle.MouseButton1Click:Connect(function()
    Enabled = not Enabled

    if Enabled then
        Status.Text = "STATUS : ONLINE"
        Status.TextColor3 = Color3.fromRGB(0,255,120)
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            HRPPos = Player.Character.HumanoidRootPart.CFrame
        else
          Enabled = false
            Status.Text = "STATUS : NO CHAR"
            Status.TextColor3 = Color3.fromRGB(255,80,80)
            return
        end

        TweenService:Create(
            Toggle,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0,120,80)}
        ):Play()
    else
        Status.Text = "STATUS : OFFLINE"
        Status.TextColor3 = Color3.fromRGB(255,80,80)

        TweenService:Create(
            Toggle,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(35,35,40)}
        ):Play()
    end
end)

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.V then
        Main.Visible = not Main.Visible
    end
end)

SkillBox.FocusLost:Connect(function()
    local num = tonumber(SkillBox.Text)
    if num and num >= 4 and num <= 6 then
        MaxSkill = num
    else
        MaxSkill = 4
        SkillBox.Text = "4"
    end
end)

local dragging = false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local keys = {
    Enum.KeyCode.One,
    Enum.KeyCode.Two,
    Enum.KeyCode.Three,
    Enum.KeyCode.Four,
    Enum.KeyCode.Five,
    Enum.KeyCode.Six
}

while task.wait(0.5) do
    if Enabled then
        local character = Player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        
        if hrp and HRPPos then
            hrp.CFrame = HRPPos
        
            for i = 1, math.clamp(MaxSkill, 1, 6) do
                if not Enabled then break end 
                
                local key = keys[i]
                VirtualInputManager:SendKeyEvent(true, key, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, key, false, game)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)

                task.wait(0.1)
            end
        else
            Enabled = false
            Status.Text = "STATUS : OFFLINE"
            Status.TextColor3 = Color3.fromRGB(255,80,80)
            Toggle.BackgroundColor3 = Color3.fromRGB(35,35,40)
        end
    end
end