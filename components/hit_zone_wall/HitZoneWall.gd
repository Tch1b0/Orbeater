extends Node2D
class_name HitZoneWall

signal chord_hit(chord, good_hit)
signal redundant_input()
signal chord_missed(chord)

func _ready():
	for zone in get_children():
		zone.connect("chord_hit", self, "_on_chord_hit")
		zone.connect("redundant_input", self, "_on_redundant_input")
		zone.connect("chord_missed", self, "_on_chord_missed")

func _on_chord_hit(chord, good_hit):
	emit_signal("chord_hit", chord, good_hit)

func _on_redundant_input():
	emit_signal("redundant_input")

func _on_chord_missed(chord):
	emit_signal("chord_missed", chord)
