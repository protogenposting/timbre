event_inherited()

gooberLocation.y=room_height

audio_stop_all()

//audio_play_sound(snd_tutorial_sound,1000,true)

selectedLevel=-4

bpm=0

audio=-4

currentBeat=0

audio_destroy_stream(global.song)

global.song=-4

global.editing=false

global.selectedLevel=0

playerProgress=0

timeBetweenBeats=0.5

timeUntilNextBeat=0

beatTimer=0

currentBeat=0

offsets=[]

points=[
	{x:256,y:256},
	{x:256+256,y:256},
	{x:256,y:512},
	{x:256+256,y:512},
	{x:256+256,y:512+256}
]

axeRotations=[0,0]

function point_between_points(x1,y1,x2,y2,percentage)
{
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	
	return {x: x1+_x,y: y1+_y}
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
]