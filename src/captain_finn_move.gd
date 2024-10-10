extends CharacterBody2D


@export var speed = 400.0
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	if velocity.length() > 0:
		animated_sprite.play("swim")
		# Flip sprite based on movement direction
		animated_sprite.flip_h = velocity.x < 0
	else:
		animated_sprite.play("idle")
	
	move_and_slide()

	# Clamp position to level bounds
	position.x = clamp(position.x, 0, 5000)
	position.y = clamp(position.y, 0, 5000)
