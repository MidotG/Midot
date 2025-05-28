extends CharacterBody2D;


#///TODO: спавн камикадзе зомби вокруг него.

signal pointsSignal(point : int);

@export var pointsForKill : int = 10;
@export var const_move_speed : int = 250;
var move_speed = const_move_speed;
@export var attack_damage : int = 20;
@onready var ray_cast_2d = $RayCast2D;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player");
@onready var dead_left = $deadLeft;
@onready var hp = $healthComponent;

@onready var hp_bar = $hpBar;

var canAttack = true;


func _ready():
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	hp_bar.value = hp.max_health;
	hp_bar.visible = false;
	pass;

func _physics_process(delta):
	if hp.dead:
		return;
	else:
		hp_bar.global_position = global_position + Vector2(-60, 90);
		hp_bar.rotation = -rotation;
	
	
	var dir_to_player = global_position.direction_to(player.global_position);
	velocity = dir_to_player * move_speed;
	move_and_slide();
	global_rotation = dir_to_player.angle() + PI/2.0;
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		move_speed = 0;
		if canAttack == true:
			canAttack = false;
			$attackInt.start();
			player.damage(attack_damage);
	else:
		move_speed = const_move_speed;
		
func kill():
	hp_bar.queue_free();
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$CollisionShape2D.queue_free();
	z_index = 1;
	pointsSignal.emit(pointsForKill);
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);
	update_hp_label();
	hp_bar.visible = true;
	
func _on_dead_left_timeout():
	queue_free();

func _on_attack_int_timeout():
	canAttack = true;

func update_hp_label():
	var cur_hp = hp.health/hp.max_health*100;
	hp_bar.value = cur_hp;
