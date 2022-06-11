extends Node2D
class_name HitZoneWall

signal chord_hit(chord)
signal redundant_input()
signal chord_missed(chord)

func _ready():
	for zone in get_children():
		zone.connect("chord_hit", self, "_chord_hit")
		zone.connect("redundant_input", self, "_redundant_input")
		zone.connect("chord_missed", self, "_chord_missed")


func _chord_hit(chord):
	emit_signal("chord_hit", chord)

func _redundant_input():
	emit_signal("redundant_input")

func _chord_missed(chord):
	emit_signal("chord_missed", chord)
