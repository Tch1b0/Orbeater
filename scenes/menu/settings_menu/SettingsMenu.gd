extends Control

signal back()

func update_ui():
	$VBoxContainer/MuteCheckBox.pressed = settings.gets("mute")
	$VBoxContainer/MasterVolumeSlider.value = settings.gets("master_volume_db")

func _on_MuteCheckBox_pressed():
	settings.sets("mute", $VBoxContainer/MuteCheckBox.pressed)
	update_ui()

func _on_BackButton_pressed():
	emit_signal("back")

func _on_MasterVolumeSlider_drag_ended(value_changed):
	if not value_changed: return
	settings.sets("master_volume_db", $VBoxContainer/MasterVolumeSlider.value)
	update_ui()

func _on_FullscreenCheckBox_pressed():
	settings.sets("fullscreen", $VBoxContainer/FullscreenCheckBox.pressed)
	update_ui()
