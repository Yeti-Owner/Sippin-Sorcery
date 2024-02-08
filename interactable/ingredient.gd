extends Interactable

@export_enum("DragonflyWing", "FairyWing", "KrakenInk", "MandrakeRoot", "MermaidScale",
	"SalamanderTail", "SpiderSilk", "TrollBlood", "PhoenixFeather", "BasiliskFang", 
	"UnicornHorn", "CentaurHoof", "HippogriffTalon", "GriffinFeather", "ChimeraFlame", 
	"GorgonBlood", "DryadSap") var Ingredient:String
var Amount:int
var mat

func  _ready():
	_check_contents()
	$CollisionShape3D.position = PotionInfo.IngredientPotions[Ingredient][2]
	$CollisionShape3D.shape.size = PotionInfo.IngredientPotions[Ingredient][3]

func get_interaction_text():
	var StockInfo:String = str(" (" + str(PotionInfo.StockAmounts[Ingredient][0]) + "/" + str(PotionInfo.StockAmounts[Ingredient][1]) + ")")
	if EventBus.HeldItem == null:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to grab [color=" + str(PotionInfo.IngredientPotions[Ingredient][1].to_html()) + "]" + str(PotionInfo.IngredientPotions[Ingredient][0]) + StockInfo + "[/color][/center]"
	elif EventBus.HeldItem == str(Ingredient):
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=" + str(PotionInfo.IngredientPotions[Ingredient][1].to_html()) + "]put it back" + StockInfo + "[/color][/center]"
	else:
		return "[center]your hands are [color=" + str(PotionInfo.IngredientPotions[Ingredient][1].to_html()) + "]full" + StockInfo + "[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if (EventBus.HeldItem == null) and not (PotionInfo.StockAmounts[Ingredient][0] <= 0):
		$GrabSound.pitch_scale = randf_range(1.01, 1.2)
		$GrabSound.play()
		PotionInfo.StockAmounts[Ingredient][0] -= 1
		EventBus.HeldItem = str(Ingredient)
		EventBus.emit_signal("HeldItemChanged")
	elif EventBus.HeldItem == str(Ingredient):
		$GrabSound.pitch_scale = randf_range(0.8, 0.99)
		$GrabSound.play()
		PotionInfo.StockAmounts[Ingredient][0] += 1
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
	_reset()
	_check_contents()

func _check_contents():
	var IngredientModel:String = Ingredient
	if PotionInfo.StockAmounts[Ingredient][0] <= 0:
		IngredientModel = IngredientModel + "Empty"
	elif PotionInfo.StockAmounts[Ingredient][0] <= PotionInfo.StockAmounts[Ingredient][1] / 2.0:
		IngredientModel = IngredientModel + "Half"
	
	# Load Model
	var Location := str("res://assets/models/ingredients/" + IngredientModel)
	$Mesh.set_mesh(load(str(Location + ".obj")))
	
	# Load Model Texture/Color
	mat = StandardMaterial3D.new()
	mat.albedo_texture = load(str(Location) + ".png")
	$Mesh.set_surface_override_material(0, mat)

func _on_property_list_changed():
	_ready()

func _on_stock_timer_timeout():
	_check_contents()
