extends CanvasLayer

@onready var OpenClose := $OpenCloseSound
@onready var DelayTimer := get_parent().get_node("DelayTimer")
@onready var Orders := $OrderForm/Bg/Scroll/Orders
const NewItem := "res://scenes/ui/OrderItem.tscn"
const GoodSound := "res://assets/audio/good.ogg"
const BadSound := "res://assets/audio/back_002.ogg"

var CompleteOrder:Dictionary
var HasOrdered:bool = false

func _ready():
	randomize()
	self.visible = false

func _new_entry(item:String, amount:int, cost:int):
	var entry := load(NewItem)
	var _entry = entry.instantiate()
	Orders.add_child(_entry, true)
	_entry._create_entry(item, amount, cost)

func _pop_up():
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DelayTimer.start()

func _hide():
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	DelayTimer.stop()
	get_parent().Active = false
	$NewOrderPopup.hide()

func _on_click_out_pressed():
	_hide()

func _disable():
	HasOrdered = !HasOrdered
	$OrderForm/Bg/Options/NewEntry.disabled = HasOrdered
	$OrderForm/Bg/Options/FinishOrder.disabled = HasOrdered

func _on_finish_order_pressed():
	if Orders.get_child_count() < 1:
		return
	
	# Check player can afford the order
	var TotalCost:int = 0
	for order in Orders.get_children():
		TotalCost += order.Cost
	
	if TotalCost > EventBus.Balance:
		$OrderForm/Bg/Options/FinishOrder.text = "Not enough $$$"
		$GoodBadSound.pitch_scale = randf_range(0.8, 1.2)
		$GoodBadSound.stream = load(BadSound)
		$GoodBadSound.play()
		$MiscTimer.start()
		return
	else:
		EventBus.Balance -= TotalCost
		EventBus.emit_signal("BalanceChanged")
	
	# Collect orders together
	for entry in Orders.get_children():
		var ReformatedName:String = entry.Item.replace(" ", "")
		CompleteOrder[ReformatedName] = entry.Amount
		entry._disable()
	
	# Give feedback
	$OrderForm/Bg/Options/FinishOrder.text = "Complete!"
	$GoodBadSound.pitch_scale = randf_range(0.8, 1.2)
	$GoodBadSound.stream = load(GoodSound)
	$GoodBadSound.play()
	
	# Actually order it
	EventBus.Order = CompleteOrder
	
	# Disable so you can only order once per day
	_disable()
	$MiscTimer.start()

func _on_misc_timer_timeout():
	$OrderForm/Bg/Options/FinishOrder.text = "Finish Order"

func _on_order_all_pressed():
	for entry in PotionInfo.StockAmounts:
		if EventBus.Balance < 5:
			break
#		print(entry) # print ingredient name
	# Iterate through stock amounts until all full or balance runs out
	# for each item call _new_entry()
	# disable new entry button
	# call _on_finish_order_pressed()
	pass
