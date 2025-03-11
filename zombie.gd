extends CharacterBody2D;

@onready var ray_cast_2d = $RayCast2D;
@export var move_speed = 250;
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
	
	#///TODO: щас убрать баг с положением зомби и игрока, зомби меняет положение от игрока зависит.dw
	#///TODO: добавить rotation-speed зомбарям. Разобраться с collision персов.
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		if canAttack == true:
			canAttack = false;
			$attackInt.start();
			player.damage(20);
		
	
	
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	$CollisionShape2D.queue_free();
	z_index = 1;
	dead_left.start();
	
func damage(damage):
	hp.damage(damage);
	
	


func _on_dead_left_timeout():
	queue_free();


func _on_attack_int_timeout():
	canAttack = true;
