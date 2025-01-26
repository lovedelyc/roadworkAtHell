class_name Artificer
extends Confaloniere


const SPARK_DAMAGE = 8  #damage dealt to the main target and adjacent units


# Initialize stats
func _init():
	life = 9
	soul = 12
	mind = 12
	motors = 10
	muscles = 9


# Sparks: deals damage to the target and any adjacent units
func sparks(target: Unit, all_units: Array[Unit]):
	if not target:
		print("No target selected for Sparks.")
		return
	
	print("%s uses Sparks on %s!" % [name, target.name])
	
	# Damage the main target
	target.take_damage(SPARK_DAMAGE, "electric")
	print("%s takes %d electric damage!" % [target.name, SPARK_DAMAGE])
	
	# Find and damage adjacent units
	var adjacent_units = all_units.filter(
		func(unit):
			return unit != target and unit.position.distance_to(target.position) <= 1.5  #adjust range if needed
	)
	
	for unit in adjacent_units:
		unit.take_damage(SPARK_DAMAGE, "electric")
		print("%s takes %d electric damage from Sparks!" % [unit.name, SPARK_DAMAGE])
	
	print("Sparks dissipate after dealing damage.")
