extends Control

#///TODO: здесь - патроны всего, и способности, а также время оставшееся.
#///TODO: пока - колво патронов не делать, сделать все - пушки, персонажей и способности, потом решать с патронами.
#///TODO: также во время проходения уровня добавить очки за убийство мобов, потом делать на какое колво и деньги давать от колва очков зависит, и бонус очков за прохождение или если не прошел, то просто текузие очки.

#///TODO: сделать еще показ очков заработанных.

@onready var hp = $"../../healthComponent"
@onready var hp_label = $VBoxContainer/hpLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cur_hp = hp.health/hp.max_health*100;
	hp_label.value = cur_hp;
	$pointsLbl.text = "Очки " + str(Saves.points);
	pass

func show_time(time):
	$VBoxContainer/timerLbl.text = "Время: " + time;
	
#func show_points(points):
	#$pointsLbl.text = "Очки " + str(Saves.points);
