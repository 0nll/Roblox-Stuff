-- Place In StarterCharacterScripts --
-- Make A Folder In Workspace For Your Desired Parts To Unload --
-- Change Your Settings To Your Desire --

-- Settings --

-- Amount of studs before unload --
local RenderDistance = 50

-- Name of the world folder --
local Name = "Change Me"

--------------------------------------------- DONT TOUCH ---------------------------------------------

-- Locals --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local RenderCache = Instance.new("Folder")
RenderCache.Name = "RenderCache"
RenderCache.Parent = ReplicatedStorage
local LocalPlayer =  Players.LocalPlayer
local Character = script.Parent
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Render = Workspace:WaitForChild(Name)
local Parts = {}

-- Recursive function to get the part
local function GetPart(Object)
    if Object:IsA("BasePart") then
        return Object
    else
        for _, Obj in ipairs(Object:GetChildren()) do
            local Part = GetPart(Obj)
            if Part then
                return Part
            end
        end
    end
    return nil
end

-- Scan the initial parts
local function Scan()
    for _, Object in ipairs(Render:GetDescendants()) do
        table.insert(Parts, Object)
        Object.Parent = RenderCache
    end
end

-- Update function to move parts based on distance
local function Update()
    for _, Part in ipairs(Parts) do
        if Part.Parent == Render then
            local Distance = (Part.Position - HumanoidRootPart.Position).Magnitude
            if Distance > RenderDistance then
                Part.Parent = RenderCache
            end
        else
            local Distance = (Part.Position - HumanoidRootPart.Position).Magnitude
            if Distance <= RenderDistance then
                Part.Parent = Render
            end
        end
    end
end

-- Initial scan and bind to render step
Scan()
RunService.RenderStepped:Connect(Update)
