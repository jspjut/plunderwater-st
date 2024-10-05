extends CharacterBody2D


@export var speed = 100.0
var direction = Vector2.RIGHT

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Main").call("_on_player_hit")

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()
	
	# Change direction if hitting a wall
	if is_on_wall():
		direction *= -1
