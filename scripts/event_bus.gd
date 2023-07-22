extends Node

# Signals
signal interaction(icon, text)
signal HeldItemChanged
signal BalanceChanged
signal DialogueFinished
signal JournalToggle(toggle:bool)
signal EnablePlayer(toggle:bool)
signal DayDone
signal CustomerDone
signal Fade(type:String)

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
var Reputation := 0 : set = _check_rep
var IdNum:int
var BossesBeaten:int = 0
var StartDate:String = Time.get_date_string_from_system()

# Misc
var ActiveCustomers:int = 0
var CurrentLevel:String = "res://scenes/char_customization.tscn"
var DayNum:int = 1

# Settings
var MasterVolume:float = 0
var MusicVolume:float = 0
var SfxVolume:float = 0
var MouseSens:float = 0.4

func _ready():
	randomize()
	IdNum = randi_range(100000, 99999999)

func _player_headshot():
	var image = Image.load_from_file("user://PlayerHeadshot.png")
	var texture = ImageTexture.create_from_image(image)
	PlayerHeadshot = texture

func _set_dialogue(_node):
	Dialogue = get_path_to(_node)

func _check_rep(_rep):
	var MaxRep := (BossesBeaten + 1) * 25
	Reputation = clamp(_rep, 0, MaxRep)
