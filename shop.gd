extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$shopPanel/balanceLabel.text += str(Saves.currency);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://menu.tscn");


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");


func _on_button_pressed():
	Saves.currency += 10;
	Saves.save_game();
	pass;
