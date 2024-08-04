// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function http_request_json(_link,_method,_data){
	var _headers = ds_map_create();
	ds_map_add(_headers, "Content-Type", "application/json");
	http_request(_link,_method,_headers,_data)
}