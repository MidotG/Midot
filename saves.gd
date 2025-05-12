extends Node

const save_path = "user://game_saves.save";
var currency : int = 200;
#var weapon_scene : Array[PackedScene];
var unlocked_weapons = {
	"PISTOL": true,    
	"RIFFLE": false,
	"MINIGUN": false
}
var selected_weapons = [];
func unlock_weapon(weapon_name: String):
	if unlocked_weapons.has(weapon_name):
		unlocked_weapons[weapon_name] = true;
		save_game();


func _ready():
	save_game();
	load_game();


func _process(delta):
	pass;

func save_game():
	var save_data = {
		"currency": currency,
		"unlocked_weapons": unlocked_weapons,
		"selected_weapons": selected_weapons
	};
	var save_file = FileAccess.open(save_path, FileAccess.WRITE);
	save_file.store_var(save_data);
	save_file.close();
	
func load_game():
	var save_file = FileAccess.open(save_path, FileAccess.READ);
	if save_file:
		var save_data = save_file.get_var();
		currency = save_data["currency"];
		unlocked_weapons = save_data["unlocked_weapons"];
		selected_weapons = save_data["selected_weapons"];
		save_file.close();
	else:
		currency = 0;
