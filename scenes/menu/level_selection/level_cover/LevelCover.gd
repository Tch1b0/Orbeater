extends Control

signal play_pressed(level_name)

export var image_size: float = 100.0
export var texture: StreamTexture setget set_texture
export var level_name: String setget set_level_name
export var level_difficulty: String setget set_level_difficulty

onready var name_label = $CenterContainer/VBoxContainer/NameLabel
onready var current_button = $CenterContainer/VBoxContainer/GreenCoverButton

func set_level_difficulty(new_difficulty):
	level_difficulty = new_difficulty
	var difficulty_colors = {
		"EASY": "Green",
		"NORMAL": "Yellow",
		"HARD": "Red"
	}

	current_button.hide()
	current_button = $CenterContainer/VBoxContainer.get_node(
		"{color}CoverButton".format(
			{ "color": difficulty_colors[level_difficulty] }
		)
	)

	if texture != null:
		set_texture(texture)

func set_level_name(new_name: String) -> void:
	level_name = new_name
	name_label.text = level_name

func set_texture(new_texture: StreamTexture) -> void:
	texture = new_texture
	current_button.show()
	current_button.icon = texture
	yield(get_tree(), "idle_frame")
	current_button.rect_scale = Vector2(
		image_size / texture.get_width(),
		image_size / texture.get_height()
	)

func update_texture() -> void: 
	set_texture(texture)

func _on_button_pressed() -> void:
	emit_signal("play_pressed", level_name)

