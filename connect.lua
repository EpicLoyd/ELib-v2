local ConnectManager = {}
ConnectManager.bans = {}
ConnectManager.iplog = {}
Elib.connectmgr = ConnectManager
----------------------BanSystem-----------------------------
local function LoadData()
    local bans = GetSerialiser('data/bans.json', FSMode.READ)
    local iplog = GetSerialiser('data/permissions.json', FSMode.READ)
	
	
	iplog:Close()
	bans:Close()
end

local function SaveData()
    local bans = GetSerialiser('data/bans.json', FSMode.WRITE)
    local iplog = GetSerialiser('data/permissions.json', FSMode.WRITE)
	
	
	iplog:Close()
	bans:Close()
end

function ConnectManager.IPLoggerCheck(name, ip)
 if ConnectManager.iplog[ip] == nil then
	local temp = {}
	temp[name] = string.format('Date: %s (%s:%s)',os.date('%x'),os.time['hour'], os.time['min'])
	ConnectManager.iplog[ip] = temp
	return
 elseif ConnectManager.iplog[ip][name] ~= nil then
    return
 else
	local players = ''
	for k,v in pairs(ConnectManager.iplog[ip]) do
		player = string.format('%s %s', player, k)
	end
	local text = string.format('Player %s connected... Player(s) with same ip %s\n')
	print(text)
	for k,v in pairs(GetPlayers()) do
	v:Console(text)
	end
 end
end

function ConnectManager.CheckBan(ip)
	if Elib.connectmgr.bans[ip] == nil then return false end
	local bantime = ConnectManager.GetBanTime(ip)
	local reason = Elib.connectmgr.bans[ip]['reason']
	if bantime == 'Permanently' then
		if not reason or reason == ' ' or reason == '' then
		 return 'You have banned from this server permanently\n'
		else
		 return 'You have banned from this server permanently\n Reason: %s\n'
		end
	else
		if not reason or reason == ' ' or reason == '' then
		 return 'You have banned from this server for %s\n'
		else
		 return 'You have banned from this server for %s\n Reason: %s\n'
		end
	end
end

function ConnectManager.CheckUUID(uuid)

end

function ConnectManager.GetBanTime(ip)
if Elib.connectmgr.bans[ip] == nil then return "0 seconds" end
local days, hours, mins, secs, timediff
local diff = Elib.connectmgr.bans[ip]['time'] - os.time() 
 
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
   local tbl = Elib.connectmgr.bans
   local temp = {}
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


function ConnectManager.RemoveBan(ip)
if Elib.connectmgr.bans[ip] == nil then return end
Elib.connectmgr.bans[ip] = nil
end

------------------------------------------------------------
local function Connect(ply) --- executed when player is connected

end

local function Disconnect(ply) --- executed when player disconnected

end