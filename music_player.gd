extends AudioStreamPlayer

@export var music_tracks : Array[AudioStream] = []; 
var current_track_index = -1;

func _ready():
	if not finished.is_connected(_on_music_finished):
		finished.connect(_on_music_finished, CONNECT_REFERENCE_COUNTED)

func play_track(track_index : int):
	if current_track_index == track_index:
		return;
	if track_index >= 0 and track_index < music_tracks.size():
		current_track_index = track_index
		stream = music_tracks[current_track_index]
		play()
		print("Музыка: Начало воспроизведения трека ", current_track_index);
		#print(str(current_track_index) + "ТЕКУЩИЙ КУРЕНТ ТРЭК ИНДЕКС МЕТОД ПОСЛЕ НАЧАЛА`");
	else:
		printerr("Ошибка: Неверный индекс музыкального трека: ", track_index);

func _on_music_finished():
	#print(str(current_track_index) + "ТЕКУЩИЙ КУРЕНТ ТРЭК ИНДЕКС МЕТОД ПОСЛЕ ЗАВЕРШЕНИЯ");
	var cur_track_index = current_track_index;
	current_track_index = -1;
	play_track(cur_track_index);

func stop_music():
	stop();
	print("Музыка: Остановлено воспроизведение")

func get_current_track_index():
	return current_track_index;

