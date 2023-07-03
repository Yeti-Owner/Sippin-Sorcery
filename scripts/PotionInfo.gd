extends Node

# increasing number : [ Name, Icon, Description ]
const JournalPotions:Dictionary = {
	0 : ["Basilisk Fangs", "res://assets/textures/ingredients/BasiliskFang.png", "Sharp, venomous fangs obtained from a basilisk, a mythical serpent-like creature known for its deadly gaze."],
	1 : ["Centaur Hoof Shavings", "res://assets/textures/ingredients/CentaurHoof.png","Small shavings collected from the hooves of centaurs, half-human and half-horse beings from ancient legends."],
	2 : ["Chimera Flame Essence", "res://assets/textures/ingredients/ChimeraFlame.png","Highly concentrated essence extracted from the flames of a chimera, a fearsome creature with the body parts of different animals, typically a lion, goat, and serpent."],
	3 : ["Dragonfly Wings", "res://assets/textures/ingredients/DragonflyWing.png", "Delicate wings harvested from dragonflies, ethereal insects known for their agile flight and vibrant colors."],
	4 : ["Dryad Sap", "res://assets/textures/ingredients/DryadSap.png","Sticky sap collected from the trunks of trees inhabited by dryads, enchanting tree spirits known by their Greek mythology."],
	5 : ["Fairy Wings", "res://assets/textures/ingredients/FairyWing.png","Exquisite and delicate wings gently obtained from fairies, mystical beings associated with enchantment and nature."],
	6 : ["Gorgon Blood", "res://assets/textures/ingredients/GorgonBlood.png","Dark and potent blood acquired from a gorgon, a terrifying creature with serpents for hair and a petrifying gaze."],
	7 : ["Griffin Feathers", "res://assets/textures/ingredients/GriffinFeather.png","Majestic feathers gathered from griffins, legendary creatures with the body of a lion and the head and wings of an eagle."],
	8 : ["Hippogriff Talons", "res://assets/textures/ingredients/HippogriffTalon.png","Sharp talons acquired from a hippogriff, a creature with the front half of an eagle and the hind half of a horse."],
	9 : ["Kraken Ink", "res://assets/textures/ingredients/KrakenInk.png","Inky substance harvested from the ink sac of a kraken, a gigantic sea monster typically dwelling in the depths of the ocean."],
	10 : ["Mandrake Roots", "res://assets/textures/ingredients/MandrakeRoot.png","Twisted and powerful roots extracted from mandrakes, plants with mystical properties and resembling humanoids."],
	11 : ["Mermaid Scales", "res://assets/textures/ingredients/MermaidScale.png","Shimmering scales collected from mermaids, beautiful aquatic beings with the upper body of a human and the tail of a fish."],
	12 : ["Phoenix Feathers", "res://assets/textures/ingredients/PhoenixFeather.png","Brilliant and fiery feathers gathered from a phoenix, a mythical bird known for its ability to rise from its ashes and be reborn."],
	13 : ["Salamander Tails", "res://assets/textures/ingredients/SalamanderTail.png","Energetic and resilient tails obtained from salamanders, mythical creatures associated with fire and transformation."],
	14 : ["Spider Silk", "res://assets/textures/ingredients/SpiderSilk.png","Fine and strong silk spun by spiders then enchanted, known for its exceptional durability and elasticity."],
	15 : ["Troll Blood", "res://assets/textures/ingredients/TrollBlood.png","Thick and viscous blood derived from a troll, a creature known for its strength and dimwitted nature."],
	16 : ["Unicorn Horn Shavings", "res://assets/textures/ingredients/UnicornHorn.png","Shavings collected from the horn of a unicorn, a legendary creature symbolizing purity and grace."]
}

# Ingredient : [ effect 1, 2, 3 ]
const CauldronPotions:Dictionary = {
	"MandrakeRoot": ["resistance", "confusion", "health"],
	"FairyWing": ["flexibility", "agility", "speed"],
	"TrollBlood": ["courage", "stamina", "strength"],
	"KrakenInk": ["badVision", "badSmell", "poison"],
	"SalamanderTail": ["coldRes", "fireRes", "lessPain"],
	"MermaidScale": ["swimming", "underwaterBreathing", "fishTalk"],
	"SpiderSilk": ["sticky", "nightVision", "invisibility"],
	"DragonflyWing": ["lessWeight", "hearing", "hovering"],
	"PhoenixFeather": ["sleep", "luck", "fireRes"],
	"BasiliskFang": ["petrification", "poison", "strength"],
	"UnicornHorn": ["purity", "health", "heightenedSenses"],
	"CentaurHoof": ["speed", "stability", "jumping"],
	"HippogriffTalon": ["precision", "lessPain", "dexterity"],
	"GriffinFeather": ["alertness", "perception", "electricalRes"],
	"ChimeraFlame": ["strength", "explosionRes", "smokeImmunity"],
	"GorgonBlood": ["petrificationRes", "poison", "betterSmell"],
	"DryadSap": ["charisma", "health", "plantControl"]
}

# Ingredient : [ Name, color, Collision Position, Collision Size ]
const IngredientPotions:Dictionary = {
	"DragonflyWing": ["Dragonfly Wing", Color(0.12549020349979, 0.29019609093666, 0.13333334028721), Vector3(0, 0.4, 0), Vector3(0.2, 0.8, 0.8)],
	"FairyWing": ["Fairy Wing", Color(0.80000001192093, 0.32941177487373, 0.80000001192093), Vector3(0, 0.15, 0), Vector3(0.8, 0.3, 0.8)],
	"KrakenInk": ["Kraken Ink", Color(0.12322875112295, 0.00120565423276, 0.12581461668015), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"MandrakeRoot": ["Mandrake Root", Color(0.12549020349979, 0.29019609093666, 0.13333334028721), Vector3(0.05, 0.4, 0.05), Vector3(0.7, 0.8, 0.7)],
	"MermaidScale": ["Mermaid Scale", Color(0.42352941632271, 0.22745098173618, 0.43921568989754), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.8)],
	"SalamanderTail": ["Salamander Tail", Color(0.25098040699959, 0.94117647409439, 0), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.2)],
	"SpiderSilk": ["Spider Silk", Color(0.90980392694473, 0.90980392694473, 0.90980392694473), Vector3(0, 0.35, 0), Vector3(0.8, 0.7, 0.8)],
	"TrollBlood": ["Troll Blood", Color(0.419607847929, 0.01568627543747, 0.01568627543747), Vector3(0, 0.15, 0), Vector3(0.8, 0.3, 0.8)],
	"PhoenixFeather": ["Phoenix Feather", Color(0.94901961088181, 0.66274511814117, 0.42352941632271), Vector3(0, 0.1, 0), Vector3(0.6, 0.2, 0.6)],
	"BasiliskFang": ["Basilisk Fang", Color(0.71372550725937, 0.61568629741669, 0.45490196347237), Vector3(0, 0.1, 0), Vector3(0.8, 0.2, 0.8)],
	"UnicornHorn": ["Unicorn Horn Shavings", Color(0.96078431606293, 0.55686277151108, 0.69411766529083), Vector3(0, 0.4, 0), Vector3(0.7, 0.8, 0.7)],
	"CentaurHoof": ["Centaur Hoof Shavings", Color(0.61568629741669, 0.6235294342041, 0.61960786581039), Vector3(0, 0.4, -0.05), Vector3(0.8, 0.8, 0.4)],
	"HippogriffTalon": ["Hippogriff Talon", Color(0.07058823853731, 0.07058823853731, 0.07450980693102), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.2)],
	"GriffinFeather": ["Griffin Feather", Color(0.35294118523598, 0.31764706969261, 0.32941177487373), Vector3(0, 0.3, 0), Vector3(0.2, 0.6, 0.7)],
	"ChimeraFlame": ["Chimera Flame Essence", Color(0.90980392694473, 0, 0.0627451017499), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"GorgonBlood": ["GorgonBlood", Color(0.5799999833107, 0.27724000811577, 0.24359999597073), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"DryadSap": ["DryadSap", Color(0.48238503932953, 0.65542727708817, 0.40115711092949), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)]
}

# Journal ingredient entries
var JournalIngredients := {
	"MandrakeRoot": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {resistance} \n\n[color=BLACK]Effect 2: \n- {confusion} \n\n[color=BLACK]Effect 3:\n- {health}",
	"FairyWing": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {flexibility} \n\n[color=BLACK]Effect 2: \n- {agility} \n\n[color=BLACK]Effect 3:\n- {speed}",
	"TrollBlood": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {courage} \n\n[color=BLACK]Effect 2: \n- {stamina} \n\n[color=BLACK]Effect 3:\n- {strength}",
	"KrakenInk": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {badVision} \n\n[color=BLACK]Effect 2: \n- {badSmell} \n\n[color=BLACK]Effect 3:\n- {poison}",
	"SalamanderTail": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {coldRes} \n\n[color=BLACK]Effect 2: \n- {fireRes} \n\n[color=BLACK]Effect 3:\n- {lessPain}",
	"MermaidScale": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {swimming} \n\n[color=BLACK]Effect 2: \n- {underwaterBreathing} \n\n[color=BLACK]Effect 3:\n- {fishTalk}",
	"SpiderSilk": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {sticky} \n\n[color=BLACK]Effect 2: \n- {nightVision} \n\n[color=BLACK]Effect 3:\n- {invisibility}",
	"DragonflyWing":"[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {lessWeight} \n\n[color=BLACK]Effect 2: \n- {hearing} \n\n[color=BLACK]Effect 3:\n- {hovering}",
	"PhoenixFeather": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {sleep} \n\n[color=BLACK]Effect 2: \n- {luck} \n\n[color=BLACK]Effect 3:\n- {fireRes}",
	"BasiliskFang": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {petrification} \n\n[color=BLACK]Effect 2: \n- {poison} \n\n[color=BLACK]Effect 3:\n- {strength}",
	"UnicornHorn": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {purity} \n\n[color=BLACK]Effect 2: \n- {health} \n\n[color=BLACK]Effect 3:\n- {heightenedSenses}",
	"CentaurHoof": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {speed} \n\n[color=BLACK]Effect 2: \n- {stability} \n\n[color=BLACK]Effect 3:\n- {jumping}",
	"HippogriffTalon": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {precision} \n\n[color=BLACK]Effect 2: \n- {lessPain} \n\n[color=BLACK]Effect 3:\n- {dexterity}",
	"GriffinFeather": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {alertness} \n\n[color=BLACK]Effect 2: \n- {perception} \n\n[color=BLACK]Effect 3:\n- {electricalRes}",
	"ChimeraFlame": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {strength} \n\n[color=BLACK]Effect 2: \n- {explosionRes} \n\n[color=BLACK]Effect 3:\n- {smokeImmunity}",
	"GorgonBlood": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {petrificationRes} \n\n[color=BLACK]Effect 2: \n- {poison} \n\n[color=BLACK]Effect 3:\n- {betterSmell}",
	"DryadSap": "[color=BLACK][center]Current known effects[/center]\n\n\nEffect 1:\n- {charisma} \n\n[color=BLACK]Effect 2: \n- {health} \n\n[color=BLACK]Effect 3:\n- {plantControl}"
}


# Just every effect in the game
const EffectsList := ["resistance", "confusion", "health","flexibility", "agility", "speed","courage", "stamina", "strength","badVision", "badSmell", "poison","coldRes", "fireRes", "lessPain","swimming", "underwaterBreathing", "fishTalk","sticky", "nightVision", "invisibility","lessWeight", "hearing", "hovering","health", "luck", "fireRes","petrification", "poison", "strength","purity", "health", "heightenedSenses","speed", "stability", "jumping","precision", "lessPain", "dexterity","alertness", "perception", "electricalRes","strength", "explosionRes", "smokeImmunity","petrificationRes", "poison", "betterSmell","charisma", "health", "plantControl", "sleep"]


# Used by Customer and test subject for clothing
const MaleHatList = ["res://assets/models/characters/hats/Hair1.obj","res://assets/models/characters/hats/Hair2.obj","res://assets/models/characters/hats/Hair5.obj"]
const FemaleHatList = ["res://assets/models/characters/hats/Hair3.obj","res://assets/models/characters/hats/Hair4.obj"]
const HatColorList = ["res://assets/models/characters/hats/HairColor1.png","res://assets/models/characters/hats/HairColor2.png","res://assets/models/characters/hats/HairColor3.png","res://assets/models/characters/hats/HairColor4.png","res://assets/models/characters/hats/HairColor5.png","res://assets/models/characters/hats/HairColor6.png"]
const HeadList = ["res://assets/models/characters/heads/Head1.obj", "res://assets/models/characters/heads/Head2.obj", "res://assets/models/characters/heads/Head3.obj", "res://assets/models/characters/heads/Head4.obj", "res://assets/models/characters/heads/Head5.obj","res://assets/models/characters/heads/Head6.obj"]
const TorsoList = ["res://assets/models/characters/torsos/torso1.obj","res://assets/models/characters/torsos/torso2.obj","res://assets/models/characters/torsos/torso3.obj","res://assets/models/characters/torsos/torso4.obj"]
const MalePantList = ["res://assets/models/characters/pants/pants1.obj"]
const FemalePantList = ["res://assets/models/characters/pants/pants3.obj"]
const LegList = ["res://assets/models/characters/legs/leg1.obj","res://assets/models/characters/legs/leg2.obj","res://assets/models/characters/legs/leg3.obj","res://assets/models/characters/legs/leg4.obj"]

