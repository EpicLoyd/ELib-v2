Elib.accounts = {} --- Handles all Account System
Elib.accounts.__index = Elib.accounts
Elib.accounts.list = {}
Accounts = Elib.accounts



---------------------Meta functions

function Elib.accounts.New(login)
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

function Elib.accounts.tostring()
  print("Account ( " .. self.login .. " )")
end

function Elib.accounts.equal(acc1, acc2)
  if acc1 and acc2 and acc1.login == acc2.login then
    return true
  else
    return false
  end
end

setmetatable(Elib.accounts, {
  __call = cls.New,
  __tostring = cls.tostring,
  __eq = cls.equal,
})

local function LoadData()
 local temp = {}
 local main = {}
 local file = GetSerialiser('data/accounts.json', FSMode.READ)
  if file == nil then
    SaveData()
  end
 file = GetSerialiser('data/accounts.json', FSMode.READ) --- Reopen
 main = file:ReadTable('account')
  for k,v in pairs(main) do
    local acc = Elib.accounts(k)
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

local function SaveData()
 local temp = {}
 local main = {}
 local file = GetSerialiser('data/accounts.json', FSMode.WRITE)
  if file == nil then
    print("^1ERROR:Failed to open settings file. Shutdowning...")
  end
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
  file:AddTable('account', main)
  file:Close()
end

function Elib.accounts.Exist(login)
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

function Elib.accounts:GetLogin()
  if self == nil then return nil end
  return self.login
end

function Elib.accounts:GetPassword()
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

local function NewAccount(ply, login, pass)

end

local function DeleteAccount(ply, login)

end

local function ResetAccount(ply, login)

end

function Elib.accounts.cmds(ply, args)
 local arg = args[1]
  if arg == 'new' then
   local user = args[2]
   local pass = args[3]
      NewAccount(ply, user, pass)
  elseif == 'purge' then
     local user = args[2]
	 DeleteAccount(ply, user)
  elseif == 'reset' then
     local user = args[3]
	 ResetAccount(ply, user)
  end
end


Elib.commands['accounts'] = Elib.accounts.cmds
