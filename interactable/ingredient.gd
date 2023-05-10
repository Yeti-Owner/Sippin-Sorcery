extends Interactable

@export_enum("DragonflyWing", "FairyWing", "KrakenInk", "MandrakeRoot", "MermaidScale",
	"SalamanderTail", "SpiderSilk", "TrollBlood", "PhoenixFeather", "BasiliskFang", 
	"UnicornHorn", "CentaurHoof", "HippogriffTalon", "GriffinFeather", "ChimeraFlame", 
	"GorgonBlood", "DryadSap") var Ingredient:String

var IngredientInfo := {
	"DragonflyWing": ["Dragonfly Wing", Color(0.12549020349979, 0.29019609093666, 0.13333334028721)],
	"FairyWing": ["Fairy Wing", Color(0.80000001192093, 0.32941177487373, 0.80000001192093)],
	"KrakenInk": ["Kraken Ink", Color(0.12322875112295, 0.00120565423276, 0.12581461668015)],
	"MandrakeRoot": ["Mandrake Root", Color(0.12549020349979, 0.29019609093666, 0.13333334028721)],
	"MermaidScale": ["Mermaid Scale", Color(0.42352941632271, 0.22745098173618, 0.43921568989754)],
	"SalamanderTail": ["Salamander Tail", Color(0.25098040699959, 0.94117647409439, 0)],
	"SpiderSilk": ["Spider Silk", Color(0.90980392694473, 0.90980392694473, 0.90980392694473)],
	"TrollBlood": ["Troll Blood", Color(0.419607847929, 0.01568627543747, 0.01568627543747)],
	"PhoenixFeather": ["Phoenix Feather", Color(0.94901961088181, 0.66274511814117, 0.42352941632271)],
	"BasiliskFang": ["Basilisk Fang", Color(0.71372550725937, 0.61568629741669, 0.45490196347237)],
	"UnicornHorn": ["Unicorn Horn", Color(0.96078431606293, 0.55686277151108, 0.69411766529083)],
	"CentaurHoof": ["Centaur Hoof", Color(0.61568629741669, 0.6235294342041, 0.61960786581039)],
	"HippogriffTalon": ["Hippogriff Talon", Color(0.07058823853731, 0.07058823853731, 0.07450980693102)],
	"GriffinFeather": ["Griffin Feather", Color(0.35294118523598, 0.31764706969261, 0.32941177487373)],
	"ChimeraFlame": ["Chimera Flame", Color(0.90980392694473, 0, 0.0627451017499)],
	"GorgonBlood": ["GorgonBlood", Color(0.5799999833107, 0.27724000811577, 0.24359999597073)],
	"DryadSap": ["DryadSap", Color(0.48238503932953, 0.65542727708817, 0.40115711092949)]
}

func  _ready():
	$Mesh.mesh.material.albedo_color = IngredientInfo[Ingredient][1]

func get_interaction_text():
	return "[center]Press E to grab [color=" + str(IngredientInfo[Ingredient][1].inverted().to_html()) + "]" + str(IngredientInfo[Ingredient][0]) + "[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	EventBus.HeldItem = str(Ingredient)
