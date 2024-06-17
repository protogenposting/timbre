/// @description Insert description here
// You can write your code in this editor

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

songSpeedAlpha-=0.01

var _hAxis=keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)

if(_hAxis!=0&&global.moveSpeed+_hAxis*0.05>0)
{
	global.moveSpeed+=(_hAxis)*0.05
	songSpeedAlpha=1
}

draw_buttons_fancy()

//draw the WHEEL OF LEVELS

var _levels=global.levels

var i=wheelProgress-1

if(i<0)
{
	i=array_length(_levels)-1
}

repeat(3)
{
	
	i++
	if(i>=array_length(_levels))
	{
		i=0
	}
}

if(selectedLevel!=-4)
{
	draw_set_font(fn_font_big)
	draw_set_color(c_white)
	
	var _startX=room_width - 512 + 64 - point_between_points(0,0,256+128,0,percentageBetweenPoints).x
	
	var _startY=0
	
	var _x=_startX
	
	var _y=_startY
	
	repeat((abs(_x-room_width)/64 + 1) + 1)
	{
		_y=_startY
		repeat(abs(_y-room_height)/64 +1)
		{
			draw_sprite(grass,flowerIndex,_x,_y)
			_y+=64
		}
		_x+=64
	}
	_x=_startX
	_y=_startY+32
	
	var _size=32
	
	_x-=64
	
	_y+=128
	
	var index=0
	
	if(global.currentDifficulty==2)
	{
		index=1
		draw_text(_x-128,_y,"Chart Style:")
	}
	
	if(!button[selectedLevel+3].availableDifficulties[2])
	{
		index=2
		if(global.currentDifficulty==2)
		{
			global.currentDifficulty=0
		}
	}
	else
	{
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-_size,_y-_size,_x+_size,_y+_size))
		{
			index=1
			if(global.pressingMouseLeft)
			{
				global.currentDifficulty=2
				var selected=obj_level_select.selectedLevel+3
				obj_level_select.selectedLevel=-4
				button[selected].func()
			}
		}
	}
	
	draw_sprite(spr_difficulty_button_easy,index,_x,_y)
	
	_y+=64
	
	index=0
	
	if(global.currentDifficulty==0)
	{
		index=1
		draw_text(_x-128,_y,"Chart Style:")
	}
	
	if(!button[selectedLevel+3].availableDifficulties[0])
	{
		index=2
		if(global.currentDifficulty==0)
		{
			global.currentDifficulty=1
		}
	}
	else
	{
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-_size,_y-_size,_x+_size,_y+_size))
		{
			index=1
			if(global.pressingMouseLeft)
			{
				global.currentDifficulty=0
				var selected=obj_level_select.selectedLevel+3
				obj_level_select.selectedLevel=-4
				button[selected].func()
			}
		}
	}
	
	draw_sprite(spr_difficulty_button_normal,index,_x,_y)
	
	_y+=64
	
	index=0
	
	if(global.currentDifficulty==1)
	{
		index=1
		draw_text(_x-128,_y,"Chart Style:")
	}
	
	if(!button[selectedLevel+3].availableDifficulties[1])
	{
		index=2
		if(global.currentDifficulty==1)
		{
			global.currentDifficulty=2
		}
	}
	else
	{
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-_size,_y-_size,_x+_size,_y+_size))
		{
			index=1
			if(global.pressingMouseLeft)
			{
				global.currentDifficulty=1
				var selected=obj_level_select.selectedLevel+3
				obj_level_select.selectedLevel=-4
				button[selected].func()
			}
		}
	}
	
	draw_sprite(spr_difficulty_button_hard,index,_x,_y)
	
	_x=_startX
	
	_y=_startY+32
	
	if(moreStats)
	{
		_x=_startX+512
		for(var i=0;i<array_length(previewNotes);i++)
		{
			function get_note_key_name(noteDirection,noteType){
				if(noteType==noteTypes.log)
				{
					if(noteDirection==noteDirections.left)
					{
						return get_key_name(global.keyboardBinds.attacking.left)
					}
					if(noteDirection==noteDirections.right)
					{
						return get_key_name(global.keyboardBinds.attacking.right)
					}
					if(noteDirection==noteDirections.up)
					{
						return get_key_name(global.keyboardBinds.attacking.up)
					}
					if(noteDirection==noteDirections.down)
					{
						return get_key_name(global.keyboardBinds.attacking.down)
					}
				}
				else
				{
					if(noteDirection==noteDirections.left)
					{
						return get_key_name(global.keyboardBinds.turning.left)
					}
					if(noteDirection==noteDirections.right)
					{
						return get_key_name(global.keyboardBinds.turning.right)
					}
					if(noteDirection==noteDirections.up)
					{
						return get_key_name(global.keyboardBinds.turning.up)
					}
					if(noteDirection==noteDirections.down)
					{
						return get_key_name(global.keyboardBinds.turning.down)
					}
				}
				return "?"
			}
			try{
				var _percentage=songMilliseconds-previewNotes[i].timeMS
				if(_percentage>0&&_percentage<1000)
				{
					var newPercentage=_percentage/1000
					var hitThisFrame=false
					if(!variable_instance_exists(previewNotes[i],"wasHitTemp")||!previewNotes[i].wasHitTemp)
					{
						hitThisFrame=true
						previewNotes[i].wasHitTemp=true
					}
					if(previewNotes[i].type==noteTypes.turn)
					{
						draw_sprite_ext(spr_reverse_arrow,image_index,_x+previewNotes[i].direction*64,_y,1-newPercentage,1-newPercentage,previewNotes[i].direction*90,c_white,1-newPercentage)
						draw_text(_x+previewNotes[i].direction*64,_y,get_note_key_name(previewNotes[i].direction,previewNotes[i].type))
						if(hitThisFrame)
						{
							audio_play_sound(snd_turn,1000,false)
							flowerIndex++
						}
					}
					if(previewNotes[i].type==noteTypes.loop)
					{
						draw_sprite_ext(spr_spider_idle,image_index,_x+previewNotes[i].direction*64,_y,1-newPercentage,1-newPercentage,previewNotes[i].direction*90,c_white,1-newPercentage)
						draw_text(_x+previewNotes[i].direction*64,_y,get_note_key_name(previewNotes[i].direction,previewNotes[i].type))
						if(hitThisFrame)
						{
							audio_play_sound(snd_turn,1000,false)
							flowerIndex++
						}
					}
					if(previewNotes[i].type==noteTypes.log)
					{
						draw_sprite_ext(spr_log,0,_x+previewNotes[i].direction*64,_y+64,1-newPercentage,1-newPercentage,previewNotes[i].direction*90,c_white,1-newPercentage)
						draw_text(_x+previewNotes[i].direction*64,_y+64,get_note_key_name(previewNotes[i].direction,previewNotes[i].type))
						if(hitThisFrame)
						{
							audio_play_sound(snd_hit_tree,1000,false)
							flowerIndex++
						}
					}
				}
			}
			catch(e)
			{
			
			}
		}
	}
	_x=_startX
	draw_text(_x+256-32,_y+32,global.levels[selectedLevel].name)
	_y+=40
	try{
		draw_text_ext(_x+256-32,_y+32,"By " + global.levels[selectedLevel].artist,24,500)
	}
	catch(e)
	{
		global.levels[selectedLevel].artist="???"
	}
	_y+=128
	draw_sprite(difficulties[global.levels[selectedLevel].difficulty].sprite,image_index,_x+256-32,_y)
	_y+=32
	draw_text(_x+256-32,_y+32,difficulties[global.levels[selectedLevel].difficulty].name)
	_y+=128
	draw_text(_x+256-32,_y+32,"High Score:")
	_y+=32
	if(!is_array(global.levels[selectedLevel].highScore))
	{
		global.levels[selectedLevel].highScore=[global.levels[selectedLevel].highScore,0,0]
	}
	draw_text(_x+256-32,_y+32,global.levels[selectedLevel].highScore[global.currentDifficulty])
	_y+=128
	draw_text(_x+256-32,_y+32,"Rank:")
	_y+=32
	if(!is_array(global.levels[selectedLevel].rank))
	{
		global.levels[selectedLevel].rank=[global.levels[selectedLevel].rank,"",""]
	}
	draw_text(_x+256-32,_y+32,global.levels[selectedLevel].rank[global.currentDifficulty])
	_y+=128
	
	var _size=1
	
	if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-128+256-32,_y-64,_x+128+256-32,_y+64))
	{
		_size=1.2
		if(global.pressingMouseLeft)
		{
			start_level()
		}
	}
	
	draw_sprite_ext(spr_start_button,0,_x+256-32,_y,_size,_size,0,c_white,1)
	
	_x+=256+128+32
	
	_y=128
	
	draw_text(_x+256-32,_y,"Average Note Distance")
	
	_y+=32
	
	draw_text(_x+256-32,_y,"(Higher is easier)")
	
	_y+=32
	
	draw_text(_x+256-32,_y,string(noteDensity))
	
	_y+=64
	
	draw_text(_x+256-32,_y,"Song Length")
	
	_y+=32
	
	draw_text(_x+256-32,_y,string(songLength/global.songSpeed) + " Seconds")
	
	_y+=64
	
	draw_text(_x+256-32,_y,"Tree to Turn Ratio")
	
	_y+=32
	
	draw_text(_x+256-32,_y,leafToTree)
	
	_y+=64
	
	draw_text(_x+256-32,_y,"Bpm")
	
	_y+=32
	
	draw_text(_x+256-32,_y,string(bpm))
	
	_y+=64
	
	draw_text(_x+256-32,_y,"Chance For a Dani D Rank")
	
	_y+=32
	
	draw_text(_x+256-32,_y,string(daniChance)+"%")
	
	_y+=64
	
	draw_set_color(c_white)
	draw_set_font(fn_font)
}

draw_set_font(fn_font_big)
draw_text_transformed_color(1366/2,768/2,"Song Speed: "+string(global.moveSpeed),3,3,0,c_white,c_white,c_white,c_white,songSpeedAlpha)
draw_set_font(fn_font)
