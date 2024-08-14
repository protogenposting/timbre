event_inherited()

minimumScrollSpeed=0.25

maximumScrollSpeed=6

gooberLocation.y=room_height

audio_stop_all()

selectedLevel=-4

yOffset=0

yOffsetSpeed=0

yOffsetMaxSpeed=25

songSpeedAlpha=1

selectingPlaylist=false

selectedPlaylistFunc=function(_playlistID){}

merps=[
	snd_merp1,
	snd_merp2,
	snd_merp3,
	snd_merp4,
	snd_merp5,
	snd_merp6,
	snd_merp7,
	snd_merp8,
	snd_merp9,
	snd_merp10,
]

bpm=0

grass=spr_grass

audio=-4

flowerIndex=0

currentBeat=0

previewNotes=[]

if(global.song!=-4)
{
	audio_destroy_stream(global.song)
}

global.song=-4

global.editing=false

noteDensity=0

moreStats=false

songLength=0

leafToTree=""

daniChance=0

sortMode=0

songMilliseconds=0

if(global.selectedLevel<0)
{
	wheelProgress=0
}

wheelProgress=global.selectedLevel

previousWheelDirection=0

wheelRotationProgress=0

readyUp=false

readyProgress=0

difflicultySelection=ds_map_create()

ds_map_add(difflicultySelection,0,{notes: "notesEasy",icon:spr_difficulty_button_easy,name:"Simple",equivelant:2})

ds_map_add(difflicultySelection,1,{notes: "notes",icon:spr_difficulty_button_normal,name:"Normal",equivelant:0})

ds_map_add(difflicultySelection,2,{notes: "notesHard",icon:spr_difficulty_button_hard,name:"Ultra",equivelant:1})

enum sortTypes{
	difficulty,
	bpm
}

sortNames[sortTypes.difficulty]="Difficulty"
sortNames[sortTypes.bpm]="Bpm"

function initialize_level(levelID){
	var _levels=get_playlist_levels(global.currentPlaylist)
	if(array_length(_levels)<=0)
	{
		return 0
	}
	if(levelID<0)
	{
		levelID=0
	}
	var _path=_levels[levelID].path
	var _file=load_file(_path)
	var hasNormal=true
	var hasEasy=false
	var hasHard=false
	if(_file!=false)
	{
		_levels[levelID].difficulty=_file.difficulty
		if(variable_struct_exists(_file,"notesHard"))
		{
			hasHard=true
		}
		if(!variable_struct_exists(_file,"notes"))
		{
			hasNormal=false
		}
		if(variable_struct_exists(_file,"notesEasy"))
		{
			hasEasy=true
		}
	}
	_levels[levelID].availableDifficulties=[hasEasy,hasNormal,hasHard]
	if(obj_level_select.selectedLevel==levelID)
	{
		//audio_stop_sound(global.song)
		global.song=-4
		currentShroomPose=-1
		obj_level_select.selectedLevel=-4
		return false
	}
	
	if(_file==false)
	{
		show_message("failed loading, data file is broken or missing")
		if(show_question("relocate data file?"))
		{
			var _newFile=GetOpenFileName(".json","data.json","", @'Open')
			if(_newFile!="")
			{
				_levels[levelID].path=_newFile
			}
		}
	}
	else
	{
		try{
			try
			{
				audio_destroy_stream(global.song)
			}
			catch(e)
			{
				
			}
			var _leafToTreeRatio=array_create(10)
			var beatLength=60/_file.bpm
			var _noteBeats=[]
			try{
				_levels[levelID].difficulty=_file.difficulty
				_levels[levelID].artist=_file.artist
			}
			catch(e)
			{
							
			}
						
			global.song=audio_create_stream(filename_dir(_path)+"\\"+_file.songName)
			global.levelData=_file
						
			obj_level_select.grass=spr_grass
						
			if(file_exists(filename_dir(_path)+"\\"+"grass.png"))
			{
				obj_level_select.grass=sprite_add(filename_dir(_path)+"\\"+"grass.png",2,false,false,32,32)
			}
						
			obj_level_select.songMilliseconds=0
			
			
		}
		catch(e)
		{
			show_message(e)
		}
	}
}

if(array_length(global.levels)>0)
{
	initialize_level(wheelProgress)
}

function reset_buttons()
{
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
		name: "Add Song",
		func: function(){
			var _file=GetOpenFileName(".json","data.json","", @'Open')
			if(_file!="")
			{
				add_song(_file)
				obj_level_select.wheelProgress=0
				with(obj_level_select)
				{
					initialize_level(wheelProgress)
					alarm[1]=1
					alarm[2]=1
				}
			}
		},
		size:{x:128,y:64},
		position:{x:128+140,y:64},
		sizeMod:0
	},
	{
		name: "Add Pack",
		func: function(){
			var _file=GetOpenFileName(".json","pack.json","", @'Open')
			if(_file!="")
			{
				var _str=load_file(_file)
				if(_str!=false)
				{
					try{
						for(var i=0;i<array_length(_str.levels);i++)
						{
							var _packDirectory=filename_dir(_file)
							add_song(_packDirectory+"/"+_str.levels[i]+"/data.json")
						}
						obj_level_select.wheelProgress=0
						with(obj_level_select)
						{
							initialize_level(wheelProgress)
							alarm[1]=1
							alarm[2]=1
						}
					}
					catch(e)
					{
						show_message("the file(s) are corrupted or not valid jsons")
					}
				}
				else
				{
					show_message("the file(s) you entered either don't exist or are corrupted")
				}
			}
		},
		size:{x:128,y:64},
		position:{x:128+140+140,y:64},
		sizeMod:0
	},
	/*
	{
		name: "More Stats",
		func: function(){
			obj_level_select.moreStats=!obj_level_select.moreStats
			audio_play_sound(snd_tab_move_back,1000,false)
			with(obj_level_select)
			{
				reset_buttons()
			}
		},
		size:{x:128,y:64},
		position:{x:128+140+140,y:64},
		sizeMod:0
	},*/
	
	/*{
		name: "Sort Mode: "+obj_level_select.sortNames[obj_level_select.sortMode],
		func: function(){
			obj_level_select.sortMode++
			if(obj_level_select.sortMode>sortTypes.bpm)
			{
				obj_level_select.sortMode=0
			}
			name="Sort Mode: "+obj_level_select.sortNames[obj_level_select.sortMode]
			obj_level_select.alarm[1]=2
		},
		size:{x:128,y:64},
		position:{x:128+140+140+140,y:64},
		sizeMod:0
	},*/]
	if(array_length(global.levels)>0)
	{
		global.levels=sort_songlist(global.levels)
	}
	for(var i=0;i<array_length(global.levels);i++)
	{
		var _directory=filename_dir(global.levels[i].path)
		
		var _cover=_directory+"/cover.png"
		
		if(file_exists(_cover))
		{
			global.levels[i].cover=sprite_add(_cover,1,false,false,128,128)
		}
		else
		{
			global.levels[i].cover=spr_no_cover
		}
	}
	if(array_length(global.levels)>0)
	{
		initialize_level(wheelProgress)
	}
	/*for(var i=0;i<array_length(global.levels);i++)
	{
		var _file=load_file(global.levels[i].path)
		var hasNormal=true
		var hasEasy=false
		var hasHard=false
		if(_file!=false)
		{
			if(variable_struct_exists(_file,"notesHard"))
			{
				hasHard=true
			}
			if(!variable_struct_exists(_file,"notes"))
			{
				hasNormal=false
			}
			if(variable_struct_exists(_file,"notesEasy"))
			{
				hasEasy=true
			}
		}
		var _struct={
			name: global.levels[i].name,
			path: global.levels[i].path,
			id:i,
			color: array_index_looped(menuColors,i),
			func: function(){
				if(!availableDifficulties[global.currentDifficulty])
				{
					global.currentDifficulty=0
				}
				if(obj_level_select.selectedLevel==id)
				{
					audio_stop_sound(global.song)
					global.song=-4
					currentShroomPose=-1
					obj_level_select.selectedLevel=-4
					return false
				}
				var _file=load_file(path)
				if(_file==false)
				{
					show_message("failed loading, data file is broken or missing")
					if(show_question("relocate data file?"))
					{
						var _newFile=GetOpenFileName(".json","data.json","", @'Open')
						if(_newFile!="")
						{
							global.levels[id].path=_newFile
						}
					}
				}
				else
				{
					try{
						audio_destroy_stream(global.song)
						var _leafToTreeRatio=array_create(10)
						var beatLength=60/_file.bpm
						var _noteBeats=[]
						try{
							global.levels[id].difficulty=_file.difficulty
						}
						catch(e)
						{
							
						}
						
						var notesToGet=_file.notes
						if(global.currentDifficulty==1)
						{
							notesToGet=_file.notesHard
						}
						if(global.currentDifficulty==2)
						{
							notesToGet=_file.notesEasy
						}
						
						for(var i=0;i<array_length(notesToGet)-1;i++)
						{
							array_push(_noteBeats,abs(notesToGet[i].beat-notesToGet[i+1].beat))
							notesToGet[i].timeMS=notesToGet[i].beat*beatLength*1000
							_leafToTreeRatio[notesToGet[i].type]++
						}
						
						global.song=audio_create_stream(filename_dir(path)+"\\"+_file.songName)
						global.levelData=_file
						
						obj_level_select.grass=spr_grass
						
						if(file_exists(filename_dir(path)+"\\"+"grass.png"))
						{
							obj_level_select.grass=sprite_add(filename_dir(path)+"\\"+"grass.png",2,false,false,32,32)
						}
						
						var _average=0
						for(var i=0;i<array_length(_noteBeats);i++)
						{
							_average+=_noteBeats[i]
						}
						obj_level_select.noteDensity=((_average/array_length(_noteBeats))/_file.bpm)*100
						
						var _songLength=array_last(notesToGet).beat-array_first(notesToGet).beat
						
						_songLength*=60/_file.bpm
						
						obj_level_select.songMilliseconds=0
						
						obj_level_select.previewNotes=notesToGet
						
						obj_level_select.songLength=_songLength
						global.songLength=_songLength
						obj_level_select.leafToTree=string(_leafToTreeRatio[0])+" : "+string(_leafToTreeRatio[1])
						var _chance=50
						if(_leafToTreeRatio[1]>200)
						{
							_chance-=5
						}
						if(_leafToTreeRatio[0]<100)
						{
							_chance+=15
						}
						if(_leafToTreeRatio[1]<100)
						{
							_chance+=15
						}
						if(_file.bpm<=120)
						{
							_chance+=15
						}
						if(_file.bpm>140)
						{
							_chance-=15
						}
						if(_songLength>100)
						{
							_chance-=10
						}
						if(global.levels[id].difficulty==3)
						{
							_chance-=60
						}
						if(global.levels[id].difficulty>=4)
						{
							_chance-=15
						}
						if(obj_level_select.noteDensity<=0.83)
						{
							_chance-=5
						}
						obj_level_select.daniChance=_chance
					}
					catch(e)
					{
						show_message(e)
					}
				}
				obj_level_select.selectedLevel=id
			},
			rightClickFunc: function(){
				if(!show_question("delete "+name+"?"))
				{
					break;
				}
				array_delete(global.levels,id,1)
				with(obj_level_select)
				{
					reset_buttons()
				}
			},
			size:{x:128,y:48},
			position:{x: _x,y: _y},
			sizeMod:0
		}
			
		_struct.availableDifficulties=[hasNormal,hasHard,hasEasy]
		array_push(button,_struct)
		_x+=160+64
		var _moreStatsPos=room_width - 512 + 64 - point_between_points(0,0,256+128,0,obj_level_select.moreStats).x -128
		if(_x>=_moreStatsPos)
		{
			_y+=64
			_x=128
		}
	}*/

	alarm[0]=5

}

percentageBetweenPoints=0

tabMoveSpeed=6

function start_level()
{
	try{
		audio_stop_all()
		global.selectedLevel=wheelProgress
		room_goto(rm_gameplay)
	}
	catch(e)
	{
		
	}
}
	
reset_buttons()

alarm[0]=2