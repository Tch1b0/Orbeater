extends Node
class_name GameController

export var song: AudioStream
export var hit_zone_wall_path: NodePath
export var death_zone_path: NodePath

onready var hit_zone_wall: HitZoneWall = get_node(hit_zone_wall_path)
onready var death_zone: Area2D = get_node(death_zone_path)

func _ready():
	hit_zone_wall.connect("chord_hit", self, "_on_HitZoneWall_chord_hit")
	hit_zone_wall.connect("chord_missed", self, "_on_HitZoneWall_chord_missed")
	death_zone.connect("area_entered", self, "_on_DeathZone_area_entered")

func _on_HitZoneWall_chord_hit(chord):
	chord.explode()

func _on_HitZoneWall_chord_missed(chord):
	pass

func _on_DeathZone_area_entered(area):
	area.queue_free()
