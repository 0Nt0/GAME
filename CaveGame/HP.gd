extends Control

var hp

func _ready():
	
	pass

func _process(delta):
	hp=HPTracker.GetHp()
	$HPSprite/Label.text="HP: "+ str(hp)
	
