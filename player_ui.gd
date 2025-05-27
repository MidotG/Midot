extends Control


@onready var hp = $"../../healthComponent"
@onready var hp_label = $VBoxContainer/hpLabel
@onready var w_1 = $HBoxContainer/w1;
@onready var w_2 = $HBoxContainer/w2;


func _ready():
	inv();
	pass # Replace with function body.

func _process(delta):
	var cur_hp = hp.health/hp.max_health*100;
	hp_label.value = cur_hp;
	$VBoxContainer/timerLbl.text = "Время: " + '%02d:%02d' % [SaveLvl.total_time_in_m, SaveLvl.total_time_in_s];
	$pointsLbl.text = "Очки " + str(SaveLvl.points);
	pass
	
func inv():
	if Saves.selected_weapons.size() == 0:
		return;
	if Saves.selected_weapons.size() == 1:
		w_1.text = Saves.selected_weapons[0];
	else:
		w_1.text = Saves.selected_weapons[0];
		w_2.text = Saves.selected_weapons[1];
