global.requests = []

function http_run(_id, _result){
	for(var i = 0; i < array_length(global.requests); i++)
	{
		if(global.requests[i].id == _id)
		{
			global.requests[i].func(_result)
			array_delete(global.requests,i,1)
			i--
		}
	}
}

function request(_id,_function) constructor
{
	id = _id
	func = _function
}