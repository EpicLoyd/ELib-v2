Elib.players = {} --- Handles all player functions
local plytab = GetPlayerTable() -- get player metatable

---------Accounts 

function plytable:CreateStorage(ply)
 local temp = {}
 local name = JPUtil.StripColours(ply:GetName())
 temp['name'] = name --- Init some data
 temp['group'] = 'default'
 temp['account'] = ''
 temp['begintime'] = GetTime()
 
Elib.players[name] = temp
end
function plytable:IsLogged(ply)
   if ply == nil then return end
   if Elib.players[name]['account'] ~= nil 
      return true
   else
      return false
   end
end

function plytable:SetAccount(ply, account)
  if ply or account == nil then return end 
  local name = JPUtil.StripColours(ply:GetName())
  Elib.players[name]['account'] = account
end

function plytable:GetAccount(ply)
  if ply == nil then return end
    local name = JPUtil.StripColours(ply:GetName())
   if Elib.players[name]['account'] ~= nil 
      return Elib.players[name]['account']
   end
  return nil
end


--------- 


function plytable:Chat(ply)

end

function plytable:Center(ply)

end

function plytable:Console(ply)

end

function plytable:Command(ply)

end

--------  Permissions

function plytable:GetGroup(ply)

end

function plytable:SetGroup(ply)

end

