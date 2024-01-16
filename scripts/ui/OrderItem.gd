extends Control

@onready var Icon := $HBoxContainer/Icon
@onready var Text := $HBoxContainer/Text
@onready var Cost := $HBoxContainer/Cost
@onready var Delete := $HBoxContainer/Delete

func _create_entry(item:String, amount:int, cost:int):
	# create an icon for flavors in ingredients folder
	var TexturePath:String = "res://assets/textures/ingredients/" + str(item.replace(" ", "")) + ".png"
	Icon.texture = load(TexturePath)
	Text.text = "\n" + str(amount) + "x " + item
	Cost.text = "\n[right]$" + str(cost) + "[/right]"

func _on_delete_pressed():
	self.queue_free()
