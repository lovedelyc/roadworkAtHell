class_name Partisan
extends Confaloniere

#initialize stats
func _init():
	life = 10
	soul = 10
	mind = 10
	motors = 11
	muscles = 11

const DAMAGE_BOOST = 1  #additional damage for allies
const ARMOR_RECOVERY = 2  #armor restored for allies
const DURATION = 2  #number of turns the effect lasts

#charge: boosts all allies' damage attributes and restores armor
func charge(allies: Array, turn_manager: TurnManager):
	if not allies or not turn_manager:
		print("Charge skill could not be used. Allies or turn manager missing.")
		return

	print("%s uses Charge! All allies gain +%d to damage attributes and recover %d armor for %d turns." 
		  % [name, DAMAGE_BOOST, ARMOR_RECOVERY, DURATION])

	#apply the effects to all allies
	for ally in allies:
		#temporarily boost damage attributes
		ally.add_buff({
			"stat_modifiers": {
				"physical_damage": DAMAGE_BOOST,
				"magical_damage": DAMAGE_BOOST,
				"psychic_damage": DAMAGE_BOOST
			},
			"duration": DURATION
		})

		#restore armor
		ally.armor += ARMOR_RECOVERY
		if ally.armor > ally.max_armor:
			ally.armor = ally.max_armor
		print("%s recovers %d armor. Current armor: %d" % [ally.name, ARMOR_RECOVERY, ally.armor])

	print("Charge effect will last for %d turns." % DURATION)
