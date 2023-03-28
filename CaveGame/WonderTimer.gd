extends Node2D


onready var enemyPosition=global_position;
onready var endPosition=global_position;
onready var time=$Timer;
var vector;

func change_position():
	vector=Vector2(rand_range(-64,64), rand_range(-64,64))
	endPosition=enemyPosition+vector

func start_time():
	time.start(rand_range(2,6));

func get_time():
	return time.time_left;
	
func get_vector():
	return vector;

func _on_Timer_timeout():
	change_position();
