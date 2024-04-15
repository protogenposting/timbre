/// @description Insert description here
// You can write your code in this editor
songMilliseconds=audio_sound_get_track_position(audio)*1000

if(audio==-4)
{
	songMilliseconds=0
}

var barPercentageLast = barPercentage
if(barPercentageLast<0)
{
	button[5].func()
}
var beatLength=60/bpm
var needle = songMilliseconds/1000 
var left = currentBeat * beatLength;
var right = left + beatLength;
barPercentage = remap(needle, left, right, 0, 1);

if(frac(barPercentage)<frac(barPercentageLast)&&barPercentage!=barPercentageLast)
{
	currentBeat++
}

if(barPercentage>1||barPercentage<=0)
{
	barPercentage=0
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

if(keyboard_check_pressed(vk_up))
{
	difficultyAlpha=1
	currentDifficulty--
	if(currentDifficulty<0)
	{
		currentDifficulty=2
	}
}
if(keyboard_check_pressed(vk_down))
{
	difficultyAlpha=1
	currentDifficulty++
	if(currentDifficulty>2)
	{
		currentDifficulty=0
	}
}

zoom=zooms[currentZoom]