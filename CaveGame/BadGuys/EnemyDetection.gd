extends Area2D


var Enemy=null

func _on_EnemyDetection_body_entered(body):
	Enemy=body


func _on_EnemyDetection_body_exited(body):
	Enemy=null
	
func SeeEnemy():
	return Enemy!=null
