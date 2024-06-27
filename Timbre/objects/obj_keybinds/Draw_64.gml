/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_center)

var _x=room_width/2
var _y=256

var _hAxis=keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)

global.gamemode+=_hAxis
if(global.gamemode>=array_length(global.gamemodes))
{
	global.gamemode=0
}
if(global.gamemode<0)
{
	global.gamemode=array_length(global.gamemodes)-1
}

draw_text(_x,_y-128,"Use Left/Right arrow keys to change the gamemode")

draw_sprite(spr_mode_background,0,_x,_y)
			
draw_sprite(global.gamemodes[global.gamemode].sprite,0,_x,_y)

if(currentStruct!=-4)
{
	draw_set_alpha(0.33)
	draw_rectangle_color(0,0,9999,9999,c_black,c_black,c_black,c_red,false)
	draw_set_alpha(1)
	
	draw_text(room_width/2,128,"press escape to exit")
	
	_x=room_width/2
	_y=room_height/2
	var _alpha=1
	var _pressed=currentDirection==1
	draw_sprite_ext(currentStruct.sprite,!_pressed*2,
	_x-64,_y,1+_pressed,1+_pressed,
	90,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	draw_text(_x-64,_y,get_key_name(currentStruct.up))
	
	_pressed=currentDirection==2
	draw_sprite_ext(currentStruct.sprite,!_pressed*2,
	_x+64,_y,1+_pressed,1+_pressed,
	180,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	draw_text(_x+64,_y,get_key_name(currentStruct.left))
	
	_pressed=currentDirection==0
	draw_sprite_ext(currentStruct.sprite,!_pressed*2,
	_x-128,_y,1+_pressed,1+_pressed,
	0,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	draw_text(_x-128,_y,get_key_name(currentStruct.right))
	
	_pressed=currentDirection==3
	draw_sprite_ext(currentStruct.sprite,!_pressed*2,
	_x+128,_y,1+_pressed,1+_pressed,
	270,make_color_rgb(255*_pressed,255*_pressed,255*_pressed),_alpha)
	draw_text(_x+128,_y,get_key_name(currentStruct.down))
	
	if(keyboard_check_pressed(vk_escape))
	{
		currentStruct=-4
		currentDirection=0
		exit;
	}
	
	if(keyboard_check_pressed(vk_anykey))
	{
		if(find_keybind(keyboard_key))
		{
			exit;
		}
		variable_struct_set(currentStruct,directionOrder[currentDirection],keyboard_key)
		currentDirection++
		if(currentDirection>=array_length(directionOrder))
		{
			currentStruct=-4
			currentDirection=0
		}
	}
}
else
{
	draw_buttons()
}