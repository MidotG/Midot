extends CharacterBody2D;


@onready var ray_cast_2d= $RayCast2D;
@export var move_speed = 350;

var dead = false;

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		reload();
	if dead:
		return;
	look_at(get_global_mouse_position());
	if Input.is_action_just_pressed("shoot"):
		shoot();
		
func _physics_process(delta):
	if dead:
		return;
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = move_dir * move_speed;
	move_and_slide();
	
func kill():
	if dead:
		return;
	dead = true;
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$CanvasLayer/DeathScreen.show();
	z_index = -1;
	
func restart():
	get_tree().reload_current_scene();
	
func reload():   #///TODO: перезарядку оружия.
	pass;
	
func shoot():
	$MuzzleFlash.show();
	$MuzzleFlash/Timer.start();
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method("kill"):
		ray_cast_2d.get_collider().kill();
	


func _on_button_pressed():
	restart();


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");
