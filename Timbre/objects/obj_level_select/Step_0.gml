/// @description Insert description here
// You can write your code in this editor
if(!audio_is_playing(global.song)&&global.song!=-4)
{
	audio_play_sound(global.song,1000,true)
}

global.botPlay=false