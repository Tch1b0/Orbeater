extends Control

func _ready():
	$AnimationPlayer.play("intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/menu/Menu.tscn")
