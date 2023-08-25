extends Area2D

onready var Audio = $AudioStreamPlayer2D

func _ready():
	connect("body_entered", self, '_on_Area2D_body_entered')

func _on_Area2D_body_entered(body:Node):
	if body.name == 'Player':
		Audio.play()
		
