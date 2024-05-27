/// @description Insert description here
// You can write your code in this editor

draw_buttons()

var _x=room_width/2
var _y=128
var _boxSizeX=64
var _boxSizeY=32
for(var i=0;i<array_length(levels);i++)
{
	_boxSizeX=max(string_width(levels[i].title)/2 +5,64)
	_boxSizeY=max(string_height(levels[i].title)/2 +5,32)
	draw_rectangle(_x-_boxSizeX,_y-_boxSizeY,_x+_boxSizeX,_y+_boxSizeY,false)
	draw_text(_x,_y,levels[i].title)
	_y+=_boxSizeY*2+5
}