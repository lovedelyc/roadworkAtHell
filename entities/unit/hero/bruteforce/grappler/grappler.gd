class_name Grappler
extends Bruteforce

#initialize stats
func _init():
	life = 15
	soul = 6
	mind = 4
	motors = 9
	muscles = 16

#property to store the grappled enemy
var grappled_enemy: Unit = null

#grapple: the grappler locks the enemy in place and reduces incoming damage.
func grapple(enemy: Unit):
	if not enemy:
		print("No enemy selected.")
		return

	#store reference to the grappled enemy
	grappled_enemy = enemy
	print("%s uses Grapple on %s!" % [name, enemy.name])

	#apply status effects to the enemy (now no need for callback)
	enemy.apply_status_effect("immobilized", 2)  # prevents movement
	enemy.apply_status_effect("disable_artillery", 2)  # prevents artillery attacks
	enemy.apply_status_effect("disable_psychic", 2)  # prevents psychic attacks
	print("%s is immobilized and cannot use artillery or psychic attacks for 2 turns." % [enemy.name])

	#apply damage reduction to the grappler
	self.apply_status_effect("damage_reduction_50", 2)  # reduces damage by 50% for 2 turns

	#connect signal to monitor when the grappler takes damage
	self.connect("damaged", Callable(self, "_on_grappler_damaged"))
	print("%s reduces incoming damage by 50% for 2 turns while grappling." % name)
