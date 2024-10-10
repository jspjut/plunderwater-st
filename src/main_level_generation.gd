extends Node2D


var level_width = 5000  # Adjust as needed
var level_height = 5000
var num_treasures = 100
var num_spikes = 50

var score = 0

var treasure_scene = preload("res://src/treasure.tscn")
var spike_scene = preload("res://src/spike.tscn")
var player_scene = preload("res://src/captain_finn.tscn")

var start_position
var end_position

func random_position():
	return Vector2(
		randf_range(0, level_width),
		randf_range(0, level_height)
	)
	
func generate_level():
	# Set start and end positions
	start_position = Vector2(100, 100)
	end_position = Vector2(level_width - 100, level_height - 100)
	
	# Spawn player
	var player = player_scene.instantiate()
	player.position = start_position
	add_child(player)
	
	# Spawn treasures
	for i in range(num_treasures):
		var treasure = treasure_scene.instantiate()
		treasure.position = random_position()
		add_child(treasure)
	
	# Spawn spikes (enemies)
	for i in range(num_spikes):
		var spike = spike_scene.instantiate()
		spike.position = random_position()
		add_child(spike)
	
	# Create end point (you might want to use a specific scene for this)
	var end_point = ColorRect.new()
	end_point.color = Color.GREEN
	end_point.size = Vector2(50, 50)
	end_point.position = end_position
	add_child(end_point)
	
func setup_camera(player):
	var camera = Camera2D.new()
	camera.make_current()
	player.add_child(camera)
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_level()
	var player = get_node("Captain Finn/CharacterBody2D")  # Adjust the path as needed
	setup_camera(player)
	for treasure in get_tree().get_nodes_in_group("treasure"):
		treasure.connect("collected", Callable(self, "_on_treasure_collected"))

func _on_treasure_collected():
	score += 1
	print("Score: ", score)

func _on_player_hit():
	print("Game Over!")
	# Implement game over logic here

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_node("Captain Finn/CharacterBody2D")  # Adjust the path as needed
	if player.position.distance_to(end_position) < 50:
		print("Level Complete!")
		# Here you would implement logic to move to the next level
