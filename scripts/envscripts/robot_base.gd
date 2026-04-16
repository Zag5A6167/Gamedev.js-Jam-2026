extends StaticBody2D

var gears_needed = 10 
var current_gears = 0
var is_player_entered = false
func _ready() -> void:
	$Label.text = str(current_gears) + " / " + str(gears_needed)
	$AnimatedSprite2D.play("dead")
func update_ui():
	$Label.text = str(current_gears) + " / " + str(gears_needed)
	if current_gears >= gears_needed:
		robot_upgrade()

func robot_upgrade():
	print("robot upgraded")
	$AnimatedSprite2D.play("effect_change_body")
	$AnimatedSprite2D_effect.play("effect")
	await $AnimatedSprite2D_effect.animation_finished
	$AnimatedSprite2D.play("wake_up")
	current_gears = 0
	gears_needed = 50
	update_ui()
	




func _on_area_2d_body_entered(body: Node2D) -> void:
	is_player_entered = true
	if body.name == "player" and body.gears_held > 0:
		
		current_gears += body.gears_held
		body.gears_held = 0 
		update_ui()


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player_entered = false
