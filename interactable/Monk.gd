extends Interactable

@onready var FlipPage := $FlipPageSound
@onready var OpenClose := $OpenCloseSound
var Active:bool = false
var Cost:int = 10

const EffectsDescription := {
	"MandrakeRoot": ["Resistance to common illnesses", "Confusion","Straightforward health boost"],
	"FairyWing": ["Better flexibility", "Creativity","Simple speed boost"],
	"TrollBlood": ["Courage", "Increased Stamina/endurance", "Vastly improved strength"],
	"KrakenInk": ["Worsened vision or blindness", "Removed olfactory sense", "Pure poison"],
	"SalamanderTail": ["Improved cold resistance", "Improved fire resistance", "Numbing effect"],
	"MermaidScale": ["Enhanced swimming", "Lungs to gills, will breathe underwater", "Talk to fish"],
	"SpiderSilk": ["Sticky grip", "Night vision", "Turn invisible"],
	"DragonflyWing": ["Affected less by gravity; weigh less", "Better hearing", "Slight temporary hovering ability"],
	"PhoenixFeather": ["Potent sleep effect", "Improved luck", "Improved fire resistance"],
	"BasiliskFang": ["Petrifies the user", "Strong poison", "Improved muscles/strength"],
	"UnicornHorn": ["Purity", "Outright health boost", "Overall improved senses"],
	"CentaurHoof": ["Improved speed", "Stability", "Improved jumping ability"],
	"HippogriffTalon": ["Precision", "Numbing", "Better dexterity"],
	"GriffinFeather": ["Alertness", "Better perception", "Improved electrical resistance"],
	"ChimeraFlame": ["Improved strength", "Improved explosion resistance?", "Immunity to smoke inhalation"],
	"GorgonBlood": ["Become resistant to petrification", "Poison", "Better sense of smell"],
	"DryadSap": ["Charisma", "Health", "Ability to control plants temporarily"]
}

# Journal stuff
@onready var PotionName := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Name
@onready var PotionIcon := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/PotionTex
@onready var PotionDesc := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/LeftPage/VBoxContainer/Description
@onready var Effect1Text := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect1/Text
@onready var Effect2Text := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect2/Text
@onready var Effect3Text := $MonkShenanigans/Journal/TextureRect/MarginContainer/HBoxContainer/RightPage/VBoxContainer/Effect3/Text

var CurrentPage:int = 0
const PageOrder:Array = ["MandrakeRoot","BasiliskFang","CentaurHoof","ChimeraFlame","DragonflyWing","DryadSap","FairyWing","GorgonBlood","GriffinFeather","HippogriffTalon","KrakenInk","MermaidScale","PhoenixFeather","SalamanderTail","SpiderSilk","TrollBlood","UnicornHorn"]
var LengthLimit:int = 49

func _ready():
	if EventBus.MetAlton == true:
		$"../Door/Lock".queue_free()
		$"../Door".rotation_degrees = Vector3(0, -90, 0)
	
	$MonkShenanigans/CostLabel.text = "$" + str(Cost) + " Per Effect\nNo Refunds"
	randomize()
	$MonkMesh/AnimationPlayer.play("idle")
	$MonkShenanigans.visible = false

func get_interaction_text():
	if Active == false:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=DARK_BLUE]talk[/color] to Monk Alton[/center]"
	else:
		return ""

func get_interaction_icon():
	if Active == false:
		return EventBus.ActionTex
	else:
		return null

func interact():
	if Active == false:
		_pop_up()

func _physics_process(_delta):
	if ((Input.is_action_just_pressed("interact")) or (Input.is_action_just_pressed("pause"))) and (Active == true):
		self._hide()

func _pop_up():
	EventBus.DisableInteract.emit(true)
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	_set_page(CurrentPage)
	$MonkShenanigans.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$DelayTimer.start()

func _hide():
	EventBus.DisableInteract.emit(false)
	OpenClose.pitch_scale = randf_range(0.8, 1.2)
	OpenClose.play()
	$MonkShenanigans.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$DelayTimer.stop()
	Active = false

func _on_delay_timer_timeout():
	Active = true
	_reset()

func _on_leave_area_body_exited(body):
	if (body.name == "Player") and (Active == true):
		_hide()

func _on_click_out_pressed():
	_hide()

func _set_page(_page):
	var page = clamp(_page, 0, 16)
	CurrentPage = page
	
	var potionData = PotionInfo.JournalPotions[page]
	PotionName.text = potionData[0]
	PotionIcon.texture = load(potionData[1])
	PotionDesc.text = potionData[2]
	
	# This looks really poor but it's actually really well optimized
	# Basically just reduces number of lookups drastically
	var ref = PotionInfo.JournalIngredients[PageOrder[page]]
	var ref0Length = ref[0].length()
	var ref1Length = ref[1].length()
	var ref2Length = ref[2].length()
	
	if ref0Length < LengthLimit:
		Effect1Text.text = "\n[color=BLACK]Effect 1:\n- "
		Effect1Text.get_parent().disabled = true
	else:
		Effect1Text.text = ref[0]
		Effect1Text.get_parent().disabled = false
	
	if ref1Length < LengthLimit:
		Effect2Text.text = "\n[color=BLACK]Effect 2:\n- "
		Effect2Text.get_parent().disabled = true
	else:
		Effect2Text.text = ref[1]
		Effect2Text.get_parent().disabled = false
	
	if ref2Length < LengthLimit:
		Effect3Text.text = "\n[color=BLACK]Effect 3:\n- "
		Effect3Text.get_parent().disabled = true
	else:
		Effect3Text.text = ref[2]
		Effect3Text.get_parent().disabled = false




# In future collapse this to 1 signal with var
func _on_left_pressed():
	_flip_sound()
	_set_page(CurrentPage - 1)

func _on_right_pressed():
	_flip_sound()
	_set_page(CurrentPage + 1)

func _flip_sound():
	FlipPage.pitch_scale = randf_range(0.9, 1.1)
	FlipPage.play()


func _clarify(EffectNum:int):
	# PageOrder[CurrentPage] gives ingredient (MandrakeRoot)
	# EffectNum will be 0, 1, 2 for the array of effect
	var Ref:Array = PotionInfo.JournalIngredients[PageOrder[CurrentPage]]
	
	if (Ref[EffectNum].length() < LengthLimit) or (EventBus.Balance < Cost): # if not experimented !!! ALSO CHECK BALANCE !!!
		return
	else:
		_write_sound()
		var CurrentEntry:String = PotionInfo.JournalIngredients[PageOrder[CurrentPage]][EffectNum]
		if ("Alton" in CurrentEntry) or ("Duane" in CurrentEntry):
			return
		
		var NewEntry:String = ""
		EventBus.Balance -= Cost
		EventBus.emit_signal("BalanceChanged")
		NewEntry = "\n[color=BLACK]Effect " + str(EffectNum + 1) + ":\n- "
		NewEntry = NewEntry + EffectsDescription[PageOrder[CurrentPage]][EffectNum]
		NewEntry = NewEntry + " ([color=DARK_BLUE]Alton[/color])"
		PotionInfo.JournalIngredients[PageOrder[CurrentPage]][EffectNum] = NewEntry
		_set_page(CurrentPage)

func _on_effect_pressed(Num):
	_clarify(Num)

func _write_sound():
	$WriteSound.pitch_scale = randf_range(0.8, 1.2)
	$WriteSound.play()

# Makes the head move to look at player
func _process(_delta):
	if get_node_or_null(EventBus.PlayerPath) != null:
		$MonkMesh/Head.look_at(get_node(EventBus.PlayerPath).position)


