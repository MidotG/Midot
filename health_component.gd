extends Node2D

@export var max_health : int =100;
var health : int;


# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health;

func damage(attack):
	health -= attack;
	if health <= 0:
		#///TODO: соединить с методом смерти сцены игрока. 
		
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
