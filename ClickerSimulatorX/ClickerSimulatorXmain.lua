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

local csxmmtguis = cxsmmt:CreateSection("Guis")
local cxsmmtogmt = cxsmmt:CreateToggle({
        Name = "Open Gold Machine",
        CurrentValue = false,
        Flag = "cxsmmtogmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.GoldMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.GoldMachine.Enabled = false
            end
        end,
})
local cxsmmtocmt = cxsmmt:CreateToggle({
        Name = "Open Cosmic Machine",
        CurrentValue = false,
        Flag = "cxsmmtocmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.CosmicMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.CosmicMachine.Enabled = false
            end
        end,
})
local cxsmmtoctmt = cxsmmt:CreateToggle({
        Name = "Open Craft Machine",
        CurrentValue = false,
        Flag = "cxsmmtoctmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.CraftMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.CraftMachine.Enabled = false
            end
        end,
})
local cxsmmtodct = cxsmmt:CreateToggle({
        Name = "Open Daycare",
        CurrentValue = false,
        Flag = "cxsmmtodct",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.Daycare.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.Daycare.Enabled = false
            end
        end,
})
local cxsmmtofmt = cxsmmt:CreateToggle({
        Name = "Open Forge Machine",
        CurrentValue = false,
        Flag = "cxsmmtofmt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.ForgeMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.ForgeMachine.Enabled = false
            end
        end,
})
local cxsmmtormt = cxsmmt:CreateToggle({
        Name = "Open Rainbow Machine",
        CurrentValue = false,
        Flag = "cxsmmtormt",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.RainbowMachine.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.RainbowMachine.Enabled = false
            end
        end,
})
local cxsmmtopit = cxsmmt:CreateToggle({
        Name = "Open Pet Index",
        CurrentValue = false,
        Flag = "cxsmmtopit",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.PetIndex.Enabled = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.PetIndex.Enabled = false
            end
        end,
})
local cxsmmtdrguit = cxsmmt:CreateToggle({
        Name = "Disable Rebirth Gui",
        CurrentValue = false,
        Flag = "cxsmmtdrguit",
        Callback = function(state)
            if state then
                game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Enabled = false
            else
                game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Enabled = true
            end
        end,
})
