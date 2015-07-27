if not Elib then return end
Elib.Hub = {}

function Elib.Hub.Redirect(args)
	local ip = args[1]
	local port = args[2]
	if port == '' or port == ' ' or port ==  nil then port = '29070'
	SendConsoleCommand(string.format('connect %s:%s', ip, port))
end

