extends Node

# Signals
signal interaction(icon, text)
signal HeldItemChanged
signal BalanceChanged
signal DialogueFinished
signal JournalToggle(toggle:bool)
signal OrderFormToggle(toggle:bool)
signal DayDone
signal CustomerDone
signal BossProblem
signal Hint(hint:String)

# Crosshair textures
const CrosshairTex := "res://assets/textures/ui/crosshair.png"
const GrabTex := "res://assets/textures/ui/grab.png"
const ActionTex := "res://assets/textures/ui/action.png"

# basic potion/held item info needed
var HeldItem
var HeldEffect
var HeldFlavor := ""
var InsertedItems

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
var SentFeedback:bool = false

# Settings
var MasterVolume:float = 0
var MusicVolume:float = 0
var SfxVolume:float = 0
var MouseSens:float = 0.2
var Keybinds:Dictionary = {
	"forward" : InputMap.action_get_events("forward")[0],
	"backward" : InputMap.action_get_events("backward")[0],
	"left" : InputMap.action_get_events("left")[0],
	"right" : InputMap.action_get_events("right")[0],
	"jump" : InputMap.action_get_events("jump")[0],
	"interact" : InputMap.action_get_events("interact")[0],
	"pause" : InputMap.action_get_events("pause")[0],
	"id" : InputMap.action_get_events("id")[0],
	"sprint" : InputMap.action_get_events("sprint")[0],
	"dialogue" : InputMap.action_get_events("dialogue")[0]
}
var RadioSong:int = 1

func _ready():
	randomize()
	IdNum = randi_range(100000, 99999999)
	if FileAccess.file_exists(PlayerData):
		_load()
		_player_headshot()
		_assign_keys()
	else:
		_save()
	
	_discord_presence()

func _player_headshot():
	var image = Image.load_from_file("user://PlayerHeadshot.png")
	var texture = ImageTexture.create_from_image(image)
	PlayerHeadshot = texture

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
		"MOUSESENS" : MouseSens,
		"JOURNALINGREDIENTS" : PotionInfo.JournalIngredients,
		"KEYBINDS" : Keybinds,
		"SENTFEEDBACK" : SentFeedback,
		"RADIOSONG" : RadioSong,
		"STOCKAMOUNTS" : PotionInfo.StockAmounts
	}
	file.store_var(SavedData)

func _load():
	var file := FileAccess.open(PlayerData, FileAccess.READ)
	var LoadedData = file.get_var()
	PlayerName = LoadedData.PLAYERNAME
	PlayerOutfit = LoadedData.PLAYEROUTFIT
	Balance = LoadedData.BALANCE
	PlayerHeadshot = LoadedData.PLAYERHEADSHOT
	IdNum = LoadedData.IDNUM
	BossesBeaten = LoadedData.BOSSESBEATEN
	StartDate = LoadedData.STARTDATE
	CurrentLevel = LoadedData.CURRENTLEVEL
	DayNum = LoadedData.DAYNUM
	MasterVolume = LoadedData.MASTERVOLUME
	MusicVolume = LoadedData.MUSICVOLUME
	SfxVolume = LoadedData.SFXVOLUME
	MouseSens = LoadedData.MOUSESENS
	PotionInfo.JournalIngredients = LoadedData.JOURNALINGREDIENTS
	Keybinds = LoadedData.KEYBINDS
	SentFeedback = LoadedData.SENTFEEDBACK
	RadioSong = LoadedData.RADIOSONG
	Reputation = LoadedData.REPUTATION
	PotionInfo.StockAmounts = LoadedData.STOCKAMOUNTS

func _check_rep(_rep):
	var MaxRep := (BossesBeaten + 1) * 25
	Reputation = clamp(_rep, 0, MaxRep)

func _assign_keys():
	return # Doesn't work idk I'll come back to it later but
	# for now keybinds aren't saved
	var binds := ["forward", "backward", "left", "right", "jump", "interact", "pause", "id"]
	for key in binds:
		print(typeof(Keybinds[key]))
		InputMap.action_erase_events(key)
		InputMap.action_add_event(key, instance_from_id(Keybinds[key].object_id))

func _discord_presence():
	discord_sdk.app_id = 1132705061659758742
	discord_sdk.details = "(For legal reasons not potions)"
	discord_sdk.state = str("Day #" + str(DayNum))
	
	discord_sdk.large_image = "discordlogo"
	discord_sdk.large_image_text = "Free on itch.io!"
	
	discord_sdk.start_timestamp = int(Time.get_unix_time_from_system())
	
	# Saving this in case it's relevant later idk
	# discord_sdk.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00 remaining"
	
	discord_sdk.refresh()

func _update_presence():
	discord_sdk.state = str("Day #" + str(DayNum))
	discord_sdk.refresh()
