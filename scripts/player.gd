extends CharacterBody2D

var speed = 300.0
var gears_held = 0
var fuel_held = 0
var item_multiplier = 1 

# เชื่อมต่อกับ Node Camera2D ที่อยู่ใต้ Player
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	# ตั้งค่ากล้องให้ติดตามไวขึ้นและนุ่มนวลผ่านโค้ด
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 10.0 # ปรับค่านี้ (5-15) ยิ่งมากยิ่งตามไวขึ้น
	
	# ปรับระยะซูมให้เห็นฉากพอดี (ตัวอย่างคือ 1.2 เท่า)
	camera.zoom = Vector2(1, 1)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("a", "d", "w", "s")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()
