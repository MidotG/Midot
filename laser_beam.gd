extends RayCast2D

@export var laser_width = 10;
@export var damage = 10;
@onready var laser_beam = $".";
@onready var laser_line_lifetime = $laser_line_lifetime;
@onready var line_2d = $Line2D;

#///TODO: для каждого лазера разные параметры ширины выстрела и урона.
#///TODO: сделать взаимодействие с противником при использовании, показ текстуры лазера во время использования, убирание текстуры его, после использования.
#///TODO: направление лазера выбирается оружием.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;


func _on_laser_line_lifetime_timeout():
	line_2d.hide();
