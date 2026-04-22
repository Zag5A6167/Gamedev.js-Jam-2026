extends StaticBody2D 

var player_entered = false

func _ready() -> void:
	# ตรวจสอบก่อนว่าสัญญาณ body_entered เชื่อมต่อหรือยัง ถ้ายังค่อยสั่ง connect
	if not $tree_interact.body_entered.is_connected(_on_player_enter):
		$tree_interact.body_entered.connect(_on_player_enter)
	
	if not $tree_interact.body_exited.is_connected(_on_player_exit):
		$tree_interact.body_exited.connect(_on_player_exit)
	
	if not $tree_interact.input_event.is_connected(_on_tree_interact_input_event):
		$tree_interact.input_event.connect(_on_tree_interact_input_event)
	
	$tree_interact.input_pickable = true

func _on_player_enter(body):
	if body.name == "player":
		print("Entered")
		player_entered = true

func _on_player_exit(body):
	if body.name == "player":
		player_entered = false



func _on_tree_interact_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if player_entered:
			$AnimationPlayer.play("is_atk")
		
