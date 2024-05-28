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
		
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96+96},
	sizeMod:0,
	color:c_purple
})

function fnf_convert(){
	var _file=get_open_filename(".json","data.json")
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
		
		var _lastNoteTime=0
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
				if(_currentNote[0]==_lastNoteTime)
				{
					_note.type=noteTypes.log
				}
				_lastNoteTime=_currentNote[0]
				array_push(_savedStruct.notes,_note)
			}
		}
		sort_note_array(_savedStruct.notes)
		save_file(_savedStruct,game_save_id+"/fnfsong/data.json")
	}
}

yOffset=0

yOffsetSpeed=0

yOffsetMaxSpeed=25