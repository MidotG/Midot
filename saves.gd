extends Node

const save_path = "user://game_saves.json";
var currency = 0;

func _ready():
	load_game();

func _process(delta):
	pass;
	

func save_game():
	var save_data = {
		"currency": currency
	};
	var save_file = FileAccess.open(save_path, FileAccess.WRITE);
	save_file.store_string(JSON.stringify(save_data));
	save_file.close();
	
func load_game():
	var save_file = FileAccess.open(save_path, FileAccess.READ);
	if save_file:
		var save_data = JSON.parse_string(save_file.get_as_text());
		currency = save_data["currency"];
		save_file.close();
	else:
		currency = 0;
