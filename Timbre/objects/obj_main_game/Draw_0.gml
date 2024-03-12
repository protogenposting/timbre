/// @description Insert description here
// You can write your code in this editor


for(var i=0;i<array_length(points)-1;i++)
{
	draw_line(points[i].x,points[i].y,points[i+1].x,points[i+1].y)
	for(var o=0; o<array_length(notes);o++)
	{
		if(notes[o].beat>points[i].beat&&notes[o].beat<points[i+1].beat)
		{
			var percentage=(points[i+1].beat-notes[o].beat)/points[i].beat
			var dist=point_between_points(points[i].x,points[i].y,points[i+1].x,points[i+1].y,percentage)
			draw_circle(dist.x,dist.y,16,true)
			show_debug_message(i)
		}
	}
	draw_text(points[i].x,points[i].y-16,string(points[i].beat))
}
var nextBeatPercentage=(currentFracBeat-points[currentPoint].beat)/(points[currentPoint+1].beat-points[currentPoint].beat)
if(nextBeatPercentage>=1)
{
	currentPoint+=1
}
if(nextBeatPercentage>1||nextBeatPercentage<=0)
{
	nextBeatPercentage=0
}
var playerPoint=point_between_points(points[currentPoint].x,points[currentPoint].y,points[currentPoint+1].x,points[currentPoint+1].y,nextBeatPercentage)
camera_set_view_pos(view_camera[0],playerPoint.x-1366/2,playerPoint.y-768/2)
var _currentX=playerPoint.x
var _currentY=playerPoint.y
draw_circle(_currentX,_currentY,32,false)