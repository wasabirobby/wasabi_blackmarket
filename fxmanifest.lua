-----------------For support, scripts, and more----------------
-----------------https://discord.gg/XJFNyMy3Bv-----------------
---------------------------------------------------------------
fx_version 'cerulean'

game 'gta5'

ui_page 'html/index.html'

author 'wasabirobby'

version '1.0.4'

files {
	'html/index.html',
	'html/style.css',
	'html/app.js',
	'html/logo.png',
	'html/Roboto-Regular.ttf',
	'html/images/**.png'
}

server_scripts {
	'config.lua',
	'server/*.lua',
}

client_scripts {
	'client/*.lua'
}

shared_script 'strings.lua'

dependencies {
	'es_extended',
	--'qtarget' Removed as dependency because 3d text option provided in config
}
