extends CharacterBody2D

var speed = 300.0
var gears_held = 0
var fuel_held = 0
var item_multiplier = 1 # ค่าเริ่มต้นคือ 1 (ปกติ) ถ้าได้บัฟจะกลายเป็น 2

func _physics_process(delta: float) -> void:
	# print(fuel_held) # แนะนำให้ปิดไว้เพื่อลดภาระการประมวลผล
	var direction := Input.get_vector("a", "d", "w", "s")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()
