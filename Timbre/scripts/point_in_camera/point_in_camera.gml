// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function point_in_camera(_l,_r,_t,_b){
	return _r>=camera_get_view_x(view_camera[0])&&_l<=camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])&&_b>=camera_get_view_y(view_camera[0])&&_t<=camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])
}