if not Elib then return end
local Draw = {}
Draw.drawlist = {}
Elib.Draw = Draw
local function FadeColor(color,startt, stopt)

end

local function DrawLoop()
	for _,v in pairs(Draw.drawlist) do
		local ok, ret = pcall(v['func'])
		if not ok then print("^2Elib Draw System: ^1Failed To Draw: " .. tostring(ret)) end
	end
end

AddListener('JPLUA_EVENT_RUNFRAME', DrawLoop)

function Draw.Reload()
	Draw.drawlist = {}
end

function Draw.AddDrawText(x,y, text, color, scale, style, font, timetodraw, fadetime, customfont) --elib draw text X Y TEXT BITCOLOR(TEXT?) STYLE FONT(TEXT?) [FADETIME] [CUSTOMFONT]
	local temp = {}
	temp['id'] = #Draw.drawlist + 1
	temp['x'] = x or 0
	temp['y'] = y or 0
	temp['text'] = text or ''
	temp['color'] = {0.55,0.55,0.55,0.55} -- for now
	temp['scale'] = scale or 0
	temp['style'] = style or 0
	temp['font'] = font or 0
	temp['timetodraw'] = timetodraw or 1
	temp['startdraw'] = GetRealTime()
	temp['fadetime'] = fadetime or 0
		if (fadetime ~= 0) and (fadetime ~= nil) then
			temp['fadetime'] = fadetime 
			temp['fadestart'] = GetRealTime() 
		end
	temp['custom_font'] = customfont or false
	
	local func = function( currentime)
					if temp['timetodraw'] + temp['startdraw'] > GetRealTime() then -- draw!
						DrawText(temp['x'], temp['y'], temp['text'], temp['color'], temp['scale'], temp['style'], temp['font'])
					end
					if (temp['fadetime'] ~= 0) and temp['timetodraw'] + temp['startdraw'] <= GetRealTime() then
						if temp['fadestart'] == 0 then temp['fadestart'] = GetRealTime()  end -- start fading
						local cur = GetRealTime() - temp['fadestart']
						if cur >= temp['fadestart'] + temp['fadetime'] then return end
						temp['color'][4] = cur / temp['fadetime']
						if temp['color'][4] <= 0 then
							Draw.drawlist[temp['id']] = nil -- fade finished
							return
						end
						DrawText(temp['x'], temp['y'], temp['text'], temp['color'], temp['scale'], temp['style'], temp['font'])
					end
				 end
	temp['func'] = func
	Draw.drawlist[#Draw.drawlist + 1] = temp
end

function Draw.AddDrawPic(x, y, w, h, color, handle, degree, fadetime) --elib draw pic X Y W H BITCOLOR(TEXT?) PATH_TO_SHADER [DEGREE] [FADETIME]

end

function Draw.AddDrawRect(x, y, w, h, color, fadetime) -- elib draw rect X Y W H BITCOLOR(TEXT?) [FADETIME]

end

function Draw.servercmds(args)
	local arg = args[1]
	table.remove(args, 1)
	if arg == 'text' then
		print('DRAWTEXT')
		local ok,ret = pcall(Draw.AddDrawText, table.unpack(args))
		print(ok,ret)
	elseif arg == 'pic' then
		pcall(Draw.Draw.AddDrawPic, table.unpack(args))
	elseif arg == 'rect' then
		pcall(Draw.Draw.AddDrawRect, table.unpack(args))
	elseif arg == 'reload' then
		pcall(Draw.Reload)
	else
		print(string.format("^2Elib Draw System: ^1Unknown Command: %s", arg))
	end
end

Elib.servercommands['draw'] = Draw.servercmds
