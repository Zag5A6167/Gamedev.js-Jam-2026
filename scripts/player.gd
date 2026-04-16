extends CharacterBody2D

const SPEED = 300.0
var gears_held = 0


func _physics_process(delta: float) -> void:
	
	var direction := Input.get_vector("a", "d", "w", "s")
	
	if direction != Vector2.ZERO:
		
		velocity = direction * SPEED
	else:
		
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)


	move_and_slide()
# 
