extends CharacterBody2D

@export var max_speed: float = 100.0       # slower top speed
@export var reverse_speed: float = 25.0   # slower reverse
@export var acceleration: float = 80.0    # slower build-up
@export var friction: float = 180.0        # stops faster
@export var turn_speed_deg: float = 20.0  # less sharp turning

var velocity_vec := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var move_dir := 0.0
	if Input.is_action_pressed("up"):
		move_dir = 1.0
	elif Input.is_action_pressed("down"):
		move_dir = -1.0

	var turn_dir := 0.0
	if Input.is_action_pressed("left"):
		turn_dir -= 1.0
	if Input.is_action_pressed("right"):
		turn_dir += 1.0

	# rotate car
	rotation += deg_to_rad(turn_dir * turn_speed_deg * delta)

	# forward/backward vector
	var forward_vec := Vector2.UP.rotated(rotation)

	if move_dir > 0.0:
		velocity_vec = velocity_vec.move_toward(forward_vec * max_speed, acceleration * delta)
	elif move_dir < 0.0:
		velocity_vec = velocity_vec.move_toward(forward_vec * -reverse_speed, acceleration * delta)
	else:
		velocity_vec = velocity_vec.move_toward(Vector2.ZERO, friction * delta)

	velocity = velocity_vec
	move_and_slide()

	# 🚧 Collision detection
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is StaticBody2D:
			print("💥 Car hit a wall at: ", collision.get_position())
			velocity_vec = Vector2.ZERO
