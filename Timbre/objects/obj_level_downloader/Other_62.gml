/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "id") == get)
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
		scrollY=0
		var _result = ds_map_find_value(async_load, "result");
		var _decoded = json_parse(_result)
		show_debug_message(_decoded) 
		levels=_decoded.mapsets
		loading=false
		selectedLevel=-4
    }
}
if (ds_map_find_value(async_load, "id") == download)
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
		downloading=false
		var _file=load_quaver_file(tempSaveID)
		save_file(_file,game_save_id+"convertedMap.json")
    }
}
