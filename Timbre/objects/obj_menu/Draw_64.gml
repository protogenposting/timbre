/// @description Insert description here
// You can write your code in this editor

draw_set_font(fn_font)

font_enable_effects(fn_font, true, {
    outlineEnable: true,
    outlineDistance: 2,
    outlineColour: c_black
});

font_enable_effects(fn_font_big, true, {
    outlineEnable: true,
    outlineDistance: 2,
    outlineColour: c_black
});

if(room==rm_menu)
{
	draw_sprite_ext(spr_logo,0,1366/2,128,0.25,0.25,logoRotation,c_white,1)
}

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
		draw_rectangle_color(button[i].position.x-sizeX*button[i].sizeMod,button[i].position.y-sizeY*button[i].sizeMod,button[i].position.x+sizeX*button[i].sizeMod,button[i].position.y+sizeY*button[i].sizeMod,c_black,c_black,c_black,c_black,false)
		draw_rectangle(button[i].position.x-sizeX*button[i].sizeMod,button[i].position.y-sizeY*button[i].sizeMod,button[i].position.x+sizeX*button[i].sizeMod,button[i].position.y+sizeY*button[i].sizeMod,true)
		draw_text(button[i].position.x,button[i].position.y,button[i].name)
	}
	catch(e)
	{
		draw_sprite_ext(button[i].sprite,0,button[i].position.x,button[i].position.y,button[i].sizeMod,button[i].sizeMod,0,c_white,1)
	}
	button[i].sizeMod-=(button[i].sizeMod-size)/10
}