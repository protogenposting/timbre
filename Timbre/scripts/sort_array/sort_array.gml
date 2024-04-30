// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sort_array(array,func){
	var newTurns=array
	var swaps=1
	while(swaps>0)
	{
		swaps=0
		for(var i=0;i<array_length(array)-1;i++)
		{
			if(func(newTurns[i],newTurns[i+1]))
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