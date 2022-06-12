extends Control

const IMG_PIXEL_SIZE: float = 100.0

var level_cover_scene = preload("res://scenes/menu/level_selection/level_cover/LevelCover.tscn")

func _ready():
	var metas = Levels.get_metas()
	for song_name in metas.keys():
		for i in range(5):
			var meta = metas[song_name]
			var texture: StreamTexture = load(meta["cover"])
			
			var level_cover = level_cover_scene.instance()
			$Levels.add_child(level_cover)
			level_cover.level_name = song_name
			level_cover.image_size = IMG_PIXEL_SIZE
			level_cover.texture = texture
