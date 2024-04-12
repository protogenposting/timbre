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
	currentShroomPose++
	if(currentShroomPose>=4)
	{
		currentShroomPose=0
	}
	if(currentShroomPose==1||currentShroomPose==3)
	{
		logoRotation=45*logoRotationMult
		logoRotationMult*=-1
	}
}

logoRotation-=sign(logoRotation)*3

if(treeLine.y>room_height-128)
{
	treeLine.y-=(treeLine.y-(room_height-128))/60
}
treeLine.x+=3
if(treeLine.x>512)
{
	treeLine.x-=512
}

if(gooberLocation.y<room_height)
{
	gooberLocation.y-=(gooberLocation.y-room_height)/60
}