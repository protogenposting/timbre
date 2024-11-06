var body = "levelName"

var form = new FormData();

var headers = ds_map_create();

ds_map_add(headers, "Session", json_stringify({username:global.username,session:global.session}));

form.add_data("fileName",body);

form.add_file("file",game_save_id+"test.zip");

http(link+"levelUpload", "POST",form,{ headers, keep_header_map: false },function(status,result){
	show_message_async(result);
});	