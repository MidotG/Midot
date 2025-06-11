extends CharacterBody2D;

@export var move_speed = 350;

#///TODO: придумать время, карту, препятствия и противников для 10 уровней.


@onready var hp = $healthComponent;
var weapon_scene = {
	"PISTOL": preload("res://pistol.tscn"),
	"RIFFLE": preload("res://automatic_rifle.tscn"),
	"MINIGUN": preload("res://minigun.tscn"),
	"LASER": preload("res://laser_gun.tscn"),
	"DESTROYER": preload("res://laser_destroyer.tscn"),
	"NIGA": preload("res://niga.tscn")
};
var weapon_instance: Node2D = null;
var weapon_num:int = 0;
var selected_weapons = Saves.selected_weapons;


func _ready():
	$Graphics/Alive.play("idle");
	#Saves.load_game();
	print(Saves.hp);
	hp.max_health = Saves.hp;
	hp.health = hp.max_health;
	$uiCanvas/PlayerUI.show();
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	$lvlPassCanvas/lvl_passed.connect("disablePMSignal", Callable(self, "disablePM"));
	if weapon_scene:
		weapon_instance = weapon_scene["PISTOL"].instantiate();
		$WeaponAttachment.add_child(weapon_instance);
	pass;

func _process(delta):
	if hp.dead:
		return;
	look_at(get_global_mouse_position());
	if Input.is_action_pressed("shoot"):
		weapon_instance.shoot($WeaponAttachment.global_position);
	if Input.is_action_just_pressed("w1"):
		weapon_instance = weapon_scene["PISTOL"].instantiate();
		for n in $WeaponAttachment.get_children():
			$WeaponAttachment.remove_child(n);
			n.queue_free();
		$WeaponAttachment.add_child(weapon_instance);
	if Input.is_action_just_pressed("w2"):
		if Saves.selected_weapons.size() < 1:
			return;
		if Saves.selected_weapons[0] == null:
			return;
		weapon_instance = weapon_scene[Saves.selected_weapons[0]].instantiate();
		for n in $WeaponAttachment.get_children():
			$WeaponAttachment.remove_child(n);
			n.queue_free();
		$WeaponAttachment.add_child(weapon_instance);
	if Input.is_action_just_pressed("w3"):
		if Saves.selected_weapons.size() < 2:
			return;
		if Saves.selected_weapons[1] == null:
			return;
		weapon_instance = weapon_scene[Saves.selected_weapons[1]].instantiate();
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
	if move_dir == Vector2.ZERO:
		$Graphics/Alive.play("idle");
	else: 
		$Graphics/Alive.play("move");
	
func damage(damage):
	hp.damage(damage);
	
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$lvlPassCanvas/lvl_lost.lvlPass(0);
	z_index = -1;

func lvl_pass(lvl_num: int):
	$lvlPassCanvas/lvl_passed.lvlPass(lvl_num);
	
func disablePM():
	$pauseCanvas/PauseMenu.set_process(false);
	
