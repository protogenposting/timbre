// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_axis_pressed(_device,_axis,_side){
	if(sign(gamepad_axis_value(_device,_axis))!=sign(obj_global_code.axisLast[_device][_axis])&&
	sign(gamepad_axis_value(_device,_axis))==_side)
	{
		return true
	}
	return false
}