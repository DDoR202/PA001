extends KinematicBody2D

export var MOVE_SPEED = 4.0
const FAST_MOVE_SPEED = 6.0
const GRID_SIZE = 32

onready var ray = $RayCast2D

var initial_position = Vector2(0, 0)
var target_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0.0

func _ready():
	initial_position = position

func _physics_process(delta):
	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false

func process_player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	if input_direction != Vector2.ZERO:
		initial_position = position
		target_position = initial_position + GRID_SIZE * input_direction
		is_moving = true

func move(delta):
	percent_moved_to_next_tile += get_move_speed() * delta
	var desired_step: Vector2 = input_direction * GRID_SIZE / 2
	ray.cast_to = desired_step
	ray.force_raycast_update()
	if !ray.is_colliding():
		if percent_moved_to_next_tile >= 1.0:
			position = target_position
			percent_moved_to_next_tile = 0.0
			is_moving = false
		else:
			position = initial_position.linear_interpolate(target_position, percent_moved_to_next_tile)
	else:
		is_moving = false

func get_move_speed():
	if Input.is_action_pressed("Shift"):
		return FAST_MOVE_SPEED
	else:
		return MOVE_SPEED
