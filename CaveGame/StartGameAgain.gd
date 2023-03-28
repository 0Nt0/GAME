extends TextureButton


func _pressed():
	LevelTracker.UnlockLevel(1)
	get_tree().change_scene("res://World_1.tscn")
