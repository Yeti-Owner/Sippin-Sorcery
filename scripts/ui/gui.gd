extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $Center/crosshair
@onready var BalanceLabel := $Control/Balance

func _ready():
	EventBus.interaction.connect(_set_interaction)
	EventBus.connect("BalanceChanged", _balance)
	_balance()

func _set_interaction(icon, text):
	if icon == null:
		InteractIcon.set_visible(false)
	else:
		InteractIcon.texture = load(icon)
	if text == null:
		InteractionLabel.set_text("")
		InteractionLabel.set_visible(false)
	else:
		InteractionLabel.set_text(str("\n" + text))
		InteractionLabel.set_visible(true)

func _balance():
	BalanceLabel.text = str("$" + str(EventBus.Balance))

func _fade(type:String):
	match type:
		"in":
			$Fader/AnimationPlayer.play("fade_in")
		"out":
			$Fader/AnimationPlayer.play("fade_out")
		"day":
			$Fader/AnimationPlayer.play("day_in")
