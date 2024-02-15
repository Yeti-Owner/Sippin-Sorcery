extends Resource
class_name CharacterSheet

@export_category("Character")
@export var Name := ""
@export_color_no_alpha var FavColor
@export var Dialog := ""
@export var Budget := 10

# Yes I know this is kind of a poor way to do it but 
# Any other system I can think of would be more annoying down the line
@export_category("Judgement")
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var resistance = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var confusion = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var health = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var flexibility = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var creativity = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var speed = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var courage = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var stamina = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var strength = "Bad"
@export_enum("Bad","Okay","Bonus","NeedOr","NeedAnd") var badVision = "Bad"
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

@export_category("Body")
@export var Hat:Mesh = null
@export var HatColor:Texture = null
@export var Head:Mesh = null

func _get_flavors() -> Array:
	var FlavorList:Array = []
	if (Strawberry): FlavorList.append("Strawberry")
	if (Banana): FlavorList.append("Banana")
	if (Pineapple): FlavorList.append("Pineapple")
	if (Blueberry): FlavorList.append("Blueberry")
	if (Watermelon): FlavorList.append("Watermelon")
	if (Orange): FlavorList.append("Orange")
	
	return FlavorList

func _get_judgement() -> Array:
	# Converts it all into a dictionary, not the prettiest solution
	# but it does it cleanly
	var Judgement := {
		"resistance" : resistance,
		"confusion" : confusion,
		"health" : health,
		"flexibility" : flexibility,
		"creativity" : creativity,
		"speed" : speed,
		"courage" : courage,
		"stamina" : stamina,
		"strength" : strength,
		"badVision" : badVision,
		"badSmell" : badSmell,
		"poison" : poison,
		"coldRes" : coldRes,
		"fireRes" : fireRes,
		"lessPain" : lessPain,
		"swimming" : swimming,
		"underwaterBreathing" : underwaterBreathing,
		"fishTalk" : fishTalk,
		"sticky" : sticky,
		"nightVision" : nightVision,
		"invisibility" : invisibility,
		"lessWeight" : lessWeight,
		"hearing" : hearing,
		"hovering" : hovering,
		"luck" : luck,
		"petrification" : petrification,
		"purity" : purity,
		"heightenedSenses" : heightenedSenses,
		"stability" : stability,
		"jumping" : jumping,
		"precision" : precision,
		"dexterity" : dexterity,
		"alertness" : alertness,
		"perception" : perception,
		"electricalRes" : electricalRes,
		"explosionRes" : explosionRes,
		"smokeImmunity" : smokeImmunity,
		"petrificationRes" : petrificationRes,
		"betterSmell" : betterSmell,
		"charisma" : charisma,
		"plantControl" : plantControl,
		"sleep" : sleep
	}
	
	# Simple match/switch case to quickly sort it into arrays (ignores Okay values)
	var Bad := []
	var Bonus := []
	var NeedOr := []
	var NeedAnd := []
	for entry in Judgement:
		match Judgement[entry]:
			"Bad": Bad.append(entry)
			"Bonus": Bonus.append(entry)
			"NeedOr": NeedOr.append(entry)
			"NeedAnd": NeedAnd.append(entry)
	
	return [Bad, Bonus, NeedOr, NeedAnd]
