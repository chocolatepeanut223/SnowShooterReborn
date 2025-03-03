extends CharacterBody2D

var bullet = preload("res://game/scenes/bullet.tscn")
var speed = 5500.0

func _ready() -> void:
	add_to_group("players")
	$AnimatedSprite2D.frame = Global.currentGuns[5]

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity.y = -1
	if Input.is_action_pressed("down"):
		velocity.y = 1
	if Input.is_action_pressed("right"):
		velocity.x = 1
	if Input.is_action_pressed("left"):
		velocity.x = -1
	velocity = velocity.normalized() * speed * delta
	move_and_slide()
	Global.playerPos = get_child(3).global_position 

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	$AnimatedSprite2D.animation = Global.currentGuns[0]


func _on_node_2d_reload() -> void:
	var gun = get_node("AnimatedSprite2D")
	gun.position.x -= 3
	$gunrecoil.wait_time = 2.0
	$gunrecoil.start()

func _on_gunrecoil_timeout() -> void:
	var gun = get_node("AnimatedSprite2D")
	gun.position.x += 3
