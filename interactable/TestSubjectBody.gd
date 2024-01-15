extends Interactable

@onready var color := Color(randf(), randf(), randf())
@onready var SpeechBubble := $SpeechBubble

const EffectsList := {
	"sleep": "I feel really sleepy now, I'm gonna go lie down",
	"resistance": "I don't know why, but suddenly it's like I'm tougher than usual. Like nothing can touch me, you know?",
	"confusion": "Whoa, everything's kinda spinning in my head. Like, I can't even remember what I had for breakfast this morning.",
	"health": "Man, I was feeling a bit ill earlier, but it's totally cleared up thank you!",
	"flexibility": "I swear, my body feels all loose and limber, like I could bend in crazy ways.",
	"creativity": "My brainfog cleared up, I have so many new ideas right now!",
	"speed": "I feel like I've been zapped with a dose of lightning! My legs are moving quicker than I thought possible.",
	"courage": "I don't know what came over me, but suddenly I'm braver than a lion. Nothing scares me anymore! Let's do this!",
	"stamina": "I could run laps around the castle and not even lose my breath! It's like I've got an endless supply of energy.",
	"strength": "I could lift a heavy cauldron like it's a feather! I'm seriously strong right now.",
	"badVision": "Uh-oh, everything's a bit blurry. Is this supposed to happen? I can't see straight!",
	"badSmell": "I can't smell a thing, very weird. Is this a potion gone wrong or something?",
	"poison": "Ugh, I don't feel so good. My stomach's churning, and I've got this weird taste in my mouth. Something's definitely not right.",
	"coldRes": "I'm not shivering anymore, even though it's freezing outside. It's like I've got my own personal heater keeping me warm!",
	"fireRes": "Whoa, did someone just turn up the heat? I'm not sweating or feeling uncomfortable at all. I'm like fireproof or something!",
	"lessPain": "I stubbed my toe earlier, but it doesn't even hurt now. It's like the pain was numbed. Weird, but useful!",
	"swimming": "I feel an urge to go swimming. I could swim laps over anyone! I know I can glide through the water so effortlessly, awesome!",
	"underwaterBreathing": "My neck feels weird, it's like I've got gills or something.",
	"fishTalk": "Something is off, I feel a strange urge to go swimming, I swear I can hear the fish from here. And they're talking?!",
	"sticky": "My hands are all tacky and clingy. Everything I touch just sticks to me. It's like I've got super glue on my fingers.",
	"nightVision": "It's dark out here, but I can see through the shadows crystal clear. It's like I've got these cool night vision goggles or something.",
	"invisibility": "Subject turned invisible?",
	"lessWeight": "I feel so light on my feet, like I could float away if I'm not careful. It's like gravity has forgotten about me!",
	"hearing": "I can hear a pin drop from across the room. My ears are super sensitive right now. It's like I've got supersonic hearing or something.",
	"hovering": "Look, I'm floating! I can hover a few inches off the ground!",
	"luck": "I don't know what's happening, but I feel like buying a lottery ticket. I just know I can win!",
	"petrification": "Subject was petrified.",
	"purity": "I feel so pure and clean, like I just took the most refreshing shower ever. It's like I've been cleansed from the inside out.",
	"heightenedSenses": "I can see a bit better, hear footsteps a touch louder, and my smell is maybe better. My senses just improved that's nice.",
	"stability": "Whoa, I feel steady on my feet. I could balance on one leg without wobbling at all.",
	"jumping": "WOW I can jump super high, my legs feel CRAZY, it's like gravity doesn't apply to me anymore.",
	"precision": "I can pick up the tiniest objects with pinpoint accuracy. It's like my fingers have become precision tools.",
	"dexterity": "I can twist and turn my fingers in ways I never thought possible. It's like I've got the hands of a master magician.",
	"alertness": "Wow I'm wide awake, like I've had a whole cauldron of coffee. I need to run a marathon to cool off.",
	"perception": "Colors seem more vibrant, the juice must increase your perception!",
	"electricalRes": "I feel rubbery, not in a stretchy way like an insulated way. odd.",
	"explosionRes": "I feel off, I can't explain it but I know I could survive a bomb being dropped on me, mark it down as explosion resistance dude.",
	"smokeImmunity": "My lungs feel stronger, I couldn't breathe underwater or anything but you get the idea.",
	"petrificationRes": "Yeah this one is a dud, nothing has changed except I feel like I'm protected from petrification. I don't want to test it though.",
	"betterSmell": "I can smell the school from here but we must be miles away?!",
	"charisma": "I've got charm oozing out of me. I can tell you can't resist my words, I'm gonna convince the teachers to not assign homework!",
	"plantControl": "Is it just me or is the grass looking at me? I can control them it's like I'm the king of the greenery!",
	"monkey": "Yeah, I'm not drinking that.",
	"water": "I feel nothing."
}
var AdditionalList1 := ["hovering","invisibility","speed","strength","charisma"]
var AdditionalList2 := ["petrification"]

var cost := 25

func _ready():
	randomize()
	
	await  get_tree().process_frame
	await  get_tree().process_frame
	await  get_tree().process_frame
	if get_parent().CharName == "Michael Jackson":
		get_parent().get_node("BodyMeshes").rotation_degrees.y += 180

func get_interaction_text():
	if EventBus.HeldItem == "Juice" and EventBus.Balance >= cost:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to test juice with [color=" + str(color.to_html()) + "] " + get_parent().CharName + "[/color] (Costs $" + str(cost) + ")[/center]")
	elif EventBus.HeldItem == "Juice" and EventBus.Balance < cost:
		return str("[center]Not enough money, [color=GOLD]$" + str(cost) + " required[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + get_parent().CharName + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if EventBus.HeldItem == "Juice" and EventBus.Balance >= cost:
		get_parent().get_node("Sfx").play()
		EventBus.Balance -= cost
		_test_juice(EventBus.HeldEffect)
		EventBus.HeldFlavor = ""
		EventBus.HeldEffect = null
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
		EventBus.emit_signal("BalanceChanged")

func _test_juice(effects:Array):
	var Results := ""
	if effects.size() > 1:
		var Responses := ["I feel too many effects to sort them out, sorry I can't help.", "Too much is going on I can't separate them.", "Geez dude I'm feeling a lot, use less ingredients next time.","I'm gonna throw up, too many effects.", "Dude, never do that again, too many effects."]
		Results = Responses[randi() % Responses.size()]
		
		SpeechBubble._talk(Results)
		$Timer.start(4)
		return
	else:
		Results = EffectsList[effects[0]]
		_record_journal(Results, effects[0])
	
	
	if AdditionalList1.has(effects[0]):
		_effect(effects[0], Results)
		$Timer.start(4)
		return
	elif AdditionalList2.has(effects[0]):
		SpeechBubble._talk("...")
		$Timer.start(8)
		return
	
	SpeechBubble._talk(Results)
	$Timer.start(4)

func _record_journal(result, effect):
	if (effect == "monkey") or (effect == "water"):
		return
	
	var NewEntry:String = str(result + " ([color=" + str(color.to_html()) + "]" + get_parent().CharName + "[/color]" + ")")
	PotionInfo.JournalIngredients[EventBus.InsertedItems] = PotionInfo.JournalIngredients[EventBus.InsertedItems].format({effect: str(NewEntry)})

func _effect(effect:String, _results:String):
	match effect:
		"hovering":
			var tween := get_tree().create_tween()
			tween.tween_property(get_parent(), "position:y", get_parent().position.y + 0.8, 0.75).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(get_parent(), "position:y", get_parent().position.y + 0.8, 2)
			tween.tween_property(get_parent(), "position:y", get_parent().position.y, 0.75).set_trans(Tween.TRANS_CUBIC)
			SpeechBubble._talk(_results)
		"invisibility":
			get_parent().get_node("BodyMeshes").visible = false
			SpeechBubble._talk("I don't feel any different, you sure you mixed it right?")
		"speed":
			get_parent().speed = 0.3
			SpeechBubble._talk(_results)
		"strength":
			get_parent().get_node("BodyMeshes/Arm1").scale = Vector3(1.5, 1, 1.5)
			get_parent().get_node("BodyMeshes/Arm2").scale = Vector3(1.5, 1, 1.5)
			SpeechBubble._talk(_results)
		"charisma":
			var CharismaEffects := preload("res://scenes/objects/charisma_hearts.tscn")
			var CE := CharismaEffects.instantiate()
			self.add_child(CE)
			CE.emitting = true
			SpeechBubble._talk(_results)
