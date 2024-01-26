extends Node

class_name Level

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)

func _ready():
	EventBus._order()
	EventBus.connect("DialogueFinished", _level)
	EventBus.connect("NextDay", _on_clock_next_day)
	EventBus.CurrentLevel = self.scene_file_path
	EventBus._save()
	EventBus._update_presence()
	_start()
	
	# Debug to check for memory leaks
#	print("---\n")
#	print_orphan_nodes()
#	print("\n---")

func _start():
	pass

func _on_clock_next_day():
	pass

func _level():
	pass
