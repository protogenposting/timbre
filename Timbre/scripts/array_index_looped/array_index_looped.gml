// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_index_looped(array,index){
	while(index>=array_length(array))
	{
		index-=array_length(array)
	}
	return array[index]
}