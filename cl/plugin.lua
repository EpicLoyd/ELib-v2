Elib = {}
Elib.plugin = RegisterPlugin('EpicLibrary', 'v2') --- by EpicLoyd
Elib.servercommands = {}

require(Elib.plugin['dirname'] .. '/draw.lua')

function Elib.servercommand(args)
 local cmd = args[1]
 print(cmd)
 if not cmd or cmd == '' or cmd == ' ' then
    return
 end
  for k, v in pairs(Elib.servercommands) do
   if k == cmd and type(v) == 'function' then
     table.remove(args, 1)
     ok, retval = pcall(v,args)
	  if (ok == false) then print("^2Elib: ^3Error occured during executing '" .. k .. " ' servercommand ( " .. retval .. " )") end 
   end
  end
end

AddServerCommand('elib', Elib.servercommand)
