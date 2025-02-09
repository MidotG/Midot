extends Control


func _ready():
	MusicPlayer.play_track(0);
	#MusicPlayer.play_track(4);

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn");


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn");
	

func _on_quit_button_pressed():
	get_tree().quit();
