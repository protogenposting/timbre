/// @description Insert description here
// You can write your code in this editor
enum noteTypes{
	log,
	turn,
	spider,
	wall,
	mine
}

enum noteDirections{
	right,
	up,
	left,
	down,
}

reset_default_playlist()

cursor_sprite=spr_mouse

//window_set_fullscreen(true)

logoPositionY=-256

logoDropTime=5000

logoRotation=0

logoRotationMult=1

doorTime=10000



audio_stop_all()

audio=audio_play_sound(snd_menu_music,1000,true)

levels=[{name:"ghost", difficulty:5}]

function remap(value, left1, right1, left2, right2) {
  return left2 + (value - left1) * (right2 - left2) / (right1 - left1);
}

bpm=90*2

currentBeat=0

currentFracBeat=0

barPercentage=0

currentShroomPose=0

treeLine={x:room_width/2,y:room_height/2+600}

gooberLocation={x:room_width/2,y:room_height-64}

button[0]={
	sprite: spr_play_button,
	func: function(){
		//make this go to level select later
		room_goto(rm_level_select)
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
	position:{x:room_width/2+140,y:room_height/2},
	sizeMod:0
}

button[2]={
	sprite: spr_tutorial_button,
	func: function(){
		//make this go to level select later
		room_goto(rm_tutorial)
		audio_stop_all()
	},
	size:{x:256,y:128},
	position:{x:room_width/2-140,y:room_height/2},
	sizeMod:0
}

button[3]={
	sprite: spr_settings_button,
	func: function(){
		room_goto(rm_settings)
		audio_stop_all()
	},
	size:{x:256,y:128},
	position:{x:room_width/2-140,y:room_height/2 + 128 + 128},
	sizeMod:0
}
button[4]={
	sprite: spr_exit_button,
	func: function(){
		game_end()
	},
	size:{x:256,y:128},
	position:{x:room_width/2+140,y:room_height/2 + 128 + 128},
	sizeMod:0
}
button[5]={
	sprite: spr_quaver_button,
	func: function(){
		room_goto(rm_conversion)
	},
	size:{x:256,y:128},
	position:{x:room_width/2+140,y:room_height/2 + 128},
	sizeMod:0
}
button[6]={
	sprite: spr_account_button,
	func: function(){
		room_goto(rm_online)
	},
	size:{x:256,y:128},
	position:{x:room_width/2-140,y:room_height/2 + 128},
	sizeMod:0
}

/*
button[3]={
	sprite: spr_tutorial_button,
	func: function(){
		//make this go to level select later
		room_goto(rm_offset_test)
		audio_stop_all()
	},
	size:{x:256,y:128},
	position:{x:room_width/2,y:room_height/2 + 128 + 128},
	sizeMod:0
}