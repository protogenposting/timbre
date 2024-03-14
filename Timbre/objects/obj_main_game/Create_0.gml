/// @description Insert description here
// You can write your code in this editor

paused=false

axeRotations=[0,0]

if(global.song!=-4)
{
	songID=global.song
}
else
{
	songID=snd_song1
}

bpm=250

currentBeat=0

currentFracBeat=0

barPercentage=0

audio=-4

songMilliseconds=0

gridSize=256

songLength=[audio_sound_length(songID)*1000,audio_sound_length(songID)/(60/bpm)]

function loop_rotation(rot){
	while(rot>=360)
	{
		rot-=360
	}
	while(rot<0)
	{
		rot+=360
	}
	return rot
}

function get_inverse(directionType){
	directionType+=180
	if(directionType>=360)
	{
		directionType-=360
	}
	return directionType
}

function remap(value, left1, right1, left2, right2) {
  return left2 + (value - left1) * (right2 - left2) / (right1 - left1);
}

function get_turns(){
	var array=[]
	for(var i=0;i<array_length(notes);i++)
	{
		if(notes[i].type==noteTypes.turn)
		{
			array_push(array,notes[i])
			array_delete(notes,i,1)
			i--
		}
	}
	return array
}

offset=0

notes=[]

if(global.levelData!=-4)
{
	for(var i=0;i<array_length(global.levelData.notes);i++)
	{
		notes[i]=global.levelData.notes[i]
	}
	bpm=global.levelData.bpm
	offset=global.levelData.offset
}

array_sort(notes,function(elm1, elm2)
{
    return elm1.beat - elm2.beat;
})

for(var i=0;i<array_length(notes);i++)
{
	notes[i].wasHit=false
}

turns=get_turns()

array_sort(turns,function(elm1, elm2)
{
    return elm1.beat - elm2.beat;
})

function point_between_points(x1,y1,x2,y2,percentage)
{
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	
	return {x: x1+_x,y: y1+_y}
}

function create_points(){
	var beatLength=60/bpm
	var pointArray=[]
	var currentDirection=0
	var _x=room_width/2
	var _y=room_height/2
	array_push(pointArray,{x:_x,y:_y,beat: 0, timeMS: 0, wasHit:true ,direction: 0})
	var lastBeat=0
	var lastBeatFrom=0
	
	array_sort(turns,function(elm1, elm2)
	{
	    return elm1.beat - elm2.beat;
	})
	
	for(var i=0;i<array_length(turns);i++)
	{
		var gridSizeCurrent=gridSize*(turns[i].beat-lastBeatFrom)
		show_message(turns)
		show_message(turns[i].beat-lastBeatFrom)
		_x+=lengthdir_x(gridSizeCurrent,currentDirection)
		_y+=lengthdir_y(gridSizeCurrent,currentDirection)
		lastBeat=max(turns[i].beat,lastBeat)
		var _pointBeat=turns[i].beat
		var tempDirection=turns[i].direction
		array_push(pointArray,{x:_x,y:_y,beat: _pointBeat, timeMS: _pointBeat*beatLength*1000, wasHit:false,direction: tempDirection})
		lastBeatFrom=turns[i].beat
		currentDirection=turns[i].direction*90
	}
	
	var lastLength=songLength[1]-lastBeat
	_x+=lengthdir_x(gridSize*lastLength,currentDirection)
	_y+=lengthdir_y(gridSize*lastLength,currentDirection)
	var _pointBeat=songLength[1]
	array_push(pointArray,{x:_x,y:_y,beat: _pointBeat, timeMS: _pointBeat*beatLength*1000, wasHit:false,direction: currentDirection})
	
	for(var i=0;i<array_length(pointArray);i++)
	{
		for(var o=0; o<array_length(notes);o++)
		{
			if(notes[o].beat>=pointArray[i].beat&&notes[o].beat<pointArray[i+1].beat&&!notes[o].wasHit)
			{
				var percentage=(notes[o].beat-pointArray[i].beat)/(pointArray[i+1].beat-pointArray[i].beat)
				var dist=point_between_points(pointArray[i].x,pointArray[i].y,pointArray[i+1].x,pointArray[i+1].y,percentage)
				var dir=notes[o].direction*90
				notes[o].x=dist.x+lengthdir_x(32,dir)
				notes[o].y=dist.y+lengthdir_y(32,dir)
				notes[o].timeMS=notes[o].beat*beatLength*1000
			}
		}
	}
	return pointArray
}

array_sort(notes,function(elm1, elm2)
{
    return elm1.beat - elm2.beat;
})

currentPoint=0
iteration=0

points=create_points()

msWindow=100

attackKey=[]

turnKey=[]

previousPlayerPos={x:0,y:0}

cameraOffset={x:0,y:0}