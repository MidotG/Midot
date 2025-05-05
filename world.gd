extends Node2D

@onready var player = $Player;
@onready var zombie_spawn_timer = $zombieSpawnTimer;
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D;

@onready var zombie_scene = preload("res://zombie.tscn");

func _ready():
	$lvlTimer.start()
	zombie_spawn_timer.timeout.connect(_spawn_zombie_inside_polygon);

func _process(delta):
	pass;

func _spawn_zombie_inside_polygon():
	var polygon = collision_polygon_2d.polygon
	if polygon.size() < 3:
		return  # Нельзя спавнить, если полигон не задан
	
	# 1. Находим ограничивающий прямоугольник (AABB) полигона
	var bounds = _calculate_polygon_bounds(polygon)
	
	var attempts = 0
	var max_attempts = 50  # Максимум попыток на поиск точки
	
	while attempts < max_attempts:
		attempts += 1
		
		# 2. Генерируем случайную точку внутри AABB
		var random_point = Vector2(
			randf_range(bounds.position.x, bounds.end.x),
			randf_range(bounds.position.y, bounds.end.y)
		)
		
		# 3. Проверяем, лежит ли точка внутри полигона
		if Geometry2D.is_point_in_polygon(random_point, polygon):
			# 4. Создаём зомби
			var zombie = zombie_scene.instantiate()
			zombie.position = random_point
			add_child(zombie)
			break  # Выходим, если заспавнили

func _calculate_polygon_bounds(polygon: PackedVector2Array) -> Rect2:
	var min_point = polygon[0]
	var max_point = polygon[0]
	
	for point in polygon:
		min_point = Vector2(min(min_point.x, point.x), min(min_point.y, point.y))
		max_point = Vector2(max(max_point.x, point.x), max(max_point.y, point.y))
	
	return Rect2(min_point, max_point - min_point)
