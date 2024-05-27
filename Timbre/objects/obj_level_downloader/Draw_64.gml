/// @description Insert description here
// You can write your code in this editor

draw_buttons()

if(!loading)
{
	var _x=room_width/2 - 256
	var _y=128+scrollY
	var _boxSizeX=64
	var _boxSizeY=32
	var _maxBoxSize=0
	for(var i=0;i<array_length(levels);i++)
	{
		_maxBoxSize=max(_maxBoxSize,_boxSizeX)
		_boxSizeX=max(string_width(levels[i].title)/2 +5,64)
		_boxSizeY=max(string_height(levels[i].title)/2 +5,32)
		var _size=0
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x-_boxSizeX,_y-_boxSizeY,_x+_boxSizeX,_y+_boxSizeY))
		{
			_size=3
			if(mouse_check_button_pressed(mb_left))
			{
				selectedLevel=i
			}
		}
		draw_rectangle(_x-_boxSizeX-_size,_y-_boxSizeY-_size,_x+_boxSizeX+_size,_y+_boxSizeY+_size,false)
		draw_text(_x,_y,levels[i].title)
		_y+=_boxSizeY*2+5
	}
	
	if(_y<room_height-256)
	{
		scrollYSpeed=0
		scrollY++
	}
	if(array_length(levels)==0)
	{
		_x=room_width/2
		_y=room_height/2
		draw_text(_x,_y,"No results :(")
	}
	if(selectedLevel>=0)
	{
		_x+=_maxBoxSize+5
		var _halfPoint=_x+(room_width-_x)/2
		draw_rectangle(_x,0,room_width,room_height,false)
		draw_text(_halfPoint,64,levels[selectedLevel].title)
		draw_text(_halfPoint,64+32,"Song by "+levels[selectedLevel].artist)
		draw_text(_halfPoint,128,"Charted by "+levels[selectedLevel].creator_username)
	}
}
else
{
	var _x=room_width/2
	var _y=room_height/2
	draw_sprite_ext(spr_quaver_logo,0,_x,_y,1,1,sin(loadTime/100)*360,c_white,1)
}