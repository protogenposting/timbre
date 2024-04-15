// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_chart_style(difficultyID){
	switch(difficultyID)
	{
		case 0:
			return "Normal"
		case 1:
			return "Ultra"
		case 2:
			return "Simple"
	}
	return 0
}