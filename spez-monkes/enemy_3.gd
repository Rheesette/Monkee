extends Area2D

var hp = 10
var dmg = 4
var cooldown = 0.5
@onready var anim = $Sprite2D

const ENEMY_3_ATTACK = preload("res://scenes/enemy_3_attack.tscn")

@export var speed: float = 50
@export var knockback_force: float = 15
var direction: int = 1
var can_move: bool = true

func _ready():
	anim.play("idle")
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	if can_move:
		position.x += speed * direction * delta

func _on_area_entered(area):
	if (area.is_in_group("team") or area.is_in_group("monketower")) and can_move:
		attack(area)

func attack(area):
	can_move = false

	# Spawn attack animation
	var atk = ENEMY_3_ATTACK.instantiate()
	var atk_anim = atk.get_node("AnimatedSprite2D")
	atk.position = self.position + Vector2(20 * direction, 0)
	get_parent().add_child(atk)
	$AudioStreamPlayer2D.play()
	atk_anim.play()

	# Let the animation remove itself when finished
	atk_anim.connect("animation_finished", Callable(atk, "queue_free"))

	# Deal damage and knockback
	area.damage(dmg)
	knockback()

	# Cooldown before next attack
	await get_tree().create_timer(cooldown).timeout
	can_move = true

func knockback():
	position.x -= knockback_force * direction

func damage(dmg):
	hp -= dmg
	if hp <= 0:
		queue_free()
