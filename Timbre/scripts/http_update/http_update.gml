global.requests = []

function http_run(_id, _result){
	global.requests[_id].func(_result)
}

function request(_id,_function) constructor
{
	id = _id
	func = _function
}