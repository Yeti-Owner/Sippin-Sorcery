extends CanvasLayer

@onready var HintLabel := $holder/Bg/RichTextLabel

func _ready():
	EventBus.Hint.connect(_hint)

func _hint(HintText):
	HintLabel.text = HintText
	$AnimationPlayer.play("show_hint")
