extends Node

const save_path = "user://game_saves.save";
var currency : int = 0;
var hp : int = 100;
var unlocked_levels := 1;
#var weapon_scene : Array[PackedScene];
var unlocked_weapons = {
	"PISTOL": true,    
	"RIFFLE": false,
	"MINIGUN": false,
	"LASER": false,
	"DESTROYER": false,
	"NIGA": false
}
var selected_weapons = [];
func unlock_weapon(weapon_name: String):
	if unlocked_weapons.has(weapon_name):
		unlocked_weapons[weapon_name] = true;
		save_game();

func select_weapon(weapon_name: String):
	if selected_weapons.size() == 2:
		selected_weapons.remove_at(0);
	selected_weapons.insert(selected_weapons.size(), weapon_name);
	print(selected_weapons.size());
	for w in selected_weapons:
		print(w);
		#print(selected_weapons.find(w));
	save_game();

func unlock_next_level(current_level: int) -> void:
	if current_level >= unlocked_levels:
		unlocked_levels = current_level + 1;
		save_game();
		
func _ready():
	#save_game();
	load_game();


func _process(delta):
	pass;

func save_game():
	var save_data = {
		"currency": currency,
		"hp": hp,
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
		hp = save_data["hp"];
		unlocked_weapons = save_data["unlocked_weapons"];
		selected_weapons = save_data["selected_weapons"];
		save_file.close();
	else:
		currency = 0;
