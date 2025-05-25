extends RayCast2D

@export var laser_width = 4;
@export var damage = 10;
@onready var laser_beam = $".";  #//raycast2d
@onready var laser_line_lifetime = $laser_line_lifetime;
@onready var line_2d = $Line2D;
@onready var area_2d = $Area2D;
@onready var collision_shape_2d = $Area2D/CollisionShape2D;

#///TODO: сделать взаимодействие с противником при использовании, показ текстуры лазера во время использования, убирание текстуры его, после использования.
#///TODO: направление лазера выбирается оружием.

# Called when the node enters the scene tree for the first time.
func _ready():
	laser_beam.scale.y = laser_width;
	line_2d.hide();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func shoot():
	line_2d.show();
	#///TODO: сделть чтобы всех противников на линии одновременно убивал, а не первого потом второго, потом третьего и т.д.
	#///TODO: и сделать урон с небольшой задержкой, а то он может за секунду не 20 как положено например, а 1000 нанести, если не контролить.
	#///TODO: при взаимодействии со стеной дальше не продвигался.
	
	#///TODO: сделать слои для каждого обьекта.
	#///TODO: raycast2d, area2d, сделать чтобы длина одинаковая везде была(похуй, у area2d ограничить просто длину дальше, если raycast2d уперся в стену).
	if laser_beam.is_colliding():
		var target = laser_beam.get_collider();
		#print("detected someone");
		if target.is_in_group("Enemy"):
			#print("zombie!");
			target.damage(damage);
		#else:
			#print(target.get_groups());
	laser_line_lifetime.start();

func _on_laser_line_lifetime_timeout():
	line_2d.hide();
	#queue_free();
