local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Snxdfer/back-ups-for-libs/refs/heads/main/Luna_Source.lua", true))()
local Window = Luna:CreateWindow({
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
		  Note = "Best Key System Ever! Also, Please Use A HWID Keysystem like Pelican, Luarmor etc. that provide key strings based on your HWID since putting a simple string is very easy to bypass",
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
if game.placeId == 7305309231 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/kxzyInt/Novus-Hub/refs/heads/main/Taxiboss/main"))()
end
