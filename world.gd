extends Node2D

var map_size = Vector2(1024, 1024);
var location = Vector2();
var packed_scene =[
	preload("res://zombie.tscn")
]
var canSpawn = true;
var time_in_s : int = 0;
var total_time_in_m : int = 0;
var total_time_in_s : int = 0;


func _ready():
	#///TODO: сделать проигрышь всех треков, кроме нулевого по очереди и в рандомном порядке.
	#///TODO: настроить уровень звука и пр.
	MusicPlayer.play_track(6);
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
	scene.connect("pointsSignal", Callable(self, "add_point"));
	scene.position = location;
	add_child(scene);
	
func _on_lvl_timer_timeout():
	time_in_s += 1;
	total_time_in_s = time_in_s%60;
	total_time_in_m = int(time_in_s/60.0);
	$Player/uiCanvas/PlayerUI.show_time('%02d:%02d' % [total_time_in_m, total_time_in_s]);
	
func add_point(point : int):
	Saves.points += point;
	
