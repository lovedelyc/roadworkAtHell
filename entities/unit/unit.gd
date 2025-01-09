class_name Unit
extends Node2D

var health: int = 100
var movement_range: int = 6
var is_ethereal: bool = false

#tracks status effects on the unit
var status_effects: Dictionary = {}

#method to take damage
func take_damage(amount, damage_type):
	health -= amount
	print("%s takes %d %s damage. Remaining health: %d" % [name, amount, damage_type, health])
		
	if is_ethereal:
		var evade_chance = randi() % 100
		if evade_chance < 50:
			print("%s evades the attack thanks to their ethereal state!" % name)
			return  # Attack missed
	health -= amount
	print("%s takes %d %s damage. Remaining health: %d" % [name, amount, damage_type, health])
	
	#check if the enemy is defeated
	if health <= 0:
		die()

#handle death
func die():
	print("%s has died!" % name)
	queue_free()

#add a status effect
func add_status_effect(effect_name: String, duration: int, callback: Callable):
	status_effects[effect_name] = {
		"turns": duration,
		"callback": callback
	}

#process all status effects (call this per turn)
func process_status_effects():
	for effect_name in status_effects.keys():
		var effect = status_effects[effect_name]
		if effect["turns"] > 0:
			effect["callback"].call(effect["turns"])
			effect["turns"] -= 1
		else:
			status_effects.erase(effect_name)
