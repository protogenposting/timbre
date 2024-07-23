/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_text(0,0,"fps: "+string(fps))

if(keyboard_check(vk_control)&&keyboard_check_pressed(ord("S")))
{
	screen_save(game_save_id+(string(current_year)+string(current_day)+string(current_hour)+string(current_second)+string(current_time))+".png")
}