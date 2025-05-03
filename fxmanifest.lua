fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

description 'egl_wheel'
author 'Eagle'
version '1.0.0'

shared_scripts {
    -- '@ox_lib/init.lua', -- only if you use ox_lib
    'locales_init.lua',
    'locales/*.lua',
    'config.lua',
    'core.lua',
}

client_scripts {
    'client/module/*.lua',
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
}