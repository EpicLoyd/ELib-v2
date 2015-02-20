local Utils = {}
Elib.utils  = {}

-- Splits up the IP in 4 individual numbers
function Utils.SplitIP(ip)
	local d1, d2, d3, d4
	_,_,d1,d2,d3,d4 = string.find(Utils.StripPort(ip),"(%d+)%.(%d+)%.(%d+)%.(%d+)")
	return tonumber(d1),tonumber(d2),tonumber(d3),tonumber(d4)
end

function Utils.randstr(l)
        if l < 1 then return nil end -- Check for l < 1
        local s = "" -- Start string
        for i = 1, l do
            n = math.random(32, 126) -- Generate random number from 32 to 126
            if n == 96 then n = math.random(32, 95) end
              if string.char(n) == "'" or '"' then 
                s = s .. string.char(n) -- turn it into character and add to string
              end
        end
        return s -- Return string
end

function Utils.StripPort(ip)
	if not string.find(ip,":") then return ip end
	return string.sub(ip, 1, string.find(ip,":") - 1)
end

function Utils.implode(div, table)
 local s = ''
  for k,v in pairs(table) do
    if s:len() == 0 then
      print('len' .. s:len())
      s = s .. v
    else
      print('passlen' .. s:len())
      s = s .. div .. v
    end
  end
  return s
end


function Utils.GenInt(len, max)
  local id 
  local s = ''
   if not max or max == '' then max = 9 end
 for i = 1, len do
     
    local n = tostring(math.random(1, max))
        if n < len then
        s = s .. n
        end
 end
  s = tonumber(s)
   return s
end

function Utils.FindItTable(table, value)
   for k,v in pairs(table) do
    if v == value then return true end
   end
end 

