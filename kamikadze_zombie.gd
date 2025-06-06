extends CharacterBody2D;

signal pointsSignal(point : int);

@export var pointsForKill : int = 10;
@export var const_move_speed : int = 250;
var move_speed = const_move_speed;
@export var attack_damage : int = 20;
@onready var ray_cast_2d = $RayCast2D;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player");
@onready var hp = $healthComponent;
@onready var dead_left = $deadLeft;


func _ready():
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	set_collision_mask_value(2, false);
	pass;

func _physics_process(delta):
	if hp.dead:
		return;
	var dir_to_player = global_position.direction_to(player.global_position);
	global_rotation = dir_to_player.angle() + PI/2.0;
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		velocity = Vector2.ZERO;
		player.damage(attack_damage);
		damage(attack_damage);
	else:
		velocity = dir_to_player * const_move_speed
	move_and_slide();
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	set_physics_process(false);
	$CollisionShape2D.set_deferred("disabled", true);
	pointsSignal.emit(pointsForKill);
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);


func _on_dead_left_timeout():
	$CollisionShape2D.queue_free();
	queue_free();
