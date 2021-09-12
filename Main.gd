extends Node

func _ready():
	$music.play()
	$HUD/Button.hide()
	$HUD/GameOver.hide()

func new_game():
	$HUD/Score.text = str(0)
	get_tree().reload_current_scene()
	#get_tree().change_scene("res://Main.tscn")

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
	print(get_tree().current_scene.name)
	yield(get_tree().create_timer(6.0), "timeout")
	$HUD/Button.show()
	get_node("/root/Game").level += 1
	get_tree().change_scene("res://level"+str(get_node("/root/Game").level)+".tscn")
	#get_tree().change_scene("res://level2.tscn")
