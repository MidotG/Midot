extends Control

signal disablePMSignal;

func _ready():
	pass;

func _process(delta):
	pass;

func lvlPass():
	disablePMSignal.emit();
	Saves.currency += Saves.points/10;
	Saves.points = 0;
	Saves.save_game();
	get_tree().paused = true;
	show();

func _on_menu_btn_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://menu.tscn");

func _on_restart_btn_pressed():
	get_tree().paused = false;
	get_tree().reload_current_scene();
	hide();
