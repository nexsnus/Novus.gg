local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local runningAutofarm = false
local runningUpgrade = false
local runningNextRagdoll = false
local runningRefine = false
local slamDuration = 20
local slamVelocity = 100

local function setFrozen(char, state)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.Anchored = state end
end

local function safeTeleport(char, cframeAbove)
    local parts = {}
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            parts[#parts+1] = part
            part.Anchored = true
            part.AssemblyLinearVelocity = Vector3.new()
            part.AssemblyAngularVelocity = Vector3.new()
        end
    end

    for _, part in pairs(parts) do
        part.CFrame = cframeAbove + Vector3.new(math.random(-1,1), 0, math.random(-1,1))
    end

    task.wait(0.3)

    for _, part in pairs(parts) do
        part.Anchored = false
    end
end

local function fireRagdollTouch()
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local ragdollPart = workspace:FindFirstChild("RagdollParts") and workspace.RagdollParts:FindFirstChild("RagdollCollission")
    if hrp and ragdollPart then
        local touchInterest = ragdollPart:FindFirstChildOfClass("TouchTransmitter")
        if touchInterest then
            firetouchinterest(hrp, ragdollPart, 0)
            task.wait()
            firetouchinterest(hrp, ragdollPart, 1)
        end
    end
end

local function autofarmLoop()
    while runningAutofarm do
        local char = plr.Character
        if not char then
            task.wait(1)
        else
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            local spawnFolder = workspace:FindFirstChild("Spawn")
            if hrp and head and spawnFolder then
                local targetPart = workspace:GetChildren()[50]
                local teleportTarget = spawnFolder:GetChildren()[84]
                if targetPart and teleportTarget then
                    fireRagdollTouch()
                    local startTime = tick()
                    while tick()-startTime < slamDuration and runningAutofarm do
                        if not (hrp and head and targetPart) then break end
                        local direction = (targetPart.Position - hrp.Position).Unit
                        local velocity = direction * slamVelocity
                        for _, partName in pairs({"HumanoidRootPart","Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}) do
                            local part = char:FindFirstChild(partName)
                            if part then
                                part.AssemblyLinearVelocity = velocity + Vector3.new(0,15,0)
                            end
                        end
                        task.wait(0.15)
                    end
                    setFrozen(char,true)
                    safeTeleport(char, teleportTarget.CFrame + Vector3.new(0,10,0))
                    setFrozen(char,false)
                    local oldChar = char
                    repeat task.wait(0.5) until not runningAutofarm or (plr.Character ~= oldChar and plr.Character:FindFirstChild("HumanoidRootPart"))
                    if not runningAutofarm then return end
                    task.wait(1)
                    fireRagdollTouch()
                else
                    task.wait(1)
                end
            else
                task.wait(1)
            end
        end
    end
end

local function autoUpgradeLoop()
    while runningUpgrade do
        Remotes.PurchaseBoneUpgrade:FireServer("Head")
        Remotes.PurchaseBoneUpgrade:FireServer("Torso")
        Remotes.PurchaseBoneUpgrade:FireServer("Arm")
        Remotes.PurchaseBoneUpgrade:FireServer("Leg")
        task.wait(0.2)
    end
end

local function autoNextRagdollLoop()
    while runningNextRagdoll do
        Remotes.PurchaseNextRagdoll:FireServer()
        task.wait(0.5)
    end
end

local function autoRefineLoop()
    while runningRefine do
        Remotes.RefineRagdoll:FireServer()
        task.wait(0.5)
    end
end

local function autoDiscountedRefineLoop()
    while runningDiscountedRefine do
        if game:GetService("Workspace").Refining.RefiningButton.BillboardGui.Discounted.visible == true
            Remotes.RefineRagdoll:FireServer()
        end
    end
end

local Window = _G.Window

local bybmt = Window:CreateTab({
    Name = "Auto Farm",
    Icon = "double_arrow",
    ImageSource = "Material",
    ShowTitle = true
})

local bybaft = bybmt:CreateToggle({
    Name = "Auto Slam",
    Description = nil,
    CurrentValue = false,
    Callback = function(state)
        runningAutofarm = state
    	  if state then task.spawn(autofarmLoop) end
    end
}, "bybaft")

local bybsds = bybmt:CreateSlider({
    Name = "Slam Duration",
    Range = {5, 60},
    Increment = 1,
    CurrentValue = 20,
        Callback = function(value)
            slamDuration = value
        end
}, "bybsds")

local bybsvs = bybmt:CreateSlider({
    Name = "Slam Velocity",
    Range = {50, 500},
    Increment = 1,
    CurrentValue = 100,
        Callback = function(value)
            slamVelocity = value
        end
}, "bybsvs")

local bybanrt = bybmt:CreateToggle({
    Name = "Auto Purchase Next Ragdoll",
    Description = nil,
    CurrentValue = false,
    Callback = function(state)
        runningNextRagdoll = state
    	  if state then task.spawn(autoNextRagdollLoop) end
    end
}, "bybanrt")

local bybaut = bybmt:CreateToggle({
    Name = "Auto Upgrade Bones",
    Description = nil,
    CurrentValue = false,
    Callback = function(state)
        runningUpgrade = state
    	  if state then task.spawn(autoUpgradeLoop) end
    end
}, "bybaut")

local bybart = bybmt:CreateToggle({
    Name = "Auto Refine Ragdoll",
    Description = nil,
    CurrentValue = false,
    Callback = function(state)
        runningRefine = state
    	  if state then task.spawn(autoRefineLoop) end
    end
}, "bybart")

local bybadrt = bybmt:CreateToggle({
    Name = "Auto Discounted Refine Ragdoll",
    Description = nil,
    CurrentValue = false,
    Callback = function(state)
        runningDiscountedRefine = state
    	  if state then task.spawn(autoDiscountedRefineLoop) end
    end
}, "bybadrt")
