extends Node2D

@onready var player = $Player;
const tile_size = 2048;
const chunk_size = 8;
var loaded_chunks ={};
#var map_size = Vector2(1024, 1024);
var location = Vector2();
var packed_scene =[
	preload("res://zombie.tscn")
]
var canSpawn = true;

#var time_in_s : int = 0;
#var total_time_in_m : int = 0;
#var total_time_in_s : int = 0;


func _ready():
	#///TODO: сделать проигрышь всех треков, кроме нулевого по очереди и в рандомном порядке.
	#///TODO: настроить уровень звука и пр.
	update_chunks();
	MusicPlayer.play_track(6);
	$lvlTimer.start();
	
func _process(delta):
	update_chunks();
	if canSpawn:
		$zombieSpawnTimer.start();
		canSpawn = false;


func _on_zombie_spawn_timer_timeout():
	canSpawn = true;
	randomize();
	#var rnd_index = randi() % $Collisions/CollisionPolygon2D.polygon.size();
	#location.x = $Collisions/CollisionPolygon2D.polygon[rnd_index].x;
	#location.y = $Collisions/CollisionPolygon2D.polygon[rnd_index].y;
	
	#///TODO: карту щас.
	#///TODO: потом сделать спавн рандомный за экраном игрока.
	var x = randf_range(-1500, 1500);
	var y = randf_range(-2000, 2000);
	location.x = $Player.global_position.x + x;
	location.y = $Player.global_position.y + y;
	var scene = packed_scene[0].instantiate();
	scene.connect("pointsSignal", Callable(self, "add_point"));
	scene.position = location;
	add_child(scene);
	
func _on_lvl_timer_timeout():
	SaveLvl.time_in_s += 1;
	SaveLvl.total_time_in_s = SaveLvl.time_in_s%60;
	SaveLvl.total_time_in_m = int(SaveLvl.time_in_s/60.0);
	
func add_point(point : int):
	SaveLvl.points += point;


func update_chunks():
	var pl_chunk_x = int(player.global_position.x / (chunk_size * tile_size));
	var pl_chunk_y = int(player.global_position.y / (chunk_size * tile_size));
	for x in range(pl_chunk_x - 1, pl_chunk_x + 2):
		for y in range(pl_chunk_y - 1, pl_chunk_y + 2):
			if not is_chunk_loaded(x, y):
				load_chunk(x, y);
	for chunk_coords in loaded_chunks.keys():
		var chunk_x = chunk_coords.x;
		var chunk_y = chunk_coords.y;
		if abs(chunk_x - pl_chunk_x) > 1 or abs(chunk_y - pl_chunk_y) > 1:
			unload_chunk(chunk_x, chunk_y);
	
func is_chunk_loaded(x, y):
	return Vector2(x, y) in loaded_chunks;
	
func load_chunk(x, y):
	for i in range(chunk_size):
		for j in range(chunk_size):
			var world_x = x * chunk_size + i;
			var world_y = y * chunk_size + j;
			$Environment/FloorTileMap.set_cell(0, Vector2i(world_x, world_y), 1,  Vector2i(0, 0));
	loaded_chunks[Vector2(x, y)] = true;

func unload_chunk(x, y):
	for i in range(chunk_size):
		for j in range(chunk_size):
			var world_x = x * chunk_size + i;
			var world_y = y * chunk_size + j;
			$Environment/FloorTileMap.set_cell(0, Vector2(world_x, world_y), -1);
	loaded_chunks.erase(Vector2(x, y));
