extends Area2D


var Player=null

func _on_PlayerDetection_body_entered(body):
	Player=body


func _on_PlayerDetection_body_exited(body):
	Player=null

func SeePlayer():
	return Player!=null
