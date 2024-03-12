/// @description Insert description here
// You can write your code in this editor
songID=snd_song1

bpm=250/4

currentBeat=0

currentFracBeat=0

barPercentage=0

audio=-4

songMilliseconds=0

gridSize=64

songLength=[audio_sound_length(songID)*1000,audio_sound_length(songID)/(60/bpm)]

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

enum noteTypes{
	log,
	turn,
}

enum noteDirections{
	right,
	up,
	left,
	down,
}

notes=[{beat: 2, type: noteTypes.log,direction: noteDirections.up},{beat: 3, type: noteTypes.log,direction: noteDirections.left},{beat: 2, type: noteTypes.turn,direction: noteDirections.up},{beat: 2.75, type: noteTypes.turn,direction: noteDirections.left},{beat: 4, type: noteTypes.turn,direction: noteDirections.down},{beat: 6.25, type: noteTypes.turn,direction: noteDirections.right}]

turns=get_turns()

function create_points(){
	var pointArray=[]
	var currentDirection=0
	var _x=room_width/2
	var _y=room_height/2
	array_push(pointArray,{x:_x,y:_y,beat: 0})
	var lastBeat=0
	var lastBeatFrom=0
	for(var i=0;i<array_length(turns);i++)
	{
		var gridSizeCurrent=gridSize*(turns[i].beat-lastBeatFrom)
		_x+=lengthdir_x(gridSizeCurrent,currentDirection)
		_y+=lengthdir_y(gridSizeCurrent,currentDirection)
		lastBeat=max(turns[i].beat,lastBeat)
		var _pointBeat=turns[i].beat
		array_push(pointArray,{x:_x,y:_y,beat: _pointBeat})
		lastBeatFrom=turns[i].beat
		currentDirection=turns[i].direction*90
	}
	var lastLength=songLength[1]-lastBeat
	_x+=lengthdir_x(gridSize*lastLength,currentDirection)
	_y+=lengthdir_y(gridSize*lastLength,currentDirection)
	var _pointBeat=songLength[1]
	array_push(pointArray,{x:_x,y:_y,beat: _pointBeat})
	return pointArray
}

currentPoint=0
iteration=0

points=create_points()

function point_between_points(x1,y1,x2,y2,percentage)
{
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	return {x: x1+_x,y: y1+_y}
}