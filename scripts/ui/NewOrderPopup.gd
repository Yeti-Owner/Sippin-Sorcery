extends Control

@onready var RestockItem := $Bg/MarginContainer/HBoxContainer/RestockItem
@onready var OrderLabel := $Bg/MarginContainer/HBoxContainer/VBoxContainer/OrderLabel
@onready var OrderMin := $Bg/MarginContainer/HBoxContainer/VBoxContainer/Slider/Min
@onready var OrderMax := $Bg/MarginContainer/HBoxContainer/VBoxContainer/Slider/Max
@onready var Amount := $Bg/MarginContainer/HBoxContainer/VBoxContainer/Slider/AmountSlider
@onready var GrayOut := $Bg/MarginContainer/GrayOut
var SelectedItem:String

func _ready():
	_hide()

# Need way to disable the items that an order already exists for

func _on_item_list_item_selected(index):
	SelectedItem = RestockItem.get_item_text(index)
	GrayOut.hide()
	Amount.editable = true
	_set_up_order()

func _set_up_order():
	var Item:String = SelectedItem.replace(" ", "")
	
	# Max is maximum amount - current amount
	Amount.max_value = (PotionInfo.StockAmounts[Item][1] - PotionInfo.StockAmounts[Item][0])
	OrderMax.text = str(Amount.max_value)
	
	# Min needs to be 0 or 1
	Amount.min_value = min(1, Amount.max_value)
	OrderMin.text = str(Amount.min_value)
	
	# value is 1 or 0 depending on max being above 0
	Amount.value = min(1, Amount.max_value)
	OrderLabel.text = str(Amount.value) + "x " + SelectedItem

func _pop_up():
	self.show()
	GrayOut.show()
	Amount.editable = false

func _hide():
	self.hide()
	Amount.min_value = 0
	Amount.max_value = 10
	Amount.set_value_no_signal(5)
	GrayOut.show()
	RestockItem.deselect_all()
	
	SelectedItem = ""
	OrderLabel.text = "..."
	OrderMin.text = "x"
	OrderMax.text = "x"

func _on_new_order_click_out_pressed():
	_hide()

func _on_new_entry_pressed():
	_pop_up()

func _on_amount_slider_value_changed(value):
	OrderLabel.text = str(value) + "x " + SelectedItem


# Have to work on this after the rest of the Order Form is done
func _on_submit_order_pressed():
	pass # Replace with function body.
