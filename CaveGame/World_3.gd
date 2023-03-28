extends Node2D


func _process(delta):
	EnemiesAreGone()
	BoosIsDead()

func BoosIsDead():
	var referance= weakref($YSort/YSort3/Armor_Slime5)
	if(!referance.get_ref()):
		$YSort/Hole_Ener3/CollisionPolygon2D.disabled=false
		$YSort/Hole_Ener3/Hole.visible=true

func EnemiesAreGone():
	if $YSort/YSort.get_child_count()==0 && $YSort/YSort2.get_child_count()==0 && $YSort/YSort3.get_child_count()==1:
		$GroundAndWalls/TileMap2/StaticBody2D/CollisionPolygon2D.disabled=true
		$GroundAndWalls/TileMap2.visible=false
