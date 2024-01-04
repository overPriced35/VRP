--[[ FX Information ]]

fx_version "cerulean"
game "gta5"
lua54 "yes"

--[[ Resource Information ]]
name "speedlimits"
author "White_Rice"
version "1.0.0"
description "Speedlimits"

--[[ Manifest ]]
client_scripts {
	'config.lua',
	'speedlimits.lua',
	'client.lua'
}

ui_page('html/index.html')

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/images/*.png',
	'html/fonts/Highway-Gothic-Regular.ttf',
	'html/fonts/DINMittelschriftStd.otf',
	'html/fonts/Transport-Medium.ttf',
}
