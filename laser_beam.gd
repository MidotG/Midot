extends Node2D

@export var damage := 5               # Урон за выстрел
@export var color := Color(1, 0, 0)   # Цвет (красный)
@export var damage_interval := 1.0    # Интервал между ударами по одному врагу

@onready var line := $Line2D
@onready var area := $Area2D
@onready var line_2d_remove_timer = $line2d_remove_timer

var enemy_cooldowns := {}  # Словарь для хранения таймеров врагов

func _ready():
	line.default_color = color
	line.hide()

func shoot():
	line.show()
	
	for body in area.get_overlapping_bodies():
		if body.is_in_group("Enemy") and body.has_method("damage"):
			var enemy_id : int = body.get_instance_id()
			
			# Если враг уже в кд - пропускаем
			if enemy_id in enemy_cooldowns:
				continue
				
			# Наносим урон
			body.damage(damage)
			
			# Добавляем врага в кд
			enemy_cooldowns[enemy_id] = true
			
			# Создаем таймер для сброса кд этого врага
			var timer := get_tree().create_timer(damage_interval)
			timer.timeout.connect(_remove_enemy_cooldown.bind(enemy_id))
	
	line_2d_remove_timer.start()

func _remove_enemy_cooldown(enemy_id):
	enemy_cooldowns.erase(enemy_id)

func _on_line_2d_remove_timer_timeout():
	line.hide()
