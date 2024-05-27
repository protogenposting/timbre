// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function load_quaver_file(_file){
	var _buffer = buffer_load(_file)
	var _string = buffer_read(_buffer,buffer_string)
	buffer_delete(_buffer)
	var _struct={}
	var _endOfLine="\n"
	var _operator=":"
	var _lastLineEnd=0
	var _gettingValue=false
	var _name=""
	var _value=""
	for(var _character=1;_character<string_length(_string);_character++)
	{
		var _char=string_char_at(_string,_character)
		if(_char==_operator)
		{
			_character++
			_gettingValue=true
			continue;
		}
		else if(_char==_endOfLine)
		{
			if(string_count("TimingPoints",_name))
			{
				break;
			}
			show_debug_message("set "+_name+" to "+_value)
			variable_struct_set(_struct,_name,_value)
			_gettingValue=false
			_lastLineEnd=_character
			continue;
		}
		else
		{
			if(_gettingValue)
			{
				_value+=_char
			}
			else
			{
				_name+=_char
			}
		}
	}
	show_message(_struct)
}