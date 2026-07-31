extends AudioStreamPlayer2D

signal song_changed(song_name)

var songs = [
	preload("res://music/synth_1.mp3")
]

var current_song := -1

func _ready():
	play_random()

func play_random():
	current_song = randi() % songs.size()
	stream = songs[current_song]
	play()
	#es la nueva forma de pemitir señales omaigoto
	song_changed.emit(GetSongName())

func GetSongName() -> String:
	return songs[current_song].resource_path.get_file().get_basename()


func _on_timer_timeout() -> void:
	var cancion = GetSongName()
	print ("tocando ", cancion)
