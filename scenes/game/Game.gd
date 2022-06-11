extends Node2D

func _on_GameController_score_updated(new_score):
	$ScoreLabel.text = str(new_score)
