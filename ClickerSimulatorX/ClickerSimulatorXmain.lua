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
        while state do
            task.wait(1) 
            if #banane:GetChildren() > 0 then
                for _, child in ipairs(banane:GetChildren()) do
                    if child:IsA("BasePart") then
                        humanoidRootPart.CFrame = child.CFrame
                        task.wait(0.5) 
                    end
                end
            end
        end   
    end,
})
