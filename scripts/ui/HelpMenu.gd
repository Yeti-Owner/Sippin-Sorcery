extends Control

@onready var Click := get_parent().get_node("ClickSound")
@onready var Back := get_parent().get_node("BackSound")

const HelpPages := ["res://assets/textures/help/HelpPage1.png","res://assets/textures/help/HelpPage2.png","res://assets/textures/help/HelpPage3.png","res://assets/textures/help/HelpPage4.png"]
@onready var HelpTex := $Bg/MarginContainer/HelpTex
var HelpStage:int = 0

var values := [Vector2(0, -1100), Vector2(0, 0)]
var Visible:int = 0 : set = _set_visible

func _ready():
	HelpTex.texture = load(HelpPages[HelpStage])

func _set_visible(new_vis):
	Visible = wrap(new_vis, 0, 2)
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "position", values[Visible], 1.2).set_trans(Tween.TRANS_BACK)

func _on_close_btn_pressed():
	Back.play()
	Visible = 0

func _on_next_arrow_pressed():
	Click.play()
	HelpStage = wrap(HelpStage + 1, 0, EventBus.UnlockedHelp)
	HelpTex.texture = load(HelpPages[HelpStage])

func _on_back_arrow_pressed():
	Click.play()
	HelpStage = wrap(HelpStage - 1, 0, HelpPages.size())
	HelpTex.texture = load(HelpPages[HelpStage])
