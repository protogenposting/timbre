/// @description Insert description here
// You can write your code in this editor

if(moreStats)
{
	if(percentageBetweenPoints<1)
	{
		percentageBetweenPoints+=0.01*tabMoveSpeed
	}
}
else
{
	if(percentageBetweenPoints>0)
	{
		percentageBetweenPoints-=0.01*tabMoveSpeed
	}
}

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
	songMilliseconds=0
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

if(mouse_wheel_up())
{
	yOffsetSpeed=yOffsetMaxSpeed
}
if(mouse_wheel_down())
{
	yOffsetSpeed=-yOffsetMaxSpeed
}

while(yOffset>=array_last(button).position.y)
{
	yOffset=array_last(button).position.y-1
	yOffsetSpeed=0
}
while(yOffset<0)
{
	yOffset=0
	yOffsetSpeed=0
}

yOffsetSpeed-=sign(yOffsetSpeed)

yOffset+=yOffsetSpeed