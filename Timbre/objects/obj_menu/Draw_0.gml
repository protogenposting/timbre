/// @description Insert description here
// You can write your code in this editor

var _x=treeLine.x-512
repeat(5)
{
	draw_sprite(spr_treeline,0,_x,treeLine.y)
	_x+=512
}

var _doorHeight=move_smooth_between_points(0,0,1,0,current_time/doorTime).x

if(_doorHeight==1&&!global.playedDoorSlam)
{
	audio_play_sound(snd_door_slam,1000,false)
	global.playedDoorSlam=true
}

draw_sprite(spr_sun,0,room_width/2,-128)

draw_sprite_ext(spr_door,0,room_width/2,0,room_width/64,room_height/(_doorHeight*64),0,c_white,1)

draw_sprite(spr_dancc,currentShroomPose,gooberLocation.x,gooberLocation.y)

window_set_cursor(cr_none)