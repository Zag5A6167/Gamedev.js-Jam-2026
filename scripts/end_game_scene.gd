extends Control

@onready var end_sound = $end_sound
func _ready() -> void:
	end_sound.play()


func _on_end_sound_finished() -> void:
	$first_label.hide()
	$second_label.show()
	await get_tree().create_timer(5.0).timeout
	#get_tree().change_scene_to_file()
