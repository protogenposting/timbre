/// @description Insert description here
// You can write your code in this editor
var _nextPoint=point_between_points(points[0].x,points[0].y,points[1].x,points[1].y,playerProgress)
var _currentX=_nextPoint.x
var _currentY=_nextPoint.y
var currentDirection=0
if(playerProgress==0.5)
{
	axeRotations[0]=-90
	audio_play_sound(snd_swipe,1000,false)
	audio_play_sound(snd_hit_tree,1000,false)
}
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,1,currentDirection+90+axeRotations[0],c_white,1)
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,-1,currentDirection-90-axeRotations[1],c_white,1)
draw_sprite_ext(spr_player,image_index,_currentX,_currentY,1,1,currentDirection,c_white,1)
draw_sprite(spr_log,playerProgress>0.5,points[0].x+128,points[0].y-64)
draw_text(points[0].x+128,points[0].y-128,"Use I J K L to hit logs depending on what direction it is to the player")


var currentPoint=(playerProgress>0.5)+2
_nextPoint=point_between_points(points[currentPoint].x,points[currentPoint].y,
points[currentPoint+1].x,points[currentPoint+1].y,(playerProgress*2)-(playerProgress>0.5))
draw_sprite_ext(spr_reverse_arrow,0,points[3].x,points[3].y,1,1,270,c_white,1)
draw_text(points[2].x+128,points[2].y-128,"Use W A S D to hit arrows")
_currentX=_nextPoint.x
_currentY=_nextPoint.y
currentDirection=(playerProgress>0.5)*270
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,1,currentDirection+90,c_white,1)
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,-1,currentDirection-90,c_white,1)
draw_sprite_ext(spr_player,image_index,_currentX,_currentY,1,1,currentDirection,c_white,1)