local Window = _G.Window

_G.ut = Window:CreateTab({
    Name = "Universal",
    Icon = "all_inclusive",
    ImageSource = "Material",
    ShowTitle = true
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/Universal/AntiAFK/AntiAFKmain.lua"))()
