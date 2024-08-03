/// @description Insert description here
// You can write your code in this editor
axisLast=[]

global.pressingMouseLeft=false

user={username:"billy"}

http_post_string("http://localhost:3000/api/users",json_stringify(user))