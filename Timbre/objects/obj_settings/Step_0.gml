/// @description Insert description here
// You can write your code in this editor
playerProgress+=0.02
if(playerProgress>1)
{
	playerProgress=0
}
if(playerProgress==0.5)
{
	audio_play_sound(snd_turn,1000,false)
}