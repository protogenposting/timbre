/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_right)
draw_set_valign(fa_top)

draw_text(room_width,0,"Current Playlist: "+global.playlists[global.currentPlaylist].name)

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

songSpeedAlpha-=0.01

/*
 YO MOVE MOVESPEED CHANGING TO A SLIDER	
if(_hAxis!=0&&global.moveSpeed+_hAxis*0.05>0)
{
	global.moveSpeed+=(_hAxis)*0.05
	songSpeedAlpha=1
}*/

draw_buttons_fancy()

if(alarm[1]>0||array_length(global.levels)<=0)
{
	exit;
}

//draw the WHEEL OF LEVELS

var _hAxis=keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)

var _levels=get_playlist_levels(global.currentPlaylist)

if(_hAxis!=0&&!readyUp)
{
	previousWheelDirection=_hAxis
	wheelProgress+=_hAxis
	if(wheelProgress<0)
	{
		wheelProgress=array_length(_levels)-1
	}
	if(wheelProgress>array_length(_levels)-1)
	{
		wheelProgress=0
	}
	wheelRotationProgress=0
	
	initialize_level(wheelProgress)
	
	readyUp=false
}
else if(_hAxis!=0&&readyUp)
{
	global.gamemode+=_hAxis
	if(global.gamemode>=array_length(global.gamemodes))
	{
		global.gamemode=0
	}
	if(global.gamemode<0)
	{
		global.gamemode=array_length(global.gamemodes)-1
	}
}

wheelRotationProgress+=0.1

var _displayedLevels=min(5,array_length(global.levels))

var i=wheelProgress-floor(_displayedLevels/2)

var _coverDistance=400

var _sizeMod=1

var _progress=move_smooth_between_points(previousWheelDirection,0,0,0,wheelRotationProgress).x

var _readyProgress=move_smooth_between_points(0,0,1,0,readyProgress).x

var _x=camera_get_view_width(view_camera[0])/2 - _coverDistance * floor(_displayedLevels/2)

if(i<0)
{
	i=array_length(_levels)+i
}

if(readyProgress<1&&readyUp)
{
	readyProgress+=0.04
}
if(readyProgress>0&&!readyUp)
{
	readyProgress-=0.04
}

draw_set_font(fn_font_big)
draw_set_color(c_white)
repeat(_displayedLevels)
{
	var _size=_sizeMod-abs(sign(i-wheelProgress))/2
	var _rotation=0
	var _isSelected=i==wheelProgress
	var _y=camera_get_view_height(view_camera[0])/2 - _readyProgress*256
	
	if(_isSelected)
	{
		if(readyUp)
		{
			var o=0
			
			var _difficultyDistance=76*_readyProgress
			
			var _xMod=_x-_difficultyDistance
			
			var _yMod=_y+256*_readyProgress
			
			draw_text(_x,_yMod-64,"Choose a difficulty")
			
			repeat(3)
			{
				if(!_levels[i].availableDifficulties[o])
				{
					_xMod+=_difficultyDistance
					o++
					continue;
				}
				var _selected=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),
				_xMod-32,_yMod-32,_xMod+32,_yMod+32)
				
				var _difficulty=ds_map_find_value(difflicultySelection,o)
				
				draw_sprite(_difficulty.icon,_selected,_xMod,_yMod)
				
				try{
					var _id=_levels[i].rank[global.gamemode][_difficulty.equivelant]
				}
				catch(e)
				{
					_levels[i].rank=array_create_2D(10,3,"")
				}
				
				var _id=get_rank_id_string(_levels[i].rank[global.gamemode][_difficulty.equivelant])
				
				if(_id!=array_length(global.ranks)-1)
				{
					draw_sprite(global.ranks[_id].icon,0,_xMod,_yMod+64)
				
					if(string_count("+",global.ranks[_id].name))
					{
						draw_sprite_ext(spr_rank_plus,image_index,
						_xMod+64,_yMod+64,1,1,_rotation,c_white,1)
					}
					if(string_count("-",global.ranks[_id].name))
					{
						draw_sprite_ext(spr_rank_minus,image_index,
						_xMod+64,_yMod+64,1,1,_rotation,c_white,1)
					}
				}
				
				if(_selected)
				{
					draw_text(_x,_yMod+128,_difficulty.name)
					if(global.pressingMouseLeft)
					{
						global.currentDifficulty=_difficulty.equivelant
						start_level()
					}
				}
				_xMod+=_difficultyDistance
				o++
			}
			
			_yMod=room_height+256-256*_readyProgress
			
			draw_sprite(spr_mode_background,0,_x+256,_yMod-128-32)
			
			draw_sprite(global.gamemodes[global.gamemode].sprite,0,_x+256,_yMod-128-32)
			
			draw_text(_x+256,_yMod-64,"Change gamemode with arrow keys")
			
			//mod stuff
			var _modGridWidth=2
			_xMod=96
			_yMod=room_height+256-(512)*_readyProgress
			
			for(var z=0;z<array_length(global.difficultyMods);z++)
			{
				var _selected=point_in_rectangle(device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				_xMod-64,_yMod-64,_xMod+64,_yMod+64)
				
				var _color=c_red
				
				if(global.difficultyMods[z].enabled)
				{
					_color=c_aqua
				}
				
				draw_sprite_ext(spr_mode_background,_selected,_xMod,_yMod,1,1,0,_color,1)
				draw_sprite(global.difficultyMods[z].sprite,0,_xMod,_yMod)
				
				if(_selected)
				{
					draw_text(96+128,room_height-256-128,global.difficultyMods[z].description)
					if(global.pressingMouseLeft)
					{
						global.difficultyMods[z].enabled=!global.difficultyMods[z].enabled
					}
				}
				
				_xMod+=128
				if(z!=0&&frac(z+1/_modGridWidth)==0)
				{
					_xMod=96
					_yMod+=128
				}
			}
			
		}
		else
		{
			draw_text(_x,_y+256,"Press Space or Enter to select")
		}
		if(mouse_check_button_pressed(mb_right))
		{
			if(!show_question("delete "+_levels[i].name+"?"))
			{
				break;
			}
			array_delete(global.levels,i,1)
			with(obj_level_select)
			{
				reset_buttons()
			}
			exit;
		}
		_y+=sin(current_time/1000)*16
		_rotation=sin(current_time/5000)*5
	}
	
	draw_sprite_ext(_levels[i].cover,0,_x+ _progress * _coverDistance,_y,_size,_size,_rotation,c_white,1)
	
	draw_sprite_ext(spr_cover_border,0,_x+ _progress * _coverDistance,_y,_size,_size,_rotation,c_white,1)
	
	var _oldY=_y
	
	_y=camera_get_view_height(view_camera[0])/2 - _readyProgress*256
	
	if(_isSelected)
	{
		draw_text(_x,_y-200,_levels[i].name)

		try{
			draw_text_ext(_x,_y-200+64,"By " + _levels[i].artist,24,500)
		}
		catch(e)
		{
			_levels[i].artist="???"
		}
		var _xOffset=lengthdir_x(128,_rotation-45)
		var _yOffset=lengthdir_y(128,_rotation-45)
		draw_sprite_ext(difficulties[_levels[i].difficulty].sprite,image_index,
		_x+_xOffset,_oldY+_yOffset,1,1,_rotation,c_white,1)
		_xOffset=lengthdir_x(128,_rotation-45+180)
		_yOffset=lengthdir_y(128,_rotation-45+180)
		
		try{
			var _id=_levels[i].rank[global.gamemode][0]
		}
		catch(e)
		{
			_levels[i].rank=array_create_2D(10,3,"")
		}
		
		var rankID=get_rank_id_string(_levels[i].rank[global.gamemode][0])
		if(rankID!=array_length(global.ranks)-1)
		{
			draw_sprite_ext(global.ranks[rankID].icon,image_index,
			_x+_xOffset,_oldY+_yOffset,1,1,_rotation,c_white,1)
		
			if(string_count("+",global.ranks[rankID].name))
			{
				draw_sprite_ext(spr_rank_plus,image_index,
				_x+_xOffset+64,_oldY+_yOffset,1,1,_rotation,c_white,1)
			}
			if(string_count("-",global.ranks[rankID].name))
			{
				draw_sprite_ext(spr_rank_minus,image_index,
				_x+_xOffset+64,_oldY+_yOffset,1,1,_rotation,c_white,1)
			}
		}
		
		if(keyboard_check_pressed(vk_space)||keyboard_check_pressed(vk_enter))
		{
			readyUp=!readyUp
			audio_play_sound(snd_beat,1000,false)
		}
	}
	
	_x+=_coverDistance
	i++
	
	if(i>=array_length(_levels))
	{
		i=0
	}
}
draw_set_font(fn_font)

draw_set_font(fn_font_big)
draw_text_transformed_color(1366/2,768/2,"Song Speed: "+string(global.moveSpeed),3,3,0,c_white,c_white,c_white,c_white,songSpeedAlpha)
draw_set_font(fn_font)
