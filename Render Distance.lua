-- Place In StarterCharecterScripts --
-- Make A Folder In Workspace For Your Desired Parts To Unload --
-- Change Your Settings To Your Desire --

-- Settings --


-- Ammount of studs before unload --
local RenderDistance = 50

-- Name of the world folder --

local Name = "Change Me"




--------------------------------------------- DONT TOUCH ---------------------------------------------

-- locals --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspacee = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local RenderCache = Instance.new("Folder")
RenderCache.Name = "RenderCache"
RenderCache.Parent = ReplicatedStorage
local LocalPlayer =  Players.LocalPlayer
local Charecter = script.Parent
local HumanoidRootPart = Charecter:WaitForChild("HumanoidRootPart")
local Render = Workspacee:WaitForChild(Name)
local Parts = {}

function Scan()
	for _, Object in next, Render:GetChildren() do
		table.insert(Parts, Object)
		Object.Parent = RenderCache
	end
end

function GetPart (Object)
	if(Object:IsA("BasePart"))then
		return Object
	else 
		for _, Obj in next, Object:GetChildren() do
			return GetPart(Obj)
		end
	end
	return nil
end


function Update()
	for _, v in next, Parts do
		local Part = GetPart(v)
		if (Part) then
			local Distance = (Part.CFrame.p - HumanoidRootPart.CFrame.p).Magnitude
			Distance = math.floor(Distance + 0.5)
			if (Distance <= RenderDistance) then 
				v.Parent = Render
			else
				v.Parent = RenderCache
			end
		end
	end
end
Scan()
RunService:BindToRenderStep("RenderSys", 1, Update)
