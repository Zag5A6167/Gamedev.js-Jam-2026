extends Control

# กำหนดเส้นทางไฟล์ฉากที่ต้องการเปลี่ยนไป (ปรับแก้ชื่อไฟล์ตามที่คุณตั้งไว้จริง)
const STAGE_1_PATH = "res://scenes/main_map.tscn"


func _ready() -> void:
	# เชื่อมต่อสัญญาณจากปุ่มต่างๆ
	$TextureRect/TextureButton.pressed.connect(_on_start_button_pressed)
	$TextureRect/TextureButton3.pressed.connect(_on_exit_button_pressed)

# 1. ปุ่มแรก: ไปที่ฉากเกม (Template)
func _on_start_button_pressed() -> void:
	change_scene(STAGE_1_PATH)

# 3. ปุ่มที่สาม: ออกจากเกม
func _on_exit_button_pressed() -> void:
	get_tree().quit()

# ฟังก์ชันกลางสำหรับเปลี่ยนฉาก (ช่วยให้โค้ดดูสะอาดและแก้ง่าย)
func change_scene(scene_path: String) -> void:
	var error = get_tree().change_scene_to_file(scene_path)
	if error != OK:
		print("Error: ไม่สามารถโหลดฉากได้ที่ path: ", scene_path)
