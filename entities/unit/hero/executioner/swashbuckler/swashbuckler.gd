class_name Swashbuckler
extends Executioner

#initialize stats
func _init():
	life = 8
	soul = 12
	mind = 6
	motors = 13
	muscles = 13

const DAMAGE_AMOUNT = 10  #damage dealt to the enemy

#moonlight: attacks an enemy and teleports to a chosen position
func moonlight(enemy: Unit, target_position: Vector2):
	if not enemy or not target_position:
		print("Moonlight skill could not be used. Enemy or target position missing.")
		return
	
	print("%s uses Moonlight on %s!" % [name, enemy.name])
	
	#deal damage to the enemy
	enemy.take_damage(DAMAGE_AMOUNT, "physical")
	
	#check if the enemy is still alive
	if enemy.health > 0:
		print("%s has %d health remaining." % [enemy.name, enemy.health])
	else:
		print("%s has been defeated!" % enemy.name)

	#teleport to the chosen position
	position = target_position
	print("%s teleports to position %s." % [name, target_position])
