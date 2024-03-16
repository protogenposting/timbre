/// @description Insert description here
// You can write your code in this editor

draw_set_font(fn_font)

draw_set_halign(fa_center)
for(var i=0;i<array_length(button);i++)
{
	var size=1
	var sizeX=button[i].size.x/2
	var sizeY=button[i].size.y/2
	if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),button[i].position.x-sizeX,button[i].position.y-sizeY,button[i].position.x+sizeX,button[i].position.y+sizeY))
	{
		size=1.3
		if(mouse_check_button_pressed(mb_left))
		{
			button[i].func()
		}
	}
	try{
		var _n=button[i].name
		draw_rectangle_color(button[i].position.x-sizeX*button[i].sizeMod,button[i].position.y-sizeY*button[i].sizeMod,
		button[i].position.x+sizeX*button[i].sizeMod,button[i].position.y+sizeY*button[i].sizeMod,c_black,c_black,
		c_black,c_black,false)
		draw_rectangle(button[i].position.x-sizeX*button[i].sizeMod,button[i].position.y-sizeY*button[i].sizeMod,
		button[i].position.x+sizeX*button[i].sizeMod,button[i].position.y+sizeY*button[i].sizeMod,true)
		draw_text(button[i].position.x,button[i].position.y,button[i].name)
	}
	catch(e)
	{
		draw_sprite_ext(button[i].sprite,0,button[i].position.x,button[i].position.y,
		button[i].sizeMod,button[i].sizeMod,0,c_white,1)
	}
	if(i!=1||selectedLevel!=-4)
	{
		button[i].sizeMod-=(button[i].sizeMod-size)/10
	}
}

if(selectedLevel!=-4)
{
	var _x=room_width - 512 + 32
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
	_x=room_width - 512 + 32
	_y=32
	draw_text(_x+256-32,_y+32,global.levels[selectedLevel].name)
	_y+=128
	draw_sprite(difficulties[global.levels[selectedLevel].difficulty].sprite,image_index,_x+256-32,_y)
	_y+=32
	draw_text(_x+256-32,_y+32,difficulties[global.levels[selectedLevel].difficulty].name)
}