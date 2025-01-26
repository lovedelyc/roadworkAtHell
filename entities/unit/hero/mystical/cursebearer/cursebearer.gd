class_name Cursebearer
extends Mystical


# Constants for cursing skill
const DAMAGE_PER_TURN = 3
const POISON_TURNS = 5
const SKILL_RANGE = 3


# Initialize stats
func _init():
	life = 8
	soul = 14
	mind = 14
	motors = 6
	muscles = 8


# Cursing skill: explodes a skull, poisoning nearby enemies
func cursing(enemies_in_range: Array[Unit]):
	if enemies_in_range.size() == 0:
		print("No enemies in range to poison with Cursing.")
		return
	
	print("%s uses Cursing!" % name)
	
	for enemy in enemies_in_range:
		# Apply poison effect
		apply_poison(enemy)


# Apply poison effect to an enemy
func apply_poison(enemy: Unit):
	print("%s is poisoned for %d damage for %d turns!" % [enemy.name, DAMAGE_PER_TURN, POISON_TURNS])
	
	# Add poison damage over time to the enemy
	enemy.add_status_effect("poison", POISON_TURNS, func(turn_count):
		if turn_count > 0:
			enemy.take_damage(DAMAGE_PER_TURN, "physical")
			print("%s takes %d physical damage from poison. %d turns remaining." % [enemy.name, DAMAGE_PER_TURN, turn_count])
		else:
			print("%s is no longer poisoned." % enemy.name)
	)
