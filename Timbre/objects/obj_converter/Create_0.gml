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
	name: "FNF (new)",
	func: function(){
		with(obj_converter)
		{
			fnf_convert_new()
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96+96},
	sizeMod:0,
	color:c_red
})

array_push(button,{
	name: "Stepmania",
	func: function(){
		with(obj_converter)
		{
			stepmania_convert()
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96+96+96},
	sizeMod:0,
	color:c_red
})

array_push(button,{
	name: "ADOFAI",
	func: function(){
		with(obj_converter)
		{
			adofai_convert()
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+96+96+96+96},
	sizeMod:0,
	color:c_red
})

function fnf_convert(){
	var _file=GetOpenFileName("","data.json","",@'Open')
	if(_file!="")
	{
		var _struct=load_file(_file).song
		var _savedStruct={
			songName:"Inst.ogg",
			bpm: _struct.bpm,
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
		save_file(_savedStruct,_saveLocation)
	}
}

function fnf_convert_new(){
	var _file=GetOpenFileName("","data.json","",@'Open')
	if(_file!="")
	{
		var _struct=load_file(_file)
		var _savedStruct={
			songName:"Inst.ogg",
			bpm: 120,
			offset:0,
			difficulty:0,
			artist:"unknown",
			notes:[]
		}
		
		var _usedTimes=ds_map_create()
		for(var i=0;i<array_length(_struct.notes.easy);i++)
		{
			var _beatLength=(60/_savedStruct.bpm)*1000
			var _currentNote=_struct.notes.easy[i]
			while(_currentNote.d>3)
			{
				_currentNote.d-=4
			}
			var _note=create_note(_currentNote.t/_beatLength,noteTypes.turn,_currentNote.d,false)
			_note.timeMS=_currentNote.t
			if(!is_undefined(ds_map_find_value(_usedTimes,_note.timeMS)))
			{
				_note.type=noteTypes.log
			}
			ds_map_add(_usedTimes,_note.timeMS,true)
			array_push(_savedStruct.notes,_note)
		}
		ds_map_destroy(_usedTimes)
		sort_note_array(_savedStruct.notes)
		var _saveLocation=GetSaveFileName("","data.json","",@'Open')
		save_file(_savedStruct,_saveLocation)
	}
}

function stepmania_convert(){
	url_open("https://github.com/UncertainProd/SMtoPsychFNF/tree/main")
	/*
	try{
		var _file=GetOpenFileName("","data.sm","",@'Open')
		if(_file!="")
		{
		
			var _string=load_file_raw(_file)
			var _savedStruct={
				songName:"Inst.ogg",
				bpm: 120,
				offset:0,
				difficulty:0,
				artist:"unknown",
				notes:[]
			}
		
			var _music=string_pos("#MUSIC:",_string)
		
			var _musicEnd=string_pos_ext(";",_string,_music)
		
			var _musicName=string_copy(_string,_music+7,_musicEnd-(_music+7))
		
			show_debug_message(_musicName)
		
			var _bpm=string_pos("#BPMS:0.000=",_string)
		
			var _bpmEnd=string_pos_ext(";",_string,_bpm)
		
			var _bpmName=string_copy(_string,_bpm+12,_bpmEnd-(_bpm+12))
		
			show_debug_message(_bpmName)
		
			_savedStruct.songName=_musicName
		
			_savedStruct.bpm=real(_bpmName)
		
			var _notesStart=string_pos("#NOTES:",_string)
		
			return 0
		
			var _usedTimes=ds_map_create()
			for(var i=0;i<array_length(_struct.notes.easy);i++)
			{
				var _beatLength=(60/_savedStruct.bpm)*1000
				var _currentNote=_struct.notes.easy[i]
				while(_currentNote.d>3)
				{
					_currentNote.d-=4
				}
				var _note=create_note(_currentNote.t/_beatLength,noteTypes.turn,_currentNote.d,false)
				_note.timeMS=_currentNote.t
				if(!is_undefined(ds_map_find_value(_usedTimes,_note.timeMS)))
				{
					_note.type=noteTypes.log
				}
				ds_map_add(_usedTimes,_note.timeMS,true)
				array_push(_savedStruct.notes,_note)
			}
			ds_map_destroy(_usedTimes)
			sort_note_array(_savedStruct.notes)
			save_file(_savedStruct,filename_dir(_file)+"data.json")
		}
	}
	catch(e)
	{
		show_message(e)
	}*/
}
	
function adofai_convert(){
	var _file=GetOpenFileName("","level.adofai","",@'Open')
	if(_file!="")
	{
		var _buffer = buffer_load(_file)
		var _string = buffer_read(_buffer,buffer_string)
		buffer_delete(_buffer)
		
		var _position = string_pos("\"decorations\":",_string)
		
		_string=string_delete(_string,_position,string_length(_string))
		
		_string = _string + "}"
		
		_string = string_replace(_string,"\n","")
		
		_string = string_replace(_string,"\r","")
		
		show_debug_message(json_parse(_string))
	}
}

yOffset=0

yOffsetSpeed=0

yOffsetMaxSpeed=25