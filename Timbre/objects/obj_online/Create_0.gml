button[0]={
	name: "Back",
	func: function(){
		room_goto(rm_menu)
	},
	size:{x:128,y:64},
	position:{x:128,y:64},
	sizeMod:0
}
button[1]={
	name: "Login",
	func: function(){
		currentLoginState = loginState.LOGIN
		get_login_async("","")
	},
	size:{x:128,y:64},
	position:{x:128,y:128},
	sizeMod:0
}
button[2]={
	name: "Create Account",
	func: function(){
		currentLoginState = loginState.CREATE
		get_login_async("","")
	},
	size:{x:128,y:64},
	position:{x:128,y:64+128},
	sizeMod:0
}

function login(_username,_password)
{
	http_request_json(
		link+"login",
		"POST",
		json_stringify({name: _username, username: _username, password: _password}),
		function(_result){
			_result = json_parse(_result)
			
			if(_result.sessionID == "0")
			{
				show_message("login details failed")
			}
			else
			{				
				global.session = _result.sessionID
				
				array_delete(button,1,2)
			}
		}
	)
}

enum loginState{
	LOGIN,
	CREATE
}

currentLoginState = loginState.LOGIN

players=[]

link = "http://localhost:3000/api/"

if(global.username != "" && global.session == "")
{
	login(global.username,global.password)
}
else if(global.session != "")
{
	array_delete(button,1,2)
}

http_request_json(
	link+"users",
	"GET",
	"",
	function(_result){
		players = _result
	}
)