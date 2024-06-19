
var currentPoint=(playerProgress>0.5)

_nextPoint=point_between_points(points[currentPoint].x,points[currentPoint].y,
points[currentPoint+1].x,points[currentPoint+1].y,(playerProgress*2)-(playerProgress>0.5))

draw_sprite_ext(spr_reverse_arrow,image_index,points[1].x,points[1].y,1,1,270,c_white,playerProgress<=0.5)

_currentX=_nextPoint.x
_currentY=_nextPoint.y
currentDirection=(playerProgress>0.5)*270

draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,1,currentDirection+90,c_white,1)
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,-1,currentDirection-90,c_white,1)
draw_sprite_ext(spr_player,image_index,_currentX,_currentY,1,1,currentDirection,c_white,1)

var _x=128
var _y=128
for(var i=0;i<array_length(settings);i++)
{
	var _buttonSizeX=128*settings[i].size
	var _buttonSizeY=64*settings[i].size
	var _selected=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),
	_x-_buttonSizeX/2,_y-_buttonSizeY/2,_x+_buttonSizeX/2,_y+_buttonSizeY/2)
	
	if(_selected)
	{
		settings[i].size-=(settings[i].size-1.2)/5
		if(settings[i].type==settingTypes.toggle)
		{
			
		}
	}
	
	draw_rectangle(_x-_buttonSizeX/2,_y-_buttonSizeY/2,_x+_buttonSizeX/2,_y+_buttonSizeY/2,
	false)
	draw_text(_x,_y,settings[i].displayName)
	settings[i].update_size()
	_y+=_buttonSizeY+5
}