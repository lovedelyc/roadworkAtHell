class_name Siege
extends Gunslinger

#initialize stats
func _init():
	life = 11
	soul = 10
	mind = 8
	motors = 16
	muscles = 5

#siege: shoots in a line, disabling ranged attacks for all enemies hit for 1 turn
func siege(targets: Array):
	if targets.size() == 0:
		print("No targets selected for Siege.")
		return

	print("%s uses Siege! Attacking all enemies in a line." % [name])

	#deal damage to all enemies in the line
	for target in targets:
		if target:
			var damage = calculate_siege_damage()
			target.take_damage(damage, "Siege Attack")
			print("%s takes %d damage from Siege." % [target.name, damage])

			#apply status effect to disable ranged attacks for 1 turn
			target.apply_status_effect("disable_ranged", 1)
			print("%s is unable to perform ranged attacks for 1 turn." % [target.name])

func calculate_siege_damage() -> int:
	#example damage calculation, adjust based on siege's power and mechanics
	return 50
