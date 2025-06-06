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


func _ready():
	z_index = 1;
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
			$Graphics/Alive.play("attack");
			#SfxPlayer.play_sound_without_check(6);
			$attackSound.play();
	else:
		move_speed = const_move_speed;
		$Graphics/Alive.play("move");

func kill():
	#SfxPlayer.play_sound_without_check(7);
	$deathSound.play();
	$Graphics/Alive.play("death");
	set_physics_process(false);
	$CollisionShape2D.set_deferred("disabled", true);
	z_index = 0;
	pointsSignal.emit(pointsForKill);
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);
	
func _on_dead_left_timeout():
	queue_free();

func _on_attack_int_timeout():
	canAttack = true;
