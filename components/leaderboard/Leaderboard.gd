extends Control

var entries: Array

onready var entries_box = $CenterContainer/EntriesBox

func update_ui():
	for child in entries_box.get_children():
		entries_box.remove_child(child)
	print(entries)
	var i = 0
	for entry in entries:
		print(entry)
		i += 1
		var label: Label = $LeaderboardLabel.duplicate()
		label.text = "{order}. {name}{spaces} - {score} Points".format({
			"order": str(i),
			"name": entry["user"],
			"spaces": " ".repeat(15 - len(entry["user"])),
			"score": entry["score"]
		})
		label.visible = true
		entries_box.add_child(label)

func update_all():
	LeaderboardApi.get_leaderboard_top()
	var data = yield(LeaderboardApi.http, "request_completed")
	var raw_entries = parse_json(data[3].get_string_from_utf8())
	print(raw_entries)
	if raw_entries.has("leaderboard"):
		entries = parse_json(data[3].get_string_from_utf8())["leaderboard"]
		update_ui()
