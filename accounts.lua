Elib.accounts = {}
Elib.accounts.__index = Elib.accounts
Elib.accounts.list = {}
Accounts = Elib.accounts

setmetatable(Elib.accounts, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
  __tostring = function(cls, ...)
    return cls.tostring(...)
  end,
})

local function LoadData()

end

local function SaveData()

end

--function Accounts.Init()
-- local plys = GetPlayers()
--   for k, v in pairs(plys) do
--     plylog[JPUtil.StripColours(v:GetName())] = false
--   end
--end


function Elib.accounts.new(login)
  local self = setmetatable({}, Elib.accounts)
  self.login = login
  self.password = ''
  self.hash = '' ----IPB Integration
  self.salt = '' ----IPB Integration
  self.isadmin = false
  --self.statistics = setmetatable({}, table) ---- Statistics
  self.money = 0
  self.banned = false
  --self.inventory = {} --Shop/Inventory
  --self.clan = ''      -- Clan System
  --self.group = 'basic' -- Permissions System
  self.player = nil
  self.loginmsg = ''
  acclist[login] = self
  return self
end
