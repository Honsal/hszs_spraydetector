if SERVER then
	AddCSLuaFile("spraydetector/cl_init.lua")
	include("spraydetector/init.lua")
end

if CLIENT then
	include("spraydetector/cl_init.lua")
end