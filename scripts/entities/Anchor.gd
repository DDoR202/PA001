extends Position2D

# Obtiene una referencia al jugador al inicio.
onready var player = get_node("../Player")

func _process(_delta):
	# Define la posición objetivo a la que el nodo debe moverse.
	var target = player.global_position
	
	# Calcula las posiciones x e y usando interpolación lineal (lerp) para suavizar el movimiento.
	var target_pos_x = int(lerp(global_position.x, target.x, 0.09))
	var target_pos_y = int(lerp(global_position.y, target.y, 0.09))
	
	# Actualiza la posición global del nodo.
	global_position = Vector2(target_pos_x, target_pos_y)
