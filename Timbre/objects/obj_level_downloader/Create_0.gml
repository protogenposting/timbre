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
		obj_level_downloader.get=http_get("https://api.quavergame.com/v1/mapsets/maps/search?search=swan&mode=2&status=2")
	},
	size:{x:128,y:64},
	position:{x:128,y:64+128},
	sizeMod:0
}

get=-4