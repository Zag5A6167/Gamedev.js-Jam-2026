extends Area2D


var player_entered = false
func _ready() -> void:
	
	self.body_entered.connect(_body_entered)
	self.body_exited.connect(_body_exited)
	input_pickable = true
	
func _body_entered(body):
	
	if body.name == "player":
		player_entered = true
		print("DW")
	

func _body_exited(body):
	if body.name == "player":
		player_entered = false
		


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
	
			print("Chop")
