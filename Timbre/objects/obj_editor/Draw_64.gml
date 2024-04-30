/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

notesToDraw=notes

if(currentDifficulty==1)
{
	notesToDraw=notesHard
}
if(currentDifficulty==2)
{
	notesToDraw=notesEasy
}

if(audio!=-4&&audio_is_playing(songLoaded))
{
	draw_rectangle(0,0,room_width*(audio_sound_get_track_position(audio)/audio_sound_length(audio)),32,false)
}
else
{
	for(var i=0;i<array_length(notesToDraw);i++)
	{
		notesToDraw[i].wasHit=false
	}
}

var beatLength=60/bpm

var _x=512+256
var _y=32
var boxSize=20

var relativeBeat=((songMilliseconds/1000)/beatLength)-zoom

var beat=startingBeat
repeat(16)
{
	draw_set_color(c_white)
	if(beat>=relativeBeat&&beat<relativeBeat+zoom)
	{
		draw_set_color(c_green)
	}
	_x=512+256
	if(currentMenu==0)
	{
		draw_text(_x-64,_y,string(beat))
		var notesInBeat=[]
		var notesInBeatEquivelants=[]
		for(var i=0;i<array_length(notesToDraw);i++)
		{
			if(notesToDraw[i].beat>=beat&&notesToDraw[i].beat<beat+1)
			{
				array_push(notesInBeat,notesToDraw[i])
				array_push(notesInBeatEquivelants,i)
			}
		}
		//turns
		var _note=0
		repeat(array_length(noteSounds))
		{
			var noteDirection=0
			repeat(4)
			{
				var noteOnBeat=note_on_beat(notesInBeat,beat,_note,noteDirection)
				if(noteOnBeat!=-1)
				{
					draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,false)
					try{
						if(songMilliseconds/1000>=beat*beatLength&&!notesToDraw[notesInBeatEquivelants[noteOnBeat]].wasHit&&audio!=-4&&audio_is_playing(songLoaded))
						{
							audio_play_sound(noteSounds[_note],1000,false)
							notesToDraw[notesInBeatEquivelants[noteOnBeat]].wasHit=true
						}
					}
					catch(e)
					{
				
					}
				}
				draw_sprite_ext(noteSprites[_note],0,_x,_y,0.3,0.3,noteDirection*90,c_white,1)
				draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,true)
				if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize))
				{
					if(mouse_check_button_pressed(mb_left))
					{
						if(noteOnBeat==-1)
						{
							array_push(notesToDraw,create_note(beat,_note,noteDirection,false))
						}
						else
						{
							array_delete(notesToDraw,notesInBeatEquivelants[noteOnBeat],1)
						}
					}
				}
				_x+=boxSize*2
				noteDirection++
			}
			_x+=boxSize
			_note++
		}
		_y+=boxSize*2
		beat+=zoom
	}
	else if(currentMenu==1)
	{		
		_x+=256
		draw_text(_x-64,_y,string(beat))
		draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,true)
		
		var _onBeat=-4
		
		for(var i=0;i<array_length(lyrics);i++)
		{
			if(beat==lyrics[i].beat)
			{
				draw_rectangle(_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize,false)
				_onBeat=i
				break;
			}
		}
		if(_onBeat>=0)
		{
			draw_text(_x+boxSize+64,_y,lyrics[_onBeat].text)
		}
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-boxSize,_y-boxSize,_x+boxSize,_y+boxSize))
		{
			if(mouse_check_button_pressed(mb_left))
			{
				if(_onBeat>=0)
				{
					array_delete(lyrics,_onBeat,1)
					break;
				}
				else
				{
					array_push(lyrics,{beat: beat,text: get_string("","put text here")})
				}
			}
			if(mouse_check_button_pressed(mb_right))
			{
				if(_onBeat>=0)
				{
					lyrics[_onBeat].text=get_string("",lyrics[_onBeat].text)
				}
			}
		}
		
		_y+=boxSize*2
		beat+=zoom
	}
}

draw_text(room_width/2,64,"use UP/DOWN to change the current chart type")

difficultyAlpha-=0.01

draw_text_color(room_width/2,32,"Current Chart Style: "+get_chart_style(currentDifficulty),c_white,c_white,c_white,c_white,1)