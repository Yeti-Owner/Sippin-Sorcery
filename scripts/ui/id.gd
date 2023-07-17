extends Control

@onready var IdPhoto := $CenterContainer/Bg/HBoxContainer/HolderPhoto/CenterContainer/PhotoBorder/Photo
@onready var IdName := $CenterContainer/Bg/HBoxContainer/HolderInfo/MarginContainer/VBoxContainer/Name/NameText
@onready var IdNum := $CenterContainer/Bg/HBoxContainer/HolderInfo/MarginContainer/VBoxContainer/Idnumber/NumLabel
@onready var IssuedDate := $CenterContainer/Bg/HBoxContainer/HolderInfo/MarginContainer/VBoxContainer/Issued/IssuedLabel
@onready var Reputation := $CenterContainer/Bg/HBoxContainer/HolderInfo/MarginContainer/VBoxContainer/Reputation/RepLabel


func _ready():
	self.hide()
	_setup()

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("id"):
		self.show()
	elif not Input.is_action_pressed("id"):
		self.hide()

func _setup():
	IdPhoto.texture = EventBus.PlayerHeadshot
	IdName.text = str(EventBus.PlayerName)
	IdNum.text = str(EventBus.IdNum)
	IssuedDate.text = EventBus.StartDate
	Reputation.text = str(EventBus.Reputation)

func _on_update_timer_timeout():
	Reputation.text = str(EventBus.Reputation)
	
	if EventBus.BossesBeaten != 0:
		for i in EventBus.BossesBeaten:
			get_node(str("CenterContainer/Bg/HBoxContainer/HolderInfo/MarginContainer/VBoxContainer/HBoxContainer/boss" + str(i + 1))).color = Color(0, 1, 0)
