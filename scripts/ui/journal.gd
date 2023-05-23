extends CanvasLayer

@onready var PotionName := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Name
@onready var PotionIcon := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/PotionTex
@onready var PotionDesc := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Description
@onready var PotionNotes := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/RightPage/Notes

# Name, Icon, Desc
var CurrentPage:int = 0

func _ready():
	EventBus.JournalToggle.connect(_toggle)
	_hide()
	_set_page(CurrentPage)

func _pop_up():
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _set_page(_page):
	CurrentPage = clamp(_page, 0, 16)
	PotionName.text = PotionInfo.JournalPotions[CurrentPage][0]
	PotionIcon.texture = load(PotionInfo.JournalPotions[CurrentPage][1])
	PotionDesc.text = PotionInfo.JournalPotions[CurrentPage][2]

func _on_left_pressed():
	_set_page(CurrentPage - 1)

func _on_right_pressed():
	_set_page(CurrentPage + 1)

func _on_click_out_pressed():
	_hide()

func _hide():
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _toggle(value):
	if value:
		_pop_up()
	else:
		_hide()
