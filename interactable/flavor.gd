extends Interactable

@export_enum("Strawberry","Banana","Pineapple","Blueberry","Watermelon","Orange","Water") var Flavor:String

const FlavorSetup := {
	"Strawberry": Color(1, 0, 0),
	"Banana": Color(1, 0.92116665840149, 0.56999999284744),
	"Pineapple": Color(0.89803922176361, 1, 0.09411764889956),
	"Blueberry": Color(0.25, 0.37499988079071, 1),
	"Watermelon": Color(0.25098040699959, 0.81960785388947, 0.02352941222489),
	"Orange": Color(0.73000001907349, 0.41366666555405, 0),
	"Water": Color(0, 0.5686274766922, 0.75686275959015)
}

func  _ready():
	$Flavor.mesh.material.albedo_color = FlavorSetup[Flavor]

func get_interaction_text():
	if EventBus.HeldItem == null:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to grab [color=" + str(FlavorSetup[Flavor].to_html()) + "]" + str(Flavor) + "[/color][/center]")
	elif EventBus.HeldItem == str(Flavor):
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=" + str(FlavorSetup[Flavor].to_html()) + "]put it back[/color][/center]"
	else:
		return "[center]your hands are [color=" + str(FlavorSetup[Flavor].to_html()) + "]full[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if EventBus.HeldItem == null:
		EventBus.HeldItem = str(Flavor)
		EventBus.emit_signal("HeldItemChanged")
	elif EventBus.HeldItem == str(Flavor):
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
