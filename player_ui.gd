extends Control

#///TODO: здесь - патроны всего, и способности, а также время оставшееся.
#///TODO: пока - колво патронов не делать, сделать все - пушки, персонажей и способности, потом решать с патронами.
#///TODO: также во время проходения уровня добавить очки за убийство мобов, потом делать на какое колво и деньги давать от колва очков зависит, и бонус очков за прохождение или если не прошел, то просто текузие очки.

#///TODO: сделать еще показ очков заработанных.

@onready var hp = $"../../healthComponent"
@onready var hp_label = $VBoxContainer/hpLabel


func _ready():
	pass # Replace with function body.

func _process(delta):
	var cur_hp = hp.health/hp.max_health*100;
	hp_label.value = cur_hp;
	$VBoxContainer/timerLbl.text = "Время: " + '%02d:%02d' % [SaveLvl.total_time_in_m, SaveLvl.total_time_in_s];
	$pointsLbl.text = "Очки " + str(SaveLvl.points);
	pass

