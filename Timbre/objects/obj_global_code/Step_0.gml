/// @description Insert description here
// You can write your code in this editor

while(global.gamemode>=array_length(global.modeBinds))
{
	array_push(global.modeBinds,{
		turning: new bind(
			spr_reverse_arrow,
			ord("A"),
			ord("D"),
			ord("W"),
			ord("S")
		),
		attacking: new bind(
			spr_log,
			ord("J"),
			ord("L"),
			ord("I"),
			ord("K")
		),
	})
}

global.keyboardBinds=global.modeBinds[global.gamemode]

if(room==rm_gameplay)
{
	var _uncappedFPS=true
	if(_uncappedFPS)
	{
		game_set_speed(1,gamespeed_microseconds)
	}
	else
	{
		game_set_speed(120,gamespeed_fps)
	}
}
else
{
	game_set_speed(60,gamespeed_fps)
}

gamepad_set_axis_deadzone(5,0.5)
gamepad_set_axis_deadzone(4,0.5)
global.pressingMouseLeft=false
if(room!=rm_gameplay&&global.usingController)
{
	window_mouse_set(window_mouse_get_x()+gamepad_axis_value(5,0)*10,window_mouse_get_y()+gamepad_axis_value(5,1)*10)
}
if(gamepad_button_check_pressed(5,0)||mouse_check_button_pressed(mb_left))
{
	global.pressingMouseLeft=true
}