extends CharacterBody2D;

signal pointsSignal(point : int);

@export var pointsForKill : int = 10;
@export var const_move_speed : int = 250;
var move_speed = const_move_speed;
@export var attack_damage : int = 20;
@onready var ray_cast_2d = $RayCast2D;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player");
@onready var dead_left = $deadLeft;
@onready var hp = $healthComponent;

var canAttack = true;


func _ready():
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	pass;

func _physics_process(delta):
	if hp.dead:
		return;
	var dir_to_player = global_position.direction_to(player.global_position);
	velocity = dir_to_player * move_speed;
	move_and_slide();
	global_rotation = dir_to_player.angle() + PI/2.0;
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		move_speed = 0;
		if canAttack == true:
			canAttack = false;
			$attackInt.start();
			player.damage(attack_damage);
	else:
		move_speed = const_move_speed;
		
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	set_physics_process(false);
	$CollisionShape2D.set_deferred("disabled", true);
	z_index = 1;
	pointsSignal.emit(pointsForKill);
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);
	teleport_near_player(player.global_position, 500);
	
func _on_dead_left_timeout():
	queue_free();

func _on_attack_int_timeout():
	canAttack = true;
	
func teleport_near_player(player_position: Vector2, distance: float = 100.0) -> void:
	# 1. Выбираем случайный угол (0-360 градусов)
	var random_angle = randf_range(0, 2 * PI)
	
	# 2. Вычисляем новую позицию
	var offset = Vector2(cos(random_angle), sin(random_angle)) * distance
	global_position = player_position + offset
	
	# 3. Гарантируем, что не телепортируемся внутрь стены (опционально)
	if has_method("move_and_collide"):
		var collision = move_and_collide(Vector2.ZERO)
		if collision:
			# Если телепорт в стену - пробуем снова
			teleport_near_player(player_position, distance)	

