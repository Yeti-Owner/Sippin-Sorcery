@tool
extends Interactable

@export_enum("DragonflyWing", "FairyWing", "KrakenInk", "MandrakeRoot", "MermaidScale",
	"SalamanderTail", "SpiderSilk", "TrollBlood", "PhoenixFeather", "BasiliskFang", 
	"UnicornHorn", "CentaurHoof", "HippogriffTalon", "GriffinFeather", "ChimeraFlame", 
	"GorgonBlood", "DryadSap") var Ingredient:String

var mat

func  _ready():
	$Mesh.mesh.material.albedo_color = PotionInfo.IngredientPotions[Ingredient][1]
	var Location := str("res://assets/models/ingredients/" + Ingredient)
	$Mesh.set_mesh(load(str(Location + ".obj")))
	mat = StandardMaterial3D.new()
	mat.albedo_texture = load(str(Location) + ".png")
	$Mesh.set_surface_override_material(0, mat)
	$Collision.position = PotionInfo.IngredientPotions[Ingredient][2]
	$Collision.shape.size = PotionInfo.IngredientPotions[Ingredient][3]

func get_interaction_text():
	if EventBus.HeldItem == null:
		return "[center]Press E to grab [color=" + str(PotionInfo.IngredientPotions[Ingredient][1].to_html()) + "]" + str(PotionInfo.IngredientPotions[Ingredient][0]) + "[/color][/center]"
	elif EventBus.HeldItem == str(Ingredient):
		return "[center]Press E to [color=" + str(PotionInfo.IngredientPotions[Ingredient][1].to_html()) + "]put it back[/color][/center]"
	else:
		return "[center]your hands are [color=" + str(PotionInfo.IngredientPotions[Ingredient][1].to_html()) + "]full[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if EventBus.HeldItem == null:
		EventBus.HeldItem = str(Ingredient)
		EventBus.emit_signal("HeldItemChanged")
	elif EventBus.HeldItem == str(Ingredient):
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
	

func _on_property_list_changed():
	_ready()
