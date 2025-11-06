extends Sprite2D

const EnemyScene = preload("res://scenes/enemy_1.tscn")
const EnemyScene2 = preload("res://scenes/enemy_2.tscn")

# Each wave contains a list of enemies to spawn
var waves = [
	[EnemyScene],                              # Wave 1
	[EnemyScene, EnemyScene],                  # Wave 2
	[EnemyScene, EnemyScene2],                 # Wave 3
	[EnemyScene2, EnemyScene2, EnemyScene],    # Wave 4
	[EnemyScene2, EnemyScene2, EnemyScene2]    # Wave 5
]

var current_wave = 0
var spawning_wave = false
var active_enemies = []   # track all alive enemies

func _ready():
	randomize()
	await get_tree().process_frame
	start_next_wave()

func start_next_wave():
	if spawning_wave:
		return
	
	if current_wave < waves.size():
		current_wave += 1
		print("Wave", current_wave, "started!")
		spawning_wave = true
		await spawn_wave(waves[current_wave - 1])
		spawning_wave = false
	else:
		print("All waves complete!")

func spawn_wave(enemy_list):
	print("Spawning wave with", enemy_list.size(), "enemies")
	for enemy_scene in enemy_list:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = self.position + Vector2(randi_range(-30, 30), 60)
		get_parent().add_child(enemy_instance)
		
		# Connect the enemy's "tree_exited" signal to track when it’s removed
		enemy_instance.tree_exited.connect(_on_enemy_died.bind(enemy_instance))
		
		active_enemies.append(enemy_instance)
		await get_tree().create_timer(0.5).timeout  # delay between spawns

func _on_enemy_died(enemy):
	# When an enemy is removed from the scene tree
	if enemy in active_enemies:
		active_enemies.erase(enemy)

	# If no enemies left, start next wave after short delay
	if active_enemies.is_empty():
		print("Wave", current_wave, "complete!")
		await get_tree().create_timer(3.0).timeout
		start_next_wave()
