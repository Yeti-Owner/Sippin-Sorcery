extends Node3D

@onready var dialogue := get_node(EventBus.Dialogue)

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _tutorial)

func _tutorial():
	Stage += 1
	match Stage:
		1:
			dialogue._new_person("[font_size=26]" + EventBus.PlayerName + "[/font_size]", str("[font_size=36]Hey Bob! I'm excited to get started.[/font_size]"), EventBus.PlayerHeadshot)
		2:
			dialogue._new_person("[font_size=26]Bob[/font_size]", str("[font_size=36]Mixing the potions is simple. Find the ingredients scattered on the shelves around us, and add them to the cauldron right in front of you. Remember " + EventBus.PlayerName + ", the effects of each ingredient change as you add more, up to a maximum of three.[/font_size]"), load("res://assets/textures/Wizard.png"))
		3:
			dialogue._talk(str("[font_size=36]Each potion needs a flavor to make it more appealing. You'll find the flavor options below the cauldron. Ask the customers what flavor they want and add it after the ingredients before mixing the potion.[/font_size]"))
		4: # Break into 2
			dialogue._talk(str("[font_size=36]When a customer comes in, they'll tell you their problem or what they're looking for. It's up to you to mix the correct ingredients to achieve the desired effect(s). Remember " + EventBus.PlayerName + ", you'll get paid a bonus for going above and beyond what is required, but avoid giving unhelpful effects.[/font_size]"))
		5:
			dialogue._new_person("[font_size=26]" + EventBus.PlayerName + "[/font_size]", str("[font_size=36]Many effects in the journal are missing?[/font_size]"), EventBus.PlayerHeadshot)
		6:
			dialogue._new_person("[font_size=26]Bob[/font_size]", str("[font_size=36]Unfortunately some pages in the journal have been torn out and replaced. But don't worry " + EventBus.PlayerName + ", there are ways to discover the missing effects.[/font_size]"), load("res://assets/textures/Wizard.png"))
		7:
			dialogue._talk(str("[font_size=36]For example I recommend-[/font_size]"), 0.5)
		8:
			dialogue._new_person("[font_size=26]Duane[/font_size]", str("[font_size=36]Hey don't mind me but I heard you're struggling and need a little push.[/font_size]"), load("res://assets/textures/Duane.png"))
		9:
			dialogue._new_person("[font_size=26]Bob[/font_size]", str("[font_size=36]Duane do you mind?[/font_size]"), load("res://assets/textures/Wizard.png"), 1)
		10:
			dialogue._new_person("[font_size=26]Duane[/font_size]", str("[font_size=36]Yes I do, now as I was saying if you leave the shop and take a right you'll often find first-year students hiding out. They're always up for a taste of your potions and will report back the effects... for a price, of course.[/font_size]"), load("res://assets/textures/Duane.png"))
		11:
			dialogue._talk(str("[font_size=36]Morally questionable sure but why deprive them the chance to earn some pocket money? Just only test 1 ingredient at a time.[/font_size]"), 1)
		12:
			dialogue._new_person("[font_size=26]Bob[/font_size]", str("[font_size=36]That's quite enough Duane.[/font_size]"), load("res://assets/textures/Wizard.png"), 3)
		13:
			dialogue._done()

func _on_loading_screen_loading_done():
	dialogue._new_person("[font_size=26]Bob[/font_size]", str("[font_size=36]Hello " + EventBus.PlayerName + "! Welcome to the juice shop. I'm Bob, your partner in this business venture. " + EventBus.PlayerName + ", you'll be in charge of the potion mixing.[/font_size]"), load("res://assets/textures/Wizard.png"))
