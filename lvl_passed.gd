extends Control

signal disablePMSignal;
var cur_lvl: int = 0;
@onready var next_lvl_btn = $Panel/VBoxContainer/nextLvlBtn;

func _ready():
	pass;

func _process(delta):
	pass;

func lvlPass(lvl_num: int):
	if lvl_num < 10 && lvl_num > 0:
		cur_lvl = lvl_num;
		next_lvl_btn.pressed.connect(change_to_next_lvl);
	else:
		next_lvl_btn.text = "Конец";
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

func change_to_next_lvl():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://world_" + str(cur_lvl + 1) + ".tscn");
