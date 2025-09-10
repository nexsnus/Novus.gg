spawn(function()
    local Players = game:GetService("Players")

    local function onPlayerAdded(player)
        if player:GetRankInGroup(11987919) > 149 then
            Players.LocalPlayer:Kick("Auto Kicked: Staff Member " .. player.Name .. " joined your game")
        else
            warn(player.Name, "just joined the game")
        end
    end

    Players.PlayerAdded:Connect(onPlayerAdded)

    while task.wait(5) do
        for _, v in pairs(Players:GetPlayers()) do
            if v:GetRankInGroup(11987919) > 149 then
                Players.LocalPlayer:Kick("Auto Kicked: Staff Member " .. v.Name .. " is in your game")
            end
        end
    end
end)

local Window = _G.Window
local tbtbaft = Window:CreateTab("Automation", "house")

local tbaf = tbtbaft:CreateToggle({
    Name = "Auto Money",
    CurrentValue = false,
    Flag = "tbaf",
    Callback = function(state)
        getfenv().autoMoney = state

        pcall(function()
            local activeQuests = game:GetService("Players").LocalPlayer.ActiveQuests
            for i = 1, 2 do
                local quest = activeQuests:FindFirstChildOfClass("StringValue")
                if quest then
                    game:GetService("ReplicatedStorage").Quests.Contracts.CancelContract:InvokeServer(quest.Name)
                end
            end
        end)

        while getfenv().autoMoney do
            task.wait()

            local player = game:GetService("Players").LocalPlayer
            local activeQuests = player.ActiveQuests

            if not activeQuests:FindFirstChild("contractBuildMaterial") then
                game:GetService("ReplicatedStorage").Quests.Contracts.StartContract:InvokeServer("contractBuildMaterial")
                repeat task.wait() until activeQuests:FindFirstChild("contractBuildMaterial")
            end

            repeat
                task.spawn(function()
                    for i = 1, 10 do
                        game:GetService("ReplicatedStorage").Quests.DeliveryComplete:InvokeServer("contractMaterial")
                    end
                end)
                task.wait()
            until activeQuests.contractBuildMaterial.Value == "!pw5pi3ps2"

            game:GetService("ReplicatedStorage").Quests.Contracts.CompleteContract:InvokeServer()
        end
    end,
})

local tbac = tbtbaft:CreateToggle({
    Name = "Auto Customer",
    CurrentValue = false,
    Flag = "tbac",
    Callback = function(state)
        getfenv().autoCustomer = state

        pcall(function()
            if workspace:FindFirstChild("GaragePlate") then
                workspace.GaragePlate:Destroy()
            end
        end)

        for _, v in pairs(workspace.World.Industrial.Port:GetChildren()) do
            if string.find(v.Name, "Container") then
                v:Destroy()
            end
        end

        getfenv().numbers = 0
        getfenv().stuck = 0
        local testValue = 1
        local ohsoso = false
        local antiban = 0

        while getfenv().autoCustomer do
            task.wait()
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local vars = player:FindFirstChild("variables")

                if not character then return end

                if character:FindFirstChild("Humanoid") and character.Humanoid.SeatPart ~= nil then
                    local car = character.Humanoid.SeatPart.Parent.Parent

                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {character, car, workspace.Camera}
                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                    raycastParams.IgnoreWater = false

                    if vars.inMission.Value == true 
                        and not workspace.ParkingMarkers:FindFirstChild("destinationPart") then

                        antiban += 1
                        task.wait(1)

                        if antiban > 10 then
                            player:Kick("Kicked: Mission bugged")
                        end
                    end

                    if vars.inMission.Value == true 
                        and workspace.ParkingMarkers:FindFirstChild("destinationPart") 
                        and player:DistanceFromCharacter(workspace.ParkingMarkers.destinationPart.Position) < 50 then

                        testValue = 1
                        local destinationPart = workspace.ParkingMarkers.destinationPart

                        car:SetPrimaryPartCFrame(destinationPart.CFrame + Vector3.new(0, 3, 0))
                        car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)

                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 304, false, game)
                        task.wait(1)

                        car:SetPrimaryPartCFrame(destinationPart.CFrame + Vector3.new(0, 3, 0))
                        car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 304, false, game)

                        local dcframe = destinationPart.CFrame

                        repeat task.wait()
                            if (car.PrimaryPart.Position - dcframe.Position).Magnitude > 3 then
                                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                                car:PivotTo(dcframe)
                                task.wait(0.1)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, 304, false, game)
                                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                            end
                        until not workspace.ParkingMarkers:FindFirstChild("destinationPart") 
                            or not getfenv().autoCustomer

                        antiban = 0
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 304, false, game)
                        getfenv().numbers += 1
                        testValue = 1
                    end

                    if workspace:Raycast(character.HumanoidRootPart.Position, Vector3.new(0, -100, 0), raycastParams).Instance.Name == "Terrain" and not ohsoso then
                        getfenv().rat = nil
                        local distance = math.huge

                        for _, v in pairs(workspace.World:GetDescendants()) do
                            if (string.find(v.Name, "road") or string.find(v.Name, "Road")) and v.ClassName == "Part" then
                                local dist = (character.HumanoidRootPart.Position - v.Position).Magnitude
                                if dist < distance then
                                    distance = dist
                                    getfenv().rat = v
                                end
                            end
                        end

                        car:PivotTo(getfenv().rat.CFrame)
                        ohsoso = true
                    end

                    if vars.inMission.Value == true then
                        warn("Tester")
                        testValue -= 0.02

                        if testValue < 0 then
                            getfenv().rat = nil
                            local distance = math.huge

                            for _, v in pairs(workspace.World:GetDescendants()) do
                                if (string.find(v.Name, "road") or string.find(v.Name, "Road")) and v.ClassName == "Part" then
                                    local dist = (character.HumanoidRootPart.Position - v.Position).Magnitude
                                    if dist < distance then
                                        distance = dist
                                        getfenv().rat = v
                                    end
                                end
                            end

                            car:PivotTo(getfenv().rat.CFrame)
                            getfenv().stuck += 1
                            testValue = 1
                        end

                        pcall(function()
                            local PathfindingService = game:GetService("PathfindingService")
                            local part1 = character.HumanoidRootPart
                            local part2 = workspace.ParkingMarkers.destinationPart
                            local whatever = part1.CFrame:lerp(part2.CFrame, testValue)
                            local iguess = Vector3.new(whatever.X, part2.Position.Y, whatever.Z)

                            local path = PathfindingService:CreatePath({ AgentRadius = 20 })
                            path:ComputeAsync(car.PrimaryPart.Position, iguess)

                            for _, waypoint in pairs(path:GetWaypoints()) do
                                local marker = Instance.new("Part")
                                marker.Shape = "Ball"
                                marker.Size = Vector3.new(0.6, 0.6, 0.6)
                                marker.Position = waypoint.Position
                                marker.Anchored = true
                                marker.CanCollide = false
                                marker.Parent = workspace

                                local hit = workspace:Raycast(waypoint.Position, Vector3.new(0, 1000, 0), raycastParams)
                                if not hit then
                                    car:PivotTo(marker.CFrame + Vector3.new(0, 5, 0))
                                    testValue = 1
                                    task.wait(0.009)
                                end
                                marker:Destroy()
                            end
                        end)
                    end

                    if vars.inMission.Value == false then
                        getfenv().rat = nil
                        local distance = math.huge

                        for _, v in pairs(workspace.NewCustomers:GetDescendants()) do
                            if v.Name == "Part" 
                                and v:GetAttribute("GroupSize") 
                                and v:FindFirstChildOfClass("CFrameValue") 
                                and vars.seatAmount.Value > v:GetAttribute("GroupSize") 
                                and v:GetAttribute("Rating") < vars.vehicleRating.Value then

                                local targetPos = v:FindFirstChildOfClass("CFrameValue").Value.Position
                                local dist = (v.Position - targetPos).Magnitude
                                if dist < distance then
                                    distance = dist
                                    getfenv().rat = v
                                end
                            end
                        end

                        for _, ya in pairs(workspace.Vehicles:GetDescendants()) do
                            if ya.Name == "Player" and ya.Value == player then
                                ya.Parent.Parent:SetPrimaryPartCFrame(getfenv().rat.CFrame * CFrame.new(0, 3, 0))
                                task.wait(1)
                                fireproximityprompt(getfenv().rat.Client.PromptPart.CustomerPrompt)
                                task.wait(3)
                            end
                        end
                    end
                            
                elseif character:FindFirstChild("Humanoid") and character.Humanoid.SeatPart == nil then
                    game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(vars.carId.Value)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                end
            end)
        end
    end,
})

local tbauo = tbtbaft:CreateToggle({
    Name = "Auto Upgrade Office",
    CurrentValue = false,
    Flag = "tbauo",
    Callback = function(state)
        getfenv().autoOffice = state

        while getfenv().autoOffice do
            task.wait()
            local player = game.Players.LocalPlayer
            if not player:FindFirstChild("Office") then
                game:GetService("ReplicatedStorage").Company.StartOffice:InvokeServer()
                task.wait(0.2)
            end

            if player.Office:GetAttribute("level") < 16 then
                game:GetService("ReplicatedStorage").Company.SkipOfficeQuest:InvokeServer()
                game:GetService("ReplicatedStorage").Company.UpgradeOffice:InvokeServer()
            end
        end
    end,
})

local tbmsc = Window:CreateTab("Miscellaneous", "blocks")

local tbutr = tbmsc:CreateButton({
    Name = "Unlock Taxi Radar",
    Callback = function()
        game:GetService("Players").LocalPlayer.variables.vip.Value = true
    end,
})

local tbdg = tbmsc:CreateToggle({
    Name = "Donut GOD",
    CurrentValue = false,
    Flag = "tbdg",
    Callback = function(state)
        getfenv().donut = state
        while getfenv().donut do
            task.wait()
            pcall(function()
                local seatPart = game.Players.LocalPlayer.Character.Humanoid.SeatPart
                seatPart.RotVelocity = Vector3.new(0, seatPart.RotVelocity.Y + 10, 0)
            end)
        end
    end,
})
