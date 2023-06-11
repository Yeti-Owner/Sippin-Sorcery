extends Control

var isPaused:bool = false

func _ready():
	self.hide()

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		isPaused = !isPaused
		_toggle()

func _toggle():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) if isPaused == false else Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().set_pause(isPaused)
	self.visible = isPaused

func _on_resume_pressed():
	isPaused = false
	_toggle()

func _on_quit_pressed():
	get_tree().quit()