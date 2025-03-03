extends Node2D

var bullet = preload("res://game/scenes/bullet.tscn")
var normal_zombie = preload("res://game/scenes/NormalZombie.tscn")
var firerate_timer : Timer
var can_shoot : bool = true
var ammo_in_mag = 12
var reloading : bool = false
var hotbarslot = 0
var reloade : Timer
var shootingCurrently = false
signal reload

func _ready() -> void:
	reloade = Timer.new()
	$ZombieSpawntime.start()
	firerate_timer = Timer.new()
	firerate_timer.wait_time = Global.currentGuns[2]
	firerate_timer.one_shot = true
	firerate_timer.timeout.connect(self._on_shoot_timer_timeout)
	add_child(firerate_timer)
	add_child(reloade)
	reloade.timeout.connect(self._on_reload)
	$CanvasLayer/SelectedGun.global_position = Vector2(987,677)

	
func _process(_delta: float) -> void:
	if shootingCurrently == true and reloading == false and ammo_in_mag > 0 and can_shoot:
		can_shoot = false
		firerate_timer.start()
		var bullet_instance = bullet.instantiate()
		add_child(bullet_instance)
		var node = get_node("player/" + Global.currentGuns[0])
		node.play()
		ammo_in_mag -= 1
		$CanvasLayer/Control/Label.text = "Ammo: " + str(ammo_in_mag)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("leftclick"):
		shootingCurrently = true
	elif Input.is_action_just_released("leftclick"):
		shootingCurrently = false
	else:
		if Input.is_action_just_pressed("Reload") and ammo_in_mag < Global.currentGuns[7] and reloading == false:
			reload.emit()
			$player/reload.play()
			reloading = true
			reloade.one_shot = true
			reloade.wait_time = Global.currentGuns[6]
			reloade.start()
	
	if Input.is_action_just_pressed("hotbar1") and Global.playerHotbar[0]:
		if hotbarslot != 0:
			Global.allcurrenthotbarammo[hotbarslot] = ammo_in_mag
			hotbarslot = 0
			reloade.stop()
			reloading = false
			Global.currentGuns = Global.playerHotbar[0]
			_on_gun_switch()
	elif Input.is_action_just_pressed("hotbar2") and Global.playerHotbar[1]:
		if hotbarslot != 1:
			Global.allcurrenthotbarammo[hotbarslot] = ammo_in_mag
			hotbarslot = 1
			reloade.stop()
			reloading = false
			Global.currentGuns = Global.playerHotbar[1]
			_on_gun_switch()
	elif Input.is_action_just_pressed("hotbar3") and Global.playerHotbar[2]:
		if hotbarslot != 2:
			Global.allcurrenthotbarammo[hotbarslot] = ammo_in_mag
			hotbarslot = 2
			reloade.stop()
			reloading = false
			Global.currentGuns = Global.playerHotbar[2]
			_on_gun_switch()
	elif Input.is_action_just_pressed("hotbar4") and Global.playerHotbar[3]:
		if hotbarslot != 3:
			Global.allcurrenthotbarammo[hotbarslot] = ammo_in_mag
			hotbarslot = 3
			reloade.stop()
			reloading = false
			Global.currentGuns = Global.playerHotbar[3]
			_on_gun_switch()
	elif Input.is_action_just_pressed("hotbar5") and Global.playerHotbar[4]:
		if hotbarslot != 4:
			Global.allcurrenthotbarammo[hotbarslot] = ammo_in_mag
			hotbarslot = 4
			reloade.stop()
			reloading = false
			Global.currentGuns = Global.playerHotbar[4]
			_on_gun_switch()
			
	if Input.is_action_just_pressed("trash"):
		var totalGuns : int = 0
		for j in range(Global.playerHotbar.size()):
			if Global.playerHotbar[j] != []:
				totalGuns += 1
		if totalGuns > 1:
			Global.playerHotbar[hotbarslot] = []
			Global.allcurrenthotbarammo[hotbarslot] = null
			print(Global.playerHotbar)
			for i in range(Global.playerHotbar.size()):
				if Global.playerHotbar[i] != []:
					hotbarslot = i
					reloade.stop()
					reloading = false
					Global.currentGuns = Global.playerHotbar[i]
					_on_gun_switch()
					return
		else:
			print("you can't trash your last gun")

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_reload():
	ammo_in_mag = Global.currentGuns[7]
	$CanvasLayer/Control/Label.text = "Ammo: " + str(ammo_in_mag)
	reloading = false


func spawn_zombie():
	var normal_zomb_instance = normal_zombie.instantiate()
	var pos = Vector2.ZERO
	while (pos.x > -600 and pos.x < 600) and (pos.y < 480 and pos.y > -480):
		pos = Vector2(randi_range(-800, 800), randi_range(-700, 700))
	normal_zomb_instance.global_position = pos
	add_child(normal_zomb_instance)


func _on_zombie_spawntime_timeout() -> void:
	spawn_zombie()
	$ZombieSpawntime.wait_time = randf_range(1.5, 3.0)
	$ZombieSpawntime.start()

func _on_gun_switch() -> void:
	ammo_in_mag = Global.allcurrenthotbarammo[hotbarslot]
	firerate_timer.wait_time = Global.currentGuns[2]
	$CanvasLayer/Control/Label.text = "Ammo: " + str(ammo_in_mag)
	reloade.wait_time = Global.currentGuns[6]
	$CanvasLayer/SelectedGun.global_position = Vector2(987 + (60 * hotbarslot), 677)
