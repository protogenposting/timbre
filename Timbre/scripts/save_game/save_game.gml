// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_game(){
	for(var i=0;i<array_length(global.levels);i++)
	{
		for(var o=0;o<array_length(global.levels);o++)
		{
			if(global.levels[o].path==global.levels[i].path&&i!=o)
			{
				array_delete(global.levels,o,1)
				o--
			}
		}
	}
	save_file({
		levels:global.levels,
		controlType:global.improvedControls,
		epilepsy:global.epilepsyMode,
		moveSpeed: global.moveSpeed,
		audioOffset:global.audioOffset,
		showKeys: global.showKeys,
		modeBinds: global.modeBinds
	},global.saveName)
}