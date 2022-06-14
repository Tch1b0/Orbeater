extends Control

var player_position: float = 3.0

onready var level_name = Levels.selected_level_name
onready var level_data = Levels.get_level_data(level_name)
onready var song: AudioStream = load(level_data["audio"])

func _ready():
	$SongNameLabel.text = level_name
	$MusicPlayer.stream = song
	$VBoxContainer/SongPositionSlider.max_value = $MusicPlayer.stream.get_length()

func _process(_delta):
	for orb in level_data["orbs"]:
		var check_box = get_node("VBoxContainer/LineCheckBoxes/CheckBoxLine%d" % (orb[1] + 1))
		check_box.pressed = stepify(orb[0], .1) == stepify(player_position, .1)

	if $MusicPlayer.playing:
		player_position = $MusicPlayer.get_playback_position()
		$VBoxContainer/SongPositionSlider.value = player_position
	$VBoxContainer/SongPositionLabel.text = "%.1f" % $VBoxContainer/SongPositionSlider.value

func _on_SaveButton_pressed():
	Levels.save_level_data(level_name, level_data)

func _on_PlayToggleButton_pressed():
	if $MusicPlayer.playing:
		$MusicPlayer.stop()
		$VBoxContainer/PlayToggleButton.text = "PLAY"
	else:
		$MusicPlayer.play(player_position)
		$VBoxContainer/PlayToggleButton.text = "STOP"

func _on_SongPositionSlider_drag_ended(value_changed: bool):
	if not value_changed: return
	player_position = $VBoxContainer/SongPositionSlider.value
	if $MusicPlayer.playing:
		_on_PlayToggleButton_pressed()

func spawn_orb_at(_idx: int) -> void:
	for orb in level_data["orbs"]:
		if stepify(orb[0], .1) == stepify(player_position, .1):
			level_data["orbs"].erase(orb)
	for i in $VBoxContainer/LineCheckBoxes.get_child_count():
		var child = $VBoxContainer/LineCheckBoxes.get_child(i)
		if child.pressed:
			level_data["orbs"].append([stepify(player_position, .1) ,i])
