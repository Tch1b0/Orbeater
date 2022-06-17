extends Node

signal data_received(data)

const API_BASE_URL = "orbeater-leaderbord.johannespour.de"

var last_request_type: int
var http: HTTPRequest = HTTPRequest.new()

func _ready():
	http.name = "HTTPRequest"
	http.connect("request_completed", self, "_on_request_completed")
	add_child(http)

func send_get_request(route: String):
	http.request(API_BASE_URL + route, [], true, HTTPClient.METHOD_GET)
	last_request_type = HTTPClient.METHOD_GET

func post_request(route: String, data: Dictionary):
	last_request_type = HTTPClient.METHOD_POST

func _on_request_completed(result, response_code: int, headers: PoolStringArray, body):
	if response_code != 200: return

	var json = parse_json(body.get_string_from_utf8())


