/// @function                snap(_cell_size,val)
/// @description             Snaps a certain variable to the grid
/// @param 			 _cell_size    the cell size for the grid
/// @param 			 val		   the value to snap
/// @return {Real}
function snap(_cell_size,val){
	return floor(val/_cell_size)*_cell_size;
}