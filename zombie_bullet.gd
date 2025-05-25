extends Area2D

@export var speed = 1700;
@export var damage = 20;

var dir;

func _ready():
	pass;
	
func _process(delta):
	position -= dir * speed * delta;
	

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(damage);
	queue_free();
