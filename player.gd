extends CharacterBody2D;

@export var move_speed = 350;

#//оружие 
#///TODO: сделать список хранящий экземпляры оружия.
#///TODO: скорее всего еще сделать сцену - класс, который как раз будет давать внешку, способности и второе оружие, а также статы.

#//сохранения
#///TODO: после выхода в главное меню из меню паузы сделать сохранение уровня(игрока, противников и мира). Потом при заходе в игру, высвечиваться будет, начать новую или продолжить(удаление при новой игры).
#///TODO: при рестарте из меню паузы стирание данных игры.

@export var weapon_scene : PackedScene;
var weapon_instance: Node2D = null;
@onready var hp = $healthComponent;


func _ready():
	$uiCanvas/PlayerUI.show();
	$healthComponent.connect("killSignal", Callable(self, "kill"));
	$lvlPassCanvas/lvl_passed.connect("disablePMSignal", Callable(self, "disablePM"));
	if weapon_scene:
		weapon_instance = weapon_scene.instantiate();
		$WeaponAttachment.add_child(weapon_instance);
	pass;

func _process(delta):
	if hp.dead:
		return;
	look_at(get_global_mouse_position());
	if Input.is_action_just_pressed("shoot"):
		weapon_instance.shoot($WeaponAttachment.global_position);
		
func _physics_process(delta):
	if hp.dead:
		return;
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = move_dir * move_speed;
	move_and_slide();
	
func damage(damage):
	hp.damage(damage);
	
func kill():
	$Graphics/Dead.show();
	$Graphics/Alive.hide();
	#$deathCanvas/DeathScreen.show();
	$lvlPassCanvas/lvl_passed.lvlPass();
	z_index = -1;
	
#func restart():  //deathCanvas
	#get_tree().reload_current_scene();
#func _on_button_pressed():
	#restart();
#func _on_button_2_pressed():
	#get_tree().change_scene_to_file("res://menu.tscn");
	
func disablePM():
	$pauseCanvas/PauseMenu.set_process(false);
	
