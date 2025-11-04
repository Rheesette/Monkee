extends Area2D

var hp = 3.0
var dmg = 1
var cooldown = .5

@export var speed: float = 50
@export var knockback_force: float = 15
@onready var anim = $anim
var direction: int = -1
var can_move: bool = true

func _ready():
	anim.play("idle")
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	if can_move:
		position.x += speed * direction * delta

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		attack()
		knockback()
		area.damage(dmg)

func attack() -> void:
	can_move = false
	anim.play("attack")
	await anim.animation_finished
	anim.play("idle")
	can_move = true

func knockback():
	position.x += knockback_force

func damage(dmg):
	self.hp -= dmg
	print(self.hp)
	if self.hp <= 0:
		queue_free()
