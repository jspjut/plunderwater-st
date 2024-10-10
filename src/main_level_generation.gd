extends Node2D


var level_width = 5000  # Adjust as needed
var level_height = 5000
var num_treasures = 100
var num_spikes = 50

@onready var tile_map_layer = $TileMapLayer
@onready var tile_set = tile_map_layer.tile_set

var tile_size: Vector2i
var tiles_wide: int
var tiles_high: int

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
	
	# Populate the tileMap
	fill_tile_map_layer()
	
func fill_tile_map_layer():
	var source_id = 0  # Assume the first source has ID 0
	var source = tile_set.get_source(source_id)
	
	#Not sure why this seems to take forever to run...
	#if source is TileSetAtlasSource:
		#var atlas_source = source as TileSetAtlasSource
		#for y in range(tiles_high):
			#for x in range(tiles_wide):
				#var random_coords = get_random_tile_coords(atlas_source)
				#if random_coords != Vector2i(-1, -1):
					#tile_map_layer.set_cell(Vector2i(x, y), source_id, random_coords)

func get_random_tile_coords(atlas_source: TileSetAtlasSource) -> Vector2i:
	var valid_coords = []
	for x in range(atlas_source.get_atlas_grid_size().x):
		for y in range(atlas_source.get_atlas_grid_size().y):
			if atlas_source.get_tile_at_coords(Vector2i(x, y)):
				valid_coords.append(Vector2i(x, y))
	
	if valid_coords.size() > 0:
		return valid_coords[randi() % valid_coords.size()]
	return Vector2i(-1, -1)  # Return invalid coords if no tiles found
	
func setup_camera(player):
	var camera = Camera2D.new()
	camera.make_current()
	player.add_child(camera)
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_size = tile_set.tile_size
	tiles_wide = level_width / tile_size.x
	tiles_high = level_height / tile_size.y
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
