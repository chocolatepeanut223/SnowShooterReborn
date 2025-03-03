extends CharacterBody2D

var player
var speed = 35 * 55
var health = 100
var gun_drop = preload("res://game/scenes/Gunitem.tscn")

func _ready() -> void:
	visible = true
	
func _physics_process(delta: float) -> void:
	player = get_parent().get_child(1)
	look_at(player.global_position)
	var direction = player.global_position - global_position
	direction = direction.normalized() * speed * delta
	velocity = direction
	move_and_slide()


func _on_area_2d_shot() -> void:
	health -= Global.currentGuns[1]
	if health < 1:
		var random = randi_range(0, 100)
		if random > 0:
			Gunitem.instance(global_position)
		queue_free()
