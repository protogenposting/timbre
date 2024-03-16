event_inherited()

audio_stop_all()

selectedLevel=-4

audio_destroy_stream(global.song)

global.song=-4

global.editing=false

global.selectedLevel=-4

difficulties=[
	{sprite:spr_easy,name:"Easy",color:c_aqua},
	{sprite:spr_normal,name:"Normal",color:c_lime},
	{sprite:spr_hard,name:"Hard",color:c_orange},
	{sprite:spr_insane,name:"Insane",color:c_red},
	{sprite:spr_expert,name:"Expert",color:c_purple},
	{sprite:spr_expertplus,name:"Expert+",color:c_black},
]

button=[
{
	name: "Back",
	func: function(){
		room_goto(rm_menu)
	},
	size:{x:128,y:64},
	position:{x:128,y:64},
	sizeMod:0
}]

var _x=128
var lastButton=array_last(button)
var _y=lastButton.position.y+96
for(var i=0;i<array_length(global.levels);i++)
{
	array_push(button,{
		name: global.levels[i].name,
		path: global.levels[i].path,
		id:i,
		color: obj_level_select.difficulties[global.levels[i].difficulty].color,
		func: function(){
			var _file=load_file(path)
			if(_file==false)
			{
				show_message_async("failed loading")
			}
			else
			{
				try{
					audio_destroy_stream(global.song)
					global.song=audio_create_stream(filename_dir(path)+"\\"+_file.songName)
					global.levelData=_file
				}
				catch(e)
				{
					show_message(e)
				}
			}
			obj_level_select.selectedLevel=id
		},
		size:{x:128,y:64},
		position:{x: _x,y: _y},
		sizeMod:0
	})
	_y+=96
	if(_y>room_height/1.1)
	{
		_y=64
		_x+=270
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