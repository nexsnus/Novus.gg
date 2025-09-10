repeat wait() until game:IsLoaded()
_G.Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
_G.Window = _G.Rayfield:CreateWindow({
   Name = "Novus.gg",
   Icon = 0,
   LoadingTitle = "Novus.gg is loading",
   LoadingSubtitle = "by nexsnus",
   ShowText = "Novus.gg", 
   Theme = "Default",

   ToggleUIKeybind = "K",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = false,
      FolderName = "Novus.gg", 
      FileName = "Novus.gg config"
   },

   Discord = {
      Enabled = false, 
      Invite = "noinvitelink", 
      RememberJoins = true
   },

   KeySystem = false, 
   KeySettings = {
      Title = "Novus.gg Keyguard",
      Subtitle = nil,
      Note = "No method of obtaining the key is provided", 
      FileName = "Key", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Hello"} 
   }
})

if game.PlaceId == 7305309231 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/Novus.gg/refs/heads/main/TaxiBoss/Taxibossmain.lua"))()
elseif game.PlaceId == 123821081589134 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/Novus.gg/refs/heads/main/BreakYourBones/BreakYourBonesmain.lua"))()
elseif game.PlaceId == 96601927506261 then
    repeat task.wait() until _G.Window
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/Novus.gg/refs/heads/main/BeeRich/BeeRichmain.lua"))()
elseif game.PlaceId == 286090429 then
   repeat task.wait() until _G.Window
   loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/Novus.gg/refs/heads/main/Arsenal/Arsenalmain"))()
else    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/Novus.gg/refs/heads/main/Universal/Universalmain.lua"))()
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/nexsnus/NovusHub/refs/heads/main/Universal/Universalmain.lua"))()
