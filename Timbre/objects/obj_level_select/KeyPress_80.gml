/// @description Playlist creation

var _playlist=new playlist(get_string("playlist name","Epic Playlist"),[])
if(wheelProgress>=0)
{
	array_push(_playlist.levels,wheelProgress)
	array_push(global.playlists,_playlist)
}