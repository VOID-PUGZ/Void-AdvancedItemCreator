fx_version 'cerulean'
game 'gta5'

author 'Void Scripts'
description 'Advanced Item Creator for QBCore with ox_inventory support'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'qb-core',
    'ox_lib'
}

lua54 'yes'
