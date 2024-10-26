// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_song(_file){
	for(var i=0;i<array_length(global.levels);i++)
	{
		if(_file==global.levels[i].path)
		{
			return false;
		}
	}
	var _str=load_file(_file)
	if(_str!=false)
	{
		try{
			var _struct={
				name: filename_dir(_file),
				path: _file,
				highScore:0,
				rank: array_create_2D(10,3,"")
			}
			var _nameLast=string_last_pos("/",_struct.name)
			if(string_count("/",_struct.name)<=0)
			{
				_nameLast=string_last_pos("/",_struct.name)
			}
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
			show_message("the file ("+_file+") is corrupted or not valid jsons")
		}		
	}
	else
	{
		show_message("the file ("+_file+") you entered either don't exist or are corrupted")
	}
}