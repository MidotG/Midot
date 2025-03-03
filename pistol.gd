extends Node2D

@export var shoot_speed = 1.0;
@onready var ray_cast_2d = $RayCast2D;
@onready var shootSpeedTimer = $shootSpeedTimer;

const bullet = preload("res://pistol_bullet.tscn");
var canShoot = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot(position):
	#///TODO: сделать оружия как отдельные сцены(сразу вместе с пулями в них), и сделать группу противников.
	#if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method("kill"):
		#ray_cast_2d.get_collider().kill();
	if canShoot == true:
		canShoot = false;
		shootSpeedTimer.start();
		$MuzzleFlash.show();
		$MuzzleFlash/Timer.start();
		var bul = bullet.instantiate();
		bul.dir = (position - get_global_mouse_position()).normalized();
		get_tree().root.add_child(bul);
		bul.rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position + bul.dir));
		bul.position = position;

func _on_shoot_speed_timer_timeout():
	canShoot = true;
