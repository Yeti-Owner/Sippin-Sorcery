extends Node

# Version Shenanigans
var version_link := "https://onedrive.live.com/download?resid=5de2d6604d631d2a%217388&authkey=!ALywAfcPz_tZLuQ"
var version_path := "user://version.txt"
var http_request: HTTPRequest

func _ready():
	_download_version()

func _download_version():
	http_request = HTTPRequest.new()
	add_child(http_request)
	
	http_request.request_completed.connect(self._check_version)
	
	var error = http_request.request(version_link)
	if error != OK:
		printerr("\n---\nHTTP request Error\n---\n")

func _check_version(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		printerr("\n---\nFailed to download\n---\n")
		return
	
	if int(body.get_string_from_utf8()) > int(EventBus.GameVersion):
		OS.alert("You are not running the latest release.\nOlder versions may have bugs and will lack new content.\nFind it at yetiowner.itch.io/sippin-sorcery", "Old Version Running")
