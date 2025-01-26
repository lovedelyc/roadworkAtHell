class_name Ventriloquist
extends Maledictory


var possession_active: bool = false  # Flag to track if possession is active
var max_action_points: int = 4       # Max points for reset


# Initialize stats
func _init():
	life = 9
	soul = 14
	mind = 10
	motors = 4
	muscles = 9
	action_points = 4


# Possession: the head controlled by the ventriloquist possesses an ally until your next turn,
# giving them +6 armor and +4 to their damage attributes.
func possession():
	# Check if enough action points are available
	if action_points < 4:
		print("Not enough action points to use Possession! You need at least 4.")
		return
	
	# Check if possession is already active
	if possession_active:
		print("Possession is already active!")
		return
	
	# Deduct action points and activate possession
	action_points -= 2
	possession_active = true
	print("The Ventriloquist uses Possession. It will last until their next turn.")
	print("Remaining Action Points: %d" % action_points)

func on_turn_start():
	# If possession was active, end the effect
	if possession_active:
		possession_active = false
		print("Possession has ended.")

	# Reset action points for the new turn
	action_points = max_action_points
	print("Ventriloquist's turn starts. Action points reset to %d." % action_points)
