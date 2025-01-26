class_name Brigadier
extends Executioner


const DAMAGE_AMOUNT = 20  # Damage dealt to the enemy
const INCAPACITATED_DURATION = 1  # Number of turns the enemy is incapacitated


# Initialize stats
func _init():
	life = 13
	soul = 8
	mind = 5
	motors = 11
	muscles = 15


# Chainsaw: attacks with a chainsaw and incapacitates the enemy
func chainsaw(enemy: Unit):
	if not enemy:
		print("CHAINSAW skill could not be used. No enemy selected.")
		return
	
	print("%s uses CHAINSAW on %s!" % [name, enemy.name])
	
	# Deal damage to the enemy
	enemy.take_damage(DAMAGE_AMOUNT, "physical")
	
	# Apply incapacitated status effect
	if not enemy.has_method("apply_status_effect"):
		print("The selected enemy does not support status effects.")
		return
	
	enemy.apply_status_effect("incapacitated", INCAPACITATED_DURATION)
	print("%s is now incapacitated and cannot deal melee damage for %d turn(s)." % [enemy.name, INCAPACITATED_DURATION])
