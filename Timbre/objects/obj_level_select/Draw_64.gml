/// @description Insert description here
// You can write your code in this editor

draw_set_font(fn_font)

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

for(var i=0;i<array_length(button);i++)
{
	var size=1
	var sizeX=button[i].size.x/2
	var sizeY=button[i].size.y/2
	var buttonPosOffset=0
	if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),button[i].position.x-sizeX,button[i].position.y-sizeY,button[i].position.x+sizeX,button[i].position.y+sizeY))
	{
		size=1.3
		buttonPosOffset=2
		if(mouse_check_button_pressed(mb_left))
		{
			button[i].func()
		}
	}
	try{
		var _n=button[i].name
		var _col=c_black
		if(variable_struct_exists(button[i],"color"))
		{
			_col=button[i].color
		}
		var offset=5
		draw_rectangle_color(button[i].position.x-sizeX*button[i].sizeMod+offset,
		button[i].position.y-sizeY*button[i].sizeMod+offset,
		button[i].position.x+sizeX*button[i].sizeMod+offset,
		button[i].position.y+sizeY*button[i].sizeMod+offset,
		c_dkgray,c_dkgray,c_dkgray,c_dkgray,false)
		buttonPosOffset+=(mouse_check_button(mb_left)&&buttonPosOffset>0)*3
		draw_rectangle_color(button[i].position.x-sizeX*button[i].sizeMod+buttonPosOffset,
		button[i].position.y-sizeY*button[i].sizeMod+buttonPosOffset,
		button[i].position.x+sizeX*button[i].sizeMod+buttonPosOffset,
		button[i].position.y+sizeY*button[i].sizeMod+buttonPosOffset,
		_col,_col,_col,_col,false)
		var stringSize=1
		if(string_width(string_upper(button[i].name))>sizeX*2&&string_pos(" ",string_upper(button[i].name))==0)
		{
			stringSize=0.75
		}
		draw_text_ext_transformed(button[i].position.x,button[i].position.y,string_upper(button[i].name),16,sizeX*2,stringSize,stringSize,0)
		if(variable_struct_exists(button[i],"id"))
		{
			draw_sprite(difficulties[global.levels[button[i].id].difficulty].sprite,image_index,button[i].position.x+sizeX+32,button[i].position.y)
		}
	}
	catch(e)
	{
		draw_sprite_ext(button[i].sprite,0,button[i].position.x,button[i].position.y,
		button[i].sizeMod,button[i].sizeMod,0,c_white,1)
	}
	button[i].sizeMod=1
}

if(selectedLevel!=-4)
{
	draw_set_font(fn_font_big)
	draw_set_color(c_black)
	var _startX=room_width - 512 + 32
	if(moreStats)
	{
		_startX-=256+128
	}
	var _x=_startX
	var _y=32
	repeat(abs(_x-room_width)/64 + 1)
	{
		_y=0
		repeat(abs(_y-room_height)/64 +1)
		{
			draw_sprite(spr_grass,image_index,_x,_y)
			_y+=64
		}
		_x+=64
	}
	_x=_startX
	_y=32
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
	draw_text(_x+256-32,_y+32,global.levels[selectedLevel].highScore)
	_y+=128
	draw_text(_x+256-32,_y+32,"Rank:")
	_y+=32
	draw_text(_x+256-32,_y+32,global.levels[selectedLevel].rank)
	_y+=128
	
	var _size=1
	
	if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-128+256-32,_y-64,_x+128+256-32,_y+64))
	{
		_size=1.2
		if(mouse_check_button_pressed(mb_left))
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
	
	draw_text(_x+256-32,_y,string(songLength) + " Seconds")
	
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