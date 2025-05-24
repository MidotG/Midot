extends Node2D

#const laser_beam = preload("res://laser_beam.tscn");
@onready var laser_beam = $laser_beam;


# Called when the node enters the scene tree for the first time.
func _ready():
	print(laser_beam.damage);
	print("nigga");
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(position):
	laser_beam.shoot();
