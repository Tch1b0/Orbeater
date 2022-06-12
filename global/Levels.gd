extends Node

var metas: Dictionary setget , get_metas
var level_datas: Dictionary

func get_metas() -> Dictionary:
	if not len(metas.keys()):
		load_metas()
	return metas

func load_json(path: String) -> Dictionary:
	var file = File.new()
	file.open(path, file.READ)
	var text_content = file.get_as_text()
	file.close()
	return parse_json(text_content)

func load_metas() -> void:
	metas = load_json("res://levels/meta.json")

func load_level_data(song_name: String) -> void:
	level_datas[song_name] = load_json(
		"res://levels/level_data/{name}.json".format({"name": song_name})
	)

func get_level_data(song_name: String) -> Dictionary:
	if not level_datas.has(song_name):
		load_level_data(song_name)
	return level_datas[song_name]
