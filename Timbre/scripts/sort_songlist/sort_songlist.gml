// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sort_songlist(array){
	var newTurns=array
	var swaps=1
	while(swaps>0)
	{
		swaps=0
		for(var i=0;i<array_length(array)-1;i++)
		{
			if(newTurns[i].difficulty>newTurns[i+1].difficulty||newTurns[i].difficulty==newTurns[i+1].difficulty&&newTurns[i].name>newTurns[i+1].name)
			{
				var temp=newTurns[i]
				newTurns[i]=newTurns[i+1]
				newTurns[i+1]=temp
				swaps++
			}
		}
		//show_debug_message(swaps)
	}
	return newTurns
}