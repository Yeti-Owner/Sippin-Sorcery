extends Interactable

@onready var color := Color(randf(), randf(), randf())
@onready var SpeechBubble := $SpeechBubble

const EffectsList := {
	"sleep": "I feel really sleepy now, I'm going to lie down",
	"resistance": "I feel a little bit better.",
	"confusion": "Whoa, everything's kind of spinning in my head. I don't feel well.",
	"health": "Man, I was feeling a bit ill earlier, but it's totally cleared up thank you!",
	"flexibility": "I feel super loose, I could touch my toes right now.",
	"creativity": "My brain fog cleared up, I have so many new ideas right now!",
	"speed": "I feel like I downed 20 coffees and can win a marathon!",
	"courage": "I feel like nothing scares me anymore, I want to fight someone!",
	"stamina": "I could run laps around the village for hours I've got an endless supply of energy.",
	"strength": "I could lift a heavy cauldron like it's a feather! I'm seriously strong right now.",
	"badVision": "Everything's blurry! It's all getting dark, is this supposed to happen?!",
	"badSmell": "I can't smell a thing, is this a potion gone wrong or something?",
	"poison": "Ugh, I don't feel so good, and I can taste blood. Something's definitely not right.",
	"coldRes": "I'm not shivering anymore, even though it's freezing outside.",
	"fireRes": "I feel colder, the sun isn't as warm now.",
	"lessPain": "I stubbed my toe earlier, but it doesn't even hurt now. The pain is just a dull ache.",
	"swimming": "I feel an urge to go swimming.",
	"underwaterBreathing": "My neck feels weird, it's like I've grown gills or something.",
	"fishTalk": "I don't feel any different, feel like going swimming though.",
	"sticky": "My hands are all gross and clingy, everything is sticking to me.",
	"nightVision": "It's dark out here, but I can see everything crystal clear, neat.",
	"invisibility": "Subject turned invisible?",
	"lessWeight": "I feel so light on my feet, like I could float away if I'm not careful.",
	"hearing": "My ears are super sensitive right now, I can hear people in their own homes?",
	"hovering": "Look, I'm floating! I can hover a few inches off the ground!",
	"luck": "I don't know what's happening, but I feel like buying a lottery ticket. I just know I can win!",
	"petrification": "Subject was petrified.",
	"purity": "I feel brand new, like I just took the most refreshing shower ever or some health cleanse.",
	"heightenedSenses": "I can see a tad further, hear things a touch louder, and my smell is maybe better.",
	"stability": "I feel super steady on my feet like I could walk a trapeze line.",
	"jumping": "My legs feel tingly I bet I could jump super high.",
	"precision": "I feel super focused, I could pick up the tiniest objects with perfect accuracy.",
	"dexterity": "My fingers feel fast and weird.",
	"alertness": "Wow I'm wide awake, like I've had a whole cauldron of coffee.",
	"perception": "Colors seem more vibrant, the juice must increase your perception!",
	"electricalRes": "I feel rubbery, not in a stretchy way like an insulated way, odd.",
	"explosionRes": "I feel off, I can't explain it but I know I could survive a bomb being dropped on me, mark it down as explosion resistance dude.",
	"smokeImmunity": "My lungs feel stronger, I couldn't breathe underwater or anything, but you get the idea.",
	"petrificationRes": "I don't get it, nothing feels different?",
	"betterSmell": "I can smell the school from here, but we must be miles away.",
	"charisma": "I feel magnetic, like I could talk my way out of or into anything!",
	"plantControl": "Is it just me or is the grass looking at me? I don't feel any different no.",
	"monkey": "Yeah, I'm not drinking that.",
	"water": "I feel nothing."
}
var AdditionalList1 := ["hovering","invisibility","speed","strength"]
var AdditionalList2 := ["petrification"]

var cost := 40

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
		EventBus.Hint.emit(str("You can only test 1 effect at a time, review help section for more info."))
		return
	else:
		# EffectsList[Effect] gives the descriptor to be recorded (+ probably spoken)
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
	# No journal entry for these, but they are considered "effects"
	if (effect == "monkey") or (effect == "water"):
		return
	
	# Maybe a note taking sound
	
	# What should be entered in place of the effect
	var NewEntry:String = str(result + " ([color=" + str(color.to_html()) + "]" + get_parent().CharName + "[/color]" + ")")
	
	for num in PotionInfo.JournalIngredients[EventBus.InsertedItems].size():
		# Formats out the {effect} for NewEntry if it finds it
		# This works because it supposes that there will not be more than 1 of {effect} per ingredient
		PotionInfo.JournalIngredients[EventBus.InsertedItems][num] = PotionInfo.JournalIngredients[EventBus.InsertedItems][num].format({effect: str(NewEntry)})
	

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
