extends VideoStreamPlayer

@onready var logo_1 = $logo1
@onready var logo_2 = $logo2
@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:

	logo_1.modulate.a = 0
	logo_2.modulate.a = 0
	logo_1.show()
	logo_2.show()
	
	finished.connect(_on_video_finished)
	play()


func _on_video_finished() -> void:

	

	var tween1 = create_tween()
	
	tween1.tween_property(logo_1, "modulate:a", 1.0, 1.0)
	
	tween1.tween_property(logo_1, "modulate:a", 0.0, 1.0)
	

	await tween1.finished

	var tween2 = create_tween()
	
	tween2.tween_property(logo_2, "modulate:a", 1.0, 1.0)

	tween2.tween_interval(1.5)

	tween2.tween_property(logo_2, "modulate:a", 0.0, 1.0)
	
	
	await tween2.finished
	

	_transition_to_menu()

func _transition_to_menu() -> void:

	
		get_tree().change_scene_to_file("res://scenes/menu_screen.tscn")
