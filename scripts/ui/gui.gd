extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $Center/crosshair

func _ready():
	Engine.set_max_fps(60)
	EventBus.interaction.connect(_set_interaction)

func _process(delta):
	pass

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
