extends Control


func _on_level_1_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn");


func _on_level_2_button_pressed():
	get_tree().change_scene_to_file("res://world_2.tscn");


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");
