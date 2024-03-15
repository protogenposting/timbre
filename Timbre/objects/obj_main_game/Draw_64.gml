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
	var accuracy = (totalScore/totalPossibleScore)*100
	draw_text(1366/2,room_height/3,"finished!")
	if(finishTimer>0)
	{
		draw_text(1366/2,room_height/3 + 64,"Score: "+string(totalScore))
		if(fullCombo)
		{
			draw_text(1366/2,room_height/3 + 64+32,"(+10% FC bonus)")
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
			draw_text(1366/2,room_height/3 + 128+32,"(+3% FC bonus)")
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
			audio_play_sound(snd_slap2,1000,false)
		}
	}
	draw_set_font(fn_font)
	if(!audio_is_playing(songID)||finishTimer>5)
	{
		if(finishTimerLast<=5)
		{
			if(get_rank(accuracy)=="F")
			{
				audio_stop_all()
				audio_play_sound(snd_SHIT,1000,false)
			}
			else
			{
				audio_play_sound(snd_slap3,1000,false)
			}
		}
		finishTimer=999
		if(showingFinalMessage)
		{
			draw_text(1366/2,room_height/3 + 256 + 64,"Press any button to return to menu")
		}
		if(keyboard_check_pressed(vk_anykey))
		{
			room_goto(rm_menu)
		}
	}
}
else
{
	draw_set_font(fn_font)
	draw_text(1366/2,32,"score: "+string(totalScore)+"    misses: "+string(misses)+"    combo: "+string(combo))
}