extends Node

# increasing number : [ Name, Icon, Description ]
const JournalPotions:Dictionary = {
	0 : ["Mandrake Roots", "res://assets/textures/ingredients/MandrakeRoot.png","Twisted and powerful roots extracted from mandrakes, plants with mystical properties and resembling humanoids."],
	1 : ["Basilisk Fangs", "res://assets/textures/ingredients/BasiliskFang.png", "Sharp, venomous fangs obtained from a basilisk, a mythical serpent-like creature known for its deadly gaze."],
	2 : ["Centaur Hoof Shavings", "res://assets/textures/ingredients/CentaurHoof.png","Small shavings collected from the hooves of centaurs, half-human and half-horse beings from ancient legends."],
	3 : ["Chimera Flame Essence", "res://assets/textures/ingredients/ChimeraFlame.png","Highly concentrated essence extracted from the flames of a chimera, a fearsome creature with the body parts of different animals, typically a lion, goat, and serpent."],
	4 : ["Dragonfly Wings", "res://assets/textures/ingredients/DragonflyWing.png", "Delicate wings harvested from dragonflies, ethereal insects known for their agile flight and vibrant colors."],
	5 : ["Dryad Sap", "res://assets/textures/ingredients/DryadSap.png","Sticky sap collected from the trunks of trees inhabited by dryads, enchanting tree spirits known by their Greek mythology."],
	6 : ["Fairy Wings", "res://assets/textures/ingredients/FairyWing.png","Exquisite and delicate wings gently obtained from fairies, mystical beings associated with enchantment and nature."],
	7 : ["Gorgon Blood", "res://assets/textures/ingredients/GorgonBlood.png","Dark and potent blood acquired from a gorgon, a terrifying creature with serpents for hair and a petrifying gaze."],
	8 : ["Griffin Feathers", "res://assets/textures/ingredients/GriffinFeather.png","Majestic feathers gathered from griffins, legendary creatures with the body of a lion and the head and wings of an eagle."],
	9 : ["Hippogriff Talons", "res://assets/textures/ingredients/HippogriffTalon.png","Sharp talons acquired from a hippogriff, a creature with the front half of an eagle and the hind half of a horse."],
	10 : ["Kraken Ink", "res://assets/textures/ingredients/KrakenInk.png","Inky substance harvested from the ink sac of a kraken, a gigantic sea monster typically dwelling in the depths of the ocean."],
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
	"FairyWing": ["flexibility", "creativity", "speed"],
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
	"DryadSap": ["charisma", "health", "plantControl"],
	"Water": ["water","water","water"],
	"NepalOrb": ["monkey","monkey","monkey"]
}

# Ingredient : [ Name, color, Collision Position, Collision Size ]
const IngredientPotions:Dictionary = {
	"DragonflyWing": ["Dragonfly Wing", Color(0.12549020349979, 0.29019609093666, 0.13333334028721), Vector3(0.3, 0.4, 0), Vector3(0.2, 0.8, 0.8)],
	"FairyWing": ["Fairy Wing", Color(0.80000001192093, 0.32941177487373, 0.80000001192093), Vector3(0, 0.15, 0), Vector3(0.8, 0.3, 0.8)],
	"KrakenInk": ["Kraken Ink", Color(0.12322875112295, 0.00120565423276, 0.12581461668015), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"MandrakeRoot": ["Mandrake Root", Color(0.12549020349979, 0.29019609093666, 0.13333334028721), Vector3(0.05, 0.4, 0.05), Vector3(0.7, 0.8, 0.7)],
	"MermaidScale": ["Mermaid Scale", Color(0.42352941632271, 0.22745098173618, 0.43921568989754), Vector3(0, 0.4, 0), Vector3(0.8, 0.8, 0.8)],
	"SalamanderTail": ["Salamander Tail", Color(0.25098040699959, 0.94117647409439, 0), Vector3(0, 0.4, -0.3), Vector3(0.8, 0.8, 0.2)],
	"SpiderSilk": ["Spider Silk", Color(0.90980392694473, 0.90980392694473, 0.90980392694473), Vector3(0, 0.35, 0), Vector3(0.8, 0.7, 0.8)],
	"TrollBlood": ["Troll Blood", Color(0.419607847929, 0.01568627543747, 0.01568627543747), Vector3(0, 0.15, 0), Vector3(0.8, 0.3, 0.8)],
	"PhoenixFeather": ["Phoenix Feather", Color(0.94901961088181, 0.66274511814117, 0.42352941632271), Vector3(0, 0.1, 0), Vector3(0.6, 0.2, 0.6)],
	"BasiliskFang": ["Basilisk Fang", Color(0.71372550725937, 0.61568629741669, 0.45490196347237), Vector3(0, 0.1, 0), Vector3(0.8, 0.2, 0.8)],
	"UnicornHorn": ["Unicorn Horn Shavings", Color(0.96078431606293, 0.55686277151108, 0.69411766529083), Vector3(0, 0.4, 0), Vector3(0.7, 0.8, 0.7)],
	"CentaurHoof": ["Centaur Hoof Shavings", Color(0.61568629741669, 0.6235294342041, 0.61960786581039), Vector3(0, 0.4, -0.05), Vector3(0.8, 0.8, 0.4)],
	"HippogriffTalon": ["Hippogriff Talon", Color(0.07058823853731, 0.07058823853731, 0.07450980693102), Vector3(0, 0.4, -0.3), Vector3(0.8, 0.8, 0.2)],
	"GriffinFeather": ["Griffin Feather", Color(0.35294118523598, 0.31764706969261, 0.32941177487373), Vector3(0.3, 0.4, -0.05), Vector3(0.2, 0.6, 0.7)],
	"ChimeraFlame": ["Chimera Flame Essence", Color(0.90980392694473, 0, 0.0627451017499), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"GorgonBlood": ["Gorgon Blood", Color(0.5799999833107, 0.27724000811577, 0.24359999597073), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)],
	"DryadSap": ["Dryad Sap", Color(0.48238503932953, 0.65542727708817, 0.40115711092949), Vector3(0, 0.35, 0), Vector3(0.4, 0.7, 0.4)]
}

# Journal ingredient entries, Ingredient : [Effect1, Effect2, Effect3]
var JournalIngredients := {
	"MandrakeRoot": ["\n[color=BLACK]Effect 1:\n- {resistance}", "\n[color=BLACK]Effect 2: \n- {confusion}","\n[color=BLACK]Effect 3:\n- {health}"],
	"FairyWing": ["\n[color=BLACK]Effect 1:\n- {flexibility}", "\n[color=BLACK]Effect 2: \n- {creativity}","\n[color=BLACK]Effect 3:\n- {speed}"],
	"TrollBlood": ["\n[color=BLACK]Effect 1:\n- {courage}", "\n[color=BLACK]Effect 2: \n- {stamina}", "\n[color=BLACK]Effect 3:\n- {strength}"],
	"KrakenInk": ["\n[color=BLACK]Effect 1:\n- {badVision}", "\n[color=BLACK]Effect 2: \n- {badSmell}", "\n[color=BLACK]Effect 3:\n- {poison}"],
	"SalamanderTail": ["\n[color=BLACK]Effect 1:\n- {coldRes}", "\n[color=BLACK]Effect 2: \n- {fireRes}", "\n[color=BLACK]Effect 3:\n- {lessPain}"],
	"MermaidScale": ["\n[color=BLACK]Effect 1:\n- {swimming}", "\n[color=BLACK]Effect 2: \n- {underwaterBreathing}", "\n[color=BLACK]Effect 3:\n- {fishTalk}"],
	"SpiderSilk": ["\n[color=BLACK]Effect 1:\n- {sticky}", "\n[color=BLACK]Effect 2: \n- {nightVision}", "\n[color=BLACK]Effect 3:\n- {invisibility}"],
	"DragonflyWing": ["\n[color=BLACK]Effect 1:\n- {lessWeight}", "\n[color=BLACK]Effect 2: \n- {hearing}", "\n[color=BLACK]Effect 3:\n- {hovering}"],
	"PhoenixFeather": ["\n[color=BLACK]Effect 1:\n- {sleep}", "\n[color=BLACK]Effect 2: \n- {luck}", "\n[color=BLACK]Effect 3:\n- {fireRes}"],
	"BasiliskFang": ["\n[color=BLACK]Effect 1:\n- {petrification}", "\n[color=BLACK]Effect 2: \n- {poison}", "\n[color=BLACK]Effect 3:\n- {strength}"],
	"UnicornHorn": ["\n[color=BLACK]Effect 1:\n- {purity}", "\n[color=BLACK]Effect 2: \n- {health}", "\n[color=BLACK]Effect 3:\n- {heightenedSenses}"],
	"CentaurHoof": ["\n[color=BLACK]Effect 1:\n- {speed}", "\n[color=BLACK]Effect 2: \n- {stability}", "\n[color=BLACK]Effect 3:\n- {jumping}"],
	"HippogriffTalon": ["\n[color=BLACK]Effect 1:\n- {precision}", "\n[color=BLACK]Effect 2: \n- {lessPain}", "\n[color=BLACK]Effect 3:\n- {dexterity}"],
	"GriffinFeather": ["\n[color=BLACK]Effect 1:\n- {alertness}", "\n[color=BLACK]Effect 2: \n- {perception}", "\n[color=BLACK]Effect 3:\n- {electricalRes}"],
	"ChimeraFlame": ["\n[color=BLACK]Effect 1:\n- {strength}", "\n[color=BLACK]Effect 2: \n- {explosionRes}", "\n[color=BLACK]Effect 3:\n- {smokeImmunity}"],
	"GorgonBlood": ["\n[color=BLACK]Effect 1:\n- {petrificationRes}", "\n[color=BLACK]Effect 2: \n- {poison}", "\n[color=BLACK]Effect 3:\n- {betterSmell}"],
	"DryadSap": ["\n[color=BLACK]Effect 1:\n- {charisma}", "\n[color=BLACK]Effect 2: \n- {health}", "\n[color=BLACK]Effect 3:\n- {plantControl}"]
}

# Item : Current, Max
var StockAmounts := {
	"MandrakeRoot": [15, 15],
	"FairyWing": [15, 15],
	"TrollBlood": [15, 15],
	"KrakenInk": [15, 15],
	"SalamanderTail": [15, 15],
	"MermaidScale": [15, 15],
	"SpiderSilk": [15, 15],
	"DragonflyWing": [15, 15],
	"PhoenixFeather": [15, 15],
	"BasiliskFang": [15, 15],
	"UnicornHorn": [15, 15],
	"CentaurHoof": [15, 15],
	"HippogriffTalon": [15, 15],
	"GriffinFeather": [15, 15],
	"ChimeraFlame": [15, 15],
	"GorgonBlood": [15, 15],
	"DryadSap": [15, 15],
	# Flavors
	"Strawberry": [20, 20],
	"Banana": [20, 20],
	"Pineapple": [20, 20],
	"Blueberry": [20, 20],
	"Watermelon": [20, 20],
	"Orange": [20, 20],
} # Note: Water is infinite, no need to restock that at all

# Just every effect in the game
const EffectsList := ["resistance", "confusion", "health","flexibility", "creativity", "speed","courage", "stamina", "strength","badVision", "badSmell", "poison","coldRes", "fireRes", "lessPain","swimming", "underwaterBreathing", "fishTalk","sticky", "nightVision", "invisibility","lessWeight", "hearing", "hovering","health", "luck", "fireRes","petrification", "poison", "strength","purity", "health", "heightenedSenses","speed", "stability", "jumping","precision", "lessPain", "dexterity","alertness", "perception", "electricalRes","strength", "explosionRes", "smokeImmunity","petrificationRes", "poison", "betterSmell","charisma", "health", "plantControl", "sleep"]

# Used by Customer and test subject for clothing
const MaleHatList = ["res://assets/models/characters/hats/Hair1.obj","res://assets/models/characters/hats/Hair2.obj","res://assets/models/characters/hats/Hair5.obj"]
const FemaleHatList = ["res://assets/models/characters/hats/Hair3.obj","res://assets/models/characters/hats/Hair4.obj"]
const HatColorList = ["res://assets/models/characters/hats/HairColor1.png","res://assets/models/characters/hats/HairColor2.png","res://assets/models/characters/hats/HairColor3.png","res://assets/models/characters/hats/HairColor4.png","res://assets/models/characters/hats/HairColor5.png","res://assets/models/characters/hats/HairColor6.png","res://assets/models/characters/hats/HairColor7.png"]
const HeadList = ["res://assets/models/characters/heads/Head1.obj", "res://assets/models/characters/heads/Head2.obj", "res://assets/models/characters/heads/Head3.obj", "res://assets/models/characters/heads/Head4.obj", "res://assets/models/characters/heads/Head5.obj","res://assets/models/characters/heads/Head6.obj"]
const TorsoList = ["res://assets/models/characters/torsos/torso1.obj","res://assets/models/characters/torsos/torso2.obj","res://assets/models/characters/torsos/torso3.obj","res://assets/models/characters/torsos/torso4.obj"]
const MalePantList = ["res://assets/models/characters/pants/pants1.obj"]
const FemalePantList = ["res://assets/models/characters/pants/pants3.obj"]
const LegList = ["res://assets/models/characters/legs/leg1.obj","res://assets/models/characters/legs/leg2.obj","res://assets/models/characters/legs/leg3.obj","res://assets/models/characters/legs/leg4.obj"]

