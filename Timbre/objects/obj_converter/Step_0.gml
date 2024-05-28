/// @description Insert description here
// You can write your code in this editor
if(mouse_wheel_down())
{
	yOffsetSpeed=yOffsetMaxSpeed
}
if(mouse_wheel_up())
{
	yOffsetSpeed=-yOffsetMaxSpeed
}

yOffsetSpeed-=sign(yOffsetSpeed)

yOffset+=yOffsetSpeed

yOffset=clamp(yOffset,0,array_last(button).position.y-256)