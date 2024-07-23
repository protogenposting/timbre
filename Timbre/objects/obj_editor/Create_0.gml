/// @description Insert description here
// You can write your code in this editor
function noteType(_type,_sprite) constructor{
	type = _type
	sprite = _sprite
}

name=""

songName="level.ogg"

currentDifficulty=0

turnTypes=[
	noteTypes.turn,
	noteTypes.mine
]

turnTypeSelected=0

notes=[]

notesToDraw=[]

notesHard=[]

notesEasy=[]

lyrics=[]

shakes=[]

difficulty=0

global.editing=true

currentBeat=0

artist="???"

currentFracBeat=0

barPercentage=0

offset=0

bpm=120

songLoaded=-4

audio=-4

currentZoom=4

zooms=[5,4,3,2,1,0.5,1/3,0.25,1/5,1/6,1/7,1/8,1/9,1/10]

zoom=1

startingBeat=0

difficultyAlpha=0

currentMenu=0

backgroundPoints=[]

gridSize=512

function generate_preview(_notes){
	backgroundPoints=[]
	_notes=sort_note_array(_notes)
	var _x=0
	var _y=0
	for(var i=0;i<array_length(_notes)-1;i++){
		if(_notes[i].type==noteTypes.turn)
		{
			var _distanceToNext=_notes[i+1].beat-_notes[i].beat
			array_push(backgroundPoints,{x: _x,y: _y, direction: _notes[i].direction*90,beat: _notes[i].beat,beatDistance: _distanceToNext,isSpider:false})
			var _direction=_notes[i].direction*90
			if(i>0&&(_notes[i-1].beat-_notes[i].beat)==0)
			{
				_direction=(_notes[i-1].direction+_notes[i].direction)/2
				if(abs(_notes[i].direction*90-_notes[i-1].direction*90)>180)
				{
					_direction+=2
				}
				_direction*=90
			}
			_x+=lengthdir_x(gridSize*_distanceToNext,_direction)
			_y+=lengthdir_y(gridSize*_distanceToNext,_direction)
		}
		if(_notes[i].type==noteTypes.spider)
		{
			var _distanceToNext=_notes[i+1].beat-_notes[i].beat
			array_push(backgroundPoints,{x: _x,y: _y, direction: _notes[i].direction*90,beat: _notes[i].beat,beatDistance: _distanceToNext,isSpider:true})
			//_x+=lengthdir_x(gridSize*_distanceToNext,_notes[i].direction*90)
			//_y+=lengthdir_y(gridSize*_distanceToNext,_notes[i].direction*90)
		}
	}
}

if(global.song!=-4)
{
	songLoaded=global.song
}
if(global.levelData!=-4)
{
	songName=global.levelData.songName
	if(variable_struct_exists(global.levelData,"notes"))
	{
		notes=global.levelData.notes
	}
	if(variable_struct_exists(global.levelData,"notesHard"))
	{
		notesHard=global.levelData.notesHard
	}
	if(variable_struct_exists(global.levelData,"notesEasy"))
	{
		notesEasy=global.levelData.notesEasy
	}
	bpm=global.levelData.bpm
	offset=global.levelData.offset
	name=global.dataLocation
	try{
		difficulty=global.levelData.difficulty
	}
	catch(e)
	{
		difficulty=0
	}
	try{
		artist=global.levelData.artist
	}
	catch(e)
	{
		difficulty=0
	}
	if(variable_struct_exists(global.levelData,"lyrics"))
	{
		lyrics=global.levelData.lyrics
	}
	if(variable_struct_exists(global.levelData,"shakes"))
	{
		shakes=global.levelData.shakes
	}
}

function save_level(_levelName,_songName){
	notes=sort_note_array(notes)
	var data={
		songName:_songName,
		bpm: obj_editor.bpm,
		offset: obj_editor.offset,
		difficulty: obj_editor.difficulty,
		artist: obj_editor.artist,
		lyrics: obj_editor.lyrics,
		shakes: obj_editor.shakes
	}
	if(array_length(notes)>0)
	{
		data.notes=notes
	}
	if(array_length(notesHard)>0)
	{
		data.notesHard=notesHard
	}
	if(array_length(notesEasy)>0)
	{
		data.notesEasy=notesEasy
	}
	save_file(data,global.saveLocation+"/data.json")
	return data
}
function load_song(_fileName){
	try{
		songLoaded=audio_create_stream(_fileName)
		global.songLength=audio_sound_length(songLoaded)
		audio_stop_all()
	}
	catch(e)
	{
		show_message(e)
	}
}

function load_level(_levelData){
	var directory=filename_path(_levelData)
	
	var directoryName=directory
	directoryName=string_delete(directoryName,string_length(directoryName),1)
	var directorySlash=string_last_pos("\\",directoryName)
	directoryName=string_copy(directoryName,directorySlash+1,9999)
	
	var struct=load_file(_levelData)
	if(struct!=false)
	{
		global.saveLocation=filename_dir(_levelData)
	
		global.wasSaved=true
		
		load_song(directory+struct.songName)
		songName=struct.songName
		bpm=struct.bpm
		offset=struct.offset
		try{
			difficulty=struct.difficulty
			artist=struct.artist
		}
		catch(e)
		{
			
		}
		if(variable_struct_exists(struct,"notes"))
		{
			notes=struct.notes
		}
		if(variable_struct_exists(struct,"notesHard"))
		{
			notesHard=struct.notesHard
		}
		if(variable_struct_exists(struct,"notesEasy"))
		{
			notesEasy=struct.notesEasy
		}
		if(variable_struct_exists(struct,"lyrics"))
		{
			lyrics=struct.lyrics
		}
		if(variable_struct_exists(struct,"shakes"))
		{
			shakes=struct.shakes
		}
		name=directoryName
		global.dataLocation=name
		button[4].name="name: "+directoryName
		generate_preview(notes)
	}	
}

function remap(value, left1, right1, left2, right2) {
  return left2 + (value - left1) * (right2 - left2) / (right1 - left1);
}

function note_on_beat(array,beat,type,noteDirection){
	for(var i=0;i<array_length(array);i++)
	{
		try{
			if(array[i].beat==beat&&array[i].type==type&&array[i].direction==noteDirection)
			{
				return i;
			}
		}
		catch(e)
		{
			
		}
	}
	return -1;
}

button[0]={
	name:"back",
	func: function(){
		//make this go to level select later
		room_goto(rm_menu)
		audio_stop_all()
	},
	size:{x:256,y:128},
	position:{x:200,y:200},
	sizeMod:0
}

button[1]={
	name:"save",
	func: function(){
		with(obj_editor)
		{
			if(name=="")
			{
				name=get_string("name",name)
			}
			global.levelData=save_level(name,songName)
			global.song=songLoaded
		}
	},
	size:{x:256,y:128},
	position:{x:200,y:328},
	sizeMod:0
}

button[2]={
	name:"load",
	func: function(){
		with(obj_editor)
		{
			var _levelDir=GetOpenFileName("","data.json","",@'Open')
			if(_levelDir!="")
			{
				load_level(_levelDir)
				global.levelData=save_level(name,songName)
			}
		}
	},
	size:{x:256,y:128},
	position:{x:200,y:328+128},
	sizeMod:0
}

button[3]={
	name:"add song",
	func: function(){
		with(obj_editor)
		{
			if(name!="")
			{
				var _levelDir=GetOpenFileName("","data.json","",@'Open')
				if(_levelDir!="")
				{
					file_copy(_levelDir,global.saveLocation+filename_name(_levelDir))
					songName=filename_name(_levelDir)
					load_song(global.saveLocation+filename_name(_levelDir))
				}
			}
			else
			{
				show_message("name the level first!")
			}
		}
	},
	size:{x:256,y:128},
	position:{x:200,y:328+128+128},
	sizeMod:0
}
button[4]={
	name:"name: "+obj_editor.name,
	func: function(){
		with(obj_editor)
		{
			name=get_string("name",name)
			artist=get_string("artist",artist)
		}
		name="name: "+obj_editor.name
	},
	size:{x:256,y:128},
	position:{x:200,y:328+128+128+128},
	sizeMod:0
}
button[5]={
	name:"play song",
	func: function(){
		with(obj_editor)
		{
			try{
				audio_stop_all()
				for(var i=0;i<array_length(notes);i++)
				{
					notes[i].wasHit=false
				}
				currentBeat=0
				audio=audio_play_sound(songLoaded,1000,false)
				var beatLength=60/bpm
				audio_sound_set_track_position(audio,beatLength*startingBeat)
			}
			catch(e)
			{
				show_message("no song loaded!")
			}
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200},
	sizeMod:0
}
button[6]={
	name:"stop song",
	func: function(){
		with(obj_editor)
		{
			try{
				audio_stop_all()
				audio=-4
			}
			catch(e)
			{
				show_message("no song loaded!")
			}
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128},
	sizeMod:0
}
button[7]={
	name:"change bpm",
	func: function(){
		with(obj_editor)
		{
			bpm=get_integer("bpm",bpm)
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128+128},
	sizeMod:0
}
button[8]={
	name:"test",
	func: function(){
		with(obj_editor)
		{
			audio_stop_all()
			if(name=="")
			{
				name=get_string("name",name)
			}
			global.levelData=save_level(name,songName)
			global.currentDifficulty=currentDifficulty
			global.song=songLoaded
			global.reloadFile=name
			global.dataLocation=name
			global.selectedLevel=-4
			room_goto(rm_gameplay)
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128+128+128},
	sizeMod:0
}
button[9]={
	name:"change difficulty",
	func: function(){
		with(obj_editor)
		{
			try{
				difficulty=get_integer("New Difficulty",difficulty)
				while(true)
				{
					try{
						show_message("changed to "+string(difficulty))
						return 0
					}
					catch(e)
					{
						show_message("invalid")
						difficulty=get_integer("New Difficulty",difficulty)
					}
				}
			}
			catch(e)
			{
				
			}
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128+128+128+128},
	sizeMod:0
}
button[10]={
	name:"Tutorial",
	func: function(){
		with(obj_editor)
		{
			url_open("https://www.youtube.com/watch?v=0304ugJuy5IZ")
		}
	},
	size:{x:256,y:64},
	position:{x:456,y:200-128},
	sizeMod:0
}
/*button[7]={
	name:"copy section",
	func: function(){
		with(obj_editor)
		{
			bpm=get_integer("bpm",bpm)
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128+128},
	sizeMod:0
}
button[8]={
	name:"paste section",
	func: function(){
		with(obj_editor)
		{
			bpm=get_integer("bpm",bpm)
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128+128+128},
	sizeMod:0
}*/
noteSounds=array_create(20,snd_hit_tree)
noteSounds[noteTypes.log]=snd_hit_tree
noteSounds[noteTypes.wall]=snd_hit_tree
noteSounds[noteTypes.turn]=snd_turn
noteSounds[noteTypes.spider]=snd_beat
noteSounds[noteTypes.mine]=snd_mine

noteSprites=array_create(20,spr_log)
noteSprites[noteTypes.log]=spr_log
noteSprites[noteTypes.wall]=spr_log
noteSprites[noteTypes.turn]=spr_reverse_arrow
noteSprites[noteTypes.spider]=spr_spider_idle
noteSprites[noteTypes.mine]=spr_mine