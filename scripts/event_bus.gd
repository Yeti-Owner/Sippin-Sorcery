extends Node

signal interaction(icon, text)
signal HeldItemChanged
signal BalanceChanged
signal DialogueFinished
signal JournalToggle(toggle:bool)
signal EnablePlayer(toggle:bool)

const CrosshairTex := "res://assets/textures/ui/crosshair.png"
const GrabTex := "res://assets/textures/ui/grab.png"
const ActionTex := "res://assets/textures/ui/action.png"

var HeldItem
var HeldEffect
var Balance := 50

var Dialogue = null : set = _set_dialogue

func _set_dialogue(_node):
	Dialogue = get_path_to(_node)
