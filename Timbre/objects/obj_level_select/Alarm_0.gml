/// @description Insert description here
// You can write your code in this editor
save_file({
	levels:global.levels,
	controlType:global.improvedControls,
	epilepsy:global.epilepsyMode,
	moveSpeed: global.moveSpeed
},global.saveName)
show_debug_message("saved data :3")

/*if(sortMode==sortTypes.difficulty)
{
	global.levels=sort_songlist(global.levels)
}
if(sortMode==sortTypes.bpm)
{
	global.levels=sort_songlist_bpm(global.levels)
}*/

alarm[0]=30