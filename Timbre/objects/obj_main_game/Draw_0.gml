/// @description Insert description here
// You can write your code in this editor
var positionsUsed=[]

for(var i=0;i<array_length(points)-1;i++)
{
	if(!variable_struct_exists(points[i],"frame"))
	{
		points[i].frame=0
	}
	var shouldContinue=false
	//draw_line(points[i].x,points[i].y,points[i+1].x,points[i+1].y)
	for(var o=0;o<array_length(positionsUsed)-1;o++)
	{
		if(positionsUsed[o][0]==points[i].x&&positionsUsed[o][1]==points[i].y)
		{
			shouldContinue=true
			break;
		}
	}
	if(shouldContinue)
	{
		continue;
	}
	if(!points[i].wasHit)
	{
		draw_sprite_ext(spr_reverse_arrow,points[i].frame,points[i].x,points[i].y,1,1,
		points[i].direction*90,c_white,1)
		array_push(positionsUsed,[points[i].x,points[i].y])
	}
	var timing=songMilliseconds-points[i].timeMS
	if(abs(timing)<=msWindow&&turnKey[points[i].direction]&&!points[i].wasHit||global.botPlay&&abs(songMilliseconds-points[i].timeMS)<=msWindow/4&&!points[i].wasHit)
	{
		audio_play_sound(snd_turn,1000,false)
		points[i].wasHit=true
		combo++
		totalScore+=msWindow-abs(timing)
		hitTime=1.33
		hitMessage=get_timing(timing)
	}
	if(points[i].timeMS-songMilliseconds<msWindow*4&&!points[i].wasHit)
	{
		draw_sprite_ext(spr_reverse_arrow,points[i].frame,points[i].x,points[i].y,
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),points[i].direction*90,c_white,0.5)
	}
	if(songMilliseconds>points[i].timeMS+msWindow&&!points[i].wasHit)
	{
		audio_play_sound(snd_spinout,1000,false)
		points[i].wasHit=true
		misses++
		fullCombo=false
	}
}

for(var o=0; o<array_length(notes);o++)
{
	var dir=notes[o].direction*90
	draw_sprite_ext(spr_log,notes[o].wasHit,notes[o].x,notes[o].y,1,1,dir,c_white,1)
	var timing=songMilliseconds-notes[o].timeMS
	if(abs(timing)<=msWindow&&attackKey[notes[o].direction]&&!notes[o].wasHit||global.botPlay&&abs(songMilliseconds-notes[o].timeMS)<=msWindow/4&&!notes[o].wasHit)
	{
		audio_play_sound(snd_hit_tree,1000,false)
		attackKey[notes[o].direction]=true
		notes[o].wasHit=true
		totalScore+=msWindow-abs(timing)
		combo++
		hitTime=1.33
		hitMessage=get_timing(timing)
	}
	if(songMilliseconds-notes[o].timeMS>=msWindow&&!notes[o].wasHit)
	{
		notes[o].wasHit=2
		misses++
		fullCombo=false
	}
	if(notes[o].timeMS-songMilliseconds<msWindow*4&&!notes[o].wasHit&&notes[o].timeMS-songMilliseconds>-msWindow)
	{
		draw_sprite_ext(spr_log,notes[o].wasHit,notes[o].x,notes[o].y,(((abs(songMilliseconds-notes[o].timeMS)/msWindow))+1),(((abs(songMilliseconds-notes[o].timeMS)/msWindow))+1),dir,c_white,0.5)
	}
}

var currentDirection=point_direction(points[currentPoint].x,points[currentPoint].y,points[currentPoint+1].x,points[currentPoint+1].y)

var timeSinceLastPoint = songMilliseconds-points[currentPoint].timeMS

var timeBetweenPoints=points[currentPoint+1].timeMS-points[currentPoint].timeMS

var nextBeatPercentage=timeSinceLastPoint/timeBetweenPoints

if(nextBeatPercentage>=1)
{
	nextBeatPercentage=0
	currentPoint++
}

var addedPoint=false
while(songMilliseconds>=points[currentPoint+1].timeMS)
{
	currentPoint+=1
	nextBeatPercentage=1
}
if(nextBeatPercentage>1||nextBeatPercentage<=0)
{
	nextBeatPercentage=0
}
//nextBeatPercentage=INCREMENT
var playerPoint=point_between_points(points[currentPoint].x,points[currentPoint].y,
points[currentPoint+1].x,points[currentPoint+1].y,
nextBeatPercentage)

var _currentX=previousPlayerPos.x
var _currentY=previousPlayerPos.y

draw_sprite_ext(spr_axes,axeFrames[0],_currentX,_currentY,1,1,currentDirection+90+axeRotations[0],c_white,1)
draw_sprite_ext(spr_axes,axeFrames[1],_currentX,_currentY,1,-1,currentDirection-90-axeRotations[1],c_white,1)
if(attackKey[loop_rotation((currentDirection+90))/90])
{
	axeRotations[0]=-90
	audio_play_sound(snd_swipe,1000,false)
}
if(attackKey[loop_rotation((currentDirection-90))/90])
{
	axeRotations[1]=-90
	audio_play_sound(snd_swipe,1000,false)
}

cameraOffset.x-=(cameraOffset.x-lengthdir_x(128,currentDirection))/10

cameraOffset.y-=(cameraOffset.y-lengthdir_y(128,currentDirection))/10

camera_set_view_pos(view_camera[0],
playerPoint.x-1366/2+cameraOffset.x,
playerPoint.y-768/2+cameraOffset.y)

draw_sprite_ext(spr_player,playerFrame,_currentX,_currentY,1,1,currentDirection,c_white,1)

//show_debug_message(playerPoint.x-(camera_get_view_x(view_camera[0])+1366/2))

previousPlayerPos.x=playerPoint.x

previousPlayerPos.y=playerPoint.y