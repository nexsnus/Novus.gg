repeat wait() until game:IsLoaded()
_G.Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Snxdfer/back-ups-for-libs/refs/heads/main/Luna_Source.lua", true))()
_G.Window = _G.Luna:CreateWindow({
    Name = "Novus Hub",
    SubTitle = "by nexsnus", 
    LogoID = "82795327169782", 
    LoadingEnabled = true, 
    LoadingTitle = "Novus Hub", 
    LoadingSubtitle = "by nexsnus", 
    ConfigSettings = {
        RootFolder = nil, 
        ConfigFolder = "Novus Hub"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Luna Example Key",
        Subtitle = "Key System",
        Note = "Example",
        SaveInRoot = false,
        SaveKey = true,
        Key = {"Example Key"},
        SecondAction = {
            Enabled = true,
            Type = "Link",
            Parameter = ""
        }
    }
})

local Window = _G.Window

local ut = Window:CreateTab({
    Name = "Universal",
    Icon = "all_inclusive",
    ImageSource = "Material",
    ShowTitle = true
})

local antiAfkEnabled = false
local antiAfkConnection

local utaafkt = ut:CreateToggle({
    Name = "Anti Afk",
    Description = nil,
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
    end
}, "utaafkt")

if game.PlaceId == 7305309231 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/TaxiBoss/Taxibossmain.lua"))()
elseif game.PlaceId == 123821081589134 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/BreakYourBones/BreakYourBonesmain.lua"))()
elseif game.PlaceId == 96601927506261 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/BeeRich/BeeRichmain.lua"))()
else    
    Luna:Destroy()
end
