extends Area2D

@export var speed: float = 50
@export var knockback_force: float = 10
var direction: int = -1

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	position.x += speed * direction * delta

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		knockback()

func knockback():
	position.x += knockback_force
