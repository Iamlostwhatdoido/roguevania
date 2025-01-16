tool
extends Node2D

onready var left_sprite := $Left
onready var right_sprite := $Right

export(String, "right", "left") var side setget set_ledge_side

func set_ledge_side(value: String)  -> void:
	side = value
	if value == "right":
		left_sprite.visible = false
		right_sprite.visible = true
	if value == "left":
		left_sprite.visible = true
		right_sprite.visible = false
