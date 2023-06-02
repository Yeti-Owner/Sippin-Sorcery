extends Resource
class_name CharacterSheet

@export_category("Character Traits")
@export var Name := ""
@export_color_no_alpha var FavColor
@export_enum("Gryffindor", "Slytherin", "Hufflepuff", "Ravenclaw") var House:String

@export_category("Needs")
@export var Dialog := ""
@export var Need := [""]
@export var Bonus := [""]
@export var Budget := 10

@export_category("Taste")
@export var Strawberry := false
@export var Banana := false
@export var Pineapple := false
@export var Blueberry := false
@export var Watermelon := false
@export var Orange := false

@export_category("Looks")
@export var Hat:Mesh = load("res://assets/models/characters/hats/Hair1.obj")
@export var Head:Mesh = load("res://assets/models/characters/heads/Head1.obj")
@export var Torso:Mesh = load("res://assets/models/characters/torsos/torso2.obj")
var Arm:Mesh = load("res://assets/models/characters/arm.obj")
@export var Pants:Mesh = load("res://assets/models/characters/pants/pants1.obj")
@export var Leg:Mesh = load("res://assets/models/characters/legs/leg1.obj")
