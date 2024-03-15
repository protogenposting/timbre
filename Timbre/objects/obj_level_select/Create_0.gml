/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

button[0]={
	sprite: spr_play_button,
	func: function(){
		//make this go to level select later
		room_goto(rm_gameplay)
		audio_stop_all()
	},
	size:{x:256,y:128},
	position:{x:room_width/2,y:room_height/2 -128},
	sizeMod:0
}

button[1]={
	sprite: spr_edit_button,
	func: function(){
		//make this go to level select later
		room_goto(rm_editor)
		audio_stop_all()
	},
	size:{x:256,y:128},
	position:{x:room_width/2,y:room_height/2},
	sizeMod:0
}