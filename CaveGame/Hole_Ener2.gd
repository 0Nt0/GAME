extends Area2D
	
var levels=3
var next

var entered=false	
var ref=weakref($YSort/YSort2/Slime9)

func _process(delta):
	
		pass
	
func _input(event):
	if entered==true and Input.is_action_just_pressed("ui_accept"):
		LevelTracker.UnlockLevel(levels)
		get_tree().change_scene("res://Map.tscn")

func _on_Hole_Ener2_body_entered(body):
	entered=true


func _on_Hole_Ener2_body_exited(body):
	entered=false
