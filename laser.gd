extends Node2D

@onready var ray_cast_2d = $RayCast2D;
@onready var line_2d = $Line2D;


# Called when the node enters the scene tree for the first time.
func _ready():
	line_2d.hide();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func shoot(position):
	line_2d.show();

