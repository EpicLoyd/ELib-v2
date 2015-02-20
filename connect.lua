Elib.connectmgr = {}
Elib.connectmgr.bans = {}

----------------------BanSystem-----------------------------
local function LoadData()

end

local function SaveData()

end

function Elib.connectmgr.CheckBan(ip, uuid)
 

end

function Elib.connectmgr.GetBanTime(ip, uuid)
if Elib.connectmgr.bans[ip] == nil then return false end
local days, hours, mins, secs, timediff
 local diff = Elib.connectmgr.bans[ip]['time'] - os.time() 
 
 	if diff <= 0 then
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
 
 
 

   return time
end


function Elib.connectmgr.AddBan(ip, uuid, time, reason)
   local tbl = Elib.connectmgr.bans
   local temp = {}
   if tbl[ip] == nil then 
    temp['ip'] = ip
	if uuid ~= nil then temp['uuid'] = uuid
	temp['time'] = time
	temp['reason'] = reason
	tlb[ip] = temp
   else
    if tbl[ip]['time'] == time and time == 0 then return ---- permanent - do nothing
	else tbl[ip]['time'] = tbl[ip]['time'] + time --- Add Some :3
	end
   end
end


function Elib.connectmgr.RemoveBan(ip, uuid)


end

------------------------------------------------------------
local function Connect(ply) --- executed when player is connected

end

local function Disconnect(ply) --- executed when player disconnected

end