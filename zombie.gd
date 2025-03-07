extends CharacterBody2D;

@onready var ray_cast_2d = $RayCast2D;
@export var move_speed = 250;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player");
@onready var dead_left = $deadLeft;


var dead = false;

func _ready():
	pass;

func _physics_process(delta):
	if dead:
		return;
	var dir_to_player = global_position.direction_to(player.global_position);
	velocity = dir_to_player * move_speed;
	move_and_slide();
	global_rotation = dir_to_player.angle() + PI/2.0;
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		player.kill();
	
	
func kill():
	if dead:
		return;
	dead = true;
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$CollisionShape2D.queue_free();
	z_index = 1;
	dead_left.start();
	
func get_damage(damage):
	print('damage taken');
	
	


func _on_dead_left_timeout():
	queue_free();
