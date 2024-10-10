extends CharacterBody2D


@export var speed = 400.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	# Clamp position to level bounds
	position.x = clamp(position.x, 0, 5000)
	position.y = clamp(position.y, 0, 5000)
