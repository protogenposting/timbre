/// @description Insert description here
// You can write your code in this editor
audio_sound_pitch(audio,global.songSpeed)

update_particles()

songMilliseconds=audio_sound_get_track_position(audio)*1000

playFinishSound=false

var barPercentageLast = barPercentage
var beatLength=60/bpm
var needle = songMilliseconds/1000
var left = currentBeat * beatLength;
var right = left + beatLength;
barPercentage = remap(needle, left, right, 0, 1);

finishTimerLast=finishTimer

image_index=round(barPercentage*24)

//show_debug_message(image_index)

playerFrame=round(barPercentage*4)
axeFrames[0]=round(barPercentage*4)
axeFrames[1]=round(barPercentage*4)
for(var i=0;i<array_length(points);i++)
{
	points[i].frame=round(barPercentage*4)
}
layer_background_index(background,round(barPercentage))

if(frac(barPercentage)<frac(barPercentageLast))
{
	for(var i=0;i<array_length(bobs);i++)
	{
		bobs[i].frame++
	}
	
	if(get_accuracy()<=30)
	{
		layer_background_sprite(background,spr_grass_bad)
	}
	else if(fullCombo&&songMilliseconds/1000>=global.songLength/2)
	{
		layer_background_sprite(background,spr_grass_fc)
	}
	else
	{
		layer_background_sprite(background,spr_grass)
	}
	currentBeat++
	if(finished)
	{
		finishTimer++
		showingFinalMessage=!showingFinalMessage
	}
	audio_play_sound(snd_beat,1000,false)
}

if(global.epilepsyMode)
{
	layer_background_sprite(background,spr_grass_epilepsy)
}
if(sprites.grass!=spr_grass)
{
	layer_background_sprite(background,sprites.grass)
}

currentFracBeat=currentBeat+barPercentage

axeRotations[0]-=axeRotations[0]/(10*(fps/60))
axeRotations[1]-=axeRotations[1]/(10*(fps/60))

#region controls

	if(!global.improvedControls)
	{
		var funnyMode=false
		var currentDirection=floor(loop_rotation(point_direction(points[currentPoint].x,points[currentPoint].y,points[currentPoint+1].x,points[currentPoint+1].y)+90)/90)
		attackKey[array_index_looped_index(attackKey,noteDirections.right+currentDirection)]=keyboard_check_pressed(global.keyboardBinds.attacking.left)
		attackKey[array_index_looped_index(attackKey,noteDirections.left+currentDirection)]=keyboard_check_pressed(global.keyboardBinds.attacking.right)
		attackKey[array_index_looped_index(attackKey,noteDirections.up+currentDirection)]=false
		attackKey[array_index_looped_index(attackKey,noteDirections.down+currentDirection)]=false
		if(funnyMode)
		{
			attackKey[array_index_looped_index(attackKey,noteDirections.right+currentDirection)]=choose(keyboard_check_pressed(global.keyboardBinds.attacking.left),keyboard_check_pressed(global.keyboardBinds.attacking.right))
			attackKey[array_index_looped_index(attackKey,noteDirections.left+currentDirection)]=choose(keyboard_check_pressed(global.keyboardBinds.attacking.left),keyboard_check_pressed(global.keyboardBinds.attacking.right))
			timings[0]=choose({distance:msWindow/7,name:"Perfect!"},{distance:msWindow/5,name:"Good"},{distance:msWindow/3,name:"Ok"},{distance:msWindow,name:"Doodoo..."})
			timings[1]=choose({distance:msWindow/7,name:"Perfect!"},{distance:msWindow/5,name:"Good"},{distance:msWindow/3,name:"Ok"},{distance:msWindow,name:"Doodoo..."})
			timings[2]=choose({distance:msWindow/7,name:"Perfect!"},{distance:msWindow/5,name:"Good"},{distance:msWindow/3,name:"Ok"},{distance:msWindow,name:"Doodoo..."})
			timings[3]=choose({distance:msWindow/7,name:"Perfect!"},{distance:msWindow/5,name:"Good"},{distance:msWindow/3,name:"Ok"},{distance:msWindow,name:"Doodoo..."})
		}
		show_debug_message(attackKey)
		show_debug_message(currentDirection)
		
	}
	else
	{
		attackKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.attacking.left)
		attackKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.attacking.right)
		attackKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.attacking.up)
		attackKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.attacking.down)
	}
	var currentDirection=points[currentPoint].direction*90
	
	turnKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.turning.left)
	turnKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.turning.right)
	turnKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.turning.up)
	turnKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.turning.down)
	
	if(attackKey[loop_rotation((currentDirection+90))/90])
	{
		axeRotations[0]=-90
		audio_play_sound(snd_swipe,1000,false)
	}
	if(attackKey[loop_rotation((currentDirection-90))/90])
	{
		axeRotations[1]=-90
		audio_play_sound(snd_swipe,1000,false)
	}
	if(attackKey[loop_rotation((currentDirection+180))/90])
	{
		axeRotations[0]=45
		axeRotations[1]=45
		audio_play_sound(snd_swipe,1000,false)
	}
	if(attackKey[loop_rotation((currentDirection))/90])
	{
		axeRotations[0]=-90
		axeRotations[1]=-90
		audio_play_sound(snd_swipe,1000,false)
	}
	
	turnKeyReleased[noteDirections.left]=keyboard_check_released(global.keyboardBinds.turning.left)
	turnKeyReleased[noteDirections.right]=keyboard_check_released(global.keyboardBinds.turning.right)
	turnKeyReleased[noteDirections.up]=keyboard_check_released(global.keyboardBinds.turning.up)
	turnKeyReleased[noteDirections.down]=keyboard_check_released(global.keyboardBinds.turning.down)
	
	turnKeyHold[noteDirections.left]=keyboard_check(global.keyboardBinds.turning.left)
	turnKeyHold[noteDirections.right]=keyboard_check(global.keyboardBinds.turning.right)
	turnKeyHold[noteDirections.up]=keyboard_check(global.keyboardBinds.turning.up)
	turnKeyHold[noteDirections.down]=keyboard_check(global.keyboardBinds.turning.down)

#endregion

if(!finished&&!audio_is_playing(songID)&&(array_contains(attackKey,1)||array_contains(turnKey,1)))
{
	audio=audio_play_sound(songID,1000,false)
	audio_sound_set_track_position(audio,offset/1000)
}

if(currentPoint>=array_length(points)-2&&(array_equals(notes,[])||currentBeat>array_last(notes).beat+3)&&!finished)
{
	finished=true
	audio_play_sound(finishHitSound,1000,false)
}

if(paused)
{
	audio_pause_sound(audio)
	if(keyboard_check_pressed(vk_space))
	{
		audio_stop_all()
		if(global.editing)
		{
			room_goto(rm_editor)
		}
		else
		{
			room_goto(rm_level_select)
		}
	}
}
if(!paused)
{
	audio_resume_sound(audio)
}