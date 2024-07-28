/// @description Insert description here
// You can write your code in this editor
var _delta=delta_time/10000

timeLeft-=_delta

x+=moveDirection.x*_delta

y+=moveDirection.y*_delta

if(timeLeft<=0)
{
	instance_destroy()
}