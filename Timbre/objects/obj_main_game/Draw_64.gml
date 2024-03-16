/// @description Insert description here
// You can write your code in this editor

if(paused)
{
	draw_text(1366/2,room_height/2,"press space to return to menu")
}

draw_set_font(fn_font_big)
draw_text_transformed(1366/2,96,hitMessage,hitTime,hitTime,0)
hitTime-=(hitTime-1)/10

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
			if(variable_struct_exists(ranks[rank],"messages"))
			{
				hitMessage=ranks[rank].messages[irandom(array_length(ranks[rank].messages)-1)]
				hitTime=3
			}
		}
		finishTimer=999
		if(showingFinalMessage)
		{
			draw_text(1366/2,room_height/3 + 256 + 64,"Press any button to return to menu")
		}
		if(keyboard_check_pressed(vk_anykey))
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
					global.levels[global.selectedLevel].rank=get_rank(get_accuracy())
					if(totalScore>global.levels[global.selectedLevel].highScore)
					{
						global.levels[global.selectedLevel].highScore=totalScore
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
	
	if(get_accuracy()>=90)
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
	
	draw_sprite(sprite_index,image_index,room_width-128,room_height-128)
}