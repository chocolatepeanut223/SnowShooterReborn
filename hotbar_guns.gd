extends AnimatedSprite2D

var hotbarinline: int = -1

func _ready() -> void:
	pass 


func instance(slot):
	hotbarinline = slot
	animation = Global.playerHotbar[slot][0]
	global_position = Vector2(996 + (60 * slot), 675)

func _process(delta: float) -> void:
	if Global.playerHotbar[hotbarinline] == []:
		queue_free()
