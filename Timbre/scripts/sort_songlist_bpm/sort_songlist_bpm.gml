// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sort_songlist_bpm(array){
	var bpmArray=array_create(array_length(array))
	for(var i=0;i<array_length(array);i++)
	{
		var _file=load_file(array[i].path)
		if(_file!=false)
		{
			bpmArray[i]=_file.bpm
		}
		else
		{
			bpmArray[i]=0
		}
	}
	var newTurns=array
	var swaps=1
	while(swaps>0)
	{
		swaps=0
		for(var i=0;i<array_length(array)-1;i++)
		{
			if(bpmArray[i]>bpmArray[i+1]||bpmArray[i]==bpmArray[i+1]&&newTurns[i].name>newTurns[i+1].name)
			{
				var temp=newTurns[i]
				var tempBpm=bpmArray[i]
				newTurns[i]=newTurns[i+1]
				newTurns[i+1]=temp
				bpmArray[i]=bpmArray[i+1]
				bpmArray[i+1]=tempBpm
				swaps++
			}
		}
		show_debug_message(swaps)
	}
	return newTurns
}