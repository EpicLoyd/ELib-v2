local ConnectManager = {}
ConnectManager.bans = {}
ConnectManager.iplog = {}
ConnectManager.maintenance = {}
ConnectManager.iplog.enabled = CreateCvar('elib_iplogger', '1', CvarFlags.ARCHIVE)
ConnectManager.iplog.list = {}
Elib.ConnectManager = ConnectManager

function ConnectManager.init()
	ConnectManager.maintenance.cvar = GetCvar('elib_maintenance')
	if not ConnectManager.maintenance.cvar then
		ConnectManager.maintenance.cvar = CreateCvar('elib_maintenance', '0', CvarFlags.ARCHIVE)
	end
	ConnectManager.maintenance.message = GetCvar('elib_maintenance_message')
	if not ConnectManager.maintenance.message then
		ConnectManager.maintenance.message = CreateCvar('elib_maintenance_message', '0', CvarFlags.ARCHIVE)
	end
	Elib.hooks.add('JPLUA_EVENT_UNLOAD', 'connect_save', ConnectManager.save)
	ConnectManager.load()
end

function ConnectManager.load()
    local bans = GetSerialiser('data/bans.json', FSMode.READ)
    local iplog = GetSerialiser('data/iplog.json', FSMode.READ)
	
	ConnectManager.bans =bans:ReadTable('bans')
	ConnectManager.iplog.list = iplog:ReadTable('iplog')
	
	bans:Close()
	iplog:Close()
end

function ConnectManager.save()
	local bans = GetSerialiser('data/bans.json', FSMode.WRITE)
    local iplog = GetSerialiser('data/iplog.json', FSMode.WRITE)
	
	bans:AddTable('bans', ConnectManager.bans)
	iplog:AddTable('iplog', ConnectManager.iplog.list)
	
	iplog:Close()
	bans:Close()
end


function ConnectManager.IPLoggerCheck(name, ip)
    local name = JPUtil.StripColours(name)
	if ConnectManager.iplog.list[ip] == nil then
		local temp = {}
		temp[name] = string.format('%s',os.date('%c'))
		ConnectManager.iplog.list[ip] = temp
		return
	elseif ConnectManager.iplog.list[ip][name] ~= nil then
		ConnectManager.iplog.list[ip][name] = string.format('%s',os.date('%c'))
	else
		local players = ''
		for k,v in pairs(ConnectManager.iplog.list[ip]) do
			player = string.format('%s %s', player, k)
		end
		local text = string.format('Player %s connected... Player(s) with same ip %s\n', name, player)
		print(text)
		for k,v in pairs(GetPlayers()) do
			v:Console(text)
		end
		ConnectManager.iplog.list[ip][name] = string.format('%s',os.date('%c'))
	end
end

function ConnectManager.IPLogList()
	print(string.format('%-20s%-30s%-10s','IP','Names','Date'))
	for k,v in pairs(ConnectManager.iplog.list) do
		local ip = k
		print(string.format('%s:', ip))
		for i,j in pairs (ConnectManager.iplog.list[ip]) do
			local name = i
			local date = j
			print(string.format('%-20s%-30s%-10s','',name,date))
		end
	end
end

function ConnectManager.CheckBan(ip)
	if ConnectManager.bans[ip] == nil then return false end
	local bantime = ConnectManager.GetBanTime(ip)
	local reason = ConnectManager.bans[ip]['reason']
	if bantime == 'Permanently' then
		if not reason or reason == ' ' or reason == '' then
		 return 'You have banned from this server permanently\n'
		else
		 return 'You have banned from this server permanently\n Reason: ' .. reason ..'\n'
		end
	else
		if not reason or reason == ' ' or reason == '' then
		 return 'You have banned from this server for '.. bantime ..'\n'
		else
		 return 'You have banned from this server for '.. bantime ..'\n Reason: ' .. reason ..'\n'
		end
	end
	return false
end

function ConnectManager.CheckUUID(uuid)

end

function ConnectManager.GetBanTime(ip)
if ConnectManager.bans[ip] == nil then return "0 seconds" end
	local days, hours, mins, secs, timediff
	local diff = ConnectManager.bans[ip]['time'] - os.time() 
 
 	if diff == 0 then
		return "Permanently"
	elseif diff < 0 then
	    return "0 seconds"
	end
	days = math.floor(diff / 86400)
	diff = diff - (days * 86400)
	hours = math.floor(diff / 3600)
	diff = diff - (hours * 3600)
	mins = math.floor(diff / 60)
	diff = diff - (mins * 60)
	secs = diff
	
	if days > 0 then
		-- More than 24 hours, do only display days and hours
		local dstr, hstr
		if days == 1 then dstr = "day" else dstr = "days" end
		if hours == 1 then hstr = "hour" else hstr = "hours" end
		return string.format("%i %s and %i %s", days, dstr, hours, hstr)
	elseif hours > 0 then
		-- Less than a day but more than an hour, display hours and minutes
		local hstr, mstr
		if hours == 1 then hstr = "hour" else hstr = "hours" end
		if mins == 1 then mstr = "minute" else mstr = "minutes" end
		return string.format("%i %s and %i %s", hours, hstr, mins, mstr)
	elseif mins > 0 then
		-- Less than an hour but more than a minute, display only minutes
		if mins == 1 then
			return "1 minute"
		else
			return string.format("%i minutes", mins)
		end
	else
		-- Display seconds
		if secs == 1 then
			return "1 second"
		else
			return string.format("%i seconds", secs)
		end
	end
end


function ConnectManager.AddBan(ip, uuid, time, reason)
	local tbl = ConnectManager.bans
	local temp = {}
	time = time + os.time()
	if tbl[ip] == nil then 
		temp['ip'] = ip
		if uuid ~= '' or uuid ~= ' ' then temp['uuid'] = uuid end
		temp['time'] = time
		temp['reason'] = reason
		tbl[ip] = temp
	else
		if tbl[ip]['time'] == time and time == 0 then return ---- permanent - do nothing
		else tbl[ip]['time'] = tbl[ip]['time'] + time --- Add Some :3
		end
	end
end

function ConnectManager.ListBans()
    print('--------------------------------------')
	print('IP             Time             Reason')
	for k,v in pairs (ConnectManager.bans) do
		local ip = v['ip']
		local time = ConnectManager.GetBanTime(ip)
		local reason = v['reason']
		if not reason or reason == ' ' or reason == '' then reason = 'Not specified' end
		print(string.format("%s             %s             %s"), ip,time,reason)
	end
	print('--------------------------------------')
end


function ConnectManager.RemoveBan(ip)
if Elib.connectmgr.bans[ip] == nil then return end
Elib.connectmgr.bans[ip] = nil
end

------------------------------------------------------------
function ConnectManager.Connect(clientNum, userinfo, ip, firsttime) --- executed when player is connected
	local ip = Elib.Utils.StripPortV4(ip)
	if ip == 'bot' then return nil end
	local banstatus = ConnectManager.CheckBan(ip)
	if banstatus ~= false then
		return banstatus
	end
	if ConnectManager.iplog.enabled:GetInteger() == 1 then
		ConnectManager.IPLoggerCheck(userinfo['name'], ip)
	end
	if ConnectManager.maintenance.cvar:GetInteger() == 1 then
		if ConnectManager.maintenance.message:GetString() == '0' then
			return "^2Elib: ^1Server temporarily closed for maintenance.Try again later... "
		else
			return ConnectManager.maintenance.message:GetString()
		end
	end
    return nil
end

function ConnectManager.Disconnect(ply) --- executed when player disconnected
	ply:CleanStorage() --- Clean Internal storage
	
end

function ConnectManager.servercmds(args)
	local arg1 = args[1]
	if arg1 == 'bansystem' then
		arg2 = args[2]
		if arg2 == 'addban' then
		
		elseif arg2 == 'removeban' then
		
		elseif arg2 == 'listbans' then
			ConnectManager.ListBans()
		else
		
		end
	elseif arg1 == 'iplogger' then
		arg2 = args[2]
		if arg2 == 'list' then
			ConnectManager.IPLogList()
		elseif arg2 == 'clean' then
		
		else
		
		end
	else
		print('^2Elib ConnectManager:\n - bansystem // Bansystem\n - iplogger  // IPLogger')
	end
end


Elib.servercommands['connectmgr'] = ConnectManager.servercmds


