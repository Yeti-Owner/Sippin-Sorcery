extends CanvasLayer

@onready var PotionName := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Name
@onready var PotionIcon := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/PotionTex
@onready var PotionDesc := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Description
@onready var PotionNotes := $Journal/CenterContainer/TextureRect/MarginContainer/HBoxContainer/RightPage/Notes

# Name, Icon, Desc
var PotionInfo:Dictionary = {
	0 : ["Basilisk Fangs", "res://assets/textures/ingredients/BasiliskFang.png", "Sharp, venomous fangs obtained from a basilisk, a mythical serpent-like creature known for its deadly gaze."],
	1 : ["Centaur Hoof Shavings", "res://assets/textures/ingredients/CentaurHoof.png","Small shavings collected from the hooves of centaurs, half-human and half-horse beings from ancient legends."],
	2 : ["Chimera Flame Essence", "res://assets/textures/ingredients/ChimeraFlame.png","Highly concentrated essence extracted from the flames of a chimera, a fearsome creature with the body parts of different animals, typically a lion, goat, and serpent."],
	3 : ["Dragonfly Wings", "res://assets/textures/ingredients/DragonflyWing.png", "Delicate wings harvested from dragonflies, ethereal insects known for their agile flight and vibrant colors."],
	4 : ["Dryad Sap", "res://assets/textures/ingredients/DryadSap.png","Sticky sap collected from the trunks of trees inhabited by dryads, enchanting tree spirits known by their Greek mythology."],
	5 : ["Fairy Wings", "res://assets/textures/ingredients/FairyWing.png","Exquisite and delicate wings gently obtained from fairies, mystical beings associated with enchantment and nature."],
	6 : ["Gorgon Blood", "res://assets/textures/ingredients/GorgonBlood.png","Dark and potent blood acquired from a gorgon, a terrifying creature with serpents for hair and a petrifying gaze."],
	7 : ["Griffin Feathers", "res://assets/textures/ingredients/GriffinFeather.png","Majestic feathers gathered from griffins, legendary creatures with the body of a lion and the head and wings of an eagle."],
	8 : ["Hippogriff Talons", "res://assets/textures/ingredients/HippogriffTalon.png","Sharp talons acquired from a hippogriff, a creature with the front half of an eagle and the hind half of a horse."],
	9 : ["Kraken Ink", "res://assets/textures/ingredients/KrakenInk.png","Inky substance harvested from the ink sac of a kraken, a gigantic sea monster typically dwelling in the depths of the ocean."],
	10 : ["Mandrake Roots", "res://assets/textures/ingredients/MandrakeRoot.png","Twisted and powerful roots extracted from mandrakes, plants with mystical properties and resembling humanoids."],
	11 : ["Mermaid Scales", "res://assets/textures/ingredients/MermaidScale.png","Shimmering scales collected from mermaids, beautiful aquatic beings with the upper body of a human and the tail of a fish."],
	12 : ["Phoenix Feathers", "res://assets/textures/ingredients/PhoenixFeather.png","Brilliant and fiery feathers gathered from a phoenix, a mythical bird known for its ability to rise from its ashes and be reborn."],
	13 : ["Salamander Tails", "res://assets/textures/ingredients/SalamanderTail.png","Energetic and resilient tails obtained from salamanders, mythical creatures associated with fire and transformation."],
	14 : ["Spider Silk", "res://assets/textures/ingredients/SpiderSilk.png","Fine and strong silk spun by spiders then enchanted, known for its exceptional durability and elasticity."],
	15 : ["Troll Blood", "res://assets/textures/ingredients/TrollBlood.png","Thick and viscous blood derived from a troll, a creature known for its strength and dimwitted nature."],
	16 : ["Unicorn Horn Shavings", "res://assets/textures/ingredients/UnicornHorn.png","Shavings collected from the horn of a unicorn, a legendary creature symbolizing purity and grace."]
}
var CurrentPage:int = 0
var Visible:bool = false

func _ready():
	EventBus.connect("JournalToggle", _toggle)
	_hide()
	_set_page(CurrentPage)

func _pop_up():
	Visible = true
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _set_page(_page):
	CurrentPage = clamp(_page, 0, 16)
	PotionName.text = PotionInfo[CurrentPage][0]
	PotionIcon.texture = load(PotionInfo[CurrentPage][1])
	PotionDesc.text = PotionInfo[CurrentPage][2]

func _on_left_pressed():
	_set_page(CurrentPage - 1)

func _on_right_pressed():
	_set_page(CurrentPage + 1)

func _on_click_out_pressed():
	_hide()

func _hide():
	Visible = false
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _toggle():
	if Visible:
		_hide()
	else:
		_pop_up()
