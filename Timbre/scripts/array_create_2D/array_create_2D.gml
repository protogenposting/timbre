// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_create_2D(_size,_secondArraySize,_secondArrayValue){
	var _array=array_create(0)
	
	for(var i=0;i<_size;i++)
	{
		array_push(_array,array_create(_secondArraySize,_secondArrayValue))
	}
	
	return _array
}