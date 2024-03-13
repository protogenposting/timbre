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
	currentBeat++
	//audio_play_sound(snd_turn,1000,false)
}

currentFracBeat=currentBeat+barPercentage

global.directory = game_save_id+"/"+obj_editor.name

if(mouse_wheel_down())
{
	if(keyboard_check(vk_shift))
	{
		currentZoom--
		if(currentZoom<0)
		{
			currentZoom=0
		}
		startingBeat=round(startingBeat)
	}
	else{
		startingBeat+=zoom
	}
}
if(mouse_wheel_up())
{
	if(keyboard_check(vk_shift))
	{
		currentZoom++
		if(currentZoom>array_length(zooms)-1)
		{
			currentZoom=array_length(zooms)-1
		}
		startingBeat=round(startingBeat)
	}
	else{
		startingBeat-=zoom
	}
}

zoom=zooms[currentZoom]