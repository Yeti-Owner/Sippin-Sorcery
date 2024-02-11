extends Control

@onready var Http := $HTTP
const URL:String = "https://api.jsonbin.io/v3/b"
const X_Master_Key := ""

var Data:Dictionary = {
	"Rate" : null,
	"Why" : null,
	"Bugs" : null,
	"Difficulty" : null,
	"Mixing" : null,
	"Thoughts" : null,
	"Rep" : EventBus.Reputation,
	"Day" : EventBus.DayNum,
	"Level" : EventBus.CurrentLevel
}
var Order:Array = ["Why","Bugs","Difficulty","Mixing","Thoughts"]

func _on_h_slider_value_changed(value):
	$"Container/1/MarginContainer/VBoxContainer/Label2".text = str(value)

func _on_submit_btn_pressed():
	Data["Rate"] = $"Container/1/MarginContainer/VBoxContainer/HSlider".value
	
	# Check data is all there then call _send_data()
	var Completed:bool = true
	for i in 5:
		var _node := str("Container/" + str(i + 2) + "/MarginContainer/VBoxContainer/TextEdit")
		if get_node(_node).text == "":
			get_node(_node).placeholder_text = "Please fill in"
			Completed = false
		else:
			Data[Order[i]] = get_node(_node).text
	
	if (Completed == true) and (EventBus.SentFeedback == false):
		EventBus.SentFeedback = true
		_send_data()
		$AnimationPlayer.play("complete")
		$Container/MarginContainer/SubmitBtn.disabled = true
	elif (Completed == true) and (EventBus.SentFeedback == true):
		$AnimationPlayer.play("complete")
		$Container/MarginContainer/SubmitBtn.disabled = true

func _send_data():
	# Convert data to json string:
	var query := JSON.stringify(Data)
	var headers := ["Content-Type: application/json", str("X-Master-Key: " + X_Master_Key), str("X-Bin-Name: " + EventBus.PlayerName + " feedback")]
	Http.request(URL, headers, HTTPClient.METHOD_POST, query)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "complete":
		SceneManager._change_scene("res://scenes/ui/menu.tscn")
		SceneManager._swap_hud(null)
