extends Interactable

var Night:bool = false

func _ready():
	EventBus.connect("DayDone", _day_done)

func get_interaction_text():
	if Night == true:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]close shop.[/color][/center]"
	else:
		return "[center][color=BLACK]Day[/color] is not complete yet.[/center]"

func get_interaction_icon():
	if Night == true:
		return EventBus.ActionTex
	else:
		return EventBus.CrosshairTex

func interact():
	if Night == true:
		EventBus.emit_signal("NextDay")

func _day_done():
	Night = true
	_reset()
