/// @description Insert description here
// You can write your code in this editor

var _x=treeLine.x-512
repeat(5)
{
	draw_sprite(spr_treeline,0,_x,treeLine.y)
	_x+=512
}

draw_sprite(spr_sun,0,room_width/2,-128)
draw_sprite(spr_dancc,currentShroomPose,gooberLocation.x,gooberLocation.y)