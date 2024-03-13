/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(audio!=-4&&audio_is_playing(songLoaded))
{
	draw_rectangle(0,0,room_width*(audio_sound_get_track_position(audio)/audio_sound_length(audio)),32,false)
	draw_text(room_width/2,64,"playing song")
}

var beatLength=60/bpm

var _x=512+256
var _y=32
var boxSize=20
if(audio!=-4&&audio_is_playing(songLoaded))
{
	var relativeBeat=((currentFracBeat)-startingBeat)*2
	if(currentFracBeat>startingBeat+17*zoom)
	{
		startingBeat+=16*zoom
	}
	draw_line(_x,_y+boxSize*relativeBeat-boxSize,_x+boxSize*9,_y+boxSize*relativeBeat-boxSize)
}

var beat=startingBeat
repeat(16)
{
	var notesInBeat=[]
	for(var i=0;i<array_length(notes);i++)
	{
		if(notes[i].beat>=beat&&notes[i].beat<beat+1)
		{
			array_push(notesInBeat,notes[i].beat)
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
		}
		draw_sprite_ext(spr_reverse_arrow,0,_x,_y,0.5,0.5,noteDirection*90,c_white,1)
		draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,true)
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize))
		{
			if(mouse_check_button_pressed(mb_left))
			{
				if(noteOnBeat==-1)
				{
					show_message(notesInBeat)
					array_push(notes,create_note(beat,noteTypes.turn,noteDirection,false))
				}
				else
				{
					
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
		draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,true)
		_x+=boxSize*2
		noteDirection++
	}
	_y+=boxSize*2
	beat++
}