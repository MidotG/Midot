extends Node2D

@onready var player = $Player;
const tile_size = 2048;
const chunk_size = 4;
var loaded_chunks ={};
var generated_obstacles = {};

var location = Vector2();
var packed_scene =[
	preload("res://zombie.tscn")
]
var canSpawn = true;

#var time_in_s : int = 0;
#var total_time_in_m : int = 0;
#var total_time_in_s : int = 0;


#///TODO: генерацию препятствий.

func _ready():
	#///TODO: сделать проигрышь всех треков, кроме нулевого по очереди и в рандомном порядке.
	#///TODO: настроить уровень звука и пр.
	var spawn_chunk_x = floor(player.global_position.x / (chunk_size * tile_size));
	var spawn_chunk_y = floor(player.global_position.y / (chunk_size * tile_size));
	generate_obstacles(spawn_chunk_x, spawn_chunk_y);
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
	var pl_chunk_x = floor(player.global_position.x / (chunk_size * tile_size));
	var pl_chunk_y = floor(player.global_position.y / (chunk_size * tile_size));
	
	# Загрузка и генерация чанков
	for x in range(pl_chunk_x - 2, pl_chunk_x + 3):  # Увеличил радиус загрузки чанков
		for y in range(pl_chunk_y - 2, pl_chunk_y + 3):
			if not is_chunk_loaded(x, y):
				load_chunk(x, y);
				generate_obstacles(x, y);  # Генерация препятствий для нового чанка
	
	# Выгрузка чанков
	for chunk_coords in loaded_chunks.keys():
		var chunk_x = chunk_coords.x;
		var chunk_y = chunk_coords.y;
		if abs(chunk_x - pl_chunk_x) > 2 or abs(chunk_y - pl_chunk_y) > 2:  # Увеличил радиус выгрузки
			unload_chunk(chunk_x, chunk_y);

func is_chunk_loaded(x, y):
	return Vector2(x, y) in loaded_chunks;

func load_chunk(x, y):
	for i in range(chunk_size):
		for j in range(chunk_size):
			var world_x = x * chunk_size + i;
			var world_y = y * chunk_size + j;
			$Environment/FloorTileMap.set_cell(0, Vector2i(world_x, world_y), 1, Vector2i(0, 0));
	loaded_chunks[Vector2(x, y)] = true;

func unload_chunk(x, y):
	for i in range(chunk_size):
		for j in range(chunk_size):
			var world_x = x * chunk_size + i;
			var world_y = y * chunk_size + j;
			$Environment/FloorTileMap.set_cell(0, Vector2(world_x, world_y), -1);
	loaded_chunks.erase(Vector2(x, y));

func generate_obstacles(x, y):
	if Vector2(x, y) in generated_obstacles:
		return;  # Препятствия уже сгенерированы для этого чанка
	
	var obstacles = [];
	var camera = player.get_node("Camera2D");  # Получаем камеру игрока
	var camera_rect = camera.get_viewport_rect();  # Получаем прямоугольник видимости камеры
	
	# Переводим прямоугольник видимости в глобальные координаты
	var camera_global_pos = camera.global_position;
	var visible_left = camera_global_pos.x - camera_rect.size.x / 2;
	var visible_right = camera_global_pos.x + camera_rect.size.x / 2;
	var visible_top = camera_global_pos.y - camera_rect.size.y / 2;
	var visible_bottom = camera_global_pos.y + camera_rect.size.y / 2;
	
	# Максимальное количество препятствий на чанк (1/5 от площади чанка)
	var max_obstacles = int((chunk_size * chunk_size) / 5);
	var obstacle_count = 0;
	
	# Генерация препятствий
	while obstacle_count < max_obstacles:
		var i = randi() % chunk_size;  # Случайная координата X в пределах чанка
		var j = randi() % chunk_size;  # Случайная координата Y в пределах чанка
		var world_x = x * chunk_size + i;
		var world_y = y * chunk_size + j;
		
		# Переводим координаты тайлов в пиксели
		var tile_pixel_x = world_x * tile_size + tile_size / 2;  # Центр тайла
		var tile_pixel_y = world_y * tile_size + tile_size / 2;  # Центр тайла
		
		# Проверка, чтобы препятствия не спавнились в зоне видимости камеры
		if (tile_pixel_x < visible_left or tile_pixel_x > visible_right or
			tile_pixel_y < visible_top or tile_pixel_y > visible_bottom):
			# Проверяем, что на этой позиции ещё нет препятствия
			if $Environment/ObstacleTileMap.get_cell_source_id(0, Vector2i(world_x, world_y)) == -1:
				$Environment/ObstacleTileMap.set_cell(0, Vector2i(world_x, world_y), 1, Vector2i(0, 0));
				obstacles.append(Vector2i(world_x, world_y));
				obstacle_count += 1;
	
	# Сохраняем сгенерированные препятствия
	generated_obstacles[Vector2(x, y)] = obstacles;
