extends Area2D

signal collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected")
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
