// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_line_curved(_x1,_y1,_x2,_y2,_iterations=10,_axis="y"){
	var _x=_x1
	var _y=_y1
	for(var i=0;i<_iterations;i++)
	{
		var _perIteration=1/_iterations
		
		var _per=i/_iterations
		
		var _xDist=(_x2-_x1)
		
		var _xInc=_perIteration*_xDist
		
		var _yDist=(_y2-_y1)
		
		var _yInc=_perIteration*_yDist
		
		var _nextX=_x+_xInc
		
		var _nextY=_y+_yInc
		
		if(_axis=="x")
		{
			_y=_y1+(sin(pi/2*_per)*_yDist)
			_nextY=_y1+sin(pi/2*(_per+_perIteration))*_yDist
		}
		if(_axis=="y")
		{
			_x=_x1+(sin(pi/2*_per)*_xDist)
			_nextX=_x1+sin(pi/2*(_per+_perIteration))*_xDist
		}
		
		if(_y>0&&_y<1366)
		{	
			draw_line(_x,_y,_nextX,_nextY)
		}
		
		_x+=_xInc
		_y+=_yInc
	}
}