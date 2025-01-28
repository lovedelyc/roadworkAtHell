class_name Maledictory
extends Unit

#poison: deals 2 psychic damage at the end of the enemy's turn indefinitely

#a dictionary to keep track of poisoned enemies and their effects
var poisoned_enemies: Dictionary = {}

func poison(target):
	#check if the target is already poisoned
	if target in poisoned_enemies:
		print("%s is already poisoned!" % target.name)
		return

	#apply poison effect
	poisoned_enemies[target] = true
	print("The curser casts Poison on %s. They will take 2 psychic damage at the end of their turn for the rest of the game." % target.name)

#handle the end of turn for poisoned enemies
func on_enemy_turn_end(enemy):
	if enemy in poisoned_enemies:
		#deal 2 psychic damage
		enemy.take_damage(2, "psychic")
		print("%s takes 2 psychic damage from Poison." % enemy.name)

#ether: the curser helps his companion by making him ethereal until his next turn, causing attacks directed at him to have a 50% chance of missing.

#a dictionary to track the ethereal state of allies
var ethereal_allies: Dictionary = {}

func ether(ally):
	#check if the ally is already ethereal
	if ally in ethereal_allies:
		print("%s is already ethereal!" % ally.name)
		return

	#apply ethereal state
	ethereal_allies[ally] = true
	print("%s is made ethereal by the curser. They now have a 50%% chance to evade attacks until the curser's next turn." % ally.name)

#remove ethereal state at the start of the next turn
func on_turn_start():
	#clear all ethereal states
	for ally in ethereal_allies.keys():
		print("%s is no longer ethereal." % ally.name)
		#remove any visual effect
		for child in ally.get_children():
			if child.name == "EtherEffect":
				child.queue_free()
	ethereal_allies.clear()

#paralize: halve the movement range of an enemy

#dictionary to track paralyzed enemies and their original movement range
var paralyzed_enemies: Dictionary = {}

func paralyze(enemy):
	#check if the enemy is already paralyzed
	if enemy in paralyzed_enemies:
		print("%s is already paralyzed!" % enemy.name)
		return

	#store the enemy's original movement range
	paralyzed_enemies[enemy] = enemy.movement_range

	#halve the enemy's movement range
	enemy.movement_range = int(enemy.movement_range / 2)
	print("%s is paralyzed! Their movement range is reduced to %d." % [enemy.name, enemy.movement_range])

#reset movement range at the start of the enemy's next turn
func on_enemy_turn_start(enemy):
	if enemy in paralyzed_enemies:
		#restore the original movement range
		enemy.movement_range = paralyzed_enemies[enemy]
		print("%s's paralysis wears off. Their movement range is restored to %d." % [enemy.name, enemy.movement_range])
		#remove the enemy from the dictionary
		paralyzed_enemies.erase(enemy)

#grudge: moves the selected enemy to the back of the turn queue

func grudge(enemy):
	#ensure the turnmanager exists in the scene
	var turn_manager = get_tree().get_current_scene().get_node("TurnManager")
	if not turn_manager:
		print("Error: TurnManager not found!")
		return

	#move the enemy to the back of the turn queue
	if turn_manager.move_to_back(enemy):
		print("%s is moved to the back of the turn queue by Grudge!" % enemy.name)
	else:
		print("Error: %s could not be moved. It might not be in the turn queue." % enemy.name)
