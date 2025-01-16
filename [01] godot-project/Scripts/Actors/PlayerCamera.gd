extends Node2D

onready var player := get_parent()

export var cam_speed := 48
export var y_level = 32
export var look_distant := 64


var right := Vector2(look_distant,0 -y_level)
var left := Vector2(-look_distant,0-y_level)
var up := Vector2(0,-look_distant-y_level)
var down := Vector2(0,look_distant-y_level)

var aim := right

func _physics_process(delta: float) -> void:
	if player.facing == "right" and aim != right:
		aim = right
	if player.facing == "left" and aim != left:
		aim = left
	if player.looking == "up" and aim != up:
		aim = up
	if player.looking == "down" and aim != down:
		aim = down
	
	
	var diff = aim - position
	
	if abs(diff.length()) > float(look_distant)/2:
		position += diff*cam_speed/32*delta
	elif abs(diff.length())>1:
		position += diff.normalized()*cam_speed*delta
	else:
		position = aim
	$Camera2D.align()
		
