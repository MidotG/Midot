extends Area2D

@export var speed = 1700;
@export var damage = 10;

var dir;

func _ready():
	pass;
	
func _process(delta):
	position -= dir * speed * delta;
	

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.get_damage(damage);
		body.kill();
		queue_free();
