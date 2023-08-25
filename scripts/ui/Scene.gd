extends Node2D

# Señal para cuando la animación de aparición gradual termine
signal fade_in_finished

onready var fade_in_player = $FadeIn/Control/AnimationPlayer

func _ready():
	# Pausa todos los nodos excepto el AnimationPlayer
	for node in get_children():
		if node != fade_in_player:
			node.pause_mode = Node.PAUSE_MODE_STOP

	# Conecta la señal de animación terminada
	fade_in_player.connect("animation_finished", self, "_on_fade_in_finished")

	# Reproduce la animación "fade_in"
	fade_in_player.play("fade_in")

# Función para manejar cuando la animación de aparición gradual termine
func _on_fade_in_finished(animation_name):
	if animation_name == "fade_in":
		# Despausa los nodos después de que la animación de aparición gradual termine
		for node in get_children():
			node.pause_mode = Node.PAUSE_MODE_INHERIT

# Tu código existente ...
