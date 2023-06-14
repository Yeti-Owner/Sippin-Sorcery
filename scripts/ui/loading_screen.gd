extends CanvasLayer

signal LoadingDone

func _ready():
	$AnimationPlayer.play("fill")

func _on_animation_player_animation_finished(_anim_name):
	self.queue_free()
	EventBus.EnablePlayer.emit(true)
	emit_signal("LoadingDone")
