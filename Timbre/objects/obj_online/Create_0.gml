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

enum loginState{
	LOGIN,
	CREATE
}

currentLoginState = loginState.LOGIN

players=[]

link = "http://localhost:3000/api/"

http_request_json(
	link+"users",
	"GET",
	"",
	function(_result){
		players = _result
	}
)