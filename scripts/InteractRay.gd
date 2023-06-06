extends RayCast3D

var current_collider: Interactable = null

func _ready():
	EventBus.interaction.emit(EventBus.CrosshairTex, null)

func _input(event: InputEvent) -> void:
	if event is InputEventAction and event.action == "interact" and event.is_pressed() and current_collider != null:
		current_collider.interact()
		EventBus.interaction.emit(current_collider.get_interaction_icon(), current_collider.get_interaction_text())

func _process(_delta) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			EventBus.interaction.emit(collider.get_interaction_icon(), collider.get_interaction_text())
			current_collider = collider
	elif current_collider:
		current_collider = null
		EventBus.interaction.emit(EventBus.CrosshairTex, null)
