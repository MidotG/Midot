extends Control

#///TODO: щас сделать 2 персов и по 2 оружия(1 пестик, 2 спец. оружие), и потом добавить в магаз, и сохранять выбор, и в уровни заходить с ним.
#///TODO: потом сделать в магазе 2ого неоткрытым по дефолту, возможность его купить, и сохранение куплен/некуплен.

@onready var label_2 = $shopPanel/choicePanel/weaponInfo/Label2;
@onready var label_5 = $shopPanel/choicePanel/weaponInfo/Label5;
@onready var label_6 = $shopPanel/choicePanel/weaponInfo/Label6;
@onready var label_7 = $shopPanel/choicePanel/weaponInfo/Label7;
@onready var buy_btn = $shopPanel/choicePanel/weaponInfo/buyBtn;
@onready var choose_btn = $shopPanel/choicePanel/chooseBtn;


# Called when the node enters the scene tree for the first time.
func _ready():
	$shopPanel/balanceLabel.text += str(Saves.currency);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$shopPanel/balanceLabel.text = "Баланс: " + str(Saves.currency);
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://menu.tscn");

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn");


func _on_riffle_btn_pressed():
	label_2.text = "Оружие: Автомат";
	label_5.text = "Урон: 10ур/выстр.";
	label_6.text = "Цена: 50";
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
	label_5.text = "Урон: 10ур/выстр.";
	label_6.text = "Цена: 200";
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

func riffle_buy_button():
	if Saves.currency < 50:
		label_7.visible = true;
		return;
	buy_btn.disabled = true;
	Saves.currency -= 50;
	Saves.unlock_weapon("RIFFLE");
	label_7.visible = false;

func minigun_buy_button():
	if Saves.currency < 200:
		label_7.visible = true;
		return;
	buy_btn.disabled = true;
	Saves.currency -= 200;
	Saves.unlock_weapon("MINIGUN");
	label_7.visible = false;

func _on_choose_btn_pressed(weapon_name: String):
	if !Saves.unlocked_weapons[weapon_name]:
		pass;
	Saves.select_weapon(weapon_name); 
	Saves.save_game();
