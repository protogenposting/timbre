/// @description Insert description here
// You can write your code in this editor

if(paused)
{
	draw_text(1366/2,room_height/2,"press space to return to menu")
}

draw_text(1366/2,32,"score: "+string(totalScore)+"    misses: "+string(misses)+"    combo: "+string(combo))
draw_text_transformed(1366/2,96,hitMessage,hitTime,hitTime,0)
hitTime-=(hitTime-2)/10