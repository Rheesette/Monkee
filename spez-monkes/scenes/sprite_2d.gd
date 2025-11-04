extends Sprite2D

const EnemyScene = preload("res://scenes/enemy_1.tscn")

func _on_timer_timeout() -> void:
	var enemy_instance = EnemyScene.instantiate()
	enemy_instance.position = self.position + Vector2(0,60)
	get_parent().add_child(enemy_instance)
