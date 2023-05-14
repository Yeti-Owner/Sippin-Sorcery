extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $Center/crosshair
@onready var BalanceLabel := $Balance

func _ready():
	Engine.set_max_fps(60)
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
		InteractionLabel.set_text(text)
		InteractionLabel.set_visible(true)

func _balance():
	BalanceLabel.text = str(str(EventBus.Balance) + " Galleons")
