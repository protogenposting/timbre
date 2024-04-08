/// @description Insert description here
// You can write your code in this editor

paused=false

axeRotations=[0,0]

early=0

perfect=0

late=0

if(global.song!=-4)
{
	songID=global.song
}
else
{
	songID=snd_song1
}

totalScore=0

combo=0

misses=0

hitMessage="..."

hitTime=1

bpm=250

currentBeat=0

currentFracBeat=0

barPercentage=0

audio=-4

songMilliseconds=0

gridSize=512

background=layer_get_id("Background")

songLength=[audio_sound_length(songID)*1000,audio_sound_length(songID)/(60/bpm)]

lastLStickRotation=0

lastRStickRotation=0

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

if(bpm>180)
{
	gridSize/=(bpm/180)
}

for(var i=0;i<array_length(notes);i++)
{
	notes[i].wasHit=false
}

turns=get_turns()

function point_between_points(x1,y1,x2,y2,percentage)
{
	var currentDirection=point_direction(x1,y1,x2,y2)
	var currentDistance=point_distance(x1,y1,x2,y2)*percentage
	
	var _x=lengthdir_x(currentDistance,currentDirection)
	var _y=lengthdir_y(currentDistance,currentDirection)
	
	
	return {x: x1+_x,y: y1+_y}
}

loopSize=64

function create_points(){
	var beatLength=60/bpm
	var pointArray=[]
	var currentDirection=0
	var _x=room_width/2
	var _y=room_height/2
	array_push(pointArray,{x:_x,y:_y,type:noteTypes.turn,beat: 0, timeMS: 0, wasHit:true ,direction: 0})
	var lastBeat=0
	var lastBeatFrom=0
	
	for(var i=0;i<array_length(turns);i++)
	{
		var gridSizeCurrent=gridSize*(turns[i].beat-lastBeatFrom)
		if(pointArray[i].type==noteTypes.turn)
		{
			_x+=lengthdir_x(gridSizeCurrent,currentDirection)
			_y+=lengthdir_y(gridSizeCurrent,currentDirection)
		}
		lastBeat=max(turns[i].beat,lastBeat)
		var _type=noteTypes.turn
		if(i<array_length(turns)-1&&turns[i].direction*90==turns[i+1].direction*90)
		{
			_type=noteTypes.loop
			//show_message(i)
		}
		var _pointBeat=turns[i].beat
		var tempDirection=turns[i].direction
		array_push(pointArray,{x:_x,y:_y,type: _type,beat: _pointBeat, timeMS: _pointBeat*beatLength*1000, wasHit:false,direction: tempDirection})
		lastBeatFrom=turns[i].beat
		currentDirection=turns[i].direction*90
	}
	
	var lastLength=songLength[1]-lastBeat
	_x+=lengthdir_x(gridSize*lastLength,currentDirection)
	_y+=lengthdir_y(gridSize*lastLength,currentDirection)
	var _pointBeat=songLength[1]
	array_push(pointArray,{x:_x,y:_y,type:noteTypes.turn,beat: _pointBeat, timeMS: _pointBeat*beatLength*1000, wasHit:false,direction: currentDirection})
	
	for(var i=0;i<array_length(pointArray);i++)
	{
		pointArray[i].wasHit=false
		for(var o=0; o<array_length(notes);o++)
		{
			if(notes[o].beat>=pointArray[i].beat&&notes[o].beat<pointArray[i+1].beat&&!notes[o].wasHit)
			{
				var percentage=(notes[o].beat-pointArray[i].beat)/(pointArray[i+1].beat-pointArray[i].beat)
				var _beatDist=abs(pointArray[i+1].beat-pointArray[i].beat)
				var _dir=pointArray[i].direction*90
				var dist=point_between_points(pointArray[i].x,pointArray[i].y,pointArray[i+1].x,pointArray[i+1].y,percentage)
				if(pointArray[i].type==noteTypes.loop)
				{
					var _dist2=in_out_between_points(0,0,
					-lengthdir_x(loopSize*2*_beatDist,_dir),
					-lengthdir_y(loopSize*2*_beatDist,_dir),percentage)
					dist.x=pointArray[i].x
					dist.y=pointArray[i].y
					dist.x+=_dist2.x
					dist.y+=_dist2.y
				}
				var dir=notes[o].direction*90
				
				var _current180=loop_rotation(_dir+180)
				
				notes[o].x=dist.x+lengthdir_x(64,dir)
				notes[o].y=dist.y+lengthdir_y(64,dir)
				notes[o].color=dir
				notes[o].timeMS=notes[o].beat*beatLength*1000
				notes[o].wasHit=false
			}
		}
	}
	pointArray[0].wasHit=true
	pointArray=sort_array(pointArray)
	notes=sort_array(notes)
	return pointArray
}

currentPoint=0
iteration=0

try{
	points=create_points()
}
catch(e)
{
	show_message(e)
}

msWindow=125

if(bpm>120)
{
	msWindow/=(bpm/120)
	if(msWindow<50)
	{
		msWindow=50
	}
}

var msWindowTemp=msWindow

timings=[{distance:msWindow/7,name:"Perfect!"},{distance:msWindow/5,name:"Good"},{distance:msWindow/3,name:"Ok"},{distance:msWindow,name:"Doodoo..."}]

function get_timing(time)
{
	for(var i=0;i<array_length(timings);i++)
	{
		if(abs(time)<timings[i].distance)
		{
			return timings[i].name+" "+string(time)
		}
	}
	return "???"
}

attackKey=[]

turnKey=[]

previousPlayerPos={x:0,y:0}

cameraOffset={x:0,y:0}

playerFrame=0

axeFrames=[0,0]

alarm[0]=60/12

finished=false

finishTimer=0

finishTimerLast=0

finishHitSound=snd_slap

fullCombo=true

totalPossibleScore=msWindow*(array_length(points)+array_length(notes))

accuracyList=[]

function get_accuracy(){
	var accuracy=0
	for(var i=0;i<array_length(accuracyList);i++)
	{
		accuracy+=accuracyList[i]
	}
	return (accuracy/array_length(accuracyList))*100
}

showingFinalMessage=false

ranks=[{percent:100,name:"P",messages:["PHENOMINAL!","P is for... PLEASE HAVE MY BABIES"]},
{percent:95,name:"S",messages:["OMG UR SO GOOD!","S is for... SANS UNDERTALE?!?!?!?!"]},
{percent:85,name:"A",messages:["Great job!","A is for... AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"]},
{percent:75,name:"B",messages:["Cool!","B is for... BOOTYHOLE"]},
{percent:50,name:"C",messages:["Good job i guess","C is for... corn!"]},
{percent:30,name:"D",messages:["Needs some work...","D is for... Detention! >:("]},
{percent:0,name:"F",messages:["Did you even try?","F is for... FIVE NIGHT FREDDY?!?!?!?"]}]

function get_rank(accuracyPercentage){
	for(var i=0;i<array_length(ranks);i++)
	{
		if(accuracyPercentage>=ranks[i].percent)
		{
			return ranks[i].name
		}
	}
	return "???"
}

function get_rank_id_string(accuracyPercentage){
	for(var i=0;i<array_length(ranks);i++)
	{
		if(accuracyPercentage==ranks[i].name)
		{
			return i
		}
	}
	return 8
}

function get_rank_id(accuracyPercentage){
	for(var i=0;i<array_length(ranks);i++)
	{
		if(accuracyPercentage>=ranks[i].percent)
		{
			return i
		}
	}
	return -4
}

turnKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.turning.left)
turnKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.turning.right)
turnKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.turning.up)
turnKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.turning.down)

turnKeyReleased[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.turning.left)
turnKeyReleased[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.turning.right)
turnKeyReleased[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.turning.up)
turnKeyReleased[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.turning.down)

attackKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.attacking.left)
attackKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.attacking.right)
attackKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.attacking.up)
attackKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.attacking.down)

attackKeyReleased[noteDirections.left]=keyboard_check_released(global.keyboardBinds.attacking.left)
attackKeyReleased[noteDirections.right]=keyboard_check_released(global.keyboardBinds.attacking.right)
attackKeyReleased[noteDirections.up]=keyboard_check_released(global.keyboardBinds.attacking.up)
attackKeyReleased[noteDirections.down]=keyboard_check_released(global.keyboardBinds.attacking.down)

turnKeyHold[noteDirections.left]=keyboard_check(global.keyboardBinds.turning.left)
turnKeyHold[noteDirections.right]=keyboard_check(global.keyboardBinds.turning.right)
turnKeyHold[noteDirections.up]=keyboard_check(global.keyboardBinds.turning.up)
turnKeyHold[noteDirections.down]=keyboard_check(global.keyboardBinds.turning.down)