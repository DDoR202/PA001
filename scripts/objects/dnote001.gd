extends Area2D

export var dialogue_key = "dnote001" # Ajusta esto según la clave de diálogo correspondiente
var area_active = false

func _ready():
	pass

func _input(event):
	if area_active and event.is_action_pressed("Enter"): # Asegúrate de que "ui_accept" está configurado para la tecla Enter
		_start_dialog()

func _on_Note_area_entered(area):
	if area.is_in_group("Player"): # Puedes usar grupos para identificar el personaje
		area_active = true

func _on_Note_area_exited(area):
	area_active = false

func _start_dialog():
	var dialogue_file_path = "res://dialogs/" + dialogue_key + ".json"
	var dialogue_file = File.new()
	dialogue_file.open(dialogue_file_path, File.READ)
	var dialogue_content = parse_json(dialogue_file.get_as_text())
	dialogue_file.close()
	
	var dialogue_box = get_node("res://dialogs/bobs/CanvasLayer.tscn") # Ajusta la ruta según la ubicación de tu caja de diálogo
	dialogue_box.display_text(dialogue_content[0]["text"]) # Ajusta esto según la estructura de tu archivo JSON

	# Aquí puedes agregar el código para mostrar el diálogo en tu juego, posiblemente usando un singleton o un nodo de diálogo en tu escena
