event_inherited()

gooberLocation.y=room_height

audio_stop_all()

audio=audio_play_sound(snd_tutorial_sound,1000,true)

selectedLevel=-4

bpm=0

currentBeat=0

playerProgress=0

passedHalf=false

function find_keybind(_key){
	var _sections=struct_get_names(global.keyboardBinds)
	for(var i=0;i<array_length(_sections);i++)
	{
		var _struct=variable_struct_get(global.keyboardBinds,_sections[i])
		var _directions=struct_get_names(_struct)
		for(var o=0;o<array_length(_directions);o++)
		{
			var _value=variable_struct_get(_struct,_directions[o])
			if(_directions[o]!="sprite")
			{
				if(_value==_key)
				{
					return true
				}
			}
		}
	}
	return false
}

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

directionOrder=["right","up","left","down"]

currentDirection=0