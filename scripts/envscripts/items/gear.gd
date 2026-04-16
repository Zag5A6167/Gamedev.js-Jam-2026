extends Area2D

@onready var label = $InteractionLabel
var player_entered = false
func _ready() -> void:
	label.hide()
	self.body_entered.connect(_body_entered)
	self.body_exited.connect(_body_exited)
	
	
func _body_entered(body):
	
	if body.name == "player":
		player_entered = true
		label.show()
	

func _body_exited(body):
	if body.name == "player":
		player_entered = false
		label.hide()
