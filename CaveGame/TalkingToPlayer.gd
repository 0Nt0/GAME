extends Area2D

func _input(event):
	if event.is_action_pressed("ui_accept") and len(get_overlapping_bodies())>0:
		show_Dialogue()
	
func show_Dialogue():
	var Dialogue=get_parent().get_node("Dialogue")
	if Dialogue:
		Dialogue.chat()
