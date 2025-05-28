extends Node2D

@onready var player = $Player;
@onready var zombie_spawn_timer = $zombieSpawnTimer;
@onready var collision_borders = $StaticBody2D/CollisionPolygon2D;

var packed_scene =[
	#preload("res://zombie.tscn"),
	#preload("res://fast_zombie.tscn"),
	#preload("res://tank_zombie.tscn"),
	#preload("res://kamikadze_zombie.tscn"),
	#preload('res://range_zombie.tscn'),
	#preload("res://invisible_zombie.tscn"),
	#preload("res://tp_zombie.tscn"),
	#preload("res://slower_zombie.tscn")
	preload("res://first_boss.tscn")
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
	
	#var scene = packed_scene[0].instantiate();
	#scene.connect("pointsSignal", Callable(self, "add_point"));
	#scene.position = location;
	#add_child(scene);
	#var scene2 = packed_scene[1].instantiate();
	#scene2.connect("pointsSignal", Callable(self, "add_point"));
	#scene2.position = location;
	#add_child(scene2);
	#var scene3 = packed_scene[2].instantiate();
	#scene3.connect("pointsSignal", Callable(self, "add_point"));
	#scene3.position = location;
	#add_child(scene3);
	#var scene4 = packed_scene[3].instantiate();
	#scene4.connect("pointsSignal", Callable(self, "add_point"));
	#scene4.position = location;
	#add_child(scene4);
	#var scene5 = packed_scene[4].instantiate();
	#scene5.connect("pointsSignal", Callable(self, "add_point"));
	#scene5.position = location;
	#add_child(scene5);
	#var scene6 = packed_scene[5].instantiate();
	#scene6.connect("pointsSignal", Callable(self, "add_point"));
	#scene6.position = location;
	#add_child(scene6);
	#var scene7 = packed_scene[6].instantiate();
	#scene7.connect("pointsSignal", Callable(self, "add_point"));
	#scene7.position = location;
	#add_child(scene7);
	#var scene8 = packed_scene[7].instantiate();
	#scene8.connect("pointsSignal", Callable(self, "add_point"));
	#scene8.position = location;
	#add_child(scene8);
	
	var scene = packed_scene[0].instantiate();
	scene.connect("pointsSignal", Callable(self, "add_point"));
	scene.position = location;
	add_child(scene);
	
func _on_lvl_timer_timeout():
	if SaveLvl.time_in_s == 60:
		player.lvl_pass();
	SaveLvl.time_in_s += 1;
	SaveLvl.total_time_in_s = SaveLvl.time_in_s%60;
	SaveLvl.total_time_in_m = int(SaveLvl.time_in_s/60.0);
	
func add_point(point : int):
	SaveLvl.points += point;
