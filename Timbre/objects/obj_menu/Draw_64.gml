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
draw_buttons()