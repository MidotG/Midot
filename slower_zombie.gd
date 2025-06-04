extends CharacterBody2D;

signal pointsSignal(point : int);

@export var pointsForKill : int = 10;
@export var const_move_speed : int = 250;
var move_speed = const_move_speed;
@export var attack_damage : int = 20;
@onready var ray_cast_2d = $RayCast2D;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player");
@onready var dead_left = $deadLeft;
@onready var hp = $healthComponent;

var canAttack = true;

@onready var slow_effect_time = $slow_effect_time
@export var slow_down_factor: float = 0.5  # Во сколько раз замедляем (0.5 = 50% скорости)
var original_speed: float

func _ready():
	original_speed = player.move_speed;
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	pass;

func _physics_process(delta):
	if hp.dead:
		return;
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
			apply_slow_effect();
	else:
		move_speed = const_move_speed;
		
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$CollisionShape2D.queue_free();
	z_index = 1;
	pointsSignal.emit(pointsForKill);
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);
	
func _on_dead_left_timeout():
	if player:
		player.move_speed = original_speed;
	queue_free();

func _on_attack_int_timeout():
	canAttack = true;

func apply_slow_effect():
	if player:
		player.move_speed = original_speed * slow_down_factor
		slow_effect_time.start()  # Таймер для возврата нормальной скорости

func _on_slow_effect_time_timeout():
	if player:
		player.move_speed = original_speed;

