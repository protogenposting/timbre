// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function in_out_between_points(x1,y1,x2,y2,percentage)
{
	percentage=clamp(percentage,0,1)
	percentage=sin((percentage)*pi)
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	
	return {x: x1+_x,y: y1+_y}
}
function move_smooth_between_points(x1,y1,x2,y2,percentage)
{
	percentage=clamp(percentage,0,1)
	percentage=sin((percentage/2)*pi)
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	
	return {x: x1+_x,y: y1+_y}
}

function point_between_points(x1,y1,x2,y2,percentage)
{
	percentage=clamp(percentage,0,1)
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	
	return {x: x1+_x,y: y1+_y}
}