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
	

#///TODO: разобраться с группами.
#///TODO: сделать взаимодействие пули с группой протинвников. И исчезновение после урона противнику.
func _on_body_entered(body):
	print("killed");
	if body.is_in_group("enemy"):
		print("killed");
		body.get_damage(damage);
		body.kill();
		queue_free();
