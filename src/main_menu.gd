extends Control

func _ready():
	$NewGameButton.connect("pressed", Callable(self, "_on_new_game_pressed"))
	$OptionsButton.connect("pressed", Callable(self, "_on_options_pressed"))
	$QuitButton.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_new_game_pressed():
	# Change to your main game scene
	GameManager.goto_scene("res://src/main.tscn")

func _on_options_pressed():
	# Implement options menu functionality
	print("Options menu not implemented yet")

func _on_quit_pressed():
	get_tree().quit()
