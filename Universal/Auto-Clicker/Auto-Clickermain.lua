local Window = _G.Window
local ut = _G.ut

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Enabled = false
local X, Y = 0, 0
local interval = 1
local clickThread = nil
local mouseDownConnection = nil

local utacs = ut:CreateSection("Auto Clicker")

local utact = ut:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "utact",
    Callback = function(state)
        Enabled = state
        if clickThread then
            task.cancel(clickThread)
            clickThread = nil
        end
        if Enabled then
            clickThread = task.spawn(function()
                while Enabled do
                    VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 1)
                    task.wait(interval / 2)
                    VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 1)
                    task.wait(interval / 2)
                end
            end)
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
    CurrentKeybind = "nil",
    HoldToInteract = false,
    Flag = "utactb",
    Callback = function()
        utact:Set(not Enabled)
    end,
})

local utacxcpg = ut:CreateParagraph({Title = "Current X-Coordinate", Content = X})
local utacycpg = ut:CreateParagraph({Title = "Current Y-Coordinate", Content = Y})

local utacpb = ut:CreateButton({
    Name = "Set Position on Click",
    Callback = function()
        if mouseDownConnection then
            mouseDownConnection:Disconnect()
        end
        local function onMouseDown(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                X, Y = Mouse.X, Mouse.Y
                utacxcpg:Set({Title = "Current X-Coordinate", Content = X})
                utacycpg:Set({Title = "Current Y-Coordinate", Content = Y})
                mouseDownConnection:Disconnect()
                mouseDownConnection = nil
            end
        end
        mouseDownConnection = UserInputService.InputBegan:Connect(onMouseDown)
    end,
})   
