extends Node2D

@onready var ray_cast_2d= $RayCast2D;
const bullet = preload("res://pistol_bullet.tscn");


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	$MuzzleFlash.show();
	$MuzzleFlash/Timer.start();
	if ray_cast_2d.is_colliding() and ray_cast_2d.gaet_collider().has_method("kill"):
		ray_cast_2d.get_collider().kill();
		#///TODO: сделать оружия как отдельные сцены(сразу вместе с пулями в них), и сделать группу противников.
		
	#var bul = bullet.instantiate();
	#bul.set_direction(Vector2(1,0));
	#get_tree().root.add_child(bul);
	#bul.global_position = get_global_mouse_position();
