extends Area2D

var Enemy=null

func _on_EnemyDetecton_body_entered(body):
	Enemy=body


func _on_EnemyDetecton_body_exited(body):
	Enemy=null

func SeeEnemy():
	return Enemy!=null
