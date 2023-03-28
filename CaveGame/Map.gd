extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levels=0

# Called when the node enters the scene tree for the first time.
func _ready():
	levels=LevelTracker.GetUnlocksedLevels()
	match levels:
		
		2:
			$Lv_1.disabled = false
			$Lv_2.disabled = false
		3:
			$LV_3.disabled = false
			$Lv_2.disabled = false
			$Lv_1.disabled = false
		4:
			$Lv_4.disabled = false
			$LV_3.disabled = false
			$Lv_2.disabled = false
			$Lv_1.disabled = false
		6:
			$LV_6.disabled = false
			$Lv_4.disabled = false
			$LV_3.disabled = false
			$Lv_2.disabled = false
			$Lv_1.disabled = false
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
