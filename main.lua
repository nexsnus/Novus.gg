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

local utaafkt = ut:CreateButton({
        Name = "Anti Afk",
        Description = nil,
        Callback = function()
            local VirtualUser = game:GetService('VirtualUser')
 
            game:GetService('Players').LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)

            utaafkl:Set({
                Text = "Anti Afk = ON",
                Style = 3
            })
        end
}, "utaafkt")

local utaafkl = ut:CreateLabel({
        Text = "Anti Afk = OFF",
        Style = 2
})

if game.PlaceId == 7305309231 then
  repeat task.wait() until _G.Window
  loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/TaxiBoss/Taxibossmain.lua"))()
elseif game.PlaceId == 123821081589134 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/BreakYourBones/BreakYourBonesmain.lua"))()
else
    Luna:Destroy()
end
