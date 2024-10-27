/// @description Insert description here
// You can write your code in this editor
if(comboPrevious<comboDanceAmount&&combo>=comboDanceAmount)
{
	comboParticles=part_system_create(p_sparks)
	audio_play_sound(snd_woo,1000,false)
}

if(comboParticles!=-4)
{
	part_system_position(comboParticles,camera_get_view_x(view_camera[0])+1366/2,camera_get_view_y(view_camera[0]))
}

if(audio!=-4&&audio_is_playing(audio))
{
	audio_sound_pitch(audio,global.songSpeed)
}

update_particles()

if(audio!=-4)
{
	songMilliseconds=audio_sound_get_track_position(audio)*1000 + global.audioOffset
}

if(global.deltaTime&&audio!=-4)
{
	songMilliseconds=abs(current_time-startTime)
}

//show_debug_message(songMilliseconds)

playFinishSound=false

var barPercentageLast = barPercentage
var beatLength=60/bpm
var needle = songMilliseconds/1000
var left = currentBeat * beatLength;
var right = left + beatLength;
barPercentage = remap(needle, left, right, 0, 1);

finishTimerLast=finishTimer

image_index=round(barPercentage*sprite_get_number(sprite_index))

if(global.gamemode==1 && sprite_index!=spr_acorn_idle)
{
	image_index=3-(spriteResetStall/danceTime)*3
	
	if(floor(image_index)==2)
	{
		animationEnded=true
	}
	
	if(animationEnded)
	{
		image_index=2
	}
}

//show_debug_message(image_index)

playerFrame=round(currentFracBeat*4)
axeFrames[0]=round(currentFracBeat*4)
axeFrames[1]=round(currentFracBeat*4)
for(var i=0;i<array_length(bobs);i++)
{
	bobs[i].frame=round(currentFracBeat*6)
}
for(var i=0;i<array_length(points);i++)
{
	points[i].frame=round(currentFracBeat*4)
}

layer_background_index(background,barPercentage*sprite_get_number(sprites.grass))

if(frac(barPercentage)<frac(barPercentageLast))
{
	currentBeat++
	if(finished)
	{
		finishTimer++
		showingFinalMessage=!showingFinalMessage
	}
	//audio_play_sound(snd_beat,1000,false)
}

layer_background_sprite(background,sprites.grass)

currentFracBeat=currentBeat+barPercentage

if(global.gamemode==0)
{
	axeRotations[0]-=axeRotations[0]/(10*(fps/60))
	axeRotations[1]-=axeRotations[1]/(10*(fps/60))
}

#region controls

	turn_off_keys()
	if(!paused)
	{
		get_inputs()
		
		if(global.gamemode==0)
		{
			rotate_axes(attackKey)
		}
	}

#endregion

if(audio==-4)
{
	startTime=current_time
}

if(!finished&&audio==-4&&
(array_contains(attackKey,1)||
array_contains(turnKey,1)||
!global.gamemodes[global.gamemode].usesNormalControls&&global.pressingMouseLeft))
{
	audio=audio_play_sound(songID,1000,false)
}

if(currentPoint>=array_length(points)-2&&(array_equals(notes,[])||songMilliseconds>array_last(notes).timeMS+3)&&!finished)
{
	finished=true
	audio_play_sound(finishHitSound,1000,false)
}

if(paused&&audio!=-4)
{
	startTime+=delta_time/1000
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
if(!paused&&audio!=-4)
{
	audio_resume_sound(audio)
}

comboPrevious=combo