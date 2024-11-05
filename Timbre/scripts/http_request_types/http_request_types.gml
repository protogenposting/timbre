function http_request_json(_link,_method,_data="",_onEnd = function(_result){}){
	var _headers = ds_map_create();
	ds_map_add(_headers, "Content-Type", "application/json");
	ds_map_add(_headers, "Authorization", "A92n5nIlklaPosfbngfbsYYhfkskaNuuHGFNJSA");
	
	array_push(global.requests,new request(
		http_request(_link,_method,_headers,_data),
		_onEnd
	))
}

function http_request_json_session(_link,_method,_data="",_onEnd = function(_result){}){
	var _headers = ds_map_create();
	ds_map_add(_headers, "Content-Type", "application/json");
	ds_map_add(_headers, "Authorization", "A92n5nIlklaPosfbngfbsYYhfkskaNuuHGFNJSA");
	ds_map_add(_headers, "Session", json_stringify({username:global.username,session:global.session}));
	
	array_push(global.requests,new request(
		http_request(_link,_method,_headers,_data),
		_onEnd
	))
}