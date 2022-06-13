extends Node2D
class_name GameController

signal score_updated(new_score)

export var spawn_to_target_distance: int = 770
export var level_name: String
export var hit_zone_wall_path: NodePath
export var death_zone_path: NodePath
export (Array, NodePath) var chord_spawn_paths

var chord_orb_scene = preload("res://components/chord_orb/ChordOrb.tscn")
var score: int = 0 setget set_score
var song_position: float = 0.0
var chord_spawns: Array

onready var hit_zone_wall: HitZoneWall = get_node(hit_zone_wall_path)
onready var death_zone: Area2D = get_node(death_zone_path)
onready var level_data: Dictionary = Levels.get_level_data(level_name)

func set_score(new_score):
	score = max(0, new_score)
	emit_signal("score_updated", score)

func _ready():
	for path in chord_spawn_paths:
		chord_spawns.append(get_node(path))

	$MusicPlayer.stream = load(level_data["audio"])

	hit_zone_wall.connect("chord_hit", self, "_on_chord_hit")
	hit_zone_wall.connect("redundant_input", self, "_on_redundant_input")
	hit_zone_wall.connect("chord_missed", self, "_on_chord_missed")
	death_zone.connect("area_entered", self, "_on_DeathZone_area_entered")

func _process(_delta):
	if not Global.game_paused and $MusicPlayer.playing:
		song_position = $MusicPlayer.get_playback_position()
	elif Global.game_paused and $MusicPlayer.playing:
		$MusicPlayer.stop()
	elif not Global.game_paused and not $MusicPlayer.playing:
		$MusicPlayer.play(song_position)

	var orb_velocity = (Global.game_speed*100)/1
	var orb_arrival_time = song_position + spawn_to_target_distance/orb_velocity

	if $MusicPlayer.get_playback_position() == $MusicPlayer.stream.get_length():
		end_game()
	elif level_data["orbs"] and orb_arrival_time >= level_data["orbs"][0][0]:
		print($MusicPlayer.get_playback_position())
		var spawn = chord_spawns[level_data["orbs"][0][1]]
		var orb = get_random_chord_orb()
		spawn.add_child(orb)
		level_data["orbs"].pop_front()

func end_game():
	get_tree().quit()

func get_random_chord_orb() -> ChordOrb:
	var chord_orb = chord_orb_scene.instance()
	var colors = [Color.orange, Color.aqua, Color.red, Color.yellow]
	chord_orb.color = colors[randi() % len(colors)]
	return chord_orb

func get_all_spawned_chords() -> Array:
	var chords := []
	for spawn in chord_spawns:
		chords.append_array(spawn.get_children())
	return chords

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
