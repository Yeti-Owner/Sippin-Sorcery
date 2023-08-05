extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $Center/crosshair
@onready var BalanceLabel := $Control/Balance
@onready var DayNumText := $Fader/Day

func _ready():
	Engine.set_max_fps(60)
	EventBus.interaction.connect(_set_interaction)
	EventBus.connect("BalanceChanged", _balance)
	EventBus.Fade.connect(_fade)
	_balance()
	DayNumText.text = str("Day " + str(EventBus.DayNum))

func _set_interaction(icon, text):
	if icon == null:
		InteractIcon.set_visible(false)
	else:
		InteractIcon.texture = load(icon)
	if text == null:
		InteractionLabel.set_text("")
		InteractionLabel.set_visible(false)
	else:
		InteractionLabel.set_text(text)
		InteractionLabel.set_visible(true)

func _balance(): # "ʛ"
	BalanceLabel.text = str(" ʛ " + str(EventBus.Balance))

func _on_timer_timeout(): # Instance pause menu
	var p = load("res://scenes/ui/pause_menu.tscn")
	var _p = p.instantiate()
	$CanvasLayer.add_child(_p)

func _fade(type:String):
	match type:
		"in":
			$Fader/AnimationPlayer.play("fade_in")
		"out":
			$Fader/AnimationPlayer.play("fade_out")
		"day":
			$Fader/AnimationPlayer.play("day_in")
