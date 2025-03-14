class_name Lvl
extends Node

#///TODO: разобраться сделать композицию или наследование для уровней.

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player();
	spawn_enemies();

func spawn_player():
	pass;
	
func spawn_enemies():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
