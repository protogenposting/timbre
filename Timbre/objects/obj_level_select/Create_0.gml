event_inherited()

gooberLocation.y=room_height

audio_stop_all()

selectedLevel=-4

bpm=0

audio=-4

currentBeat=0

audio_destroy_stream(global.song)

global.song=-4

global.editing=false

global.selectedLevel=-4

noteDensity=0

moreStats=false

songLength=0

leafToTree=""

daniChance=0

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
			var _file=get_open_filename(".json","data.json")
			if(_file!="")
			{
				var _str=load_file(_file)
				if(_file!=false)
				{
					try{
						var _struct={
							name: filename_dir(_file),
							path: _file,
							highScore:0,
							rank:""
						}
						var _nameLast=string_last_pos("\\",_struct.name)
						_struct.name=string_copy(_struct.name,_nameLast+1,999)
						if(variable_struct_exists(_str,"difficulty"))
						{
							_struct.difficulty=_str.difficulty
						}
						else
						{
							_struct.difficulty=3
						}
						if(variable_struct_exists(_str,"artist"))
						{
							_struct.artist=_str.artist
						}
						else
						{
							_struct.artist="???"
						}
						array_push(global.levels,_struct)
						with(obj_level_select)
						{
							alarm[1]=2
						}
					}
					catch(e)
					{
					
					}
				}
			}
			global.levels=sort_songlist(global.levels)
		},
		size:{x:128,y:64},
		position:{x:128+140,y:64},
		sizeMod:0
	},
	{
		name: "More Stats",
		func: function(){
			obj_level_select.moreStats=!obj_level_select.moreStats
		},
		size:{x:128,y:64},
		position:{x:128+140+140,y:64},
		sizeMod:0
	},]

	var _x=128
	var lastButton=array_last(button)
	var _y=lastButton.position.y+96
	for(var i=0;i<array_length(global.levels);i++)
	{
		array_push(button,{
			name: global.levels[i].name,
			path: global.levels[i].path,
			id:i,
			color: array_index_looped(menuColors,i),
			func: function(){
				var _file=load_file(path)
				if(_file==false)
				{
					show_message_async("failed loading, no data file")
				}
				else
				{
					try{
						audio_destroy_stream(global.song)
						global.song=audio_create_stream(filename_dir(path)+"\\"+_file.songName)
						global.levelData=_file
						var _noteBeats=[]
						
						var _leafToTreeRatio=[0,0]
						for(var i=0;i<array_length(_file.notes)-1;i++)
						{
							array_push(_noteBeats,abs(_file.notes[i].beat-_file.notes[i+1].beat))
							_leafToTreeRatio[_file.notes[i].type]++
						}
						var _average=0
						for(var i=0;i<array_length(_noteBeats);i++)
						{
							_average+=_noteBeats[i]
						}
						obj_level_select.noteDensity=((_average/array_length(_noteBeats))/_file.bpm)*100
						
						var _songLength=array_last(_file.notes).beat-array_first(_file.notes).beat
						
						_songLength*=60/_file.bpm
						
						obj_level_select.songLength=_songLength
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
			size:{x:128,y:48},
			position:{x: _x,y: _y},
			sizeMod:0
		})
		_y+=64
		if(_y>room_height/1.1)
		{
			_y=64+96
			_x+=160+64
		}
	}

	alarm[0]=1

	function start_level()
	{
		if(obj_level_select.selectedLevel!=-4)
		{
			try{
				audio_stop_all()
				global.selectedLevel=obj_level_select.selectedLevel
				room_goto(rm_gameplay)
			}
			catch(e)
			{
				obj_level_select.selectedLevel=-4
			}
		}
	}
}

reset_buttons()