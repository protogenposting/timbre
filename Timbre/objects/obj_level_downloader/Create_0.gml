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
			request="https://api.quavergame.com/v1/mapsets/maps/search?search="+_str+"&mode="+string(mode)+"&status="+string(status)+"&page="
			get_request()
		}
	},
	size:{x:128,y:64},
	position:{x:128,y:64+128},
	sizeMod:0
}

page=0

mode=1

status=1

request="https://api.quavergame.com/v1/mapsets/maps/search?mode="+string(mode)+"&status="+string(status)+"&page="

function get_request(){
	get=http_get(request+string(page))
	loading=true
	loadTime=0
	selectedLevel=-4
}

get_request()

loading=true

loadTime=0

levels=[]

scrollY=0

scrollYSpeed=0

scrollReduceTime=0

scrollSpeed=3

selectedLevel=-4

/*

TODO:

add converter (converts beatmaps to timbre maps. doubles triples and quads will be turned into log hits)

add downloading

add mp3 to ogg converter (if needed)