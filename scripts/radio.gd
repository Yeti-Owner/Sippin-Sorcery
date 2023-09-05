extends Node3D

@onready var RadioDisplay = $Label3D

var Songs:Dictionary = {
	0 : ["Sunsets - @itsskyebaby", "res://assets/audio/music/Sunsets.wav"],
	1 : ["Vacation - @itsskyebaby", "res://assets/audio/music/Vacation.wav"],
	2 : ["In The Morning - @LavenderGS", "res://assets/audio/music/InTheMorning.mp3"],
	3 : ["Dreamin' - @LavenderGS", "res://assets/audio/music/Dreamin.mp3"],
	4 : ["Snowfall - @LavenderGS", "res://assets/audio/music/Snowfall.mp3"]
}
var CurrentSong:int = 1
var DisplayLength:int = 12

var DisplayFrom:int = 0

func _ready():
	DisplayFrom = 0
	$MusicPlayer.stream = load(Songs[CurrentSong][1])
	$MusicPlayer.play()

func _back():
	CurrentSong = wrap(CurrentSong - 1, 0, Songs.size())
	_ready()

func _next():
	CurrentSong = wrap(CurrentSong + 1, 0, Songs.size())
	_ready()

# when I wrote this code only God and I understood what it did
# now only God knows
func _on_timer_timeout():
	var NewSongDisplay := str(Songs[CurrentSong][0] + "        " + Songs[CurrentSong][0])
	if NewSongDisplay.substr(DisplayFrom, DisplayLength) == NewSongDisplay.substr(0, DisplayLength):
		DisplayFrom = 0
	RadioDisplay.text = NewSongDisplay.substr(DisplayFrom, DisplayLength)
	DisplayFrom += 1

func _on_music_player_finished():
	$MusicPlayer.play()
