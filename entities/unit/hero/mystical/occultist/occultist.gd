class_name Occultist
extends Mystical


# Constants for shadowstrike skill
const DAMAGE_PER_TURN = 4
const DAMAGE_TURNS = 3
const MOVEMENT_REDUCTION_FACTOR = 0.5


# Initialize stats
func _init():
	life = 7
	soul = 13
	mind = 15
	motors = 9
	muscles = 6


# Shadowstrike: halves the enemy's movement range and applies psychic damage over time
func shadowstrike(enemy: Unit):
	if not enemy:
		print("No enemy selected for Shadowstrike.")
		return
	
	print("%s uses Shadowstrike on %s!" % [name, enemy.name])
	
	# Halve the enemy's movement range
	if enemy.has("movement_range"):
		enemy.movement_range = int(enemy.movement_range * MOVEMENT_REDUCTION_FACTOR)
		print("%s's movement range is reduced to %d!" % [enemy.name, enemy.movement_range])
	
	# Apply psychic damage over time
	apply_psychic_damage(enemy)


# Apply psychic damage over time
func apply_psychic_damage(enemy: Unit):
	print("%s takes %d psychic damage for %d turns!" % [enemy.name, DAMAGE_PER_TURN, DAMAGE_TURNS])
	
	enemy.add_status_effect("psychic_damage", DAMAGE_TURNS, func(turn_count):
		if turn_count > 0:
			enemy.take_damage(DAMAGE_PER_TURN, "psychic")
			print("%s takes %d psychic damage. %d turns remaining." % [enemy.name, DAMAGE_PER_TURN, turn_count])
		else:
			print("%s is no longer taking psychic damage." % enemy.name)
	)
