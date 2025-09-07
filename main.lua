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

if game.PlaceId == 7305309231 then
  repeat task.wait() until _G.Window
  loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/TaxiBoss/Taxibossmain.lua"))()
else
    Luna:Destroy()
end
