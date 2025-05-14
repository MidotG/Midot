extends CharacterBody2D;

@export var move_speed = 350;

#//оружие 
#///TODO: сделать список хранящий экземпляры оружия.

#///TODO: придумать время, карту, препятствия и противников для 10 уровней.


@onready var hp = $healthComponent;
@export var weapon_scene : Array[PackedScene];
var weapon_instance: Node2D = null;
var weapon_num:int = 0;
var selected_weapons = [];


func _ready():
	$uiCanvas/PlayerUI.show();
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	$lvlPassCanvas/lvl_passed.connect("disablePMSignal", Callable(self, "disablePM"));
	if weapon_scene:
		weapon_instance = weapon_scene[weapon_num].instantiate();
		$WeaponAttachment.add_child(weapon_instance);
	
	pass;

func _process(delta):
	if hp.dead:
		return;
	look_at(get_global_mouse_position());
	if Input.is_action_pressed("shoot"):
		weapon_instance.shoot($WeaponAttachment.global_position);
	if Input.is_action_just_pressed("w1"):
		weapon_num = 0;
		weapon_instance = weapon_scene[weapon_num].instantiate();
		for n in $WeaponAttachment.get_children():
			$WeaponAttachment.remove_child(n);
			n.queue_free();
		$WeaponAttachment.add_child(weapon_instance);
	if Input.is_action_just_pressed("w2") && Saves.unlocked_weapons["RIFFLE"]:
		weapon_num = 1;
		weapon_instance = weapon_scene[weapon_num].instantiate();
		for n in $WeaponAttachment.get_children():
			$WeaponAttachment.remove_child(n);
			n.queue_free();
		$WeaponAttachment.add_child(weapon_instance);
	if Input.is_action_just_pressed("w3") && Saves.unlocked_weapons["MINIGUN"]:
		weapon_num = 2;
		weapon_instance = weapon_scene[weapon_num].instantiate();
		for n in $WeaponAttachment.get_children():
			$WeaponAttachment.remove_child(n);
			n.queue_free();
		$WeaponAttachment.add_child(weapon_instance);
		
func _physics_process(delta):
	if hp.dead:
		return;
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = move_dir * move_speed;
	move_and_slide();
	
func damage(damage):
	hp.damage(damage);
	
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$lvlPassCanvas/lvl_lost.lvlPass();
	z_index = -1;

func lvl_pass():
	$lvlPassCanvas/lvl_passed.lvlPass();
	
func disablePM():
	$pauseCanvas/PauseMenu.set_process(false);
	
