extends Area2D
	
var levels=2
var next

var entered=false



func _on_Hole_Ener_body_entered(body):
	entered=true
	
func _input(event):
	if entered==true and Input.is_action_just_pressed("ui_accept"):
		LevelTracker.UnlockLevel(levels)
		get_tree().change_scene("res://Map.tscn")

func _on_Hole_Ener_body_exited(body):
	entered=false;
