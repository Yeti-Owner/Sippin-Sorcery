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
const PlayerData := "user://save.dat"
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
	if FileAccess.file_exists(PlayerData):
		_load()
		_player_headshot()
	else:
		_save()
	
	_discord_presence()

func _player_headshot():
	var image = Image.load_from_file("user://PlayerHeadshot.png")
	var texture = ImageTexture.create_from_image(image)
	PlayerHeadshot = texture

func _set_dialogue(_node):
	Dialogue = get_path_to(_node)

func _check_rep(_rep):
	var MaxRep := (BossesBeaten + 1) * 25
	Reputation = clamp(_rep, 0, MaxRep)

func _save():
	var file := FileAccess.open(PlayerData, FileAccess.WRITE)
	var SavedData := {
		"PLAYERNAME" : PlayerName,
		"PLAYEROUTFIT" : PlayerOutfit,
		"BALANCE" : Balance,
		"PLAYERHEADSHOT" : PlayerHeadshot,
		"REPUTATION" : Reputation,
		"IDNUM" : IdNum,
		"BOSSESBEATEN" : BossesBeaten,
		"STARTDATE" : StartDate,
		"CURRENTLEVEL" : CurrentLevel,
		"DAYNUM" : DayNum,
		"MASTERVOLUME" : MasterVolume,
		"MUSICVOLUME" : MusicVolume,
		"SFXVOLUME" : SfxVolume,
		"MOUSESENS" : MouseSens
	}
	file.store_var(SavedData)

func _load():
	var file := FileAccess.open(PlayerData, FileAccess.READ)
	var LoadedData = file.get_var()
	PlayerName = LoadedData.PLAYERNAME
	PlayerOutfit = LoadedData.PLAYEROUTFIT
	Balance = LoadedData.BALANCE
	PlayerHeadshot = LoadedData.PLAYERHEADSHOT
	Reputation = LoadedData.REPUTATION
	IdNum = LoadedData.IDNUM
	BossesBeaten = LoadedData.BOSSESBEATEN
	StartDate = LoadedData.STARTDATE
	CurrentLevel = LoadedData.CURRENTLEVEL
	DayNum = LoadedData.DAYNUM
	MasterVolume = LoadedData.MASTERVOLUME
	MusicVolume = LoadedData.MUSICVOLUME
	SfxVolume = LoadedData.SFXVOLUME
	MouseSens = LoadedData.MOUSESENS

func _discord_presence():
	discord_sdk.app_id = 1132705061659758742
#	print("Discord working: " + str(discord_sdk.get_is_discord_working()))
	discord_sdk.details = "(For legal reasons not potions)"
	discord_sdk.state = str("Day #" + str(DayNum))
	
	discord_sdk.large_image = "cauldron"
	discord_sdk.large_image_text = "Free on itch.io!"
#	discord_sdk.small_image = "cauldron"
#	discord_sdk.small_image_text = "Free on itch.io!"
	
	discord_sdk.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	# discord_sdk.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00 remaining"
	
	discord_sdk.refresh() # Always refresh after changing the values!
