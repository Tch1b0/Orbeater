extends Settings

# Runs at launch, because it is a global script
func _enter_tree():
	# Automatically save the settings to a settings file
	# when a setting is changed
	auto_save = true

	# Automatically load settings from file on startup
	auto_load = true

	set_default("fullscreen", false)
	set_default("master_volume_db", 0.0)
	set_default("mute", false)
	adapt_settings()

func sets(setting: String, value):
	.sets(setting, value)
	adapt_settings()

func adapt_settings():
	OS.window_fullscreen = gets("fullscreen")
	AudioServer.set_bus_volume_db(0, gets("master_volume_db"))
	AudioServer.set_bus_mute(0, gets("mute"))
