extends Control

@onready var Anims := $AnimPlayer
@onready var Name := $Bg/Name
@onready var Text := $Bg/HBoxContainer/Text
@onready var Headshot := $Bg/HBoxContainer/Headshot
@onready var Counter := $Counter
var Visible:bool = false
var delay:float = 2.0

func _ready():
	EventBus.Dialogue = self

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "start":
		Counter.start()

func _new_person(_name:String, _words:String, _icon, _delay := 2.0):
	delay = _delay
	Text.visible_ratio = 0
	Name.text = str("[center]" + _name + "[/center]")
	Headshot.texture = _icon

	Text.text = str(_words)
	
	if not Visible:
		Anims.play("start")
		Visible = true
	else:
		Counter.start()

func _talk(_words, _delay := 2.0):
	delay = _delay
	Text.visible_ratio = 0
	
	Text.text = str(_words)
	Counter.start()

func _done():
	Anims.play("end")
	Visible = false

func _on_counter_timeout():
	Text.visible_characters += 1
	if Text.visible_ratio >= 1:
		$DelayTimer.start(delay)
		delay = 2.0
	else:
		Counter.start()

func _on_delay_timer_timeout():
	Text.text = ""
	Text.visible_ratio = 0
	EventBus.emit_signal("DialogueFinished")
