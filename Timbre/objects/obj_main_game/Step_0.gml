/// @description Insert description here
// You can write your code in this editor
songMilliseconds=audio_sound_get_track_position(audio)*1000

var barPercentageLast = barPercentage
var beatLength=60/bpm
var needle = songMilliseconds/1000
var left = currentBeat * beatLength;
var right = left + beatLength;
barPercentage = remap(needle, left, right, 0, 1);

if(frac(barPercentage)<frac(barPercentageLast))
{
	layer_background_index(background,currentBeat)
	currentBeat++
	//audio_play_sound(snd_metronome,1000,false)
}

currentFracBeat=currentBeat+barPercentage

axeRotations[0]-=axeRotations[0]/10
axeRotations[1]-=axeRotations[1]/10

#region controls

	attackKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.attacking.left)
	attackKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.attacking.right)
	attackKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.attacking.up)
	attackKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.attacking.down)

	turnKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.turning.left)
	turnKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.turning.right)
	turnKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.turning.up)
	turnKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.turning.down)

#endregion

if(!audio_is_playing(songID)&&(array_contains(attackKey,1)||array_contains(turnKey,1)))
{
	audio=audio_play_sound(songID,1000,false)
	audio_sound_set_track_position(audio,offset/1000)
}

if(paused)
{
	audio_pause_sound(audio)
	if(keyboard_check_pressed(vk_space))
	{
		room_goto(rm_menu)
	}
}
if(!paused)
{
	audio_resume_sound(audio)
}