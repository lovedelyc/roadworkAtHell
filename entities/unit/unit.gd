class_name Unit
extends Node2D

func take_damage(amount: int):
	print("Unit took " + str(amount) + " damage.")
	die()

func die():
	print("Unit has died.")
	queue_free()
