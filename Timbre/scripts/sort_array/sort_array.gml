// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sort_array(array){
	var newTurns=array
	var swaps=1
	while(swaps>0)
	{
		for(var i=0;i<array_length(array)-1;i++)
		{
			swaps=0
			if(newTurns[i].beat>newTurns[i+1].beat)
			{
				var temp=newTurns[i].beat
				newTurns[i].beat=newTurns[i+1].beat
				newTurns[i+1].beat=temp
				swaps++
			}
		}
	}
	return newTurns
}