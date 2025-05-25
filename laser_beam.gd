extends Node2D

@export var damage := 30               # Урон за выстрел
@export var color := Color(1, 0, 0)   # Цвет (красный)

#///TODO: исправить траблы, сделать норм. А также с прошлого коммита тудушки чекнуть и сделать.


@onready var line := $Line2D
@onready var area := $Area2D
@onready var line_2d_remove_timer = $line2d_remove_timer

func _ready():
	line.default_color = color
	line.hide()
	
func _physics_process(delta):
	pass;

func shoot():
	line.show()
	# Мгновенный урон всем врагам на линии
	for body in area.get_overlapping_bodies():
		print("body looked");
		if body.is_in_group("Enemy") and body.has_method("damage"):
			body.damage(damage)
			print("damage enemy");
	line_2d_remove_timer.start();


func _on_line_2d_remove_timer_timeout():
	line.hide();
