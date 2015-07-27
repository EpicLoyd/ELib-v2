if not Elib then return end
local Hub = {}
Elib.Hub = Hub

function Hub.Redirect(ip, port)
	if (port == '') or (port == ' ') or (port ==  nil) then port = '29070' end
	SendConsoleCommand(string.format('connect %s:%s', ip, port))
end


function Hub.servercmds(args)
	local arg = args[1]
	table.remove(args, 1)
	if arg == 'redirect' then
		pcall(Hub.Redirect, unpack(args))
	elseif arg == '' then
		print('blank space')
	else
		print(string.format("^2Elib Hub System: ^1Unknown Command: %s", arg))
	end
end

Elib.servercommands['hub'] = Hub.servercmds

