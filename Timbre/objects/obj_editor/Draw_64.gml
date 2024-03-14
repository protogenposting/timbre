/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(audio!=-4&&audio_is_playing(songLoaded))
{
	draw_rectangle(0,0,room_width*(audio_sound_get_track_position(audio)/audio_sound_length(audio)),32,false)
	draw_text(room_width/2,64,"playing song")
}
else
{
	for(var i=0;i<array_length(notes);i++)
	{
		notes[i].wasHit=false
	}
}

var beatLength=60/bpm

var _x=512+256
var _y=32
var boxSize=20

var relativeBeat=((songMilliseconds/1000)/beatLength)-1

show_debug_message(relativeBeat)
show_debug_message(currentBeat)

var beat=startingBeat
repeat(16)
{
	draw_set_color(c_white)
	if(beat>=relativeBeat&&beat<relativeBeat+zoom)
	{
		draw_set_color(c_green)
	}
	var notesInBeat=[]
	var notesInBeatEquivelants=[]
	for(var i=0;i<array_length(notes);i++)
	{
		if(notes[i].beat>=beat&&notes[i].beat<beat+1)
		{
			array_push(notesInBeat,notes[i])
			array_push(notesInBeatEquivelants,i)
		}
	}
	_x=512+256
	draw_text(_x-64,_y,string(beat))
	//turns
	var noteDirection=0
	repeat(4)
	{
		var noteOnBeat=note_on_beat(notesInBeat,beat,noteTypes.turn,noteDirection)
		if(noteOnBeat!=-1)
		{
			draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,false)
			if(songMilliseconds/1000>=beat*beatLength&&!notes[notesInBeatEquivelants[noteOnBeat]].wasHit&&audio!=-4&&audio_is_playing(songLoaded))
			{
				audio_play_sound(snd_turn,1000,false)
				notes[notesInBeatEquivelants[noteOnBeat]].wasHit=true
			}
		}
		draw_sprite_ext(spr_reverse_arrow,0,_x,_y,0.5,0.5,noteDirection*90,c_white,1)
		draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,true)
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize))
		{
			if(mouse_check_button_pressed(mb_left))
			{
				if(noteOnBeat==-1)
				{
					array_push(notes,create_note(beat,noteTypes.turn,noteDirection,false))
				}
				else
				{
					array_delete(notes,notesInBeatEquivelants[noteOnBeat],1)
				}
			}
		}
		_x+=boxSize*2
		noteDirection++
	}
	_x+=boxSize
	//logs
	noteDirection=0
	repeat(4)
	{
		var noteOnBeat=note_on_beat(notesInBeat,beat,noteTypes.log,noteDirection)
		if(noteOnBeat!=-1)
		{
			draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,false)
			if(songMilliseconds/1000>=beat*beatLength&&!notes[notesInBeatEquivelants[noteOnBeat]].wasHit&&audio!=-4&&audio_is_playing(songLoaded))
			{
				audio_play_sound(snd_hit_tree,1000,false)
				notes[notesInBeatEquivelants[noteOnBeat]].wasHit=true
			}
		}
		draw_sprite_ext(spr_log,0,_x,_y,0.5,0.5,noteDirection*90,c_white,1)
		draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,true)
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize))
		{
			if(mouse_check_button_pressed(mb_left))
			{
				if(noteOnBeat==-1)
				{
					array_push(notes,create_note(beat,noteTypes.log,noteDirection,false))
				}
				else
				{
					array_delete(notes,notesInBeatEquivelants[noteOnBeat],1)
				}
			}
		}
		_x+=boxSize*2
		noteDirection++
	}
	_y+=boxSize*2
	beat+=zoom
}