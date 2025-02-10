class_name Gunslinger
extends Unit

#artillery attack method (assumed)
func artillery_attack(target: Unit, damage: int) -> void:
	if target.is_enemy_marked():
		print("%s attacks %s with artillery, ignoring resistance!" % [name, target.name])
		damage += target.get("armor")
	else:
		print("%s attacks %s with artillery!" % [name, target.name])

	target.take_damage(damage, "artillery")

#escape: fires a weak close-range attack at nearby enemies and then escapes.
func escape(nearest_enemies: Array):
	if nearest_enemies.size() == 0:
		print("No nearby enemies to shoot at for Escape.")
		return

	print("%s uses Escape! Attacking enemies up close and then escaping." % [name])

	#damage to nearby enemies
	for enemy in nearest_enemies:
		if enemy:
			var damage = calculate_escape_damage()
			enemy.take_damage(damage, "Escape Shot")
			print("%s takes %d damage from the Escape shot." % [enemy.name, damage])

	#move the gunslinger to a safer position (escape)
	escape_movement()

func calculate_escape_damage() -> int:
	return 10

#move the gunslinger to a safer position after the attack
func escape_movement():
	var escape_position = get_escape_position()
	self.position = escape_position
	print("%s escapes to a safer position." % [name])

#example method to determine the escape position (modify as needed)
func get_escape_position() -> Vector2:
	return self.position + Vector2(100, 0)  #example: Move 100 pixels to the right

# Variable to track the bomb position
var bomb_position: Vector2 = Vector2.ZERO  # Initialize with a default position

#bomb: plants a bomb at a specified position that deals artillery damage to enemies that pass over it
func plant_bomb(position: Vector2):
	bomb_position = position
	print("%s plants a bomb at position: %s" % [name, bomb_position])

func check_bomb_damage(enemy: Unit):
	if enemy.position.distance_to(bomb_position) < 50:  #adjust the range for triggering the bomb
		var damage = calculate_bomb_damage()
		enemy.take_damage(damage, "Artillery Bomb")
		print("%s takes %d artillery damage from the bomb!" % [enemy.name, damage])

#this method calculates the bomb's artillery damage
func calculate_bomb_damage() -> int:
	return 30

func on_enemy_turn_start(enemy: Unit):
	check_bomb_damage(enemy)
