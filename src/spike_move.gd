extends CharacterBody2D


@export var speed = 100.0
var direction = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()
	
	# Change direction if hitting a wall
	if is_on_wall():
		direction *= -1
