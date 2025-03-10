extends CharacterBody2D;

@export var move_speed = 350;

#//оружие 
#///TODO: сделать список хранящий экземпляры оружия.
#///TODO: скорее всего еще сделать сцену - класс, который как раз будет давать внешку, способности и второе оружие, а также статы.
@export var weapon_scene : PackedScene;
var weapon_instance: Node2D = null;

var dead = false;

func _ready():
	$uiCanvas/PlayerUI.show();
	if weapon_scene:
		weapon_instance = weapon_scene.instantiate();
		$WeaponAttachment.add_child(weapon_instance);
	pass;

func _process(delta):
	if dead:
		return;
	look_at(get_global_mouse_position());
	if Input.is_action_just_pressed("shoot"):
		weapon_instance.shoot($WeaponAttachment.global_position);
		
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
	$deathCanvas/DeathScreen.show();
	z_index = -1;
	
func restart():
	get_tree().reload_current_scene();


func _on_button_pressed():
	restart();


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");
