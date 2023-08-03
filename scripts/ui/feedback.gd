extends Control

# This script needs to have 2 main functions
# 1, it needs to make sure there is data entered for every question
# 2, it needs to then send that data + additional info to pipedream
# Pipe dream will hopefully be able to send data to a google sheet and then
# I can view all the info from there.

@onready var Http := $HTTP
const URL:String = "" # Input pipedream url when I have it

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
#		_send_data()
	elif (Completed == true) and (EventBus.SentFeedback == true):
		pass # Thank them and act as if it sent but don't send

func _send_data():
	# Convert data to json string:
	var query := JSON.stringify(Data)
	# Add 'Content-Type' header:
	var headers := ["Content-Type: application/json"]
	Http.request(URL, headers, HTTPClient.METHOD_POST, query)

