extends CharacterBody2D;

signal pointsSignal(point : int);

@export var pointsForKill : int = 10;
@export var const_move_speed : int = 250;
var move_speed = const_move_speed;
@onready var ray_cast_2d = $RayCast2D;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player");
@onready var dead_left = $deadLeft;
@onready var hp = $healthComponent;

var zombie_bullet = preload("res://zombie_bullet.tscn");
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
			$Graphics/Alive.play("attack");
			$attackSound.play();
			$attackInt.start();
			var bul = zombie_bullet.instantiate();
			bul.dir = (position - player.global_position).normalized();
			get_tree().root.add_child(bul);
			bul.rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position + bul.dir));
			bul.position = position;
	else:
		move_speed = const_move_speed;
		$Graphics/Alive.play("move");
		
func kill():
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
