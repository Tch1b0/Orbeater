extends Area2D
class_name ChordOrb

export var color: Color setget set_color

# whether the curernt object is exploding
var exploding: bool = false

func set_color(new_color) -> void:
	color = new_color
	$Orb.color = color

func explode():
	exploding = true
	$AudioStreamPlayer.play()
	$CollisionPolygon2D.disabled = true
	$Orb.explode()

func _process(delta):
	if not exploding:
		move_local_x(-Global.game_speed * delta * 100)

func _on_Orb_tree_exiting():
	queue_free()
