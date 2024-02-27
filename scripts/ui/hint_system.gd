extends CanvasLayer

@onready var HintLabel := $holder/Bg/RichTextLabel

func _ready():
	EventBus.Hint.connect(_hint)

func _hint(HintText):
	HintLabel.text = str("\n" + HintText) # Cuz the font is wonky
	$AnimationPlayer.play("show_hint")
