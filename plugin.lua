local plugin = RegisterPlugin("EpicLibrary", "v2") --- By EpicLoyd

CreateCvar('^1Elibvesion', '2.0^1dev', 0x0004)
Elib = {}
Elib.modules = {}
Elib.logger = nil
Elib.settings = {}
Elib.commands = {}
Elib.settings['Motd'] = 'Welcome'

local function SaveSettings()
  local file = GetSerialiser('data/settings.json', FSMode.WRITE)
   if file == nil then
     error("^1Failed to open settings file. Shutdowning...")
   end
     file:AddTable("settings", Elib.settings)  --- Save
end

local function LoadSettings()
    local file = GetSerialiser('data/settings.json', FSMode.READ)
	 if file == nil then  ----Create new one
	   SaveSettings()
	 end
	 file = GetSerialiser('data/settings.json', FSMode.READ) -- Reopen it
	   file:ReadTable("settings", Elib.settings)
	 file:Close()
end

local function ElibCommand(ply, args)
 local cmd = args[1]
  for k, v in pairs(Elib.commands) do
   if k == cmd and type(v) == 'function' then
     ok, retval = pcall(v, args)
	  if (ok == false) then print("^3SEVERE: Error occured during executing '" .. k .. " ' command") end 
   end
  end
end




local function Init()
 print('\n=====ELib Initiliazation======')
 LoadSettings()
 ------Permissions System
 
 ------Accounts System, Ban System
 
 ------Connection Manager
 
 ------Admin System
 
 ------Economic System
 
 ------Clan System
 
 ------Shop System
 
 ------Awards System
 
 print('===========Complete===========\n')
end


local function Shutdown()
 print('\n=========Elib Shutdown==========')

 
 print('================================\n')
end