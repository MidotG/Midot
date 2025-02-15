extends Node2D

func _ready():
	MusicPlayer.play_track(1);

#func _process(delta):
	#if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		#print("FULLSCREEN");
	#else:
		#print(DisplayServer.window_get_mode());

