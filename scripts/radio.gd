extends Node3D

@onready var RadioDisplay = $Label3D

var Songs:Dictionary = {
	0 : ["Sunsets - @itsskyebaby", "res://assets/audio/music/Sunsets.wav"],
	1 : ["Vacation - @itsskyebaby", "res://assets/audio/music/Vacation.wav"]
}
var CurrentSong:int = 0
var DisplayLength:int = 12

var DisplayFrom:int = 0

# when I wrote this code only God and I understood what it did
# now only God knows
func _on_timer_timeout():
	var NewSongDisplay := str(Songs[CurrentSong][0] + "        " + Songs[CurrentSong][0])
	if NewSongDisplay.substr(DisplayFrom, DisplayLength) == NewSongDisplay.substr(0, DisplayLength):
		DisplayFrom = 0
	RadioDisplay.text = NewSongDisplay.substr(DisplayFrom, DisplayLength)
	DisplayFrom += 1
