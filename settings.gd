extends Control

@onready var checkBoxButton = $VBoxContainer/HBoxContainer/CheckBox;

func _ready():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		checkBoxButton.button_pressed = true;
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		checkBoxButton.button_pressed = false;
	
	
func _on_quit_settings_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");
	

func _on_check_box_toggled(toggled_on):
	if toggled_on == true:
		get_window().mode = Window.MODE_WINDOWED;
		get_viewport().size = Vector2i(1280,720);
		get_window().move_to_center();
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN);
