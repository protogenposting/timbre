// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_combine(_array1,_array2){
	for(var i = 0; i < array_length(_array2); i++)
	{
		array_push(_array1,_array2[i])
	}
	return _array1
}