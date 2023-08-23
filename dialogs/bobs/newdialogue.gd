extends Area2D

export(String) var dialogue_index # Variable exportada, asignable en el Inspector
var active = false
var dialogue_active = false 

func _ready():
	connect("body entered", self, '_on_Note_body_entered')
	connect("body exited", self, '_on_Note_body_exited')

func _on_Note_body_entered(body:Node):
	if body.name == 'Player':
		active = true
		$AnimationPlayer.play("fade_in") # Reproduce la animación "fade_in"

func _on_Note_body_exited(body:Node):
	if body.name == 'Player':
		active = false # Restablecer 'active' a falso cuando el jugador sale del área
		$AnimationPlayer.play_backwards("fade_in") # Reproduce la animación "fade_in"


func _input(event):
	if not dialogue_active and event.is_action_pressed("Enter") and active:
		get_tree().paused = true
		get_node("/root/Node2D/Player").can_move = false
		if event.is_action_pressed("Enter") and active:
			get_tree().paused = true
			get_node("/root/Node2D/Player").can_move = false # Deshabilita el movimiento aquí
			var dialog = Dialogic.start(dialogue_index) # Usa el valor de dialogue_index asignado en el Inspector
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('tree_exited', self, '_on_dialogue_tree_exited') # Conectar la señal de fin del diálogo
			add_child(dialog)
			dialogue_active = true # Marca el diálogo como activo

func _on_dialogue_tree_exited():
	dialogue_active = false
	get_tree().paused = false
	get_node("/root/Node2D/Player").can_move = true
