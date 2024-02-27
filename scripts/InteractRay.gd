extends RayCast3D

var current_collider: Interactable = null
var Interacted:bool = false

func _ready():
	EventBus.interaction.emit(EventBus.CrosshairTex, null)
	EventBus.DisableInteract.connect(_toggle)

func _input(event: InputEvent) -> void:
	if (event.is_action("interact")) and (current_collider != null) and (Interacted == false):
		current_collider.interact()
		# Signals are more optimized but look less clean, this is
		# Surprisingly fast to execute
		EventBus.interaction.emit(current_collider.get_interaction_icon(), current_collider.get_interaction_text())
		Interacted = true
	if (event.is_action_released("interact")):
		Interacted = false

# I Can't really think of a better way but I'm sure it exists
func _process(_delta) -> void:
	var collider = get_collider()
	
	if (is_colliding()) and (collider is Interactable):
		if current_collider != collider:
			EventBus.interaction.emit(collider.get_interaction_icon(), collider.get_interaction_text())
			current_collider = collider
	elif current_collider:
		current_collider = null
		EventBus.interaction.emit(EventBus.CrosshairTex, null)

func _toggle(value):
	self.enabled = !value
