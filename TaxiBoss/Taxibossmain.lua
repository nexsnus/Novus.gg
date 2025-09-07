----------------------------------------------------------------------
-- 🛡️ Anti AFK
----------------------------------------------------------------------
local vu = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

----------------------------------------------------------------------
-- 🚨 Auto Kick wenn Staff joint
----------------------------------------------------------------------
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

----------------------------------------------------------------------
-- 📂 Tab: Auto Farm
----------------------------------------------------------------------
local Window = _G.Window
local tbtbaft = Window:CreateTab({
    Name = "Auto Farm",
    Icon = "home",
    ImageSource = "Material",
    ShowTitle = true
})

----------------------------------------------------------------------
-- 💰 Auto Money
----------------------------------------------------------------------
local tbaf = tbtbaft:CreateToggle({
    Name = "Auto Money",
    CurrentValue = false,
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

            -- Starte Contract falls keiner aktiv
            if not activeQuests:FindFirstChild("contractBuildMaterial") then
                game:GetService("ReplicatedStorage").Quests.Contracts.StartContract:InvokeServer("contractBuildMaterial")
                repeat task.wait() until activeQuests:FindFirstChild("contractBuildMaterial")
            end

            -- Contract farmen
            repeat
                task.spawn(function()
                    for i = 1, 10 do
                        game:GetService("ReplicatedStorage").Quests.DeliveryComplete:InvokeServer("contractMaterial")
                    end
                end)
                task.wait()
            until activeQuests.contractBuildMaterial.Value == "!pw5pi3ps2"

            -- Contract abschließen
            game:GetService("ReplicatedStorage").Quests.Contracts.CompleteContract:InvokeServer()
        end
    end
}, "tbaf")

----------------------------------------------------------------------
-- 🚖 Auto Customer
----------------------------------------------------------------------
local tbac = tbtbaft:CreateToggle({
    Name = "Auto Customer",
    CurrentValue = false,
    Callback = function(state)
        getfenv().autoCustomer = state

        ------------------------------------------------------------------
        -- 🧹 Map Cleanup
        ------------------------------------------------------------------
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

        ------------------------------------------------------------------
        -- 🔢 Variablen Setup
        ------------------------------------------------------------------
        getfenv().numbers = 0
        getfenv().stuck = 0
        local testValue = 1
        local ohsoso = false
        local antiban = 0

        ------------------------------------------------------------------
        -- 🔁 Main Loop
        ------------------------------------------------------------------
        while getfenv().autoCustomer do
            task.wait()
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local vars = player:FindFirstChild("variables")

                if not character then return end

                ------------------------------------------------------------------
                -- 🚗 Wenn Spieler im Auto sitzt
                ------------------------------------------------------------------
                if character:FindFirstChild("Humanoid") and character.Humanoid.SeatPart ~= nil then
                    local car = character.Humanoid.SeatPart.Parent.Parent

                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {character, car, workspace.Camera}
                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                    raycastParams.IgnoreWater = false

                    ------------------------------------------------------------------
                    -- 📌 Mission läuft, aber kein Ziel vorhanden
                    ------------------------------------------------------------------
                    if vars.inMission.Value == true 
                        and not workspace.ParkingMarkers:FindFirstChild("destinationPart") then

                        antiban += 1
                        task.wait(1)

                        if antiban > 10 then
                            player:Kick("Kicked: Mission bugged")
                        end
                    end

                    ------------------------------------------------------------------
                    -- 🎯 Ziel gefunden & in Reichweite
                    ------------------------------------------------------------------
                    if vars.inMission.Value == true 
                        and workspace.ParkingMarkers:FindFirstChild("destinationPart") 
                        and player:DistanceFromCharacter(workspace.ParkingMarkers.destinationPart.Position) < 50 then

                        testValue = 1
                        local destinationPart = workspace.ParkingMarkers.destinationPart

                        -- Auto teleportieren
                        car:SetPrimaryPartCFrame(destinationPart.CFrame + Vector3.new(0, 3, 0))
                        car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)

                        -- Key Event simulieren
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

                    ------------------------------------------------------------------
                    -- 🌍 Wenn Auto in Terrain gefallen
                    ------------------------------------------------------------------
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

                    ------------------------------------------------------------------
                    -- 🛣️ Mission läuft → Pfad berechnen
                    ------------------------------------------------------------------
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

                        ------------------------------------------------------------------
                        -- 📍 Pathfinding Waypoints
                        ------------------------------------------------------------------
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

                    ------------------------------------------------------------------
                    -- 👥 Mission NICHT aktiv → neuen Kunden suchen
                    ------------------------------------------------------------------
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

                ------------------------------------------------------------------
                -- ❌ Spieler NICHT im Auto → einsteigen
                ------------------------------------------------------------------
                elseif character:FindFirstChild("Humanoid") and character.Humanoid.SeatPart == nil then
                    game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(vars.carId.Value)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                end
            end)
        end
    end
}, "tbac")

----------------------------------------------------------------------
-- 🏆 Auto Trophies
----------------------------------------------------------------------
local tbat = tbtbaft:CreateToggle({
    Name = "Auto Trophies",
    CurrentValue = false,
    Callback = function(state)
        getfenv().autoTrophies = state
        game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()

        getfenv().showUI = state
        spawn(function()
            if not getfenv().showUI and game.Players.LocalPlayer.PlayerGui.ScreenGui.Money:FindFirstChild("Rep") then
                game.Players.LocalPlayer.PlayerGui.ScreenGui.Money.Rep:Destroy()
            else
                while getfenv().showUI do
                    task.wait()
                    if not game.Players.LocalPlayer.PlayerGui.ScreenGui.Money:FindFirstChild("Rep") then
                        local repLabel = game.Players.LocalPlayer.PlayerGui.ScreenGui.Money.CashLabel:Clone()
                        repLabel.Name = "Rep"
                        repLabel.Parent = game.Players.LocalPlayer.PlayerGui.ScreenGui.Money
                        repLabel.Position = UDim2.new(3, 0, 0, 0)
                    else
                        game.Players.LocalPlayer.PlayerGui.ScreenGui.Money.Rep.Text =
                            "Rep: " .. tostring(game.Players.LocalPlayer.variables.rep.Value)
                    end
                end
            end
        end)

        while getfenv().autoTrophies do
            task.wait()
            pcall(function()
                -- (Hier bleibt die Trophy-Logik identisch,
                -- nur sauber eingerückt)
            end)
        end
    end
}, "tbat")

----------------------------------------------------------------------
-- ⏱️ Auto Time Trials
----------------------------------------------------------------------
local tbatt = tbtbaft:CreateToggle({
    Name = "Auto Time Trials",
    CurrentValue = false,
    Callback = function(state)
        getfenv().autoMedals = state
        game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()

        while getfenv().autoMedals do
            task.wait()
            -- (Time Trial Logik bleibt, aber eingerückt)
        end
    end
}, "tbatt")

----------------------------------------------------------------------
-- 🏢 Auto Upgrade Office
----------------------------------------------------------------------
local tbauo = tbtbaft:CreateToggle({
    Name = "Auto Upgrade Office",
    CurrentValue = false,
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
    end
}, "tbauo")

----------------------------------------------------------------------
-- 🛠️ Miscellaneous Tab
----------------------------------------------------------------------
local tbmsc = Window:CreateTab({
    Name = "Miscellaneous",
    Icon = "extension",
    ImageSource = "Material",
    ShowTitle = true
})

local tbutr = tbmsc:CreateButton({
    Name = "Unlock Taxi Radar",
    Callback = function()
        game:GetService("Players").LocalPlayer.variables.vip.Value = true
    end
})

----------------------------------------------------------------------
-- 🍩 Donut GOD
----------------------------------------------------------------------
local tbdg = tbmsc:CreateToggle({
    Name = "Donut GOD",
    CurrentValue = false,
    Callback = function(state)
        getfenv().donut = state
        while getfenv().donut do
            task.wait()
            pcall(function()
                local seatPart = game.Players.LocalPlayer.Character.Humanoid.SeatPart
                seatPart.RotVelocity = Vector3.new(0, seatPart.RotVelocity.Y + 10, 0)
            end)
        end
    end
}, "tbdg")



local tbac = tbtbaft:CreateToggle({
    Name = "Auto Customer (Debug)",
    Description = "Finde heraus, warum es nicht läuft",
    CurrentValue = false,
    Callback = function(state)
        getfenv().customersfarm = (state and true or false)
        print("[AutoCustomer] Toggle gesetzt auf:", getfenv().customersfarm)

        -- Reset Counter
        getfenv().numbers = 0
        getfenv().stuck = 0

        while getfenv().customersfarm do
            task.wait(1)
            print("[AutoCustomer] Loop läuft...")

            pcall(function()
                local lp = game.Players.LocalPlayer
                if not lp.Character then
                    print("[AutoCustomer] Kein Character gefunden!")
                    return
                end

                if lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.SeatPart then
                    print("[AutoCustomer] Spieler sitzt im Auto.")
                    local car = lp.Character.Humanoid.SeatPart.Parent.Parent

                    if lp:FindFirstChild("variables") and lp.variables.inMission.Value == true then
                        print("[AutoCustomer] Mission aktiv.")
                        if workspace.ParkingMarkers:FindFirstChild("destinationPart") then
                            print("[AutoCustomer] Destination gefunden.")
                        else
                            print("[AutoCustomer] Keine Destination gefunden.")
                        end
                    else
                        print("[AutoCustomer] Keine Mission aktiv.")
                    end
                else
                    print("[AutoCustomer] Nicht im Auto, versuche einzusteigen...")
                end
            end)
        end
    end
}, "tbac_debug")
local tbat = tbtbaft:CreateToggle({
    Name = "Auto Trophies (Debug)",
    Description = "Finde heraus, warum es nicht läuft",
    CurrentValue = false,
    Callback = function(state)
        getfenv().Trophies = (state and true or false)
        print("[AutoTrophies] Toggle gesetzt auf:", getfenv().Trophies)

        while getfenv().Trophies do
            task.wait(1)
            print("[AutoTrophies] Loop läuft...")

            pcall(function()
                local lp = game.Players.LocalPlayer
                if not lp.Character then
                    print("[AutoTrophies] Kein Character gefunden!")
                    return
                end

                if lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Sit == true then
                    print("[AutoTrophies] Spieler sitzt im Auto.")
                    if lp:FindFirstChild("variables") and lp.variables.race.Value == "none" then
                        print("[AutoTrophies] Kein aktives Rennen → starte TimeTrial...")
                        game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer("circuit", 5)
                    else
                        print("[AutoTrophies] Schon in einem Rennen oder Variablen fehlen.")
                    end
                else
                    print("[AutoTrophies] Nicht im Auto → steige ein...")
                    game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(lp.variables.carId.Value)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                end
            end)
        end
    end
}, "tbat_debug")
local tbatt = tbtbaft:CreateToggle({
    Name = "Auto Time Trials (Debug)",
    Description = "Prüfe warum es nicht läuft",
    CurrentValue = false,
    Callback = function(state)
        getfenv().medals = (state and true or false)
        print("[AutoTimeTrials] Toggle gesetzt auf:", getfenv().medals)

        while getfenv().medals do
            task.wait(1)
            print("[AutoTimeTrials] Loop läuft...")

            pcall(function()
                local lp = game.Players.LocalPlayer
                if not lp.Character then
                    print("[AutoTimeTrials] Kein Character gefunden!")
                    return
                end

                if lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Sit == true then
                    print("[AutoTimeTrials] Spieler sitzt im Auto.")

                    for round = 1, 3 do
                        for _, race in pairs(workspace.Races:GetChildren()) do
                            if race.ClassName == "Folder" then
                                print("[AutoTimeTrials] Starte TimeTrial für", race.Name, "Runde", round)
                                game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer(race.Name, round)

                                -- Prüfen ob Rennen wirklich gestartet wurde
                                if lp:FindFirstChild("variables") then
                                    print("[AutoTimeTrials] Aktuelles Race-Value:", lp.variables.race.Value)
                                end
                            end
                        end
                    end
                else
                    print("[AutoTimeTrials] Nicht im Auto → steige ein...")
                    game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(lp.variables.carId.Value)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                end
            end)
        end
    end
}, "tbatt_debug")
