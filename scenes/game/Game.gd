extends Node2D

export (Array, AudioStream) var countdown_sounds

var chord_orb_scene = preload("res://components/chord_orb/ChordOrb.tscn")

func _on_GameController_score_updated(new_score):
	$ScoreLabel.text = str(new_score)

func _ready():
	Global.game_paused = true
	randomize()
	$CountdownSound.stream = countdown_sounds[randi() % len(countdown_sounds)]
	$AnimationPlayer.play("intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "intro":
		Global.game_paused = false
		spawn_random()

func spawn_random():
	var spawn_position = $ChordSpawns.get_child(randi() % 4)
	var chord_orb = chord_orb_scene.instance()
	var colors = [Color.orange, Color.aqua, Color.red, Color.yellow]
	chord_orb.position = spawn_position.position
	chord_orb.color = colors[randi() % len(colors)]
	$Chords.add_child(chord_orb)
	$SpawnTimer.start((randi() % 2) + 0.5)

func _on_SpawnTimer_timeout():
	spawn_random()
