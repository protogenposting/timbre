event_inherited()

gooberLocation.y=room_height

audio_stop_all()

audio=audio_play_sound(snd_tutorial_sound,1000,true)

selectedLevel=-4

bpm=0

currentBeat=0

playerProgress=0

passedHalf=false

button=[
	{
		name: "Back",
		func: function(){
			room_goto(rm_menu)
		},
		size:{x:128,y:64},
		position:{x:128,y:64},
		sizeMod:0
	},
	{
		name: "Turning",
		func: function(){
			obj_keybinds.currentStruct=global.keyboardBinds.turning
		},
		size:{x:256,y:256},
		position:{x:room_width/3,y:room_height/2},
		sizeMod:0
	},
	{
		name: "Attacking",
		func: function(){
			obj_keybinds.currentStruct=global.keyboardBinds.attacking
		},
		size:{x:256,y:256},
		position:{x:room_width/1.5,y:room_height/2},
		sizeMod:0
	},
]

currentStruct=-4

directionOrder=["left","up","right","down"]

currentDirection=0