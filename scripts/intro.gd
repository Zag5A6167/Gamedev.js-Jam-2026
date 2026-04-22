extends VideoStreamPlayer

# ดึง Node ลูกมาสร้างเป็นตัวแปรเพื่อให้เรียกใช้ง่ายๆ
@onready var logo1 = $logo1
@onready var logo2 = $logo2

func _ready() -> void:
	
	logo1.modulate.a = 0
	logo2.modulate.a = 0
	
	
	self.finished.connect(_on_video_finished)
	


func _on_video_finished() -> void:
	var tween = create_tween()
	

	tween.tween_callback(func(): $AudioStreamPlayer.pitch_scale = 1.0)
	tween.tween_callback($AudioStreamPlayer.play)
	
	tween.tween_property(logo1, "modulate:a", 1.0, 1.0)
	tween.tween_interval(1.5)
	tween.tween_property(logo1, "modulate:a", 0.0, 1.0)
	

	tween.tween_callback(func(): $AudioStreamPlayer.pitch_scale = 1.5)
	tween.tween_callback($AudioStreamPlayer.play)
	
	tween.tween_property(logo2, "modulate:a", 1.0, 1.0)
	tween.tween_interval(1.5)
	tween.tween_property(logo2, "modulate:a", 0.0, 1.0)
	

	tween.finished.connect(_change_to_main_menu)
	
	
func _change_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/menu_screen.tscn")
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		_change_to_main_menu()
