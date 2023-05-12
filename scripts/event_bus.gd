extends Node

signal interaction(icon, text)
signal HeldItemChanged

const CrosshairTex := "res://assets/textures/ui/crosshair.png"
const GrabTex := "res://assets/textures/ui/grab.png"

var HeldItem
var HeldEffect
