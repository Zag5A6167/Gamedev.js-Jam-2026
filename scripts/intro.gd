extends VideoStreamPlayer

@onready var logo1 = $logo1
@onready var logo2 = $logo2
@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	logo1.modulate.a = 0
	logo2.modulate.a = 0
	
	# เชื่อมต่อสัญญาณเมื่อวิดีโอจบ
	self.finished.connect(_on_video_finished)
	
	# เริ่มเล่นวิดีโอทันที
	play()

func _input(event: InputEvent) -> void:
	# ระบบ Skip: ถ้ากดปุ่มใดๆ หรือคลิกเมาส์ ให้ข้ามไปหน้าเมนูทันที
	if event.is_pressed():
		_transition_to_menu()

func _on_video_finished() -> void:
	var tween = create_tween()
	
	# แสดง Logo 1
	tween.tween_callback(func(): audio_player.pitch_scale = 1.0)
	tween.tween_callback(audio_player.play)
	tween.tween_property(logo1, "modulate:a", 1.0, 1.0)
	tween.tween_interval(1.5)
	tween.tween_property(logo1, "modulate:a", 0.0, 1.0)
	
	# แสดง Logo 2
	tween.tween_callback(func(): audio_player.pitch_scale = 1.5) 
	tween.tween_callback(audio_player.play)
	tween.tween_property(logo2, "modulate:a", 1.0, 1.0)
	tween.tween_interval(1.5)
	tween.tween_property(logo2, "modulate:a", 0.0, 1.0)
	
	# --- จุดที่หายไป: เมื่อ Tween ทั้งหมดทำงานจบ ให้ไปหน้าเมนู ---
	tween.tween_callback(_transition_to_menu)

func _transition_to_menu() -> void:
	# ตรวจสอบ Path ให้ถูกต้องตามที่อยู่ใน FileSystem ของคุณ
	var menu_path = "res://scenes/menu_screen.tscn"
	
	if ResourceLoader.exists(menu_path):
		get_tree().change_scene_to_file(menu_path)
	else:
		print("Error: ไม่พบไฟล์หน้าเมนูที่ ", menu_path)
