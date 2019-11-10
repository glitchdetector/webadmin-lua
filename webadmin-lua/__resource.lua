name "Webadmin Lua Factory"
author "glitchdetector"
contact "glitchdetector@gmail.com"
version "1.0"

description "A helper tool for creating Webadmin plugins in Lua"
details [[
    Exposes a widget factory
]]
usage [[
    Depend on this resource
    Get the factory using the provided export
    Use the exported factory to easily create an interface
]]

dependency 'webadmin'
provide 'webadmin-lua'

server_script 'server/utils/*.lua'
server_script 'server/factory.lua'
server_script 'server/updatecheck.lua'

server_export 'getFactory'

-- Uncomment the below lines to enable examples
-- server_script 'server/included/demo.lua'
-- server_script 'server/included/boilerplate.lua'
