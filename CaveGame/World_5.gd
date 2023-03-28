extends Node2D


func _process(delta):
	EnemiesGone()
	
func EnemiesGone():
	if($YSort2/YSort.get_child_count()==0 && $YSort2/YSort2.get_child_count()==0 && $YSort2/YSort3.get_child_count()==0):
		$YSort2/Hole_Ener_5/CollisionPolygon2D.disabled=false
		$YSort2/Hole_Ener_5/Hole.visible=true
