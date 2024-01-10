extends Resource
class_name CharacterSheet

@export_category("Character Traits")
@export var Name := ""
@export_color_no_alpha var FavColor

@export_category("Needs")
@export var Dialog := ""
@export var Need:Array[String] = [""]
@export var Bonus:Array[String] = [""]
@export var Budget := 10

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
