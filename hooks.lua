local Hook = {}
Elib.hooks = Hook -- Hooks system ( because i don't like current listeners system -.-)

local Hooks = {}
Hooks['JPLUA_EVENT_UNLOAD'] = {}
Hooks['JPLUA_EVENT_RUNFRAME'] = {}
Hooks['JPLUA_EVENT_CHATMSGRECV'] = {}
Hooks['JPLUA_EVENT_CLIENTBEGIN'] = {}
Hooks['JPLUA_EVENT_CLIENTCOMMAND'] = {}
Hooks['JPLUA_EVENT_CLIENTCONNECT'] = {}
Hooks['JPLUA_EVENT_CLIENTDISCONNECT'] = {}
Hooks['JPLUA_EVENT_CLIENTSPAWN'] = {}
Hooks['JPLUA_EVENT_CLIENTUSERINFOCHANGED'] =  {}
Hooks['JPLUA_EVENT_PAIN'] = {}
Hooks['JPLUA_EVENT_PLAYERDEATH'] = {}


local function Execute(id, ...)
 for k,v in pairs(Hooks[id]) do
  if type(v['func']) == 'function' then
   ok, retval = pcall(v['func'], ...)
   if ok == false then
     print(string.format("^2Elib: ^2Hook %s error: %s", tostring(retval)))
   end
  end
 end
end


function Hook.init()
 AddListener('JPLUA_EVENT_UNLOAD', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_UNLOAD', ...)  end)
 AddListener('JPLUA_EVENT_RUNFRAME', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_RUNFRAME', ...) end)
 AddListener('JPLUA_EVENT_CHATMSGRECV', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_CHATMSGRECV', ...) end)
 AddListener('JPLUA_EVENT_CLIENTBEGIN', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_CLIENTBEGIN', ...) end)
 AddListener('JPLUA_EVENT_CLIENTCOMMAND', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_CLIENTCOMMAND', ...) end)
 AddListener('JPLUA_EVENT_CLIENTCONNECT', function(...) return Elib.ConnectManager.Connect(...) end)
 AddListener('JPLUA_EVENT_CLIENTDISCONNECT', function(...) _, ret = pcall(Elib.ConnectManager.Disconnect, ...) end)
 AddListener('JPLUA_EVENT_CLIENTSPAWN', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_CLIENTSPAWN', ...) end)
 AddListener('JPLUA_EVENT_CLIENTUSERINFOCHANGED', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_CLIENTUSERINFOCHANGED', ...) end)
 AddListener('JPLUA_EVENT_PAIN', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_PAIN', ...) end)
 AddListener('JPLUA_EVENT_PLAYERDEATH', function(...) _, ret = pcall(Execute, 'JPLUA_EVENT_PLAYERDEATH', ...) end)
 --for now...
end

function Hook.add(id, name, func)
local temp = {}
temp['name'] = name
temp['func'] = func
table.insert(Hooks[id], temp)
end

