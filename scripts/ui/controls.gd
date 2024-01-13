extends Control

@onready var Click := get_parent().get_node("ClickSound")

const ControlArray := ["forward", "backward", "left", "right", "jump", "interact", "pause", "id", "sprint", "dialogue"]
var OldControl:String
var NewAction
var values := [Vector2(-890, 405), Vector2(-5, 405)]
var Visible:int = 0 : set = _set_visible

func _set_visible(new_vis):
	Visible = wrap(new_vis, 0, 2)
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "position", values[Visible], 0.75)

func _ready():
	for i in ControlArray.size():
		get_node(str("Bg/GridContainer/" + ControlArray[i] + str("/Button"))).text = str(OS.get_keycode_string(InputMap.action_get_events(ControlArray[i])[0].keycode))
	set_process_input(false)

func _on_button_pressed(extra_arg_0):
	Click.play()
	get_node(str("Bg/GridContainer/" + ControlArray[extra_arg_0] + str("/Button"))).text = str("...")
	set_process_input(true)
	OldControl = ControlArray[extra_arg_0]

func _input(event):
	if (event is InputEvent) and not (event is InputEventMouseMotion) and not (event is InputEventMouseButton):
		set_process_input(false)
		NewAction = event
		_new_key(event.as_text())

func _new_key(key):
	if _has_key(key) == false:
		_assign_key(OldControl)
	
	get_node(str("Bg/GridContainer/" + OldControl + str("/Button"))).text = str(OS.get_keycode_string(InputMap.action_get_events(OldControl)[0].keycode))

func _assign_key(control):
	EventBus.Keybinds[control] = NewAction
	InputMap.action_erase_events(control)
	InputMap.action_add_event(control, NewAction)

func _has_key(key) -> bool:
	# Get all keys in use and slap into an array
	@warning_ignore("unassigned_variable")
	var UsedKeys:Array
	for i in ControlArray.size():
		UsedKeys.append(str(OS.get_keycode_string(InputMap.action_get_events(ControlArray[i])[0].keycode)))
	
	return UsedKeys.has(key)
