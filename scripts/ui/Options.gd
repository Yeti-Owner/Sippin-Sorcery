extends Control

var values := [Vector2(1960, 405), Vector2(1060, 405)]
var Visible:int = 0 : set = _set_visible

func _set_visible(new_vis):
	Visible = wrap(new_vis, 0, 2)
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "position", values[Visible], 0.75)



# Options

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)

func _on_sens_slider_value_changed(value):
	EventBus.MouseSens = value
