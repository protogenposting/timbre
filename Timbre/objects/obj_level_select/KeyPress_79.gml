/// @description Insert description here
// You can write your code in this editor
if(global.currentPlaylist!=0)
{
	//delete the playlist
	array_delete(global.playlists[global.currentPlaylist].levels,wheelProgress,1)
}
else
{
	//add teh current song (MAKE THIS ACTUALLY WORK)
	selectingPlaylist=true

	selectedPlaylistFunc=function(_playlistID){
		var _levels=get_playlist_levels(global.currentPlaylist)
		array_push(global.playlists[_playlistID].levels,_levels[wheelProgress].path)
	}
}