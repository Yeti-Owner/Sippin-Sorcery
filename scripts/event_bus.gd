extends Node

# Signals
signal interaction(icon, text)
signal HeldItemChanged
signal BalanceChanged
signal DialogueFinished
signal JournalToggle(toggle:bool)
signal EnablePlayer(toggle:bool)

# Crosshair textures
const CrosshairTex := "res://assets/textures/ui/crosshair.png"
const GrabTex := "res://assets/textures/ui/grab.png"
const ActionTex := "res://assets/textures/ui/action.png"

# basic potion/held item info needed
var HeldItem
var HeldEffect
var HeldFlavor := ""
var InsertedItems

var Dialogue = null : set = _set_dialogue

# Player Info
var PlayerName:String = "Callum"
var PlayerOutfit:Array = ["res://assets/models/characters/hats/Hair1.obj", "res://assets/models/characters/heads/Head1.obj", "res://assets/models/characters/torsos/torso1.obj", "res://assets/models/characters/pants/pants1.obj", "res://assets/models/characters/legs/leg1.obj", "res://assets/models/characters/hats/HairColor1.png"]
var Balance := 75
var PlayerHeadshot
var Reputation := 0

func _player_headshot():
	var image = Image.load_from_file("user://PlayerHeadshot.png")
	var texture = ImageTexture.create_from_image(image)
	PlayerHeadshot = texture

func _set_dialogue(_node):
	Dialogue = get_path_to(_node)
