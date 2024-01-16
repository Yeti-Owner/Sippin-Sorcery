extends Control

@onready var RestockItem := $Bg/MarginContainer/HBoxContainer/RestockItem
@onready var OrderLabel := $Bg/MarginContainer/HBoxContainer/VBoxContainer/OrderLabel
@onready var OrderMin := $Bg/MarginContainer/HBoxContainer/VBoxContainer/Slider/Min
@onready var OrderMax := $Bg/MarginContainer/HBoxContainer/VBoxContainer/Slider/Max
@onready var Amount := $Bg/MarginContainer/HBoxContainer/VBoxContainer/Slider/AmountSlider
@onready var SubmitBtn := $Bg/SubmitOrder
var SelectedItem:String = ""

func _ready():
	_hide()

# Need way to disable the items that an order already exists for
# for now, everything is a flat rate of $5

func _on_item_list_item_selected(index):
	SelectedItem = RestockItem.get_item_text(index)
	Amount.editable = true
	_set_up_order()

func _set_up_order():
	# Basic set-up
	var Item:String = SelectedItem.replace(" ", "")
	Amount.min_value = 0
	Amount.value = 0
	Amount.max_value = 0
	
	# Max is maximum amount - current amount
	var MaxVal:int = PotionInfo.StockAmounts[Item][1] - PotionInfo.StockAmounts[Item][0]
	Amount.max_value = (MaxVal)
	OrderMax.text = str(Amount.max_value)
	
	# Min needs to be 0 or 1
	Amount.min_value = min(1, Amount.max_value)
	OrderMin.text = str(Amount.min_value)

	# value is 1 or 0 depending on max being above 0
	Amount.value = min(1, Amount.max_value)
	OrderLabel.text = str(Amount.value) + "x " + SelectedItem

func _pop_up():
	self.show()
	Amount.editable = false

func _hide():
	self.hide()
	Amount.min_value = 0
	Amount.max_value = 10
	Amount.set_value_no_signal(5)
	RestockItem.deselect_all()
	SubmitBtn.text = "Submit $0"
	
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
	SubmitBtn.text = "Submit $" + str(value * 5)

func _on_submit_order_pressed():
	if (Amount.value > 0) and (SelectedItem != ""):
		get_parent()._new_entry(SelectedItem, Amount.value, int(Amount.value * 5))
	_hide()
