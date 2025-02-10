class_name Sniper
extends Gunslinger

#initialize stats
func _init():
	life = 8
	soul = 10
	mind = 11
	motors = 17
	muscles = 4

var headshot_ready: bool = true

#headshot: deals a powerful shot, and if the target dies, the skill can be used again next turn.
func headshot(target: Unit):
	if not target:
		print("No target selected for Headshot.")
		return
	
	if not headshot_ready:
		print("Headshot is not ready yet.")
		return

	#deal damage (assuming a method for powerful attacks, e.g., a critical hit multiplier)
	var damage = calculate_headshot_damage()
	target.take_damage(damage, "Headshot")

	print("%s uses Headshot on %s! Damage dealt: %d" % [name, target.name, damage])

	#if the target dies, prepare headshot for next turn
	if target.health <= 0:
		print("%s was killed by the Headshot!" % [target.name])
		headshot_ready = false  #disable headshot for this turn
	else:
		print("%s survives the Headshot." % [target.name])

#this method is called at the start of the sniper's turn to reset the headshot skill.
func on_turn_start():
	#if headshot was used and the target died, reset for next turn
	headshot_ready = true
	print("%s is ready for the next Headshot." % [name])

func calculate_headshot_damage() -> int:
	return 100  #change this value based on how powerful the sniper's headshot should be
