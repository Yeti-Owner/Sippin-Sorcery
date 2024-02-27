extends Interactable

@export_enum("Strawberry","Banana","Pineapple","Blueberry","Watermelon","Orange") var Flavor:String

# in future store elsewhere
const FlavorSetup := {
	"Strawberry": Color(1, 0, 0),
	"Banana": Color(1, 0.92116665840149, 0.56999999284744),
	"Pineapple": Color(0.89803922176361, 1, 0.09411764889956),
	"Blueberry": Color(0.25, 0.37499988079071, 1),
	"Watermelon": Color(0.25098040699959, 0.81960785388947, 0.02352941222489),
	"Orange": Color(0.73000001907349, 0.41366666555405, 0),
}
# Stage/State : [Position, Size]
const FlavorConfigs := {
	"Normal" : [0.45, 0.7],
	"Half" : [0.275, 0.35],
	"Empty" : [0.11, 0.02]
}

func  _ready():
	$Flavor.mesh.material.albedo_color = FlavorSetup[Flavor]
	_check_contents()

func get_interaction_text():
	var StockInfo:String = str(" (" + str(PotionInfo.StockAmounts[Flavor][0]) + "/" + str(PotionInfo.StockAmounts[Flavor][1]) + ")")
	if EventBus.HeldItem == null:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to grab [color=" + str(FlavorSetup[Flavor].to_html()) + "]" + str(Flavor) + StockInfo + "[/color][/center]")
	elif EventBus.HeldItem == str(Flavor):
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=" + str(FlavorSetup[Flavor].to_html()) + "]put it back " + StockInfo + "[/color][/center]"
	else:
		return "[center]your hands are [color=" + str(FlavorSetup[Flavor].to_html()) + "]full" + StockInfo + "[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	var stockAmounts = PotionInfo.StockAmounts[Flavor]
	var heldItem = EventBus.HeldItem
	var glassSound = $GlassSound
	
	if (heldItem == null) and not (stockAmounts[0] <= 0):
		glassSound.pitch_scale = randf_range(1.01, 1.2)
		glassSound.play()
		stockAmounts[0] -= 1
		EventBus.HeldItem = Flavor
		EventBus.emit_signal("HeldItemChanged")
	elif heldItem == Flavor:
		glassSound.pitch_scale = randf_range(0.8, 0.99)
		glassSound.play()
		stockAmounts[0] += 1
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
		_reset()
	_check_contents()


func _check_contents():
	var stockAmounts = PotionInfo.StockAmounts[Flavor]
	var positionAndSize = FlavorConfigs["Normal"]
	
	if stockAmounts[0] <= 0:
		positionAndSize = FlavorConfigs["Empty"]
	elif stockAmounts[0] <= stockAmounts[1] / 2.0:
		positionAndSize = FlavorConfigs["Half"]
	
	$Flavor.position.y = positionAndSize[0]
	$Flavor.mesh.size.y = positionAndSize[1]

func _on_timer_timeout():
	_check_contents()
