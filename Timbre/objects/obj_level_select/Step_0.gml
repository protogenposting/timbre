/// @description Insert description here
// You can write your code in this editor
if(!audio_is_playing(global.song)&&global.song!=-4)
{
	audio=audio_play_sound(global.song,1000,true)
}

global.botPlay=false

try{
	bpm=global.levelData.bpm
	songMilliseconds=audio_sound_get_track_position(audio)*1000

	var barPercentageLast = barPercentage
	var beatLength=60/bpm
	var needle = songMilliseconds/1000
	var left = currentBeat * beatLength;
	var right = left + beatLength;
	barPercentage = remap(needle, left, right, 0, 1);
	if(frac(barPercentage)<frac(barPercentageLast))
	{
		currentShroomPose++
	}
}
catch(e)
{
	
}

if(treeLine.y<room_height+256)
{
	treeLine.y-=(treeLine.y-(room_height+256))/60
}
treeLine.x+=3
if(treeLine.x>512)
{
	treeLine.x-=512
}

if(gooberLocation.y>room_height-256)
{
	gooberLocation.y-=(gooberLocation.y-(room_height-256))/60
}