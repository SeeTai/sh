local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")
local terrain = workspace:FindFirstChildOfClass("Terrain")


if terrain then
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 0
end


lighting.GlobalShadows = false
lighting.FogEnd = 1e9
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01


for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    elseif v:IsA("Decal") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastRadius = 1
    end
end


for _, v in ipairs(lighting:GetDescendants()) do
    if v:IsA("PostEffect") then
        v.Enabled = false
    end
end


workspace.DescendantAdded:Connect(function(child)
    if child.ClassName == "ForceField" then
        runService.Heartbeat:Wait()
        print("Dont destroy")
    elseif child.ClassName == "Sparkles" or child.ClassName == "Smoke" or child.ClassName == "Fire" then
        runService.Heartbeat:Wait()
        child:Destroy()
    end
end)
