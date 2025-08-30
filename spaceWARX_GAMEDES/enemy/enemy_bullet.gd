extends Area2D
class_name EnemyBullet

@export var speed := 1000
@export var damage := 15
@export var disabled := true   # 🔴 set true to disable completely

var direction := Vector2.ZERO

func start(_pos: Vector2, _dir: Vector2) -> void:
	if disabled:
		hide()
		set_process(false)
		return
	position = _pos
	rotation = _dir.angle()
	direction = _dir.normalized()

func _process(delta: float) -> void:
	if disabled: return
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if disabled: return
	if body.name == "Player":
		if "shield" in body:
			body.shield -= damage
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
