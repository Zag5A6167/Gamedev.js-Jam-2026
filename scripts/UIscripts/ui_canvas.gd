extends CanvasLayer

@onready var gears_label = $Control/Label
@onready var timer_label = $Control/TimerLabel
@onready var message_label = $Control/message_label
@onready var mute_button = $TextureButton 

var time_left = 60.0 
var is_time_active = true
var message_tween : Tween 
var player_ref = null

func _ready() -> void:
	message_label.hide()
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_ref = players[0]
	
	var boosts = get_tree().get_nodes_in_group("speed_boost_items")
	for boost in boosts:
		boost.speed_boosted.connect(_on_speed_boosted)

func _process(delta: float) -> void:
	if player_ref:
		gears_label.text = str(player_ref.gears_held)
	
	if is_time_active:
		if time_left > 0:
			time_left -= delta
			update_timer_display()
		else:
			time_left = 0
			is_time_active = false
			game_over()

func update_timer_display():
	var mins = floor(time_left / 60.0) 
	var secs = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [mins, secs]
	
	if time_left < 10:
		timer_label.add_theme_color_override("font_color", Color.RED)
	else:
		timer_label.add_theme_color_override("font_color", Color.WHITE)

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
	message_tween.tween_property(message_label, "modulate:a", 0.0, 0.5)
	message_tween.tween_callback(message_label.hide)

func _on_texture_button_pressed() -> void:
	var master_bus = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_bus)
	
	AudioServer.set_bus_mute(master_bus, !is_muted)
	
	if !is_muted:

		mute_button.texture_normal = load("res://icons/sound/off.png")
	else:

		mute_button.texture_normal = load("res://icons/sound/normal.png")
