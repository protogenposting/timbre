/// @description Insert description here
// You can write your code in this editor
save_file({levels:global.levels,controlType:global.improvedControls},global.saveName)

if(sortMode==sortTypes.difficulty)
{
	global.levels=sort_songlist(global.levels)
}
if(sortMode==sortTypes.bpm)
{
	global.levels=sort_songlist_bpm(global.levels)
}

alarm[0]=30