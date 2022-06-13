extends Node

var metas: Dictionary setget , get_metas
var level_datas: Dictionary
var selected_level_name: String = "Pulse"

func get_metas() -> Dictionary:
	if not len(metas.keys()):
		load_metas()
	return metas.duplicate(true)

func save_json(path: String, data: Dictionary) -> void:
	var file = File.new()
	file.open(path, file.WRITE)
	file.store_string(to_json(data))
	file.close()

func load_json(path: String) -> Dictionary:
	var file = File.new()
	file.open(path, file.READ)
	var text_content = file.get_as_text()
	file.close()
	return parse_json(text_content)

func load_metas() -> void:
	metas = load_json("res://levels/meta.json")

func save_metas(data: Dictionary) -> void:
	metas = data
	save_json("res://levels/meta.json", data)

func load_level_data(song_name: String) -> void:
	level_datas[song_name] = load_json(
		"res://levels/level_data/{name}.json".format({"name": song_name})
	)

func level_data_comparison(a, b):
	return a[0] < b[0]

func save_level_data(song_name: String, data: Dictionary) -> void:
	level_datas[song_name] = data
	level_datas[song_name]["orbs"].sort_custom(self, "level_data_comparison")
	save_json(
		"res://levels/level_data/{name}.json".format({"name": song_name}),
		data
	)

func get_level_data(song_name: String) -> Dictionary:
	if not level_datas.has(song_name):
		load_level_data(song_name)
	return level_datas[song_name].duplicate(true)
