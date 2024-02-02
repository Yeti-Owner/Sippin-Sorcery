extends CanvasLayer

@onready var FlipPage := $FlipPageSound
@onready var OpenClose := $OpenCloseSound

@onready var PotionName := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Name
@onready var PotionIcon := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/PotionTex
@onready var PotionDesc := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Description
@onready var PotionNotes := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/RightPage/Notes

var enabled:bool = false

# Name, Icon, Desc
var CurrentPage:int = 0
var PageOrder:Array = ["MandrakeRoot","BasiliskFang","CentaurHoof","ChimeraFlame","DragonflyWing","DryadSap","FairyWing","GorgonBlood","GriffinFeather","HippogriffTalon","KrakenInk","MermaidScale","PhoenixFeather","SalamanderTail","SpiderSilk","TrollBlood","UnicornHorn"]

func _ready():
	EventBus.JournalToggle.connect(_toggle)
	_hide()
	_set_page(CurrentPage)

func _physics_process(_delta) -> void:
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (self.visible == true) and (enabled == true):
		self._hide()

func _pop_up():
	OpenClose.play()
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_set_page(CurrentPage)
	$delay.start()

func _set_page(_page):
	CurrentPage = clamp(_page, 0, 16)
	PotionName.text = PotionInfo.JournalPotions[CurrentPage][0]
	PotionIcon.texture = load(PotionInfo.JournalPotions[CurrentPage][1])
	PotionDesc.text = PotionInfo.JournalPotions[CurrentPage][2]
	
	
	# Notes shenanigans
	var NewText:String = PotionInfo.JournalIngredients[PageOrder[CurrentPage]] # Get PotionInfo.JournalIngredients entry
	for effect in PotionInfo.EffectsList:
		NewText = NewText.format({effect: ""})
	PotionNotes.text = NewText

func _on_left_pressed():
	FlipPage.play()
	_set_page(CurrentPage - 1)

func _on_right_pressed():
	FlipPage.play()
	_set_page(CurrentPage + 1)

func _on_click_out_pressed():
	_hide()

func _hide():
	if (enabled == true) and (self.visible == true):
		OpenClose.play()
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$delay.stop()
	enabled = false

func _toggle(value):
	if value:
		_pop_up()
	else:
		_hide()

func _on_delay_timeout():
	enabled = true
