extends Node3D

# Could prolly move elsewhere but idc
const FlavorSetup := {
	"Strawberry": Color(1, 0, 0),
	"Banana": Color(1, 0.92116665840149, 0.56999999284744),
	"Pineapple": Color(0.89803922176361, 1, 0.09411764889956),
	"Blueberry": Color(0.25, 0.37499988079071, 1),
	"Watermelon": Color(0.25098040699959, 0.81960785388947, 0.02352941222489),
	"Orange": Color(0.73000001907349, 0.41366666555405, 0),
	"Lasagna": Color(0.7569, 0.6078, 0.3059)
}

func _ready():
	if EventBus.HeldFlavor != "":
		$Liquid.mesh.material.albedo_color = FlavorSetup[EventBus.HeldFlavor]
