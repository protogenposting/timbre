/// @description Insert description here
// You can write your code in this editor
if(room==rm_gameplay)
{
	var _uncappedFPS=false
	if(_uncappedFPS)
	{
		game_set_speed(1,gamespeed_microseconds)
	}
	else
	{
		game_set_speed(120,gamespeed_fps)
	}
}
else
{
	game_set_speed(60,gamespeed_fps)
}