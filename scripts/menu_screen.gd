extends Control

# กำหนดเส้นทางไฟล์ฉากที่ต้องการเปลี่ยนไป
const STAGE_1_PATH = "res://scenes/main_map.tscn"
# เพิ่ม Path ของ Intro ไว้เผื่อเรียกใช้ (แต่ปกติเราจะรันผ่าน Project Settings)
const INTRO_SCENE_PATH = "res://intro.tscn" 

func _ready() -> void:
	# ตรวจสอบว่า Node มีอยู่จริงก่อนเชื่อมต่อเพื่อป้องกัน Crash
	if has_node("TextureRect/TextureButton"):
		$TextureRect/TextureButton.pressed.connect(_on_start_button_pressed)
	
	if has_node("TextureRect/TextureButton3"):
		$TextureRect/TextureButton3.pressed.connect(_on_exit_button_pressed)

# 1. ปุ่มเริ่มเกม: เปลี่ยนไปฉากแผนที่หลัก
func _on_start_button_pressed() -> void:
	change_scene(STAGE_1_PATH)

# 2. ปุ่มออกจากเกม
func _on_exit_button_pressed() -> void:
	get_tree().quit()

# ฟังก์ชันกลางสำหรับเปลี่ยนฉาก
func change_scene(scene_path: String) -> void:
	# ตรวจสอบว่าไฟล์มีอยู่จริงไหมก่อนเปลี่ยนฉาก (ป้องกันบัค Path ผิด)
	if ResourceLoader.exists(scene_path):
		var error = get_tree().change_scene_to_file(scene_path)
		if error != OK:
			print("Error: เกิดข้อผิดพลาดทางเทคนิคขณะโหลดฉาก")
	else:
		print("Error: ไม่พบไฟล์ฉากที่: ", scene_path)
