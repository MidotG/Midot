extends Control

signal disablePMSignal;

func _ready():
	pass;

func _process(delta):
	pass;

func lvlPass():
	disablePMSignal.emit();
	$Panel/VBoxContainer/totalPoints.text = "Очков заработано: " + str(SaveLvl.points);
	Saves.currency += SaveLvl.points/10;
	SaveLvl.points = 0;
	SaveLvl.reload();
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
