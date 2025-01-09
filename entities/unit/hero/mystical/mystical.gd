class_name Mystical
extends Hero

#tracks which ally has the "splithairs" buff
var buffed_ally: Unit = null

#bloodthirst: reduces the target's life by 3 and increases their muscles by 3
func bloodthirst(target: Unit):
	#verify that the target is valid
	if target == null:
		print("No valid target for Bloodthirst.")
		return

	#apply the effects
	target.life -= 3
	target.muscles += 3

	#log the action
	print("%s uses Bloodthirst on %s. Life reduced by 3 and muscles increased by 3." % [name, target.name])

	#check if the target dies from the health reduction
	if target.life <= 0:
		target.die()

#splithairs: buff an ally's next psychic attack to target an additional enemy and split damage
func split_hairs(ally: Unit):
	if buffed_ally != null:
		print("Another ally is already buffed with SplitHairs.")
		return

	#apply the buff to the selected ally
	buffed_ally = ally
	print("%s uses SplitHairs on %s. Their next psychic attack will target an additional enemy." % [name, ally.name])

#called when an ally makes a psychic attack
func on_ally_attack(attacker: Unit, damage: int, primary_target: Unit, secondary_target: Unit = null):
	if attacker == buffed_ally:
		if secondary_target == null:
			print("SplitHairs requires a secondary target!")
			return

		#split damage between the two targets
		var split_damage = damage / 2
		primary_target.take_damage(split_damage, "psychic")
		secondary_target.take_damage(split_damage, "psychic")

		print("%s splits their psychic attack, dealing %d damage to %s and %s." % [attacker.name, split_damage, primary_target.name, secondary_target.name])

		#remove the buff after the attack
		buffed_ally = null
	else:
		#regular attack if the ally is not buffed
		primary_target.take_damage(damage, "psychic")
		print("%s attacks %s with %d psychic damage." % [attacker.name, primary_target.name, damage])
