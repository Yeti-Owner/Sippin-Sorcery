extends Interactable

var Active:bool = false

func _ready():
	_hide()

func get_interaction_text():
	return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]talk[/color] to Alton[/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	_popup()

func _physics_process(_delta) -> void:
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (Active == true):
		self._hide()

func _popup():
	print("Pop")
	$MonkShenanigans.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$DelayTimer.start()

func _hide():
	print("Hide")
	$MonkShenanigans.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Active = false

func _on_delay_timer_timeout():
	Active = true


func _on_button_pressed():
	print("Button1 pressed")

func _on_button_2_pressed():
	_hide()
