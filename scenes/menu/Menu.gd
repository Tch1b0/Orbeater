extends Control

var next_scene: String
var is_editing: bool = false

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
	if Input.is_action_just_pressed("ui_accept") and $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == "intro":
		_on_AnimationPlayer_animation_finished("intro")
		$AnimationPlayer.play("RESET")

func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "fade_out":
		if next_scene:
			get_tree().change_scene(next_scene)
		else:
			quit()
	elif anim_name == "intro" and not LeaderboardApi.user_token:
		$RegisterBox.show()

func _on_SelectLevelButton_pressed():
	if not LeaderboardApi.user_token: return
	$MainMenu.hide()
	$LevelSelection.show()

func _on_TutorialButton_pressed():
	$MainMenu.hide()
	$Tutorial.show()

func _on_SettingsButton_pressed():
	$MainMenu.hide()
	$SettingsMenu.show()

func _on_ExitButton_pressed():
	$AnimationPlayer.play("fade_out")

func _on_back():
	is_editing = false

	$LevelSelection.hide()
	$SettingsMenu.hide()
	$Tutorial.hide()
	$MainMenu.show()

func _on_LevelSelection_switch_scene(scene_path):
	if is_editing:
		switch_scene("res://scenes/level_editor/LevelEditor.tscn")
	else:
		switch_scene(scene_path)

func _on_LevelEditorButton_pressed():
	is_editing = true
	$MainMenu.hide()
	$LevelSelection.show()

func _on_RegisterBox_finished():
	$RegisterBox.hide()

