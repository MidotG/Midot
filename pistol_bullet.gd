extends Area2D

@export var speed = 700;
@export var damage = 10;

var dir;

func _ready():
	#await get_tree().create_timer(3).timeout;
	#queue_free();
	pass;
	
func _process(delta):
	position -= dir * speed * delta;
	#print(position);
	

#///TODO: изменить точку спавна пули, и сделать взаимодействие с группой протинвников пули.

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.get_damage(damage);
		print("killed");
		queue_free();
