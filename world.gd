extends Node2D

var map_size = Vector2(1024, 1024);
var location = Vector2();
var packed_scene =[
	preload("res://zombie.tscn")
]

var canSpawn = true;

func _ready():
	MusicPlayer.play_track(2);
	$lvlTimer.start();
	
func _process(delta):
	if canSpawn:
		$zombieSpawnTimer.start();
		canSpawn = false;


func _on_zombie_spawn_timer_timeout():
	canSpawn = true;
	randomize();
	var rnd_index = randi() % $Collisions/CollisionPolygon2D.polygon.size();
	location.x = $Collisions/CollisionPolygon2D.polygon[rnd_index].x;
	location.y = $Collisions/CollisionPolygon2D.polygon[rnd_index].y;
	var scene = packed_scene[0].instantiate();
	scene.position = location;
	add_child(scene);
	
#///TODO: разобраться сделать композицию или наследование для уровней.
func _on_lvl_timer_timeout():
	$lvlPassCanvas/lvl_passed.lvlPass();
