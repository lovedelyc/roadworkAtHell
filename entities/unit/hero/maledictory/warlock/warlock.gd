class_name Warlock
extends Maledictory

#initialize stats
func _init():
	life = 10
	soul = 12
	mind = 11
	motors = 4
	muscles = 9

#dictionary to track cursed enemies and their remaining turns
var cursed_enemies: Dictionary = {}

#pierce skill: curse an enemy to stay in place for 2 turns, taking true damage if they move
func pierce(enemy):
	#ensure the enemy is not already cursed
	if cursed_enemies.has(enemy):
		print("%s is already cursed by Pierce!" % enemy.name)
		return

	#apply the curse
	cursed_enemies[enemy] = 2  #curse duration in turns
	print("%s is cursed by the Warlock's Pierce! They cannot move for 2 turns without taking damage." % enemy.name)

#check and apply pierce effect when the enemy attempts to move
func on_enemy_move(enemy, attempted_distance):
	if cursed_enemies.has(enemy):
		if cursed_enemies[enemy] > 0:
			#prevent movement
			print("%s is cursed and cannot move!" % enemy.name)
			return false
		else:
			#allow movement but inflict true damage for each tile moved
			var true_damage = attempted_distance
			enemy.take_damage(true_damage, "true")
			print("%s moves but suffers %d true damage from the curse!" % [enemy.name, true_damage])
	return true

#called at the end of each turn to reduce curse duration
func on_turn_end():
	for enemy in cursed_enemies.keys():
		cursed_enemies[enemy] -= 1
		if cursed_enemies[enemy] <= 0:
			print("The curse on %s has ended." % enemy.name)
			cursed_enemies.erase(enemy)
