extends Control



#///TODO: сделать уровни. 
#///И сделать цену, урон балансную всем оружиям, и параметры всем врагам тоже сбалансить.

#/// музыку сделать повторяющейся, а то когда заканчивается в уровне, то перестает играть.

#// доделать сложность 8 уровня и остальные тоже, потом добавить звуки и звуки спецэффектов.


#///TODO: потом сделать тектуры и анимации везде нормальные.


@onready var label_2 = $shopPanel/choicePanel/weaponInfo/Label2;
@onready var label_5 = $shopPanel/choicePanel/weaponInfo/Label5;
@onready var label_6 = $shopPanel/choicePanel/weaponInfo/Label6;
@onready var label_7 = $shopPanel/choicePanel/weaponInfo/Label7;
@onready var label_8 = $shopPanel/choicePanel/weaponInfo/Label8;
@onready var label_9 = $shopPanel/choicePanel/weaponInfo/Label9;
@onready var buy_btn = $shopPanel/choicePanel/weaponInfo/buyBtn;
@onready var choose_btn = $shopPanel/choicePanel/chooseBtn;
@onready var inv_1 = $shopPanel/choicePanel/weaponInfo/HBoxContainer/inv1;
@onready var inv_2 = $shopPanel/choicePanel/weaponInfo/HBoxContainer/inv2;
@onready var wrng_label = $shopPanel/choicePanel/VBoxContainer/wrngLabel;
@onready var hp_label = $shopPanel/choicePanel/VBoxContainer/hpLabel;
@onready var hp_price_label = $shopPanel/choicePanel/VBoxContainer/hpPriceLabel;


func _ready():
	inv();
	$shopPanel/balanceLabel.text += str(Saves.currency);
	wrng_label.visible = false;
	
func _process(delta):
	$shopPanel/balanceLabel.text = "Баланс: " + str(Saves.currency);
	hp_label.text = "Здоровье игрока: " + str(Saves.hp);
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://menu.tscn");

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");


func _on_riffle_btn_pressed():
	label_2.text = "Оружие: Автомат";
	label_5.text = "Урон: 100ур/сек.";
	label_6.text = "Цена: 100";
	label_7.visible = false;
	label_8.visible = false;
	label_9.visible = false;
	if Saves.unlocked_weapons["RIFFLE"]:
		buy_btn.disabled = true;
	else:
		buy_btn.disabled = false;
	if !Saves.unlocked_weapons["RIFFLE"]:
		for con in buy_btn.pressed.get_connections():
			buy_btn.pressed.disconnect(con.callable);
		buy_btn.pressed.connect(riffle_buy_button);
	for con in choose_btn.pressed.get_connections():
		choose_btn.pressed.disconnect(con.callable);
	choose_btn.pressed.connect(_on_choose_btn_pressed.bind("RIFFLE"));

func _on_minigun_btn_pressed():
	label_2.text = "Оружие: Пулемет";
	label_5.text = "Урон: 200ур/сек.";
	label_6.text = "Цена: 500";
	label_7.visible = false;
	label_8.visible = false;
	label_9.visible = false;
	if Saves.unlocked_weapons["MINIGUN"]:
		buy_btn.disabled = true;
	else:
		buy_btn.disabled = false;
	if !Saves.unlocked_weapons["MINIGUN"]:
		for con in buy_btn.pressed.get_connections():
			buy_btn.pressed.disconnect(con.callable);
		buy_btn.pressed.connect(minigun_buy_button);
	for con in choose_btn.pressed.get_connections():
		choose_btn.pressed.disconnect(con.callable);
	choose_btn.pressed.connect(_on_choose_btn_pressed.bind("MINIGUN"));


func _on_laser_btn_pressed():
	label_2.text = "Оружие: Лазер";
	label_5.text = "Урон: 100ур/c.";
	label_6.text = "Цена: 1200";
	label_7.visible = false;
	label_8.visible = false;
	label_9.visible = false;
	if Saves.unlocked_weapons["LASER"]:
		buy_btn.disabled = true;
	else:
		buy_btn.disabled = false;
	if !Saves.unlocked_weapons["LASER"]:
		for con in buy_btn.pressed.get_connections():
			buy_btn.pressed.disconnect(con.callable);
		buy_btn.pressed.connect(laser_buy_button);
	for con in choose_btn.pressed.get_connections():
		choose_btn.pressed.disconnect(con.callable);
	choose_btn.pressed.connect(_on_choose_btn_pressed.bind("LASER"));

func _on_destroyer_btn_pressed():
	label_2.text = "Оружие: Уничтожитель";
	label_5.text = "Урон: 450ур/сек.";
	label_6.text = "Цена: 3500";
	label_7.visible = false;
	label_8.visible = false;
	label_9.visible = false;
	if Saves.unlocked_weapons["DESTROYER"]:
		buy_btn.disabled = true;
	else:
		buy_btn.disabled = false;
	if !Saves.unlocked_weapons["DESTROYER"]:
		for con in buy_btn.pressed.get_connections():
			buy_btn.pressed.disconnect(con.callable);
		buy_btn.pressed.connect(destroyer_buy_button);
	for con in choose_btn.pressed.get_connections():
		choose_btn.pressed.disconnect(con.callable);
	choose_btn.pressed.connect(_on_choose_btn_pressed.bind("DESTROYER"));
	
func riffle_buy_button():
	if Saves.currency < 100:
		label_7.visible = true;
		return;
	buy_btn.disabled = true;
	Saves.currency -= 100;
	Saves.unlock_weapon("RIFFLE");
	label_7.visible = false;

func minigun_buy_button():
	if Saves.currency < 500:
		label_7.visible = true;
		return;
	buy_btn.disabled = true;
	Saves.currency -= 500;
	Saves.unlock_weapon("MINIGUN");
	label_7.visible = false;
	
func laser_buy_button():
	if Saves.currency < 1200:
		label_7.visible = true;
		return;
	buy_btn.disabled = true;
	Saves.currency -= 1200;
	Saves.unlock_weapon("LASER");
	label_7.visible = false;
	
func destroyer_buy_button():
	if Saves.currency < 3500:
		label_7.visible = true;
		return;
	buy_btn.disabled = true;
	Saves.currency -= 3500;
	Saves.unlock_weapon("DESTROYER");
	label_7.visible = false;

func _on_choose_btn_pressed(weapon_name: String):
	if Saves.unlocked_weapons[weapon_name] == null || Saves.unlocked_weapons[weapon_name] == false:
		label_8.visible = true;
		return;
	if Saves.selected_weapons.size() > 0 && Saves.selected_weapons.find(weapon_name) != -1:
		label_9.visible = true;
		return;
	Saves.select_weapon(weapon_name);
	label_8.visible = false;
	label_9.visible = false;
	Saves.save_game();
	inv();

func inv():
	if Saves.selected_weapons.size() == 0:
		return;
	if Saves.selected_weapons.size() == 1:
		inv_1.text = Saves.selected_weapons[0];
	else:
		inv_1.text = Saves.selected_weapons[0];
		inv_2.text = Saves.selected_weapons[1];


func _on_hp_btn_pressed():
	if Saves.currency < 100:
		wrng_label.visible = true;
		return;
	Saves.currency -= 100;
	Saves.hp += 10;
	Saves.save_game();
	wrng_label.visible = false;
	
