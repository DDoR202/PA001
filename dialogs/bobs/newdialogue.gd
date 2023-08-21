extends Area2D

var active = false

func _ready():
    connect("body entered", self, '_on_Note_body_entered')
    connect("body exited", self, 'on_Note_body_exited')
    
func _on_Note_body_entered(body:Node):
    if body.name == 'Player':
        print("detected _on_note_body_entered")
        print("Amamos MUCHO a Swing Swuong")
        active = true
        $QuestionMark.visible = active
        $

func _on_Note_body_exited(body:Node):
    if body.name == 'Player':
        print("Amamos a Swing Swuong")
        active = false
        $QuestionMark.visible = active

func _process(_delta):
    $QuestionMark.visible = active


#func _on_Note_body_entered(body:Node):
	#pass # Replace with function body.
