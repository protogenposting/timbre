/// @description Insert description here
// You can write your code in this editor

for(var i=0;i<array_length(button);i++)
{
	var size=1
	var sizeX=button[i].size.x
	var sizeY=button[i].size.y
	if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),button[i].position.x-sizeX,button[i].position.y-sizeY,button[i].position.x+sizeX,button[i].position.y+sizeY))
	{
		size=1.3
		if(mouse_check_button_pressed(mb_left))
		{
			button[i].func()
		}
	}
	draw_sprite_ext(button[i].sprite,0,button[i].position.x,button[i].position.y,button[i].sizeMod,button[i].sizeMod,0,c_white,1)
	button[i].sizeMod-=(button[i].sizeMod-size)/10
}