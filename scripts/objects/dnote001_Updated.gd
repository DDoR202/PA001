extends Area2D

export var dialogue_key = ""
var area_active = false
var dialogue_box_scene = load("res://dialogs/bobs/CanvasLayer.tscn") # Carga la escena
var dialogue_box

func _ready():
	dialogue_box = dialogue_box_scene.instance() # Instancia la escena
	call_deferred("add_child", dialogue_box) # Añade la instancia a la escena de forma diferida
	dialogue_box.connect("dialogue_ended", self, "_on_dialogue_ended")

func _input(event):
	if area_active and event.is_action_pressed("Enter"):
		_start_dialog()

func _on_Note_area_entered(area):
	if area.is_in_group("Player"):
		area_active = true

func _on_Note_area_exited(area):
	area_active = false

func _start_dialog():
	var dialogue_file_path = "res://dialogs/" + dialogue_key + ".json"
	var dialogue_file = File.new()
	dialogue_file.open(dialogue_file_path, File.READ)
	var dialogue_content = parse_json(dialogue_file.get_as_text())
	dialogue_file.close()
	
	dialogue_box.start(dialogue_content) # Utiliza la referencia a dialogue_box que ya has creado

func _on_dialogue_ended():
	dialogue_box.hide() # Oculta la instancia de DialogueBox
