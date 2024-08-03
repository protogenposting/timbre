/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "status") == 0)
{
    show_message(ds_map_find_value(async_load, "result"))
}