local Window = _G.Window

local srsst = Window:CreateTab("Spawner", 4483362458)

local srsstsicsb = srsst:CreateButton({

   Name = "Silly Icecream",

   Callback = function()

      local args = {"Silly Icecream", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsstsssb = srsst:CreateButton({

   Name = "Summer Sheep",

   Callback = function()

      local args = {"Summer Sheep", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsstsebfsb = srsst:CreateButton({

   Name = "Earth ButterFly",

   Callback = function()

      local args = {"Earth ButterFly", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsstspdsb = srsst:CreateButton({

   Name = "Past Dominus",

   Callback = function()

      local args = {"Past Dominus", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsstspidsb = srsst:CreateButton({

   Name = "Pink Dragon",

   Callback = function()

      local args = {"Pink Dragon", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsstsmmsb = srsst:CreateButton({

   Name = "Mimic",

   Callback = function()

      local args = {"Mimic", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsstsajsb = srsst:CreateButton({

   Name = "Air Jinn",

   Callback = function()

      local args = {"Air Jinn", false}

      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CanBuyEgg"):InvokeServer(unpack(args))

   end,

})

local srsft = Window:CreateTab("Farm", 4483362458)

local AutoRebirth = false

local srsftarbt = srsft:CreateToggle({

   Name = "Auto Rebirth",

   CurrentValue = false,

   Flag = "srsftarbt",

   Callback = function(Value)

      AutoRebirth = Value

      if AutoRebirth then

         task.spawn(function()

            while AutoRebirth do

               task.wait(0.5)

               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):FireServer()

            end

         end)

      end

   end,

})

local AutoClicker = false

local srsftact = srsft:CreateToggle({

   Name = "Auto Clicker",

   CurrentValue = false,

   Flag = "AutoClickerToggle",

   Callback = function(Value)

      AutoClicker = Value

      if AutoClicker then

         task.spawn(function()

            while AutoClicker do

               task.wait(0.1)

               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AddSpeed"):FireServer()

            end

         end)

      end

   end,

})

local OrbRingFarm = false

local srsftoarft = srsft:CreateToggle({

   Name = "Orb and Ring Farm",

   CurrentValue = false,

   Flag = "OrbRingFarmToggle",

   Callback = function(Value)

      OrbRingFarm = Value

      if OrbRingFarm then

         task.spawn(function()

            while OrbRingFarm do

               task.wait(0.2)

               local char = game.Players.LocalPlayer.Character

               if char and char:FindFirstChild("HumanoidRootPart") then

                  local hrp = char.HumanoidRootPart

                  for _, orb in pairs(workspace:GetChildren()) do

                     if orb.Name == "Orb" and orb:IsA("BasePart") then

                        firetouchinterest(hrp, orb, 0)

                        firetouchinterest(hrp, orb, 1)

                     end

                  end

                  for _, ring in pairs(workspace:GetChildren()) do

                     if ring.Name == "Ring" and ring:IsA("BasePart") then

                        firetouchinterest(hrp, ring, 0)

                        firetouchinterest(hrp, ring, 1)

                     end

                  end

               end

            end

         end)

      end

   end,

})
