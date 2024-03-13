/// @description Insert description here
// You can write your code in this editor
songMilliseconds=audio_sound_get_track_position(audio)*1000

var barPercentageLast = barPercentage
var beatLength=60/bpm
var needle = songMilliseconds/1000
var left = currentBeat * beatLength;
var right = left + beatLength;
barPercentage = remap(needle, left, right, 0, 1);

if(frac(barPercentage)<frac(barPercentageLast))
{
	currentShroomPose++
}