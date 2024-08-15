/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "status") == 0)
{
    var _result = ds_map_find_value(async_load, "result");
	players=json_parse(_result).users
}