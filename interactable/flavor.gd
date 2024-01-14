extends Interactable

@export_enum("Strawberry","Banana","Pineapple","Blueberry","Watermelon","Orange") var Flavor:String

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
	if (EventBus.HeldItem == null) and not (PotionInfo.StockAmounts[Flavor][0] <= 0):
		PotionInfo.StockAmounts[Flavor][0] -= 1
		EventBus.HeldItem = str(Flavor)
		EventBus.emit_signal("HeldItemChanged")
	elif EventBus.HeldItem == str(Flavor):
		PotionInfo.StockAmounts[Flavor][0] += 1
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
	_reset()
	_check_contents()

func _check_contents():
	if (PotionInfo.StockAmounts[Flavor][0] <= 0):
		$Flavor.position.y = FlavorConfigs["Empty"][0]
		$Flavor.mesh.size.y = FlavorConfigs["Empty"][1]
	elif PotionInfo.StockAmounts[Flavor][0] <= PotionInfo.StockAmounts[Flavor][1] / 2.0:
		$Flavor.position.y = FlavorConfigs["Half"][0]
		$Flavor.mesh.size.y = FlavorConfigs["Half"][1]
	else:
		$Flavor.position.y = FlavorConfigs["Normal"][0]
		$Flavor.mesh.size.y = FlavorConfigs["Normal"][1]
