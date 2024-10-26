function add_pack(_file){
	var _str=load_file(_file)
	if(_str!=false)
	{
		try{
			for(var i=0;i<array_length(_str.levels);i++)
			{
				var _packDirectory=filename_dir(_file)
				add_song(_packDirectory+"/"+_str.levels[i]+"/data.json")
			}
			obj_level_select.wheelProgress=0
			with(obj_level_select)
			{
				initialize_level(wheelProgress)
				alarm[1]=1
				alarm[2]=1
			}
		}
		catch(e)
		{
			show_message("the file(s) are corrupted or not valid jsons")
		}
	}
	else
	{
		show_message("the file(s) you entered either don't exist or are corrupted")
	}
}