extends Actor

onready var sprite := $Sprite

export var speed := 160
export var jump_impulse := 350
export(String, "right", "left") var facing 
export(String, "null", "up", "down") var looking 


func _physics_process(_delta: float) -> void:
	var direction := get_direction()
	
	update_art()
	
	velocity = calculate_velocity(velocity,direction)
	velocity = move_and_slide(velocity, Vector2.UP)


func get_direction()-> Vector2:
	var can_jump = is_on_floor()
	var is_jumping = Input.is_action_pressed("jump") and can_jump
	return Vector2(
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
		-1.0 if is_jumping else 0.0
	)


func calculate_velocity(
		velocity : Vector2,
		direction : Vector2
	) -> Vector2:
	
	var out = velocity
	out.x = speed * direction.x
	out.y += gravity*get_physics_process_delta_time()
	if direction.y == -1:
		out.y = jump_impulse * direction.y
		print(jump_impulse)
	out.y = clamp(out.y, -jump_impulse , jump_impulse)
	return out

func update_art() -> void:
	var delta : float = get_physics_process_delta_time()

	if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("look_right"):
		self.facing = "right"
		sprite.flip_h = false
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("look_left"):
		self.facing = "left"
		sprite.flip_h = true
		
	if Input.is_action_pressed("look_up") and !Input.is_action_pressed("look_down"):
		self.looking = "up"
	if !Input.is_action_pressed("look_up") and Input.is_action_pressed("look_down"):
		self.looking = "down"
	if !Input.is_action_pressed("look_up") and !Input.is_action_pressed("look_down"):
		self.looking = "null"
