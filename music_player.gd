extends AudioStreamPlayer

@onready var music_player = MusicPlayer # Получаем ссылку на AudioStreamPlayer

# Массив для хранения музыкальных треков (AudioStream ресурсов)
@export var music_tracks : Array[AudioStream] = [] # Используем @export для удобства заполнения в редакторе, тип Array[AudioStream]

var current_track_index = -1 # Индекс текущего играющего трека

func _ready():
	if music_tracks.size() > 0:
		play_track(0) # Начнем играть первый трек при запуске (опционально)

func play_track(track_index : int):
	if current_track_index == track_index:
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

func set_volume(volume : float):
	# volume - значение от 0.0 (полностью тихо) до 1.0 (максимальная громкость)
	# Конвертируем линейную громкость в децибелы (dB) для AudioStreamPlayer
	# dB = 20 * log10(volume)  (при volume = 0, dB будет -infinity, поэтому нужно обрабатывать 0)
	if volume <= 0:
		music_player.volume_db = -80 # Минимальное значение, чтобы звук был практически неслышен
	else:
		music_player.volume_db = 20.0 * log(volume) / log(10.0)
	print("Музыка: Установлена громкость ", volume)

func get_current_track_index():
	return current_track_index
