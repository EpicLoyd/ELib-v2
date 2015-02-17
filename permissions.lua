local Perms = {}
Elib.permissions = Perms
Elib.permissions.groups = {}
local permissionlist = {}
permissionlist['spawn'] = 'spawn'
permissionlist['spectate'] = 'spectate'
permissionlist['duel'] = 'allowduel'
permissionlist['pvp'] = 'pvp'
permissionlist['weapons'] = 'weapons'
permissionlist['models'] = 'models'
permissionlist['teams'] = 'teams'
permissionlist['adminchat'] = 'adminchat'
permissionlist['chat'] = 'globalchat'
permissionlist['force'] = 'force'
permissionlist['shop'] = 'shop'
permissionlist['shopitems'] = 'shopitems'


local function LoadData()
Elib.permissions = Elib.settings.permissions 
end

local function SaveData()
Elib.settings.permissions = Elib.permissions
end

function Perms.Init()

end

---Groups manipulation
 
function Perms.group.add(name)
  local temp = {}
  temp['name'] = name
  temp['owner'] = ''
  temp['permissions'] = {}
  temp['members'] = {}
  --TODO HIERARCHY
  temp['hierarchy'] = ''
  Elib.permissions.groups['name'] = temp
  return temp
end

function Perms.group.delete(name)
  if Elib.permissions.groups['name'] != nil then
     Elib.permissions.groups['name'] = nil
  end
end

function Perms.group.rename(name, to)
 if Elib.permissions.groups['name'] == nil then return end
end


function Perms.group.addpermission(name, permission)
 if Elib.permissions.groups['name'] == nil then return end
 Elib.permissions.groups['name']['permissions'][permission] = 1
 
end

function Perms.group.deletepermission(name, permission)
 if Elib.permissions.groups['name'] == nil then return end
 Elib.permissions.groups['name']['permissions'][permission] = 0
 
end

function Perms.CheckPermission(group, permission)
 if Elib.permissions.groups[group] == nil then return end
  if Elib.permissions.groups[group]['permissions'][permission] == nil or 0 then 
    return false
  elseif Elib.permissions.groups[group]['permissions'][permission] == 1
    return true
  end
end


