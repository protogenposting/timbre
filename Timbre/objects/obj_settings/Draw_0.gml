/// @description Insert description here
// You can write your code in this editor
var currentPoint=(playerProgress>0.5)+2
_nextPoint=point_between_points(points[currentPoint].x,points[currentPoint].y,
points[currentPoint+1].x,points[currentPoint+1].y,(playerProgress*2)-(playerProgress>0.5))
draw_sprite_ext(spr_reverse_arrow,image_index,points[3].x,points[3].y,1,1,270,c_white,playerProgress<=0.5)
draw_text(points[2].x+128,points[2].y-128,"Use W A S D to hit arrows")
_currentX=_nextPoint.x
_currentY=_nextPoint.y
currentDirection=(playerProgress>0.5)*270
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,1,currentDirection+90,c_white,1)
draw_sprite_ext(spr_axes,image_index,_currentX,_currentY,1,-1,currentDirection-90,c_white,1)
draw_sprite_ext(spr_player,image_index,_currentX,_currentY,1,1,currentDirection,c_white,1)