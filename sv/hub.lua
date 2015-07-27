local Hub = {}
Hub.servers = {}
Elib.hub = {} --- Hub System


local function Redirect(player, ip, port)
	player:Command(string.format('elib redirect %s:%s',ip,port))
end

local function ServerInfo(server, player, data)
	
end

function Hub.Init()

end

function Hub.AddServer(name, ip)


end

function Hub.DeleteServer(name, ip)


end

function Hub.Redirect(player, server)
	local ip = server['ip']
	local port = server['port']
	local data = {}
	
	
	Redirect(player, ip, port,data)
    print('^2Elib: ^7Redirecting player ' .. player.name ..'^7 to ' .. server['name'] .. ' ')
end

function Hub.Status()


end