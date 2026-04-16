extends CanvasLayer

@onready var gears_label = $Control/Label



func _process(delta: float) -> void:
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		var player = players[0]
		gears_label.text = str(player.gears_held)
