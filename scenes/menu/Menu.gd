extends Control

var next_scene: String

func switch_scene(path: String) -> void:
	next_scene = path
	$AnimationPlayer.play("fade_out")

func quit() -> void:
	get_tree().quit()
	if OS.has_feature("JavaScript"):
		JavaScript.eval("window.close()")

func _ready():
	$AnimationPlayer.play("intro")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and $AnimationPlayer.is_playing():
		$AnimationPlayer.play("RESET")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		if next_scene:
			get_tree().change_scene(next_scene)
		else:
			quit()

func _on_PlayButton_pressed():
	switch_scene("res://scenes/game/Game.tscn")

func _on_SettingsButton_pressed():
	$MainMenu.hide()
	$SettingsMenu.show()

func _on_ExitButton_pressed():
	$AnimationPlayer.play("fade_out")

func _on_SettingsMenu_back():
	$SettingsMenu.hide()
	$MainMenu.show()
