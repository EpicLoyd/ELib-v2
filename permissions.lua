local Perms = {}  ---- Handles all Permission System
Elib.permissions = Perms
Elib.permissions.groups = {}
Elib.permissions.settings = {}
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

local function SaveData()
  Elib.settings.permissions = Elib.permissions
  local file = GetSerialiser('data/permissions.json', FSMode.WRITE)
   if file == nil then
     error("^1Failed to open settings file. Shutdowning...")
   end
     file:AddTable("groups", Elib.permissions.groups)
	 file:Close()
end

local function LoadData()
    Elib.permissions.settings = Elib.settings.permissions  
    local file = GetSerialiser('data/permissions.json', FSMode.READ)
	 if file == nil then  ----Create new one
	   SaveSettings()
	 end
	 file = GetSerialiser('data/permissions.json', FSMode.READ)
	   file:ReadTable("group", Elib.permissions.groups)
	 file:Close()
end

function Perms.Init()

end

function Perms.Reload()
  SaveData()
    Elib.permissions.groups = {}
    Elib.permissions.settings = {}
  LoadData()
end

---Groups manipulation
 
function Perms.group.add(name)
  local temp = {}
  temp['name'] = name
  temp['owner'] = ''
  temp['permissions'] = {}
  temp['members'] = {}
  --TODO HIERARCHY
  temp['hierarchy'] = '' ---hierarch from another permission group ( group 'Vip' will include permissions of default group)
  Elib.permissions.groups['name'] = temp
  return temp
end

function Perms.group.exist(name)
 if name == ' ' or '' then return false
   if Elib.permissions.groups['name'] != nil then
     return false
   else
     return true
   end
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



