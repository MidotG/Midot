extends Node2D

@onready var player = $Player;
@onready var zombie_spawn_timer = $zombieSpawnTimer;
@onready var collision_borders = $StaticBody2D/CollisionPolygon2D;

var packed_scene =[
	preload("res://zombie.tscn")
]
var canSpawn = true;

func _ready():
	MusicPlayer.play_track(1);
	$lvlTimer.start()
	
func _process(delta):
	if canSpawn:
		$zombieSpawnTimer.start();
		canSpawn = false;

func _on_zombie_spawn_timer_timeout():
	canSpawn = true;
	randomize();
	var rnd_index = randi() % collision_borders.polygon.size();
	var location = Vector2i();
	location.x = collision_borders.polygon[rnd_index].x;
	location.y = collision_borders.polygon[rnd_index].y;
	
	var scene = packed_scene[0].instantiate();
	scene.connect("pointsSignal", Callable(self, "add_point"));
	scene.position = location;
	add_child(scene);
	
func _on_lvl_timer_timeout():
	if SaveLvl.time_in_s == 90:
		player.lvl_pass(1);
		Saves.unlock_next_level(1);
	SaveLvl.time_in_s += 1;
	SaveLvl.total_time_in_s = SaveLvl.time_in_s%60;
	SaveLvl.total_time_in_m = int(SaveLvl.time_in_s/60.0);
	
func add_point(point : int):
	SaveLvl.points += point;
