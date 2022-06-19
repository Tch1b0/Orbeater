extends Control

signal finished()

func _on_Button_pressed():
	var content = $CenterContainer/VBoxContainer/LineEdit.text
	if not len(content): return
	LeaderboardApi.register(content)
	yield(LeaderboardApi.http, "request_completed")
	if not LeaderboardApi.user_token:
		$AcceptDialog.dialog_text = "Username already taken"
		$AcceptDialog.popup_centered()
	emit_signal("finished")
