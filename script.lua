-- [[ Gerger Hub | Main Source Code ]] --
local UI = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 160, 0, 35)
Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active, Main.Draggable = true, true

local Toggle = Instance.new("TextButton", Main)
Toggle.Size = UDim2.new(1, -10, 1, -10)
Toggle.Position = UDim2.new(0, 5, 0, 5)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Toggle.Text = "🔧 Auto Mechanic: OFF"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.GothamBold

_G.AutoMechanic = false
Toggle.MouseButton1Click:Connect(function()
    _G.AutoMechanic = not _G.AutoMechanic
    if _G.AutoMechanic then
        Toggle.Text = "🟢 Auto Mechanic: ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    else
        Toggle.Text = "🔧 Auto Mechanic: OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoMechanic then
            pcall(function()
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                for _, v in pairs(workspace.Vehicles:GetChildren()) do
                    if not _G.AutoMechanic then break end
                    local hp = v:FindFirstChild("Health") or v:FindFirstChild("EngineHealth")
                    if hp and hp.Value < 100 and v:FindFirstChildOfClass("VehicleSeat") then
                        hrp.CFrame = v:FindFirstChildOfClass("VehicleSeat").CFrame + Vector3.new(0, 5, 0)
                        task.wait(0.2)
                        local r = game.ReplicatedStorage:FindFirstChild("RepairEvent")
                        if r then r:FireServer(v) end
                    end
                end
            end)
        end
    end
end)
