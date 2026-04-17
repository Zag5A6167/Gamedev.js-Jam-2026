extends CanvasLayer

@onready var gears_label = $Control/Label
@onready var timer_label = $Control/TimerLabel
@onready var message_label = $Control/message_label

var time_left = 300.0
var is_time_active = true
var message_tween : Tween 

func _ready() -> void:
	
	message_label.hide()
	
	var boosts = get_tree().get_nodes_in_group("speed_boost_items")
	for boost in boosts:
		boost.speed_boosted.connect(_on_speed_boosted)

func _process(delta: float) -> void:

	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		gears_label.text = str(player.gears_held)
	

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


func _on_speed_boosted(msg):
	
	if message_tween:
		message_tween.kill()
		
	message_label.text = msg
	message_label.show()
	message_label.modulate.a = 1.0 
	
	
	message_tween = create_tween()
	message_tween.tween_interval(1.5) 
	message_tween.tween_property(message_label, "modulate:a", 0.0, 0.5) # จางหายใน 0.5 วินาที
	message_tween.tween_callback(message_label.hide) 
