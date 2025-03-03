extends Node

var playerPos = Vector2(-9999,1000)
var playerHotbar: Array = [["pistol", 55, 0.6, 1, 0, 0, 2.0, 12, 0.7],[],[],[],[]] # "name", "dmg", "firerate per bullet (in seconds), bullets shot per shot, time between bullets, frame, reload time(sec), max ammo, gun despawn time 
var currentGuns = playerHotbar[0]
var allcurrenthotbarammo : Array = [12,null,null,null,null]
var guigun = preload("res://hotbarGuns.tscn")

var everygun = [
	["pistol", 55, 0.6, 1, 0, 0, 2.0, 12, 0.7],
	["rifle", 20, 0.1, 1, 0, 1, 2.5, 45, 0.3],
]

func _ready() -> void:
	var gunguiinstance = guigun.instantiate()
	$/root/Main/CanvasLayer.add_child(gunguiinstance)
	gunguiinstance.instance(0)
	
