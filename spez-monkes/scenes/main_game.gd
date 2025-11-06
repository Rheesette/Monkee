extends Node

const MONKEY_1 = preload("res://scenes/monkey_1.tscn")
const MONKEY_2 = preload("res://scenes/monkey_2.tscn")
@export var spawn_position: Vector2 = Vector2(536, 268)

var coins = 0
var coin_rate = 1
var upgrade_level = 0
var max_upgrades = 4
var upgrade_cost = 10

@onready var coin_label = $coinlabel
@onready var upgrade_button = $PanelContainer/MarginContainer/HSplitContainer/upgradeTower
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
	coins += coin_rate
	coin_label.text = "Coin/s: " + str(coins)

func _update_coin_label():
	coin_label.text = "Coin/s: " + str(coins)

func _update_upgrade_button_text():
	if upgrade_level < max_upgrades:
		upgrade_button.text = "Upgrade Tower: " + str(upgrade_cost) + " Coins"
	else:
		upgrade_button.text = "Tower Maxed"

func _on_upgrade_tower_pressed() -> void:
	if upgrade_level < max_upgrades:
		if coins >= upgrade_cost:
			coins -= upgrade_cost
			upgrade_level += 1
			coin_rate += 1  # increase coins gained per tick
			upgrade_cost *= 2  # cost doubles each upgrade
			_update_coin_label()
			_update_upgrade_button_text()
			print("Tower upgraded! Level:", upgrade_level)
		else:
			print("Not enough coins to upgrade!")
	else:
		print("Tower is already at max level!")
