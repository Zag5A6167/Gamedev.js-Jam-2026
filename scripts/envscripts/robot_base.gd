extends StaticBody2D

var gears_needed = 10 
var current_gears = 0

func _ready() -> void:
	$Label.text = str(current_gears) + " / " + str(gears_needed)

func update_ui():
	$Label.text = str(current_gears) + " / " + str(gears_needed)
	if current_gears >= gears_needed:
		win_game()

func win_game():
	print("robot upgraded")
	




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and body.gears_held > 0:
		print("rg")
		current_gears += body.gears_held
		body.gears_held = 0 
		update_ui()
