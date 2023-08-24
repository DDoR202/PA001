extends Control

const first_scene = preload("res://scenes/levels/Level001.tscn")


onready var selector_one = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_one_ = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector2
onready var selector_two = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_two_ = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector2
onready var selector_three = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selector_three_ = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector2

var alpha = Color(0, 0, 0, 0)
var white = Color(1, 1, 1, 1)
var current_selection = 0

func _ready():
	_set_current_selection(0)

func _process(delta):
	if Input.is_action_just_pressed("Down") and current_selection < 2:
		current_selection += 1
		_set_current_selection(current_selection)
	if Input.is_action_just_pressed("Up") and current_selection > 0:
		current_selection -= 1
		_set_current_selection(current_selection)
	elif Input.is_action_just_pressed("Enter"):
		handle_selection(current_selection):

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent

func _set_current_selection(current_selection):
	selector_one.modulate = alpha
	selector_one_.modulate = alpha
	selector_two.modulate = alpha
	selector_two_.modulate = alpha
	selector_three.modulate = alpha
	selector_three_.modulate = alpha
	if current_selection == 0:
		selector_one.modulate = white
		selector_one_.modulate = white
	elif current_selection == 1:
		selector_two.modulate = white
		selector_two_.modulate = white
	elif current_selection == 2:
		selector_three.modulate = white
		selector_three_.modulate = white
		
