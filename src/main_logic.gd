extends Node2D

var score = 0

func _ready():
	for treasure in get_tree().get_nodes_in_group("treasure"):
		treasure.connect("collected", Callable(self, "_on_treasure_collected"))

func _on_treasure_collected():
	score += 1
	print("Score: ", score)

func _on_player_hit():
	print("Game Over!")
	# Implement game over logic here
