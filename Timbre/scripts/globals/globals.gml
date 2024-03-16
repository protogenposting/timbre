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
	global.levels=[{name:"chronosphere",path: working_directory+"chronosphere\\data.json",difficulty:4,highScore:0,rank:""},{name:"fardstep",path: working_directory+"fardstep\\data.json",difficulty:2,highScore:0,rank:""}]
}
else
{
	global.levels=_file.levels
}