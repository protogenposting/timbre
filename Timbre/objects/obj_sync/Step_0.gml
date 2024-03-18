/// @description Insert description here
// You can write your code in this editor
playerProgress+=0.01
if(playerProgress>1)
{
	playerProgress=0
}

axeRotations[0]-=axeRotations[0]/10
axeRotations[1]-=axeRotations[1]/10

timeUntilNextBeat-=delta_time/1000000

beatTimer-=delta_time/1000000

if(timeUntilNextBeat<=0)
{
	audio_play_sound(snd_beat,1000,false)
	timeUntilNextBeat=timeBetweenBeats
	currentBeat++
	if(currentBeat>3)
	{
		currentBeat=0
	}
	beatTimer=0.3
}

/*
if(timeUntilNextBeat>timeBetweenBeats/2)
{
	if(keyboard_check_pressed(vk_anykey))
	{
		array_push(offsets,timeUntilNextBeat-timeBetweenBeats*currentBeat)
	}
}

if(timeUntilNextBeat<=timeBetweenBeats/2)
{
	if(keyboard_check_pressed(vk_anykey))
	{
		array_push(offsets,timeUntilNextBeat-timeBetweenBeats*currentBeat)
	}
}