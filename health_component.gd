extends Node2D

@export var max_health : int = 100;
var health : int;
var dead = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health;

func damage(attack):
	health -= attack;
	if health <= 0:
		dead = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
