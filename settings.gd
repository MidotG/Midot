extends Control


func _on_quit_settings_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");
