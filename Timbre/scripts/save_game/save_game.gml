// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_game(){
	save_file({
		levels:global.levels,
		controlType:global.improvedControls,
		epilepsy:global.epilepsyMode,
		moveSpeed: global.moveSpeed,
		audioOffset:global.audioOffset
	},global.saveName)
}