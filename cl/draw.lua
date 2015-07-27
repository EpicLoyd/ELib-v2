if not Elib then return end
local Draw = {}
Draw.drawlist = {}
Elib.Draw = Draw
local function FadeColor(color,startt, stopt)

end

local function DrawLoop()
	
end

local function Draw.Reload()
	Draw.drawlist = {}
end

function Draw.AddDrawText(x,y, text, color, scale, style, font, fadetime, fadespeed,customfont) --elib draw text X Y TEXT BITCOLOR(TEXT?) STYLE FONT(TEXT?) [FADETIME] [CUSTOMFONT]
	local temp = {}
	temp['x'] = x or 0
	temp['y'] = y or 0
	temp['text'] = text or ''
	temp['color'] = {1,1,1,1} -- for now
	temp['scale'] = scale or 0
	temp['style'] = style or 0
	temp['font'] = font or 0
	temp['fadetime'] = fadetime or 0
		if (fadetime ~= 0) and (fadetime ~= nil) then
			temp['fadetime'] = fadetime 
			temp['fadestart'] = GetRealTime() 
		end
	temp['custom_font'] = customfont or false
	
	local func = function( currentime)
					local alpha = temp['color'][4] -- fade
					if (temp['fadetime'] ~= 0) then
						local cur = GetRealTime() - temp['fadestart']
						if cur >= temp['fadestart'] + temp['fadetime'] then return end
						temp['color'][4] = cur / temp['fadetime']
					end
					DrawText(temp['x'], temp['y'], temp['text'], temp['color'], temp['scale'], temp['style'], temp['font'])
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
		pcall(Draw.AddDrawText, unpack(args))
	elseif arg == 'pic' then
		pcall(Draw.Draw.AddDrawPic, unpack(args))
	elseif arg == 'rect' then
		pcall(Draw.Draw.AddDrawRect, unpack(args))
	elseif arg == 'reload' then
		pcall(Draw.Reload)
	else
		print(string.format("^2Elib Draw System: ^1Unknown Command: %s", arg))
	end
end

Elib.servercommands['draw'] = Draw.servercmds
