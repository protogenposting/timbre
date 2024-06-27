// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.keyboardBinds={
	turning:{
		sprite: spr_reverse_arrow,
		left: ord("A"),
		right: ord("D"),
		up: ord("W"),
		down: ord("S"),
	},
	attacking:{
		sprite: spr_log,
		left: ord("J"),
		right: ord("L"),
		up: ord("I"),
		down: ord("K"),
	},
}
global.sfxVolume=1

global.musicVolume=1

global.showKeys=false

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

global.gamemode=1

global.audioOffset=0

var _file=load_file(global.saveName)

if(_file==false)
{
	global.levels=[
	]
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
		global.keyboardBinds=_file.keybinds
	}
	catch(e)
	{
	}
}


global.levels=sort_songlist(global.levels)

#macro difficulties [{sprite:spr_easy,name:"Casual",color:c_aqua},{sprite:spr_normal,name:"Normal",color:c_lime},{sprite:spr_hard,name:"Hard",color:c_orange},{sprite:spr_insane,name:"Spicy",color:c_red},{sprite:spr_expert,name:"Firey!",color:c_purple},{sprite:spr_expertplus,name:"ASH",color:c_black},{sprite:spr_grandmaster,name:"D E S O L A T I O N",color:c_black},{sprite:spr_truedesolation,name:"T R U E D E S O L A T I O N",color:c_black},{sprite:spr_why,name:"Why",color:c_black}]

#macro menuColors [c_aqua,c_yellow,c_lime,c_orange,c_purple,c_red,c_black]

