extends Area2D

var entered=false

func _input(event):
	if entered==true and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Game_Won.tscn")

func _on_Hole_Ener_5_body_entered(body):
		entered=true

func _on_Hole_Ener_5_body_exited(body):
	entered=false
