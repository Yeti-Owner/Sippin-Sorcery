extends Interactable

@export var HasItem:bool = false
var Searched:String = "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]search trash bag[/color][/center]"
var isSearched:bool = false

func _ready():
	randomize()

func get_interaction_text():
	if EventBus.HeldItem == null:
		return Searched
	else:
		return "[center]a [color=BLACK]trash bag[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if isSearched == false:
		$Sfx.pitch_scale = randf_range(0.78, 1.22)
		$Sfx.play()
		isSearched = true
	
	if (EventBus.HeldItem == null) and (HasItem == true):
		EventBus.HeldItem = "NepalOrb"
		EventBus.emit_signal("HeldItemChanged")
	elif (HasItem == false):
		Searched = "[center]a boring [color=BLACK]trash bag[/color] filled with trash[/center]"
		_reset()
	
