local plugin = RegisterPlugin("EpicLibrary", "v2") --- By EpicLoyd

CreateCvar('^1Elibvesion', '2.0^1dev', 0x0004)
Elib = {}
Elib.modules = {}
Elib.logger = nil
Elib.settings = {}
Elib.commands = {}
Elib.servercommands = {}
Elib.settings['Motd'] = 'Welcome'

--[[

local function SessionSave()

end                              -------TODO: Sessions

local function SessionLoad()

end
]]  

function Elib.save()
  local file = GetSerialiser('data/settings.json', FSMode.WRITE)
     file:AddTable("settings", Elib.settings)  --- Save
	 file:Close()
end

function Elib.load()
    local file = GetSerialiser('data/settings.json', FSMode.READ)
	Elib.settings = file:ReadTable("settings")
	file:Close()
end

local function ElibCommand(ply, args)
 local cmd = args[1]
  for k, v in pairs(Elib.commands) do
   if k == cmd and type(v) == 'function' then
     table.remove(args, 1)
     ok, retval = pcall(v, ply ,args)
	  if (ok == false) then print("^2Elib: ^3Error occured during executing '" .. k .. " ' command") end 
   end
  end
end

local function ElibServerCommand(args)
 local cmd = args[1]
 if not cmd or cmd == '' or cmd == ' ' then
    print('^2Elib:\n - accounts    // Show info for accounts system\n - permissions // Show info for permissions system\n - connectmgr  // Show info for connection manager\n - admin       // Show info for admin system')
 end
  for k, v in pairs(Elib.servercommands) do
   if k == cmd and type(v) == 'function' then
     table.remove(args, 1)
     ok, retval = pcall(v,args)
	  if (ok == false) then print("^2Elib: ^3Error occured during executing '" .. k .. " ' command") end 
   end
  end
end

local function Init()
 print('\n=====ELib Initiliazation======')
 Elib.load()
 
 require 'Elibv2/utils.lua'
 ------Hooks system
 print('Hooks...')
 require 'Elibv2/hooks.lua'
 Elib.hooks.init()
 ------Connection Manager
 print('Connect Manager...')
 require 'Elibv2/connect.lua'
 Elib.ConnectManager.init()
 -----Permissions
 print('Permissions...')
 require 'Elibv2/permissions.lua'
 Elib.permissions.load()
 -----Accounts
 print('Accounts...')
 require 'Elibv2/accounts.lua'
 

 
 ------Admin System
 
 ------Economic System
 
 ------Clan System (future ja++ clan system integration?)
 
 ------Shop System ( UILua need to be done)
 
 ------Awards System ( May be)
 
 print('===========Complete===========\n')
end


local function Shutdown()
 print('\n=========Elib Shutdown==========')
 print('Saving settings...')
 Elib.save()
 print('================================\n')
end

AddServerCommand('elib', ElibServerCommand)
Init()
Elib.hooks.add('JPLUA_EVENT_UNLOAD', 'elib_shutdown', Shutdown)