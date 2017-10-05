HSSprayDetector = {}
Msg("##############################\n")
Msg("## Loading Spray Detector   ##\n")
-- Msg("## shared.lua               ##\n")
Msg("##############################\n")

HSSprayDetector.List = {}
function HSSprayDetector.ReceiveList(len)
	local tbl = net.ReadTable()
	if !tbl or !istable(tbl) then
		return
	end
	
	if (istable(HSSprayDetector.List)) then
		for i = #HSSprayDetector.List, 1, -1 do
			table.remove(HSSprayDetector.List, i)
		end
	end
	
	HSSprayDetector.List = table.Copy(tbl)
	
	for i = #tbl, 1, -1 do
		table.remove(tbl, i)
	end
end
net.Receive("hssd_list", HSSprayDetector.ReceiveList)

local colSpray = Color(0, 255, 0, 220)
function HSSprayDetector.DrawInfo(depth, skybox)
	if !istable(HSSprayDetector.List) then
		return
	end
	if table.Count(HSSprayDetector.List) <= 0 then
		return
	end
	for i, v in pairs(HSSprayDetector.List) do
		local sid, nick, pos, ang = i, v[1], v[2], v[3]
		
		if !(sid or nick or pos or ang) then
			continue
		end
		
		local dist = math.sqrt((pos -LocalPlayer():EyePos()):LengthSqr())
		if dist > 300 then
			continue
		end
		-- cam.IgnoreZ(true)
		cam.Start3D2D(pos, ang, 0.1)
			colSpray.a = math.Clamp(220 * (1 - dist / 300), 0, 220)
			draw.SimpleText("닉네임: " .. nick, "ChatFont", 0, 180, colSpray, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("SID: " .. sid, "ChatFont", 0, 210, colSpray, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		-- cam.IgnoreZ(false)
	end
end
hook.Add("PostDrawTranslucentRenderables", "HSSprayDetector.DrawInfo", HSSprayDetector.DrawInfo)