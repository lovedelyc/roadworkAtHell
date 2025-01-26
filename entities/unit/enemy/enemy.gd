class_name Enemy
extends Unit


# Attributes
var unit_name: String = "Enemy"


# Attempt to move
func attempt_move(distance: int):
	#notify the warlock to check for the Pierce effect
	for player in get_tree().get_nodes_in_group("heroes"):
		if player is Warlock:
			if not player.on_enemy_move(self, distance):
				return  #movement is blocked due to the curse

	#proceed with movement if not blocked
	print("%s moves %d tiles." % [name, distance])
