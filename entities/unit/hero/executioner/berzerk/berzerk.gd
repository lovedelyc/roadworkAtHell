class_name Berzerk
extends Executioner


const DAMAGE_PERCENTAGE = 0.15  # 15% of the enemy's max health


# Initialize stats
func _init():
	life = 12
	soul = 10
	mind = 3
	motors = 13
	muscles = 14


# The world: deals percentage-based damage to the enemy
func the_world(enemy: Unit):
	if not enemy:
		print("THE WORLD skill could not be used. No enemy selected.")
		return
	
	print("%s uses THE WORLD on %s!" % [name, enemy.name])
	
	# Calculate damage based on the enemy's maximum health
	var damage = int(enemy.max_health * DAMAGE_PERCENTAGE)
	print("Calculated damage: %d" % damage)
	
	# Apply damage to the enemy
	enemy.take_damage(damage, "physical")
	
	# Check enemy's remaining health
	if enemy.health > 0:
		print("%s has %d health remaining." % [enemy.name, enemy.health])
	else:
		print("%s has been defeated!" % enemy.name)
