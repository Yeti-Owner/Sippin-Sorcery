extends Interactable

@onready var JournalUI := $Journal
var Active:bool = false

func get_interaction_text():
	if Active == false:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [rainbow freq=0.3 sat=0.8 val=0.8]Read Journal[/rainbow][/center]"
	else:
		return ""

func get_interaction_icon():
	if Active == false:
		return EventBus.ActionTex
	else:
		return null

func interact():
	if Active == false:
		JournalUI._pop_up()

func _physics_process(_delta):
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (Active == true):
		JournalUI._hide()

func _on_area_3d_body_exited(body):
	if (body.name == "Player") and (Active == true):
		JournalUI._hide()

func _on_delay_timer_timeout():
	Active = true
	_reset()
