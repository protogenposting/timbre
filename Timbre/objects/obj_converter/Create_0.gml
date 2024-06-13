/// @description Insert description here
// You can write your code in this editor
button[0]={
	name: "Back",
	func: function(){
		room_goto(rm_menu)
	},
	size:{x:128,y:64},
	position:{x:128,y:64},
	sizeMod:0
}
array_push(button,{
	name: "FNF",
	func: function(){
		with(obj_converter)
		{
			fnf_convert()
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96},
	sizeMod:0,
	color:c_red
})

array_push(button,{
	name: "OSU!Mania",
	func: function(){
		with(obj_converter)
		{
			osu_convert()
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96+96},
	sizeMod:0,
	color:c_purple
})

function fnf_convert(){
	var _file=GetOpenFileName("","data.json","",@'Open')
	if(_file!="")
	{
		var _struct=load_file(_file).song
		var _savedStruct={
			songName:"Inst.ogg",
			bpm:_struct.bpm,
			offset:0,
			difficulty:0,
			artist:"unknown",
			notes:[]
		}
		
		var _usedTimes=ds_map_create()
		for(var i=0;i<array_length(_struct.notes);i++)
		{
			for(var o=0;o<array_length(_struct.notes[i].sectionNotes);o++)
			{
				var _beatLength=(60/_struct.bpm)*1000
				var _currentNote=_struct.notes[i].sectionNotes[o]
				while(_currentNote[1]>3)
				{
					_currentNote[1]-=4
				}
				var _note=create_note(_currentNote[0]/_beatLength,noteTypes.turn,_currentNote[1],false)
				_note.timeMS=_currentNote[0]
				if(!is_undefined(ds_map_find_value(_usedTimes,_note.timeMS)))
				{
					_note.type=noteTypes.log
				}
				ds_map_add(_usedTimes,_note.timeMS,true)
				array_push(_savedStruct.notes,_note)
			}
		}
		ds_map_destroy(_usedTimes)
		sort_note_array(_savedStruct.notes)
		var _saveLocation=GetSaveFileName("","data.json","",@'Open')
		save_file(_savedStruct,game_save_id+"/fnfsong/data.json")
	}
}

function osu_convert(){
	var _file=GetOpenFileName("","data.json","",@'Open')
	//_file=game_save_id+"osu.osz"
	if(_file!="")
	{
		
	}
}

yOffset=0

yOffsetSpeed=0

yOffsetMaxSpeed=25