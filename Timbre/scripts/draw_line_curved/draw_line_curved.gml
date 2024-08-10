// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_line_curved(_x1,_y1,_x2,_y2,_iterations=30,_axis="y"){
	var _x=_x1
	var _y=_y1
	for(var i=0;i<_iterations;i++)
	{
		var _perIteration=1/_iterations
		
		var _per=i/_iterations
		
		var _xInc=_per*(_x2-_x1)
		
		var _yInc=_per*(_y2-_y1)
		
		var _nextX=_x+_xInc
		
		var _nextY=_y+_yInc
		
		if(_axis=="x")
		{
			_y=sin(pi*_per)
			_nextY=_y+sin(pi*(_per+_perIteration))
		}
		if(_axis=="y")
		{
			_x=sin(pi*_per)
			_nextX=_x+sin(pi*(_per+_perIteration))
		}
		
		draw_line(_x,_y,_nextX,_nextY)
		
		_x+=_xInc
		_y+=_yInc
	}
}