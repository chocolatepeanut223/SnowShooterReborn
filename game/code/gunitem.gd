extends Area2D

var gunitem = load("res://game/scenes/Gunitem.tscn")
var player_near : bool = false
var gunsChance : Dictionary = {
"pistol" : 50,
"rifle" : 50,
}

func _ready():
	pass

func instance(pos):
	var guninstance = gunitem.instantiate()
	guninstance.global_position = pos
	get_node("/root/Main").call_deferred("add_child", guninstance)
	guninstance.get_child(1).animation = chance()

	var despawn = Timer.new()
	despawn.wait_time = 8
	despawn.autostart = false
	despawn.one_shot = true
	guninstance.add_child(despawn)
	despawn.timeout.connect(guninstance._on_despawn.bind(guninstance))
	despawn.call_deferred("start")

func chance():
	var sum : int = 0
	for value in gunsChance.values():
		sum += value  # Correct way to sum values
	var acc : int = 0
	var picked = null
	var rand = randf_range(0, sum)  # Generate random value only once
	for key in gunsChance.keys():
		acc += gunsChance[key]  # Correct way to accumulate probabilities
		if rand <= acc:
			picked = key
			break
	return picked

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		player_near = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		player_near = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup") and player_near:
		add_gun($Sprite2D.animation)

func add_gun(gun):
	for i in range(Global.everygun.size()):
		if gun == Global.everygun[i][0]:
			var slottedgun = Global.everygun[i]
			for j in range(Global.playerHotbar.size()):
				if Global.playerHotbar[j] == []:
					Global.playerHotbar[j] = slottedgun
					Global.allcurrenthotbarammo[j] = slottedgun[7]
					var gunguiinstance = Global.guigun.instantiate()
					$/root/Main/CanvasLayer.add_child(gunguiinstance)
					gunguiinstance.instance(j)
					queue_free()
					return
			print("inventory full")

func _on_despawn(timer):
	queue_free()
	timer.queue_free()
