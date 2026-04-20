extends Area2D

@onready var label = $InteractionLabel
var player_ref = null # ใช้เก็บค่า Player แทนแค่สถานะ true/false

func _ready() -> void:
	label.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:    
	if player_ref and Input.is_action_just_pressed("interact"):
		interact()    

func interact():
	# มอบบัฟคูณ 2 ให้ผู้เล่นถาวร
	player_ref.item_multiplier = 2
	print("Buff Activated: Double Items!")
	
	# ลบไอเท็มบัฟนี้ออก
	queue_free()

func _on_body_entered(body):
	if body.name == "player":
		player_ref = body # เก็บค่า body ไว้เพื่อให้เข้าถึงตัวแปรใน player ได้
		label.show()

func _on_body_exited(body):
	if body.name == "player":
		player_ref = null
		label.hide()
		
