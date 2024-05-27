/// @description Insert description here
// You can write your code in this editor
if(mouse_wheel_up())
{
	scrollYSpeed+=scrollSpeed
	scrollReduceTime=10
}
if(mouse_wheel_down())
{
	scrollYSpeed-=scrollSpeed
	scrollReduceTime=10
}

if(scrollY+scrollYSpeed<0)
{
	scrollYSpeed=0
}

scrollY+=scrollYSpeed

scrollReduceTime--

if(scrollReduceTime<0)
{
	scrollYSpeed-=(scrollYSpeed)/15
}

loadTime++