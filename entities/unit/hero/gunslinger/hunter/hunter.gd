class_name Hunter
extends Gunslinger

#initialize stats
func _init():
	life = 7
	soul = 10
	mind = 10
	motors = 15
	muscles = 8

var marked_enemy: Unit = null

#activate the marksmanship skill
func marksmanship(enemy: Unit):
	if not enemy:
		print("%s tries to mark a target but no enemy is selected!" % name)
		return

	marked_enemy = enemy
	print("%s marks %s as their target!" % [name, enemy.name])

	#change the artillery attack behavior to ignore resistance
	enemy.set("ignore_resistance", true)

#method to check if an enemy is marked
func is_enemy_marked() -> bool:
	return marked_enemy != null
