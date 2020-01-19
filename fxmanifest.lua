fx_version 'adamant'

game 'gta5'

description 'ESX Aircraft Shop'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'esx_dmvschool'
}

export 'GeneratePlate'