class_name Unit
extends Node2D


var health: int = 100
var max_health: int = 100
var movement_range: int = 6
var armor: int = 0
var max_armor: int = 10
var is_ethereal: bool = false

#tracks status effects on the unit
var status_effects: Dictionary = {}

var buffs: Array = []


var spritesheet: Texture2D

# Graphics and animations
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	# Assign corresponding texture to the sprite
	if spritesheet:
		sprite.texture = spritesheet


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

#method to add a temporary buff
func add_buff(buff: Dictionary):
	buffs.append(buff)
	print("%s receives a buff: %s" % [name, buff])

#method to process buffs at the end of the unit's turn
func process_buffs():
	for buff in buffs:
		if buff.has("stat_modifiers"):
			for stat in buff["stat_modifiers"]:
				self.set(stat, self.get(stat) + buff["stat_modifiers"][stat])

		buff["duration"] -= 1
		if buff["duration"] <= 0:
			buffs.erase(buff)
			print("%s's buff expired." % name)
