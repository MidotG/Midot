extends Node2D

@onready var laser_beam = $laser_beam;
@onready var shoot_speed_timer = $shootSpeedTimer;
var canShoot = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	canShoot = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(position):
	if canShoot:
		laser_beam.shoot();
		canShoot = false;
		shoot_speed_timer.start();

func _on_shoot_speed_timer_timeout():
	canShoot = true;
	
	
