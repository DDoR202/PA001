extends KinematicBody2D

export var MOVE_SPEED = 6.0
const FAST_MOVE_SPEED = 8.0
const GRID_SIZE = 32

var initial_position = Vector2(0, 0)
var target_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0.0

onready var raycast_forward = $RayCast2D_Forward
onready var raycast_right = $RayCast2D_Right
onready var raycast_left = $RayCast2D_Left
onready var raycast_down = $RayCast2D_Down
onready var raycast_area_forward = $RayCast2D_Area_Forward
onready var raycast_area_right = $RayCast2D_Area_Right
onready var raycast_area_left = $RayCast2D_Area_Left
onready var raycast_area_down = $RayCast2D_Area_Down



func _ready():
	for raycast in [raycast_forward, raycast_right, raycast_left, raycast_down]:
		raycast.enabled = true
		raycast.collision_mask = 2


func _physics_process(delta):
	if !is_moving:
		process_player_input()
		if input_direction != Vector2.ZERO and not is_collision():
			initial_position = position
			target_position = initial_position + GRID_SIZE * input_direction
			is_moving = true
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false

func process_player_input():
	input_direction = Vector2(0, 0)
	if Input.is_action_pressed("Right") and not raycast_right.is_colliding():
		input_direction.x = 1
	elif Input.is_action_pressed("Left") and not raycast_left.is_colliding():
		input_direction.x = -1
	elif Input.is_action_pressed("Down") and not raycast_down.is_colliding():
		input_direction.y = 1
	elif Input.is_action_pressed("Up") and not raycast_forward.is_colliding():
		input_direction.y = -1

func is_collision():
	return false

func move(delta):
	percent_moved_to_next_tile += get_move_speed() * delta
	if percent_moved_to_next_tile >= 1.0:
		position = target_position
		percent_moved_to_next_tile = 0.0
		is_moving = false
	else:
		position = initial_position.linear_interpolate(target_position, percent_moved_to_next_tile)

func get_move_speed():
	if Input.is_action_pressed("Shift"):
		return FAST_MOVE_SPEED
	else:
		return MOVE_SPEED

