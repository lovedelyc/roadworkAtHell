class_name Shaman
extends Mystical

#initialize stats
func _init():
	life = 10
	soul = 10
	mind = 13
	motors = 8
	muscles = 9

#constants for scythe skill
const MAGIC_DAMAGE = 10
const BLEED_DAMAGE = 2
const BLEED_TURNS = 3

#scythe: devastating magical attack and applies bleed effect
func scythe(enemies_in_front: Array[Unit]):
	if enemies_in_front.empty():
		print("No enemies in front to attack with Scythe.")
		return

	print("%s uses Scythe!" % name)

	for enemy in enemies_in_front:
		#apply magic damage
		enemy.take_damage(MAGIC_DAMAGE, "magic")

		#apply bleed effect
		apply_bleed(enemy)

#apply bleed effect to an enemy
func apply_bleed(enemy: Unit):
	print("%s is bleeding for %d damage for %d turns!" % [enemy.name, BLEED_DAMAGE, BLEED_TURNS])
	
	#add bleed damage over time to the enemy
	enemy.add_status_effect("bleed", BLEED_TURNS, func(turn_count):
		if turn_count > 0:
			enemy.take_damage(BLEED_DAMAGE, "physical")
			print("%s takes %d physical damage from bleeding. %d turns remaining." % [enemy.name, BLEED_DAMAGE, turn_count])
		else:
			print("%s is no longer bleeding." % enemy.name)
	)
