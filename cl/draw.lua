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

function Draw.AddDrawText(x,y, text, color, style, font) --elib draw text X Y TEXT BITCOLOR(TEXT?) STYLE FONT(TEXT?)

end

function Draw.AddDrawPic(x,y,w,h, color, handle)

end

function Draw.AddDrawRect(x,y,w,h color)

end

function Draw.servercmds(args)
	local arg = args[1]
	if arg == 'text' then
		local from = args[2]
		local to = args[3]
		Draw.AddDrawText
	elseif arg == 'pic' then
		local from = args[2]
		local to = args[3]
		Draw.AddDrawPic
	elseif arg == 'rect' then
		Draw.AddDrawRect
	elseif arg == 'reload' then
		
	else
		print(string.format("^2Elib Database System:\nCurrent: %s", db.current))
	end
end

Elib.servercommands['draw'] = Draw.servercmds