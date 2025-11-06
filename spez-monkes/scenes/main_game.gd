extends Node

const MONKEY_1 = preload("res://scenes/monkey_1.tscn")
const MONKEY_2 = preload("res://scenes/monkey_2.tscn")
@export var spawn_position: Vector2 = Vector2(536, 268)

var coins = 0
@onready var coin_label = $coinlabel

var gorilla_cost = 5
var monkey_cost = 2

func _on_button_pressed() -> void:
	if coins >= gorilla_cost:
		coins -= gorilla_cost
		var monke_ins = MONKEY_1.instantiate()
		monke_ins.position = spawn_position
		get_parent().add_child(monke_ins)
		_update_coin_label()
	else:
		print("Not enough coins!")

func _on_button_2_pressed() -> void:
	if coins >= monkey_cost:
		coins -= monkey_cost
		var monke_ins = MONKEY_2.instantiate()
		monke_ins.position = spawn_position
		get_parent().add_child(monke_ins)
		_update_coin_label()
	else:
		print("Not enough coins!")


func _on_coin_timeout() -> void:
	coins += 1
	coin_label.text = "Coins/s: " + str(coins)

func _update_coin_label():
	coin_label.text = "Coins: " + str(coins)
