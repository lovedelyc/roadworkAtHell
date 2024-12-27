class_name Bard
extends Maledictory

#initialize stats
func _init():
	life = 10
	soul = 13
	mind = 11
	motors = 4
	muscles = 8
	action_points = 4
	attack_cost = 2

#hymn effect tracker
var hymn_targets: Dictionary = {}

#hymn skill: grants the first attack of an ally no action point cost and allows repetition
func hymn(ally):
	if hymn_targets.has(ally):
		print("%s is already under the effect of Hymn." % ally.name)
		return

	#add ally to hymn_targets with the effect enabled
	hymn_targets[ally] = true
	print("%s is inspired by the Bard's Hymn! Their first attack costs no action points and can be repeated once." % ally.name)

#called when an ally performs an action
func on_ally_action(ally, action_type):
	if hymn_targets.has(ally) and hymn_targets[ally]:
		if action_type == "attack":
			print("%s's first attack is free and can be repeated!" % ally.name)
			
			#apply the hymn benefit
			ally.action_points += ally.attack_cost  #refund action points used for attack
			print("Action points refunded for %s. They can attack again!" % ally.name)
			
			#disable hymn effect after use
			hymn_targets[ally] = false
			return true
	return false

#perform an attack
func perform_attack(target):
	if action_points < attack_cost:
		print("%s doesn't have enough action points to attack!" % name)
		return

	action_points -= attack_cost
	print("%s attacks %s!" % [name, target.name])
	
	#notify the turnmanager of the action
	var turn_manager = get_tree().get_current_scene().get_node("TurnManager")
	if turn_manager:
		turn_manager.unit_performs_action(self, "attack")
