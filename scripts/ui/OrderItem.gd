extends Control

@onready var Icon := $HBoxContainer/Icon
@onready var Text := $HBoxContainer/Text
@onready var CostLabel := $HBoxContainer/Cost
@onready var Delete := $HBoxContainer/Delete
var Cost:int
var Amount:int
var Item:String

func _create_entry(item:String, amount:int, cost:int):
	Item = item
	Amount = amount
	Cost = cost
	
	# create an icon for flavors in ingredients folder
	var TexturePath:String = "res://assets/textures/ingredients/" + str(item.replace(" ", "")) + ".png"
	Icon.texture = load(TexturePath)
	Text.text = "\n" + str(amount) + "x " + item
	CostLabel.text = "\n[right]$" + str(cost) + "[/right]"

func _on_delete_pressed():
	get_parent().get_parent().get_parent().get_parent().get_node("NewOrderPopup").OrderedItems.erase(Item)
	self.queue_free()

func _disable():
	Delete.disabled = true
