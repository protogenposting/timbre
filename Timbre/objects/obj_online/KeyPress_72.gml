var form = new FormData();

form.add_file("file",game_save_id+"test.zip");

form.add_data("foo","bar");

var headers = ds_map_create();

ds_map_add(headers, "Content-Type", "application/json");

ds_map_add(headers, "Authorization", "A92n5nIlklaPosfbngfbsYYhfkskaNuuHGFNJSA");

http(link+"levelUpload", "POST", form, {headers:headers}, function(http_status,result){
	show_message(result);
},function(http_status,result){
	show_message("Error - " + result);
});