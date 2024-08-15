/// @description Insert description here
// You can write your code in this editor

draw_buttons()

var _x=room_width/1.3
var _y=64

for(var i=0; i<array_length(players); i++)
{
	draw_rectangle(_x-64,_y-32,_x+64,_y+32,false)
	draw_text(_x,_y,players[i].name)
}