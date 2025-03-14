extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass; # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func lvlPass():
	get_tree().paused = true;
	show();
	#InputMap.action_erase_events("pause");
	#process_mode = Node.PROCESS_MODE_DISABLED;
	#///TODO: отрубить pause - input action во время окончания уровня, чтобы нельзя было вернуть игру в актив.
	

func _on_menu_btn_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://menu.tscn");

func _on_restart_btn_pressed():
	get_tree().paused = false;
	get_tree().reload_current_scene();
	hide();
