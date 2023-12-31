extends Interactable


# Name: array( effects list, flavor list )
const BossData := {
	"Tom": [["courage"], ["Orange","Banana"]],
	"Humphrey": [["resistance","flexibility","courage","badVision","coldRes","swimming","sticky","lessWeight","sleep","petrification","purity","speed","precision","alertness","strength","petrificationRes","charisma"], ["Strawberry","Banana","Pineapple","Blueberry","Watermelon","Orange"]],
	"Sir Higgins": [["monkey"], ["Banana"]],
	"Garfield": [["sleep"], ["Lasagna"]]
}
# Use get_parent().BossId to access

var CharName:String
@onready var color := Color(randf(), randf(), randf())
var Talk:bool = false
var Used:bool = false

func get_interaction_text():
	if EventBus.HeldItem == "Juice" and Used == false:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to give juice to [color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if Used == true:
		return
	
	if EventBus.HeldItem == "Juice":
		get_parent()._result(_check_success(), _check_flavor())
		
		EventBus.HeldEffect = null
		EventBus.HeldFlavor = ""
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
		Used = true
	else:
		if Talk:
			_ask_flavors()
		else:
			_ask_problem()

func _check_success() -> bool:
	var need = BossData[get_parent().BossId][0]
	var held_effects = EventBus.HeldEffect
	
	# Check if all strings in "need" are present in "held_effects"
	var all_need_present = true
	for string in need:
		if not held_effects.has(string):
			all_need_present = false
			break
	
	return all_need_present # returns true if met requirements else false

func _check_flavor() -> bool:
	var FlavorList = BossData[get_parent().BossId][1]
	
	var success := false
	if FlavorList.has(EventBus.HeldFlavor):
		success = true
	
	return success

func _ask_flavors():
	Talk = !Talk
	get_parent().Dialogue._talk(get_parent().BossTaste)

func _ask_problem():
	Talk = !Talk
	get_parent().Dialogue._talk(get_parent().BossProblem)
	EventBus.emit_signal("BossProblem")
