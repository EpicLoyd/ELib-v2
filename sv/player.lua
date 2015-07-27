Elib.players = {} --- Handles all player functions
local plytable = GetPlayerTable() -- get player metatable

---------Accounts 

function plytable:CreateStorage()
	local temp = {}
	local name = JPUtil.StripColours(self.name)
	temp['name'] = name
	temp['group'] = 'default'
	temp['account'] = ''
	temp['begintime'] = GetTime()
	Elib.players[self.id] = temp
end

function plytable:CleanStorage()
	Elib.players[self.id] = nil
end

function plytable:IsLogged()
print(self)
	if self == nil then return false end
	if Elib.players[self.id]['account'] ~= nil or Elib.players[self.id]['account'] ~= '' then
		return true
	else
		return false
	end
end

function plytable:SetAccount(account)
	if self or account == nil then return end
	Elib.players[self.id]['account'] = account
end

function plytable:GetAccount()
	if self == nil then return nil end
	if Elib.players[self.id]['account'] ~= nil then
		return Elib.players[self.id]['account']
	end
	return nil
end


--------- 


function plytable:Chat(msg)
	if self == nil then return end
	SendReliableCommand(self.id, string.format('chat "%s"', msg))
end

function plytable:Center(msg)
	if self == nil then return end
    SendReliableCommand(self.id, string.format('cp "%s"', msg))
end

function plytable:Console(msg)
	if self == nil then return end
    SendReliableCommand(self.id, string.format('print "%s"', msg))
end

function plytable:Command(msg)
	if self == nil then return end
    SendReliableCommand(self.id, string.format('%s', cmd))
end

--------  Permissions

function plytable:GetGroup()
	if self == nil then return end
	local acc = self:GetAccount()
	if acc.group and acc.group ~= 'default' and acc.group ~= ' ' then
		return acc.group
	elseif Elib.players[self.id]['group'] ~= 'default' then
		return Elib.players[self.id]['group']
	else
		return 'default'
	end
end

function plytable:SetGroup(roup)
	if self == nil then return end
	if not Perms.group.exist(group) then return end
	local acc = self:GetAccount()
	if not acc then
		Elib.players[self.id]['group'] = group
	else 
		acc.group = group
	end 
end

