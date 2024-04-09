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

global.improvedControls=true

global.classicView=false

var _file=load_file(global.saveName)

if(_file==false)
{
	global.levels=[
		{name:"Chronosphere",artist:"Килджо",path: working_directory+"chronosphere\\data.json",difficulty:4,highScore:0,rank:""},
		{name:"Fardstep 2",artist:"Protogen Posting",path: working_directory+"fardstep\\data.json",difficulty:2,highScore:0,rank:""},
		{name:"Fardstep",artist:"Protogen Posting",path: working_directory+"Fardstep 1\\data.json",difficulty:2,highScore:0,rank:""},
		{name:"Value Exception",artist:"Protogen Posting and ScratchGuy",path: working_directory+"VE\\data.json",difficulty:5,highScore:0,rank:""},
		{name:"Say It Back",artist:"TV Room",path: working_directory+"Say It Back\\data.json",difficulty:1,highScore:0,rank:""},
		{name:"Party Sirens",artist:"Tanger",path: working_directory+"Party Sirens\\data.json",difficulty:5,highScore:0,rank:""},
		{name:"Pineapple Pizza!",artist:"Protogen Posting",path: working_directory+"Pineapple Pizza\\data.json",difficulty:0,highScore:0,rank:""},
		{name:"Paint",artist:"Celeste Strawberry Jam",path: working_directory+"Paint\\data.json",difficulty:0,highScore:0,rank:""},
		{name:"Reverse",artist:"Caravan Palace",path: working_directory+"Reverse\\data.json",difficulty:3,highScore:0,rank:""},
		{name:"Ice Kingdom",artist:"Protogen Posting",path: working_directory+"Aurora Borealis\\data.json",difficulty:2,highScore:0,rank:""},
		{name:"Sand Kingdom",artist:"Protogen Posting",path: working_directory+"sand kingdom\\data.json",difficulty:1,highScore:0,rank:""},
		{name:"Airship",artist:"Protogen Posting",path: working_directory+"airship\\data.json",difficulty:4,highScore:0,rank:""},
		{name:"Danger (Hard)",artist:"Z11 Music (Cover by ScratchGuy23)",path: working_directory+"Danger\\data.json",difficulty:5,highScore:0,rank:""},
		{name:"Schoolhouse Trouble",artist:"Anthony Hampton (Baldi's Basics)",path: working_directory+"Schoolhouse Trouble\\data.json",difficulty:4,highScore:0,rank:""},
		{name:"Altars of Apostasy",artist:"Hakita",path: working_directory+"Altars of Apostasy\\data.json",difficulty:1,highScore:0,rank:""},
		{name:"Danger",artist:"Z11 Music",path: working_directory+"Other Danger\\data.json",difficulty:4,highScore:0,rank:""},
		{name:"Identity Theft",artist:"ScratchGuy",path: working_directory+"Identity Theft\\data.json",difficulty:5,highScore:0,rank:""},
	]
	global.offset=0
}
else
{
	global.levels=_file.levels
	try{
		global.improvedControls=_file.controlType
		global.offset=_file.offset
	}
	catch(e)
	{
		global.offset=0
	}
}


global.levels=sort_songlist(global.levels)

#macro difficulties [{sprite:spr_easy,name:"Easy",color:c_aqua},{sprite:spr_normal,name:"Normal",color:c_lime},{sprite:spr_hard,name:"Hard",color:c_orange},{sprite:spr_insane,name:"Insane",color:c_red},{sprite:spr_expert,name:"Expert",color:c_purple},{sprite:spr_expertplus,name:"Expert+",color:c_black},]

#macro menuColors [c_aqua,c_yellow,c_lime,c_orange,c_purple,c_red,c_black]