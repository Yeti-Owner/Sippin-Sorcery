@tool
extends Interactable

@export_enum("DragonflyWing", "FairyWing", "KrakenInk", "MandrakeRoot", "MermaidScale",
	"SalamanderTail", "SpiderSilk", "TrollBlood", "PhoenixFeather", "BasiliskFang", 
	"UnicornHorn", "CentaurHoof", "HippogriffTalon", "GriffinFeather", "ChimeraFlame", 
	"GorgonBlood", "DryadSap") var Ingredient:String

var mat

# Name, Color, CollisionPos, CollisionSize
var IngredientInfo := {
	"DragonflyWing": ["Dragonfly Wing", Color(0.12549020349979, 0.29019609093666, 0.13333334028721), Vector3(0, 0.4, 0), Vector3(0.2, 0.8, 0.8)],
	"FairyWing": ["Fairy Wing", Color(0.80000001192093, 0.32941177487373, 0.80000001192093), Vector3(0, 0.15, 0), Vector3(0.5, 0.3, 0.8)],
	"KrakenInk": ["Kraken Ink", Color(0.12322875112295, 0.00120565423276, 0.12581461668015), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"MandrakeRoot": ["Mandrake Root", Color(0.12549020349979, 0.29019609093666, 0.13333334028721), Vector3(0.05, 0.4, 0.05), Vector3(0.7, 0.8, 0.7)],
	"MermaidScale": ["Mermaid Scale", Color(0.42352941632271, 0.22745098173618, 0.43921568989754), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.8)],
	"SalamanderTail": ["Salamander Tail", Color(0.25098040699959, 0.94117647409439, 0), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.2)],
	"SpiderSilk": ["Spider Silk", Color(0.90980392694473, 0.90980392694473, 0.90980392694473), Vector3(0, 0.35, 0), Vector3(0.8, 0.7, 0.8)],
	"TrollBlood": ["Troll Blood", Color(0.419607847929, 0.01568627543747, 0.01568627543747), Vector3(0, 0.15, 0), Vector3(0.8, 0.3, 0.8)],
	"PhoenixFeather": ["Phoenix Feather", Color(0.94901961088181, 0.66274511814117, 0.42352941632271), Vector3(0, 0.1, 0), Vector3(0.6, 0.2, 0.6)],
	"BasiliskFang": ["Basilisk Fang", Color(0.71372550725937, 0.61568629741669, 0.45490196347237), Vector3(0, 0.1, 0), Vector3(0.8, 0.2, 0.8)],
	"UnicornHorn": ["Unicorn Horn Shavings", Color(0.96078431606293, 0.55686277151108, 0.69411766529083), Vector3(0, 0.4, 0), Vector3(0.7, 0.8, 0.7)],
	"CentaurHoof": ["Centaur Hoof Shavings", Color(0.61568629741669, 0.6235294342041, 0.61960786581039), Vector3(0, 0.4, -0.05), Vector3(0.8, 0.8, 0.4)],
	"HippogriffTalon": ["Hippogriff Talon", Color(0.07058823853731, 0.07058823853731, 0.07450980693102), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.2)],
	"GriffinFeather": ["Griffin Feather", Color(0.35294118523598, 0.31764706969261, 0.32941177487373), Vector3(0, 0.3, 0), Vector3(0.2, 0.6, 0.7)],
	"ChimeraFlame": ["Chimera Flame Essence", Color(0.90980392694473, 0, 0.0627451017499), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"GorgonBlood": ["GorgonBlood", Color(0.5799999833107, 0.27724000811577, 0.24359999597073), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"DryadSap": ["DryadSap", Color(0.48238503932953, 0.65542727708817, 0.40115711092949), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)]
}

func  _ready():
	$Mesh.mesh.material.albedo_color = IngredientInfo[Ingredient][1]
	var Location := str("res://assets/models/ingredients/" + Ingredient)
	$Mesh.set_mesh(load(str(Location + ".obj")))
	mat = StandardMaterial3D.new()
	mat.albedo_texture = load(str(Location) + ".png")
	$Mesh.set_surface_override_material(0, mat)
	$Collision.position = IngredientInfo[Ingredient][2]
	$Collision.shape.size = IngredientInfo[Ingredient][3]

func get_interaction_text():
	return "[center]Press E to grab [color=" + str(IngredientInfo[Ingredient][1].to_html()) + "]" + str(IngredientInfo[Ingredient][0]) + "[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	EventBus.HeldItem = str(Ingredient)

func _on_property_list_changed():
	print("Change")
	_ready()
