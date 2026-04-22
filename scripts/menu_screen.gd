extends Control


const STAGE_1_PATH = "res://scenes/main_map.tscn"

const INTRO_SCENE_PATH = "res://intro.tscn" 

func _ready() -> void:
	
	if has_node("TextureRect/TextureButton"):
		$TextureRect/TextureButton.pressed.connect(_on_start_button_pressed)
	
	if has_node("TextureRect/TextureButton3"):
		$TextureRect/TextureButton3.pressed.connect(_on_exit_button_pressed)


func _on_start_button_pressed() -> void:
	change_scene(STAGE_1_PATH)


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func change_scene(scene_path: String) -> void:
	
	if ResourceLoader.exists(scene_path):
		var error = get_tree().change_scene_to_file(scene_path)
		if error != OK:
			print("Error: เกิดข้อผิดพลาดทางเทคนิคขณะโหลดฉาก")
	else:
		print("Error: ไม่พบไฟล์ฉากที่: ", scene_path)
