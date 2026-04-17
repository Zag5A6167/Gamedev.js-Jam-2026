extends CanvasLayer

@onready var gears_label = $Control/Label
@onready var timer_label = $Control/TimerLabel

var time_left = 300.0
var is_time_active = true

func _process(delta: float) -> void:

	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		gears_label.text =  str(player.gears_held)
	

	if is_time_active:
		if time_left > 0:
			time_left -= delta
			update_timer_display()
		else:
			time_left = 0
			is_time_active = false
			game_over()

func update_timer_display():

	var mins = int(time_left) / 60
	var secs = int(time_left) % 60
	
	timer_label.text = str("%02d:%02d" % [mins, secs])
	

	if time_left < 10:
		timer_label.add_theme_color_override("font_color", Color.RED)

func game_over():
	print("game over")
