/// @description Insert description here
// You can write your code in this editor

previousPlayerPos={x:0,y:0}

paused=false

axeRotations=[0,0,0,0]

if(global.gamemode==1)
{
	axeSpinSpeeds=[0,0,0,0]
}

danceFromCenter={x:0,y:0}

danceTime=30

animationEnded=false

function dance(note){
	image_index=0
	if(note.direction==noteDirections.left)
	{
		sprite_index=sprites.acornLeft
	}
	if(note.direction==noteDirections.right)
	{
		sprite_index=sprites.acornRight
	}
	if(note.direction==noteDirections.up)
	{
		sprite_index=sprites.acornUp
	}
	if(note.direction==noteDirections.down)
	{
		sprite_index=sprites.acornDown
	}
	spriteResetStall=30
	
	animationEnded=false
}

afterImages=[0,0,0]

startTime=current_time

early=0

perfect=0

late=0

shakeTimer=0

shakes=[]

if(global.song!=-4)
{
	songID=global.song
}
else
{
	songID=snd_song1
}

lyrics=[{text:"",beat:0}]

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

bobs=[]

songMilliseconds=0

gridSize=512*global.moveSpeed

background=layer_background_get_id(layer_get_id("Background"))

songLength=[audio_sound_length(songID)*1000,audio_sound_length(songID)/(60/bpm)]

lastLStickRotation=0

lastRStickRotation=0

comboMissTimer=0

comboDanceAmount=50

comboPrevious=0

function rotate_axes(attacks){
	var currentDirection=points[currentPoint].direction*90
	if(!global.improvedControls)
	{
		var horizontalDirection=1
		if(currentDirection==270)
		{
			horizontalDirection=-1
		}
		if(attacks[noteDirections.left]&&horizontalDirection>0||attacks[noteDirections.right]&&horizontalDirection<0)
		{
			axeRotations[0]=-90
			audio_play_sound(snd_swipe,1000,false)
		}
		if(attacks[noteDirections.right]&&horizontalDirection>0||attacks[noteDirections.left]&&horizontalDirection<0)
		{
			axeRotations[1]=-90
			audio_play_sound(snd_swipe,1000,false)
		}
		if(attacks[noteDirections.down])
		{
			axeRotations[0]=45
			axeRotations[1]=45
			audio_play_sound(snd_swipe,1000,false)
		}
		if(attacks[noteDirections.up])
		{
			axeRotations[0]=-90
			axeRotations[1]=-90
			audio_play_sound(snd_swipe,1000,false)
		}
		
	}
	else
	{
		if(attacks[loop_rotation((currentDirection+90))/90])
		{
			axeRotations[0]=-90
			audio_play_sound(snd_swipe,1000,false)
		}
		if(attacks[loop_rotation((currentDirection-90))/90])
		{
			axeRotations[1]=-90
			audio_play_sound(snd_swipe,1000,false)
		}
		if(attacks[loop_rotation((currentDirection+180))/90])
		{
			axeRotations[0]=45
			axeRotations[1]=45
			audio_play_sound(snd_swipe,1000,false)
		}
		if(attacks[loop_rotation((currentDirection))/90])
		{
			axeRotations[0]=-90
			axeRotations[1]=-90
			audio_play_sound(snd_swipe,1000,false)
		}
	}
}

comboParticles=-4

function miss(struct)
{
	part_system_destroy(comboParticles)
	comboParticles=-4
	audio_play_sound(snd_spinout,1000,false)
	struct.wasHit=2
	misses++
	fullCombo=false
	if(combo>5)
	{
		comboMissTimer=50
		var _aud=audio_play_sound(snd_combo_loss,1000,false)
		audio_sound_gain(_aud,3,0)
	}
	combo=0
	array_push(accuracyList,0)
}

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
		if(notes[i].type==noteTypes.turn||notes[i].type==noteTypes.spider||notes[i].type==noteTypes.mine)
		{
			array_push(array,notes[i])
			array_delete(notes,i,1)
			i--
		}
	}
	return array
}

notes=[]

if(global.levelData!=-4)
{
	var notesToGet=global.levelData.notes

	if(global.currentDifficulty==1)
	{
		notesToGet=global.levelData.notesHard
	}
	if(global.currentDifficulty==2)
	{
		notesToGet=global.levelData.notesEasy
	}
	for(var i=0;i<array_length(notesToGet);i++)
	{
		notes[i]=notesToGet[i]
	}
	sort_note_array(notes)
	
	if(variable_struct_exists(global.levelData,"lyrics"))
	{
		lyrics=global.levelData.lyrics
	}
	
	if(variable_struct_exists(global.levelData,"shakes"))
	{
		shakes=global.levelData.shakes
	}
	
	bpm=global.levelData.bpm
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
	var _bobAmount=array_length(turns)/2
	var beatLength=60/bpm
	var pointArray=[]
	randomize()
	var currentDirection=0
	var _x=room_width/2
	var _y=room_height/2
	array_push(pointArray,
	{x:_x,y:_y,type:noteTypes.turn,beat: 0, timeMS: 0, 
		wasHit:true ,direction: currentDirection,
		continuing:false,color:c_white,release:false})
	var lastBeat=0
	var lastBeatFrom=0
	
	var _spidersQueued=[]
	
	for(var i=0;i<array_length(turns);i++)
	{
		var gridSizeCurrent=gridSize*(turns[i].beat-lastBeatFrom)
		if(pointArray[i].type!=noteTypes.spider)
		{
			_x+=lengthdir_x(gridSizeCurrent,currentDirection)
			_y+=lengthdir_y(gridSizeCurrent,currentDirection)
		}
		
		var _color=c_white
		if(turns[i].direction==noteDirections.left)
		{
			_color=$ff2d2d
		}
		else if(turns[i].direction==noteDirections.right)
		{
			_color=$2d3eff
		}
		else if(turns[i].direction==noteDirections.up)
		{
			_color=$41ff2d
		}
		else if(turns[i].direction==noteDirections.down)
		{
			_color=$f6ff2d
		}
		lastBeat=max(turns[i].beat,lastBeat)
		var _type=turns[i].type
		var _pointBeat=turns[i].beat
		var tempDirection=turns[i].direction
		if(turns[i].type!=noteTypes.mine)
		{
			if(i>1&&(turns[i].beat-turns[i-1].beat)==0&&turns[i-1].type!=noteTypes.mine)
			{
				currentDirection=(turns[i].direction*90+turns[i-1].direction*90)/2
				if(abs(turns[i].direction*90-turns[i-1].direction*90)>180)
				{
					currentDirection+=180
				}
				show_debug_message("diagonal at "+string(i))
				show_debug_message(currentDirection)
				//_color=c_purple
				//pointArray[i-1].color=c_purple
			}
			else
			{
				currentDirection=turns[i].direction*90
			}
		}
		array_push(pointArray,{x:_x,y:_y,type: _type,beat: _pointBeat, 
			timeMS: _pointBeat*beatLength*1000, wasHit:false,direction: tempDirection,
			continuing:false,color: _color,release:false})
		
		for(var o=0;o<array_length(_spidersQueued);o++)
		{
			if(pointArray[i].direction==pointArray[_spidersQueued[o]].direction)
			{
				pointArray[_spidersQueued[o]].endNote=i
				pointArray[i].release=true
				array_delete(_spidersQueued,o,1)
				break;
			}
		}
		
		lastBeatFrom=turns[i].beat
		if(pointArray[i].type==noteTypes.spider)
		{
			array_push(_spidersQueued,i)
		}
	}
	
	var lastLength=songLength[1]-lastBeat
	_x+=lengthdir_x(gridSize*lastLength,currentDirection)
	_y+=lengthdir_y(gridSize*lastLength,currentDirection)
	var _pointBeat=songLength[1]+100
	array_push(pointArray,{x:_x,y:_y,
		type:noteTypes.turn,beat: _pointBeat, 
		timeMS: _pointBeat*beatLength*1000, 
		wasHit:true,direction: currentDirection,
		continuing:false,color:c_white,release:false})
	
	for(var i=0;i<array_length(pointArray);i++)
	{
		pointArray[i].wasHit=false
		var _direction=pointArray[i].direction*90
		if(pointArray[i].type==noteTypes.spider)
		{
			if(!variable_struct_exists(pointArray[i],"endNote"))
			{
				array_delete(pointArray,i,1)
				i--
				continue;
			}
		}
		for(var o=0; o<array_length(notes);o++)
		{
			var _lastBeat=-20000
			var _directionsOnThisBeat=[]
			if(notes[o].beat>=pointArray[i].beat&&notes[o].beat<pointArray[i+1].beat)
			{
				var percentage=(notes[o].beat-pointArray[i].beat)/(pointArray[i+1].beat-pointArray[i].beat)
				var _beatDist=abs(pointArray[i+1].beat-pointArray[i].beat)
				var _dir=pointArray[i].direction*90
				var dist=point_between_points(pointArray[i].x,pointArray[i].y,pointArray[i+1].x,pointArray[i+1].y,percentage)
				if(pointArray[i].type==noteTypes.spider)
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
				
				var directionID=pointArray[i].direction+1
				while(directionID>3)
				{
					directionID-=4
				}
				var lrDir=directionID
				if(lrDir==2)
				{
					lrDir=0
				}
				else if(dir==loop_rotation(_direction))
				{
					if(lrDir==0)
					{
						lrDir=2
					}
				}
				var _directions=[0,1,2,3]
				_directions[noteDirections.right]=array_index_looped_index(_directions,noteDirections.right+lrDir)
				_directions[noteDirections.left]=array_index_looped_index(_directions,noteDirections.left+lrDir)
				_directions[noteDirections.up]=array_index_looped_index(_directions,noteDirections.up+lrDir)
				_directions[noteDirections.down]=array_index_looped_index(_directions,noteDirections.down+lrDir)
				
				if(!global.improvedControls)
				{
					notes[o].intendedDirection=_directions[notes[o].direction]
				}
				else
				{
					notes[o].intendedDirection=notes[o].direction
				}
				
				notes[o].x=dist.x+lengthdir_x(64,dir)
				notes[o].y=dist.y+lengthdir_y(64,dir)
				notes[o].color=c_white
				if(dir==loop_rotation(_direction+90))
				{
					notes[o].color=c_green
					if(_dir/90==noteDirections.down)
					{
						notes[o].color=c_lime
					}
				}
				if(dir==loop_rotation(_direction-90))
				{
					notes[o].color=c_lime
					if(_dir/90==noteDirections.down)
					{
						notes[o].color=c_green
					}
				}
				if(dir==loop_rotation(_direction+180))
				{
					notes[o].color=c_black
					notes[o].startX=notes[o].x
					notes[o].startY=notes[o].y
					notes[o].intendedDirection=noteDirections.down
					if(global.gamemode==1)
					{
						notes[o].direction=loop_rotation(_direction)/90
						for(var e=0; e<array_length(notes);e++)
						{
							if(e==o)
							{
								continue;
							}
							if(notes[e].direction==notes[o].direction&&notes[e].beat==notes[o].beat)
							{
								array_delete(notes,o,1)
								break;
							}
						}
						o--
						continue;
					}
				}
				if(dir==loop_rotation(_direction))
				{
					notes[o].color=c_aqua
					notes[o].temporaryType=noteTypes.wall
					notes[o].startX=notes[o].x
					notes[o].startY=notes[o].y
				}
				
				notes[o].timeMS=notes[o].beat*beatLength*1000
				notes[o].wasHit=false
				_lastBeat=notes[o].beat
			}
		}
		if(irandom(3)>=3&&array_length(bobs)<_bobAmount&&i<array_length(pointArray)-1)
		{
			var bob={
				x:pointArray[i].x,
				y:pointArray[i].y,
				frame: irandom(1),
			}
			var _offset=point_between_points(pointArray[i].x,pointArray[i].y,pointArray[i+1].x,pointArray[i+1].y,random_range(0,1))
			bob.x=_offset.x+random_range(-128,128)
			bob.y=_offset.y+random_range(-128,128)
			var overlap=false
			for(var o=0;o<array_length(pointArray);o++)
			{
				if(point_distance(pointArray[o].x,pointArray[o].y,bob.x,bob.y)<=16)
				{
					overlap=true
				}
			}
			if(!overlap)
			{
				array_push(bobs,bob)
			}
		}
	}
	pointArray[0].wasHit=true
	pointArray=sort_note_array(pointArray)
	notes=sort_note_array(notes)
	return pointArray
}

currentPoint=0
iteration=0

points=create_points()

msWindow=210

var msWindowTemp=msWindow

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

function get_timing_id(time)
{
	for(var i=0;i<array_length(timings);i++)
	{
		if(abs(time)<timings[i].distance)
		{
			return i
		}
	}
	return 99999
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

function reset_timings()
{
	timings=[{distance:msWindow/30,name:"AMAZING!!!",result:1,sprite: spr_rating_amazing},
	{distance:msWindow/7,name:"Perfect!",result:1,sprite: spr_rating_perfect},
	{distance:msWindow/5,name:"Good",result:0.8,sprite: spr_rating_good},
	{distance:msWindow/3,name:"Ok",result:0.75,sprite: spr_rating_ok},
	{distance:msWindow*1000,name:"Dull...",result:0.5,sprite: spr_rating_dull},
	{distance:msWindow*20000,name:"WORST",result:0.5,sprite: spr_rating_dull}]
}

reset_timings()

trueAccuracyList=[]

function get_accuracy_population(){
	var listMinimum=0
	var listMaximum=0
	var accuracyListData=[]
	var populations=[]
	for(var i=0;i<array_length(trueAccuracyList);i++)
	{
		var _acc=snap(5,trueAccuracyList[i])
		listMaximum=max(listMaximum,_acc)
		listMinimum=min(listMinimum,_acc)
		if(!array_contains(populations,_acc))
		{
			array_push(populations,_acc)
		}
		array_push(accuracyListData,_acc)
	}
	sort_array(populations,function(a,b){return a>b})
	var endResult=array_create(array_length(populations))
	for(var i=0;i<array_length(accuracyListData);i++)
	{
		endResult[array_get_index(populations,accuracyListData[i])]++
	}
	return [endResult,listMinimum,listMaximum,populations]
}



function turn_off_keys(){
	turnKey[noteDirections.left]=false
	turnKey[noteDirections.right]=false
	turnKey[noteDirections.up]=false
	turnKey[noteDirections.down]=false

	turnKeyReleased[noteDirections.left]=false
	turnKeyReleased[noteDirections.right]=false
	turnKeyReleased[noteDirections.up]=false
	turnKeyReleased[noteDirections.down]=false

	attackKey[noteDirections.left]=false
	attackKey[noteDirections.right]=false
	attackKey[noteDirections.up]=false
	attackKey[noteDirections.down]=false

	attackKeyReleased[noteDirections.left]=false
	attackKeyReleased[noteDirections.right]=false
	attackKeyReleased[noteDirections.up]=false
	attackKeyReleased[noteDirections.down]=false

	turnKeyHold[noteDirections.left]=false
	turnKeyHold[noteDirections.right]=false
	turnKeyHold[noteDirections.up]=false
	turnKeyHold[noteDirections.down]=false
}
turn_off_keys()

function get_inputs(){
	if(global.usingController)
	{
		attackKey[noteDirections.left]=get_axis_pressed(4,0,-1)
		attackKey[noteDirections.right]=get_axis_pressed(4,0,1)
		attackKey[noteDirections.up]=get_axis_pressed(4,1,-1)
		attackKey[noteDirections.down]=get_axis_pressed(4,1,1)
	
		turnKey[noteDirections.left]=get_axis_pressed(5,0,-1)
		turnKey[noteDirections.right]=get_axis_pressed(5,0,1)
		turnKey[noteDirections.up]=get_axis_pressed(5,1,-1)
		turnKey[noteDirections.down]=get_axis_pressed(5,1,1)
	
		turnKeyReleased[noteDirections.left]=get_axis_pressed(5,0,0)
		turnKeyReleased[noteDirections.right]=get_axis_pressed(5,0,0)
		turnKeyReleased[noteDirections.up]=get_axis_pressed(5,1,0)
		turnKeyReleased[noteDirections.down]=get_axis_pressed(5,1,0)
	
		turnKeyHold[noteDirections.left]=gamepad_axis_value(5,0)<0
		turnKeyHold[noteDirections.right]=gamepad_axis_value(5,0)>0
		turnKeyHold[noteDirections.up]=gamepad_axis_value(5,1)<0
		turnKeyHold[noteDirections.down]=gamepad_axis_value(5,1)>0
	}
	else
	{
		attackKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.attacking.left)
		attackKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.attacking.right)
		attackKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.attacking.up)
		attackKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.attacking.down)
		
		attackKeyHold[noteDirections.left]=keyboard_check(global.keyboardBinds.attacking.left)
		attackKeyHold[noteDirections.right]=keyboard_check(global.keyboardBinds.attacking.right)
		attackKeyHold[noteDirections.up]=keyboard_check(global.keyboardBinds.attacking.up)
		attackKeyHold[noteDirections.down]=keyboard_check(global.keyboardBinds.attacking.down)
	
		turnKey[noteDirections.left]=keyboard_check_pressed(global.keyboardBinds.turning.left)
		turnKey[noteDirections.right]=keyboard_check_pressed(global.keyboardBinds.turning.right)
		turnKey[noteDirections.up]=keyboard_check_pressed(global.keyboardBinds.turning.up)
		turnKey[noteDirections.down]=keyboard_check_pressed(global.keyboardBinds.turning.down)
	
		turnKeyReleased[noteDirections.left]=keyboard_check_released(global.keyboardBinds.turning.left)
		turnKeyReleased[noteDirections.right]=keyboard_check_released(global.keyboardBinds.turning.right)
		turnKeyReleased[noteDirections.up]=keyboard_check_released(global.keyboardBinds.turning.up)
		turnKeyReleased[noteDirections.down]=keyboard_check_released(global.keyboardBinds.turning.down)
	
		turnKeyHold[noteDirections.left]=keyboard_check(global.keyboardBinds.turning.left)
		turnKeyHold[noteDirections.right]=keyboard_check(global.keyboardBinds.turning.right)
		turnKeyHold[noteDirections.up]=keyboard_check(global.keyboardBinds.turning.up)
		turnKeyHold[noteDirections.down]=keyboard_check(global.keyboardBinds.turning.down)
	}
}

particles=[]

spriteResetStall=0

sprites={
	player: spr_player,
	arrow: spr_reverse_arrow,
	arrowOutline: spr_reverse_arrow_outline,
	log: spr_log,
	logOutline: spr_log_outline,
	wall: spr_wall,
	web: spr_loop,
	spiderStart: spr_spider_idle,
	spiderEnd: spr_spider_hit,
	spiderGrab: spr_spider,
	axe: spr_axes,
	grass: spr_grass_epilepsy,
	bob: spr_bob,
	badArrow: spr_bad_arrow,
	mine: spr_mine,
	path: spr_path,
	
	acornIdle: spr_acorn_idle,
	acornLeft: spr_acorn_left,
	acornRight: spr_acorn_right,
	acornUp: spr_acorn_up,
	acornDown: spr_acorn_down,
	
	acornDodge1: spr_acorn_dodge_1,
	acornDodge2: spr_acorn_dodge_2,
}


var _dir=""
if(global.selectedLevel!=-4)
{
	_dir=filename_dir(global.levels[global.selectedLevel].path)+"/"
}
else
{
	_dir=global.dataLocation+"/"
}

var _spritesToGet=struct_get_names(sprites)

for(var i=0;i<array_length(_spritesToGet);i++)
{
	var _file=_dir+_spritesToGet[i]+".gif"
	if(file_exists(_file))
	{
		var _oldSprite=variable_struct_get(sprites,_spritesToGet[i])
		var _frameDelays=[]
		var _sprite = sprite_add_gif(_file,0,0,_frameDelays)
		
		variable_struct_set(sprites,_spritesToGet[i],_sprite)
	}
}

botplayLeniency=10

function update_particles(){
	var particleUpdateTime=fps/120
	for(var i=0;i<array_length(particles);i++)
	{
		particles[i].updateTimer--
		if(particles[i].updateTimer<=0)
		{
			part_system_update(particles[i].id)
			particles[i].updateTimer=particleUpdateTime
			particles[i].time--
		}
		if(particles[i].time<=0)
		{
			part_system_destroy(particles[i].id)
			array_delete(particles,i,1)
			i--
			continue;
		}
	}
}