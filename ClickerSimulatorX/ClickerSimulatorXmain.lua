local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local banane = workspace.Gameplay.Dynamic.Bosses

local Window = _G.Window
local csxmat = Window:CreateTab("Automation", "home")

local csxmatakbt = csxmat:CreateToggle({
    Name = "Auto Kill Boss",
    CurrentValue = false,
    Flag = "csxmatakbt",
    Callback = function(state)
        if state then
            spawn(function()
                while state do
                    local children = banane:GetChildren()
                    if #children > 0 then
                        for _, boss in ipairs(children) do
                            if boss:IsA("BasePart") then
                                humanoidRootPart.CFrame = boss.CFrame
                                task.wait(0.7)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})   

local csxmmt = Window:CreateTab("Miscellaneous", "credit-card")
local csxmmtguis = csxmmt:CreateSection("Guis")

local csxmmtogmt = csxmmt:CreateToggle({
        Name = "Open Gold Machine",
        CurrentValue = false,
        Flag = "csxmmtogmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.GoldMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.GoldMachine.Enabled = false
            end
        end,
})
local csxmmtocmt = csxmmt:CreateToggle({
        Name = "Open Cosmic Machine",
        CurrentValue = false,
        Flag = "csxmmtocmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.CosmicMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.CosmicMachine.Enabled = false
            end
        end,
})
local csxmmtoctmt = csxmmt:CreateToggle({
        Name = "Open Craft Machine",
        CurrentValue = false,
        Flag = "csxmmtoctmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.CraftMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.CraftMachine.Enabled = false
            end
        end,
})
local csxmmtodct = csxmmt:CreateToggle({
        Name = "Open Daycare",
        CurrentValue = false,
        Flag = "csxmmtodct",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.Daycare.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.Daycare.Enabled = false
            end
        end,
})
local csxmmtofmt = csxmmt:CreateToggle({
        Name = "Open Forge Machine",
        CurrentValue = false,
        Flag = "csxmmtofmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.ForgeMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.ForgeMachine.Enabled = false
            end
        end,
})
local csxmmtormt = csxmmt:CreateToggle({
        Name = "Open Rainbow Machine",
        CurrentValue = false,
        Flag = "csxmmtormt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.RainbowMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.RainbowMachine.Enabled = false
            end
        end,
})
local csxmmtopit = csxmmt:CreateToggle({
        Name = "Open Pet Index",
        CurrentValue = false,
        Flag = "csxmmtopit",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.PetIndex.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.PetIndex.Enabled = false
            end
        end,
})
local csxmmtdrguit = csxmmt:CreateToggle({
        Name = "Disable Rebirth Gui",
        CurrentValue = false,
        Flag = "csxmmtdrguit",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Enabled = false
            else
                game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Enabled = true
            end
        end,
})
