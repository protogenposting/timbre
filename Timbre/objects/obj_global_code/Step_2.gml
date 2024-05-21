/// @description Insert description here
// You can write your code in this editor
for(var i=0;i<gamepad_get_device_count();i++)
{
	for(var o=0;o<gamepad_axis_count(i);o++)
	{
		axisLast[i][o]=gamepad_axis_value(i,o)
	}
}