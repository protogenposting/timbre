// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function load_quaver_file(_file){
	var _buffer = buffer_load(_file)
	var _string = buffer_read(_buffer,buffer_string)
	buffer_delete(_buffer)
	show_message(string_count("\n",_string))
}