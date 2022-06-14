extends Node2D

export (Array, AudioStream) var countdown_sounds

var chord_orb_scene = preload("res://components/chord_orb/ChordOrb.tscn")

func toggle_pause():
	Global.game_paused = not Global.game_paused
	if Global.game_paused:
		$BlurTexture.show()
		$PauseMenu.show()
	else:
		$BlurTexture.hide()
		$PauseMenu.hide()

func _process(_delta):
	if Input.is_action_just_pressed("escape") and $AnimationPlayer.current_animation != "intro":
		toggle_pause()

func _on_GameController_score_updated(new_score):
	$ScoreLabel.text = str(new_score)

func _ready():
	Global.game_paused = true
	$GameController.level_name = Levels.selected_level_name
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
