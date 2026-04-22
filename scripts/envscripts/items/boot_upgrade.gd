extends Area2D


signal speed_boosted(message)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
			body.speed += 150
			speed_boosted.emit("SPEED UP!!")
			$AudioStreamPlayer.play()
			visible = false
			set_deferred("monitoring", false)
			await $AudioStreamPlayer.finished
			queue_free()
