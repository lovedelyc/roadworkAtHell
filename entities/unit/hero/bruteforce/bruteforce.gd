class_name Bruteforce
extends Unit

#property to store the enemy affected by suffocate
var suffocated_enemy: Unit = null

#suffocate: the bruteforce strangles the enemy, immobilizing them and disabling certain attack types.
func suffocate(enemy: Unit):
	if not enemy:
		print("No enemy selected.")
		return

	#add suffocation effect to the enemy, without callback
	enemy.add_status_effect("suffocated", 2)
	print("Enemy is suffocated!")

#in unit.gd, modify process_status_effects to handle the effect without callbackllback
func process_status_effects():
	for effect_name in status_effects.keys():
		var effect = status_effects[effect_name]
		if effect["turns"] > 0:
			#you can check if the effect has ended and do something accordingly
			if effect_name == "suffocated" and effect["turns"] == 1:
				print("%s is no longer suffocated!" % name)
			effect["turns"] -= 1
		else:
			status_effects.erase(effect_name)
