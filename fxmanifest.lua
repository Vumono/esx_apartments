fx_version 'cerulean'
game {'gta5' }
author 'Vumon'

dependencies {
	"PolyZone"
}

shared_script '@es_extended/imports.lua'

client_scripts {
	'client.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua'
}

