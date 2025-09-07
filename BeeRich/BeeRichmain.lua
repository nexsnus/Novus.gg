local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("Request")
local args = {"ManualGather"}

local Window = _G.Window

local beraftm = Window:CreateTab({
    Name = "Auto Farm",
    Icon = "double_arrow",
    ImageSource = "Material",
    ShowTitle = true
})

local farmLoop

local beraft = beraftm:CreateToggle({
    Name = "Auto Farm",
    Description = nil,
    CurrentValue = false,
    Callback = function(state)
      if state then
        farmLoop = task.spawn(function()
            while farmActive do
                for i = 1, 5 do 
                    remote:FireServer(unpack(args))
                    remote:FireServer(unpack(args))
                    remote:FireServer(unpack(args))
                    remote:FireServer(unpack(args))
                end
                task.wait(0.01)
            end
        end)
    end
}, "beraft")
