/// @description Insert description here
// You can write your code in this editor

if(global.showKeys)
{
	var _x=room_width-256-128
	var _y=room_height-128
	var _alpha=0.75
	var _pressed=turnKeyHold[noteDirections.up]
	draw_sprite_ext(spr_reverse_arrow,!_pressed*2,
	_x,_y-64,1,1,90,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_pressed=turnKeyHold[noteDirections.left]
	draw_sprite_ext(spr_reverse_arrow,!_pressed*2,
	_x-64,_y,1,1,180,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_pressed=turnKeyHold[noteDirections.right]
	draw_sprite_ext(spr_reverse_arrow,!_pressed*2,
	_x+64,_y,1,1,0,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_pressed=turnKeyHold[noteDirections.down]
	draw_sprite_ext(spr_reverse_arrow,!_pressed*2,
	_x,_y+64,1,1,270,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_x+=256
	
	_pressed=attackKeyHold[noteDirections.up]
	draw_sprite_ext(spr_log,!_pressed*2,
	_x,_y-64,1,1,90,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_pressed=attackKeyHold[noteDirections.left]
	draw_sprite_ext(spr_log,!_pressed*2,
	_x-64,_y,1,1,180,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_pressed=attackKeyHold[noteDirections.right]
	draw_sprite_ext(spr_log,!_pressed*2,
	_x+64,_y,1,1,0,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	
	_pressed=attackKeyHold[noteDirections.down]
	draw_sprite_ext(spr_log,!_pressed*2,
	_x,_y+64,1,1,270,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
}

//all the drawing for MANIA mode
if(global.gamemode==1)
{
	spriteResetStall-=delta_time/10000
	if(spriteResetStall<=-30)
	{
		sprite_index=sprites.acornIdle
		animationEnded=false
	}
	
	camera_set_view_pos(view_camera[0],0,0)
	var _camHeight=camera_get_view_height(view_camera[0])
	var _camWidth=camera_get_view_width(view_camera[0])
	
	for(var _x=0;_x<_camWidth;_x+=sprite_get_width(sprites.grass))
	{
		for(var _y=0;_y<_camWidth;_y+=sprite_get_height(sprites.grass))
		{
			draw_sprite(sprites.grass,layer_background_get_index(background),_x,_y)
		}
	}
	
	danceFromCenter.x=move_toward(danceFromCenter.x,0,delta_time/10000)
	danceFromCenter.y=move_toward(danceFromCenter.y,0,delta_time/10000)
	
	draw_sprite(sprite_index,image_index,room_width/2+danceFromCenter.x,room_height/2+danceFromCenter.y)
	
	var _noteDistance=96
	
	var _x=_camWidth/2 - 1.5*_noteDistance - 300
	var _y=128
	for(var i=2;i>=0;i--)
	{
		if(attackKey[i])
		{
			axeRotations[i]=0
			axeSpinSpeeds[i]=26
		}
		axeRotations[i]+=axeSpinSpeeds[i]
		
		axeSpinSpeeds[i]-=sign(axeSpinSpeeds[i])
		
		draw_sprite_ext(sprites.axe,0,_x,_y,1,1,axeRotations[i],c_white,1)
		
		if(i==noteDirections.up)
		{
			draw_text(_x,_y-32,get_key_name(global.keyboardBinds.attacking.up))
		}
		if(i==noteDirections.right)
		{
			draw_text(_x,_y-32,get_key_name(global.keyboardBinds.attacking.right))
		}
		if(i==noteDirections.left)
		{
			draw_text(_x,_y-32,get_key_name(global.keyboardBinds.attacking.left))
		}
		_x+=_noteDistance
	}
	
	var _scrollSpeed=global.moveSpeed
	
	for(var i=0;i<array_length(notes);i++)
	{
		var _timing=notes[i].timeMS-songMilliseconds
		var _scrollPosition=_y+(_timing)*global.moveSpeed
		if(_scrollPosition>_camHeight||notes[i].wasHit)
		{
			continue;
		}
		notes[i].x=_x-32-_noteDistance*notes[i].intendedDirection
		notes[i].y=128
		draw_sprite_ext(sprites.log,0,_x-32-_noteDistance*notes[i].intendedDirection,_scrollPosition,1,1,notes[i].intendedDirection*90,notes[i].color,1)
	}
	
	_x=_camWidth/2 - 2*_noteDistance + 64 + 300
	_y=room_height-96
	
	for(var i=0;i<4;i++)
	{		
		draw_sprite_ext(sprites.player,turnKeyHold[i]*2,_x,_y,1+turnKeyHold[i]*0.3,1+turnKeyHold[i]*0.3,i*90,c_white,1)
		
		if(i==noteDirections.up)
		{
			draw_text(_x,_y+32,get_key_name(global.keyboardBinds.turning.up))
		}
		if(i==noteDirections.down)
		{
			draw_text(_x,_y+32,get_key_name(global.keyboardBinds.turning.down))
		}
		if(i==noteDirections.right)
		{
			draw_text(_x,_y+32,get_key_name(global.keyboardBinds.turning.right))
		}
		if(i==noteDirections.left)
		{
			draw_text(_x,_y+32,get_key_name(global.keyboardBinds.turning.left))
		}
		
		_x+=_noteDistance
	}
	
	for(var i=0;i<array_length(points)-1;i++)
	{
		var _sprite=sprites.arrow
		var _timing=points[i].timeMS-songMilliseconds
		var _scrollPosition=_y-(_timing)*global.moveSpeed
		var _xPos=_x-_noteDistance*(3-points[i].direction)-96
		if(points[i].type==noteTypes.mine)
		{
			_sprite=sprites.mine
		}
		if(points[i].type==noteTypes.spider)
		{
			_sprite=sprites.spiderStart
			var _beatDistance=(abs(points[i].timeMS-points[points[i].endNote].timeMS)/1000)*_scrollSpeed
			draw_sprite_ext(sprites.web,0,_xPos,_scrollPosition,
			_beatDistance*16,1,270,c_white,1)
		}
		if(points[i].wasHit||_scrollPosition<0)
		{
			continue;
		}
		points[i].x=_xPos
		points[i].y=room_height-96
		draw_sprite_ext(_sprite,0,_xPos,_scrollPosition,1,1,points[i].direction*90,points[i].color,1)
	}
	
}

//all the stuff for NVDR mode
if(global.gamemode==2)
{
	var _camHeight=camera_get_view_height(view_camera[0])
	var _camWidth=camera_get_view_width(view_camera[0])
	var _noteDistance=_camWidth/6
	var _logDistance=_camWidth/6
	var _playerX=device_mouse_x_to_gui(0)
	var _playerY=_camHeight-32 
	
	#region botplay stuff
	var _nextType=noteTypes.turn
	
	var _nextNote=0
	for(var i=0;i<array_length(points)-1;i++)
	{
		if(points[i].wasHit||points[i].type==noteTypes.mine)
		{
			continue;
		}
		_nextNote=i
		break;
	}
		
	var _nextLog=0
	for(var i=0;i<array_length(notes);i++)
	{
		if(notes[i].wasHit)
		{
			continue;
		}
		_nextLog=i
		break;
	}
		
	if(array_length(points)<=0)
	{
		_nextType=noteTypes.log
	}
	else if(array_length(notes)<=0)
	{
		_nextType=noteTypes.turn
	}
	else
	{
		if(notes[_nextLog].timeMS<points[_nextNote].timeMS)
		{
			_nextType=noteTypes.log
		}
		else
		{
			_nextType=noteTypes.turn
		}
	}
	
	#endregion
	
	var _y=_camHeight-128
	
	for(var i=array_length(points)-1;i>0;i--)
	{
		var _sprite=sprites.arrow
		
		var _maxHitDistance=msWindow/4
		
		var _x=(_camWidth/2 - 1.5 * _noteDistance) + _noteDistance * points[i].direction
		
		var _timing=points[i].timeMS-songMilliseconds
		
		var _scrollPosition=_y-(_timing)
		
		if(global.botPlay&&_nextType==noteTypes.turn&&_nextNote==i)
		{
			_playerX=_x
		}
		
		if(points[i].type==noteTypes.mine)
		{
			_sprite=sprites.mine
		}
		
		if(points[i].type==noteTypes.spider)
		{
			var _touching=_playerX>_x-72&&_playerX<_x+72
			
			if(!_touching&&points[i].wasHit&&!points[points[i].endNote].wasHit)
			{
				//miss(points[points[i].endNote])
			}
			
			_sprite=sprites.spiderStart
			
			var _beatDistance=(abs(points[i].timeMS-points[points[i].endNote].timeMS)/1000)
			
			draw_sprite_ext(sprites.web,0,_x,_scrollPosition,
			_beatDistance*16,1,270,c_white,1)
		}
		
		if(global.shouldShowNVDRLines)
		{
			points[i].x=_x
			points[i].y=_scrollPosition
			try{
				if(points[i].y>0||points[i+1].y<room_height&&points[i+1].y>0)
				{
					draw_line_curved(points[i].x,points[i].y,points[i+1].x,points[i+1].y)
				}
			}
			catch(e)
			{
			
			}
		}
		
		if(points[i].wasHit)
		{
			continue;
		}
		
		draw_sprite_ext(_sprite,playerFrame,_x,_scrollPosition,
			1,1,90,points[i].color,1)
		
		var _touching=rectangle_in_rectangle(
		_x-32,_scrollPosition-32,_x+32,_scrollPosition+32,
		_playerX-64,_playerY-64,_playerX+64,_playerY+64)
		
		var _timing=songMilliseconds-points[i].timeMS
		
		if(_touching&&audio_is_playing(audio))
		{	
			if(points[i].type==noteTypes.mine)
			{
				miss(points[i])
			}
			else
			{
				totalScore+=(msWindow-abs(_timing))*global.songSpeed
			
				hitMessage=get_timing(_timing)
			
				var _timingID=get_timing_id(_timing)
			
				array_push(accuracyList,timings[_timingID].result)
			
				array_push(trueAccuracyList,_timing)
			
				audio_play_sound(snd_turn,1000,false)
			
				if(_timingID<=1)
				{
					var _p=part_system_create(p_arrow_perfect)
					array_push(particles,{time:160,id:_p,updateTimer:0})
					part_system_position(_p,_playerX,_playerY)
					part_system_angle(_p,90)
					part_system_automatic_update(_p,false)
				}
				combo++
				points[i].wasHit=true
			}
		}
		if(_timing>msWindow&&points[i].type!=noteTypes.mine&&audio_is_playing(audio))
		{
			miss(points[i])
		}
	}
	var _noteDistanceFromCenter=[]
	_noteDistanceFromCenter[noteDirections.left]=0
	_noteDistanceFromCenter[noteDirections.up]=1
	_noteDistanceFromCenter[noteDirections.right]=2
	_noteDistanceFromCenter[noteDirections.down]=1
	for(var i=array_length(notes)-1;i>=0;i--)
	{
		var _maxHitDistance=msWindow/4
		
		var _x=(_camWidth/2 - _logDistance) 
		+ _logDistance 
		* _noteDistanceFromCenter[notes[i].direction]
		
		var _timing=notes[i].timeMS-songMilliseconds
		
		var _scrollPosition=_y-(_timing)
		
		var _xPos=_x-_noteDistance*(3-notes[i].direction)-96
			
		if(global.shouldShowNVDRLines)
		{
			notes[i].x=_x
			notes[i].y=_scrollPosition
		
			try{
				if(notes[i].y>0||notes[i+1].y<room_height&&notes[i+1].y>0)
				{
					draw_set_color(c_black)
					draw_line_curved(notes[i].x,notes[i].y,notes[i+1].x,notes[i+1].y)
					draw_set_color(c_white)
				}
			}
			catch(e)
			{
			
			}
		}
		
		if(notes[i].wasHit)
		{
			continue;
		}
		
		draw_sprite_ext(sprites.log,0,_x,_scrollPosition,
			1,1,90,notes[i].color,1)
		
		if(global.botPlay&&_nextType==noteTypes.log&&_nextLog==i)
		{
			_playerX=_x
		}
		
		var _touching=rectangle_in_rectangle(
		_x-32,_scrollPosition-32,_x+32,_scrollPosition+32,
		_playerX-64,_playerY-64,_playerX+64,_playerY+64)
		
		var _timing=songMilliseconds-notes[i].timeMS
		
		if(_touching&&audio_is_playing(audio))
		{
			totalScore+=(msWindow-abs(_timing))*global.songSpeed
			
			hitMessage=get_timing(_timing)
			
			var _timingID=get_timing_id(_timing)
			
			array_push(accuracyList,timings[_timingID].result)
			
			array_push(trueAccuracyList,_timing)
			
			audio_play_sound(snd_turn,1000,false)
			
			if(_timingID<=1)
			{
				var _p=part_system_create(p_arrow_perfect)
				array_push(particles,{time:160,id:_p,updateTimer:0})
				part_system_position(_p,_playerX,_playerY)
				part_system_angle(_p,90)
				part_system_automatic_update(_p,false)
			}
			combo++
			notes[i].wasHit=true
		}
		if(_timing>msWindow&&audio_is_playing(audio))
		{
			miss(notes[i])
		}
	}
	for(var i=0;i<array_length(afterImages);i++)
	{
		draw_sprite_ext(sprites.player,playerFrame,afterImages[i],_playerY,
			2,2,90,c_white,0.5)
	}
	draw_sprite_ext(sprites.player,playerFrame,_playerX,_playerY,
		2,2,90,c_white,1)
	array_delete(afterImages,0,1)
	array_push(afterImages,_playerX)
}

for(var i=0;i<array_length(global.difficultyMods);i++)
{
	if(global.difficultyMods[i].enabled)
	{
		global.difficultyMods[i].effect()
	}
}


draw_set_halign(fa_center)
draw_set_font(fn_font_big)
if(paused)
{
	draw_text(1366/2,room_height/2,"press space to return to menu")
}
draw_text_transformed(1366/2,96,hitMessage,hitTime,hitTime,0)
hitTime-=(hitTime-1)/(10*(fps/60))

if(finished)
{
	draw_set_alpha(0.33)
	draw_rectangle_color(0,0,1366,768,c_black,c_black,c_black,c_black,false)
	draw_set_alpha(1)
	var accuracy = get_accuracy()
	draw_text(1366/2,room_height/3,"finished!")
	if(finishTimer>0)
	{
		draw_text(1366/2,room_height/3 + 64,"Score: "+string(totalScore))
		if(fullCombo)
		{
			draw_text(1366/2,room_height/3 + 64+32,"(+10% FC bonus)")
		}
		else
		{
			draw_text(1366/2,room_height/3 + 64+32,"/"+string(totalPossibleScore))
		}
		if(finishTimerLast<=0)
		{
			audio_play_sound(finishHitSound,1000,false)
		}
	}
	if(finishTimer>1)
	{
		draw_text(1366/2,room_height/3 + 128,"Accuracy: "+string(accuracy)+"%")
		if(fullCombo)
		{
			draw_text(1366/2,room_height/3 + 128+32,"(+15% FC bonus)")
			accuracy+=15
		}
		if(finishTimerLast<=1)
		{
			audio_play_sound(finishHitSound,1000,false)
		}
	}
	if(finishTimer>2)
	{
		draw_text(1366/2,room_height/3 + 128+64,"Rank: ")
		if(finishTimerLast<=2)
		{
			audio_play_sound(finishHitSound,1000,false)
		}
	}
	if(finishTimer>3)
	{
		draw_text(1366/2,room_height/3 + 256,get_rank(accuracy))
		if(finishTimerLast<=3)
		{
			if(get_rank(accuracy)=="F")
			{
				audio_stop_all()
				audio_play_sound(snd_SHIT,1000,false)
			}
			else
			{
				audio_play_sound(snd_slap2,1000,false)
			}
		}
	}
	if(finishTimer>4)
	{
		var _x=1366/2
		var _y=room_height/3
		var _sizeX=256
		var _sizeY=64
		var _arrayResults=get_accuracy_population()
		draw_rectangle_color(_x,_y-_sizeY,_x+_sizeX,_y+_sizeY,c_lime,c_red,c_red,c_lime,false)
		draw_rectangle_color(_x-_sizeX,_y-_sizeY,_x,_y+_sizeY,c_red,c_lime,c_lime,c_red,false)
		
		var _population=_arrayResults[0]
		var _min=_arrayResults[1]
		var _max=_arrayResults[2]
		var _types=_arrayResults[3]
		var _range=abs(_min)+abs(_max)
		
		_x=_x-_sizeX
		var graphSize=2
		var _late=0
		var _perfect=0
		var _early=0
		for(var i=0;i<array_length(_population)-1;i++)
		{
			var inc=(_sizeX*2)/array_length(_population)
			draw_line(_x,_y-_sizeY-_population[i]*graphSize,_x+inc,_y-_sizeY-_population[i+1]*graphSize)
			_x+=inc
			if(get_timing_id(_types[i])<=1)
			{
				_perfect++
			}
			else if(_types[i]<0)
			{
				_early++
			}
			else
			{
				_late++
			}
		}
		
		if(finishTimerLast<=4)
		{
			audio_play_sound(finishHitSound,1000,false)
		}
	}
	draw_set_font(fn_font)
	if(!audio_is_playing(songID)||finishTimer>5)
	{
		if(finishTimerLast<=5)
		{
			if(get_rank(accuracy)=="F")
			{
				
			}
			else
			{
				audio_play_sound(snd_slap3,1000,false)
			}
			var rank=get_rank_id(accuracy)
			if(variable_struct_exists(global.ranks[rank],"messages"))
			{
				hitMessage=global.ranks[rank].messages[irandom(array_length(global.ranks[rank].messages)-1)]
				hitTime=3
			}
		}
		finishTimer=999
		if(showingFinalMessage)
		{
			draw_text(1366/2,room_height/3 + 256 + 64,"Press button 1 to return to menu")
		}
		if(keyboard_check_pressed(vk_anykey)||gamepad_button_check_pressed(5,0))
		{
			audio_stop_all()
			if(global.editing)
			{
				room_goto(rm_editor)
			}
			else
			{
				room_goto(rm_level_select)
				try{
					var tempRank=get_rank_id_string(global.levels[global.selectedLevel].rank[global.gamemode][global.currentDifficulty])
					if(get_rank_id(accuracy)<tempRank&&global.songSpeed>=1)
					{
						global.levels[global.selectedLevel].rank[global.gamemode][global.currentDifficulty]=get_rank(accuracy)
					}
					if(totalScore>global.levels[global.selectedLevel].highScore[global.gamemode][global.currentDifficulty])
					{
						global.levels[global.selectedLevel].highScore[global.gamemode][global.currentDifficulty]=totalScore
					}
				}
				catch(e)
				{
					
				}
			}
		}
	}
}
else
{
	draw_set_font(fn_font)
	draw_text(1366/2,32,"score: "+string(totalScore)+"    misses: "+string(misses)+"    combo: "+string(combo)+"    accuracy: "+string(get_accuracy()))
	
	draw_text(1366/2,96+64,"Early: "+string(early)+"    Late: "+string(late)+"    Perfect+: "+string(perfect))
	
	comboMissTimer--
	
	if(global.gamemode!=1)
	{
		if(combo>comboDanceAmount)
		{
			sprite_index=spr_tv_highcombo
		}
		else if(comboMissTimer>0)
		{
			sprite_index=spr_tv_miss_combo
		}
		else if(get_accuracy()>=90)
		{
			sprite_index=spr_tv_really_good
		}
		else if(get_accuracy()>80)
		{
			sprite_index=spr_tv_good
		}
		else if(get_accuracy()<30)
		{
			sprite_index=spr_tv_really_bad
		}
		else if(get_accuracy()<50)
		{
			sprite_index=spr_tv_bad
		}
		else
		{
			sprite_index=spr_tv_idle
		}
	
		if(!global.showKeys)
		{
			draw_sprite(sprite_index,image_index,room_width-128,room_height-128)
		}
	}
}

if(array_length(lyrics)>0)
{
	var _nextLyric=-4

	for(var i=0;i<array_length(lyrics);i++)
	{
		if(lyrics[i].beat<(songMilliseconds/1000)*(bpm/60))
		{
			_nextLyric=i
		}
	}

	if(_nextLyric!=-4)
	{
		draw_set_font(fn_font_big)
		draw_text(1366/2,768/2 -128,lyrics[_nextLyric].text)
		draw_set_font(fn_font)
	}
}

