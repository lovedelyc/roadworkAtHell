class_name Paladin
extends Confaloniere


const FULL_ARMOR_RECOVERY = true


# Initialize stats
func _init():
	life = 12
	soul = 10
	mind = 11
	motors = 11
	muscles = 8


# Chosen: restores full armor and prioritizes the Paladin in the next turn
func chosen(turn_manager: TurnManager):
	# Restore armor
	if FULL_ARMOR_RECOVERY:
		armor = max_armor
		print("%s is filled with divine grace! Armor fully restored." % name)
	
	# Move the paladin to the front of the turn queue
	if turn_manager:
		turn_manager.move_to_front(self)
		print("%s is now the first in the next turn." % name)
	else:
		print("Turn manager not available. Could not prioritize Paladin.")
	
	# Add visual or audio feedback if needed
	print("Chosen skill activated.")
