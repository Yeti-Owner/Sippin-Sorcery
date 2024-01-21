extends Resource
class_name CharacterSheet

@export_category("Character")
@export var Name := ""
@export_color_no_alpha var FavColor
@export var Dialog := ""
@export var Budget := 10

@export_category("Judement")
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var resistance = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var confusion = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var health = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var flexibility = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var creativity = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var speed = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var courage = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var stamina = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var strength = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var badSmell = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var poison = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var coldRes = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var fireRes = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var lessPain = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var swimming = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var underwaterBreathing = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var fishTalk = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var sticky = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var nightVision = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var invisibility = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var lessWeight = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var hearing = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var hovering = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var luck = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var petrification = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var purity = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var heightenedSenses = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var stability = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var jumping = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var precision = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var dexterity = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var alertness = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var perception = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var electricalRes = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var explosionRes = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var smokeImmunity = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var petrificationRes = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var betterSmell = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var charisma = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var plantControl = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var sleep = "Bad"

@export_category("Looks")
@export_enum("Gryffindor:4", "Slytherin:3", "Hufflepuff:2", "Ravenclaw:1") var House:int
@export_enum("Male","Female") var Gender:String

@export_category("Taste")
@export var TastePrefix:String = "I like "
@export var Strawberry := false
@export var Banana := false
@export var Pineapple := false
@export var Blueberry := false
@export var Watermelon := false
@export var Orange := false

#
#@export var Hat:Mesh = load("res://assets/models/characters/hats/Hair1.obj")
#@export var HatColor:Texture = load("res://assets/models/characters/hats/HairColor1.png")
#@export var Head:Mesh = load("res://assets/models/characters/heads/Head1.obj")
#@export var Torso:Mesh = load("res://assets/models/characters/torsos/torso2.obj")
#var Arm:Mesh = load("res://assets/models/characters/arm.obj")
#@export var Pants:Mesh = load("res://assets/models/characters/pants/pants1.obj")
#@export var Leg:Mesh = load("res://assets/models/characters/legs/leg1.obj")

