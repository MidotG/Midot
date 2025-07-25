extends CharacterBody2D;


#///TODO: спавн камикадзе зомби вокруг него.

signal pointsSignal(point : int);

@export var pointsForKill : int = 10;
@export var const_move_speed : int = 250;
var move_speed = const_move_speed;
@onready var ray_cast_2d = $RayCast2D;
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player");
@onready var dead_left = $deadLeft;
@onready var hp = $healthComponent;
@onready var hp_bar = $hpBar;
var kamikadze_zombie = preload("res://kamikadze_zombie.tscn");
@export var spawn_radius: float = 50.0;
@onready var spawn_timer = $spawnTimer;
var canSpawn: bool = true;


func _ready():
	z_index = 1;
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	hp_bar.value = hp.max_health;
	hp_bar.visible = false;
	pass;

func _physics_process(delta):
	if hp.dead:
		return;
	else:
		hp_bar.global_position = global_position + Vector2(-60, 90);
		hp_bar.rotation = -rotation;
	var dir_to_player = global_position.direction_to(player.global_position);
	velocity = dir_to_player * move_speed;
	move_and_slide();
	global_rotation = dir_to_player.angle() + PI/2.0;
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		move_speed = 0;
		if canSpawn:
			$Graphics/Alive.play("attack");
			canSpawn = false;
			$attackSound.play();
			spawn_timer.start();
			var spawn_position = global_position + Vector2(
			randf_range(-spawn_radius, spawn_radius),
			randf_range(-spawn_radius, spawn_radius));
			var kamikadze = kamikadze_zombie.instantiate();
			get_parent().add_child(kamikadze);
			kamikadze.global_position = spawn_position;
	else:
		move_speed = const_move_speed;
		$Graphics/Alive.play("move");
		
func kill():
	$deathSound.play();
	hp_bar.queue_free();
	$Graphics/Alive.play("death");
	set_physics_process(false);
	$CollisionShape2D.set_deferred("disabled", true);
	z_index = 0;
	pointsSignal.emit(pointsForKill);
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);
	update_hp_label();
	hp_bar.visible = true;
	
func _on_dead_left_timeout():
	queue_free();


func update_hp_label():
	var cur_hp = hp.health/hp.max_health*100;
	hp_bar.value = cur_hp;


func _on_spawn_timer_timeout():
	canSpawn = true;
