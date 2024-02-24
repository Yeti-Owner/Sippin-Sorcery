extends Interactable

@onready var InteractTimer := $InteractTimer
@onready var CookingTimer := $CookingTimer
@onready var particles := $JuiceParticles

var ItemsAdded:Array

const stages:Dictionary = {
	1: 0.27,
	2: 0.3,
	3: 0.33,
	4: 0.35,
	5: 0.38,
	6: 0.4,
	7: 0.42,
	8: 0.45,
	9: 0.49,
	10: 0.52,
	11: 0.56,
	12: 0.572
}

const BannedList := ["Juice","Frog"]
const FlavorList := ["Strawberry","Banana","Pineapple","Blueberry","Watermelon","Orange","Lasagna"]
const FlavorContent := {
	"Strawberry": Color(1, 0, 0),
	"Banana": Color(1, 0.92116665840149, 0.56999999284744),
	"Pineapple": Color(0.89803922176361, 1, 0.09411764889956),
	"Blueberry": Color(0.25, 0.37499988079071, 1),
	"Watermelon": Color(0.25098040699959, 0.81960785388947, 0.02352941222489),
	"Orange": Color(0.73000001907349, 0.41366666555405, 0),
	"Lasagna": Color(0.7569, 0.6078, 0.3059)
}
const DefaultGreen := Color(0.2392156869173, 0.67058825492859, 0.10588235408068)

var content := ""

func _ready():
	randomize()

func get_interaction_text():
	if InteractTimer.is_stopped():
		if EventBus.HeldItem == null and ItemsAdded.size() == 0:
			return "[center]An ordinary cauldron, add ingredients and mix to make [color=orange]juice[/color][/center]"
		elif EventBus.HeldItem == null and ItemsAdded.size() >= 0:
			return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to mix some [color=orange]juice[/color][/center]"
		elif EventBus.HeldItem != null:
			return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=orange]add ingredient[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/cauldron.png"

func interact():
	if InteractTimer.is_stopped():
		if EventBus.HeldItem == null and ItemsAdded.size() > 0:
			_mix()
		elif (EventBus.HeldItem != null) and not (BannedList.has(EventBus.HeldItem)):
			$AddItem.pitch_scale = randf_range(0.7, 1.2)
			$AddItem.play()
			if FlavorList.has(EventBus.HeldItem):
				_juice(true)
			else:
				_juice()
				ItemsAdded.append(EventBus.HeldItem)
				EventBus.InsertedItems = str(EventBus.HeldItem)
			EventBus.HeldItem = null
			EventBus.emit_signal("HeldItemChanged")
		elif (EventBus.HeldItem == "Frog"):
			EventBus.Hint.emit("Don't put a Frog in there :(")
		InteractTimer.start()

func _mix():
	$AudioStreamPlayer3D.play()
	_particles()
	var Effects = []
	while ItemsAdded.size() > 0:
		var amt = min(ItemsAdded.count(ItemsAdded[0])-1, 2)
		Effects.append(PotionInfo.CauldronPotions[ItemsAdded[0]][amt])
		var tmp = ItemsAdded[0]
		while ItemsAdded.has(tmp):
			ItemsAdded.erase(tmp)
	EventBus.HeldFlavor = content
	content = ""
	EventBus.HeldEffect = Effects
	EventBus.HeldItem = "Juice"
	EventBus.emit_signal("HeldItemChanged")
	_juice()
	$Juice.mesh.material.albedo_color = DefaultGreen

func _juice(FlavorAdded:bool = false):
	if ItemsAdded.size() == 0:
		$Juice.visible = false
	else:
		$Juice.visible = true
		$Juice.position.y = stages[min(11, ItemsAdded.size())]
	
	if FlavorAdded:
		content = EventBus.HeldItem
		$Juice.mesh.material.albedo_color = FlavorContent[EventBus.HeldItem]

func _particles():
	particles.position.y = $Juice.position.y
	particles.draw_pass_1.material.albedo_color = $Juice.mesh.material.albedo_color
	particles.set_emitting(true)

func _on_interact_timer_timeout():
	_reset()
