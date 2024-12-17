class_name TurnManager
extends Node

#list of units in the game
var units: Array = []
var current_turn_index: int = 0

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

#end the current turn and move to the next one
func end_turn():
	current_turn_index = (current_turn_index + 1) % units.size()
	start_turn(units[current_turn_index])
