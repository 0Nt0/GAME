extends Node2D

func _process(delta):
	EnemiesAreDead()
	BossIsDead()
	
	
	
	

func BossIsDead():
	var referance= weakref($YSort/YSort2/Slime9)
	if(!referance.get_ref()):
		$Hole_Ener2/CollisionPolygon2D.disabled=false
		$Hole_Ener2/Hole.visible=true
	else:
		pass
func EnemiesAreDead():
	
	if $YSort/YSort.get_child_count()==0:
		print($YSort/YSort.get_child_count())
		$YSort/DoorToBoss/CollisionForBossDoor/CollisionPolygon2D.disabled=true
		$YSort/DoorToBoss.visible=false
	
