extends Control

var values := [Vector2(1960, 405), Vector2(1060, 405)]
var Visible:int = 0 : set = _set_visible

func _set_visible(new_vis):
	Visible = wrap(new_vis, 0, 2)
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "position", values[Visible], 0.75)
