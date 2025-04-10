// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function bind(_sprite,_left,_right,_up,_down) constructor{
	left=_left
	right=_right
	up=_up
	down=_down
	sprite=_sprite
}

global.modeBinds=[
	{
		turning: new bind(
			spr_reverse_arrow,
			ord("A"),
			ord("D"),
			ord("W"),
			ord("S")
		),
		attacking: new bind(
			spr_log,
			ord("J"),
			ord("L"),
			ord("I"),
			ord("K")
		),
	},
	{
		turning: new bind(
			spr_player,
			186,
			ord("A"),
			ord("S"),
			192
		),
		attacking: new bind(
			spr_log,
			vk_lshift,
			vk_rshift,
			vk_space,
			ord("K")
		),
	},
	{
		turning: new bind(
			spr_reverse_arrow,
			ord("A"),
			ord("D"),
			ord("W"),
			ord("S")
		),
		attacking: new bind(
			spr_log,
			ord("J"),
			ord("L"),
			ord("I"),
			ord("K")
		),
	},
]

global.session = ""

global.skins=[]//"Default Skin"]

//find skins
var _file=file_find_first("Skins/*",fa_directory)

while(_file!="")
{
	array_push(global.skins,_file)
	
	_file=file_find_next()
}

file_find_close()

global.skinSelected=0

global.deltaTime=false

global.playedDoorSlam=false

global.keyboardBinds=global.modeBinds[0]

global.sfxVolume=1

global.musicVolume=1

global.showKeys=false

global.shouldShowNVDRLines=true

global.saveLocation=game_save_id

global.wasSaved=false

global.levelData=-4

global.song=-4

global.usingController=false

global.currentDifficulty=0

global.songSpeed=1

global.orderedAlpha=false

global.epilepsyMode=true

global.moveSpeed=1

global.selectedLevel=0

global.dataLocation=""

global.botPlay=false

global.saveName=game_save_id+"save_data.TTT"

global.editing=false

global.improvedControls=false

global.gamemode=0

global.audioOffset=0

_file=load_file(global.saveName)

function playlist(_name,_levels) constructor{
	name=_name
	levels=_levels
}

global.currentPlaylist=0

global.playlists=[
	new playlist("All Levels",[])
]

global.username = ""

global.password = ""

if(_file==false)
{
	global.levels=[]
}
else
{
	global.levels=_file.levels
	try{
		global.improvedControls=_file.controlType
		global.epilepsyMode=_file.epilepsy
		global.moveSpeed=_file.moveSpeed
		global.audioOffset=_file.audioOffset
		global.showKeys=_file.showKeys
		global.modeBinds=_file.modeBinds
		global.playlists=_file.playlists
		if(variable_struct_exists(_file,"loginDetails"))
		{
			global.username = _file.loginDetails.username
			
			global.password = _file.loginDetails.password
		}
	}
	catch(e)
	{
		
	}
}

function get_playlist_levels(_playlistID){
	var _returnValue=[]
	var _unfoundLevels=[]
	array_copy(_unfoundLevels,0,global.levels,0,array_length(global.levels))
	for(var i=0;i<array_length(global.playlists[_playlistID].levels);i++)
	{
		try{
			for(var o=0;o<array_length(_unfoundLevels);o++)
			{
				if(_unfoundLevels[o].path==global.playlists[_playlistID].levels[i])
				{
					array_push(_returnValue,_unfoundLevels[o])
					array_delete(_unfoundLevels,o,1)
					o--
				}
			}
		}
		catch(e)
		{
			array_delete(global.playlists[_playlistID].levels,i,1)
			return get_playlist_levels(_playlistID)
		}
	}
	return _returnValue
}

function reset_default_playlist()
{
	global.levels=sort_songlist(global.levels)
	global.playlists[0].levels=[]

	for(var i=0;i<array_length(global.levels);i++)
	{
		array_push(global.playlists[0].levels,global.levels[i].path)
	}
	show_debug_message(global.playlists[0])
}

function GameMode(_name,_sprite,_usesNormalControls,_requirments=function(){return true}) constructor{
	name=_name
	sprite=_sprite
	requirments=_requirments
	usesNormalControls=_usesNormalControls
}

function DifficultyMod(_name,_description,_sprite,_effect) constructor{
	name=_name
	sprite=_sprite
	effect=_effect
	description=_description
	enabled=false
}

global.gamemodes=[
	new GameMode("Timbre",spr_mode_normal,true),
	new GameMode("TimbreMania",spr_mode_mania,true),
	new GameMode("TimbreNVDR",spr_mode_nvdr,false),
]

global.difficultyMods=[
	new DifficultyMod(
		"Fungal Infection",
		"No seeing for you!",
		spr_mod_fungal,
		function(){
			if(global.gamemode==0)
			{
				draw_sprite(spr_fungal_infection,0,0,0)
			}
			if(global.gamemode==1)
			{
				draw_rectangle(0,768/2,1366/2,768,false)
				draw_rectangle(1366/2,0,1366,768/2,false)
			}
		}
	),
	new DifficultyMod(
		"Hard Drugs",
		"Everything is harder!",
		spr_mod_hard,
		function(){
			with(obj_main_game)
			{
				msWindow=90
				reset_timings()
			}
		}
	)
]

#region get the songs!

var _directory = game_save_id+"Songs"

var _dir = working_directory+"/assets/songs"

if(os_type == os_windows)
{
	 _dir = working_directory + "Songs"
}

var _allFiles = file_find_all(_dir,"")

for(var i = 0; i < array_length(_allFiles); i++)
{
	_allFiles[i] = string_replace(_allFiles[i],_dir,"")
	if(string_pos(".",_allFiles[i])!=0)
	{
		file_copy(_dir + _allFiles[i],_directory + _allFiles[i])
	}
}

_allFiles = file_find_all(_directory,"")

for(var i = 0; i < array_length(_allFiles); i++)
{
	if(string_pos(".",_allFiles[i])!=0)
	{
		if(string_pos("data.json",_allFiles[i]) != 0)
		{
			var _newDir = _allFiles[i]
			
			//_newDir = string_replace_all(_newDir," ","_")
			
			add_song(_newDir)
		}
	}
}

#endregion

reset_default_playlist()

for(var i=1;i<array_length(global.playlists);i++)
{
	if(array_length(global.playlists[i].levels)<=0)
	{
		array_delete(global.playlists,i,1)
		i--
	}
}

global.levels=sort_songlist(global.levels)

#macro difficulties [{sprite:spr_easy,name:"Casual",color:c_aqua},{sprite:spr_normal,name:"Normal",color:c_lime},{sprite:spr_hard,name:"Hard",color:c_orange},{sprite:spr_insane,name:"Spicy",color:c_red},{sprite:spr_expert,name:"Firey!",color:c_purple},{sprite:spr_expertplus,name:"ASH",color:c_black},{sprite:spr_grandmaster,name:"D E S O L A T I O N",color:c_black},{sprite:spr_truedesolation,name:"T R U E D E S O L A T I O N",color:c_black},{sprite:spr_why,name:"Why",color:c_black}]

#macro menuColors [c_aqua,c_yellow,c_lime,c_orange,c_purple,c_red,c_black]

