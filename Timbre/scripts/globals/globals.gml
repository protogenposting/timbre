// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.keyboardBinds={
	turning:{
		left: ord("A"),
		right: ord("D"),
		up: ord("W"),
		down: ord("S"),
	},
	attacking:{
		left: ord("J"),
		right: ord("L"),
		up: ord("I"),
		down: ord("K"),
	},
}
global.levelData=-4

global.song=-4

global.selectedLevel=-4

global.dataLocation=""

global.botPlay=false

global.saveName="save_data.TTT"

global.editing=false

var _file=load_file(global.saveName)

if(_file==false)
{
	global.levels=[
	{name:"Chronosphere",artist:"Килджо",path: working_directory+"chronosphere\\data.json",difficulty:4,highScore:0,rank:""},
	{name:"Fardstep 2",artist:"Protogen Posting",path: working_directory+"fardstep\\data.json",difficulty:2,highScore:0,rank:""},
	{name:"Error: Value Exception",artist:"Protogen Posting and ScratchGuy",path: working_directory+"VE\\data.json",difficulty:5,highScore:0,rank:""},
	{name:"Say It Back",artist:"TV Room",path: working_directory+"Say It Back\\data.json",difficulty:1,highScore:0,rank:""},
	{name:"Party Sirens",artist:"Tanger",path: working_directory+"Party Sirens\\data.json",difficulty:5,highScore:0,rank:""},
	{name:"Pineapple Pizza!",artist:"Protogen Posting",path: working_directory+"Pineapple Pizza\\data.json",difficulty:0,highScore:0,rank:""},
	{name:"Reverse",artist:"Caravan Palace",path: working_directory+"Reverse\\data.json",difficulty:3,highScore:0,rank:""},
	]
}
else
{
	global.levels=_file.levels
}
//show_message(working_directory+"VE\\data.json")

global.levels=sort_songlist(global.levels)

#macro difficulties [{sprite:spr_easy,name:"Easy",color:c_aqua},{sprite:spr_normal,name:"Normal",color:c_lime},{sprite:spr_hard,name:"Hard",color:c_orange},{sprite:spr_insane,name:"Insane",color:c_red},{sprite:spr_expert,name:"Expert",color:c_purple},{sprite:spr_expertplus,name:"Expert+",color:c_black},]