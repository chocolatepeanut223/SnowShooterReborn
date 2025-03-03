extends Area2D

signal shot

func _ready():
	add_to_group("zombies")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		shot.emit()
