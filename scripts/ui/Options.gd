extends Control

var values := [Vector2(1960, 405), Vector2(1090, 405)]
var Visible:int = 0 : set = _set_visible

func _ready():
	$Bg/GridContainer/MasterSlider.value = EventBus.MasterVolume
	$Bg/GridContainer/MusicSlider.value = EventBus.MusicVolume
	$Bg/GridContainer/SfxSlider.value = EventBus.SfxVolume
	$Bg/GridContainer/SensSlider.value = EventBus.MouseSens

func _set_visible(new_vis):
	Visible = wrap(new_vis, 0, 2)
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "position", values[Visible], 0.75)

# Options
func _on_master_slider_value_changed(value):
	EventBus.MasterVolume = value
	if value == -15:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
	AudioServer.set_bus_volume_db(0, value)

func _on_music_slider_value_changed(value):
	EventBus.MusicVolume = value
	if value == -15:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
	AudioServer.set_bus_volume_db(1, value)

func _on_sfx_slider_value_changed(value):
	EventBus.SfxVolume = value
	if value == -15:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
	AudioServer.set_bus_volume_db(2, value)

func _on_sens_slider_value_changed(value):
	EventBus.MouseSens = value
