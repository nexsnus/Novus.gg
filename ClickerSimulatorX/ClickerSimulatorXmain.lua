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
