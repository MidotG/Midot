extends Node2D

@export var enemy : Array[PackedScene]= [];
@export var spawn_weights : Array[int] = [85, 15];
@onready var enemy_spawnpoints = $EnemySpawnpoints;
@onready var enemy_spawn_timer = $EnemySpawnTimer;
@onready var lvl_timer = $LvlTimer;
@onready var player = $Player;
var spawn_positions = [];
var canSpawn = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_spawn_positions_from_tilemap();
	MusicPlayer.play_track(2);
	lvl_timer.start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canSpawn:
		enemy_spawn_timer.start();
		canSpawn = false;
	
func get_spawn_positions_from_tilemap():
	var cells = enemy_spawnpoints.get_used_cells(0);  # 0 — слой
	for cell in cells:
		spawn_positions.append(enemy_spawnpoints.map_to_local(cell));
		
func _on_enemy_spawn_timer_timeout():
	canSpawn = true;
	randomize();
	var rnd_index = randi() % spawn_positions.size();
	#var rnd_enemy_index = randi() % enemy.size();
	var rnd_enemy_index = weighted_random(spawn_weights);
	var scene = enemy[rnd_enemy_index].instantiate();
	scene.connect("pointsSignal", Callable(self, "add_point"));
	scene.position = spawn_positions[rnd_index];
	add_child(scene);

func _on_lvl_timer_timeout():
	if SaveLvl.time_in_s == 90:
		player.lvl_pass();
		Saves.unlock_next_level(2);
	SaveLvl.time_in_s += 1;
	SaveLvl.total_time_in_s = SaveLvl.time_in_s%60;
	SaveLvl.total_time_in_m = int(SaveLvl.time_in_s/60.0);
	
func add_point(point : int):
	SaveLvl.points += point;

#///TODO: разобраться как работает, а то такое ощущение что волнами выпускает.
func weighted_random(weights: Array[int]):
	var total_weight = 0
	for weight in weights:
		total_weight += weight
	var random_value = randi() % total_weight
	var cumulative_weight = 0
	for i in weights.size():
		cumulative_weight += weights[i]
		if random_value < cumulative_weight:
			return i
	return 0;

