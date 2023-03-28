extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file
var Dialogue=[]
var Dialogue_Now=0
var active=false

func _ready():
	$NinePatchRect.visible=false

func chat():
	if active:
		return
	active=true
	$NinePatchRect.visible=true
	Dialogue= Get_Dialogue()
	Next()
	
func Get_Dialogue():
	var file= File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file,file.READ)
		return parse_json(file.get_as_text())


func _input(event):
	if not active:
		return
	if event.is_action_pressed("ui_accept"):
		Dialogue_Now +=1
		Next()
		

func Next():
	
	if Dialogue_Now>= len(Dialogue):
		$Timer.start()
		$NinePatchRect.visible=false
		return
	$NinePatchRect/Name.text= Dialogue[Dialogue_Now]["name"]
	$NinePatchRect/Text.text=Dialogue[Dialogue_Now]["text"]


func _on_Timer_timeout():
	active=false
