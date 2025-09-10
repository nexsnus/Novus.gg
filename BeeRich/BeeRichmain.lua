local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("Request")
local args = {"ManualGather"}

local Window = _G.Window

local beraftm = Window:CreateTab("Automation", "home")

local farmLoop
local farmActive = false

local beraft = beraftm:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "beraft",
    Callback = function(state)
        if state then
            farmActive = true
            farmLoop = task.spawn(function()
                while farmActive do
                    for i = 1, 5 do
                        remote:FireServer(unpack(args))
                    end
                    task.wait(0.01)
                end
            end)
        else
            farmActive = false
            if farmLoop then
                task.cancel(farmLoop)
                farmLoop = nil
            end
        end
    end,
})
