HSSprayDetector = {}
Msg("##############################\n")
Msg("## Loading Spray Detector   ##\n")
-- Msg("## shared.lua               ##\n")
Msg("##############################\n")

util.AddNetworkString("hssd_list")

HSSprayDetector.List = {}
function HSSprayDetector.Sprayed(pl)
	if !IsValid(pl) then
		return false
	end
	local trace = pl:GetEyeTrace()
	local ang = trace.HitNormal:Angle()
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 90)
	HSSprayDetector.List[pl:SteamID()] = {pl:Nick() or "UNKNOWN", trace.HitPos, ang}
	net.Start("hssd_list")
		net.WriteTable(HSSprayDetector.List)
	net.Broadcast()
	return false
end
hook.Add("PlayerSpray", "HSSprayDetector.Sprayed", HSSprayDetector.Sprayed)