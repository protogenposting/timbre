/// @description Insert description here
// You can write your code in this editor
if(global.currentPlaylist!=0)
{
	if(array_length(global.playlists[global.currentPlaylist].levels)>0)
	{
		array_delete(global.playlists[global.currentPlaylist].levels,wheelProgress,1)
	}
	else
	{
		array_delete(global.playlists,global.currentPlaylist,1)
		global.currentPlaylist=0
	}
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