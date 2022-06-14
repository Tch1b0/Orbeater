extends Control

signal close_menu()
signal go_home()

func _ready():
	$AnimationPlayer.play("color_fade")

func _on_ResumeButton_pressed():
	emit_signal("close_menu")

func _on_SettingsButton_pressed():
	$PauseMenuContainer.hide()
	$SettingsMenu.show()

func _on_SettingsMenu_back():
	$SettingsMenu.hide()
	$PauseMenuContainer.show()

func _on_MenuButton_pressed():
	emit_signal("go_home")
