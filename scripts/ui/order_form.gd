extends CanvasLayer

@onready var Orders := $OrderForm/Bg/Orders
const NewItem := "res://scenes/ui/OrderItem.tscn"
const GoodSound := "res://assets/audio/good.ogg"
const BadSound := "res://assets/audio/back_002.ogg"


var CompleteOrder:Dictionary
var HasOrdered:bool = false
var enabled:bool = false
var HideTimer:bool = false

func _ready():
	randomize()
	EventBus.OrderFormToggle.connect(_toggle)
	_hide()

func _physics_process(_delta) -> void:
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (self.visible == true) and (enabled == true):
		self._hide()

func _new_entry(item:String, amount:int, cost:int):
	var entry := load(NewItem)
	var _entry = entry.instantiate()
	Orders.add_child(_entry, true)
	_entry._create_entry(item, amount, cost)

func _pop_up():
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$OpenCloseSound.pitch_scale = randf_range(0.8, 1.2)
	$OpenCloseSound.play()
	$DelayTimer.start()

func _on_click_out_pressed():
	_hide()

func _hide():
	if (enabled == true) and (self.visible == true):
		$OpenCloseSound.pitch_scale = randf_range(0.8, 1.2)
		$OpenCloseSound.play()
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$DelayTimer.stop()
	enabled = false
	$NewOrderPopup.hide()

func _toggle(value):
	if value:
		_pop_up()
	else:
		_hide()

func _on_delay_timer_timeout():
	enabled = true

func _disable():
	HasOrdered = !HasOrdered
	$OrderForm/Bg/Options/NewEntry.disabled = HasOrdered
	$OrderForm/Bg/Options/FinishOrder.disabled = HasOrdered

func _on_finish_order_pressed():
	if Orders.get_child_count() < 1:
		print("No Orders")
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
	HideTimer = true
	$MiscTimer.start()

func _on_misc_timer_timeout():
	$OrderForm/Bg/Options/FinishOrder.text = "Finish Order"
	if HideTimer:
		_hide()
	HideTimer = false
