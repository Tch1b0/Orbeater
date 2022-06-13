extends Control

signal switch_scene(scene_path)
signal back()

const IMG_PIXEL_SIZE: float = 100.0

var level_cover_scene = preload("res://scenes/menu/level_selection/level_cover/LevelCover.tscn")

func show():
	.show()
	for level in $Levels.get_children():
		level.update_texture()

func _ready():
	var metas = Levels.get_metas()
	for song_name in metas.keys():
		var meta = metas[song_name]
		var texture: StreamTexture = load(meta["cover"])
		
		var level_cover = level_cover_scene.instance()
		$Levels.add_child(level_cover)
		level_cover.level_name = song_name
		level_cover.image_size = IMG_PIXEL_SIZE
		level_cover.texture = texture
		level_cover.level_difficulty = meta["difficulty"]
		level_cover.connect("play_pressed", self, "_on_play_pressed")

func _on_play_pressed(level_name: String):
	Levels.selected_level_name = level_name
	emit_signal("switch_scene", "res://scenes/game/Game.tscn")

func _on_BackButton_pressed():
	emit_signal("back")
