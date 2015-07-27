local Hub = {}
Hub.servers = {}
Elib.Hub = Hub --- Hub System

local function LoadServerList()
	local file = GetSerialiser('data/serverlist.json', FSMode.READ)
	if not file then 
		file = GetSerialiser('data/serverlist.json', FSMode.WRITE)
		local temp = {}
		local tempserver = {}
			tempserver['Name'] = 'JKNet DuelServer'
			tempserver['IP'] = '192.168.1.1'
			tempserver['PORT'] = '29071'
		temp['Duel'] = tempserver
		file:AddTable('servers', temp)
		file:Close()
	end
	local file = GetSerialiser('data/serverlist.json', FSMode.READ)
	if not file then error("^2JPLua: ^1FileSystem Failure") return end
	Hub.servers = file:ReadTable('servers')
end


local function Redirect(player, ip, port)
	player:Command(string.format('elib redirect %s:%s',ip,port))
end

local function ServerInfo(server, player, data)
	
end

function Hub.Init()
	LoadServerList()
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