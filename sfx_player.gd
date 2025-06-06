extends AudioStreamPlayer

@export var music_tracks : Array[AudioStream] = []; 
var current_track_index = -1;

func _ready():
	pass;

func play_sound(track_index: int):
	if current_track_index == track_index:
		return;
	if track_index >= 0 and track_index < music_tracks.size():
		current_track_index = track_index
		stream = music_tracks[current_track_index];
		play();
		print("Звук: Начало воспроизведения звукового эффекта ", current_track_index);
	else:
		printerr("Ошибка: Неверный индекс звукового эффекта: ", track_index);

func play_sound_without_check(track_index: int):
	if track_index >= 0 and track_index < music_tracks.size():
		current_track_index = track_index
		stream = music_tracks[current_track_index];
		play();
		print("Звук: Начало воспроизведения звукового эффекта ", current_track_index);
	else:
		printerr("Ошибка: Неверный индекс звукового эффекта: ", track_index);

func stop_music():
	stop();
	print("Звук: Остановлено воспроизведение");

func _on_finished():
	current_track_index = -1;
