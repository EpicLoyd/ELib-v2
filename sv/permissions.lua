local Perms = {}  ---- Handles all Permission System
Perms.groups = {}
Perms.group = {}
Perms.settings = {}
local permissionlist = {}
Elib.permissions = Perms
Elib.permissions.list = permissionlist

permissionlist['spawn'] = 'spawn' -- Allow spawning
permissionlist['spectate'] = 'spectate' -- Allow spectating
permissionlist['duel'] = 'allowduel' -- Allow duels
permissionlist['pvp'] = 'pvp' -- Allow to damage other players
permissionlist['weapons'] = 'weapons' -- User weapons
permissionlist['models'] = 'models' -- Change player model
permissionlist['adminchat'] = 'adminchat' -- Use admin chat
permissionlist['chat'] = 'globalchat' -- Use global chat
permissionlist['force'] = 'force' -- Use force 

permissionlist['shop'] = 'shop' -- Can shop? -- TODO Shop
permissionlist['shopitems'] = 'shopitems' -- List of allowed items -- TODO Shop

local function FirstStart()
 Perms.group.new('default')
 Perms.group.addpermission('default', 'spawn')
 Perms.group.addpermission('default', 'spectate')
 Perms.group.addpermission('default', 'allowduel')
 Perms.group.addpermission('default', 'pvp')
 Perms.group.addpermission('default', 'models')
 Perms.group.addpermission('default', 'globalchat')
end

function Perms.save()
    local file = GetSerialiser('data/permissions.json', FSMode.WRITE)
	if file then
		file:AddTable('groups', Elib.permissions.groups)
		file:Close()
	end
end

function Perms.load()
    local file = GetSerialiser('data/permissions.json', FSMode.READ)
	if not file then Perms.save() return end
	Elib.permissions.groups = file:ReadTable('groups')
	file:Close()
end

function Perms.init()
  Perms.load()
end

function Perms.reload()
  Elib.permissions.groups = {}
  Elib.permissions.settings = {}
  LoadData()
end

---Groups manipulation
 
function Perms.group.new(name)
  local temp = {}
  temp['name'] = name
  temp['permissions'] = {}
  temp['members'] = {}
  --TODO HIERARCHY
  temp['hierarchy'] = '' ---hierarch from another permission group ( group 'Vip' will include permissions of default group)
  Elib.permissions.groups[name] = temp
  return temp
end

function Perms.group.exist(name)
 if name == ' ' or '' then return false end
   if Elib.permissions.groups[name] ~= nil then
     return true
   else
     return false
   end
end

function Perms.group.delete(name)
  if Elib.permissions.groups[name] ~= nil then
     Elib.permissions.groups[name] = nil
  end
end

function Perms.group.rename(name, to)
 if Elib.permissions.groups[name] == nil then return end
end


function Perms.group.addpermission(name, permission)
 if Elib.permissions.groups[name] == nil then return end
 if permissionlist[permission] == nil then return end
 Elib.permissions.groups[name]['permissions'][permission] = 1
end

function Perms.group.deletepermission(name, permission)
 if Elib.permissions.groups[name] == nil then return end
 if permissionlist[permission] == nil then return end
 Elib.permissions.groups[name]['permissions'][permission] = 0
 
end

function Perms.group.addmember(group, name)
if Elib.permissions.groups[group] == nil then return end
table.insert(Elib.permissions.groups[group]['members'],name)
end

function Perms.group.removemember(group, name)
if Elib.permissions.groups[group] == nil then return end
for k,v in pairs (Elib.permissions.groups[group]['members']) do
 if v == name then
   Elib.permissions.groups[group]['members'][k] = nil
   return
 end
end
end

function Perms.CheckPermission(group, permission)
 if Elib.permissions.groups[group] == nil then return end
  if Elib.permissions.groups[group]['permissions'][permission] == nil or 0 then 
    return false
  elseif Elib.permissions.groups[group]['permissions'][permission] == 1 then
    return true
  end
end

function Perms.servercmds(args)
 local arg = args[1]
  if arg == 'group' then
    arg2 = args[2]
	if arg2 == 'add' then
	    arg3 = args[3]
		if arg3 == 'member' then
		  group = args[4]
		  name = args[5]
		  Perms.group.addmember(group, name)
		elseif arg3 == 'permission' then
		  group = args[4]
		  perm = args[5]
		  Perms.group.addpermission(group, perm)
	    else
		  name = args[3]
		  Perms.group.new(name)
		  print('^2Elib Permissions: ^7Group "' .. name  .. '" Successfully created!')
		end
	elseif arg2 == 'delete' or arg2 == 'remove' or arg2 == 'purge' then
	    arg3 = args[3]
		if arg3 == 'group' then
		  name = args[4]
		  Perms.group.delete(name)
		elseif arg3 == 'member' then
		  group = args[4]
		  name = args[5]
		  Perms.group.removemember(group, name)
		elseif arg3 == 'permission' then
		  group = args[4]
		  perm = args[5]
		  Perms.group.deletepermission(group, perm)
	    else
		  print("^2Elib Permissions: ^1Wrong syntax")
		end
	else
	    print("^2Elib Permissions: ^1Wrong syntax")
    end
  elseif arg == 'reload' then
    Perms.reload()
  elseif arg == 'smth' then
  
  else
     print("^2Elib Permissions System:\n - group [h for help] // Group manager\n - reload // Reloads permissions system")
  end
end

Elib.servercommands['permissions'] = Perms.servercmds
Elib.hooks.add('JPLUA_EVENT_UNLOAD', 'permissions_save', Perms.save)