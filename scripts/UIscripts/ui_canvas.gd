extends CanvasLayer

@onready var gears_label = $Control/Label
@onready var timer_label = $Control/TimerLabel
@onready var message_label = $Control/message_label

var time_left = 60.0 # แก้เป็น 60 วินาที (1 นาที)
var is_time_active = true
var message_tween : Tween 
var player_ref = null # สร้างตัวแปรไว้เก็บค่า player

func _ready() -> void:
	message_label.hide()
	
	# หา player เก็บไว้ตั้งแต่เริ่มเกมครั้งเดียว
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_ref = players[0]
	
	var boosts = get_tree().get_nodes_in_group("speed_boost_items")
	for boost in boosts:
		boost.speed_boosted.connect(_on_speed_boosted)

func _process(delta: float) -> void:
	# อัปเดต gear label โดยใช้ player_ref ที่หาไว้แล้ว
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
	# ใช้ floor() เพื่อปัดเศษทิ้งให้ชัดเจน หรือใช้ fmod สำหรับวินาที
	# วิธีนี้จะช่วยลบ Warning เพราะเราบอกโปรแกรมชัดเจนว่าต้องการจัดการเศษอย่างไร
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
