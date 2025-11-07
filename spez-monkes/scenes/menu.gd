extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")


func _on_shop_pressed() -> void:
	print("START232")


func _on_exit_pressed() -> void:
	get_tree().quit()
