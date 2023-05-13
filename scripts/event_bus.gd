extends Node

signal interaction(icon, text)
signal HeldItemChanged
signal BalanceChanged

const CrosshairTex := "res://assets/textures/ui/crosshair.png"
const GrabTex := "res://assets/textures/ui/grab.png"
const ActionTex := "res://assets/textures/ui/action.png"

var HeldItem
var HeldEffect
var Balance := 50
