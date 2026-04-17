extends StaticBody2D

var gears_needed = 10 
var current_gears = 0
var robot_level = 1 

func _ready() -> void:
	update_ui()
	$AnimatedSprite2D.play("dead")

func update_ui():
	$Label.text = str(current_gears) + " / " + str(gears_needed)
	if current_gears >= gears_needed:
		robot_upgrade()

func robot_upgrade():

	if robot_level >= 2 and current_gears >= 50:
		game_complete()
		return

	print("Robot Level Upgraded to Level: ", robot_level + 1)
	

	$AnimatedSprite2D.play("effect_change_body")
	if has_node("AnimatedSprite2D_effect"):
		$AnimatedSprite2D_effect.play("effect")
		await $AnimatedSprite2D_effect.animation_finished
	
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.play("wake_up")
	

	robot_level += 1
	current_gears = 0 #
	
	if robot_level == 2:
		gears_needed = 50
	
	
	update_ui()

func game_complete():
	print("Game Complete!")
	$Label.text = "MISSION COMPLETE"
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player") and body.gears_held > 0:
		current_gears += body.gears_held
		body.gears_held = 0 
		update_ui()
