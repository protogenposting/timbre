/// @description Insert description here
// You can write your code in this editor

var _x=128
var _y=room_height/2 - 32

var i=0

draw_text(room_width/2,_y-128,"press any button to the beat, start whenever")
draw_text(room_width/2,_y-128-64,string(offsets))
repeat(4)
{
	draw_sprite(spr_easy,image_index,_x,_y)
	if(i==currentBeat&&beatTimer>0)
	{
		draw_sprite(spr_expert,image_index,_x,_y)
	}
	_x+=256
	i++
}