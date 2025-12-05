local Window = _G.Window
local ut = _G.ut

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = Players.LocalPlayer
local Enabled = false
local Mouse = Player:GetMouse()
local X, Y = 1700, 600
local interval = 1

while Enabled do
      VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 1)
      VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 1)
      wait(interval)
end

local utacs = ut:CreateSection("Auto Clicker")
local utact = ut:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "utact",
    Callback = function(state)
        Enabled = state
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
            Enabled = true
        end,
})
