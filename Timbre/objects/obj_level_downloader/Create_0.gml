/// @description Insert description here
// You can write your code in this editor

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
	name: "Search",
	func: function(){
		var _str=get_string("search terms","")
		with(obj_level_downloader)
		{
			page=0
			request="https://api.quavergame.com/v1/mapsets/maps/search?search="+_str+"&mode=2&status=2&page="
			get=http_get(request+string(page))
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+128},
	sizeMod:0
}

request="https://api.quavergame.com/v1/mapsets/maps/search?mode=2&status=2&page="

page=0

get=http_get(request+string(page))