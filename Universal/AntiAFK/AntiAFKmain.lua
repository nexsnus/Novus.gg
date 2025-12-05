local Window = _G.Window
local ut = _G.ut

local antiAfkEnabled = false
local antiAfkConnection

local utaafks = ut:CreateSection("AntiAFK")
local utaafkt = ut:CreateToggle({
    Name = "Anti Afk",
    CurrentValue = false,
    Flag = "utaafkt",
    Callback = function()
        if not antiAfkEnabled then
            antiAfkEnabled = true
            local VirtualUser = game:GetService("VirtualUser")
            antiAfkConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            antiAfkEnabled = false
            if antiAfkConnection then
                antiAfkConnection:Disconnect()
                antiAfkConnection = nil
            end
        end
    end,
})
