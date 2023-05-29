extends Node3D

@onready var BubbleText := $Text
@onready var AnimPlayer := $AnimationPlayer


func _ready():
	self.hide()

func _talk(text:String):
	BubbleText.mesh.text = text
	AnimPlayer.play("show")
	$Timer.start()
	self.show()

func _on_timer_timeout():
	AnimPlayer.play("hide")
