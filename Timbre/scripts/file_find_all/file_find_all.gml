// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function file_find_all(_dir){
	var _files = []
	
	var _file = file_find_first(_dir+"/*",fa_none)

	while(_file!="")
	{
		array_push(_files,_dir+"/"+_file)
	
		_file = file_find_next()
	}

	file_find_close()
	
	for(var i = 0; i < array_length(_files); i++)
	{
		var _newFiles = file_find_all(_files[i])
		
		array_combine(_files,_newFiles)
	}
	
	return _files
}