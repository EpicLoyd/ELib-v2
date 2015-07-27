Elib = {}
Elib.plugin = RegisterPlugin('EpicLibrary', 'v2') --- by EpicLoyd


local function Elib.servercommand(args)
 local cmd = args[1]
 if not cmd or cmd == '' or cmd == ' ' then
    return
 end
  for k, v in pairs(Elib.servercommands) do
   if k == cmd and type(v) == 'function' then
     table.remove(args, 1)
     ok, retval = pcall(v,args)
	  if (ok == false) then print("^2Elib: ^3Error occured during executing '" .. k .. " ' servercommand") end 
   end
  end
end

AddServerComand('elib', Elib.servercommand)
