extends Control


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn");


func _on_options_button_pressed():
	var options = load("res://settings.tscn").instantiate();
	get_tree().current_scene.add_child(options);
# // Ыаа ыааа поверх главного меню настройки лезут, в меню и настройках добавить задний фон.
	#get_tree().change_scene_to_file("res://settings.tscn");
	

func _on_quit_button_pressed():
	pass # Replace with function body.
