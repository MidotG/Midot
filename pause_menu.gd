extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	testEsc();


func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		get_tree().paused = true;
		show();
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		get_tree().paused = false;
		hide();
		

func _on_resume_btn_pressed():
	get_tree().paused = false;
	hide();

func _on_restart_btn_pressed():
	get_tree().paused = false;
	get_tree().reload_current_scene();
	
func _on_quit_lvl_btn_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://menu.tscn");


