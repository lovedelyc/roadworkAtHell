class_name Unit
extends Node2D

var health: int = 100
var movement_range: int = 6
var is_ethereal: bool = false

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
		print("%s has been defeated!" % name)
		queue_free()

func die():
	print("Unit has died.")
	queue_free()
