class_name Unit
extends Node2D

var life: int
var soul: int
var mind: int
var motors: int
var muscles: int
var health: int = 100
var max_health: int = 100
var movement_range: int = 6
var armor: int = 0
var ignore_resistance: bool = false
var max_armor: int = 10
var is_ethereal: bool = false
var action_points: int = 0
var attack_cost: int = 0

#tracks status effects on the unit
var status_effects: Dictionary = {}

#tracks temporary buffs on the unit
var buffs: Array = []

#method to take damage
func take_damage(amount: int, damage_type: String):
	if is_ethereal:
		var evade_chance = randi() % 100
		if evade_chance < 50:
			print("%s evades the attack thanks to their ethereal state!" % name)
			return  #attack missed

	#apply damage
	health -= amount
	print("%s takes %d %s damage. Remaining health: %d" % [name, amount, damage_type, health])

	#check if the unit is defeated
	if health <= 0:
		die()

#handle death
func die():
	print("%s has died!" % name)
	queue_free()

#apply a status effect to the unit
func apply_status_effect(effect_name: String, duration: int, callback: Variant = null):
	# Store the effect with a null callback if no callback is provided
	status_effects[effect_name] = {
		"turns": duration,
		"callback": callback
	}

#process all status effects (call this per turn)
func process_status_effects():
	var effects_to_remove: Array = []
	for effect_name in status_effects.keys():
		var effect = status_effects[effect_name]
		if effect["turns"] > 0:
			# Only call the callback if it's not null
			if effect["callback"] != null:
				effect["callback"].call(effect["turns"])  # Execute the callback
			effect["turns"] -= 1
		if effect["turns"] <= 0:
			effects_to_remove.append(effect_name)

	# Remove expired effects
	for effect_name in effects_to_remove:
		remove_status_effect(effect_name)

#remove a specific status effect
func remove_status_effect(effect_name: String):
	if effect_name in status_effects:
		status_effects.erase(effect_name)
		print("%s loses the status effect: %s." % [name, effect_name])

#add a temporary buff
func add_buff(buff: Dictionary):
	buffs.append(buff)
	print("%s receives a buff: %s" % [name, buff])

#process buffs at the end of the unit's turn
func process_buffs():
	for buff in buffs:
		if buff.has("stat_modifiers"):
			for stat in buff["stat_modifiers"]:
				self.set(stat, self.get(stat) + buff["stat_modifiers"][stat])

		buff["duration"] -= 1
		if buff["duration"] <= 0:
			buffs.erase(buff)
			print("%s's buff expired." % name)

#reset the ignore resistance option after each turn
func reset_ignore_resistance():
	ignore_resistance = false
