extends Interactable

@onready var FlipPage := $FlipPageSound
@onready var OpenClose := $OpenCloseSound
var Active:bool = false


# Journal stuff
@onready var PotionName := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Name
@onready var PotionIcon := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/PotionTex
@onready var PotionDesc := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Description
#@onready var PotionNotes := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/Notes
var CurrentPage:int = 0
var PageOrder:Array = ["MandrakeRoot","BasiliskFang","CentaurHoof","ChimeraFlame","DragonflyWing","DryadSap","FairyWing","GorgonBlood","GriffinFeather","HippogriffTalon","KrakenInk","MermaidScale","PhoenixFeather","SalamanderTail","SpiderSilk","TrollBlood","UnicornHorn"]

func _ready():
	randomize()
	$MonkShenanigans.visible = false

func get_interaction_text():
	return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]talk[/color] to Alton[/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if Active == false:
		_popup()

func _physics_process(_delta) -> void:
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (Active == true):
		self._hide()

func _popup():
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	_set_page(CurrentPage)
	$MonkShenanigans.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$DelayTimer.start()

func _hide():
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	$MonkShenanigans.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Active = false

func _on_delay_timer_timeout():
	Active = true

func _on_leave_area_body_exited(body):
	if body.name == "Player":
		_hide()

func _on_click_out_pressed():
	_hide()

func _set_page(_page):
	CurrentPage = clamp(_page, 0, 16)
	PotionName.text = PotionInfo.JournalPotions[CurrentPage][0]
	PotionIcon.texture = load(PotionInfo.JournalPotions[CurrentPage][1])
	PotionDesc.text = PotionInfo.JournalPotions[CurrentPage][2]
	
	
	
	# Notes shenanigans
	var Ref = PotionInfo.JournalIngredients2["MandrakeRoot"]
	$MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect1/Text.text = Ref[0]
	$MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect2/Text.text = Ref[1]
	$MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect3/Text.text = Ref[2]
	
	return
	var NewText:String = PotionInfo.JournalIngredients[PageOrder[CurrentPage]] # Get PotionInfo.JournalIngredients entry
	for effect in PotionInfo.EffectsList:
		NewText = NewText.format({effect: ""})
#	PotionNotes.text = NewText

func _on_left_pressed():
	FlipPage.pitch_scale = randf_range(0.8, 1.2)
	FlipPage.play()
	_set_page(CurrentPage - 1)

func _on_right_pressed():
	FlipPage.pitch_scale = randf_range(0.8, 1.2)
	FlipPage.play()
	_set_page(CurrentPage + 1)
