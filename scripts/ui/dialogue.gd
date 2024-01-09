extends Control

@onready var Anims := $AnimPlayer
@onready var Name := $Bg/Name
@onready var Text := $Bg/HBoxContainer/Text
@onready var Headshot := $Bg/HBoxContainer/Headshot
@onready var Counter := $Counter

var CharacterList := {
	"Bob" : ["[font_size=26]Bob[/font_size]", load("res://assets/textures/Wizard.png")],
	"Duane" : ["[font_size=26]Duane[/font_size]", load("res://assets/textures/Duane.png")],
	"Self" : [str("[font_size=26]" + EventBus.PlayerName + "[/font_size]"), EventBus.PlayerHeadshot],
	"Callum" : [str("[font_size=26]Callum[/font_size]"), load("res://assets/textures/Callum.png")]
}
var LastUsed:String

var Visible:bool = false
var delay:float = 2.0

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "start":
		Counter.start()

func _talk(_words:String, _char := LastUsed, _delay := 2.0) -> void:
	LastUsed = _char
	delay = _delay
	Text.visible_ratio = 0
	Name.text = str("[center]" + CharacterList[_char][0] + "[/center]")
	Headshot.texture = CharacterList[_char][1]

	Text.text = str(_words)
	
	if not Visible:
		Anims.play("start")
		Visible = true
	else:
		Counter.start()

func _done():
	Anims.play("end")
	Visible = false

func _on_counter_timeout():
	Text.visible_characters += 1.5
	if Text.visible_ratio >= 1:
		$DelayTimer.start(delay)
		delay = 2.0
	else:
		Counter.start()

func _on_delay_timer_timeout():
	Text.text = ""
	Text.visible_ratio = 0
	EventBus.emit_signal("DialogueFinished")
