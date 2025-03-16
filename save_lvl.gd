#///TODO: потом сделать полноценное сохранение лвла и данных в нем(игрока, противников, мира(очков, времени и др.)).

#extends Resource;
extends Node;

const save_path = "user://save_lvl.tres";
var points = 0;
var time_in_s : int = 0;
var total_time_in_m : int = 0;
var total_time_in_s : int = 0;

func _ready():
	pass;

func _process(delta):
	pass;
	
#var world : Resource = preload("world.tres");

#func write_save_lvl():
	#ResourceSaver.save(self, save_path);
	

