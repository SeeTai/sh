if game.PlaceId ~= 2202352383 then return end

game.Loaded:Wait()
while not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do
    task.wait()
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/theplayer8000/Client-X/main/antilag.lua"))()

local FsMain = {"Losersexa", ""}
local PpMain = {""}

local player = game:GetService("Players").LocalPlayer

local TrainFist = table.find(FsMain, player.Name) and true or false
local TrainPsychic = table.find(PpMain, player.Name) and true or false

local function createTrainingPlatform()
    local NewPart = Instance.new("Part")
    NewPart.Position = Vector3.new(-272, 277.5, 1004)
    NewPart.Anchored = true
    NewPart.Size = Vector3.new(100, 1.5, 100)
    NewPart.Color = Color3.fromRGB(109, 232, 246)
    NewPart.Parent = game.Workspace
end

task.spawn(createTrainingPlatform)
task.wait(2)
game.ReplicatedStorage.RemoteEvent:FireServer({"Respawn"})
task.wait(3)

local function train()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(-266, 281, 1001) * CFrame.Angles(0, math.rad(269), 0)
    task.wait(1)
    player.Character.UpperTorso.Waist:Destroy()
    task.wait(1)

    local targetPosition = TrainFist and CFrame.new(-369, 15735, -9) or CFrame.new(-2544, 5412, -495)
    player.Character.HumanoidRootPart.CFrame = targetPosition * CFrame.Angles(0, math.rad(269), 0)
    task.wait(1)

    game:GetService("RunService").Heartbeat:Connect(function()
        player.Character.HumanoidRootPart.CFrame = targetPosition * CFrame.Angles(0, math.rad(269), 0)
        game.ReplicatedStorage.RemoteEvent:FireServer({TrainFist and "+FS6" or "+PP6"})
    end)
end

task.spawn(train)

task.spawn(function()
    while task.wait() do
        pcall(function()
            local vuser = game:GetService("VirtualUser")
            vuser:CaptureController()
            vuser:ClickButton1(Vector2.new(989, 133))
        end)
    end
end)

task.spawn(function()
    task.wait(3)
    local speaker = player
    local workspace = game:GetService("Workspace")

    workspace.CurrentCamera:Destroy()
    task.wait(0.1)
    repeat task.wait() until speaker.Character
    
    local cam = workspace.CurrentCamera
    cam.CameraSubject = speaker.Character:FindFirstChildWhichIsA("Humanoid")
    cam.CameraType = "Custom"
    speaker.CameraMinZoomDistance = 0.5
    speaker.CameraMaxZoomDistance = 400
    speaker.CameraMode = "Classic"
    speaker.Character.Head.Anchored = false
end)

task.delay(15, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SeeTai/sh/refs/heads/main/sh.lua"))()
    
    while task.wait() do
        if not (player.Character:FindFirstChild("ForceField") or player.Character:FindFirstChild("GodModeShield")) then
            print("no ff, server hopping")
            task.wait()
            Teleport()
            task.wait(1.5)
        else
            print("player has ff")
        end
    end
end)
