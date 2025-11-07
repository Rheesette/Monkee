extends Area2D

var hp = 15
var dmg = 10
var cooldown = .5

@export var speed: float = 50
@export var knockback_force: float = 15
var direction: int = -1
var can_move: bool = true

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	if can_move:
		position.x += speed * direction * delta

func _on_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("tower"):
		attack()
		knockback()
		area.damage(dmg)

func attack() -> void:
	var aud = $AudioStreamPlayer2D
	can_move = false
	aud.play()
	await aud.finished  # wait until the audio finishes
	can_move = true


func knockback():
	position.x += knockback_force

func damage(dmg):
	self.hp -= dmg
	if self.hp <= 0:
		queue_free()
