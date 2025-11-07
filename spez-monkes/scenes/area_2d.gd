extends Area2D

signal tower_destroyed
var hp = 10
@onready var hp_label = $Label  # make sure a Label node is a child of this tower

func _ready():
	update_hp_label()

func damage(dmg):
	hp -= dmg
	update_hp_label()

	if hp <= 0:
		tower_destroyed.emit()
		queue_free()

func update_hp_label():
	hp_label.text = "Health: %d" % hp
