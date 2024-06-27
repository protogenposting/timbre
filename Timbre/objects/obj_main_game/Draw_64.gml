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

if(global.gamemode==1)
{
	var _camHeight=camera_get_view_height(view_camera[0])
	var _camWidth=camera_get_view_width(view_camera[0])
	
	for(var _x=0;_x<_camWidth;_x+=64)
	{
		for(var _y=0;_y<_camWidth;_y+=64)
		{
			draw_sprite(sprites.grass,layer_background_get_index(background),_x,_y)
		}
	}
	
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
		
		_x+=_noteDistance
	}
	
	var _scrollSpeed=global.moveSpeed
	
	for(var i=0;i<array_length(notes);i++)
	{
		var _timing=notes[i].timeMS-songMilliseconds
		var _scrollPosition=_y+(_timing)*global.moveSpeed
		if(_scrollPosition>_camHeight)
		{
			continue;
		}
		draw_sprite_ext(sprites.log,0,_x-32-_noteDistance*notes[i].intendedDirection,_scrollPosition,1,1,notes[i].intendedDirection*90,notes[i].color,1)
	}
	
	_x=_camWidth/2 - 2*_noteDistance + 64 + 300
	_y=room_height-96
	
	for(var i=0;i<4;i++)
	{		
		draw_sprite_ext(sprites.player,turnKeyHold[i]*2,_x,_y,1+turnKeyHold[i]*0.3,1+turnKeyHold[i]*0.3,i*90,c_white,1)
		
		_x+=_noteDistance
	}
	
	for(var i=0;i<array_length(points)-1;i++)
	{
		var _sprite=sprites.arrow
		var _timing=points[i].timeMS-songMilliseconds
		var _scrollPosition=_y-(_timing)*global.moveSpeed
		var _xPos=_x-_noteDistance*(3-points[i].direction)-96,_scrollPosition
		if(points[i].type==noteTypes.loop)
		{
			_sprite=sprites.spiderStart
			var _beatDistance=(abs(points[i].timeMS-points[i+1].timeMS)/1000)*_scrollSpeed
			draw_sprite_ext(sprites.web,0,_xPos,_scrollPosition,
			_beatDistance*16,1,270,c_white,1)
		}
		if(points[i].wasHit)
		{
			continue;
		}
		draw_sprite_ext(_sprite,0,_xPos,_scrollPosition,1,1,points[i].direction*90,points[i].color,1)
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