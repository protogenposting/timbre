/// @description Insert description here
// You can write your code in this editor
name=""

songName="level.ogg"

notes=[]

currentBeat=0

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

function save_level(_levelName,_songName){
	var data={songName:_songName,bpm: obj_editor.bpm, notes: obj_editor.notes,offset: obj_editor.offset}
	save_file(data,game_save_id+_levelName+"/data.json")
	return data
}
function load_song(_fileName){
	try{
		songLoaded=audio_create_stream(_fileName)
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
		load_song(directory+struct.songName)
		songName=struct.songName
		notes=struct.notes
		bpm=struct.bpm
		offset=struct.offset
		name=directoryName
		button[4].name="name: "+directoryName
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
			save_level(name,songName)
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
			var _levelDir=get_open_filename_ext("","data.json","/","LOAD A LEVEL")
			if(_levelDir!="")
			{
				load_level(_levelDir)
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
			var _levelDir=get_open_filename("","data.json")
			if(_levelDir!="")
			{
				file_copy(_levelDir,game_save_id+name+"/"+filename_name(_levelDir))
				songName=filename_name(_levelDir)
				load_song(game_save_id+name+"/"+filename_name(_levelDir))
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
				if(audio==-4)
				{
					audio=audio_play_sound(songLoaded,1000,false)
					var beatLength=60/bpm
					audio_sound_set_track_position(audio,beatLength*startingBeat +offset/1000)
				}
				else
				{
					audio_stop_sound(audio)
					audio=-4
				}
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
	name:"change bpm",
	func: function(){
		with(obj_editor)
		{
			bpm=get_integer("bpm",bpm)
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128},
	sizeMod:0
}
button[7]={
	name:"change offset",
	func: function(){
		with(obj_editor)
		{
			offset=get_integer("offset (in milliseconds)",offset)
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
			if(name=="")
			{
				name=get_string("name",name)
			}
			global.levelData=save_level(name,songName)
			global.song=songLoaded
			room_goto(rm_gameplay)
		}
	},
	size:{x:256,y:128},
	position:{x:456,y:200+128+128+128},
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
}