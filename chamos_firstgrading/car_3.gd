extends CharacterBody2D

@export var max_speed: float = 2.0     # 💤 barely moving
@export var acceleration: float = 1.0  # crawls to its top speed

var velocity_vec := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var forward_vec := Vector2.UP.rotated(rotation)
	velocity_vec = velocity_vec.move_toward(forward_vec * max_speed, acceleration * delta)

	velocity = velocity_vec
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is StaticBody2D:
			velocity_vec = Vector2.ZERO
