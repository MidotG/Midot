extends AudioStreamPlayer

@onready var music_player = MusicPlayer; # Получаем ссылку на AudioStreamPlayer

# Массив для хранения музыкальных треков (AudioStream ресурсов)
@export var music_tracks : Array[AudioStream] = []; # Используем @export для удобства заполнения в редакторе, тип Array[AudioStream]

var current_track_index = -1 # Индекс текущего играющего трека

#func _ready():
	#if music_tracks.size() > 0:
		#play_track(0) # Начнем играть первый трек при запуске (опционально)

func play_track(track_index : int):
	if current_track_index == track_index:  #///TODO: проверить потом музыку когда настройки и стоп меню будут во время лвла.
		return;
	if track_index >= 0 and track_index < music_tracks.size():
		current_track_index = track_index
		music_player.stream = music_tracks[current_track_index]
		music_player.play()
		print("Музыка: Начало воспроизведения трека ", current_track_index)
	else:
		printerr("Ошибка: Неверный индекс музыкального трека: ", track_index)

func stop_music():
	music_player.stop()
	print("Музыка: Остановлено воспроизведение")


func get_current_track_index():
	return current_track_index
