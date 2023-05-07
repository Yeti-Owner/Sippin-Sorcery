extends RayCast3D

var current_collider

func _ready():
	EventBus.interaction.emit(EventBus.CrosshairTex, null)

func _process(_delta) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			EventBus.interaction.emit(collider.get_interaction_icon(),collider.get_interaction_text())
			current_collider = collider
		
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			EventBus.interaction.emit(collider.get_interaction_icon(), collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		EventBus.interaction.emit(EventBus.CrosshairTex, null)
