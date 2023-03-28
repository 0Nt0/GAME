extends Node2D



func _process(delta):
	NoMoreEnemies()
	BossDead()

func BossDead():
	var referance= weakref($YSort2/YSort/Bat15)
	if(!referance.get_ref()):
		$YSort2/Hole_Ener4/CollisionPolygon2D.disabled=false
		$YSort2/Hole_Ener4/Hole.visible=true

func NoMoreEnemies():
	if($YSort2/YSort.get_child_count()==1 && $YSort2/YSort2.get_child_count()==0 && $YSort2/YSort3.get_child_count()==0):
		$YSort/BossDoor/StaticBody2D/CollisionPolygon2D.disabled=true
		$YSort/BossDoor.visible=false
