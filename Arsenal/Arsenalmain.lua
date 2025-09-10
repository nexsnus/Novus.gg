local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Window = _G.Window

local aabt = Window:CreateTab("Aimbot", "crosshair")
local asat = Window:CreateTab("Silent Aim", "crosshair")
local avt = Window:CreateTab("Visuals", "nfc")
local agmt = Window:CreateTab("Gun Mods", "anvil")

local Enabled = false
local FOV = 100
local Smoothing = 0.1


local SilentAimEnabled = false
local HitboxSize = 13
local HitboxTransparency = 10


local ShowFOVCircle = false
local ShowESP = false
local ESPColor = Color3.new(0, 1, 0)

if not Drawing then
    return
end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = ShowFOVCircle
FOVCircle.Radius = FOV
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local ESPDrawings = {}


local function BroadcastPresence()
    if not _G.ArsenalScriptUsers then
        _G.ArsenalScriptUsers = {}
    end
    _G.ArsenalScriptUsers[LocalPlayer.Name] = {
        identifier = ScriptIdentifier,
        timestamp = tick(),
        player = LocalPlayer
    }
end

local function getPlayersName()
    for _, v in pairs(game:GetChildren()) do
        if v.ClassName == "Players" then
            return v.Name
        end
    end
end

local players = game[getPlayersName()]
local localPlayer = players.LocalPlayer

local silentAimConnections = {}

local function StartSilentAim()
    if silentAimConnections.transparency then
        silentAimConnections.transparency:Disconnect()
    end
    if silentAimConnections.hitbox then
        silentAimConnections.hitbox:Disconnect()
    end
    
    
    silentAimConnections.transparency = coroutine.wrap(function()
        while SilentAimEnabled do
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer and player.Character then
                    for _, partName in pairs({"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}) do
                        local part = player.Character:FindFirstChild(partName)
                        if part then
                            part.Transparency = HitboxTransparency
                        end
                    end
                end
            end
            wait(1)
        end
    end)()
    
    
    silentAimConnections.hitbox = coroutine.wrap(function()
        while SilentAimEnabled do
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer and player.Character then
                    for _, partName in pairs({"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}) do
                        local part = player.Character:FindFirstChild(partName)
                        if part then
                            part.CanCollide = false
                            part.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        end
                    end
                end
            end
            wait(1)
        end
    end)()
end

local function StopSilentAim()
    if silentAimConnections.transparency then
        silentAimConnections.transparency:Disconnect()
        silentAimConnections.transparency = nil
    end
    if silentAimConnections.hitbox then
        silentAimConnections.hitbox:Disconnect()
        silentAimConnections.hitbox = nil
    end
    
    
    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            for _, partName in pairs({"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}) do
                local part = player.Character:FindFirstChild(partName)
                if part then
                    part.Transparency = 0
                    part.CanCollide = true
                
                    if partName == "HumanoidRootPart" then
                        part.Size = Vector3.new(2, 2, 1)
                    elseif partName:find("Leg") then
                        part.Size = Vector3.new(1, 2, 1)
                    elseif partName == "HeadHB" then
                        part.Size = Vector3.new(2, 1, 1)
                    end
                end
            end
        end
    end
end


local function CreateESP(player)
    if ESPDrawings[player] then return end

    local drawings = {}
    drawings.Spine = Drawing.new("Line")
    drawings.LeftUpperArm = Drawing.new("Line")
    drawings.LeftLowerArm = Drawing.new("Line")
    drawings.RightUpperArm = Drawing.new("Line")
    drawings.RightLowerArm = Drawing.new("Line")
    drawings.LeftUpperLeg = Drawing.new("Line")
    drawings.LeftLowerLeg = Drawing.new("Line")
    drawings.RightUpperLeg = Drawing.new("Line")
    drawings.RightLowerLeg = Drawing.new("Line")
    
    drawings.DistanceText = Drawing.new("Text")
    drawings.DistanceText.Text = "0m"
    drawings.DistanceText.Size = 16
    drawings.DistanceText.Color = Color3.new(1, 1, 1)
    drawings.DistanceText.Center = true
    drawings.DistanceText.Outline = true
    drawings.DistanceText.OutlineColor = Color3.new(0, 0, 0)
    drawings.DistanceText.Visible = false
    
    for name, line in pairs(drawings) do
        if name:find("Arm") or name:find("Leg") or name == "Spine" then
            line.Visible = false
            line.Color = ESPColor
            line.Thickness = 2
        end
    end

    ESPDrawings[player] = drawings
end

local function RemoveESP(player)
    if not ESPDrawings[player] then return end

    for _, drawing in pairs(ESPDrawings[player]) do
        drawing:Remove()
    end
    ESPDrawings[player] = nil
end

local function UpdateESP()
    for player, drawings in pairs(ESPDrawings) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            if player.Team ~= LocalPlayer.Team then
                local character = player.Character
                local head = character:FindFirstChild("Head")
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                
                local leftUpperArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
                local leftLowerArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftLowerArm")
                local rightUpperArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
                local rightLowerArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightLowerArm")
                local leftUpperLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
                local leftLowerLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftLowerLeg")
                local rightUpperLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
                local rightLowerLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightLowerLeg")

                if head and torso then
                    local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
                    local torsoPos, torsoOnScreen = Camera:WorldToViewportPoint(torso.Position)
                    
                    if headOnScreen and torsoOnScreen then
                        drawings.Spine.From = Vector2.new(headPos.X, headPos.Y)
                        drawings.Spine.To = Vector2.new(torsoPos.X, torsoPos.Y)
                        drawings.Spine.Visible = ShowESP
                        
                        if leftUpperArm then
                            local leftUpperArmPos, leftUpperArmOnScreen = Camera:WorldToViewportPoint(leftUpperArm.Position)
                            if leftUpperArmOnScreen then
                                drawings.LeftUpperArm.From = Vector2.new(torsoPos.X, torsoPos.Y)
                                drawings.LeftUpperArm.To = Vector2.new(leftUpperArmPos.X, leftUpperArmPos.Y)
                                drawings.LeftUpperArm.Visible = ShowESP
                                
                                if leftLowerArm and leftLowerArm ~= leftUpperArm then
                                    local leftLowerArmPos, leftLowerArmOnScreen = Camera:WorldToViewportPoint(leftLowerArm.Position)
                                    if leftLowerArmOnScreen then
                                        drawings.LeftLowerArm.From = Vector2.new(leftUpperArmPos.X, leftUpperArmPos.Y)
                                        drawings.LeftLowerArm.To = Vector2.new(leftLowerArmPos.X, leftLowerArmPos.Y)
                                        drawings.LeftLowerArm.Visible = ShowESP
                                    else
                                        drawings.LeftLowerArm.Visible = false
                                    end
                                else
                                    drawings.LeftLowerArm.Visible = false
                                end
                            else
                                drawings.LeftUpperArm.Visible = false
                                drawings.LeftLowerArm.Visible = false
                            end
                        else
                            drawings.LeftUpperArm.Visible = false
                            drawings.LeftLowerArm.Visible = false
                        end
                        
                        if rightUpperArm then
                            local rightUpperArmPos, rightUpperArmOnScreen = Camera:WorldToViewportPoint(rightUpperArm.Position)
                            if rightUpperArmOnScreen then
                                drawings.RightUpperArm.From = Vector2.new(torsoPos.X, torsoPos.Y)
                                drawings.RightUpperArm.To = Vector2.new(rightUpperArmPos.X, rightUpperArmPos.Y)
                                drawings.RightUpperArm.Visible = ShowESP
                                
                                if rightLowerArm and rightLowerArm ~= rightUpperArm then
                                    local rightLowerArmPos, rightLowerArmOnScreen = Camera:WorldToViewportPoint(rightLowerArm.Position)
                                    if rightLowerArmOnScreen then
                                        drawings.RightLowerArm.From = Vector2.new(rightUpperArmPos.X, rightUpperArmPos.Y)
                                        drawings.RightLowerArm.To = Vector2.new(rightLowerArmPos.X, rightLowerArmPos.Y)
                                        drawings.RightLowerArm.Visible = ShowESP
                                    else
                                        drawings.RightLowerArm.Visible = false
                                    end
                                else
                                    drawings.RightLowerArm.Visible = false
                                end
                            else
                                drawings.RightUpperArm.Visible = false
                                drawings.RightLowerArm.Visible = false
                            end
                        else
                            drawings.RightUpperArm.Visible = false
                            drawings.RightLowerArm.Visible = false
                        end
                        
                        if leftUpperLeg then
                            local leftUpperLegPos, leftUpperLegOnScreen = Camera:WorldToViewportPoint(leftUpperLeg.Position)
                            if leftUpperLegOnScreen then
                                drawings.LeftUpperLeg.From = Vector2.new(torsoPos.X, torsoPos.Y)
                                drawings.LeftUpperLeg.To = Vector2.new(leftUpperLegPos.X, leftUpperLegPos.Y)
                                drawings.LeftUpperLeg.Visible = ShowESP
                                
                                if leftLowerLeg and leftLowerLeg ~= leftUpperLeg then
                                    local leftLowerLegPos, leftLowerLegOnScreen = Camera:WorldToViewportPoint(leftLowerLeg.Position)
                                    if leftLowerLegOnScreen then
                                        drawings.LeftLowerLeg.From = Vector2.new(leftUpperLegPos.X, leftUpperLegPos.Y)
                                        drawings.LeftLowerLeg.To = Vector2.new(leftLowerLegPos.X, leftLowerLegPos.Y)
                                        drawings.LeftLowerLeg.Visible = ShowESP
                                    else
                                        drawings.LeftLowerLeg.Visible = false
                                    end
                                else
                                    drawings.LeftLowerLeg.Visible = false
                                end
                            else
                                drawings.LeftUpperLeg.Visible = false
                                drawings.LeftLowerLeg.Visible = false
                            end
                        else
                            drawings.LeftUpperLeg.Visible = false
                            drawings.LeftLowerLeg.Visible = false
                        end
                        
                        if rightUpperLeg then
                            local rightUpperLegPos, rightUpperLegOnScreen = Camera:WorldToViewportPoint(rightUpperLeg.Position)
                            if rightUpperLegOnScreen then
                                drawings.RightUpperLeg.From = Vector2.new(torsoPos.X, torsoPos.Y)
                                drawings.RightUpperLeg.To = Vector2.new(rightUpperLegPos.X, rightUpperLegPos.Y)
                                drawings.RightUpperLeg.Visible = ShowESP
                                
                                if rightLowerLeg and rightLowerLeg ~= rightUpperLeg then
                                    local rightLowerLegPos, rightLowerLegOnScreen = Camera:WorldToViewportPoint(rightLowerLeg.Position)
                                    if rightLowerLegOnScreen then
                                        drawings.RightLowerLeg.From = Vector2.new(rightUpperLegPos.X, rightUpperLegPos.Y)
                                        drawings.RightLowerLeg.To = Vector2.new(rightLowerLegPos.X, rightLowerLegPos.Y)
                                        drawings.RightLowerLeg.Visible = ShowESP
                                    else
                                        drawings.RightLowerLeg.Visible = false
                                    end
                                else
                                    drawings.RightLowerLeg.Visible = false
                                end
                            else
                                drawings.RightUpperLeg.Visible = false
                                drawings.RightLowerLeg.Visible = false
                            end
                        else
                            drawings.RightUpperLeg.Visible = false
                            drawings.RightLowerLeg.Visible = false
                        end
                        
                        local distance = math.floor((head.Position - Camera.CFrame.Position).Magnitude)
                        drawings.DistanceText.Text = distance .. "m"
                        drawings.DistanceText.Position = Vector2.new(headPos.X, headPos.Y - 25)
                        drawings.DistanceText.Visible = ShowESP
                    else
                        for _, element in pairs(drawings) do
                            element.Visible = false
                        end
                    end
                else
                    for _, element in pairs(drawings) do
                        element.Visible = false
                    end
                end
            else
                for _, element in pairs(drawings) do
                    element.Visible = false
                end
            end
        else
            for _, element in pairs(drawings) do
                element.Visible = false
            end
        end
    end
end


local function IsPlayerVisible(player)
    if not player.Character then return false end
    local target = player.Character:FindFirstChild("Head")
    if not target then return false end

    local origin = Camera.CFrame.Position
    local direction = (target.Position - origin).Unit
    local ray = Ray.new(origin, direction * 1000)

    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})

    if hit and hit:IsDescendantOf(player.Character) then
        return true
    end
    return false
end

local function IsInFOVCircle(player)
    if not player.Character then return false end
    local target = player.Character:FindFirstChild("Head")
    if not target then return false end

    local screenPoint, onScreen = Camera:WorldToViewportPoint(target.Position)
    if not onScreen then return false end

    local circleCenter = FOVCircle.Position
    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - circleCenter).Magnitude

    return distance <= FOVCircle.Radius
end

local function GetClosestPlayerInFOV()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            if player.Team ~= LocalPlayer.Team then
                if IsPlayerVisible(player) and IsInFOVCircle(player) then
                    local screenPoint = Camera:WorldToViewportPoint(player.Character.Head.Position)
                    local circleCenter = FOVCircle.Position
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - circleCenter).Magnitude

                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function AimBot()
    if not Enabled then return end 
    local closestPlayer = GetClosestPlayerInFOV()
    if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
        local target = closestPlayer.Character.Head
        
        local currentLook = Camera.CFrame.LookVector
        local targetLook = (target.Position - Camera.CFrame.Position).Unit
        local adjustedLook = (currentLook + (targetLook - currentLook) * Smoothing).Unit
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + adjustedLook)
    end
end

local aabtabt = aabt:CreateToggle({
  Name = "Aimbot",
  CurrentValue = "false",
  Flag = "aabtabt",
  Callback = function(state)
    Enabled = state
  end,
})

local asatsat = asat:CreateToggle({
  Name = "Silent Aim",
  CurrentValue = "false",
  Flag = "asatsat",
  Callback = function(state)
    SilentAimEnabled = state
    if state then
      StartSilentAim()
    else
      StopSilentAim()
    end
  end,
})

local avtsfovt = avt:CreateToggle({
  Name = "Show FOV",
  CurrentValue = "false",
  Flag = "avtsfovt",
  Callback = function(state)
    ShowFOVCircle = state
    FOVCircle.Visible = state
  end,
})

local avtsespt = avt:CreateToggle({
  Name = "Skeleton ESP",
  CurrentValue = "false",
  Flag = "avtsespt",
  Callback = function(state)
    ShowESP = state
  end,
})

local avtfovgs = avt:CreateSlider({
  Name = "FOV Size",
  Range = {50, 300},
  Increment = 1,
  Suffix = "Size",
  CurrentValue = 50,
  Flag = "avtfovgs",
  Callback = function(value)
    FOV = value
    FOVCircle.Radius = value
  end,
})

local aabtsts = aabt:CreateSlider({
  Name = "Smoothing",
  Range = {30, 100},
  Increment = 1,
  Suffix = "Smoothness",
  CurrentValue = 30,
  Flag = "aabtsts",
  Callback = function(value)
    Smoothing = value / 100
  end,
})

local avtespcp = avt:CreateColorPicker({
  Name = "ESP Color",
  Color = Color3.fromRGB(255,255,255),
  Flag = "avtespcp",
  Callback = function(value)
    ESPColor = value
    for _, drawings in pairs(ESPDrawings) do
        if drawings.Spine then drawings.Spine.Color = value end
        if drawings.LeftUpperArm then drawings.LeftUpperArm.Color = value end
        if drawings.LeftLowerArm then drawings.LeftLowerArm.Color = value end
        if drawings.RightUpperArm then drawings.RightUpperArm.Color = value end
        if drawings.RightLowerArm then drawings.RightLowerArm.Color = value end
        if drawings.LeftUpperLeg then drawings.LeftUpperLeg.Color = value end
        if drawings.LeftLowerLeg then drawings.LeftLowerLeg.Color = value end
        if drawings.RightUpperLeg then drawings.RightUpperLeg.Color = value end
        if drawings.RightLowerLeg then drawings.RightLowerLeg.Color = value end
    end
  end
})

local success, err = pcall(function()
    RunService.RenderStepped:Connect(function()
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        UpdateESP()
    end)
    RunService.RenderStepped:Connect(AimBot)
end)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

local agmtrgt = agmt:CreateToggle({
        Name = "Rainbow Gun",
        CurrentValue = false,
        Flag = "agmtrgt",
        Callback = function(state)
            if state == true then
                local c = 1
                function zigzag(X)
                 return math.acos(math.cos(X * math.pi)) / math.pi
                end
                game:GetService("RunService").RenderStepped:Connect(function()
                 if game.Workspace.Camera:FindFirstChild('Arms') then
                  for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                   if v.ClassName == 'MeshPart' then 
                    v.Color = Color3.fromHSV(zigzag(c),1,1)
                    c = c + .0001
                   end
                  end
                 end
                end)
            end
        end,
})

local agmtiat = agmt:CreateToggle({
        Name = "Infinite Ammo",
        CurrentValue = false,
        Flag = "agmtiat",
        Callback = function(state)
            while state do
                game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999
                game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
                wait() 
            end   
        end,
})
