extends Interactable

@onready var InteractTimer := $InteractTimer
@onready var CookingTimer := $CookingTimer
@onready var particles := $JuiceParticles

var ItemsAdded:Array

const stages:Dictionary = {
	1: 0.208,
	2: 0.243,
	3: 0.278,
	4: 0.313,
	5: 0.348,
	6: 0.383,
	7: 0.418,
	8: 0.453,
	9: 0.488,
	10: 0.523,
	11: 0.558,
	12: 0.572
}

const FlavorList := ["Strawberry","Banana","Pineapple","Blueberry","Watermelon","Orange"]
const FlavorContent := {
	"Strawberry": Color(1, 0, 0),
	"Banana": Color(1, 0.92116665840149, 0.56999999284744),
	"Pineapple": Color(0.89803922176361, 1, 0.09411764889956),
	"Blueberry": Color(0.25, 0.37499988079071, 1),
	"Watermelon": Color(0.25098040699959, 0.81960785388947, 0.02352941222489),
	"Orange": Color(0.73000001907349, 0.41366666555405, 0)
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
			return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=cyan]add ingredient[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/cauldron.png"

func interact():
	if InteractTimer.is_stopped():
		if EventBus.HeldItem == null and ItemsAdded.size() > 0:
			_mix()
		elif EventBus.HeldItem != null:
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
