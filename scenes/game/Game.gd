extends Node2D

export (Array, AudioStream) var countdown_sounds

var previous_score: float = 0.0

var chord_orb_scene = preload("res://components/chord_orb/ChordOrb.tscn")

func toggle_pause():
	Global.game_paused = not Global.game_paused
	if Global.game_paused:
		$HUD/BlurTexture.show()
		$HUD/PauseMenu.show()
	else:
		$HUD/BlurTexture.hide()
		$HUD/PauseMenu.hide()

func _process(_delta):
	$ProgressBar.value = $GameController.song_position
	if Input.is_action_just_pressed("escape") and $AnimationPlayer.current_animation != "intro" and not $GameController.game_ended:
		toggle_pause()

func _on_GameController_score_updated(new_score):
	$HUD/ScoreLabel.text = str(new_score)
	var diff = new_score - previous_score
	$HUD/ScoreDiffLabel.text = ("+" if diff > 0 else "") + str(diff)
	if diff > 0:
		$HUD/ScoreDiffLabel.modulate = Color.green
	else:
		$HUD/ScoreDiffLabel.modulate = Color.red
	$HUD/ScoreDiffLabel.show()
	$HUD/ScoreDiffTimer.start()
	previous_score = new_score

func _ready():
	Global.game_paused = true
	$GameController.level_name = Levels.selected_level_name
	$ProgressBar.max_value = $GameController.song_length
	randomize()
	$CountdownSound.stream = countdown_sounds[randi() % len(countdown_sounds)]
	$AnimationPlayer.play("intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "intro":
		Global.game_paused = false

func _on_PauseMenu_close_menu():
	toggle_pause()

func _on_PauseMenu_go_home():
	get_tree().change_scene("res://scenes/menu/Menu.tscn")

func _on_ScoreDiffTimer_timeout():
	$HUD/ScoreDiffLabel.hide()

func _on_GameController_game_finished(score):
	$HUD/BlurTexture.show()
	$HUD/EndingScreen.show()
	$HUD/EndingScreen/ScoreLabel.text = "Your Score: %d" % score
	$HUD/EndingScreen/Leaderboard.update_all()

func _on_MenuButton_pressed():
	_on_PauseMenu_go_home()
