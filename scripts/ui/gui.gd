extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $Center/crosshair
@onready var BalanceLabel := $Control/Balance

func _ready():
#	Engine.set_max_fps(60)
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

func _balance(): # "ʛ"
	BalanceLabel.text = str(" ʛ " + str(EventBus.Balance))

func _on_timer_timeout(): # Instane pause menu
	var p = load("res://scenes/ui/pause_menu.tscn")
	var _p = p.instantiate()
	$CanvasLayer.add_child(_p)
