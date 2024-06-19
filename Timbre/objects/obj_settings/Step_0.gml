/// @description Insert description here
// You can write your code in this editor
var _trackPos=audio_sound_get_track_position(audio)+global.audioOffset/1000
playerProgress=_trackPos/audio_sound_length(snd_tutorial_sound)
if(playerProgress>=0.5&&!passedHalf)
{
	audio_play_sound(snd_turn,1000,false)
	passedHalf=true
}
if(playerProgress<0.5&&passedHalf)
{
	passedHalf=false
}