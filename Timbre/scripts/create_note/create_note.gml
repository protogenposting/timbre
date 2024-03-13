// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_note(_beat,_type,_direction,_wasHit){
	return {beat: _beat, type: _type,direction: _direction,wasHit: _wasHit}
}