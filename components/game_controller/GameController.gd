extends Node
class_name GameController

signal score_updated(new_score)

export var song: AudioStream
export var hit_zone_wall_path: NodePath
export var death_zone_path: NodePath

var score: int = 0 setget set_score

onready var hit_zone_wall: HitZoneWall = get_node(hit_zone_wall_path)
onready var death_zone: Area2D = get_node(death_zone_path)

func set_score(new_score):
	score = max(0, new_score)
	emit_signal("score_updated", score)

func _ready():
	hit_zone_wall.connect("chord_hit", self, "_on_chord_hit")
	hit_zone_wall.connect("redundant_input", self, "_on_redundant_input")
	hit_zone_wall.connect("chord_missed", self, "_on_chord_missed")
	death_zone.connect("area_entered", self, "_on_DeathZone_area_entered")

func _on_chord_hit(chord, good_hit):
	if chord.exploding: return
	if good_hit:
		set_score(score + 100)
	else:
		set_score(score + 50)
	chord.explode()

func _on_redundant_input(): 
	set_score(score - 25)

func _on_chord_missed(chord):
	set_score(score - 5)

func _on_DeathZone_area_entered(area):
	area.queue_free()
