class_name TurnManager
extends Node

var units: Array = [] #list of units in the game
var current_turn_index: int = 0
var turn_queue: Array = []  #list of units in the turn order

#signal to notify the start of a unit's turn
signal turn_started(unit)

#start the turn cycle
func start_turns():
	if units.size() == 0:
		print("No units to manage in TurnManager!")
		return

	current_turn_index = 0
	start_turn(units[current_turn_index])

#start an individual turn
func start_turn(unit):
	print("%s's turn begins." % unit.name)
	emit_signal("turn_started", unit)

	#notify the unit to run any start-of-turn logic
	if unit.has_method("on_turn_start"):
		unit.on_turn_start()

	if unit is Enemy:
		#notify the maledictory to handle paralyzed enemies
		for player in get_tree().get_nodes_in_group("heroes"):
			if player is Maledictory:
				player.on_enemy_turn_start(unit)

	print("%s's turn begins." % unit.name)

#end the current turn and apply poison if applicable
func end_turn():
	var current_unit = units[current_turn_index]

	#notify the unit that their turn has ended
	if current_unit.has_method("on_turn_end"):
		current_unit.on_turn_end()

	#handle poison effects for enemies
	if current_unit is Enemy:
		for unit in units:
			if unit is Maledictory:
				unit.on_enemy_turn_end(current_unit)
				

	if current_unit is Warlock:
		current_unit.on_turn_end()
	print("%s's turn ends." % current_unit.name)
	
	#rotate the queue to the next unit
	turn_queue.append(turn_queue.pop_front())

	#move to the next unit's turn
	current_turn_index = (current_turn_index + 1) % units.size()
	start_turn(units[current_turn_index])

#move a unit to the back of the turn queue
func move_to_back(unit: Node) -> bool:
	if unit in turn_queue:
		turn_queue.erase(unit)
		turn_queue.append(unit)
		return true
	return false

#start the next turn
func next_turn():
	if turn_queue.size() > 0:
		#rotate the queue
		var current_unit = turn_queue.pop_front()
		turn_queue.append(current_unit)
		print("Turn begins for %s." % current_unit.name)
		current_unit.on_turn_start()

#notify allies and apply hymn effect during their turn
func notify_ally_action(ally, action_type):
	for unit in get_tree().get_nodes_in_group("heroes"):
		if unit is Bard:
			unit.on_ally_action(ally, action_type)
			
#example usage during an action
func unit_performs_action(unit, action_type):
	notify_ally_action(unit, action_type)
	print("%s performs %s action." % [unit.name, action_type])
