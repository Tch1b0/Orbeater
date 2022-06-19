extends Control

var entries: Array

onready var entries_box = $CenterContainer/EntriesBox

func update_content(data: Array):
	entries = data

func update_ui():
	for child in entries_box.get_children():
		entries_box.remove_child(child)

	var i = 0
	for entry in entries:
		i += 1
		var label: Label = $LeaderboardLabel.duplicate()
		label.text = "{order}. {name}{spaces} - {score} Points".format({
			"order": str(i),
			"name": entry["user"],
			"spaces": " ".repeat(15 - len(entry["user"])),
			"score": entry["score"]
		})
		entries_box.add_child(label)

func update_all():
	LeaderboardApi.get_leaderboard_top()

func _ready():
	LeaderboardApi.connect("leaderboard_data_received", self, "update_content")
	update_all()

func show():
	.show()
	update_all()
