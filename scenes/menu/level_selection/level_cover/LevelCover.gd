extends Control

signal play_pressed(level_name)

export var image_size: float = 100.0
export var texture: StreamTexture setget set_texture
export var level_name: String setget set_level_name

onready var name_label = $CenterContainer/VBoxContainer/NameLabel
onready var cover_button = $CenterContainer/VBoxContainer/CoverButton

func set_level_name(new_name: String) -> void:
	level_name = new_name
	name_label.text = level_name

func set_texture(new_texture: StreamTexture) -> void:
	texture = new_texture
	cover_button.icon = texture
	yield(get_tree(), "idle_frame")
	cover_button.rect_scale = Vector2(
		image_size / texture.get_width(),
		image_size / texture.get_height()
	)
