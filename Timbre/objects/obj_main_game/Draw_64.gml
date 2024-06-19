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

if(global.classicView)
{
	draw_rectangle_color(0,0,camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]),
	c_black,c_black,c_black,c_black,
	false)
}
if(paused)
{
	draw_text(1366/2,room_height/2,"press space to return to menu")
}
draw_set_halign(fa_center)
draw_set_font(fn_font_big)
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
					var tempRank=get_rank_id_string(global.levels[global.selectedLevel].rank[global.currentDifficulty])
					if(get_rank_id(accuracy)<tempRank&&global.songSpeed>=1)
					{
						global.levels[global.selectedLevel].rank[global.currentDifficulty]=get_rank(accuracy)
					}
					if(totalScore>global.levels[global.selectedLevel].highScore[global.currentDifficulty])
					{
						global.levels[global.selectedLevel].highScore[global.currentDifficulty]=totalScore
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

if(global.classicView)
{
	var rotationOrder=[]
	
	rotationOrder[noteDirections.left]=0
	rotationOrder[noteDirections.right]=3
	rotationOrder[noteDirections.up]=1
	rotationOrder[noteDirections.down]=2
	
	var maxX=0
	var _hitPoint=room_height-128
	var _speed=200000/bpm
	var _startPoint=room_width-256-128
	var _rotation=0
	var _x=_startPoint
	var _noteDistance=74
	repeat(4)
	{
		draw_sprite_ext(spr_log,0,_startPoint+rotationOrder[_rotation]*_noteDistance,_hitPoint,1,1,_rotation*90,c_white,0.3)
		_x+=_noteDistance
		_rotation++
	}
	for(var i=0;i<array_length(notes);i++)
	{
		var _distance=(notes[i].timeMS-songMilliseconds)/_speed
		_x=_startPoint+rotationOrder[notes[i].direction]*_noteDistance
		maxX=max(_x,maxX)
		var _y=_hitPoint*(1-_distance)
		draw_sprite_ext(spr_log,0,_x,_y,1,1,notes[i].direction*90,c_white,1)
	}
	_rotation=0
	_startPoint-=_noteDistance*8
	_x=_startPoint
	repeat(4)
	{
		draw_sprite_ext(spr_reverse_arrow,0,_startPoint+rotationOrder[_rotation]*_noteDistance,_hitPoint,1,1,_rotation*90,c_white,0.3)
		_x+=_noteDistance
		_rotation++
	}
	for(var i=0;i<array_length(points);i++)
	{
		var _distance=(points[i].timeMS-songMilliseconds)/_speed
		_x=_startPoint+rotationOrder[points[i].direction]*_noteDistance
		maxX=max(_x,maxX)
		var _y=_hitPoint*(1-_distance)
		draw_sprite_ext(spr_reverse_arrow,0,_x,_y,1,1,points[i].direction*90,c_white,1)
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