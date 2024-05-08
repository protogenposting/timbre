/// @description Insert description here
// You can write your code in this editor
var beatLength=60/bpm

var _currentBeat=(songMilliseconds/1000)/beatLength

var _nextNote=-4

var _beatDistance=0

for(var i=0;i<array_length(backgroundPoints)-1;i++)
{
	if(backgroundPoints[i].beat<=_currentBeat)
	{
		_beatDistance=(_currentBeat-backgroundPoints[i].beat)/(backgroundPoints[i+1].beat-backgroundPoints[i].beat)
		
		_nextNote=i
		continue;
	}
	var _spr=spr_reverse_arrow
	if(backgroundPoints[i].isSpider)
	{
		_spr=spr_spider_idle
	}
	draw_sprite_ext(_spr,0,backgroundPoints[i].x,backgroundPoints[i].y,1,1,
	backgroundPoints[i].direction,c_white,0.5)
}

if(_nextNote==-4)
{
	exit;
}

show_debug_message(_nextNote)

var _camPos=point_between_points(backgroundPoints[_nextNote].x,backgroundPoints[_nextNote].y,
backgroundPoints[_nextNote+1].x,backgroundPoints[_nextNote+1].y,_beatDistance)

/*if(backgroundPoints[_nextNote].isSpider)
{
	var _spiderOffset=in_out_between_points(backgroundPoints[_nextNote].x,backgroundPoints[_nextNote].y,
	backgroundPoints[_nextNote].x-lengthdir_x(gridSize*_beatDistance,backgroundPoints[_nextNote].direction),
	backgroundPoints[_nextNote].y-lengthdir_y(gridSize*_beatDistance,backgroundPoints[_nextNote].direction),
	_beatDistance)
	_camPos.x+=_spiderOffset.x
	_camPos.y+=_spiderOffset.y
}*/

camera_set_view_pos(view_camera[0],_camPos.x-(1366/2),_camPos.y-(768/2))