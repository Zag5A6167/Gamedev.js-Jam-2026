extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Boom!")
		$AudioStreamPlayer.play()
		
		if body.has_method("set_physics_process"):
			body.set_physics_process(false) 
		
	
		var tween = create_tween().set_loops()
		
		var spin_speed = 0.2
		var rotation_amount = PI * 2 
		

		tween.tween_property(body, "rotation", body.rotation + rotation_amount, spin_speed) \
			.set_trans(Tween.TRANS_LINEAR) 

		
		var fly_tween = create_tween()
		fly_tween.tween_property(body, "position:y", body.position.y - 100000, 10.0)
