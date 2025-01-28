class_name Worker
extends Bruteforce

#initialize stats
func _init():
	life = 11
	soul = 9
	mind = 2
	motors = 11
	muscles = 17

#freight train: hits all enemies in a straight line, damage increases by 1 for each enemy hit
func freight_train(target_position: Vector2, base_damage: int):
	#get all enemies in the game or in the relevant range
	var enemies_in_line: Array = get_enemies_in_line(target_position)

	var damage = base_damage
	var enemies_hit = 0
	
	#iterate through each enemy and apply the damage
	for enemy in enemies_in_line:
		#apply the damage to each enemy
		if enemy:
			enemy.take_damage(damage, "physical")  #assuming "physical" is the damage type
			damage += 1  #increase damage for the next enemy
			enemies_hit += 1
	
	#nNotify about the outcome of the attack
	print("%s uses Freight Train and hits %d enemies in a straight line!" % [name, enemies_hit])

#helper function to detect enemies in the line of attack
func get_enemies_in_line(target_position: Vector2) -> Array:
	var enemies_in_line: Array = []
	var direction = (target_position - position).normalized()
	var distance = position.distance_to(target_position)
	
	#check each enemy in the game to see if they are in the line
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy is Unit and is_enemy_in_line(enemy, direction, distance):
			enemies_in_line.append(enemy)
	
	return enemies_in_line

#helper function to check if an enemy is in the line of attack
func is_enemy_in_line(enemy: Unit, direction: Vector2, max_distance: float) -> bool:
	var distance_to_enemy = position.distance_to(enemy.position)
	
	#check if the enemy is within the line of attack range and within a straight line
	if distance_to_enemy <= max_distance:
		var enemy_direction = (enemy.position - position).normalized()
		if direction.angle_to(enemy_direction) < 0.1:  #allow a small margin for error
			return true
	
	return false
