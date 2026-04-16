extends Area2D

@onready var label = $InteractionLabel
@onready var sound_player_collect_item = $AudioStreamPlayer
var player_entered = false
var is_collected = false
func _ready() -> void:
	label.hide()
	self.body_entered.connect(_body_entered)
	self.body_exited.connect(_body_exited)
	
func _process(_delta: float) -> void:	
	if player_entered and not is_collected and Input.is_action_just_pressed("interact"):
			interact()	


func interact():
	is_collected = true
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		players[0].gears_held += 1
		
		
	sound_player_collect_item.play()

	await  sound_player_collect_item.finished
	
	queue_free()
		
func _body_entered(body):
	
	if body.name == "player":
		player_entered = true
		label.show()
	

func _body_exited(body):
	if body.name == "player":
		player_entered = false
		label.hide()
