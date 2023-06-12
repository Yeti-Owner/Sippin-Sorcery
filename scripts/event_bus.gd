extends Node

signal interaction(icon, text)
signal HeldItemChanged
signal BalanceChanged
signal DialogueFinished
signal JournalToggle(toggle:bool)
signal EnablePlayer(toggle:bool)

const CrosshairTex := "res://assets/textures/ui/crosshair.png"
const GrabTex := "res://assets/textures/ui/grab.png"
const ActionTex := "res://assets/textures/ui/action.png"

var HeldItem
var HeldEffect
var HeldFlavor := ""
var InsertedItems
var Balance := 50

var Dialogue = null : set = _set_dialogue

var PlayerName:String = "Callum"
var PlayerOutfit:Array = ["res://assets/models/characters/hats/Hair1.obj", "res://assets/models/characters/heads/Head1.obj", "res://assets/models/characters/torsos/torso1.obj", "res://assets/models/characters/pants/pants1.obj", "res://assets/models/characters/legs/leg1.obj", "res://assets/models/characters/hats/HairColor1.png"]

func _set_dialogue(_node):
	Dialogue = get_path_to(_node)
