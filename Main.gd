extends Node

func _ready():
	$music.play()
	$HUD/Button.hide()
	$HUD/GameOver.hide()

func new_game():
	$HUD/Score.text = str(0)
	get_tree().change_scene("res://Main.tscn")

func game_over():
	$HUD/Button.show()
	$HUD/GameOver.show()
	$music.stop()
	$gameover_music.play()

func level_won():
	$music.stop()
	$you_won_music.play()
	$HUD/GameOver.text = "LEVEL COMPLETED!!!"
	$HUD/GameOver.show()
	$HUD/Button.show()
