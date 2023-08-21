extends Area2D

export(String) var dialogue_index # Variable exportada, asignable en el Inspector
var active = false

func _ready():
	connect("body entered", self, '_on_Note_body_entered')
	connect("body exited", self, '_on_Note_body_exited')

func _on_Note_body_entered(body:Node):
	if body.name == 'Player':
		active = true
		$QuestionMark.visible = active
		$AnimationPlayer.play("fade_in") # Reproduce la animación "fade_in"
		if not active:
			$AnimationPlayer.play_backwards("fade_in") # Reproduce la animación "fade_in" a la inversa

func _on_Note_body_exited(body:Node):
	if body.name == 'Player':
		active = false
		$QuestionMark.visible = active

func _process(_delta):
	$QuestionMark.visible = active

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("Enter") and active:
			get_tree().paused = true
			var dialog = Dialogic.start(dialogue_index) # Usa el valor de dialogue_index asignado en el Inspector
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
