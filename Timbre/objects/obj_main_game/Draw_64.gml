/// @description Insert description here
// You can write your code in this editor
draw_text(0,0,string(currentFracBeat))
draw_text(0,16,string(currentPoint))
draw_text(0,32,string((currentFracBeat-points[currentPoint].beat)/(points[currentPoint+1].beat-points[currentPoint].beat)))