extends Area2D

signal chord_hit(chord)
signal redundant_input()
signal chord_missed(chord)

export var input_action: String = "ui_accept"

onready var chords_inside := []

func _process(_delta):
	if Input.is_action_just_pressed(input_action):
		if not chords_inside:
			emit_signal("redundant_input")
		else:
			for chord in chords_inside:
				emit_signal("chord_hit", chord)
			chords_inside = []

func _on_HitZone_area_entered(area):
	chords_inside.append(area)

func _on_HitZone_area_exited(area):
	if area.is_queued_for_deletion():
		return
	chords_inside.erase(area)
	emit_signal("chord_missed", area)
