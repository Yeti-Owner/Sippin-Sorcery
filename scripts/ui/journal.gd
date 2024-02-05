extends CanvasLayer

@onready var FlipPage := $FlipPageSound
@onready var OpenClose := $OpenCloseSound
@onready var DelayTimer := get_parent().get_node("DelayTimer")

@onready var PotionName := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Name
@onready var PotionIcon := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/PotionTex
@onready var PotionDesc := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Description
@onready var Effect1Text := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect1
@onready var Effect2Text := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect2
@onready var Effect3Text := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect3

var LengthLimit:int = 49

# Name, Icon, Desc
var CurrentPage:int = 0
var PageOrder:Array = ["MandrakeRoot","BasiliskFang","CentaurHoof","ChimeraFlame","DragonflyWing","DryadSap","FairyWing","GorgonBlood","GriffinFeather","HippogriffTalon","KrakenInk","MermaidScale","PhoenixFeather","SalamanderTail","SpiderSilk","TrollBlood","UnicornHorn"]

func _ready():
	randomize()
	self.visible = false
	_set_page(CurrentPage)

func _pop_up():
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	_set_page(CurrentPage)
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DelayTimer.start()

func _hide():
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	DelayTimer.stop()
	get_parent().Active = false

func _set_page(_page):
	CurrentPage = clamp(_page, 0, 16)
	PotionName.text = PotionInfo.JournalPotions[CurrentPage][0]
	PotionIcon.texture = load(PotionInfo.JournalPotions[CurrentPage][1])
	PotionDesc.text = PotionInfo.JournalPotions[CurrentPage][2]
	
	
	# Notes shenanigans
	var Ref = PotionInfo.JournalIngredients[PageOrder[CurrentPage]]
	if Ref[0].length() < LengthLimit:
		Effect1Text.text = "\n[color=BLACK]Effect 1:\n- "
	else:
		Effect1Text.text = Ref[0]
	
	if Ref[1].length() < LengthLimit:
		Effect2Text.text = "\n[color=BLACK]Effect 2:\n- "
	else:
		Effect2Text.text = Ref[1]
	
	if Ref[2].length() < LengthLimit:
		Effect3Text.text = "\n[color=BLACK]Effect 3:\n- "
	else:
		Effect3Text.text = Ref[2]

func _on_left_pressed():
	FlipPage.pitch_scale = randf_range(0.9, 1.1)
	FlipPage.play()
	_set_page(CurrentPage - 1)

func _on_right_pressed():
	FlipPage.pitch_scale = randf_range(0.9, 1.1)
	FlipPage.play()
	_set_page(CurrentPage + 1)

func _on_click_out_pressed():
	_hide()
