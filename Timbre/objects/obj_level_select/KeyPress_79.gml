/// @description Insert description here
// You can write your code in this editor
if(global.currentPlaylist!=0)
{
	//delete the playlist
	if(show_question("delete "+global.playlists[global.currentPlaylist].name+"?"))
	{
		array_delete(global.playlists,global.currentPlaylist,1)
		global.currentPlaylist=0
		var _levels=get_playlist_levels(global.currentPlaylist)
		wheelProgress=0
		initialize_level(wheelProgress)
	}
}
else
{
	//add teh current song
	selectingPlaylist=true

	selectedPlaylistFunc=function(_playlistID){
		var _levels=get_playlist_levels(global.currentPlaylist)
		array_push(global.playlists[_playlistID].levels,_levels[wheelProgress].path)
	}
}