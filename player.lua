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
   if ply == nil then return end
    SendReliableCommand(ply:GetID(), string.format('chat "%s"', msg))
end

function plytable:Center(ply)
   if ply == nil then return end
    SendReliableCommand(ply:GetID(), string.format('cp "%s"', msg))
end

function plytable:Console(ply)
   if ply == nil then return end
    SendReliableCommand(ply:GetID(), string.format('print "%s"', msg))
end

function plytable:Command(ply)
   if ply == nil then return end
    SendReliableCommand(ply:GetID(), string.format('%s', cmd))
end

--------  Permissions

function plytable:GetGroup(ply)
   if ply == nil then return end
   local acc = ply:GetAccount()
   if acc.group and acc.group ~= '' or  ' ' then
     return acc.group
   else
     return nil
   end
end

function plytable:SetGroup(ply, group)
   if ply == nil then return end
   if not Perms.group.exist(group) then return end
   local acc = ply:GetAccount()
   if not acc then
    Elib.players[JPUtil.StripColours(ply:GetName())]['group'] = group
   else
    acc.group = group
   end
   
end

