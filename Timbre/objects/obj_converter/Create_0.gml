/// @description Insert description here
// You can write your code in this editor
button[0]={
	name: "Back",
	func: function(){
		room_goto(rm_menu)
	},
	size:{x:128,y:64},
	position:{x:128,y:64},
	sizeMod:0
}
button[1]={
	name: "FNF",
	func: function(){
		
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96},
	sizeMod:0,
	color:c_red
}
button[2]={
	name: "OSU!Mania",
	func: function(){
		
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96+96},
	sizeMod:0,
	color:c_purple
}

yOffset=0

yOffsetSpeed=0

yOffsetMaxSpeed=25