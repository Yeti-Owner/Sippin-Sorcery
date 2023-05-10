extends Resource
class_name CharacterSheet

@export var Name := ""
@export_color_no_alpha var FavColor
@export var Dialog := ""
@export var Need := [""]
@export var Bonus := [""]
@export var Budget := 10
@export_enum("Gryffindor", "Slytherin", "Hufflepuff", "Ravenclaw") var House:String
