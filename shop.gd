extends Control

#///TODO: щас сделать 2 персов и по 2 оружия(1 пестик, 2 спец. оружие), и потом добавить в магаз, и сохранять выбор, и в уровни заходить с ним.

# Called when the node enters the scene tree for the first time.
func _ready():
	$shopPanel/balanceLabel.text += str(Saves.currency);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://menu.tscn");


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");

