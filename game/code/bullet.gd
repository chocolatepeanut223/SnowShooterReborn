extends Area2D


func _ready() -> void:
	add_to_group("bullets")
	area_entered.connect(self._on_area_entered)
	position = Global.playerPos
	look_at(get_global_mouse_position())
	$BulletDespawn.wait_time = Global.currentGuns[8]
	$BulletDespawn.start()

func _process(delta: float) -> void:
	var direction = Vector2(cos(rotation), sin(rotation))
	global_position += direction * 1200 * delta


func _on_bullet_despawn_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D):
	if area.is_in_group("zombies"):
		queue_free()
