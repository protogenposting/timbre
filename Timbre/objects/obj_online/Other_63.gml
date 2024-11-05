var _username = ds_map_find_value(async_load, "username");
var _password = ds_map_find_value(async_load, "password");

if(currentLoginState == loginState.CREATE)
{
	global.username = _username

	global.password = _password
	
	http_request_json(
		link+"newUser",
		"POST",
		json_stringify({name: _username, username: _username, password: _password}),
		function(_result){
			var _failed = string_pos("UNIQUE",_result) > 0
				
			if(_failed)
			{
				show_message("Your username is not unique! REDO IT")
			}
			else
			{
				show_message("You created an account! Logging you in...")
				
				login(global.username,global.password)
			}
		}
	)
}
if(currentLoginState == loginState.LOGIN)
{
	global.username = _username

	global.password = _password
	
	login(_username,_password)
}