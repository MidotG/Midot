extends Control

func _ready():
	Saves.load_game();
	MusicPlayer.play_track(0);

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://lvl_menu.tscn");


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn");
	

func _on_quit_button_pressed():
	get_tree().quit();


func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://shop.tscn");
