/// @description Insert description here
// You can write your code in this editor
var positionsUsed=[]
var beatLength=60/bpm

for(var i=0;i<array_length(bobs);i++)
{
	draw_sprite(sprites.bob,bobs[i].frame,bobs[i].x,bobs[i].y)
}

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
	if(points[i].wasHit||abs(songMilliseconds-points[i].timeMS)/1000>10)
	{
		points[i].continuing=true
		continue;
	}
	var shouldContinue=false
	//draw_line(points[i].x,points[i].y,points[i+1].x,points[i+1].y)
	for(var z=0;z<array_length(positionsUsed);z++)
	{
		if(abs(positionsUsed[z][0]-points[i].x)<=32&&abs(positionsUsed[z][1]-points[i].y)<=32&&points[i].timeMS!=positionsUsed[z][2])
		{
			shouldContinue=true
		}
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
		array_push(positionsUsed,[points[i].x,points[i].y,points[i].timeMS])
	}
	var timing=songMilliseconds-points[i].timeMS
	var inCamera=point_in_camera(points[i].x-32,points[i].x+32,points[i].y-32,points[i].y+32)
	var hitKey=i>0&&points[i-1].type!=noteTypes.loop&&turnKey[points[i].direction]||i>0&&points[i-1].type==noteTypes.loop&&turnKeyReleased[points[i].direction]
	if(abs(timing)<=msWindow&&hitKey&&!points[i].wasHit||global.botPlay&&abs(songMilliseconds-points[i].timeMS)<=botplayLeniency&&!points[i].wasHit)
	{
		turnKey[points[i].direction]=false
		audio_play_sound(snd_turn,1000,false)
		points[i].wasHit=true
		combo++
		totalScore+=(msWindow-abs(timing))*global.songSpeed
		array_push(accuracyList,(msWindow-abs(timing))/msWindow)
		array_push(trueAccuracyList,timing)
		if(timing<-timings[1].distance)
		{
			early++
		}
		else if(timing>timings[1].distance)
		{
			late++
		}
		else
		{
			perfect++
		}
		
		hitTime=1.33
		hitMessage=get_timing(timing)
		if(get_timing_id(timing)<=1)
		{
			var _p=part_system_create(p_arrow_perfect)
			array_push(particles,{time:160,id:_p,updateTimer:0})
			part_system_position(_p,points[i].x,points[i].y)
			part_system_angle(_p,points[i].direction*90)
			part_system_automatic_update(_p,false)
		}
	}
	if(songMilliseconds>points[i].timeMS+msWindow&&!points[i].wasHit)
	{
		miss(points[i])
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
	if(points[i].continuing&&points[i].type!=noteTypes.loop)
	{
		continue;
	}
	var timing=songMilliseconds-points[i].timeMS
	var inCamera=point_in_camera(points[i].x-32,points[i].x+32,points[i].y-32,points[i].y+32)
	if(!points[i].wasHit&&abs(timing)<=(msWindow*beatLength)*120&&inCamera)
	{
		draw_sprite_ext(sprites.arrow,points[i].frame,points[i].x,points[i].y,1,1,
		points[i].direction*90,_color,1)
	}
	if(points[i].type==noteTypes.loop)
	{
		var _beatDistance=abs(points[i].beat-points[i+1].beat)
		if(!points[i+1].wasHit)
		{
			draw_sprite_ext(sprites.web,0,points[i].x,points[i].y,(loopSize/32)*_beatDistance,1,
			points[i].direction*90,c_white,1)
		}
		if(!points[i].wasHit)
		{
			draw_sprite_ext(sprites.spiderStart,0,
			points[i].x-lengthdir_x(64,points[i].direction*90),
			points[i].y-lengthdir_y(64,points[i].direction*90),
			1,1,
			points[i].direction*90,c_white,1)
		}
		else if(points[i+1].wasHit)
		{
			draw_sprite_ext(sprites.spiderEnd,0,
			points[i].x-lengthdir_x(64,points[i].direction*90),
			points[i].y-lengthdir_y(64,points[i].direction*90),
			1,1,
			points[i].direction*90,c_white,1)
		}
	}
	if(points[i].timeMS-songMilliseconds<msWindow*4&&!points[i].wasHit&&inCamera)
	{
		var _alpha=0.03
		if(currentPoint+1==i)
		{
			_alpha=0.5
		}
		if(!global.orderedAlpha)
		{
			_alpha=0.5
		}
		draw_sprite_ext(sprites.arrow,points[i].frame,points[i].x,points[i].y,
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),points[i].direction*90,_color,_alpha)
	}
}

var _nextNote=99999999999999
var hitTree=-1

for(var o=0; o<array_length(notes);o++)
{
	var _spr=sprites.log
	
	var inCamera=point_in_camera(notes[o].x-32,notes[o].x+32,notes[o].y-32,notes[o].y+32)
	var dir=notes[o].direction*90
	var timing=songMilliseconds-notes[o].timeMS
	try{
		if(notes[o].temporaryType==noteTypes.movingHit)
		{
			notes[o].x=notes[o].startX+lengthdir_x(gridSize*timing/1000,-dir)/4
			notes[o].y=notes[o].startY+lengthdir_y(gridSize*timing/1000,-dir)/4
			
		}
		if(notes[o].temporaryType==noteTypes.wall)
		{
			_spr=sprites.wall
		}
	}
	catch(e)
	{
		//show_debug_message(e)
	}
	
	if(notes[o].wasHit||sprites.log!=spr_log)
	{
		notes[o].color=c_white
	}
	
	if(!notes[o].wasHit)
	{
		_nextNote=min(_nextNote,o)
	}
	
	if(inCamera)
	{
		draw_sprite_ext(_spr,notes[o].wasHit,notes[o].x,notes[o].y,1,1,dir,notes[o].color,1)
	}
	if(abs(timing)<=msWindow&&attackKey[notes[o].direction]&&!notes[o].wasHit||global.botPlay&&abs(timing)<=botplayLeniency&&!notes[o].wasHit)
	{
		audio_play_sound(snd_hit_tree,1000,false)
		attackKey[notes[o].direction]=false
		notes[o].wasHit=true
		totalScore+=(msWindow-abs(timing))*global.songSpeed
		array_push(accuracyList,(msWindow-abs(timing))/msWindow)
		array_push(trueAccuracyList,timing)
		combo++
		if(timing<-timings[1].distance)
		{
			early++
		}
		else if(timing>timings[1].distance)
		{
			late++
		}
		else
		{
			perfect++
		}
		hitTime=1.33
		hitMessage=get_timing(timing)
		hitTree=notes[o].direction
		
		if(_spr==sprites.log)
		{
			var _p=part_system_create(p_log_break)
			array_push(particles,{time:160,id:_p,updateTimer:0})
			part_system_position(_p,notes[o].x,notes[o].y)
			part_system_angle(_p,notes[o].direction*90)
			part_system_automatic_update(_p,false)
			
		}
		if(_spr==sprites.wall)
		{
			var _p=part_system_create(p_wall_break)
			array_push(particles,{time:160,id:_p,updateTimer:0})
			part_system_position(_p,notes[o].x,notes[o].y)
			part_system_angle(_p,notes[o].direction*90)
			part_system_automatic_update(_p,false)
		}
	}
	if(songMilliseconds-notes[o].timeMS>=msWindow&&!notes[o].wasHit)
	{
		miss(notes[o])
	}
	if(notes[o].timeMS-songMilliseconds<msWindow*4&&!notes[o].wasHit&&notes[o].timeMS-songMilliseconds>-msWindow&&inCamera)
	{
		var _alpha=0.06
		if(_nextNote==o)
		{
			_alpha=0.6
		}
		if(!global.orderedAlpha)
		{
			_alpha=0.5
		}
		draw_sprite_ext(_spr,notes[o].wasHit,notes[o].x,notes[o].y,
		(((abs(songMilliseconds-notes[o].timeMS)/msWindow))+1),
		(((abs(songMilliseconds-notes[o].timeMS)/msWindow))+1),dir,notes[o].color,_alpha)
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
	/*if(!variable_struct_exists(points[currentPoint],"playedUp"))
	{
		_aud=audio_play_sound(snd_slide_up,1000,false)
		var _pitch=1
		audio_sound_pitch(_aud,_pitch)
		show_debug_message(_pitch)
		points[currentPoint].playedUp=true
	}*/
	if(nextBeatPercentage>=0.5&&!variable_struct_exists(points[currentPoint],"playedDown"))
	{
		var _aud=audio_play_sound(snd_slide_down,1000,false)
		var _pitch=1
		audio_sound_pitch(_aud,_pitch)
		audio_sound_set_track_position(_aud,0.06)
		show_debug_message(_pitch)
		points[currentPoint].playedDown=true
	}
	_currentX+=_transitionAmount.x
	_currentY+=_transitionAmount.y
	playerPoint.x+=_transitionAmount.x
	playerPoint.y+=_transitionAmount.y
	draw_sprite_ext(sprites.spiderGrab,0,_currentX-lengthdir_x(64,currentDirection),
	_currentY-lengthdir_y(64,currentDirection),1,1,currentDirection,c_white,1)
	if(turnKeyHold[points[currentPoint].direction])
	{
		totalScore+=1
	}
}

draw_sprite_ext(sprites.axe,axeFrames[0],_currentX,_currentY,1,1,currentDirection+90+axeRotations[0],c_white,1)
draw_sprite_ext(sprites.axe,axeFrames[1],_currentX,_currentY,1,-1,currentDirection-90-axeRotations[1],c_white,1)


if(_transitionAmount.x!=0||_transitionAmount.y!=0)
{
	cameraOffset.x-=(cameraOffset.x-lengthdir_x(-128,currentDirection))/(10*(fps/60))

	cameraOffset.y-=(cameraOffset.y-lengthdir_y(-128,currentDirection))/(10*(fps/60))
}
else
{
	cameraOffset.x-=(cameraOffset.x-lengthdir_x(128,currentDirection))/(10*(fps/60))

	cameraOffset.y-=(cameraOffset.y-lengthdir_y(128,currentDirection))/(10*(fps/60))
}

camera_set_view_pos(view_camera[0],
playerPoint.x-1366/2+cameraOffset.x,
playerPoint.y-768/2+cameraOffset.y)

draw_sprite_ext(sprites.player,playerFrame,_currentX,_currentY,1,1,currentDirection,c_white,1)

if(hitTree==loop_rotation((currentDirection+90))/90)
{
	axeRotations[0]=-90
	audio_play_sound(snd_swipe,1000,false)
}
if(hitTree==loop_rotation((currentDirection-90))/90)
{
	axeRotations[1]=-90
	audio_play_sound(snd_swipe,1000,false)
}
if(hitTree==loop_rotation((currentDirection+180))/90)
{
	axeRotations[0]=45
	axeRotations[1]=45
	audio_play_sound(snd_swipe,1000,false)
}
if(hitTree==loop_rotation((currentDirection))/90)
{
	axeRotations[0]=-90
	axeRotations[1]=-90
	audio_play_sound(snd_swipe,1000,false)
}

//show_debug_message(playerPoint.x-(camera_get_view_x(view_camera[0])+1366/2))

previousPlayerPos.x=playerPoint.x

previousPlayerPos.y=playerPoint.y