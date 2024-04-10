/// @description Insert description here
// You can write your code in this editor
var positionsUsed=[]
var beatLength=60/bpm

//check notes
for(var i=0;i<array_length(points)-1;i++)
{
	var _color=c_white
	if(i>0&&points[i-1].type==noteTypes.loop)
	{
		_color=c_red
	}
	if(!variable_struct_exists(points[i],"frame"))
	{
		points[i].frame=0
	}
	var shouldContinue=false
	//draw_line(points[i].x,points[i].y,points[i+1].x,points[i+1].y)
	for(var z=0;z<array_length(positionsUsed);z++)
	{
		if(abs(positionsUsed[z][0]-points[i].x)<=32&&abs(positionsUsed[z][1]-points[i].y)<=32)
		{
			shouldContinue=true
		}
	}
	if(points[i].wasHit||abs(songMilliseconds-points[i].timeMS)/1000>30)
	{
		points[i].continuing=false
		continue;
	}
	if(shouldContinue)
	{
		points[i].continuing=true
	}
	else
	{
		points[i].continuing=false
	}
	if(!points[i].wasHit)
	{
		array_push(positionsUsed,[points[i].x,points[i].y])
	}
	var timing=songMilliseconds-points[i].timeMS
	var inCamera=point_in_camera(points[i].x-32,points[i].x+32,points[i].y-32,points[i].y+32)
	var hitKey=i>0&&points[i-1].type!=noteTypes.loop&&turnKey[points[i].direction]||i>0&&points[i-1].type==noteTypes.loop&&turnKeyReleased[points[i].direction]
	if(abs(timing)<=msWindow&&hitKey&&!points[i].wasHit||global.botPlay&&abs(songMilliseconds-points[i].timeMS)<=msWindow/4&&!points[i].wasHit)
	{
		audio_play_sound(snd_turn,1000,false)
		points[i].wasHit=true
		combo++
		totalScore+=msWindow-abs(timing)
		array_push(accuracyList,(msWindow-abs(timing))/msWindow)
		if(timing<-timings[0].distance)
		{
			early++
		}
		else if(timing>timings[0].distance)
		{
			late++
		}
		else
		{
			perfect++
		}
		
		hitTime=1.33
		hitMessage=get_timing(timing)
	}
	if(songMilliseconds>points[i].timeMS+msWindow&&!points[i].wasHit)
	{
		audio_play_sound(snd_spinout,1000,false)
		points[i].wasHit=true
		misses++
		fullCombo=false
		combo=0
		array_push(accuracyList,0)
	}
}

//draw notes
for(var i=array_length(points)-1;i>0;i--)
{
	var _color=points[i].color
	if(i>0&&points[i].type==noteTypes.loop)
	{
		_color=c_red
	}
	if(!variable_struct_exists(points[i],"frame"))
	{
		points[i].frame=0
	}
	if(points[i].continuing)
	{
		continue;
	}
	var timing=songMilliseconds-points[i].timeMS
	var inCamera=point_in_camera(points[i].x-32,points[i].x+32,points[i].y-32,points[i].y+32)
	if(!points[i].wasHit&&abs(timing)<=(msWindow*beatLength)*120&&inCamera)
	{
		draw_sprite_ext(spr_reverse_arrow,points[i].frame,points[i].x,points[i].y,1,1,
		points[i].direction*90,_color,1)
	}
	if(points[i].type==noteTypes.loop)
	{
		var _beatDistance=abs(points[i].beat-points[i+1].beat)
		if(!points[i+1].wasHit)
		{
			draw_sprite_ext(spr_loop,0,points[i].x,points[i].y,(loopSize/32)*_beatDistance,1,
			points[i].direction*90,c_white,1)
		}
		if(!points[i].wasHit)
		{
			draw_sprite_ext(spr_spider_idle,0,
			points[i].x-lengthdir_x(64,points[i].direction*90),
			points[i].y-lengthdir_y(64,points[i].direction*90),
			1,1,
			points[i].direction*90,c_white,1)
		}
		else if(points[i+1].wasHit)
		{
			draw_sprite_ext(spr_spider_hit,0,
			points[i].x-lengthdir_x(64,points[i].direction*90),
			points[i].y-lengthdir_y(64,points[i].direction*90),
			1,1,
			points[i].direction*90,c_white,1)
		}
	}
	if(points[i].timeMS-songMilliseconds<msWindow*4&&!points[i].wasHit&&inCamera)
	{
		draw_sprite_ext(spr_reverse_arrow,points[i].frame,points[i].x,points[i].y,
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),points[i].direction*90,_color,0.5)
	}
}

for(var o=0; o<array_length(notes);o++)
{
	var inCamera=point_in_camera(notes[o].x-32,notes[o].x+32,notes[o].y-32,notes[o].y+32)
	var dir=notes[o].direction*90
	if(inCamera)
	{
		draw_sprite_ext(spr_log,notes[o].wasHit,notes[o].x,notes[o].y,1,1,dir,notes[o].color,1)
	}
	var timing=songMilliseconds-notes[o].timeMS
	if(abs(timing)<=msWindow&&attackKey[notes[o].direction]&&!notes[o].wasHit||global.botPlay&&abs(timing)<=msWindow/4&&!notes[o].wasHit)
	{
		audio_play_sound(snd_hit_tree,1000,false)
		attackKey[notes[o].direction]=true
		notes[o].wasHit=true
		totalScore+=msWindow-abs(timing)
		array_push(accuracyList,(msWindow-abs(timing))/msWindow)
		combo++
		if(timing<-timings[0].distance)
		{
			early++
		}
		else if(timing>timings[0].distance)
		{
			late++
		}
		else
		{
			perfect++
		}
		hitTime=1.33
		hitMessage=get_timing(timing)
	}
	if(songMilliseconds-notes[o].timeMS>=msWindow&&!notes[o].wasHit)
	{
		notes[o].wasHit=2
		misses++
		fullCombo=false
		combo=0
		array_push(accuracyList,0)
	}
	if(notes[o].timeMS-songMilliseconds<msWindow*4&&!notes[o].wasHit&&notes[o].timeMS-songMilliseconds>-msWindow&&inCamera)
	{
		draw_sprite_ext(spr_log,notes[o].wasHit,notes[o].x,notes[o].y,
		(((abs(songMilliseconds-notes[o].timeMS)/msWindow))+1),
		(((abs(songMilliseconds-notes[o].timeMS)/msWindow))+1),dir,notes[o].color,0.5)
	}
}

var currentDirection=points[currentPoint].direction*90

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

var _beatDistance=abs(points[currentPoint].beat-points[currentPoint+1].beat)

var _currentX=previousPlayerPos.x
var _currentY=previousPlayerPos.y

var _transitionAmount={x:0,y:0}

if(points[currentPoint].type==noteTypes.loop)
{
	_transitionAmount=in_out_between_points(0,0,
	-lengthdir_x(loopSize*_beatDistance,currentDirection),
	-lengthdir_y(loopSize*_beatDistance,currentDirection),
	nextBeatPercentage)
	_currentX+=_transitionAmount.x
	_currentY+=_transitionAmount.y
	playerPoint.x+=_transitionAmount.x
	playerPoint.y+=_transitionAmount.y
	draw_sprite_ext(spr_spider,0,_currentX-lengthdir_x(64,currentDirection),
	_currentY-lengthdir_y(64,currentDirection),1,1,currentDirection,c_white,1)
	if(turnKeyHold[points[currentPoint].direction])
	{
		totalScore+=1
	}
}

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

if(_transitionAmount.x!=0||_transitionAmount.y!=0)
{
	cameraOffset.x-=(cameraOffset.x-lengthdir_x(-128,currentDirection))/10

	cameraOffset.y-=(cameraOffset.y-lengthdir_y(-128,currentDirection))/10
}
else
{
	cameraOffset.x-=(cameraOffset.x-lengthdir_x(128,currentDirection))/10

	cameraOffset.y-=(cameraOffset.y-lengthdir_y(128,currentDirection))/10
}

camera_set_view_pos(view_camera[0],
playerPoint.x-1366/2+cameraOffset.x,
playerPoint.y-768/2+cameraOffset.y)

draw_sprite_ext(spr_player,playerFrame,_currentX,_currentY,1,1,currentDirection,c_white,1)

//show_debug_message(playerPoint.x-(camera_get_view_x(view_camera[0])+1366/2))

previousPlayerPos.x=playerPoint.x

previousPlayerPos.y=playerPoint.y