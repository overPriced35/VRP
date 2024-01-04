fx_version 'cerulean'

game 'gta5'

ui_page 'html/index.html'

files {'html/*.html', 'html/*.js', 'html/*.css', 'html/assets/spawn.png'}

client_script 'cl_spawn.lua'

server_script {
    'sv_main.lua'
}
