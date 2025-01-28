class_name Slayer
extends Bruteforce

#initialize stats
func _init():
	life = 13
	soul = 11
	mind = 3
	motors = 8
	muscles = 15

#slayer-specific stats
var original_armor: int
var rage_active: bool = false

#function to activate the "rage" skill
func rage():
	if rage_active:
		print("%s's Rage is already active!" % name)
		return
	
	print("%s activates Rage!" % name)
	
	#save the original armor value
	original_armor = armor
	
	#remove all armor
	armor = 0
	
	#double max health and resistance
	max_health *= 2
	health = max_health  #restore health to its max value
	motors *= 2
	
	#mark that the skill is active
	rage_active = true

	#set priority for next turn
	var turn_manager = get_node("/root/TurnManager")  # Adjust the path if needed
	turn_manager.set_priority_for_next_turn(self)
	
	print("%s uses Rage and will act first next turn!" % name)

#reset the rage skill at the end of the turn
func end_rage():
	if not rage_active:
		return
	
	print("%s's Rage ends." % name)
	
	#restore original values
	max_health /= 2
	health = max_health  #restore health to its max value
	motors /= 2
	armor = original_armor
	
	#deactivate the rage skill
	rage_active = false
	
#function to handle priority for the next turn
func set_priority_for_next_turn():
	print("%s is the first to act next turn." % name)

# Here you can handle damage or other skills related to RAGE, if necessary.
