extends Area2D


var is_exploded = false

func _on_body_entered(body: Node2D) -> void:

	if not body.is_in_group("player") or is_exploded:
		return
	
	
	is_exploded = true

	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

	print("Boom!")
	if has_node("AudioStreamPlayer"):
		$AudioStreamPlayer.play()
	
	if body.has_method("set_physics_process"):
		body.set_physics_process(false) 
	

	var spin_tween = create_tween().set_loops()
	spin_tween.tween_property(body, "rotation", body.rotation + (PI * 2), 0.2).set_trans(Tween.TRANS_LINEAR) 

	var fly_tween = create_tween()
	fly_tween.tween_property(body, "position:y", body.position.y - 100000, 10.0)
	

	await get_tree().create_timer(3.0).timeout
	
	
	if is_inside_tree() and get_tree() != null:
		get_tree().reload_current_scene()
