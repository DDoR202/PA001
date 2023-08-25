extends KinematicBody2D





export var MOVE_SPEED = 6.0
const GRID_SIZE = 32

onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var chase_area = $ChaseArea
onready var escape_area = $EscapeArea

var path = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)] # Ejemplo de camino
var path_index = 0
var is_chasing_player = false

func _ready():
	chase_area.connect("area_entered", self, "_on_chase_area_entered")
	escape_area.connect("area_exited", self, "_on_escape_area_exited")

func _physics_process(delta):
	if Newdialogue.dialogue_active:
		return

	if is_chasing_player:
		chase_player(delta)
	else:
		follow_path(delta)

func follow_path(delta):
	# Implementar la lógica para seguir el camino definido
	# Similar a tu lógica de movimiento existente, pero utilizando el camino en lugar de la entrada del jugador

func chase_player(delta):
	# Implementar la lógica para perseguir al jugador
	# Puedes calcular la dirección hacia el jugador y luego usar tu lógica de movimiento existente

func _on_chase_area_entered(area):
	if area == player: # Asegúrate de que el área sea la del jugador
		is_chasing_player = true

func _on_escape_area_exited(area):
	if area == player: # Asegúrate de que el área sea la del jugador
		is_chasing_player = false
		# Aquí puedes resetear el NPC a su camino original si es necesario
