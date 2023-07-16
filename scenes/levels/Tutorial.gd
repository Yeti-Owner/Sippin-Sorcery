extends Node3D

@onready var dialogue := get_node(EventBus.Dialogue)

var Stage:int = -1

func _ready():
	EventBus.connect("DialogueFinished", _tutorial)

func _tutorial():
	Stage += 1
	match Stage:
		0:
			dialogue._talk(str("[font_size=36]Hey Bob! I'm excited to get started.[/font_size]"), "Self")
		1:
			dialogue._talk(str("[font_size=36]For legal reasons this is a juice shop and you sell juice, but don't worry about that I'll handle the business side.[/font_size]"), "Bob")
		2:
			dialogue._talk(str("[font_size=36]Mixing the juice is simple. Find the ingredients scattered on the shelves around us, and add them to the cauldron right in front of you. Remember " + EventBus.PlayerName + ", the effects of each ingredient change as you add more, up to a maximum of three.[/font_size]"))
		3:
			dialogue._talk(str("[font_size=36]Each juice needs a flavor to make it more appealing. You'll find the flavor options below the cauldron. Ask the customers what flavor they want and add it after the ingredients before mixing the juice.[/font_size]"))
		4:
			dialogue._talk("[font_size=36]When a customer comes in, they'll tell you their problem or what they're looking for. It's up to you to mix the correct ingredients to achieve the desired effect(s).[/font_size]")
		5:
			dialogue._talk(str("[font_size=36]Remember " + EventBus.PlayerName + ", you'll get paid a bonus for going above and beyond what is required, but avoid giving unhelpful effects.[/font_size]"))
		6:
			dialogue._talk(str("[font_size=36]Many effects in the journal are missing?[/font_size]"), "Self")
		7:
			dialogue._talk(str("[font_size=36]Unfortunately some pages in the journal have been torn out and replaced. But don't worry " + EventBus.PlayerName + ", there are ways to discover the missing effects.[/font_size]"), "Bob")
		8:
			dialogue._talk(str("[font_size=36]For example I recommend-[/font_size]"), "Bob", 0.5)
		9:
			dialogue._talk(str("[font_size=36]Hey don't mind me but I heard you're struggling and need a little push.[/font_size]"), "Duane")
		10:
			dialogue._talk(str("[font_size=36]Duane do you mind?[/font_size]"), "Bob", 1)
		11:
			dialogue._talk(str("[font_size=36]Yes I do, now as I was saying if you leave the shop and take a right you'll often find first-year Hogwarts students hiding out. They're always up for a taste of your juice and will report back the effects... for a price, of course.[/font_size]"), "Duane")
		12:
			dialogue._talk(str("[font_size=36]Morally questionable sure but why deprive them the chance to earn some pocket money? Just only test 1 ingredient at a time.[/font_size]"), "Duane", 1)
		13:
			dialogue._talk(str("[font_size=36]That's quite enough Duane.[/font_size]"), "Bob", 3)
		14:
			dialogue._talk(str("[font_size=36]Now " + EventBus.PlayerName + ", as I was saying, the journal is your greatest asset for mixing juice.[/font_size]"))
		15:
			dialogue._talk(str("[font_size=36]Customers should be arriving soon. I can't help you anymore but I recommend you check out your journal and remember.[/font_size]"))
		16:
			dialogue._talk(str("[font_size=36]When in doubt, just walk over and ask the customer again.[/font_size]"))
		17:
			dialogue._talk(str("[font_size=36]Good luck " + EventBus.PlayerName + ", but I'm sure you won't need it.[/font_size]"))
		18:
			dialogue._done()
			$TempTimer.start()
			dialogue.Visible = false
		20:
			dialogue._talk(str("[font_size=36]Heya " + EventBus.PlayerName + ", notice your journal is still blank? I can help.[/font_size]"), "Duane")
		21:
			_duane_journal()
			dialogue._talk(str("[font_size=36]Go ahead and check it again, I've added some basic effects I know.[/font_size]"))
			$Spawner._start()
		22:
			dialogue._talk(str("[font_size=36]This wasn't for free though, I will be taking a small commission if you don't mind.[/font_size]"))
			EventBus.Balance = 25
			EventBus.emit_signal("BalanceChanged")
		23:
			dialogue._talk(str("[font_size=36]Wait[/font_size]"), "Self", 0.4)
		24:
			dialogue._talk(str("[font_size=36]See ya![/font_size]"), "Duane", 1)
		25:
			dialogue._done()
			$TempTimer.start(20)
		29:
			dialogue._talk(str("[font_size=36]Well done " + EventBus.PlayerName + "![/font_size]"), "Bob")
		30:
			dialogue._talk(str("[font_size=36]Looks like that will be all the customers today. I recommend you research some ingredients then close shop whenever you're done.[/font_size]"))
		31:
			dialogue._talk(str("[font_size=36]You did good " + EventBus.PlayerName + ", I'm proud of you.[/font_size]"))
		32:
			dialogue._done()

func _on_loading_screen_loading_done():
	EventBus.Fade.emit(true)
	dialogue._talk(str("[font_size=36]Hello " + EventBus.PlayerName + "! Welcome to the juice shop. I'm Bob, your partner in this business venture. " + EventBus.PlayerName + ", you'll be in charge of the juice mixing.[/font_size]"), "Bob")

func _on_temp_timer_timeout():
	if Stage == 18:
		Stage = 19
		_tutorial()
	elif Stage == 25 and EventBus.ActiveCustomers == 0:
		Stage = 28
		_tutorial()
	elif Stage == 25 and EventBus.ActiveCustomers != 0:
		$TempTimer.start(5)
	elif Stage == 30:
		get_tree().change_scene_to_file("res://scenes/levels/Level1.tscn")

func _duane_journal():
	PotionInfo.JournalIngredients["MermaidScale"] = PotionInfo.JournalIngredients["MermaidScale"].format({"swimming": str("Enhanced swimming ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["GriffinFeather"] = PotionInfo.JournalIngredients["GriffinFeather"].format({"alertness": str("Increased alertness ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["MandrakeRoot"] = PotionInfo.JournalIngredients["MandrakeRoot"].format({"resistance": str("Overall resistance to common illnesses ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["TrollBlood"] = PotionInfo.JournalIngredients["TrollBlood"].format({"courage": str("Courage ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["PhoenixFeather"] = PotionInfo.JournalIngredients["PhoenixFeather"].format({"sleep": str("Sleep/calming effect ([color=DARK_GRAY]Duane[/color]" + ")")})

func _on_clock_next_day():
	EventBus.Fade.emit(false)
	$TempTimer.start(1)
	Stage = 30
