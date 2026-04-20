extends Area2D

@onready var label = $InteractionLabel
@onready var sound_player_collect_item = $AudioStreamPlayer

var player_ref = null # เปลี่ยนจาก boolean เป็นการเก็บตัวแปร player โดยตรง
var is_collected = false

func _ready() -> void:
	label.hide()
	# เชื่อมต่อ Signal
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _process(_delta: float) -> void:	
	# ถ้า player อยู่ในระยะ, ยังไม่ถูกเก็บ และกดปุ่ม interact
	if player_ref and not is_collected and Input.is_action_just_pressed("interact"):
		interact()	

func interact():
	is_collected = true
	label.hide() # ซ่อนข้อความทันทีที่กดเก็บ
	
	# ตรวจสอบว่าตัวแปร player_ref มีอยู่จริงหรือไม่
	if player_ref:
		# ตรวจสอบว่า player มีตัวแปร item_multiplier ไหม (ถ้าไม่มีให้ใช้ 1 เป็นค่าเริ่มต้น)
		var multiplier = 1
		if "item_multiplier" in player_ref:
			multiplier = player_ref.item_multiplier
		
		# เพิ่มจำนวน Gear ตามตัวคูณ (เช่น 1 * 2 = 2 อัน)
		player_ref.gears_held += (1 * multiplier)
		print("Collected! Current Gears: ", player_ref.gears_held)

	# เล่นเสียงและรอจนจบก่อนลบวัตถุ
	if sound_player_collect_item.stream:
		sound_player_collect_item.play()
		await sound_player_collect_item.finished
	
	queue_free()
		
func _on_body_entered(body):
	# ตรวจสอบว่าเป็น player (แนะนำให้ใช้การเช็คชื่อหรือ Group ให้ตรงกับตัวละคร)
	if body.name == "player" or body.is_in_group("player"):
		player_ref = body
		label.show()

func _on_body_exited(body):
	if body.name == "player" or body.is_in_group("player"):
		player_ref = null
		label.hide()
