extends Node

const MONKEY_1 = preload("res://scenes/monkey_1.tscn")
const MONKEY_2 = preload("res://scenes/monkey_2.tscn")
@export var spawn_position: Vector2 = Vector2(536, 268)

func _on_button_pressed() -> void:
	var monke_ins = MONKEY_1.instantiate()
	monke_ins.position = spawn_position
	get_parent().add_child(monke_ins)

func _on_button_2_pressed() -> void:
	var monke_ins = MONKEY_2.instantiate()
	monke_ins.position = spawn_position
	get_parent().add_child(monke_ins)
