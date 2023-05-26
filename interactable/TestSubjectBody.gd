extends Interactable

@onready var color := Color(randf(), randf(), randf())
var CharName := ["Jack", "Emily", "Thomas", "Jessica", "James", "Charlotte", "Daniel", "Sophie", "Joshua", "Olivia", "Matthew", "Emma", "William", "Hannah", "Joseph", "Amy", "Benjamin", "Lucy", "Samuel", "Rebecca", "David", "Megan", "Oliver", "Lauren", "Christopher", "Katie", "Alexander", "Ellie", "Ryan", "Grace"]
var Char:String = CharName[randi() % CharName.size()]

const EffectsList := {
	"resistance": "\n- I don't know why, but suddenly it's like I'm tougher than usual. Like nothing can touch me, you know? (",
	"confusion": "\n- Whoa, everything's kinda spinning in my head. Like, I can't even remember what I had for breakfast this morning. (",
	"health": "\n- Man, I was feeling a bit ill earlier, but it's totally cleared up thank you! (",
	"flexibility": "\n- I swear, my body feels all loose and limber, like I could bend in crazy ways. (",
	"agility": "\n- You won't believe it, but I'm moving so fast right now! I feel like I could outrun a Quidditch player. Zoom! (",
	"speed": "\n- I feel like I've been zapped with a dose of lightning! My legs are moving quicker than I thought possible. (",
	"courage": "\n- I don't know what came over me, but suddenly I'm braver than a lion. Nothing scares me anymore! Let's do this! (",
	"stamina": "\n- I could run laps around the castle and not even lose my breath! It's like I've got an endless supply of energy. (",
	"strength": "\n- I lifted that heavy cauldron like it was a feather! I've got some serious muscles going on right now. (",
	"badVision": "\n- Uh-oh, everything's a bit blurry. Is this supposed to happen? I can't see straight! (",
	"badSmell": "\n- I can't smell a thing, very weird. Is this a potion gone wrong or something? (",
	"poison": "\n- Ugh, I don't feel so good. My stomach's churning, and I've got this weird taste in my mouth. Something's definitely not right. (",
	"coldRes": "\n- I'm not shivering anymore, even though it's freezing outside. It's like I've got my own personal heater keeping me warm! (",
	"fireRes": "\n- Whoa, did someone just turn up the heat? I'm not sweating or feeling uncomfortable at all. I'm like fireproof or something! (",
	"lessPain": "\n- I stubbed my toe earlier, but it doesn't even hurt now. It's like the pain just vanished into thin air. Weird, but cool! (",
	"swimming": "\n- I feel an urge to go swimming. I could swim laps over anyone! I know I can glide through the water so effortlessly, awesome! (",
	"underwaterBreathing": "\n- My neck feels weird, it's like I've got gills or something. (",
	"fishTalk": "\n- Something is off, I feel a strange urge to go swimming, I swear I can hear the fish from here. And they're talking?! (",
	"sticky": "\n-My hands are all tacky and clingy. Everything I touch just sticks to me. It's like I've got super glue on my fingers. (",
	"nightVision": "\n-It's dark out here, but I can see through the shadows crystal clear. It's like I've got these cool night vision goggles or something. (",
	"invisibility": "\n-Hey, where did I go? I can't see myself. This is mad. (",
	"lessWeight": "\n-I feel so light on my feet, like I could float away if I'm not careful. It's like gravity has forgotten about me! (",
	"hearing": "\n-I can hear a pin drop from across the room. My ears are super sensitive right now. It's like I've got supersonic hearing or something. (",
	"hovering": "\n-Look, I'm floating! I can hover a few inches off the ground! (",
	"luck": "\n-I don't know what's happening, but I feel like buying a lottery ticket. I just know I can win! (",
	"petrification": "\n- Subject froze (",
	"purity": "\n- I feel so pure and clean, like I just took the most refreshing shower ever. It's like I've been cleansed from the inside out. (",
	"heightenedSenses": "\n- I can see a bit better, hear footsteps a touch louder, and my smell is maybe better. My senses just improved that's nice. (",
	"stability": "\n- Whoa, I feel steady on my feet. I could balance on one leg without wobbling at all. (",
	"jumping": "\n- WOW I can jump super high, my legs feel CRAZY, it's like gravity doesn't apply to me anymore. (",
	"precision": "\n- I can pick up the tiniest objects with pinpoint accuracy. It's like my fingers have become precision tools. (",
	"dexterity": "\n- I can twist and turn my fingers in ways I never thought possible. It's like I've got the hands of a master magician. (",
	"alertness": "\n- Wow I'm wide awake, like I've had a whole cauldron of coffee. I need to run a marathon to cool off. (",
	"perception": "\n- Colors seem more vibrant and I can read your body language. It's like I'm experiencing the world in high definition! (",
	"electricalRes": "\n- I feel rubbery, not in a stretchy way like an insulated way. odd. (",
	"explosionRes": "\n- I feel off, I can't explain it but I know I could survive a bomb being dropped on me, mark it down as explosion resistance dude. (",
	"smokeImmunity": "\n- My lungs feel stronger, I couldn't breathe underwater or anything but you get the idea. (",
	"petrificationRes": "\n- Yeah this one is a dud, nothing has changed except I feel like I'm protected from petrification. I don't want to test it though. (",
	"betterSmell": "\n- I can smell the school from here! I am picking up scents of quills from miles away. (",
	"charisma": "\n- I've got charm oozing out of me. I can tell you can't resist my words, I'm gonna convince the teachers to not assign homework! (",
	"plantControl": "\n- Is it just me or is the grass looking at me? I can control them it's like I'm the king of the greenery! (",
}

func _ready():
	randomize()

func get_interaction_text():
	if EventBus.HeldItem == "Juice":
		return str("[center]Press E to test juice with [color=" + str(color.to_html()) + "] " + Char + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + Char + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if EventBus.HeldItem == "Juice":
		_test_juice(EventBus.HeldEffect)
		EventBus.HeldEffect = null
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")

func _test_juice(effects:Array):
	var Results := ""
	if effects.size() > 1:
		var Responses := ["I feel too many effects to sort them out, sorry I can't help.", "Too much is going on I can't separate them.", "Geez dude I'm feeling a lot, use less ingredients next time.","I'm gonna throw up, move.", "Dude, never do that again, too much."]
		Results = Responses[randi() % Responses.size()]
	else:
		pass
	
	_record_journal(Results)
	$Timer.start()

func _record_journal(result):
	pass
