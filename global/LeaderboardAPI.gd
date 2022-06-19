extends Node

signal leaderboard_data_received(data)

const API_BASE_URL = "https://orbeater-leaderboard.johannespour.de"

var last_request_type: int
var http: HTTPRequest = HTTPRequest.new()
var session_token: String
var user_name: String
var user_token: String

func _ready():
	settings.set_default("user_name", "")
	settings.set_default("user_token", "")
	user_token = settings.gets("user_token")
	user_name = settings.gets("user_name")

	http.name = "HTTPRequest"
	http.connect("request_completed", self, "_on_request_completed")
	add_child(http)


func register(username: String) -> void:
	settings.sets("user_name", username)
	user_name = username
	send_post_request(
		"/register",
		"username=%s" % username
	)

func start_session(current_song = Levels.selected_level_name) -> void:
	send_post_request(
		"/start",
		"song=%s" % current_song
	)

func end_session(score: int) -> void:
	send_post_request(
		"/end",
		"user-token={u_token}&session-token={s_token}&score={score}".format({
			"u_token": user_token,
			"s_token": session_token,
			"score": score
		})
	)

func get_leaderboard_top(song = Levels.selected_level_name, count = 10):
	send_get_request(
		"/leaderboard/{song}/{count}".format({
			"song": song,
			"count": count
		})
	)

func send_get_request(route: String) -> void:
	http.request(API_BASE_URL + route, [], true, HTTPClient.METHOD_GET)
	last_request_type = HTTPClient.METHOD_GET

func send_post_request(route: String, data: String) -> void:
	http.request(
		API_BASE_URL + route, 
		["Content-Type: application/x-www-form-urlencoded"], 
		true, 
		HTTPClient.METHOD_POST, 
		data
	)
	last_request_type = HTTPClient.METHOD_POST

func _on_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if response_code != 200: return
	var json = parse_json(body.get_string_from_utf8())
	if last_request_type == HTTPClient.METHOD_GET:
		emit_signal("leaderboard_data_received", json["leaderboard"])
	elif user_token == "":
		settings.sets("user_token", json["token"])
		user_token = json["token"]
	elif session_token == "":
		session_token = json["token"]
