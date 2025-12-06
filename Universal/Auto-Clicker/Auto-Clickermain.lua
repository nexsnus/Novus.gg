local Window = _G.Window
local ut = _G.ut

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = Players.LocalPlayer
local Enabled = false
local Mouse = Player:GetMouse()
local X, Y = 0, 0
local interval = 1
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local utacs = ut:CreateSection("Auto Clicker")
local utact = ut:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "utact",
    Callback = function(state)
        Enabled = state
        while Enabled do
            VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 1)
            wait(interval)
        end
    end,
})
local utacis = ut:CreateSlider({
   Name = "Auto Clicker Interval",
   Range = {0.01, 2},
   Increment = 0.01,
   Suffix = "Seconds",
   CurrentValue = 1,
   Flag = "utacis", 
   Callback = function(value)
        interval = value
   end,
})
local utactb = ut:CreateKeybind({
        Name = "Auto Clicker Toggle Bind",
        CurrentKeybind = "F",
        HoldToInteract = false,
        Flag = "utactb",
        Callback = function()
            if Enabled == true then
                utact:Set(false)
            else
                utact:Set(true)
            end
        end,
})
local utacpb = ut:CreateButton({
    Name = "Set Position on Click",
    Callback = function()
        local function onMouseDown(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local Mouse = Player:GetMouse()
                X, Y = Mouse.X, Mouse.Y
                if MouseDownConnection then
                    MouseDownConnection:Disconnect()
                end
            end
        end
        local MouseDownConnection = UserInputService.InputBegan:Connect(onMouseDown)
    end,
})
local utacxcpg = ut:CreateParagraph({Title = "Current X-Coordinate", Content = X})
local utacycpg = ut:CreateParagraph({Title = "Current Y-Coordinate", Content = Y})
