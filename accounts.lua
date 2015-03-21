Elib.accounts = {} --- Handles all Account System
Elib.accounts.__index = Elib.accounts
Elib.accounts.list = {}
Accounts = Elib.accounts

---------------------Meta functions

function Elib.accounts.new(login)
  local self = setmetatable({}, Elib.accounts)
  self.login = login
  self.password = ''
  self.hash = '' ----IPB Integration
  self.salt = '' ----IPB Integration
  self.admin = false
  --self.statistics = setmetatable({}, table) ---- Statistics
  self.money = 0
  self.banned = false
  --self.inventory = {} --Shop/Inventory
  self.clan = 'extrajka'      -- Clan System
  self.group = 'default' -- Permissions System
  self.player = nil
  self.loginmsg = ''
  Elib.accounts.list[login] = self
  return self
end

function Elib.accounts.tostring(acc)
  return("Account ( " .. acc.login .. " )")
end

function Elib.accounts.equal(acc1, acc2)
  if acc1 and acc2 and acc1.login == acc2.login then
    return true
  else
    return false
  end
end

Elib.accounts.__tostring = Elib.accounts.tostring
Elib.accounts.__equal = Elib.accounts.equal  

function Accounts.load()
 local temp = {}
 local main = {}
 local file = GetSerialiser('data/accounts.json', FSMode.READ)
 main = file:ReadTable('accounts')
  for k,v in pairs(main) do
    local acc = Elib.accounts.new(k)
	acc.password = v['password']
	acc.admin = v['admin']
	acc.money = v['money']
	acc.banned = v['banned']
	acc.group = v['group']
	acc.loginmsg = v['loginmsg']
	acc.clan = v['clan']
  end
  file:Close()
end

function Accounts.save()
 local temp = {}
 local main = {}
 local file = GetSerialiser('data/accounts.json', FSMode.WRITE)
  for k,v in pairs(Elib.accounts.list) do
    temp['login'] = v.login
	temp['password'] = v.password
	temp['admin'] = v.admin
	temp['money'] = v.money
	temp['banned'] = v.banned
	temp['group'] = v.group
	temp['loginmsg'] = v.loginmsg
	temp['clan'] = v.clan
	  main[v.login] = temp
  end
  file:AddTable('accounts', main)
  file:Close()
end

function Elib.accounts.exist(login)
  if Elib.accounts.list[login] ~= nil then
    return true
  else
    return false
  end
end

function Elib.accounts.get(login)
 if Elib.accounts.list[login] ~= nil then
    return Elib.accounts.list[login]
 else
    return nil
 end
end

function Elib.accounts.login()
  if self == nil then return nil end
  return self.login
end

function Elib.accounts.password()
  if self == nil then return nil end
end

function Elib.accounts:Changepass(newpass)
  if self == nil then return nil end

end

function Elib.accounts:Rename(newname)
  if self == nil then return nil end
end

---------

local function Login(login, pass)
if Elib.accounts.list[login] == nil then return false end
   local acc = Elib.accounts.list[login]
   if not acc then return end
   if acc.password == pass then
     return true
   else
     return false
   end
end

local function Register(login, pass)


end

----- Permissons

function Elib.accounts:CheckPermission(permission)
  if self == nil then return nil end
  if self.group == '' or ' ' then return false end
 if  Perms.CheckPermission(self.group, permission) then
     return true
 else
     return false
 end
end

function Elib.accounts:GetGroup()
  if self == nil then return nil end
  if self.group == '' or ' ' then return nil end
  return self.group
end

function Elib.accounts:SetGroup(group)
  if self == nil then return nil end
  self.group = group
end


---------------------Bind cmds to global commands system

local function NewAccount(login, pass, loginmsg)
 local acc = Elib.accounts.new(login)
 acc.password = pass
 acc.loginmsg = loginmsg
end

local function DeleteAccount(ply, login)

end

local function ResetAccount(ply, login)

end

function Elib.accounts.servercmds(args)
 local arg = args[1]
  if arg == 'new' then
   local user = args[2]
   local pass = args[3]
   local loginmsg = args[4]
      NewAccount(user, pass, loginmsg)
  elseif arg == 'purge' then
     local user = args[2]
	 DeleteAccount(user)
  elseif arg == 'reset' then
     local user = args[2]
	 ResetAccount(user)
  else
     print("^2Elib Accounts System:\n - new   [user] [password] [loginmsg] // Creates new account\n - purge [user] // Deletes account\n - reset [user] // Set account to default settings")
  end
end

Elib.servercommands['accounts'] = Elib.accounts.servercmds 
Elib.hooks.add('JPLUA_EVENT_UNLOAD', 'accounts_save', Accounts.save)
Accounts.load()
