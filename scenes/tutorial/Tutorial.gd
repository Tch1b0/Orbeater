extends Control

signal back()

func _on_BackButton_pressed():
	emit_signal("back")
