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
	var _x=room_width/2 - (sprite_get_number(spr_logo)/2)*96
	for(var i=0;i<sprite_get_number(spr_logo);i++)
	{
		draw_sprite(spr_logo,i,_x,logoPositionY+sin((current_time/1000)+(i/4))*32)
		_x+=96
	}
}


draw_buttons()