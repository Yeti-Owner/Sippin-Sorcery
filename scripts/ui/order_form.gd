extends CanvasLayer

var enabled:bool = false

func _ready():
	EventBus.OrderFormToggle.connect(_toggle)
	_hide()

func _physics_process(_delta) -> void:
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (self.visible == true) and (enabled == true):
		self._hide()

func _pop_up():
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# play sound
	$DelayTimer.start()


func _on_click_out_pressed():
	_hide()

func _hide():
	if (enabled == true) and (self.visible == true):
		pass # play sound
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$DelayTimer.stop()
	enabled = false

func _toggle(value):
	if value:
		_pop_up()
	else:
		_hide()

func _on_delay_timer_timeout():
	enabled = true
