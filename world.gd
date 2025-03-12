extends Node2D

#///TODO: рандомный спавн зомби сделать.
var map_size = Vector2(1024, 1024);
var location = Vector2();
var packed_scene =[
	preload("res://zombie.tscn")
]
var canSpawn = true;


func _ready():
	MusicPlayer.play_track(2);
	
func _process(delta):
	if canSpawn:
		$zombieSpawnTimer.start();
		canSpawn = false;


func _on_zombie_spawn_timer_timeout():
	canSpawn = true;
	randomize();
	location.x = randi_range(-1024, map_size.x);
	location.y = randi_range(-1024, map_size.y);
	var scene = packed_scene[0].instantiate();
	scene.position = location;
	add_child(scene);
