extends Control

const first_scene = preload("res://scenes/levels/Level001.tscn")

onready var fade_out = $FadeOut/AnimationPlayer
onready var selector_one = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_one_ = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector2
onready var selector_two = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_two_ = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector2
onready var selector_three = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selector_three_ = $MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector2
onready var audio_player = $AudioStreamPlayer # Asegúrate de tener un nodo AudioStreamPlayer en tu escena
onready var audio_player2 = $AudioStreamPlayer2 # Asegúrate de tener un nodo AudioStreamPlayer en tu escena
onready var animation_player = $AnimationPlayer # Referencia al AnimationPlayer




var alpha = Color(0, 0, 0, 0)
var white = Color(1, 1, 1, 1)
var current_selection = 0

func _ready():
	_set_current_selection(0)
	fade_out.connect("animation_finished", self, "_on_fade_out_finished")

func _process(_delta):
	if Input.is_action_just_pressed("Down"):
		current_selection += 1
		if current_selection > 2: # Si supera 2, volver a 0
			current_selection = 0
		_set_current_selection(current_selection)
		audio_player.play() # Reproduce el sonido
	if Input.is_action_just_pressed("Up"):
		current_selection -= 1
		if current_selection < 0: # Si baja de 0, subir a 2
			current_selection = 2
		_set_current_selection(current_selection)
		audio_player.play() # Reproduce el sonido
	elif Input.is_action_just_pressed("Enter"):
		handle_selection(current_selection)
		audio_player.play() # Reproduce el sonido
func handle_selection(_current_selection):
	if _current_selection == 0:
		fade_out.play("fade_out") # Reproduce la animación de desvanecimiento
	elif _current_selection == 1:
		audio_player2.play() # Reproduce el sonido del AudioStreamPlayer2
		animation_player.play("shake") # Reproduce la animación "shake"

func _on_fade_out_finished(animation_name):
	if animation_name == "fade_out":
		# Carga la escena después de que la animación de desvanecimiento termine
		get_parent().add_child(first_scene.instance())
		queue_free()

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
