/// @description Insert description here
// You can write your code in this editor
audio=audio_play_sound(snd_menu_music,1000,true)

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
		room_goto(rm_gameplay)
	},
	size:{x:256,y:128},
	position:{x:room_width/2,y:room_height/2 -128},
	sizeMod:0
}