// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_buttons_fancy(){
	for(var i=0;i<array_length(button);i++)
	{
		var size=1
		var sizeX=button[i].size.x/2
		var sizeY=button[i].size.y/2
		var _posX=button[i].position.x
		var _posY=button[i].position.y - yOffset
		var buttonPosOffset=0
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_posX-sizeX,_posY-sizeY,_posX+sizeX,_posY+sizeY))
		{
			size=1.3
			buttonPosOffset=2
			if(global.pressingMouseLeft)
			{
				button[i].func()
			}
			if(mouse_check_button_pressed(mb_right))
			{
				if(variable_struct_exists(button[i],"rightClickFunc"))
				{
					button[i].rightClickFunc()
				}
			}
		}
		try{
			draw_set_alpha(0.3)
			var _n=button[i].name
			var _col=c_aqua
			if(variable_struct_exists(button[i],"color"))
			{
				_col=button[i].color
			}
			var offset=5
			draw_rectangle_color(_posX-sizeX*button[i].sizeMod+offset,
			_posY-sizeY*button[i].sizeMod+offset,
			_posX+sizeX*button[i].sizeMod+offset,
			_posY+sizeY*button[i].sizeMod+offset,
			c_dkgray,c_dkgray,c_dkgray,c_dkgray,false)
			buttonPosOffset+=(mouse_check_button(mb_left)&&buttonPosOffset>0)*3
			draw_rectangle_color(_posX-sizeX*button[i].sizeMod+buttonPosOffset,
			_posY-sizeY*button[i].sizeMod+buttonPosOffset,
			_posX+sizeX*button[i].sizeMod+buttonPosOffset,
			_posY+sizeY*button[i].sizeMod+buttonPosOffset,
			_col,_col,_col,_col,false)
			var stringSize=1
			if(string_width(string_upper(button[i].name))>sizeX*2&&string_pos(" ",string_upper(button[i].name))==0)
			{
				stringSize=0.75
			}
			draw_set_alpha(1)
			draw_text_ext_transformed(_posX,_posY,string_upper(button[i].name),16,sizeX*2,stringSize,stringSize,0)
			if(variable_struct_exists(button[i],"id"))
			{
				draw_sprite(difficulties[global.levels[button[i].id].difficulty].sprite,image_index,_posX+sizeX+32,_posY)
			}
		}
		catch(e)
		{
			draw_sprite_ext(button[i].sprite,0,_posX,_posY,
			button[i].sizeMod,button[i].sizeMod,0,c_white,1)
		}
		button[i].sizeMod=1
	}
}