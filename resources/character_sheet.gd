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
