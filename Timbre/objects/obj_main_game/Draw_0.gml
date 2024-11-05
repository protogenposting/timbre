/// @description Insert description here
// You can write your code in this editor
if(!global.gamemodes[global.gamemode].usesNormalControls)
{
	var gotLastNote=false
	for(var i=array_length(points)-1;i>0;i--)
	{
		if(points[i].timeMS<=songMilliseconds&&!gotLastNote)
		{
			currentPoint=i
			gotLastNote=true
			break;
		}
	}
	exit;
}

var positionsUsed=[]
var beatLength=60/bpm

for(var i=0;i<array_length(bobs);i++)
{
	draw_sprite(sprites.bob,bobs[i].frame,bobs[i].x,bobs[i].y)
}

//check notes
for(var i=0;i<array_length(points)-1;i++)
{
	if(global.gamemode==1&&points[i].wasHit)
	{
		continue;
	}
	var _color=c_white
	if(points[i].release)
	{
		_color=c_red
	}
	if(!variable_struct_exists(points[i],"frame"))
	{
		points[i].frame=0
	}
	if(abs(songMilliseconds-points[i].timeMS)/1000>10)
	{
		points[i].continuing=true
		continue;
	}
	var inCamera=point_in_camera(points[i].x-32,points[i].x+32,points[i].y-32,points[i].y+32)
	if(points[i].wasHit==2&&inCamera)
	{
		draw_sprite_ext(sprites.badArrow,points[i].frame,points[i].x,points[i].y,1,1,
		points[i].direction*3,_color,1)
	}
	
	if(points[i].wasHit)
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
	var hitKey=!points[i].release&&turnKey[points[i].direction]||points[i].release&&turnKeyReleased[points[i].direction]
	var _canHit=abs(timing)<=msWindow
	if(points[i].type==noteTypes.mine)
	{
		_canHit=abs(timing)<=msWindow/4
	}
	points[i].wasHitThisFrame=false
	if(_canHit&&hitKey&&!points[i].wasHit||global.botPlay&&abs(songMilliseconds-points[i].timeMS)<=botplayLeniency&&!points[i].wasHit&&points[i].type!=noteTypes.mine)
	{
		if(points[i].type==noteTypes.mine)
		{
			audio_play_sound(snd_mine,1000,false)
			miss(points[i])
		}
		else
		{
			if(global.gamemode==1)
			{
				dance(points[i])
			}
			turnKey[points[i].direction]=false
			audio_play_sound(snd_turn,1000,false)
			points[i].wasHit=true
			combo++
			var timingID=get_timing_id(timing)
			totalScore+=(msWindow-abs(timing))*global.songSpeed
			array_push(accuracyList,timings[timingID].result)
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
			
			var _inst=instance_create_depth(points[i].x,points[i].y,depth-1,obj_effect)
			_inst.sprite_index=timings[timingID].sprite
			_inst.timeLeft=20
			_inst.totalTime=20
			_inst.drawOnGui=true
			_inst.moveDirection.y=-2
			
			if(global.gamemode==0)
			{
				_inst.drawOnGui=false
				_inst.moveDirection.y=-5
			}
			
			hitTime=1.33
			hitMessage=get_timing(timing)
		}
	}
	if(songMilliseconds>points[i].timeMS+msWindow&&!points[i].wasHit)
	{
		if(points[i].type!=noteTypes.mine)
		{
			miss(points[i])
		}
		else
		{
			points[i].wasHit=true
		}
	}
}

var gotLastNote=false
//draw notes
for(var i=array_length(points)-1;i>0;i--)
{
	var _spr=sprites.arrow
	if(points[i].timeMS<=songMilliseconds&&!gotLastNote)
	{
		currentPoint=i
		gotLastNote=true
	}
	
	var _currentPoint=points[i-1]
	
	if(currentPoint==i-1)
	{
		_currentPoint=previousPlayerPos
	}
	
	if(global.gamemode==1)
	{
		break;
	}
	
	var _noteSize=64
	
	if(point_in_camera(_currentPoint.x-_noteSize,_currentPoint.x+_noteSize,
	_currentPoint.y-_noteSize,_currentPoint.y+_noteSize)||
	point_in_camera(points[i].x-_noteSize,points[i].x+_noteSize,
	points[i].y-_noteSize,points[i].y+_noteSize))
	{
		var _xScale=(point_distance(_currentPoint.x,_currentPoint.y,points[i].x,points[i].y)+32)/64
		var _x=_currentPoint.x-(_currentPoint.x-points[i].x)/2
		var _yScale=1
		var _y=_currentPoint.y-(_currentPoint.y-points[i].y)/2
	
		if(currentPoint<i)
		{
			draw_sprite_ext(sprites.path,0,_x,_y,_xScale,_yScale,
				point_direction(points[i-1].x,points[i-1].y,points[i].x,points[i].y),c_white,1)
		}
	}
	
	if(points[i].type==noteTypes.mine)
	{
		_spr=sprites.mine
	}
	var _color=points[i].color
	if(i<array_length(points)-1&&points[i+1].release)
	{
		_color=c_red
	}
	if(!variable_struct_exists(points[i],"frame"))
	{
		points[i].frame=0
	}
	if(points[i].continuing&&points[i].type!=noteTypes.spider)
	{
		continue;
	}
	
	var timing=songMilliseconds-points[i].timeMS
	var inCamera=point_in_camera(points[i].x-32,points[i].x+32,points[i].y-32,points[i].y+32)
	try{
		var _directionToNext=points[i].direction*90
	}
	catch(e)
	{
		var _directionToNext=points[i].direction*90
	}
	if(!points[i].wasHit&&abs(timing)<=(msWindow*beatLength)*120&&inCamera)
	{
		draw_sprite_ext(_spr,points[i].frame,points[i].x,points[i].y,1,1,
		_directionToNext,_color,1)
	}
	if(points[i].type==noteTypes.spider)
	{
		var _beatDistance=abs(points[i].beat-points[points[i].endNote].beat)
		if(!points[i+1].wasHit)
		{
			var _nextNormalNote=i
			for(var i2=_nextNormalNote;i2<array_length(points);i2++)
			{
				if(!points[i2].release)
				{
					_nextNormalNote=i2
					break;
				}
			}
			var _dir=point_direction(points[i+1].x,points[i+1].y,points[_nextNormalNote].x,points[_nextNormalNote].y)
			if(points[i+1].x==points[_nextNormalNote].x&&points[i+1].y==points[_nextNormalNote].y)
			{
				_dir=points[i].direction*90
			}
			draw_sprite_ext(sprites.web,0,points[i].x,points[i].y,(loopSize/32)*_beatDistance,1,
			_dir,c_white,1)
			
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
	if(points[i].timeMS-songMilliseconds<msWindow*2&&!points[i].wasHit&&inCamera)
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
		draw_sprite_ext(_spr,points[i].frame,points[i].x,points[i].y,
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),
		(((abs(songMilliseconds-points[i].timeMS)/msWindow))+1),_directionToNext,_color,_alpha)
	}
}

var _nextNote=99999999999999
var hitTrees=[]

var usedTreeSpaces=[]
//TREEES
for(var o=0; o<array_length(notes);o++)
{
	if(global.gamemode==1&&notes[o].wasHit)
	{
		continue;
	}
	
	var _spr=sprites.log
	
	var inCamera=point_in_camera(notes[o].x-32,notes[o].x+32,notes[o].y-32,notes[o].y+32)
	var dir=notes[o].direction*90
	var timing=songMilliseconds-notes[o].timeMS
	if(variable_struct_exists(notes[o],"temporaryType"))
	{
		if(notes[o].temporaryType==noteTypes.wall)
		{
			_spr=sprites.wall
		}
	}
	
	if(notes[o].intendedDirection==noteDirections.down)
	{
		_spr = sprites.player
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
		var shouldSkip=false
		for(var i=0;i<array_length(usedTreeSpaces);i++)
		{
			if(abs(usedTreeSpaces[i].x-notes[o].x)<5&&abs(usedTreeSpaces[i].y-notes[o].y)<5&&!usedTreeSpaces[i].wasHit)
			{
				shouldSkip=true
			}
		}
		array_push(usedTreeSpaces,{x:notes[o].x,y:notes[o].y,wasHit:notes[o].wasHit})
		if(global.gamemode!=1&&!shouldSkip)
		{
			var _xOffset = 0
			
			var _yOffset = 0
			
			if(_spr == sprites.player)
			{
				_xOffset = lengthdir_x((songMilliseconds-notes[o].timeMS)/1000 * gridSize,dir+90)
				
				_yOffset = lengthdir_y((songMilliseconds-notes[o].timeMS)/1000 * gridSize,dir+90)
			}
			
			draw_sprite_ext(_spr,notes[o].wasHit,notes[o].x + _xOffset,notes[o].y + _yOffset,1,1,dir,notes[o].color,1)
			if(notes[o].timeMS-songMilliseconds<msWindow*2&&!notes[o].wasHit&&notes[o].timeMS-songMilliseconds>-msWindow&&inCamera)
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
	}
	if(array_contains(hitTrees,notes[o].intendedDirection))
	{
		continue;
	}
	if(abs(timing)<=msWindow&&attackKey[notes[o].intendedDirection]&&!notes[o].wasHit||global.botPlay&&abs(timing)<=botplayLeniency&&!notes[o].wasHit)
	{
		audio_play_sound(snd_hit_tree,1000,false)
		if(global.gamemode==0)
		{
			attackKey[notes[o].intendedDirection]=false
		}
		
		
		
		notes[o].wasHit=true
		var timingID=get_timing_id(timing)
		if(global.gamemode==1)
		{
			var _inst=instance_create_depth(notes[o].x,notes[o].y,depth-1,obj_effect)
			_inst.sprite_index=timings[timingID].sprite
			_inst.timeLeft=20
			_inst.totalTime=20
			_inst.drawOnGui=true
			_inst.moveDirection.y=2
		}
		totalScore+=(msWindow-abs(timing))*global.songSpeed
		array_push(accuracyList,timings[timingID].result)
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
		if(global.botPlay)
		{
			var _tempArray=[0,0,0,0]
			_tempArray[notes[o].intendedDirection]=true
			rotate_axes(_tempArray)
		}
		hitTime=1.33
		hitMessage=get_timing(timing)
		array_push(hitTrees,notes[o].intendedDirection)
		
		show_debug_message(points[currentPoint].direction+1)
		show_debug_message([notes[o].direction,notes[o].intendedDirection])
		
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
	if(global.gamemode==1)
	{
		continue;
	}
}

var currentDirection=point_direction(points[currentPoint].x,points[currentPoint].y,points[currentPoint+1].x,points[currentPoint+1].y)

if(points[currentPoint].x==points[currentPoint+1].x&&points[currentPoint].y==points[currentPoint+1].y)
{
	currentDirection=points[currentPoint].direction*90
}

var timeSinceLastPoint = songMilliseconds-points[currentPoint].timeMS

var timeBetweenPoints=points[currentPoint+1].timeMS-points[currentPoint].timeMS

var nextBeatPercentage=timeSinceLastPoint/timeBetweenPoints

if(nextBeatPercentage>=1)
{
	nextBeatPercentage=0
	currentPoint++
}

var addedPoint=false
if(nextBeatPercentage<0)
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

if(points[currentPoint].type==noteTypes.spider)
{
	var timeSinceLastPoint = songMilliseconds-points[currentPoint].timeMS

	var timeBetweenPoints=points[points[currentPoint].endNote].timeMS-points[currentPoint].timeMS

	var releaseBeatPercentage=timeSinceLastPoint/timeBetweenPoints
	
	_transitionAmount=in_out_between_points(0,0,
	-lengthdir_x(loopSize*_beatDistance,currentDirection),
	-lengthdir_y(loopSize*_beatDistance,currentDirection),
	releaseBeatPercentage)
	/*if(!variable_struct_exists(points[currentPoint],"playedUp"))
	{
		_aud=audio_play_sound(snd_slide_up,1000,false)
		var _pitch=1
		audio_sound_pitch(_aud,_pitch)
		show_debug_message(_pitch)
		points[currentPoint].playedUp=true
	}*/
	if(releaseBeatPercentage>=0.5&&!variable_struct_exists(points[currentPoint],"playedDown"))
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
		totalScore+=delta_time/10000
		dance(points[currentPoint])
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

var cameraWidth=camera_get_view_width(view_camera[0])
var cameraHeight=camera_get_view_height(view_camera[0])

camera_set_view_pos(view_camera[0],
playerPoint.x-cameraWidth/2+cameraOffset.x,
playerPoint.y-cameraHeight/2+cameraOffset.y)

draw_sprite_ext(sprites.player,playerFrame,_currentX,_currentY,1,1,currentDirection,c_white,1)

//show_debug_message(playerPoint.x-(camera_get_view_x(view_camera[0])+1366/2))

previousPlayerPos.x=playerPoint.x

previousPlayerPos.y=playerPoint.y