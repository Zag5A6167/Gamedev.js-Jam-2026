extends VideoStreamPlayer

@onready var color_rect = $ColorRect
@onready var logo_1 = $logo1
@onready var logo_2 = $logo2
@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	# 1. เตรียมความพร้อม ซ่อนโลโก้ก่อน
	logo_1.hide()
	logo_2.hide()
	
	# 2. เชื่อมต่อ Signal เมื่อวิดีโอเล่นจบ
	finished.connect(_on_video_finished)
	
	# 3. เริ่มเล่นวิดีโอ Intro
	play()

func _input(event: InputEvent) -> void:
	# ระบบ Skip: ถ้ากดปุ่มใดๆ หรือคลิกเมาส์ ให้ข้ามไปหน้าเมนูเลย
	if event.is_pressed():
		_transition_to_menu()

func _on_video_finished() -> void:
	# เมื่อวิดีโอจบ สามารถเลือกว่าจะแสดงโลโก้ต่อ หรือไปหน้าเมนูเลย
	# ในที่นี้คือสั่งให้ไปหน้าเมนูทันที
	_transition_to_menu()

func _transition_to_menu() -> void:
	# เปลี่ยนฉากไปยังหน้า MenuScreen (ตรวจสอบ Path ให้ถูกต้อง)
	get_tree().change_scene_to_file("res://scenes/menu_screen.tscn")
