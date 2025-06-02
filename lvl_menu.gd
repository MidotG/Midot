extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://menu.tscn");


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
