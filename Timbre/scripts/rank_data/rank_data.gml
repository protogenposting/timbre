var _temporaryRanks=[{percent:115,name:"P+",messages:[
	"WE IN OHIO FR FR"
	]},
{percent:100,name:"P",messages:[
	"PHENOMINAL!",
	"P is for... PLEASE HAVE MY BABIES",
	"Perfection!",
	"Pure Perfect!",
	"What are you an osu player?",
	"How many hours was that?"
	]},
{percent:95,name:"S",messages:[
	"OMG UR SO GOOD!",
	"S is for... SANS UNDERTALE?!?!?!?!",
	"Sloppy toppy!",
	"Nice! Full combo!... probably!... idk if u got one!"
	]},
{percent:90,name:"A+",messages:[
	"Great job... PLUS!",
	"A+ is for... Almost an S! Plus!!!",
	"You get a shiny quarter!"]},
{percent:85,name:"A",messages:[
	"Great job!",
	"A is for... AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
	"You did great! Next time go for a 100% score!"]},
{percent:80,name:"B+",messages:[
	"Cooler than a regular B!",
	"B+ is for... Boi just get an A already! Plus!!!",
	"...alright i guess"]},
{percent:75,name:"B",messages:[
	"Cool!",
	"B is for... BOOTYHOLE",
	"BARRY B BENSON THE BILLIONTH"]},
{percent:65,name:"C+",messages:[
	"Good job i guess...... PLUS!!!",
	"C+ is for... Can't you just get a B? Plus!!!",
	"Go remake the game in C++. Maybe then you can get better accuracy."]},
{percent:50,name:"C",messages:[
	"Good job i guess",
	"C is for... Corn!",
	"COBWOB WOOP WOOP"]},
{percent:40,name:"D+",messages:[
	"Needs some work... PLUS!!!",
	"D+ is for... DANI?!?!?!??! PLUS?!?!?!?!?",
	"Hi dani :3"]},
{percent:30,name:"D",messages:[
	"Needs some work...",
	"D is for... Detention! >:(",
	"DICK AND BALLS"]},
{percent:0,name:"F",messages:[
	"Did you even try?",
	"F is for... FIVE NIGHT FREDDY?!?!?!?",
	"FFFFFFFFFFFFFFFFAAAAAAAAAAAAAAAAAARRRRRRRRRRTTTTTTTTTTTTT"]},
{percent:-1,name:"F-",messages:[
	"How did u get an F- lmao"]}]

#macro ranks _temporaryRanks

function get_rank_id_string(accuracyPercentage){
	for(var i=0;i<array_length(ranks);i++)
	{
		if(accuracyPercentage==ranks[i].name)
		{
			return i
		}
	}
	return 8
}

function get_rank(accuracyPercentage){
	for(var i=0;i<array_length(ranks);i++)
	{
		if(accuracyPercentage>=ranks[i].percent)
		{
			return ranks[i].name
		}
	}
	return "???"
}

function get_rank_id(accuracyPercentage){
	for(var i=0;i<array_length(ranks);i++)
	{
		if(accuracyPercentage>=ranks[i].percent)
		{
			return i
		}
	}
	return -4
}