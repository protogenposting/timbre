event_inherited()

gooberLocation.y=room_height

audio_stop_all()

audio=audio_play_sound(snd_tutorial_sound,1000,true)

selectedLevel=-4

bpm=0

currentBeat=0

if(global.song!=-4)
{
	audio_destroy_stream(global.song)
}

global.song=-4

global.editing=false

playerProgress=0

passedHalf=false

points=[
	{x:512+256,y:512},
	{x:512+256+256,y:512},
	{x:512+256+256,y:512+256}
]

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
		name: "Keybinds",
		func: function(){
			room_goto(rm_keybinds)
		},
		size:{x:128,y:64},
		position:{x:128,y:64+70},
		sizeMod:0
	},
	{
		name: "Skins",
		func: function(){
			//room_goto(rm_keybinds)
		},
		size:{x:128,y:64},
		position:{x:128,y:64+70+70},
		sizeMod:0
	},
]

enum settingTypes{
	toggle,
	slider,
	realValue,
}

function setting(_type,_name,_displayName,_toolTip="") constructor{
	type=_type
	name=_name
	displayName=_displayName
	toolTip=_toolTip
	size=1
	minimumValue=-100
	maximumValue=100
	function update_size(){
		size-=(size-1)/20
	}
}

function setting_set_value(_setting,_variable,_value){
	for(var i=0;i<array_length(settings);i++)
	{
		if(settings.name==_setting)
		{
			variable_struct_set(_setting,_variable,_value)
		}
	}
}

settings=[]

array_push(settings,new setting(settingTypes.toggle,"epilepsyMode","Epilepsy Mode"))

array_push(settings,new setting(settingTypes.toggle,"showKeys","Show Inputs"))

array_push(settings,new setting(settingTypes.toggle,"deltaTime","Delta Time"))