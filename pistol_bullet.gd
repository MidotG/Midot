extends Area2D

@export var speed = 1700;
@export var damage = 10;

var dir;

func _ready():
	#await get_tree().create_timer(3).timeout;
	#queue_free();
	pass;
	
func _process(delta):
	position -= dir * speed * delta;
	

func _on_body_entered(body):
	#print("killed");
	print("Пуля столкнулась с:", body.name)
	if body.is_in_group("Enemy"):
		print("killed");
		body.get_damage(damage);
		body.kill();
		queue_free();
	else:
		print("Обьект не в группе enemy");
