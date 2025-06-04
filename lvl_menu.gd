extends Control

@onready var level_buttons :=[
	$HBoxContainer/lvl1, $HBoxContainer/lvl2, $HBoxContainer/lvl3, $HBoxContainer/lvl4, $HBoxContainer/lvl5,
	$HBoxContainer2/lvl6, $HBoxContainer2/lvl7, $HBoxContainer2/lvl8, $HBoxContainer2/lvl9, $HBoxContainer2/lvl10
];
@onready var end_lbl = $endLbl;

# Called when the node enters the scene tree for the first time.
func _ready():
	end_lbl.visible = false;
	if Saves.unlocked_levels == 11:
		end_lbl.visible = true;
	update_buttons();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://menu.tscn");

func update_buttons():
	for i in range(level_buttons.size()):
		var button = level_buttons[i]
		button.disabled = (i + 1) > Saves.unlocked_levels;

func _on_menu_btn_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");

func _on_lvl_1_pressed():
	get_tree().change_scene_to_file("res://world.tscn");

func _on_lvl_2_pressed():
	get_tree().change_scene_to_file("res://world_2.tscn");

func _on_lvl_3_pressed():
	get_tree().change_scene_to_file("res://world_3.tscn");

func _on_lvl_4_pressed():
	get_tree().change_scene_to_file("res://world_4.tscn");

func _on_lvl_5_pressed():
	get_tree().change_scene_to_file("res://world_5.tscn");

func _on_lvl_6_pressed():
	get_tree().change_scene_to_file("res://world_6.tscn");

func _on_lvl_7_pressed():
	get_tree().change_scene_to_file("res://world_7.tscn");

func _on_lvl_8_pressed():
	get_tree().change_scene_to_file("res://world_8.tscn");

func _on_lvl_9_pressed():
	get_tree().change_scene_to_file("res://world_9.tscn");

func _on_lvl_10_pressed():
	get_tree().change_scene_to_file("res://world_10.tscn");
	#get_tree().change_scene_to_file("res://exp_world.tscn");
