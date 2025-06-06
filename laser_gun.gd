extends Node2D

@onready var laser_beam = $laser_beam;

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(position):
	SfxPlayer.play_sound(3);
	laser_beam.shoot();
