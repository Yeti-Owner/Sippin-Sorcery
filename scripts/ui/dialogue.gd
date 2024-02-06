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
	"Callum" : [str("[font_size=26]Callum[/font_size]"), load("res://assets/textures/Callum.png")],
	"Alton" : [str("[font_size=26]Monk Alton[/font_size]"), load("res://assets/textures/Alton.png")]
}
var LastUsed:String

var Visible:bool = false
var delay:float = 5.0
var Active:bool = false

func _ready():
	$Bg/ContinueLabel.text = str("Press " + OS.get_keycode_string(InputMap.action_get_events("dialogue")[0].keycode) + " to continue")

func _process(_delta):
	if Input.is_action_just_pressed("dialogue"):
		if Active == true:
			Counter.stop()
			if Text.visible_ratio < 0.5:
				Text.visible_ratio = 0.5
			else:
				Text.visible_ratio = 1
			await get_tree().create_timer(0.1).timeout
			if Counter.is_stopped():
				Counter.start()
		elif (Active == false) and (Visible == true):
			$DelayTimer.start(0.05)

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "start":
		Counter.start()
	elif (anim_name == "continue") and (Active == false):
		$Bg/ContinueLabel.text = str("Press " + OS.get_keycode_string(InputMap.action_get_events("dialogue")[0].keycode) + " to continue")
		Anims.play("continue")

func _talk(_words:String, _char := LastUsed, _delay := 5.0):
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
	if Text.visible_ratio >= 1:
		$DelayTimer.start(delay)
		Anims.play("continue")
		Active = false
		delay = 10.0
	else:
		Active = true
		Text.visible_characters += 2
		Counter.start()

func _on_delay_timer_timeout():
	Text.text = ""
	Text.visible_ratio = 0
	EventBus.emit_signal("DialogueFinished")
