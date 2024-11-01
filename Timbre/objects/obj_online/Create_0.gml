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
		
	},
	size:{x:128,y:64},
	position:{x:128,y:128},
	sizeMod:0
}
button[2]={
	name: "Create Account",
	func: function(){
		http_request_json(
			"http://localhost:3000/api/newUser",
			"POST",
			{name:"John undertale",username:"john",password:"password"},
			function(_result){
				show_message(_result)
			}
		)
	},
	size:{x:128,y:64},
	position:{x:128,y:64+128},
	sizeMod:0
}

players=[]

http_request_json(
	"http://localhost:3000/api/users",
	"GET",
	"",
	function(_result){
		players = _result
	}
)