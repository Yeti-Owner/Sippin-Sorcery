extends Node

class_name Interactable

func get_interaction_text():
	return "Interact"

func get_interaction_icon():
	return EventBus.CrosshairTex

func interact():
	print("Interacted with me")
