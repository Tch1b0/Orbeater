extends Control

signal finished()

func _process(_delta):
	if visible and LeaderboardApi.user_token != "":
		emit_signal("finished") 

func _on_Button_pressed():
	var content = $CenterContainer/VBoxContainer/LineEdit.text
	if not len(content): return
	LeaderboardApi.register(content)
