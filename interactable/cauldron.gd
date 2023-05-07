extends Interactable

@onready var InteractTimer := $InteractTimer
@onready var CookingTimer := $CookingTimer

var ItemsAdded:Array
var ingredientEffects = {
	"MandrakeRoot": ["resistance", "confusion", "health"],
	"FairyWing": ["flexibility", "agility", "speed"],
	"TrollBlood": ["courage", "stamina", "strength"],
	"KrakenInk": ["badVision", "badSmell", "poison"],
	"SalamanderTail": ["coldRes", "fireRes", "lessPain"],
	"MermaidScale": ["swimming", "underwaterBreathing", "fishTalk"],
	"SpiderSilk": ["sticky", "nightVision", "invisibility"],
	"DragonflyWing": ["lessWeight", "hearing", "hovering"]
}


func get_interaction_text():
	if InteractTimer.is_stopped():
		if EventBus.HeldItem == null and ItemsAdded.size() == 0:
			return "[center]An ordinary cauldron, add ingredients and mix to make [color=orange]juice[/color][/center]"
		elif EventBus.HeldItem == null and ItemsAdded.size() >= 0:
			return "[center]Press E to mix some [color=orange]juice[/color][/center]"
		elif EventBus.HeldItem != null:
			return str("[center]Press E to add [color=cyan]" + str(EventBus.HeldItem) + "[/color][/center]")

func get_interaction_icon():
	return "res://assets/textures/ui/cauldron.png"

func interact():
	if InteractTimer.is_stopped():
		if EventBus.HeldItem == null and ItemsAdded.size() >= 0:
			_mix()
		elif EventBus.HeldItem != null:
			ItemsAdded.append(EventBus.HeldItem)
			EventBus.HeldItem = null
		InteractTimer.start()

func _mix():
	var Effects = []
	
	while ItemsAdded.size() > 0:
		var amt = min(ItemsAdded.count(ItemsAdded[0])-1, 2)
		Effects.append(ingredientEffects[ItemsAdded[0]][amt])
		var tmp = ItemsAdded[0]
		while ItemsAdded.has(tmp):
			ItemsAdded.erase(tmp)
	
	print(Effects)
#	Effects.append(ingredientEffects)
#	for item in ItemsAdded:
#
#		var itemEffects = ingredientEffects[item]
#		for i in range(min(3, len(itemEffects))):
#			Effects.append(itemEffects[i])
#	print(Effects)

