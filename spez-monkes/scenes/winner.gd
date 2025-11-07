extends Control

@onready var retry_button = $CanvasLayer/VBoxContainer/Button
@export var main_scene_path: String = "res://scenes/main_game.tscn"
func _ready():
	retry_button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	print("Retry button pressed!")
	# Replace current scene with main game scene
	get_tree().change_scene_to_file(main_scene_path)
