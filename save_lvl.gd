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
	
func reload():
	points = 0;
	time_in_s = 0;
	total_time_in_m = 0;
	total_time_in_s = 0;
	
	
#var world : Resource = preload("world.tres");

#func write_save_lvl():
	#ResourceSaver.save(self, save_path);
	

