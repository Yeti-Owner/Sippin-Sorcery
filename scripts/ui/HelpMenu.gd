extends Control

const HelpPages := ["[center]Customers will explain a problem and it is your job to find the right effects to solve it. Some may be obvious and some may require problem solving skills. Customers also have flavor preferences, you can ask the customer what flavors they like by clicking on them. If you forget what problem they have you can also click on them to ask again.[/center]","[center]To mix a potion you need to add ingredients and then a flavor. You'll know what flavor is added by the color shown in the cauldron. Check your Journal and click on the pages to see the known effects of ingredients. Remember that the effect changes as you add more of an ingredient. For example if an ingredient has the following effects: 1. Happiness, 2. Sadness, 3. Anger. You can give it the sadness effect to a juice by adding 2 of the ingredient to the cauldron.[/center]","[center]To better solve your customers problems you need a better understanding of the ingredient effects. You can discover new effects by mixing a juice and giving it to Hogwarts students found near the exit portal. However these students will require payment in order to test the juice, and you can only test 1 effect at a time.[/center]"]
@onready var HelpLabel := $Bg/MarginContainer/HelpLabel
var HelpStage:int = 0

var values := [Vector2(0, -1100), Vector2(0, 0)]
var Visible:int = 0 : set = _set_visible

func _ready():
	HelpLabel.text = HelpPages[HelpStage]

func _set_visible(new_vis):
	Visible = wrap(new_vis, 0, 2)
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "position", values[Visible], 2).set_trans(Tween.TRANS_BACK)

func _on_close_btn_pressed():
	Visible = 0

func _on_next_arrow_pressed():
	HelpStage = wrap(HelpStage + 1, 0, HelpPages.size())
	HelpLabel.text = HelpPages[HelpStage]

func _on_back_arrow_pressed():
	HelpStage = wrap(HelpStage - 1, 0, HelpPages.size())
	HelpLabel.text = HelpPages[HelpStage]
