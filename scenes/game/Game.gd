extends Node2D

export (Array, AudioStream) var countdown_sounds

var chord_orb_scene = preload("res://components/chord_orb/ChordOrb.tscn")

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
