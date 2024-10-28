// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function file_find_all(_dir,_mask){
	var _files = []
	
	var _search = _dir+"/*"
	
	var _type = fa_none
	
	if(os_type == os_windows)
	{
		_type = fa_directory
	}
	
	var _file = file_find_first(_search,_type)

	while(_file!="")
	{
		array_push(_files,_dir+"/"+_file)
	
		_file = file_find_next()
	}

	file_find_close()
	
	for(var i = 0; i < array_length(_files); i++)
	{
		var _newFiles = file_find_all(_files[i],"")
		
		array_combine(_files,_newFiles)
	}
	
	return _files
}