extends Control

@onready var end_sound = $end_sound
func _ready() -> void:
	end_sound.play()
func _on_end_sound_finished() -> void:
	# --- 1. จัดการ Label แรก (ข้อความเริ่มต้น) ---
	var tween1 = create_tween()
	tween1.tween_property($first_label, "modulate:a", 0.0, 1.0)
	await tween1.finished
	$first_label.hide()
	
	# --- 2. แสดง Label ที่สอง (ข้อความจบเกม/เนื้อเรื่อง) ---
	$second_label.modulate.a = 0
	$second_label.show()
	var tween2 = create_tween()
	tween2.tween_property($second_label, "modulate:a", 1.0, 1.0)
	
	await get_tree().create_timer(3.0).timeout # โชว์ค้างไว้ 3 วิ
	
	var tween2_out = create_tween()
	tween2_out.tween_property($second_label, "modulate:a", 0.0, 1.0)
	await tween2_out.finished
	$second_label.hide()

	# --- 3. แสดง Label ที่สาม (Credits: คุณ, เพื่อน, และ Pixabay) ---
	$third_label.modulate.a = 0
	$third_label.show()
	
	# ปรับข้อความให้มีชื่อทุกคนและเครดิต (ใช้ \n เพื่อขึ้นบรรทัดใหม่)
	
	
	var tween3 = create_tween()
	tween3.tween_property($third_label, "modulate:a", 1.0, 1.0)
	
	# โชว์ Credits ค้างไว้ 5 วิ ให้คนอ่านทัน
	await get_tree().create_timer(5.0).timeout
	
	# (Optional) จางชื่อออกก่อนจบจริง
	var tween3_out = create_tween()
	tween3_out.tween_property($third_label, "modulate:a", 0.0, 1.0)
	await tween3_out.finished
	
	
	$forth_label.modulate.a = 0
	$forth_label.show()
	
	
	
	var tween4 = create_tween()
	tween4.tween_property($forth_label, "modulate:a", 1.0, 1.0)
	

	await get_tree().create_timer(3.0).timeout
	
	# (Optional) จางชื่อออกก่อนจบจริง
	var tween4_out = create_tween()
	tween4_out.tween_property($forth_label, "modulate:a", 0.0, 1.0)
	await tween4_out.finished
	
	# กลับหน้าเมนูหลัก
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
