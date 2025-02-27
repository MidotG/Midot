extends Area2D

@export var speed = 200;
@export var damage = 10;

var dir:Vector2;

func _ready():
	await get_tree().create_timer(3).timeout;
	queue_free();

func set_direction(bulletDirection):
	dir = bulletDirection;
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position + dir));
	
func _physics_process(delta):
	global_position += dir * speed * delta;
	
func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.get_damage(damage);
		print("killed");
		queue_free();
